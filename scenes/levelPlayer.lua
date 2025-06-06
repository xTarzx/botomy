local Scene = {}
Scene.__index = Scene

function Scene.new()
    return setmetatable({
        level = nil,
        meta = nil,
        paused = true,
        _level = nil,
        canvas = love.graphics.newCanvas(1280, 720),
        neuroSeeds = {},
        elapsed = 0,
    }, Scene)
end

function Scene:setLevel(level)
    self.level = level
    self.meta = love.filesystem.load("levels/" .. self.level)()
    self.paused = true
    self._level = self.meta.level.new({
        canvasWidth = self.canvas:getWidth(),
        canvasHeight = self.canvas:getHeight(),
    })
end

function Scene:resetLevel()
    self.elasped = 0
    local bots = {}
    for i, bot in ipairs(self._level.bots) do
        bots[i] = bot
    end

    self._level = self.meta.level.new({
        canvasWidth = self.canvas:getWidth(),
        canvasHeight = self.canvas:getHeight(),
        bots = bots,
    })

    for i, bot in ipairs(self._level.bots) do
        local brain = self.neuroSeeds[i] and self.neuroSeeds[i].neuroSeed.new()
        self._level:transplantBrain(i, brain)
    end
end

function Scene:enter(params)
    if params.level then
        self:setLevel(params.level)
    end
end

function Scene:update(dt)
    if not self.paused then
        self._level:update(dt)
        self.elapsed = self.elapsed + dt
    end
end

function Scene:draw()
    local font = love.graphics.newFont(FontSize * 0.65, "mono")
    local windowWidth, windowHeight = love.graphics.getDimensions()
    local font_h = font:getHeight()
    local canvas_w, canvas_h = self.canvas:getDimensions()


    love.graphics.setCanvas(self.canvas)
    love.graphics.setFont(font)
    love.graphics.setBlendMode("alpha")
    self._level:draw()
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.clear()
    local ratio = canvas_h / windowHeight
    local scale = ratio * 0.8
    local x = windowWidth / 2 - canvas_w * scale / 2
    local y = windowHeight / 2 - canvas_h * scale / 2

    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.canvas, x, y, 0, scale, scale)

    love.graphics.setBlendMode("alpha")


    love.graphics.setFont(font)
    local level = "level: " .. self.meta.name .. " (" .. self.level .. ")"
    love.graphics.print(level, 0, 0)
    local state = self.paused and "paused" or "playing"
    love.graphics.print(state, 0, font_h)

    local elapsed_x = font:getWidth(level)
    love.graphics.print(" -- elapsed: " .. tostring(self.elapsed), elapsed_x, 0)
end

function Scene:keypressed(key)
    if key == "escape" then
        SceneManager:push("pauseMenu", {}, { popup = true })
    elseif key == "space" then
        self.paused = not self.paused
    elseif key == "r" then
        self:resetLevel()
    elseif key == "c" then
        self:openCortex()
    end
end

function Scene:keyreleased(key)
end

function Scene:openCortex()
    SceneManager:push("cortex", {
        level = self._level,
        neuroSeeds = self.neuroSeeds
    }, { popup = true })
end

return Scene
