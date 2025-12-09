local function parse_input()
  local points = {}
  for line in io.lines() do
    if line == "" then break end
    local x, y = line:match("(%d+),(%d+)")
    table.insert(points, {x=tonumber(x), y=tonumber(y)})
  end
  return points
end

local function by_x(a, b)
  return a.x < b.x
end

local function square_size(a, b)
  local dx = math.abs(a.x - b.x) + 1
  local dy = math.abs(a.y - b.y) + 1
  return dx * dy
end

local points = parse_input()
table.sort(points, by_x)

-- pareto-optimal sets
local bottom_left = {}
local bottom_right = {}
local top_right = {}
local top_left = {}

local max = math.mininteger
local min = math.maxinteger
for i=1,#points do
  if points[i].y > max then
    table.insert(bottom_left, points[i])
    max = points[i].y
  end
  if points[i].y < min then
    table.insert(top_left, points[i])
    min = points[i].y
  end
end

max = math.mininteger
min = math.maxinteger
for i=#points,1,-1 do
  if points[i].y > max then
    table.insert(bottom_right, points[i])
    max = points[i].y
  end
  if points[i].y < min then
    table.insert(top_right, points[i])
    min = points[i].y
  end
end

-- print((#points) ^ 2)
-- print(#top_left * #bottom_right + #top_right * #bottom_left)

local max_square = 0

for _, point_a in ipairs(bottom_left) do
  for _, point_b in ipairs(top_right) do
    max_square = math.max(max_square, square_size(point_a, point_b))
  end
end

for _, point_a in ipairs(bottom_right) do
  for _, point_b in ipairs(top_left) do
    max_square = math.max(max_square, square_size(point_a, point_b))
  end
end

print(max_square)
