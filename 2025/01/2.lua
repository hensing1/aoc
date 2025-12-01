#! /usr/bin/lua

function ParseIoLine(line)
  local num = tonumber(string.sub(line, 2))

  if not num then
    return 0
  end

  if string.sub(line, 1, 1) == "L" then
    return -num
  elseif string.sub(line, 1, 1) == "R" then
    return num
  else
    error("Invalid input: " .. line)
  end
end

local dial = 50
local solution = 0

for line in io.lines() do
  local prevdial = dial
  dial = dial + ParseIoLine(line)
  solution = solution + math.floor(math.abs(dial) / 100)
  if dial <= 0 and prevdial ~= 0 then
    solution = solution + 1
  end
  dial = dial % 100
end

print(solution)
