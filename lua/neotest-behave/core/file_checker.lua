FileChecker = {}

---@async
---@param file_path string
---@return boolean
function FileChecker.isTestFile(file_path)
	-- test files end with .feature
	return vim.endswith(file_path, ".feature")
end

return FileChecker
