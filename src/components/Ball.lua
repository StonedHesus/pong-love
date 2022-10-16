--[[

    This here compilation unit models the Ball object.
    
    @author Andrei-Paul Ionescu.
]]

-- Inform the environment that Ball indicates a class.
Ball = Class{}

--[[
    @param x; a numerical, integer value which indicates the initial x-axis coordinate of the ball object.
    @param y; a numerical, integer value which indicates the initial y-axis coordinate of the ball object.
    @param radius; since the ball game object is going to represented as a circle, we have to provide the radius of the ball. 

    This is the sole constructor provided for the class.
    Its role is to initialise the attributes which are going to be present in the object's table
    with the values provided by the one invoking the initialiser/constructor routine.

    In addition to this, the constructor also initialises the deltaX, and deltaY values.
    These values are for now initialised with a random x-axis bounded velocity and a y-axis bounded direction.

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
    @param deltaTime; a numerical integer value which indicates the amount of time that elapsed betwixt
    two consectuive frames.

    This here method updates the x and y coordinate values of the ball.

    @author Andrei-Paul Ionescu.
]]
function Ball:update(deltaTime)
    self.x = self.x + self.deltaX * deltaTime
    self.y = self.y + self.deltaY * deltaTime
end

--[[

    This here routine resets the ball's attributes to their initial default value.

    @author Andrei-Paul Ionescu.
]]
function Ball:reset()
    self.x = DEFAULT_WINDOW_WIDTH / 2 - 20
    self.y = DEFAULT_WINDOW_WIDTH / 2 - 20

    self.deltaX = math.random(2) == 1 and -250 or 250
    self.deltaY = math.random(-300, 300)
end

--[[
    @param paddle; a Paddle type object.

    Determine if the ball object collides with the paddle object which is provided to the function as an argument.

    In the case in which a collision is detected, the method yields the boolean value true to the caller.
    If no collision was detected, then the routine yields the boolean value false to the caller.    

    @author Andrei-Paul Ionescu.
]]
function Ball:collides(paddle)

    -- Determine whether any collision occurs which involve the top edges.
    -- If no collision occur between those edges then this test yields the boolean value false.
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.radius then
        return false
    end

    -- Determine whether any collision occurs which involve the bottom edges.
    -- If no collision occur between those edges then this test yields the boolean value false.
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.radius then
        return false
    end

    -- If the previous two conditionals failed, it implies that a collision took place,
    -- hence in this case we yield the true boolean value.
    return true
end

--[[

    This here routine utilises Löve2D's framework API so as to tell to the framework 
    that we wish to draw our current ball object to the screen.
    In order to achieve this we utilise the circle() function which is found within the graphics module.

    @author Andrei-Paul Ionescu.
]]
function Ball:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle('fill', self.x, self.y, self.radius)
end
