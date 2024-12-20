local root_finder = require("neotest-behave.core.root_finder")
local async = require("neotest.async")

SpecBuilder = {
	---@param args neotest.RunArgs
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args)
		local results_path = async.fn.tempname()
		local position = args.tree:data()
		local root = root_finder.findRoot(position.path)

		local commands = {}

		local command = {
			"cd",
			root,
			"&&",
			"behave",
			"-f",
			"json",
			"--no-summary",
		}

		local node_data = position
		local id_keys = vim.split(node_data.id, "::")
		if node_data.type == "dir" then
			return
		end
		if node_data.type == "file" then
			table.insert(command, string.sub(id_keys[1], #root + 2))
		end
		if node_data.type == "namespace" or node_data.type == "test" then
			table.insert(command, id_keys[1])
		end
		if node_data.type == "test" then
			table.insert(command, "-n '" .. node_data.name .. "'")
		end

		table.insert(commands, {
			command = table.concat(command, " "),
			context = {
				results_path = results_path,
				file = position.path,
				root = root,
			},
		})
		return commands
	end,
}

return SpecBuilder
