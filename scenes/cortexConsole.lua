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
    local titleFont = love.graphics.newFont(FontSize * 2, "mono")
    local font = love.graphics.newFont(FontSize * 1.5, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()

    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)

    local boundary_w = windowHeight * 0.40
    local boundary_h = windowHeight * 0.40
    local boundary_x = windowWidth / 2 - boundary_w / 2
    local boundary_y = windowHeight / 2 - boundary_h / 2
    love.graphics.setColor(0.4, 0.4, 0.4, 1.0)
    love.graphics.rectangle("fill", boundary_x, boundary_y, boundary_w, boundary_h)

    love.graphics.setFont(titleFont)
    love.graphics.setColor(1, 1, 1, 1)
    local cx = boundary_x + boundary_w / 2
    local title = "Cortex Console"
    local titleWidth = titleFont:getWidth(title)
    love.graphics.print(title, cx - titleWidth / 2, boundary_y + font_h)
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    end
end

function Scene:keyreleased(key)
end

return Scene
