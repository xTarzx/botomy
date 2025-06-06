local Meta = {
    name = "dino",
    max_bots = 1,
}

local Level = {}
Level.__index = Level

local DINO_SIZE = 40

function Level.new(params)
    local self = setmetatable({
        bots = params.bots or {},
        brains = params.brains or {},
        canvasWidth = params.canvasWidth,
        canvasHeight = params.canvasHeight,

        dinos = {},
        blocks = {},
        spawnTimer = 0
    }, Level)

    for _, bot in ipairs(self.bots) do
        self.dinos[bot] = { x = 0, y = 0, w = DINO_SIZE, h = DINO_SIZE, vy = 0 }
    end

    return self
end

function Level:addBot(brain)
    if #self.bots < Meta.max_bots then
        local bot = "bot" .. tostring(#self.bots + 1)
        table.insert(self.bots, bot)
        self.brains[bot] = brain
        self.dinos[bot] = { x = 0, y = 0, w = DINO_SIZE, h = DINO_SIZE, vy = 0 }
    end
end

function Level:transplantBrain(botIndex, brain)
    assert(botIndex <= #self.bots, "zombies")

    self.brains[self.bots[botIndex]] = brain
end

function Level:update(dt)
    if self.spawnTimer > 0 then
        self.spawnTimer = self.spawnTimer - dt
    end

    if self.spawnTimer < 0 then
        self.spawnTimer = love.math.random()
    end

    local gravity = 500
    for _, bot in ipairs(self.bots) do
        local dino = self.dinos[bot]
        local isGrounded = dino.y <= 0
        local params = { dt = dt, isGrounded = isGrounded }
        local action = self.brains[bot] and self.brains[bot]:think(params)

        if isGrounded then
            dino.y = 0
            dino.vy = 0
            if action then
                dino.vy = -300
            end
        else
            dino.vy = dino.vy + gravity * dt
        end

        dino.y = dino.y - dino.vy * dt

    end
end

function Level:draw()
    love.graphics.clear(0.1, 0.1, 0.1, 1.0)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("dino", 0, 0)

    local ground_x = 0
    local ground_w = self.canvasWidth
    local ground_h = self.canvasHeight * 0.05
    local ground_y = self.canvasHeight - ground_h

    love.graphics.setColor(0.7, 0.5, 0.25, 1)
    love.graphics.rectangle("fill", ground_x, ground_y, ground_w, ground_h)

    love.graphics.setColor(0.46, 0.59, 0.39, 1)
    for _, bot in ipairs(self.bots) do
        local dino = self.dinos[bot]
        local x = ground_w * 0.30 + dino.x - dino.w / 2
        local y = ground_y - dino.y - dino.h
        love.graphics.rectangle("fill", x, y, dino.w, dino.h)
    end
end

Meta.level = Level
return Meta
