push= require 'lib/push'

--constant--
VIRTUAL_WIDTH,VIRTUAL_HEIGHT=800,750
WINDOW_WIDTH,WINDOW_HEIGHT=1200,750

--player 

local player={}
player.width=60
player.height=60
player.x=VIRTUAL_WIDTH/2-player.width/2
player.y=VIRTUAL_HEIGHT-player.height;
player.speed=200

function love.load()
    -- init -> screen generation--
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
    })
end


function love.update(dt)

    if love.keyboard.isDown("right") then 
        player.x=math.min(VIRTUAL_WIDTH-player.width,player.x+player.speed*dt) 
    end

    if love.keyboard.isDown("left") then 
        player.x=math.max(0,player.x-player.speed*dt) 
    end

    if love.keyboard.isDown("up") then 
        player.y=math.max(0,player.y-player.speed*dt) 
    end

    if love.keyboard.isDown("down") then 
        player.y=math.min(VIRTUAL_HEIGHT-player.height,player.y+player.speed*dt) 
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end



function love.draw()
    push:start()
    
    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)

    love.graphics.setColor(1,0.3,0)
    love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)

    love.graphics.print(math.floor(player.x).."  "..math.floor(player.y),100,100)
    
    push:finish()
end 