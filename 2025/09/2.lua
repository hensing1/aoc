local function parse_input()
  local points = {}
  for line in io.lines() do
    if line == "" then break end
    local x, y = line:match("(%d+),(%d+)")
    table.insert(points, {x=tonumber(x), y=tonumber(y)})
  end
  return points
end

local function rect_size(a, b)
  local dx = math.abs(a.x - b.x) + 1
  local dy = math.abs(a.y - b.y) + 1
  return dx * dy
end

local function is_inside_rect(point, rec1, rec2)
	local in_x = (rec1.x < point.x and point.x < rec2.x) or
							 (rec2.x < point.x and point.x < rec1.x)
	local in_y = (rec1.y < point.y and point.y < rec2.y) or
							 (rec2.y < point.y and point.y < rec1.y)
	return in_x and in_y
end

local points = parse_input()

local dickhead_point_1 = points[249]
local dickhead_point_2 = points[250]

local max = 0
for i = 1, 248 do
	local size = rect_size(dickhead_point_1, points[i])
	if size <= max then goto continue end
	for j=1, 248 do
		if is_inside_rect(points[j], dickhead_point_1, points[i]) then goto continue end
	end
	max = size
    ::continue::
end
for i = 251, #points do
	local size = rect_size(dickhead_point_2, points[i])
	if size <= max then goto continue end
	for j=251, #points do
		if is_inside_rect(points[j], dickhead_point_2, points[i]) then goto continue end
	end
	max = size
    ::continue::
end

print(max)
