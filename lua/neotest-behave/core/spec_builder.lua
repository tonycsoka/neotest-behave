local root_finder = require("neotest-behave.core.root_finder")

SpecBuilder = {
	---@param args neotest.RunArgs
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args)
		local tree = args.tree
		local tree_data = tree:data()
		local path = tree_data.path
		local root = root_finder.findRoot(tree_data.path)

		print(string.sub(path, #root + 2))

		print(vim.inspect(args))

		for _, node in tree:iter_nodes() do
			local node_data = node:data()
			print(vim.inspect(node_data))
			if node_data.type == "namespace" or node_data.type == "test" then
			end
		end

		return commands
	end,
}

return SpecBuilder
