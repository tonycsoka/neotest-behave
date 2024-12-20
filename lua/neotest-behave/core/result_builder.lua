local lib = require("neotest.lib")
local Path = require("plenary.path")

ResultBuilder = {}

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function ResultBuilder.build_results(spec, result, tree)
	-- local results = {}
	local run_res = {}

	local success, lines = pcall(lib.files.read_lines, result.output)
	for _, line in ipairs(lines) do
		line = string.gsub(line, "^(.-),?$", "%1")
		local ok, bdd_json = pcall(vim.json.decode, line, { luanil = { object = true } })
		if not ok then
			goto continue
		end

		local file = vim.split(bdd_json.location, ":")[1]
		local feature = bdd_json.name
		for _, element in ipairs(bdd_json.elements) do
			if element.type == "scenario" then
				local name = element.name
				local element_name = file .. "::" .. feature .. "::" .. name
				run_res[element_name] = {
					status = element.status,
				}
				if element.status == "failed" then
					for _, step in ipairs(element.steps) do
						if step.result ~= nil and step.result.status == "failed" then
							run_res[element_name].short = step.location
						end
					end
				end
			end
		end
		::continue::
	end

	return run_res
end

return ResultBuilder
