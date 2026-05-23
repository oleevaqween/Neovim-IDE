return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "/mnt/c/Users/PRAISE OKONKWO/Documents/Notes",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    ui = {
      enable = false, -- render-markdown.nvim handles this
    },
  },
  keys = {
    { "<leader>on", "<Cmd>ObsidianNew<CR>",       desc = "New note" },
    { "<leader>os", "<Cmd>ObsidianSearch<CR>",    desc = "Search notes" },
    { "<leader>of", "<Cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
    { "<leader>ob", "<Cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
    { "<leader>od", "<Cmd>ObsidianToday<CR>",     desc = "Daily note" },
  },
}
