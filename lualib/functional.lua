local functional = {}

function functional.map(t, fn)
    local new = {}
    for i, v in ipairs(t) do
        new[i] = fn(v)
    end
    return new
end

function functional.map_kv(t, fn)
    local new = {}
    for k, v in pairs(t) do
        new[k] = fn(v)
    end
    return new
end

return functional
