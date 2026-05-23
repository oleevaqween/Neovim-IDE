return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"nvim-neotest/nvim-nio",
		{
			"mfussenegger/nvim-dap",
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			end,
		},
		{
			"mfussenegger/nvim-dap-python",
			config = function()
				require("dap-python").setup(
					"~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
				)
			end,
		},
		{
			"leoluz/nvim-dap-go",
			config = function()
				require("dap-go").setup()
			end,
		},
	},
	config = function()
		require("dapui").setup()
	end,
}
