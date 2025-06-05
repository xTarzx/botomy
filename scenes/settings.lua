local Scene = {}
Scene.__index = Scene

function Scene.new()
    local settings_map = {}

    for entry in pairs(Settings) do
        table.insert(settings_map, entry)
    end

    return setmetatable({
        selected = nil,
        settings_map = settings_map
    }, Scene)
end

function Scene:enter(params)
    if not self.selected then
        self.selected = 1
    end
end

function Scene:update(dt)
end

function Scene:draw()
    local titleFont = love.graphics.newFont(FontSize * 2, "mono")
    local font = love.graphics.newFont(FontSize * 1.5, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()

    love.graphics.setFont(titleFont)
    local title = "Settings"
    local titleWidth = titleFont:getWidth(title)
    love.graphics.print(title, windowWidth / 2 - titleWidth / 2, windowHeight * 0.10)

    love.graphics.setFont(font)

    local key_x = windowWidth * 0.30
    local value_x = windowWidth * 0.70
    local mark_w = font:getWidth("*")
    local i = 1
    for key, value in pairs(Settings) do
        local y = windowHeight * 0.25 + i * font_h
        love.graphics.print(key, key_x, y)

        if type(value) == "boolean" then
            local text = tostring(value)
            local text_w = font:getWidth(text)
            love.graphics.print(text, value_x - text_w, y)
        end

        if self.settings_map[self.selected] == key then
            love.graphics.print("*", key_x - mark_w * 2, y)
            love.graphics.print("*", value_x + mark_w * 2, y)
        end

        i = i + 1
    end


    local back = "BACK"
    if self.selected == "back" then
        back = "* BACK *"
    end
    local back_w = font:getWidth(back)
    local back_cx = windowWidth * 0.20
    local back_y = windowHeight - font_h
    love.graphics.print(back, back_cx / 2 - back_w / 2, back_y)
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    elseif key == "w" or key == "up" then
        if self.selected == "back" then
            self.selected = #self.settings_map
        else
            self.selected = self.selected - 1
            if self.selected < 1 then
                self.selected = "back"
            end
        end
    elseif key == "s" or key == "down" then
        if self.selected == "back" then
            self.selected = 1
        else
            self.selected = self.selected + 1
            if self.selected > #self.settings_map then
                self.selected = "back"
            end
        end
    elseif key == "space" or key == "return" then
        if self.selected == "back" then
            SceneManager:pop()
        else
            local settingName = self.settings_map[self.selected]


            if settingName == "fullscreen" then
                local value = not Settings[settingName]
                Settings[settingName] = value
                love.window.setFullscreen(value)
                SaveSettings()
            end
        end
    end
end

function Scene:keyreleased(key)
end

return Scene
