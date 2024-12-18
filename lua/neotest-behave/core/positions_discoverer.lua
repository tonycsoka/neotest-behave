local lib = require("neotest.lib")

PositionsDiscoverer = {}

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function PositionsDiscoverer.discover_positions(file_path)
	local query = [[
    (feature
      (name) @namespace.name
      (scenario
        (name) @test.name
      ) @test.definition
    ) @namespace.definition
  ]]

	local opts = {
		require_namespaces = true,
		position_id = function(position, parents)
			local prefix = {}
			for _, namespace in pairs(parents) do
				table.insert(prefix, namespace.name)
			end
			local name = position.name
			return table.concat(vim.iter({ position.path, prefix, name }):flatten(), "::")
		end,
	}

	local positions = lib.treesitter.parse_positions(file_path, query, opts)
	print(positions)
	return positions
end

return PositionsDiscoverer
