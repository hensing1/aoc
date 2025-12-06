local function get_num(lines, col)
  local num = 0
  for row=1,#lines - 1 do
    local dig = lines[row]:sub(col, col)
    if dig ~= " " then
      num = num * 10
      num = num + tonumber(dig)
    end
  end
  return num
end

local lines = {}
for line in io.lines() do
  if line == "" then break end
  table.insert(lines, line)
end

local total = 0
local ops = lines[#lines]
local currProblem = 0
local currOp
for col=1,#lines[1] do
  local num = get_num(lines, col)
  if num == 0 then goto continue end
  local op = ops:sub(col, col)
  if op ~= " " then
    total = total + currProblem
    currOp = op
    if op == "+" then currProblem = 0 else currProblem = 1 end
  end

  if currOp == "+" then
    currProblem = currProblem + num
  else
    currProblem = currProblem * num
  end
    ::continue::
end

total = total + currProblem

print(total)
