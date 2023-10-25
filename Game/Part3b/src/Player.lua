Player = Class {
    __includes = BaseState
}

function Player:init()

    self.width = 65
    self.height = 90
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT - self.height;
    self.speed = 400

    self.health_bar_x = self.x - 65 / 2
    self.health_bar_y = self.y - 10
    self.health_bar_width = 135

    self.Many_Bullets = {}

    
    self.exp1 = love.graphics.newImage('sprites/EXP1.png')
    self.bullet_image = love.graphics.newImage('sprites/blt.png')

    self.shot = love.audio.newSource('music/shot.mp3', 'static')
    self.shot:setVolume(0.05)

    self.animation = animations.player_idle
    self.img = love.graphics.newImage('sprites/part.png')

    psystem = love.graphics.newParticleSystem(self.img, 2000)

    -- lasts between 0.5-1 seconds seconds
    psystem:setParticleLifetime(0.4, 0.2)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward
    psystem:setLinearAcceleration(-60, 20, 60, 800)

    psystem:emit(200)

end

function Player:update(dt)

    
    psystem:update(dt)
    psystem:emit(200)

    -- Movement
    if love.keyboard.isDown("right") then
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.speed * dt)
    end

    if love.keyboard.isDown("left") then
        self.x = math.max(0, self.x - self.speed * dt)
    end

    if love.keyboard.isDown("up") then
        self.y = math.max(0, self.y - self.speed * dt)
    end

    if love.keyboard.isDown("down") then
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.speed * dt)
    end

    if love.keyboard.wasPressed("space") then
        self:CreateBullet()
        self.shot:stop()
        self.shot:play()
    end

    -- Bullet movement 

    for key, value in pairs(self.Many_Bullets) do
        value.y = value.y - value.speed * dt
    end

    -- delete Bullet 

    for key, value in pairs(self.Many_Bullets) do
        if value.y < -value.height then
            table.remove(self.Many_Bullets, key)
        end
    end

    self.health_bar_x = self.x - 65 / 2
    self.health_bar_y = self.y - 10

    self.health_bar_width = math.max(0, self.health_bar_width)

    self.animation:update(dt)

end

function Player:CreateBullet()
    local Bullet = {}
    Bullet.width = 10
    Bullet.height = 10
    Bullet.x = self.x + self.width / 2 - Bullet.width / 2
    Bullet.y = self.y - Bullet.height
    Bullet.speed = 600

    table.insert(self.Many_Bullets, Bullet)
end

function Player:render()

    -- Bullets render

    for keys, values in ipairs(self.Many_Bullets) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.bullet_image, values.x, values.y)
        -- love.graphics.rectangle("line",values.x,values.y,values.width,values.height)

    end

    love.graphics.rectangle("fill", self.x, self.y, 2, 2)

    love.graphics.setColor(0, 1, 0)

    --love.graphics.setLineWidth(2)

    love.graphics.rectangle("fill", 1100, 100, self.health_bar_width, 7)
    love.graphics.rectangle("line", 1100, 100, 135, 7)

    love.graphics.print("Health", 1100, 130)

    love.graphics.setColor(1, 1, 1)

    -- camera:attach()

    --camera:move(shake_offset_x, shake_offset_y)

    if shake_timer > 0 or self.health_bar_width < 25 then
        love.graphics.setColor(1, 0.5, 0)
    else
        love.graphics.setColor(1, 1, 1)
    end

    if self.health_bar_width > 0 then
        -- love.graphics.rectangle("line", self.x,self.y,self.width,self.height)
        self.animation:draw(sprites.playerSheet, self.x+shake_offset_x, self.y+shake_offset_y, math.rad(0), 1, 1)
        love.graphics.draw(psystem, self.x + 20+shake_offset_x, self.y + self.height+shake_offset_y)
        love.graphics.draw(psystem, self.x + self.width - 20+shake_offset_x, self.y + self.height+shake_offset_y)
    else
        love.graphics.draw(self.exp1, self.x + self.width / 2, self.y)
    end

end
