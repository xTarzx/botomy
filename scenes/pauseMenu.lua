local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        selected = 1,
        menuEntries = {
            "BACK",
            "SETTINGS",
            "MAIN MENU",
        }
    }, Scene)
end

function Scene:enter(params)
    self.selected = 1
end

function Scene:update(dt)
end

function Scene:draw()
    local font = love.graphics.newFont(FontSize * 0.65, "mono")
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

    love.graphics.setFont(font)
    love.graphics.setColor(1, 1, 1, 1)

    local cx = boundary_x + boundary_w / 2
    local y0 = boundary_y + font_h

    for i, entry in ipairs(self.menuEntries) do
        local text = entry
        if self.selected == i then
            text = "* " .. entry .. " *"
        end
        local w = font:getWidth(text)
        local y = y0 + font_h * (i - 1)
        local x = cx - w / 2
        love.graphics.print(text, x, y)
    end
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    elseif key == "w" or key == "up" then
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

function Scene:keyreleased(key)
end

function Scene:handleSelection()
    local selected = self.menuEntries[self.selected]

    if selected == "BACK" then
        SceneManager:pop()
    elseif selected == "SETTINGS" then
        SceneManager:push("settings")
    elseif selected == "MAIN MENU" then
        -- TODO: cleanup
        SceneManager:change("menu")
    end
end

return Scene
