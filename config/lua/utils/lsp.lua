local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(event)
      local bufnr = event.buf
      local keymap = vim.keymap.set
      local opts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
      }

      -- native neovim keymaps
      keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      keymap("n", "<leader>gS", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
      keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      keymap("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float({ scope = 'line' })<CR>", opts)
      keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      keymap("n", "<leader>pd", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      keymap("n", "<leader>nd", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
      keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

      -- fzf-lua keymaps
      keymap("n", "<leader>gd", "<cmd>FzfLua lsp_finder<CR>", opts)
      keymap("n", "<leader>gr", "<cmd>FzfLua lsp_references<CR>", opts)
      keymap("n", "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)
      keymap("n", "<leader>ds", "<cmd>FzfLua lsp_document_symbols<CR>", opts)
      keymap("n", "<leader>ws", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts)
      keymap("n", "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", opts)
    end,
  })
end

return M
