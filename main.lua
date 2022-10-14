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

-- Define a global constant which contains the title of the view, i.e. the title of the game in this case.
VIEW_TITLE = "Pong"


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

end
