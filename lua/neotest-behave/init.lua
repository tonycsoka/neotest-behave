local FileChecker = require("neotest-behave.core.file_checker")
local RootFinder = require("neotest-behave.core.root_finder")
local DirFilter = require("neotest-behave.core.dir_filter")
local PositionsDiscoverer = require("neotest-behave.core.positions_discoverer")
local SpecBuilder = require("neotest-behave.core.spec_builder")
local ResultBuilder = require("neotest-behave.core.result_builder")

local Path = require("plenary.path")
local utils = require("neotest.utils")

---@class neotest.Adapter
---@field name string
NeotestBehaveAdapter = { name = "neotest-behave" }

function NeotestBehaveAdapter._generate_id(position, ns)
	local paths = vim.split(position.path, Path.path.sep)
	local id = table.concat(
		utils.tbl_flatten({
			"features" .. Path.path.sep .. paths[#paths],
			vim.tbl_map(function(pos)
				return pos.name
			end, ns),
			position.name,
		}),
		"::"
	)
	return id
end

---Find the project root directory given a current directory to work from.
---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
---@async
---@param dir string @Directory to treat as cwd
---@return string | nil @Absolute root dir of test suite
function NeotestBehaveAdapter.root(dir)
	return RootFinder.findRoot(dir)
end

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function NeotestBehaveAdapter.filter_dir(name, rel_path, root)
	return DirFilter.filter_dir(name, rel_path, root)
end

---@async
---@param file_path string
---@return boolean
function NeotestBehaveAdapter.is_test_file(file_path)
	return FileChecker.isTestFile(file_path)
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function NeotestBehaveAdapter.discover_positions(file_path)
	return PositionsDiscoverer.discover_positions(file_path)
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function NeotestBehaveAdapter.build_spec(args)
	return SpecBuilder.build_spec(args)
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function NeotestBehaveAdapter.results(spec, result, tree)
	return ResultBuilder.build_results(spec, result, tree)
end

return NeotestBehaveAdapter
