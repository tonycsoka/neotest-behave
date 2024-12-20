local Path = require("plenary.path")
local utils = require("neotest.utils")

return {
	generate_id = function(position, ns)
		local paths = vim.split(position.path, Path.path.sep)
		local id = table.concat(
			utils.tbl_flatten({
				paths[#paths - 1] .. Path.path.sep .. paths[#paths],
				vim.tbl_map(function(pos)
					return pos.name
				end, ns),
				position.name,
			}),
			"::"
		)
		return id
	end,
}
