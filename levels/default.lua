local Level = {}
Level.__index = Level

function Level.new()
    return setmetatable({
    }, Level)
end

function Level:update(dt)
end

function Level:draw()
    love.graphics.print("default level", 0, 0)
end

local Meta = {
    name = "default",
    level = Level
}

return Meta
