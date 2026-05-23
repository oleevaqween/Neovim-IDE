vim.lsp.config("ts_ls", {
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
	},
	settings = {
		typescript = {
			indentStyle = "space",
			indentSize = 2,
		},
	},
})
vim.lsp.enable("ts_ls")
