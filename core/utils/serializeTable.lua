local function serializeTable(tbl, indent)
    indent = indent or ""
    local nextIndent = indent .. "  "
    local str = "{\n"
    for k, v in pairs(tbl) do
        local key = type(k) == "string" and string.format("[%q]", k) or "[" .. k .. "]"
        local value
        if type(v) == "table" then
            value = serializeTable(v, nextIndent)
        elseif type(v) == "string" then
            value = string.format("%q", v)
        else
            value = tostring(v)
        end
        str = str .. nextIndent .. key .. " = " .. value .. ",\n"
    end
    return str .. indent .. "}"
end


return serializeTable
