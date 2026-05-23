vim.lsp.config("pyright", {
	filetypes = { "python" },
	settings = {
		python = {
			disableOrganizeImports = false,
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
			},
		},
	},
})
vim.lsp.enable("pyright")
