local lib = require("neotest.lib")
local Path = require("plenary.path")

ResultBuilder = {}

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function ResultBuilder.build_results(spec, result, tree)
	local results = {}
	local run_res = {}

	local success, lines = pcall(lib.files.read_lines, result.output)
	for _, line in ipairs(lines) do
		if line == "[" or line == "]" or line == "" then
			goto continue
		end
		line = string.gsub(line, "^(.-),?$", "%1")
		local bdd_json = vim.json.decode(line)

		local file = vim.split(bdd_json.location, ":")[1]
		local feature = bdd_json.name
		for _, element in ipairs(bdd_json.elements) do
			if element.type == "scenario" then
				local name = element.name
				run_res[file .. "::" .. feature .. "::" .. name] = element.status
			end
		end
		::continue::
	end

	for _, node in tree:iter_nodes() do
		local node_data = node:data()
		if run_res[node_data.id] ~= nil then
			results[node_data.id] = {
				status = run_res[node_data.id],
			}
		end
	end

	return results
end

return ResultBuilder
