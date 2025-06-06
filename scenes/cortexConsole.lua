local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        selected = "add",
        neuroSeeds = {},
    }, Scene)
end

function Scene:enter(params)
    assert(params and params.level, "you need a level bro")
    self.level = params.level and params.level or self.level
    self.neuroSeeds = params.neuroSeeds and params.neuroSeeds or self.neuroSeeds
end

function Scene:update(dt)
end

function Scene:draw()
    local titleFont = love.graphics.newFont(FontSize * 0.80, "mono")
    local font = love.graphics.newFont(FontSize * 0.65, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()
    local mark_w = font:getWidth("*")

    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)

    local boundary_w = windowWidth * 0.65
    local boundary_h = windowHeight * 0.65
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

    love.graphics.setFont(font)
    local addBot_cx = boundary_x * 1.40
    local addBot_y = boundary_y + font_h * 3
    local addText = "add"
    local addText_w = font:getWidth(addText)
    love.graphics.print(addText, addBot_cx - addText_w / 2, addBot_y)

    if self.selected == addText then
        love.graphics.print("*", addBot_cx - addText_w / 2 - mark_w * 2, addBot_y)
        love.graphics.print("*", addBot_cx + addText_w / 2 + mark_w, addBot_y)
    end

    local botList_x = addBot_cx - addText_w / 2
    local botBrain_x = botList_x * 1.5
    for i, bot in ipairs(self.level.bots) do
        local y = addBot_y * 1.2 + (i - 1) * font_h
        love.graphics.print(bot, botList_x, y)
        if self.selected == i then
            love.graphics.print("*", botList_x - mark_w * 2, y)
            love.graphics.print("*", botList_x + font:getWidth(bot) + mark_w, y)
        end

        local brain = self.neuroSeeds[i]
        if brain then
            local text = brain.file
            love.graphics.print(text, botBrain_x, y)
        end
    end
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:pop()
    elseif key == "space" or key == "return" then
        self:handleSelection()
    elseif key == "w" or key == "up" then
        if self.selected == "add" then
            if #self.level.bots > 0 then
                self.selected = #self.level.bots
            end
        else
            self.selected = self.selected - 1
            if self.selected < 1 then
                self.selected = "add"
            end
        end
    elseif key == "s" or key == "down" then
        if self.selected == "add" then
            if #self.level.bots > 0 then
                self.selected = 1
            end
        else
            self.selected = self.selected + 1
            if self.selected > #self.level.bots then
                self.selected = "add"
            end
        end
    end
end

function Scene:keyreleased(key)
end

function Scene:handleSelection()
    if self.selected == "add" then
        self.level:addBot()
    else
        SceneManager:push("brainBank", {
            onSelect = function(brain)
                self.neuroSeeds[self.selected] = { file = brain, neuroSeed = love.filesystem.load("brains/" .. brain)() }
            end,
        }, { popup = true })
    end
end

return Scene
