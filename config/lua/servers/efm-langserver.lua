local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")

local flake8 = require("efmls-configs.linters.flake8")
local black = require("efmls-configs.formatters.black")

local eslint_d = require("efmls-configs.linters.eslint_d")
local prettier = require("efmls-configs.formatters.prettier")

local revive = require("efmls-configs.linters.go_revive")
local gofumpt = require("efmls-configs.formatters.gofumpt")

local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")

local hadolint = require("efmls-configs.linters.hadolint")
local fixjson = require("efmls-configs.formatters.fixjson")

local fs = require("efmls-configs.fs")
local nginxfmt = {
	formatCommand = fs.executable("nginxfmt") .. " -",
	formatStdin = true,
}

vim.lsp.config("efm", {
	filetypes = {
		"lua",
		"python",
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"markdown",
		"html",
		"css",
		"dockerfile",
		"json",
		"jsonc",
		"go",
		"sh",
		"sass",
		"vue",
		"svelte",
		"scss",
		"nginx",
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
	settings = {
		languages = {
			lua = { luacheck, stylua },
			python = { flake8, black },
			typescript = { eslint_d, prettier },
			typescriptreact = { eslint_d, prettier },
			javascript = { eslint_d, prettier },
			javascriptreact = { eslint_d, prettier },
			json = { fixjson, eslint_d },
			jsonc = { fixjson, eslint_d },
			markdown = { prettier },
			html = { prettier },
			css = { prettier },
			dockerfile = { hadolint },
			go = { revive, gofumpt },
			sh = { shellcheck, shfmt },
			nginx = { nginxfmt },
		},
	},
})
vim.lsp.enable("efm")
