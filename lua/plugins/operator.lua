-- operator for multicursors in vscode
-- neovim can use vim-visual-multi also
return {
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		cond = not not vim.g.vscode,
	},
	{
		"noearc/jieba.nvim",
		event = "VeryLazy",
		dependencies = { "noearc/jieba-lua" },
	},
}
