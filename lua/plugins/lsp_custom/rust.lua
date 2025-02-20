return {
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
					rebuildOnSave = false,
					useRustcWrapper = true,
				},
				allTargets = false,
				target = "x86_64-unknown-linux-gnu",
			},
			procMacro = {
				enable = true,
			},
		},
	},
}
