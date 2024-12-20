local FileChecker = require("neotest-behave.core.file_checker")
local RootFinder = require("neotest-behave.core.root_finder")
local DirFilter = require("neotest-behave.core.dir_filter")
local PositionsDiscoverer = require("neotest-behave.core.positions_discoverer")
local SpecBuilder = require("neotest-behave.core.spec_builder")
local ResultBuilder = require("neotest-behave.core.result_builder")

---@type neotest.Adapter
local NeotestBehaveAdapter = {
	name = "neotest-behave",
	root = RootFinder.findRoot,
	filter_dir = DirFilter.filter_dir,
	is_test_file = FileChecker.isTestFile,
	discover_positions = PositionsDiscoverer.discover_positions,
	build_spec = SpecBuilder.build_spec,
	results = ResultBuilder.build_results,
}

return NeotestBehaveAdapter
