
require 'src/Dependencies'


function love.load()
    -- init -> screen generation--
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
    })

    math.randomseed(os.time())
    print(os.time())

      -- keep track of keypressed
    
    love.keyboard.keysPressed={}

    gStateStack = StateStack()
    gStateStack:push(MainMenu())

   
end

function love.update(dt)
    gStateStack:update(dt)
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

function love.draw()

    push:start()

    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)  
    gStateStack:render()
    push:finish()

end 



