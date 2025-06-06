local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(states)
    return setmetatable({
        states = states,
        stack = {},
        opts = {},
    }, StateMachine)
end

function StateMachine:change(stateName, params)
    assert(self.states[stateName], "Invalid state: " .. stateName)
    self.stack = {}
    table.insert(self.stack, stateName)
    if self.states[stateName].enter then
        self.states[stateName]:enter(params)
    end
    pcall(function()
        self.opts[stateName].popup = false
    end)
end

function StateMachine:push(stateName, params, opts)
    assert(self.states[stateName], "Invalid state: " .. stateName)
    table.insert(self.stack, stateName)
    if self.states[stateName].enter then
        self.states[stateName]:enter(params)
    end

    self.opts[stateName] = opts
end

function StateMachine:get(stateName)
    assert(self.states[stateName], "Invalid state: " .. stateName)
    return self.states[stateName]
end

function StateMachine:pop()
    table.remove(self.stack, #self.stack)
end

function StateMachine:update(dt)
    local stateName = self.stack[#self.stack]
    local state = self.states[stateName]
    if state.update then
        state:update(dt)
    end
end

function StateMachine:draw()
    local drawStack = {}

    for i = #self.stack, 1, -1 do
        local stateName = self.stack[i]
        table.insert(drawStack, stateName)
        if not (self.opts[stateName] and self.opts[stateName].popup) then
            break
        end
    end


    for i = #drawStack, 1, -1 do
        local stateName = drawStack[i]
        local state = self.states[stateName]

        if state.draw then
            state:draw()
        end
    end
end

function StateMachine:keypressed(key)
    local state = self.states[self.stack[#self.stack]]
    if state.keypressed then
        state:keypressed(key)
    end
end

function StateMachine:keyreleased(key)
    local state = self.states[self.stack[#self.stack]]
    if state.keyreleased then
        state:keyreleased(key)
    end
end

return StateMachine
