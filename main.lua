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
VIRTUAL_WINDOW_WIDTH  = 480
VIRTUAL_WINDOW_HEIGHT = 320

DEFAULT_PADDLE_SPEED = 200

-- Define a global constant which contains the title of the view, i.e. the title of the game in this case.
VIEW_TITLE = "Pong"

--Define a set of global constants which contain the label of the states in which our state machine can 
-- be found.
PLAYING_STATE = 'playing'
PAUSED_STATE  = 'paused'
VICTORY_STATE = 'victory'

-- Load the required external libraries.
push = require "./libraries/push"
Class = require './libraries/class' -- This library will allow us to interact with class in a Python like manner.

-- Import the required classes.
require './src/components/Paddle'
require '/src/components/Ball'

-- Define a global variable which keeps track of the current state of the game, i.e. whether we are playing 
-- or we are pausing the game, by default this value is initialised with the paused state.
local programState = 'paused'

-- Define two accumulators which will keep track of the scores of left side player and right side player respectively.
local leftSidePlayerScore  = 0
local rightSidePlayerScore = 0

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
    
    if key == "return" or key == "enter" then 
        if programState == PAUSED_STATE then 
            programState = PLAYING_STATE
        elseif programState == PLAYING_STATE then 
            programState = PAUSED_STATE
        elseif programState == VICTORY_STATE then 
            leftSidePlayerScore  = 0
            rightSidePlayerScore = 0
            programState = PAUSED_STATE
        end
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

     -- Provide a different seed each time the program is ran so that random values are truly random.
     math.randomseed(os.time())

     -- Load the fonts utilised within the project, and define a variable for each individual size we 
     -- require. That is due to the fact that font objects are immutable, therefore further modification 
     -- of the size of the font is impossible.
     smallSizeFont = love.graphics.newFont('fonts/classic-arcade-font.ttf', 32)

     stateFont     = love.graphics.newFont('fonts/classic-arcade-font.ttf', 100)

     scoreFont     = love.graphics.newFont('fonts/classic-arcade-font.ttf', 160)

    -- Define the initial behaviour of the screen.
    -- When launched, the size of the screen ought to be the one indicated by the global constant values.
    push:setupScreen(DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, {

        -- Inside the third argument, which is a table type data collection, we indicate that 
        -- the view should not be launched in full-screen mode, that it should not be resisable, 
        -- and that it ought to vertically sync itself with the user's monitor.
        fullscreen = false,
        resizable  = true,
        vsync      = true
    })

    -- Initialise the required game components, and pass to them the default values for their properties.
    leftSidePlayer  = Paddle(100, 300, 30, 200)
    rightSidePlayer = Paddle(DEFAULT_WINDOW_WIDTH - 100, DEFAULT_WINDOW_HEIGHT - 420, 30, 200)
    ball            = Ball(DEFAULT_WINDOW_WIDTH / 2 - 20, DEFAULT_WINDOW_HEIGHT / 2 - 20, 20)

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

    if programState == PLAYING_STATE then

        -- Detect whether or not the ball collides with the left side paddle.
        if ball:collides(leftSidePlayer) then
            -- If that is the case, then since the ball was moving to the left, 
            -- we ought to change its direction, i.e. multiply its deltaX with -1
            -- and also multiply that value with a significant greater value so as 
            -- to gradually increase the difficulty of the game.
            ball.deltaX = -ball.deltaX * 1.05

            -- In addition to this, we would also move the ball slightly to the right 
            -- so that the movement does not commence from the point when the ball 
            -- is intersected with the exterior of the paddle. 
            -- We do this so as to ensure that the ball won't be detected once again
            -- by the colide function in the next frame, thus freezing the game.
            ball.x      = leftSidePlayer.x + 30

            -- Ensure that the angle at which the ball commences the movement in the new 
            -- direction is randomised.
            if ball.deltaY < 0 then
                ball.deltaY = -math.random(10, 150)
            else
                ball.deltaY = math.random(10, 150)
            end
        end

        -- Detect whether or not the ball collides with the right side paddle.
        if ball:collides(rightSidePlayer) then
                        -- If that is the case, then since the ball was moving to the left, 
            -- we ought to change its direction, i.e. multiply its deltaX with -1
            -- and also multiply that value with a significant greater value so as 
            -- to gradually increase the difficulty of the game.
            ball.deltaX = -ball.deltaX * 1.05

            -- In addition to this, we would also move the ball slightly to the right 
            -- so that the movement does not commence from the point when the ball 
            -- is intersected with the exterior of the paddle. 
            -- We do this so as to ensure that the ball won't be detected once again
            -- by the colide function in the next frame, thus freezing the game.
            ball.x      = rightSidePlayer.x - 20

            -- Ensure that the angle at which the ball commences the movement in the new 
            -- direction is randomised.
            if ball.deltaY < 0 then
                ball.deltaY = -math.random(10, 150)
            else
                ball.deltaY = math.random(10, 150)
            end
        end

        -- Respond to what happens when the ball hits the x-axis oriented edges of the court.
        if ball.y <= 0 then
            ball.y = 0
            ball.deltaY = -ball.deltaY
        end
        -- FIXME: DETERMINE WHY THE BALL JUST DISAPPEARS WHEN IT ENTERS IN CONTACT WITH THE
        --        LOWER PORTION OF THE SCREEN.
        if ball.y >= DEFAULT_WINDOW_HEIGHT - 40 then
            ball.y = DEFAULT_WINDOW_WIDTH - 40
            ball.deltaY = -ball.deltaY
        end

        -- Respond to the scenarios when the ball reaches the left or the right edges of the screen.
        if ball.x < 0 then 
            
            rightSidePlayerScore = rightSidePlayerScore + 1
            ball:reset()
        end

        if ball.x > DEFAULT_WINDOW_WIDTH then 
            
            leftSidePlayerScore = leftSidePlayerScore + 1
            ball:reset()
        end

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
        ball:update(deltaTime)
    end
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
    push:start()

    love.graphics.setFont(stateFont)

    love.graphics.setColor(0, 255, 0, 255)

    if programState == PAUSED_STATE then 
        love.graphics.printf('Game is paused!', 0, DEFAULT_WINDOW_HEIGHT / 2 - 6, DEFAULT_WINDOW_WIDTH, 'center')
    elseif programState == PLAYING_STATE then
        love.graphics.printf('Game is running!', 0, DEFAULT_WINDOW_HEIGHT / 2 - 6, DEFAULT_WINDOW_WIDTH, 'center')
    end

    -- Check whether any of the players have met the winning condition.
    if leftSidePlayerScore == 10 then
        love.graphics.printf('Left player won!', 0, DEFAULT_WINDOW_HEIGHT / 2 - 6, DEFAULT_WINDOW_WIDTH, 'center')
        love.graphics.printf('Press return to play again!', 0, DEFAULT_WINDOW_HEIGHT / 2 + 135, DEFAULT_WINDOW_WIDTH, 'center')
        programState = VICTORY_STATE
    elseif rightSidePlayerScore == 10 then 
        love.graphics.printf('Right player won!', 0, DEFAULT_WINDOW_HEIGHT / 2 - 6, DEFAULT_WINDOW_WIDTH, 'center')
        love.graphics.printf('Press return to play again!', 0, DEFAULT_WINDOW_HEIGHT / 2 + 135, DEFAULT_WINDOW_WIDTH, 'center')
        programState = VICTORY_STATE
    end


    -- Draw the paddles to the screen in their current state.
    leftSidePlayer:draw()
    rightSidePlayer:draw()

    -- Draw the ball to the screen in its current state.
    ball:draw()

    -- Invoke the helper method which will draw to the screen the diveder blocks.
    drawDivider()

    -- Invoke the helper method which will collate to the screen the current score of each player.
    displayScores()

    -- Invoke the helper method which will collate to the screen the current value of the FPS attribute.
    displayFPS()

    -- End rendering.
    push:finish()
end

function love.resize(weight, height)
    push:resize(weight, height)
end


--[[

    @author Andrei-Paul Ionescu.
]]
function displayScores()
    displayScore(leftSidePlayerScore, 'left')
    displayScore(rightSidePlayerScore, 'right')
end
--[[
    This here method is yet another auxiliary/helper routine whose sole role is to refactor some 
    of the logic so as to obtain a clearer compilation unit.

    The role of this method is to draw the dividers that separate the two portions of the court.
    These diveders are plain rectangles separated by spaces from one another.

    @author Andrei-Paul Ionescu.
]]
function drawDivider()

    local gap = 80
    local yValue = 0

    while(yValue < DEFAULT_WINDOW_HEIGHT)
    do       
        love.graphics.rectangle('fill', DEFAULT_WINDOW_WIDTH/2 - 20, yValue, 40, 80)
        yValue = yValue + 80 + gap
    end

end

--[[
    @param score; a numerical integer value which indicates the score of the player.
    @param player; a string literal value which can either be 'left', or 'right' which indicates which 
                   player's score we ought to modify.

    This here routine is responsible for drawing the score of one of the players.
    The player for which we want to draw the score is indicated with the aid of the second 
    formal argument of the method.

    @author Andrei-Paul Ionescu.
]]
function displayScore(score, player)
    -- Set the current rendering font to be the font defined in the scoreFont variable.
    love.graphics.setFont(scoreFont)
    
    -- Determine for which player we are going to print the score.
    if player == 'left' then 
        love.graphics.print(tostring(score), 
        DEFAULT_WINDOW_WIDTH / 4, DEFAULT_WINDOW_HEIGHT / 2 - 160)
    elseif player == 'right' then
        love.graphics.print(tostring(score), 
        DEFAULT_WINDOW_WIDTH / 4 + DEFAULT_WINDOW_WIDTH / 2 - 50, DEFAULT_WINDOW_HEIGHT / 2 - 160 )
    end
end
--[[
    This here routine draws the current value of the FPS attribute in the left up corner of the screen.

    @author Andrei-Paul Ionescu.
]]
function displayFPS()
    love.graphics.setFont(smallSizeFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end