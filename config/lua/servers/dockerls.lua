vim.lsp.config("dockerls", {
	filetypes = { "dockerfile" },
})
vim.lsp.enable("dockerls")
