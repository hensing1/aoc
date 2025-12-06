local function read_input()
  local line = io.read()
  local columns = {}
  for num in line:gmatch("%d+") do
    table.insert(columns, { nums={tonumber(num)} })
  end

  line = io.read()
  while line:sub(1, 1) ~= "*" and line:sub(1,1) ~= "+" do
    local colInd = 1
    for num in line:gmatch("%d+") do
      table.insert(columns[colInd].nums, tonumber(num))
      colInd = colInd + 1
    end
    line = io.read()
  end

  local colInd = 1
  for op in line:gmatch("[%*%+]") do
    columns[colInd].op = op
    colInd = colInd + 1
  end

  return columns
end

local total = 0
for _, column in ipairs(read_input()) do
  local res
  if column.op == "*" then
    res = 1
    for _, num in ipairs(column.nums) do
      res = res * num
    end
  elseif column.op == "+" then
    res = 0
    for _, num in ipairs(column.nums) do
      res = res + num
    end
  else
    print "some bullshit happened"
    print(column.op)
  end
  total = total + res
end

print(total)
