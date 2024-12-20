local lib = require("neotest.lib")

RootFinder = {}
---Find the project root directory given a current directory to work from.
---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
---@async
---@param dir string @Directory to treat as cwd
---@return string | nil @Absolute root dir of test suite
function RootFinder.findRoot(dir)
	return lib.files.match_root_pattern(
		".git",
		"pyproject.toml",
		"setup.cfg",
		"mypy.ini",
		"pytest.ini",
		"setup.py",
		"features/",
		"*.features/"
	)(dir)
end

return RootFinder
