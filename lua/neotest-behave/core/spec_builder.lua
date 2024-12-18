local root_finder = require("neotest-behave.core.root_finder")
local async = require("neotest.async")

SpecBuilder = {
	---@param args neotest.RunArgs
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args)
		local tree = args.tree
		local tree_data = tree:data()
		local path = tree_data.path
		local root = root_finder.findRoot(tree_data.path)
		local results_path = async.fn.tempname()
		local position = args.tree:data()

		local commands = {
			"cd",
			root,
			"&&",
			"behave",
			"-f",
			"json",
			"--no-summary",
		}

		for _, node in tree:iter_nodes() do
			local node_data = node:data()
			local id_keys = vim.split(node_data.id, "::")
			if node_data.type == "file" then
				table.insert(commands, string.sub(id_keys[1], #root + 2))
			end
			if node_data.type == "namespace" or node_data.type == "test" then
				table.insert(commands, id_keys[1])
			end
			if node_data.type == "test" then
				table.insert(commands, "-n '" .. node_data.name .. "'")
			end
			break
		end

		local return_result = {
			command = table.concat(commands, " "),
			context = {
				results_path = results_path,
				file = position.path,
				root = root,
			},
		}
		return return_result
	end,
}

return SpecBuilder
