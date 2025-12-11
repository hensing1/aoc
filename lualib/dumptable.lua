function dump(o, indent)
	indent = indent or ""
	if type(o) == "table" then
		local s = "{\n"
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. indent .. "  [" .. k .. "] = " .. dump(v, indent .. "  ") .. ",\n"
		end
		return s .. indent .. "}"
	else
		return tostring(o)
	end
end

return dump
