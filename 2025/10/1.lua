local dump = require("lualib.dumptable")
local queue = require("lualib.linked_queue")

local function read_input()
  local machines = {}
  for line in io.lines() do
    if line == "" then break end
    local leds = 0
    local buttons = {}
    local ledstr = string.reverse(line:match("[%.#]+"))
    for led in ledstr:gmatch(".") do
      leds = leds << 1
      leds = leds | (led == "#" and 1 or 0)
    end
    for buttonstr in line:gmatch("%([%d,]+%)") do
      local button = 0
      for ind in buttonstr:gmatch("(%d+)") do
        button = button | (1 << tonumber(ind))
      end
      table.insert(buttons, button)
    end
    table.insert(machines, {leds=leds, buttons=buttons})
  end
  return machines
end

local function bfs(target, state, buttons)
  local visited = {}
  local q = queue.new()
  q:push({state=state, count=0, pressed=0})

  while not q:empty() do
    local current = q:pop()
    if current.state == target then return current.count end

    visited[current.state] = true

    for i, button in ipairs(buttons) do
      if (current.pressed & (1 << i)) > 0 then goto continue end
      local next_state = current.state ~ button  -- press button via bitwise XOR
      if visited[next_state] then goto continue end
      local now_pressed = current.pressed | (1 << i)
      q:push({state=next_state, count=current.count + 1, pressed=now_pressed})
        ::continue::
    end
  end
  error("no solution found")
end

local machines = read_input()
-- print(dump(machines))

local total = 0
for _, machine in ipairs(machines) do
  total = total + bfs(machine.leds, 0, machine.buttons)
end
print(total)
