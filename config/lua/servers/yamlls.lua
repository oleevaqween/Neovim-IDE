vim.lsp.config("yamlls", {
	filetypes = { "yaml", "yml" },
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/composer.json"] = "composer.json",
				["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
			},
			validate = true,
			format = {
				enable = true,
			},
		},
	},
})
vim.lsp.enable("yamlls")
