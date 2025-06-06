local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        selected = 0,
        levels = {}
    }, Scene)
end

function Scene:loadLevels()
    self.levels = love.filesystem.getDirectoryItems("levels")
    table.sort(self.levels)
end

function Scene:enter(params)
    self:loadLevels()
    self.selected = 1
end

function Scene:update(dt)
end

function Scene:draw()
    local titleFont = love.graphics.newFont(FontSize * 2, "mono")
    local font = love.graphics.newFont(FontSize, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()


    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.clear()
    love.graphics.setFont(titleFont)
    local title = "Levels"
    local titleWidth = titleFont:getWidth(title)
    love.graphics.print(title, windowWidth / 2 - titleWidth / 2, windowHeight * 0.10)

    love.graphics.setFont(font)

    for i, value in ipairs(self.levels) do
        local y = windowHeight * 0.30 + i * font_h
        local text = value
        if self.selected == i then
            text = "* " .. text .. " *"
        end

        local text_w = font:getWidth(text)
        local text_cx = windowWidth * 0.25
        love.graphics.print(text, text_cx - text_w / 2, y)
    end
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    elseif key == "w" or key == "up" then
        self.selected = self.selected - 1
        if self.selected < 1 then
            self.selected = #self.levels
        end
    elseif key == "s" or key == "down" then
        self.selected = self.selected + 1
        if self.selected > #self.levels then
            self.selected = 1
        end
    elseif key == "space" or key == "return" then
        SceneManager:change("player", { level = self.levels[self.selected] })
    end
end

function Scene:keyreleased(key)
end

return Scene
