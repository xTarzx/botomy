local Brain = {}
Brain.__index = Brain

function Brain.new()
    return setmetatable({}, Brain)
end

function Brain:think(params)
end

return Brain
