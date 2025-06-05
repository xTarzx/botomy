local Scene = {}
Scene.__index = Scene


function Scene.new()
    return setmetatable({
        selected = 1,
        menuEntries = {
            "PLAY",
            "SETTINGS",
            "QUIT"
        },
    }, Scene)
end

function Scene:update(dt)
end

function Scene:draw()
    local titleFont = love.graphics.newFont(FontSize * 2, "mono")
    local font = love.graphics.newFont(FontSize * 1.5, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()

    love.graphics.setFont(titleFont)
    local title = "BOTomy"
    local titleWidth = titleFont:getWidth(title)
    love.graphics.print(title, windowWidth / 2 - titleWidth / 2, windowHeight * 0.20)

    love.graphics.setFont(font)
    local y0 = windowHeight / 2
    local h = font:getHeight()
    for i, entry in ipairs(self.menuEntries) do
        local text = entry
        if self.selected == i then
            text = "* " .. entry .. " *"
        end
        local w = font:getWidth(text)
        local y = y0 + h * (i - 1)
        local x = windowWidth/2-w/2
        love.graphics.print(text, x, y)
    end
end

function Scene:keypressed(key)
    if key == "w" or key == "up" then
        self.selected = self.selected - 1
        if self.selected < 1 then
            self.selected = #self.menuEntries
        end
    elseif key == "s" or key == "down" then
        self.selected = self.selected + 1
        if self.selected > #self.menuEntries then
            self.selected = 1
        end
    elseif key == "space" or key == "return" then
        self:handleSelection()
    end
end

function Scene:handleSelection()
    local selected = self.menuEntries[self.selected]

    if selected == "PLAY" then
    elseif selected == "SETTINGS" then
        SceneManager:push("settings")
    elseif selected == "QUIT" then
        love.event.quit()
    end

end

return Scene
