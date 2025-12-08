local function read_manifold()
  local start, _ = io.read("l"):find("S", 1)
  local splitters = {}
  for line in io.lines() do
    local pos = 1
    local splittersLine
    while true do
      local i, _ = line:find("^", pos, true)
      if i == nil then break
      elseif splittersLine == nil then splittersLine = {} end
      pos = i + 1
      table.insert(splittersLine, i)
    end
    if splittersLine ~= nil then
      table.insert(splitters, splittersLine)
    end
  end
  return start, splitters
end

local function split(beams, splitters)
  local count = 0
  for _, splitter in ipairs(splitters) do
    if beams[splitter] then
      beams[splitter] = false
      beams[splitter - 1] = true
      beams[splitter + 1] = true
      count = count + 1
    end
  end
  return count
end

local start, splitters = read_manifold()
local beams = {}
beams[start] = true

local splits = 0
for _, splitterLine in ipairs(splitters) do
  splits = splits + split(beams, splitterLine)
end

print(splits)
