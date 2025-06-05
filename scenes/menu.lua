local Scene = {}
Scene.__index = Scene

local MenuEntries = {
    play = "PLAY",
    settings = "SETTINGS",
    quit = "QUIT"
}

function Scene.new()
    return setmetatable({}, Scene)
end

function Scene:update(dt)
end

function Scene:draw()
    love.graphics.print("menu", 0, 0)
end

return Scene
