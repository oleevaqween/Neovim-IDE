vim.lsp.config("emmet_ls", {
	filetypes = {
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"markdown",
		"scss",
		"sass",
		"svelte",
		"vue",
	},
})
vim.lsp.enable("emmet_ls")
