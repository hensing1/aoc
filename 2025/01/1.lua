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
  dial = dial + ParseIoLine(tostring(line))
  if dial % 100 == 0 then
    solution = solution + 1
  end
end

print(solution)
