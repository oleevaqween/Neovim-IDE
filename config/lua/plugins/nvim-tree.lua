return {
   "nvim-tree/nvim-tree.lua",
   lazy = false,
   config = function()
	vim.cmd([[ hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

	require("nvim-tree").setup({
	   filters = {
	      dotfiles = false, -- Show hidden files (dotfiles)
	   },
	   view = {
	      adaptive_size = true,
	   },
	})
    end,
}
