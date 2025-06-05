local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(states)
    return setmetatable({
        states = states,
        stack = {},
    }, StateMachine)
end

function StateMachine:change(stateName, params)
    assert(self.states[stateName], "Invalid state: " .. stateName)
    self.stack = {}
    table.insert(self.stack, stateName)
    if self.states[stateName].enter then
        self.states[stateName]:enter(params)
    end
end

function StateMachine:push(stateName, params)
    assert(self.states[stateName], "Invalid state: " .. stateName)
    table.insert(self.stack, stateName)
    if self.states[stateName].enter then
        self.states[stateName]:enter(params)
    end
end

function StateMachine:pop()
    table.remove(self.stack, #self.stack)
end

function StateMachine:update(dt)
    local state = self.states[self.stack[#self.stack]]
    if state.update then
        state:update(dt)
    end
end

function StateMachine:draw()
    local state = self.states[self.stack[#self.stack]]
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
