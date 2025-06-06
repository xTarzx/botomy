local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        selected = 0,
        brains = {},
    }, Scene)
end

function Scene:enter(params)
    self.brains = love.filesystem.getDirectoryItems("brains")
    table.sort(self.brains)
    self.selected = math.min(#self.brains, 1)
end

function Scene:update(dt)
end

function Scene:draw()
    local font = love.graphics.newFont(FontSize * 0.65, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()
    local mark_w = font:getWidth("*")

    local boundary_w = windowWidth * 0.20
    local boundary_h = windowHeight * 0.45
    local boundary_x = windowWidth / 2 - boundary_w / 2
    local boundary_y = windowHeight / 2 - boundary_h / 2
    love.graphics.setColor(0.5, 0.5, 0.5, 1.0)
    love.graphics.rectangle("fill", boundary_x, boundary_y, boundary_w, boundary_h)
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    end
end

function Scene:keyreleased(key)
end

return Scene
