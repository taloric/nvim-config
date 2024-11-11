vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- NOTE: use keys.lua instead of its
-- DEPRECATED
-- require("mapping")

local o = vim.o
o.ignorecase = true
o.smartcase = true
o.fileformat = "unix"

o.laststatus = 3 -- global statusline
o.showmode = false

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

vim.opt.fillchars = { eob = " " }

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.undofile = true

-- highlight yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.api.nvim_create_user_command("MasonRestore", function()
	vim.cmd("MasonInstall lua-language-server stylua")
	if not is_windows then
		vim.cmd("MasonInstall gopls pyright gofumpt goimports")
	end
end, {})
