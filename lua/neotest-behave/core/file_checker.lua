FileChecker = {}

---@async
---@param file_path string
---@return boolean
function FileChecker.isTestFile(file_path)
	-- test files end with .feature
	return file_path:match(".feature$")
end

return FileChecker
