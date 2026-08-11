return {
	"milanglacier/minuet-ai.nvim",
	event = "InsertEnter",
	config = function()
		require("minuet").setup({
			provider = "openai_compatible",
			provider_options = {
				openai_compatible = {
					model = "gpt-oss:120b-cloud",
					end_point = "https://ollama.com/v1/chat/completions",
					api_key = "OLLAMA_API_KEY",
					name = "Ollama Cloud",
					stream = true,
					optional = {
						max_tokens = 256,
						top_p = 0.9,
						reasoning_effort = "low",
					},
				},
			},
			virtualtext = {
				auto_trigger_ft = { "*" },
				keymap = {
					accept = "<A-A>",
					accept_line = "<A-a>",
					accept_n_lines = "<A-z>",
					prev = "<A-[>",
					next = "<A-]>",
					dismiss = "<A-e>",
				},
			},
		})
	end,
}
