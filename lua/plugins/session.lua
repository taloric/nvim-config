-- session persistence
return {
	-- persistence, keep session
	{
		"folke/persistence.nvim",
		cond = not vim.g.vscode,
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup()
		end,
	},
}
