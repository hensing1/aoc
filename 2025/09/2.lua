local function parse_input()
  local points = {}
  for line in io.lines() do
    if line == "" then break end
    local x, y = line:match("(%d+),(%d+)")
    table.insert(points, {x=tonumber(x), y=tonumber(y)})
  end
  return points
end

local points = parse_input()
local lastx, lasty, dir, prevdir = "", "", "", ""
local prevp = points[#points]
for i, p in ipairs(points) do
  if p.x < prevp.x then lastx = "left" end
  if p.x > prevp.x then lastx = "right" end
  if p.y < prevp.y then lasty = "up " end
  if p.y > prevp.y then lasty = "down " end
  dir = lasty .. lastx
  if dir ~= prevdir then print(i .. " " .. dir) end
  prevdir = dir
end
