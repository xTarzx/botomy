local function parseResolution(res)
    local i = string.find(res,"x")
    return tonumber(string.sub(res, 1, i-1)),tonumber(string.sub(res, i+1, #res))
end


return parseResolution
