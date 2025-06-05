local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({}, Scene)
end

function Scene:update(dt)
end

function Scene:draw()
    love.graphics.print("settings", 0, 0)
end

return Scene
