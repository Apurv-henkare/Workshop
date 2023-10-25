push = require 'lib/push'

require "Enemies"

-- constant--
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 800, 750
WINDOW_WIDTH, WINDOW_HEIGHT = 1200, 750

-- player 

local player = {}
player.width = 60
player.height = 60
player.x = VIRTUAL_WIDTH / 2 - player.width / 2
player.y = VIRTUAL_HEIGHT - player.height;
player.speed = 200

local Many_Bullets = {}

function love.load()
    -- init -> screen generation--
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    math.randomseed(os.time())
    print(os.time())
end

function love.update(dt)

    Enemies_update(dt)

    -- Movement
    if love.keyboard.isDown("right") then
        player.x = math.min(VIRTUAL_WIDTH - player.width, player.x + player.speed * dt)

    elseif love.keyboard.isDown("left") then
        player.x = math.max(0, player.x - player.speed * dt)

    elseif love.keyboard.isDown("up") then
        player.y = math.max(0, player.y - player.speed * dt)

    elseif love.keyboard.isDown("down") then
        player.y = math.min(VIRTUAL_HEIGHT - player.height, player.y + player.speed * dt)
    end

    -- Bullet movement 

    for key, value in pairs(Many_Bullets) do
        value.y = value.y - value.speed * dt
    end

    -- delete Bullet 

    for key, value in pairs(Many_Bullets) do
        if value.y < -value.height then
            table.remove(Many_Bullets, key)
        end
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then
        CreateBullets()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function CreateBullets()

    local Bullet = {}
    Bullet.width = 10
    Bullet.height = 10
    Bullet.x = player.x + player.width / 2 - Bullet.width / 2
    Bullet.y = player.y - Bullet.height
    Bullet.speed = 600

    table.insert(Many_Bullets, Bullet)
end

function love.draw()

    push:start()

    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 0.3, 0)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    -- bullet render 

    for key, value in pairs(Many_Bullets) do
        love.graphics.setColor(0, 0.8, 0)
        love.graphics.rectangle("fill", value.x, value.y, value.width, value.height)
    end

    love.graphics.print(math.floor(player.x) .. "  " .. math.floor(player.y), 100, 100)

    Enemies_render()

    push:finish()
end
