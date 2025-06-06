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
    local stateName = self.stack[#self.stack]
    local state = self.states[stateName]

    if self.opts[stateName] and self.opts[stateName].popup then
        local previous = self.states[self.stack[#self.stack - 1]]
        if previous.draw then
            previous:draw()
        end
    end

    if state.draw then
        state:draw()
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
