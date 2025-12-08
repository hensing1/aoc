local union_find = require("lualib.union-find")

local function parse_points()
  local points = {}
  for line in io.lines() do
    if line == "" then break end
    local x, y, z = line:match("(%d+),(%d+),(%d+)")
    table.insert(points, {x=tonumber(x), y=tonumber(y), z=tonumber(z)})
  end
  return points
end

local function euclidian(a, b)
  local dx = a.x - b.x
  local dy = a.y - b.y
  local dz = a.z - b.z
  return (dx * dx + dy * dy + dz * dz) ^ 0.5
end

local function edge_list(points)
  local edges = {}
  for i = 1, #points-1 do
    for j = i+1, #points do
      table.insert(edges, { i=i, j=j, dist=euclidian(points[i], points[j])})
    end
  end
  return edges
end

local function edge_comp(v, w)
  return v.dist < w.dist
end

local points = parse_points()
local edges = edge_list(points)
-- print("made " .. #edges .. " edges")
table.sort(edges, edge_comp)
-- print("sorted edges")

local uf = union_find:new()

for point=1,#points do
  uf:make_set(point)
end

local i = 1
local lastEdge
while uf._numSets > 1 do
  if uf:find(edges[i].i) ~= uf:find(edges[i].j) then
    uf:union(edges[i].i, edges[i].j)
    lastEdge = edges[i]
  end
  i = i + 1
end

print(points[lastEdge.i].x * points[lastEdge.j].x)
