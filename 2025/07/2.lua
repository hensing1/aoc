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
  for _, splitter in ipairs(splitters) do
    if beams[splitter] then
      local count = beams[splitter]
      local cBefore = beams[splitter - 1] or 0
      local cAfter = beams[splitter + 1] or 0
      beams[splitter] = nil
      beams[splitter - 1] = cBefore + count
      beams[splitter + 1] = cAfter + count
    end
  end
end

local start, splitters = read_manifold()
local beams = {}
beams[start] = 1

for _, splitterLine in ipairs(splitters) do
  split(beams, splitterLine)
end

local total = 0
for _, numRealities in pairs(beams) do
  total = total + numRealities
end

print(total)
