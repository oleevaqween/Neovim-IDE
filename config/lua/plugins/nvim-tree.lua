return {
   "nvim-tree/nvim-tree.lua",
   lazy = false,
   config = function()
	vim.cmd([[ hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

	local api = require("nvim-tree.api")

	-- Create several files and/or folders at once: comma-separated names,
	-- relative to the highlighted folder (or its parent, if a file is
	-- highlighted). A trailing "/" on a name creates a folder instead of a
	-- file, matching nvim-tree's own single-create convention.
	local function multi_create(node)
	   node = node or api.tree.get_node_under_cursor()
	   if not node then
	      return
	   end

	   local dir = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")

	   local input = vim.fn.input("Create files/folders (comma-separated, trailing / for folder): ")
	   if input == "" then
	      return
	   end

	   local created, failed = {}, {}

	   for name in input:gmatch("[^,]+") do
	      name = name:match("^%s*(.-)%s*$")
	      if name ~= "" then
	         local path = dir .. "/" .. name

	         if name:sub(-1) == "/" then
	            local ok = vim.fn.mkdir(path, "p")
	            table.insert(ok == 1 and created or failed, name)
	         else
	            vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
	            local file = io.open(path, "w")
	            if file then
	               file:close()
	            end
	            table.insert(file and created or failed, name)
	         end
	      end
	   end

	   api.tree.reload()

	   if #created > 0 then
	      vim.notify("Created: " .. table.concat(created, ", "), vim.log.levels.INFO)
	   end
	   if #failed > 0 then
	      vim.notify("Failed to create: " .. table.concat(failed, ", "), vim.log.levels.ERROR)
	   end
	end

	local function my_on_attach(bufnr)
	   api.config.mappings.default_on_attach(bufnr)
	   vim.keymap.set("n", "A", function()
	      multi_create(api.tree.get_node_under_cursor())
	   end, { buffer = bufnr, desc = "Create multiple files" })
	end

	require("nvim-tree").setup({
	   on_attach = my_on_attach,
	   filters = {
	      dotfiles = false, -- Show hidden files (dotfiles)
	   },
	   view = {
	      adaptive_size = true,
	   },
	})
    end,
}
