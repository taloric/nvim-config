return {
	-- telescope is a file finder & quick operator to switch between files
	-- similar plugins: fzf
	{
		"nvim-telescope/telescope.nvim",
		cond = not vim.g.vscode,
		cmd = "Telescope",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
			},
			extensions = {
				persisted = {
					layout_config = { width = 0.6, height = 0.6 },
				},
			},
		},
	},
}
