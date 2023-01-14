---@class StateMachine : Class
StateMachine = class{}

--- The StateMachine class constructor/initializer method.
--- The method automatically constructs and caches an empty state, which will 
--- be used as a fallback if the requested state is not found, or when the software 
--- is first initialized.
---@param states table
function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }
    self.states = states or {}
    self.current = self.empty
end

---@param stateName string
---@param parameters table
function StateMachine:change(stateName, parameters)
    assert(self.states[state])
    self.current:exit()
    self.current = self.states[state]()
    self.current:enter()
end

---@param deltaTime number
function StateMachine:update(deltaTime)
    self.current:update(deltaTime)
end

function StateMachine:render()
    self.current:render()
end