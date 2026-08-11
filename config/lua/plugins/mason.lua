return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"typescript-language-server",
				"pyright",
				"gopls",
				"bash-language-server",
				"dockerfile-language-server",
				"emmet-language-server",
				"json-lsp",
				"tailwindcss-language-server",
				"yaml-language-server",
				"efm",
				"rust-analyzer",
				"clangd",
				"vue-language-server",
				"sqls",

				-- Formatters & linters (used by efm-langserver)
				"stylua",
				"luacheck",
				"black",
				"flake8",
				"prettier",
				"eslint_d",
				"gofumpt",
				"revive",
				"shellcheck",
				"shfmt",
				"hadolint",
				"fixjson",
				"nginx-config-formatter",

				-- Debug adapters
				"debugpy",
				"delve",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
