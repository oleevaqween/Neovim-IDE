return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require('nvim-treesitter').install({
      'bash',
      'c',
      'cpp',
      'css',
      'dockerfile',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'rust',
      'svelte',
      'solidity',
      'typescript',
      'vue',
      'yaml',
    })

    require('nvim-treesitter-textobjects').setup({
      select = { lookahead = true },
      move   = { set_jumps = true },
    })

    local sel  = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')
    local swap = require('nvim-treesitter-textobjects.swap')

    -- select textobjects (visual + operator-pending modes)
    local selects = {
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['ab'] = '@block.outer',
      ['ib'] = '@block.inner',
    }
    for key, obj in pairs(selects) do
      vim.keymap.set({ 'x', 'o' }, key, function()
        sel.select_textobject(obj, 'textobjects')
      end)
    end

    -- move keymaps
    vim.keymap.set('n', ']f', function() move.goto_next_start('@function.outer', 'textobjects') end)
    vim.keymap.set('n', ']c', function() move.goto_next_start('@class.outer', 'textobjects') end)
    vim.keymap.set('n', ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end)
    vim.keymap.set('n', ']F', function() move.goto_next_end('@function.outer', 'textobjects') end)
    vim.keymap.set('n', ']C', function() move.goto_next_end('@class.outer', 'textobjects') end)
    vim.keymap.set('n', ']A', function() move.goto_next_end('@parameter.inner', 'textobjects') end)
    vim.keymap.set('n', '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end)
    vim.keymap.set('n', '[c', function() move.goto_previous_start('@class.outer', 'textobjects') end)
    vim.keymap.set('n', '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end)
    vim.keymap.set('n', '[F', function() move.goto_previous_end('@function.outer', 'textobjects') end)
    vim.keymap.set('n', '[C', function() move.goto_previous_end('@class.outer', 'textobjects') end)
    vim.keymap.set('n', '[A', function() move.goto_previous_end('@parameter.inner', 'textobjects') end)

    -- swap keymaps
    vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner', 'textobjects') end)
    vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner', 'textobjects') end)
  end,
}
