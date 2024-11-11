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
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					--	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					-- shift + alt + f not working, hang it
					-- vim.keymap.set("n", "<S-M-f>", function()
					-- 	vim.lsp.buf.format({ async = true })
					-- end, opts)
				end,
			})

			-- Set up lspconfig.
			require("lspconfig").lua_ls.setup(require("plugins.lsp_custom.lua_ls"))

			-- setup golang lsp
			require("lspconfig").gopls.setup(require("plugins.lsp_custom.golang"))
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
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = "VeryLazy",
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		-- NOTE: c-space conflict with IME switch, <bs> is useless (why not directly x?)
		-- keys = {
		-- 	{ "<c-space>", desc = "Increment Selection" },
		-- 	{ "<bs>", desc = "Decrement Selection", mode = "x" },
		-- },
		opts_extend = { "ensure_installed" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				-- 20241108: NOTE: remove unused language
				"bash",
				-- "c",
				"diff",
				-- "html",
				-- "javascript",
				-- "jsdoc",
				"json",
				-- "jsonc",
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
				-- "toml",
				-- "tsx",
				-- "typescript",
				"vim",
				"vimdoc",
				-- "xml",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
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
}
