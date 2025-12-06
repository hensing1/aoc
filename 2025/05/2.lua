local function ReadRanges()
  local line = io.read("l")
  local ranges = {}
  while line ~= "" do
    local s_low, s_high = line:match("(%d+)-(%d+)")
    table.insert(ranges, { low = tonumber(s_low), high = tonumber(s_high) })
    line = io.read("l")
  end
  return ranges
end

local ranges = ReadRanges()

local rangeStarts = {}
local rangeEnds = {}
for _, range in ipairs(ranges) do
  table.insert(rangeStarts, range.low)
  table.insert(rangeEnds, range.high)
end

table.sort(rangeStarts)
table.sort(rangeEnds)

local fusedRanges = {}
local r = 0  -- keeps track of nested ranges - hits zero when we leave a range

local sI = 1 -- index for rangeStarts
local eI = 1 -- index for rangeEnds

local currRangeStart = 0

while eI <= #rangeEnds do
  local oldR = r
  if sI > #rangeStarts or rangeStarts[sI] > rangeEnds[eI] then
    r = r - 1
    eI = eI + 1
  elseif rangeStarts[sI] < rangeEnds[eI] then
    r = r + 1
    sI = sI + 1
  else
    eI = eI + 1
    sI = sI + 1
  end

  if oldR == 0 and r == 1 then
    currRangeStart = rangeStarts[sI - 1]
  elseif r == 0 then
    table.insert(fusedRanges, { low = currRangeStart, high = rangeEnds[eI - 1] })
  end
end

local total = 0
for _, range in ipairs(fusedRanges) do
  total = total + range.high + 1 - range.low
end

print(total)
