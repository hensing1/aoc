local dump = require("lualib.dumptable")

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
  graph["out"] = {}
  return graph
end

local function dfs(graph, node, target, memo)
  if node == target then return 1 end
  if memo[node] then
    return memo[node]
  end
  local num_paths = 0
  for _, outgoing in ipairs(graph[node]) do
    num_paths = num_paths + dfs(graph, outgoing, target, memo)
  end
  memo[node] = num_paths
  return num_paths
end

local graph = read_input()

local solution

-- one of these needs to be zero, otherwise we have a loop and infinite solutions
local dac_to_fft = dfs(graph, "dac", "fft", {})
local fft_to_dac = dfs(graph, "fft", "dac", {})

if dac_to_fft > 0 then
  local svr_to_dac = dfs(graph, "svr", "dac", {})
  local fft_to_out = dfs(graph, "fft", "out", {})
  solution = svr_to_dac * dac_to_fft * fft_to_out
else
  local svr_to_fft = dfs(graph, "svr", "fft", {})
  local dac_to_out = dfs(graph, "dac", "out", {})
  solution = svr_to_fft * fft_to_dac * dac_to_out
end

print(dump(graph))
print(solution)
