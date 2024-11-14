-- plugin spec: https://lazy.folke.io/spec

Transparent_Background = true
return {
	-- mason is an lsp/coding related manager
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		cond = not vim.g.vscode,
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
		end,
	},
}
