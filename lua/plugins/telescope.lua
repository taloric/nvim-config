-- telescope is a file finder & quick operator to switch between files
-- similar plugins: fzf

return {
	{
		"nvim-telescope/telescope.nvim",
		cond = not vim.g.vscode,
		cmd = "Telescope",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		defaults = {
			sorting_strategy = "ascending",
		},
	},
}
