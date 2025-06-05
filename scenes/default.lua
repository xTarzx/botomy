local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({}, Scene)
end

function Scene:update(dt)
end

function Scene:draw()
end

return Scene
