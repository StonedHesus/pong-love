--[[
    This here compilation unit serves the role of the runner of the game, i.e. it is the unit in which we 
    will invoke Löve2D methods that allow us to set up the initial behaviour of the view, i.e. what's going 
    to happen when the view is first loaded. In addition that, it is here that we will also define how the 
    game behaves to frame changes.

    @author Andrei-Paul Ionescu.
]]

-- Define two global constants which indicate the default dimension which will be utilised so as to 
-- create the initial view of the software.
DEFAULT_WINDOW_WIDTH  = 1280
DEFAULT_WINDOW_HEIGHT = 720
DEFAULT_PADDLE_SPEED = 200

-- Define a global constant which contains the title of the view, i.e. the title of the game in this case.
VIEW_TITLE = "Pong"

-- Load the required external libraries.
push = require "./libraries/push"
Class = require './libraries/class' -- This library will allow us to interact with class in a Python like manner.

-- Import the required classes.
require './components/Paddle'


--[[
    Handle keyboard events. This method is invoked by Löve2D each frame.
    The key parameter contains the intercepted key event object which the user provided.

    @author Andrei-Paul Ionescu.
]]
function love.keypressed(key)

    -- If the user has pressed the escape key, i.e. ESC on the majority of keyboards, then close the program.
    if key == "escape" then
        love.event.quit()
    end
end

--[[
    Describe the behaviour which the program, chiefly the view, ought to have when the application is
    launched.
    Therefore, this method is invoked one sole time by Löve2D.

    Inside it we will initialise all the required objects, we will define the default behaviour of those 
    game components, and of environmental ones, such as the screen.

    @author Andrei-Paul Ionescu.
]]
function love.load()

    -- Define the initial behaviour of the screen.
    -- When launched, the size of the screen ought to be the one indicated by the global constant values.
    love.window.setMode(DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, {

        -- Inside the third argument, which is a table type data collection, we indicate that 
        -- the view should not be launched in full-screen mode, that it should not be resisable, 
        -- and that it ought to vertically sync itself with the user's monitor.
        fullscreen = false,
        resizable  = false,
        vsync      = true
    })

    -- Initialise the required game components, and pass to them the default values for their properties.
    leftSidePlayer  = Paddle(100, 300, 30, 200)
    rightSidePlayer = Paddle(DEFAULT_WINDOW_WIDTH - 100, DEFAULT_WINDOW_HEIGHT - 420, 30, 200)

    -- Set the title of the view to equal to the contents of the VIEW_TITLE global constant.
    love.window.setTitle(VIEW_TITLE)
end

--[[
    @param deltaTime, indicates the amount of time between each two consecutive frames.

    Describe the behaviour which the program ought to have when one unit of time, i.e. a frame has elapsed.
    The unit of time is indicated by the argument deltaTime, which Löve2D is going to provide.

    @author Andrei-Paul Ionescu.
]]
function love.update(deltaTime)

    -- Intercept keyboard input that is linked with the left player's paddle.
    if love.keyboard.isDown('w') then
        leftSidePlayer.deltaY = -DEFAULT_PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        leftSidePlayer.deltaY = DEFAULT_PADDLE_SPEED
    else
        leftSidePlayer.deltaY = 0
    end

    -- Intercept keyboard input that is linked with the right player's paddle.
    if love.keyboard.isDown('up') then
        rightSidePlayer.deltaY = -DEFAULT_PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        rightSidePlayer.deltaY = DEFAULT_PADDLE_SPEED
    else
        rightSidePlayer.deltaY = 0
    end


    leftSidePlayer:update(deltaTime)
    rightSidePlayer:update(deltaTime)
end

--[[
    Describe the set of rules for the elements which need to be drawn to the screen.
    In addition, indicate certain constraints regarding when each drawing ought to be made.

    @author Andrei-Paul Ionescu.
]]
function love.draw()

    -- Define a state machine which is comprised of the collection of rules that we ought to follow 
    -- for each frame so as to render the visuals in accordance to different events which might have 
    -- been triggered within the program.

    -- Begin rendering.
    --push:apply('start')

    love.graphics.printf('Hello Pong!', 0, DEFAULT_WINDOW_HEIGHT / 2 - 6, DEFAULT_WINDOW_WIDTH, 'center')

    -- Draw the paddle's to the screen in their current state.
    leftSidePlayer:draw()
    rightSidePlayer:draw()

    -- End rendering.
    --push:apply('end')
end
