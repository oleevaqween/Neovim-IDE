vim.lsp.config("yamlls", {
	filetypes = { "yaml", "yml" },
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/composer.json"] = "composer.json",
				["https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json"] = {
					"docker-compose*.yml",
					"docker-compose*.yaml",
					"compose*.yml",
					"compose*.yaml",
				},
			},
			validate = true,
			format = {
				enable = true,
			},
		},
	},
})
vim.lsp.enable("yamlls")
