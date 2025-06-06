local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        bot = nil,
        onSelect = nil,
        selected = 0,
        brains = {},
    }, Scene)
end

function Scene:enter(params)
    self.brains = love.filesystem.getDirectoryItems("brains")
    table.sort(self.brains)
    self.selected = math.min(#self.brains, 1)

    self.bot = params.bot
    self.onSelect = params.onSelect
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

    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    love.graphics.setFont(font)
    for i, value in ipairs(self.brains) do
        local y = boundary_y + i * font_h
        local text = value
        if self.selected == i then
            text = "* " .. text .. " *"
        end

        local text_w = font:getWidth(text)
        local text_cx = boundary_x + boundary_w / 2

        love.graphics.print(text, text_cx - text_w / 2, y)
    end
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    elseif key == "w" or key == "up" then
        self.selected = self.selected - 1
        if self.selected < 1 then
            self.selected = #self.brains
        end
    elseif key == "s" or key == "down" then
        self.selected = self.selected + 1
        if self.selected > #self.brains then
            self.selected = 1
        end
    elseif key == "space" or key == "return" then
        self.onSelect(self.brains[self.selected])
        SceneManager:pop()
    end
end

function Scene:keyreleased(key)
end

return Scene
