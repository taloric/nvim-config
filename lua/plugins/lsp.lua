return {
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		event = "VeryLazy",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					--	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "<S-A-f>", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			-- Set up lspconfig.
			-- local lsp_config = require("lspconfig")
			vim.lsp.config("lua_ls", require("plugins.lsp_custom.lua_ls"))
			-- vim.lsp.config.lua_ls.setup(require("plugins.lsp_custom.lua_ls"))

			-- setup golang lsp
			vim.lsp.config("gopls", require("plugins.lsp_custom.golang"))
			-- vim.lsp.config.gopls.setup(require("plugins.lsp_custom.golang"))

			-- setup rust lsp
			vim.lsp.config("rust_analyzer", require("plugins.lsp_custom.rust"))
			-- vim.lsp.config.rust_analyzer.setup(require("plugins.lsp_custom.rust"))

			-- setup python lsp
			vim.lsp.config("pyright", require("plugins.lsp_custom.python"))
			-- vim.lsp.config.pyright.setup(require("plugins.lsp_custom.python"))

			vim.lsp.config("markdown_oxide", {})
			-- vim.lsp.config.markdown_oxide.setup({})
		end,
	},
	-- use conform instead of null-ls
	{
		"stevearc/conform.nvim",
		cond = not vim.g.vscode,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				-- python = { "yapf" },
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	-- treesitter use for code syntax highlight
	{
		"nvim-treesitter/nvim-treesitter",
		cond = not vim.g.vscode,
		branch = "main",
		lazy = false, -- main 分支禁止 lazy-load
		build = ":TSUpdate",
		cmd = { "TSUpdate", "TSInstall", "TSUpdateSync" },
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- 取代旧的 ensure_installed
			local parsers = {
				"bash",
				"diff",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"go",
				"gomod",
				"query",
				"regex",
				"rust",
				"vim",
				"vimdoc",
				"yaml",
			}
			require("nvim-treesitter").install(parsers)

			-- 取代旧的 highlight.enable / indent.enable
			-- 为所有安装了 parser 的 filetype 自动启动 highlight 和 indent
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf = args.buf
					local ft = vim.bo[buf].filetype
					local lang = vim.treesitter.language.get_lang(ft)
					if lang and vim.treesitter.language.add(lang) then
						pcall(vim.treesitter.start, buf, lang)
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- 取代旧的 incremental_selection（极简自实现版）
			-- <C-space> 扩选到包含当前位置的最小 node；继续按则扩到父 node
			-- <BS> 缩回上一级
			local selection_stack = {}

			local function start_or_grow()
				local node
				if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
					-- 已经在 visual 模式，扩到 parent
					local top = selection_stack[#selection_stack]
					if top and top:parent() then
						node = top:parent()
					end
				end
				if not node then
					node = vim.treesitter.get_node()
				end
				if not node then
					return
				end
				table.insert(selection_stack, node)
				local srow, scol, erow, ecol = node:range()
				vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
				vim.cmd("normal! v")
				vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
			end

			local function shrink()
				if #selection_stack <= 1 then
					return
				end
				table.remove(selection_stack)
				local node = selection_stack[#selection_stack]
				local srow, scol, erow, ecol = node:range()
				vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
				vim.cmd("normal! v")
				vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
			end

			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "[vV\22]*:[^vV\22]*",
				callback = function()
					selection_stack = {}
				end,
			})

			vim.keymap.set({ "n", "x" }, "<C-space>", start_or_grow, { desc = "TS incremental select" })
			vim.keymap.set("x", "<BS>", shrink, { desc = "TS shrink select" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		cond = not vim.g.vscode,
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				move = {
					set_jumps = true,
				},
			})

			local move = require("nvim-treesitter-textobjects.move")

			-- goto_next_start
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				move.goto_next_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]a", function()
				move.goto_next_start("@parameter.inner", "textobjects")
			end)

			-- goto_next_end
			vim.keymap.set({ "n", "x", "o" }, "]F", function()
				move.goto_next_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]C", function()
				move.goto_next_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]A", function()
				move.goto_next_end("@parameter.inner", "textobjects")
			end)

			-- goto_previous_start
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start("@parameter.inner", "textobjects")
			end)

			-- goto_previous_end
			vim.keymap.set({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[C", function()
				move.goto_previous_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[A", function()
				move.goto_previous_end("@parameter.inner", "textobjects")
			end)
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
		cond = not vim.g.vscode and vim.loop.os_uname().sysname ~= "Windows_NT",
		ft = { "go", "gomod", "gosum" },
		-- build = ":GoInstallBinaries",
		opts = {
			-- By default, we've turned off these options to prevent clashes with our gopls config
			icons = false,
			diagnostic = false,
			lsp_cfg = false,
			lsp_gofumpt = false,
			lsp_keymaps = false,
			lsp_codelens = false,
			lsp_document_formatting = false,
			lsp_inlay_hints = { enable = false },
			-- DAP-related settings are also turned off here for the same reason
			dap_debug = false,
			dap_debug_keymap = false,
			textobjects = false,
			-- Miscellaneous options to seamlessly integrate with other plugins
			trouble = true,
			luasnip = false,
			run_in_floaterm = false,
		},
	},
	-- {
	-- 	"Exafunction/windsurf.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"monkoose/neocodeium",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local neocodeium = require("neocodeium")
	-- 		neocodeium.setup()
	-- 		vim.keymap.set("i", "<A-f>", neocodeium.accept)
	-- 	end,
	-- },
}
