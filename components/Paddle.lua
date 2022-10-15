--[[

    This here compilation unit models the Paddle object.
    
    @author Andrei-Paul Ionescu.
]]

-- Inform the environment that the Paddle indicates a class.
Paddle = Class{}

--[[
    @param x; a numerical, integer value indicating the x-axis coordinate value of the current paddle object.
    @param y; a numerical, integer value indicatingthe y-axis coordinate value of the current paddle object.
    @param width; a numerical, integer value which indicates the width of the current paddle.
    @param height; a numerical, integer value which indicates the width of the current paddle.

    This is the sole constructor provided for the class.
    Its role is simply to initialise the attributes which are going to be present in the object's table 
    with the values provided by the one invoking the initialiser routine.

    In addition to this, the constructor also initialises the deltaY value with its default value of 0.

    @author Andrei-Paul Ionescu.
]]
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width  = width
    self.height = height
    self.deltaY = 0
end

--[[

    @param deltaTime; a numerical integer value which indicates the amount of time that elapsed betwixt two 
    consecutives frames.

    This here method updates the y-coordinate value of the paddle. 
    Since in the game of pong, the user controlled objects only move on the y-axis, we will have to verify
    whether or not the objects have reached the boundaries of the current view, this ensures us that 
    the objects won't disappear out of view.

    @author Andrei-Paul Ionescu.
]]
function Paddle:update(deltaTime)

    -- If we are going up, then.
    if self.deltaY < 0 then
        -- Determine whether we have reached the top, i.e. y = 0, or whether we are still not there yet.
        self.y = math.max(0, self.y + deltaTime * self.deltaY)
    -- Else, if we are going downwards, then.
    else
        -- Determine whether we have reached the buttom, i.e. DEFAULT_WINDOW_HEIGHT - self.height.
        self.y = math.min(self.y + deltaTime * self.deltaY, DEFAULT_WINDOW_HEIGHT - self.height)
    end

end

--[[

    @author Andrei-Paul Ionescu.
]]
function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end