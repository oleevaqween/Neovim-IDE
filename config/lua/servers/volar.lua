-- Vue's TS-aware diagnostics need a tsdk; falls back to Mason's bundled copy if a
-- project doesn't have its own typescript in node_modules.
vim.lsp.config("volar", {
	filetypes = { "vue" },
	init_options = {
		typescript = {
			tsdk = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/typescript/lib"),
		},
	},
})
vim.lsp.enable("volar")
