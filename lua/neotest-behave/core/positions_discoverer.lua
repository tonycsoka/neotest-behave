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
      ) @test.description
    ) @namespace.description

  ]]

	return lib.treesitter.parse_positions(file_path, query, { nested_tests = true })
end

return PositionsDiscoverer
