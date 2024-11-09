-- use whitespace as leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- NOTE: use keys.lua instead of its
-- cause keys.lua can add 'desc' for each key
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
-- NOTE: VM stands for vim-multi-curcor, it can only set key mapping in global like the vim key settings
vim.keymap.set("n", "<C-x>", "<Plug>(VM-Find-Under)")
