function ReadGrid()
	local grid = {}
	for line in io.lines() do
		if not line or line == "" then break end

		local row = {}
		for chr in line:gmatch(".") do
			table.insert(row, chr == "@")
		end
		table.insert(grid, row)
	end
	return grid
end

function Get(grid, i, j)
  if not grid[i] then return 0 end
  return grid[i][j] and 1 or 0
end

local grid = ReadGrid()

local answer = 0
for i = 1, #grid do
	for j = 1, #grid[i] do
	  if not grid[i][j] then
	    goto continue
	  end
	  local sum =
	    Get(grid, i-1, j-1) + Get(grid, i-1, j) + Get(grid, i-1, j+1) +
	    Get(grid, i  , j-1) +                     Get(grid, i  , j+1) +
	    Get(grid, i+1, j-1) + Get(grid, i+1, j) + Get(grid, i+1, j+1)
	  if sum < 4 then
	    answer = answer + 1
	  end
	    ::continue::
	end
end

print(answer)
