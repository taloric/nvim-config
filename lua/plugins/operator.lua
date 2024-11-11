-- operator for multicursors in vscode
-- neovim can use vim-visual-multi also
return {
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		cond = not not vim.g.vscode,
	},
	-- no cond, allow to all platform
	{
		"noearc/jieba.nvim",
		event = "VeryLazy",
		dependencies = { "noearc/jieba-lua" },
	},
	-- yank between ssh session & local clipboard
	{
		"ibhagwan/smartyank.nvim",
		lazy = true,
		event = "BufReadPost",
		cond = vim.loop.os_uname().sysname ~= "Windows_NT",
		opts = {
			highlight = {
				enabled = false, -- highlight yanked text
				higroup = "IncSearch", -- highlight group of yanked text
				timeout = 2000, -- timeout for clearing the highlight
			},
			clipboard = {
				enabled = true,
			},
			tmux = {
				enabled = true,
				-- remove `-w` to disable copy to host client's clipboard
				cmd = { "tmux", "set-buffer", "-w" },
			},
			osc52 = {
				enabled = true,
				escseq = "tmux", -- use tmux escape sequence, only enable if you're using remote tmux and have issues (see #4)
				ssh_only = true, -- false to OSC52 yank also in local sessions
				silent = false, -- true to disable the "n chars copied" echo
				echo_hl = "Directory", -- highlight group of the OSC52 echo message
			},
		},
	},
}
