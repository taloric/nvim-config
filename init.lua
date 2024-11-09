-- global options (vim option)
require("options")

if vim.g.vscode then
	-- extension for vscode
	vim.g.clipboard = vim.g.vscode_clipboard
else
	-- neovim
	vim.o.clipboard = "unnamedplus"
	vim.wo.relativenumber = true

	-- lazy init
	local lazy_init = require("lazy_init")
	lazy_init:lazy_load()

	-- init plugin & conf by lazy
	-- NOTE: setup("plugins") cause auto-load lua/plugins/*.lua files
	require("lazy").setup("plugins", lazy_init:lazy_conf())
	vim.cmd.colorscheme("tokyonight-moon")
end
