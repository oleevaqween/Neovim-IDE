return {
  "nvim-lualine/lualine.nvim",
   config = function()
     require("lualine").setup({
       options = {
         theme = "melange",
         icons_enabled = true,
	 section_separators = { left = "", right = "" },
	 component_separators = "|",
	},
	sections = {
	  lualine_c = { "filename" },
	  lualine_x = {
	    {
	      function()
	        return "●  UNSAVED"
	      end,
	      cond = function()
	        return vim.bo.modified
	      end,
	      color = { fg = "#1d2021", bg = "#e06c75", gui = "bold" },
	    },
	    "encoding",
	    "fileformat",
	    "filetype",
	  },
	},
      })
   end,
   dependencies = { "nvim-tree/nvim-web-devicons" },
}
