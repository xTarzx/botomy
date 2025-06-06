local Meta = {
    name = "dino",
    max_bots = 1,
}

local Level = {}
Level.__index = Level

function Level.new(params)
    return setmetatable({
        bots = params.bots or {},
        brains = params.brains or {},
        canvasWidth = params.canvasWidth,
        canvasHeight = params.canvasHeight,
    }, Level)
end

function Level:addBot(brain)
    if #self.bots < Meta.max_bots then
        local bot = "bot" .. tostring(#self.bots + 1)
        table.insert(self.bots, bot)
        self.brains[bot] = brain
    end
end

function Level:transplantBrain(botIndex, brain)
    assert(botIndex <= #self.bots, "zombies")

    self.brains[self.bots[botIndex]] = brain
end

function Level:update(dt)
    
end

function Level:draw()
    love.graphics.clear(0.1, 0.1, 0.1, 1.0)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.print("dino", 0, 0)
end

Meta.level = Level
return Meta
