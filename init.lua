-- global options (vim option) for both vs-code & neovim
require("options")

-- lazy init
local lazy_init = require("lazy_init")
lazy_init:lazy_load()

-- init plugin & conf by lazy
-- NOTE: setup("plugins") cause auto-load lua/plugins/*.lua files
require("lazy").setup("plugins", lazy_init:lazy_conf())
require("keys")

vim.api.nvim_create_augroup("numbertoggle", { clear = true })
if vim.g.vscode then
	-- extension for vscode
	vim.g.clipboard = vim.g.vscode_clipboard
	local vscode = require("vscode")
	-- smart line number in vscode
	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		group = "numbertoggle",
		callback = function()
			vscode.update_config("editor.lineNumbers", "on")
		end,
	})
	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		group = "numbertoggle",
		callback = function()
			vscode.update_config("editor.lineNumbers", "relative")
		end,
	})
else
	-- extension for neovim
	vim.o.clipboard = "unnamedplus"
	vim.o.cursorline = true
	vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })

	-- smart line number
	-- when in I mode, show abosolute line number
	-- when in N+V mode, show relative number
	vim.wo.number = true
	vim.wo.relativenumber = true
	vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
		group = "numbertoggle",
		callback = function()
			if vim.wo.number and vim.fn.mode() ~= "i" then
				vim.wo.relativenumber = true
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
		group = "numbertoggle",
		callback = function()
			if vim.wo.number then
				vim.wo.relativenumber = false
			end
		end,
	})
	-- colorscheme for neovim
	vim.cmd.colorscheme("catppuccin")
end
