-- session persistence
return {
	-- persistence, keep session
	{
		"olimorris/persisted.nvim",
		cond = not vim.g.vscode,
		event = "BufReadPre",
		lazy = false,
		config = function()
			require("persisted").setup({
				autosave = true,
				autoload = false,
				should_autosave = function()
					return true
				end,
				telescope = {
					-- after delete session, reset prompl
					reset_prompt_after_deletion = true,
				},
				follow_cwd = true,
			})
			require("telescope").load_extension("persisted")
		end,
	},
}
