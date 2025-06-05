local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({}, Scene)
end

function Scene:enter(params)
end

function Scene:update(dt)
end

function Scene:draw()
end

function Scene:keypressed(key)
end

function Scene:keyreleased(key)
end

return Scene
