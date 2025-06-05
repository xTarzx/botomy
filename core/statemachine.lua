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
end

function StateMachine:push(stateName, params)
    assert(self.states[stateName], "Invalid state: " .. stateName)
    table.insert(self.stack, stateName)
end

function StateMachine:pop()
    table.remove(self.stack, #self.stack)
end

function StateMachine:update(dt)
    self.states[self.stack[#self.stack]]:update(dt)
end

function StateMachine:draw()
    self.states[self.stack[#self.stack]]:draw()
end

function StateMachine:keypressed(key)
end

function StateMachine:keyreleased(key)
end

return StateMachine
