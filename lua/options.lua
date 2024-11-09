vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- NOTE: use keys.lua instead of its
-- DEPRECATED
-- require("mapping")

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.fileformat = "unix"

-- highlight yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
