-- global options (vim option) for both vs-code & neovim
require("options")

-- lazy init
local lazy_init = require("lazy_init")
lazy_init:lazy_load()

-- init plugin & conf by lazy
-- NOTE: setup("plugins") cause auto-load lua/plugins/*.lua files
require("lazy").setup("plugins", lazy_init:lazy_conf())
require("keys")

if vim.g.vscode then
	-- extension for vscode
	vim.g.clipboard = vim.g.vscode_clipboard
else
	-- extension for neovim
	vim.o.clipboard = "unnamedplus"
	-- smart line number
	-- when in I mode, show abosolute line number
	-- when in N+V mode, show relative number
	vim.wo.number = true
	vim.wo.relativenumber = true
	vim.api.nvim_create_augroup("numbertoggle", { clear = true })
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
	vim.cmd.colorscheme("tokyonight-moon")
end
