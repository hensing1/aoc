local map
local map_kv
do
  local f = require("lualib.functional")
  map = f.map
  map_kv = f.map_kv
end

local dump = require("lualib.dumptable")

local function parse_present()
  local shape = {}
  local count = 0
  for _=1,3 do
    local line = io.read("l")
    local pres_line = {}
    for c in line:gmatch(".") do
      local is_set = c == "#"
      count = count + (is_set and 1 or 0)
      table.insert(pres_line, is_set)
    end
    table.insert(shape, pres_line)
  end
  _ = io.read("l")
  local ret = { shape=shape, size=count }
  return ret
end

local function parse_area(line)
  local size_x, size_y = line:match("(%d+)x(%d+)")
  local req1, req2, req3, req4, req5, req6 = line:match("(%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")
  local size = {x=size_x, y=size_y}
  local reqs = { req1, req2, req3, req4, req5, req6 }
  return { size=map_kv(size, tonumber), reqs=map(reqs, tonumber) }
end

local function read_input()
  local presents = {}
  local areas = {}

  local line = io.read("l")
  while not line:find("x") do
    table.insert(presents, parse_present())
    line = io.read("l")
  end

  repeat
    table.insert(areas, parse_area(line))
    line = io.read("l")
  until line == ""

  -- return {presents=presents, areas=areas}
  return presents, areas
end

local presents, areas = read_input()

local count = 0
for _, area in ipairs(areas) do
  local num_squares = area.size.x * area.size.y
  local min_space = 0
  for i, num in ipairs(area.reqs) do
    min_space = min_space + num * presents[i].size
  end
  if min_space <= num_squares then
    count = count + 1
  end
end

print(count)
