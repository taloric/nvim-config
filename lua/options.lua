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

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.api.nvim_create_user_command("MasonRestore", function()
	vim.cmd("MasonInstall lua-language-server stylua")
	if not is_windows then
		vim.cmd("MasonInstall gopls pyright gofumpt goimports")
	end
end, {})
