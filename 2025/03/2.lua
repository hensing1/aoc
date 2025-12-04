function ToNumArray(line)
  local arr = {}
  for char in line:gmatch(".") do
    table.insert(arr, tonumber(char))
  end
  return arr
end

function ArrMax(arr, startI, endI)
  local max = -1
  local maxI = -1
  for i = startI, endI do
    if arr[i] > max then
      max = arr[i]
      maxI = i
    end
  end
  return { num = max, index = maxI }
end

function GetJoltage(line)
  if not line or line == "" then
    return 0
  end

  local arr = ToNumArray(line)
  local joltage = 0
  local minIndex = 1
  for d = 11, 0, -1 do
    local newDig = ArrMax(arr, minIndex, #arr - d)
    minIndex = newDig.index + 1
    joltage = joltage * 10 + newDig.num
  end
  return joltage
end

local totalJoltage = 0

for line in io.lines() do
  totalJoltage = totalJoltage + GetJoltage(line)
end

print(totalJoltage)
