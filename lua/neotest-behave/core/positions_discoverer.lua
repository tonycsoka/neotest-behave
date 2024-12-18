local lib = require("neotest.lib")
local Path = require("plenary.path")

PositionsDiscoverer = {}

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function PositionsDiscoverer.discover_positions(file_path)
	local query = [[
    (feature
      (name) @namespace.name
    ) @namespace.definition

    (scenario
      (name) @test.name
    ) @test.definition

  ]]

	local opts = {
		-- nested_namespaces = true,
		-- require_namespaces = false,
		-- nested_tests = true,
		position_id = "require('neotest-behave')._generate_id",
	}

	local positions = lib.treesitter.parse_positions(file_path, query, opts)
	return positions
end

return PositionsDiscoverer
