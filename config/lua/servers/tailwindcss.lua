vim.lsp.config("tailwindcss", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	capabilities = {
		textDocument = {
			colorProvider = { dynamicRegistration = true },
		},
	},
})
vim.lsp.enable("tailwindcss")
