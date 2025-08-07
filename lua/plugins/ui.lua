-- ui, including theme & scheme & tree

-- set transparent backgroupd
local transparent_background = Transparent_Background
return {
	-- theme and colorscheme
	{
		"catppuccin/nvim",
		cond = not vim.g.vscode,
		lazy = true,
		config = function()
			require("catppuccin").setup({
				transparent_background = transparent_background,
				term_colors = true,
				styles = {
					comments = { "italic" },
					functions = { "bold" },
					keywords = { "italic" },
					operators = { "bold" },
					conditionals = { "bold" },
					loops = { "bold" },
					booleans = { "bold", "italic" },
					numbers = {},
					types = {},
					strings = {},
					variables = {},
					properties = {},
				},
				-- enabled all plugins I used (and disabled not used)
				integrations = {
					treesitter = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					aerial = false,
					alpha = false,
					barbar = false,
					beacon = false,
					cmp = true,
					coc_nvim = false,
					dap = false,
					dap_ui = false,
					dashboard = false,
					dropbar = { enabled = false, color_mode = false },
					fern = false,
					fidget = false,
					flash = false,
					gitgutter = false,
					gitsigns = true,
					harpoon = false,
					headlines = false,
					hop = false,
					illuminate = false,
					indent_blankline = { enabled = true, colored_indent_levels = false },
					leap = false,
					lightspeed = false,
					lsp_saga = false,
					lsp_trouble = false,
					markdown = true,
					mason = true,
					mini = true,
					navic = { enabled = false },
					neogit = false,
					neotest = false,
					neotree = { enabled = true, show_root = true, transparent_panel = transparent_background },
					noice = false,
					notify = false,
					nvimtree = false,
					overseer = false,
					pounce = false,
					rainbow_delimiters = true,
					sandwich = false,
					semantic_tokens = true,
					symbols_outline = false,
					telekasten = false,
					telescope = { enabled = true, style = "nvchad" },
					treesitter_context = true,
					ts_rainbow = false,
					vim_sneak = false,
					vimwiki = false,
					which_key = true,
				},
				highlight_overrides = {
					---@param cp palette
					all = function(cp)
						return {
							-- For base configs
							NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
							FloatBorder = {
								fg = transparent_background and cp.blue or cp.mantle,
								bg = transparent_background and cp.none or cp.mantle,
							},
							CursorLineNr = { fg = cp.green },

							-- For native lsp configs
							DiagnosticVirtualTextError = { bg = cp.none },
							DiagnosticVirtualTextWarn = { bg = cp.none },
							DiagnosticVirtualTextInfo = { bg = cp.none },
							DiagnosticVirtualTextHint = { bg = cp.none },
							LspInfoBorder = { link = "FloatBorder" },

							-- For mason.nvim
							MasonNormal = { link = "NormalFloat" },

							-- For indent-blankline
							IblIndent = { fg = cp.surface0 },
							IblScope = { fg = cp.surface2, style = { "bold" } },

							-- For nvim-cmp and wilder.nvim
							Pmenu = { fg = cp.overlay2, bg = transparent_background and cp.none or cp.base },
							PmenuBorder = { fg = cp.surface1, bg = transparent_background and cp.none or cp.base },
							PmenuSel = { bg = cp.green, fg = cp.base },
							CmpItemAbbr = { fg = cp.overlay2 },
							CmpItemAbbrMatch = { fg = cp.blue, style = { "bold" } },
							CmpDoc = { link = "NormalFloat" },
							CmpDocBorder = {
								fg = transparent_background and cp.surface1 or cp.mantle,
								bg = transparent_background and cp.none or cp.mantle,
							},

							-- For telescope.nvim
							TelescopeMatching = { fg = cp.lavender },
							TelescopeResultsDiffAdd = { fg = cp.green },
							TelescopeResultsDiffChange = { fg = cp.yellow },
							TelescopeResultsDiffDelete = { fg = cp.red },
						}
					end,
				},
			})
		end,
	},
	-- left tree in ui
	-- COPYED from: https://www.lazyvim.org/plugins/editor
	-- but delete keys and moved to mappings.lua
	{
		"nvim-neo-tree/neo-tree.nvim",
		cond = not vim.g.vscode,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		cmd = "Neotree",
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
				},
				group_empty_dirs = true,
				scan_mode = "deep",
			},
			window = {
				-- defaut width: 40
				width = 30,
				position = "left",
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					["O"] = {
						function(state)
							require("lazy.util").open(state.tree:get_node().path, { system = true })
						end,
						desc = "Open with System Application",
					},
					["P"] = { "toggle_preview", config = { use_float = false } },
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
	},
	-- buffer line use for tab title
	-- in vim, open a new file is in 'buffer' & we called it window
	-- noticed: window is different from 'tab', which means :tabnew & :sp/:vsp is not the same things
	{
		"akinsho/bufferline.nvim",
		cond = not vim.g.vscode,
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = {
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = true,
	},
	-- indent
	{
		"lukas-reineke/indent-blankline.nvim",
		cond = not vim.g.vscode,
		lazy = true,
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			scope = { char = "┃" },
		},
	},
	-- for vim status line display
	{
		"echasnovski/mini.statusline",
		cond = not vim.g.vscode,
		init = function()
			require("mini.statusline").section_location = function()
				-- percentage/total/buffern
				return "%p%%|%L|b%n"
			end
		end,
		opts = {
			set_vim_settings = false,
		},
	},
	-- display code scope
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = true,
		cond = not vim.g.vscode,
		opts = {
			enable = true,
			max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			zindex = 30,
		},
	},
}
