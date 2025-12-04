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
  local firstDig = ArrMax(arr, 1, #arr - 1)
  local secondDig = ArrMax(arr, firstDig.index + 1, #arr)
  return 10 * firstDig.num + secondDig.num
end

local totalJoltage = 0

for line in io.lines() do
  totalJoltage = totalJoltage + GetJoltage(line)
end

print(totalJoltage)
