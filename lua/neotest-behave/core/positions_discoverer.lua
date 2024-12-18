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

    (feature
      (name) @namespace.name
    ) @namespace.definition

    (scenario
      (name) @test.name
    ) @test.definition

  ]]

	local opts = {
		nested_namespaces = false,
	}

	local positions = lib.treesitter.parse_positions(file_path, query, opts)
	return positions
end

return PositionsDiscoverer
