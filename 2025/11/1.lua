-- local dump = require("lualib.dumptable")

local function read_input()
  local graph = {}
  for line in io.lines() do
    if line == "" then break end
    local from = line:match("^%a+")
    -- print(from)
    local to = {}
    local ind = 6
    local target = line:match("%a+", ind)
    while target do
      table.insert(to, target)
      ind = ind + 4
      target = line:match("%a+", ind)
    end
    graph[from] = to
  end
  return graph
end

local function dfs(graph, node)
  if node == "out" then return 1 end
  local num_paths = 0
  for _, outgoing in ipairs(graph[node]) do
    num_paths = num_paths + dfs(graph, outgoing)
  end
  return num_paths
end

local graph = read_input()
print(dfs(graph, "you"))
