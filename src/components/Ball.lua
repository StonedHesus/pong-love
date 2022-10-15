--[[

    This here compilation unit models the Ball object.
    
    @author Andrei-Paul Ionescu.
]]

-- Inform the environment that Ball indicates a class.
Ball = Class{}

--[[


    @author Andrei-Paul Ionescu.
]]
function Ball:init(x, y, radius)
    self.x = x
    self.y = y 
    self.radius = radius

    -- Initialise the two variables which allow us to keep track of the ball's velocity on both of the axis.
    self.deltaX = math.random(2) == 1 and -250 or 250
    self.deltaY = math.random(-300, 300)
end
--[[

    @author Andrei-Paul Ionescu.
]]
function Ball:update(deltaTime)
    self.x = self.x + self.deltaX * deltaTime
    self.y = self.y + self.deltaY * deltaTime
end

--[[

    @author Andrei-Paul Ionescu.
]]
function Ball:draw()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end
