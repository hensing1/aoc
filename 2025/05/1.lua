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

local function ReadNums()
  local line = io.read("l")
  local nums = {}
  while line and line ~= "" do
    table.insert(nums, tonumber(line))
    line = io.read("l")
  end
  return nums
end

local ranges = ReadRanges()
local nums = ReadNums()
local freshCount = 0

for _, num in ipairs(nums) do
  for _, range in ipairs(ranges) do
    if range.low <= num and num <= range.high then
      freshCount = freshCount + 1
      break
    end
  end
end

print(freshCount)
