#! /bin/lua

function ParseIO()
  io.lines()
  local input = tostring(io.read())
  local ranges = {}
  for low, high in string.gmatch(input, "(%d+)-(%d+)") do
    table.insert(ranges, {low=tonumber(low), high=tonumber(high)})
  end
  return ranges
end

function NumDigits(num)
  local digits = 0
  while num > 0 do
    digits = digits + 1
    num = num // 10
  end
  return digits
end

function RepeatNum(num, n)
  local res = num
  for _=1,n-1 do
    res = res * 10 ^ NumDigits(num)
    res = res + num
  end
  return res
end

function FirstNDigits(num, n)
  local digitsToRemove = NumDigits(num) - n
  return num // 10 ^ digitsToRemove
end

function DividesAny(list, num)
  for _, item in ipairs(list) do
    if item % num == 0 then
      return true
    end
  end
  return false
end


local result = 0

for _, range in ipairs(ParseIO()) do
  local checkedNumbers = {}
  local lenLow = NumDigits(range.low)
  local lenHigh = NumDigits(range.high)

  for totalLen=lenLow,lenHigh do
    local checkedBlockLens = {}

    for blockLen=totalLen // 2,1,-1 do
      if totalLen % blockLen ~= 0 or DividesAny(checkedBlockLens, blockLen) then
        goto continue
      end
      table.insert(checkedBlockLens, blockLen)

      local minBlock = 10 ^ (blockLen - 1)
      local maxBlock = RepeatNum(9, blockLen)
      if totalLen == lenLow then
        minBlock = FirstNDigits(range.low, blockLen)
      end
      if totalLen == lenHigh then
        maxBlock = FirstNDigits(range.high, blockLen)
      end

      local numRepeats = totalLen / blockLen
      for block=minBlock,maxBlock do
        local candidate = RepeatNum(block, numRepeats)
        if range.low <= candidate and candidate <= range.high and not checkedNumbers[candidate] then
          result = result + candidate
          checkedNumbers[candidate] = true
        end
      end
        ::continue::
    end
  end
end

print(result)
