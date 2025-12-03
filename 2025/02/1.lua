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

function RepeatNum(num)
  local res = num * 10 ^ NumDigits(num)
  return res + num
end

function FirstHalf(num)
  local digitsRemoved = math.ceil(NumDigits(num) / 2)
  return math.floor(num / 10 ^ digitsRemoved)
end


local total = 0
for _, val in ipairs(ParseIO()) do
  local half = FirstHalf(val.low)
  local curr = RepeatNum(half)
  while curr < val.low do
    half = half + 1
    curr = RepeatNum(half)
  end

  while curr <= val.high do
    total = total + curr
    half = half + 1
    curr = RepeatNum(half)
  end
end

print(total)
