vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- NOTE: use keys.lua instead of its
-- DEPRECATED
-- require("mapping")

local o = vim.o
o.ignorecase = true
o.smartcase = true
o.fileformats = "unix,mac,dos"

o.laststatus = 3 -- global statusline
o.showmode = false

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.shiftround = true
o.smartindent = true
o.smarttab = true
o.tabstop = 4

vim.opt.fillchars = { eob = " " }
vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 99

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
-- MasonRestore for quick restore lsp
vim.api.nvim_create_user_command("MasonRestore", function()
	vim.cmd("MasonInstall lua-language-server stylua")
	if not is_windows then
		vim.cmd("MasonInstall gopls gofumpt goimports")
	end
end, {})
