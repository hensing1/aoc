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

function Get(board, i, j)
  if not board[i] then return 0 end
  return board[i][j] and 1 or 0
end

function Deepcopy(grid)
  local copy = {}
  for i = 1, #grid do
    local row = {}
    for j = 1, #grid[i] do
      table.insert(row, grid[i][j])
    end
    table.insert(copy, row)
  end
  return copy
end

function RemoveRolls(grid)
  local removed = 0
  local copy = Deepcopy(grid)
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
	      removed = removed + 1
	      copy[i][j] = false
	    end
	      ::continue::
	  end
  end
  return { num=removed, grid=copy }
end

local grid = ReadGrid()
local answer = 0

repeat
  local removed = RemoveRolls(grid)
  answer = answer + removed.num
  grid = removed.grid
  print(removed.num)
  io.input()
until removed.num == 0

print(answer)
