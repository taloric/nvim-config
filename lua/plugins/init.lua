-- plugin spec: https://lazy.folke.io/spec

-- fzf
-- multicursor for vscode
return {
	-- mason is an lsp/coding related manager
	{
		event = "VeryLazy",
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
		end,
	},
}
