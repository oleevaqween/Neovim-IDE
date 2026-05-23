return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  opts = {
    heading = {
      enabled = true,
      sign = false,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      border = true,
      width = { "full", "full", "block", "block", "block", "block" },
      left_margin = { 0, 0, 0, 0.5, 1, 1.5 },
    },
    code = {
      enabled = true,
      style = "full",
      border = "thin",
    },
    bullet = { enabled = true },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked   = { icon = "󰱒 " },
    },
    table = { enabled = true },
    link  = { enabled = true },
  },
  keys = {
    { "<leader>mr", "<Cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
  },
}
