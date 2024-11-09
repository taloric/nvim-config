-- plugin spec: https://lazy.folke.io/spec

return {
	-- mason is an lsp/coding related manager
	{
		event = "VeryLazy",
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
			-- require("mason-lspconfig").setup()
		end,
	},
}
