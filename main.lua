-- Global variable  used to keep track of level as well--
counter_var = 0

require 'src/Dependencies'

shake_duration = 0.5
shake_intensity = 10
shake_timer = 0
shake_offset_x, shake_offset_y = 0, 0

-- Global variables--

function love.load()

    love.window.setTitle('Cave_Exploration')

    --[[ 
       random function is human made, we observe the same pattern again and again.
       so we randomise with respect to time
    ]]
    math.randomseed(os.time())

    camera = Camera()

    -- init -> screen generation--
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false,
    })

    -- load images and animation--
    sprites = {}
    sprites.playerSheet = love.graphics.newImage('sprites/player.png')
    sprites.enemySheet = love.graphics.newImage('sprites/a1.png')
    sprites.bossSheet = love.graphics.newImage('sprites/ship01.png')

    enemygrid = anim8.newGrid(60, 60, sprites.enemySheet:getWidth(), sprites.enemySheet:getHeight())
    playergrid = anim8.newGrid(65, 90, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())
    bossgrid = anim8.newGrid(100, 138, sprites.bossSheet:getWidth(), sprites.bossSheet:getHeight())

    animations = {}
    animations.player_idle = anim8.newAnimation(playergrid('1-2', 1), 0.3)
    animations.idle = anim8.newAnimation(enemygrid('1-1', 1), 0.3)
    animations.boss = anim8.newAnimation(bossgrid('1-2', 1), 0.3)

    -- load music--
    song = love.audio.newSource('music/background_music.mp3', 'stream')
    song:setVolume(0.1)

    song:setLooping(true)
    song:play()

    -- keep track of keypressed
    love.keyboard.keysPressed = {}
    gStateStack = StateStack()
    gStateStack:push(MainMenu())

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    
    if key  == 'f' then 
        shake_timer = shake_duration
    end 
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)

    camera:lookAt(love.graphics.getWidth() / 2,love.graphics.getHeight() / 2)

    if shake_timer > 0 then
        shake_timer = math.max(0,shake_timer - dt)
        shake_offset_x = love.math.random(-shake_intensity, shake_intensity)
        shake_offset_y = love.math.random(-shake_intensity, shake_intensity)
    else 
        shake_offset_x, shake_offset_y = 0, 0
      
    end

    Timer.update(dt)
    gStateStack:update(dt)

    --print(#gStateStack.states,counter_var)

    love.keyboard.keysPressed = {}
end

-- Distance function
function Distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

-- collision conditions, if overlap happens then collision is true --
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

-- Rendering everything in the statestack
function love.draw()
    push:start()
 
    gStateStack:render()
  
    push:finish()
end
