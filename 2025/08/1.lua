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

local function argmax(t)
  local iMax = -1
  local max = math.mininteger
  for i, elem in pairs(t) do
    if elem > max then
      max = elem
      iMax = i
    end
  end
  return iMax
end


local points = parse_points()
local edges = edge_list(points)
print("made " .. #edges .. " edges")
table.sort(edges, edge_comp)
print("sorted edges")

local uf = union_find:new()

for point=1,#points do
  uf:make_set(point)
end
print("made the sets")

-- print(uf._numSets)
for i = 1, 1000 do
  if uf:find(edges[i].i) ~= uf:find(edges[i].j) then
    uf:union(edges[i].i, edges[i].j)
  end
end
print("made the unions")

local setSizes = {}
for point=1,#points do
  setSizes[uf:find(point)] = #uf[point]
end

local maxima = {}
for _=1,3 do
  local iMax = argmax(setSizes)
  table.insert(maxima, setSizes[iMax])
  setSizes[iMax] = 0
end

print(maxima[1] * maxima[2] * maxima[3])
