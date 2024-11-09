-- use whitespace as leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- NOTE: leader should be loaded before "mapping"
require("mapping")

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.fileformat = "unix"

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
