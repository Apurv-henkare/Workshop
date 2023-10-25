
require 'src/Dependencies'


shake_duration = 0.5
shake_intensity = 10
shake_timer = 0
shake_offset_x, shake_offset_y = 0, 0


function love.load()
    -- init -> screen generation--
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
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

    math.randomseed(os.time())
    print(os.time())

      -- keep track of keypressed
    
    love.keyboard.keysPressed={}

    gStateStack = StateStack()
    gStateStack:push(MainMenu(),{level=0})

    print("helloo LuaJIT "..jit.version)

   
end

function love.update(dt)

    if shake_timer > 0 then
        shake_timer = math.max(0,shake_timer - dt)
        shake_offset_x = love.math.random(-shake_intensity, shake_intensity)
        shake_offset_y = love.math.random(-shake_intensity, shake_intensity)
    else 
        shake_offset_x, shake_offset_y = 0, 0
      
    end

    
    gStateStack:update(dt)

    print(gStateStack:Info())
    love.keyboard.keysPressed={}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

-- collision conditions, if overlap happens then collision is true --
function checkCollision(obj1,obj2)
    return obj1.x < obj2.x + obj2.width and 
           obj2.x < obj1.x + obj1.width and 
           obj1.y < obj2.y + obj2.height and 
           obj2.y < obj1.y + obj1.height    
end

function love.draw()

    push:start()

   -- love.graphics.setColor(0.1,0.1,0.1)
    --love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)  
    gStateStack:render()
    push:finish()

end 



