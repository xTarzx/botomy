local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        level = nil,
        meta = nil,
        paused = true,
    }, Scene)
end

function Scene:setLevel(level)
    self.level = level
    self.meta = love.filesystem.load("levels/" .. self.level)()
    self.paused = true
end

function Scene:enter(params)
    if params.level then
        self:setLevel(params.level)
    end
end

function Scene:update(dt)
    if not self.paused then

    end
end

function Scene:draw()
    local font = love.graphics.newFont(FontSize * 0.65, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()

    love.graphics.setFont(font)

    local level = "level: " .. self.meta.name .. " (" .. self.level .. ")"
    love.graphics.print(level, 0, 0)
end

function Scene:keypressed(key)
end

function Scene:keyreleased(key)
end

return Scene
