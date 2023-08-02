Player = Class {
    __includes = BaseState
}
local rotationAngle = 0

function Player:init()

    self.width = 65
    self.height = 90
    self.x = WINDOW_WIDTH / 2 - self.width / 2
    self.y = WINDOW_HEIGHT - self.height
    self.speed = 400

    self.animation = animations.player_idle

    self.Many_Bullets = {}
    self.bullet_image = love.graphics.newImage('sprites/blt.png')

    self.exp1 = love.graphics.newImage('sprites/exp1.png')

    self.shot = love.audio.newSource('music/shot.mp3', 'static')
    self.shot:setVolume(0.05)

    self.health_bar_x = self.x - 65 / 2
    self.health_bar_y = self.y - 10
    self.health_bar_width = 135

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

    rotationAngle = rotationAngle + 100 * dt
    --- Player Movements -- 

    psystem:update(dt)
    psystem:emit(200)

    if love.keyboard.isDown('up') then
        self.y = math.max(0, self.y - self.speed * dt)
    end

    if love.keyboard.isDown('down') then
        self.y = math.min(WINDOW_HEIGHT - self.height, self.y + self.speed * dt)
    end

    if love.keyboard.isDown('left') then
        self.x = math.max(0, self.x - self.speed * dt)
    end

    if love.keyboard.isDown('right') then
        self.x = math.min(WINDOW_WIDTH - self.width, self.x + self.speed * dt)
    end

    if love.keyboard.wasPressed('space') then
        table.insert(self.Many_Bullets, self:CreateBullets())
        self.shot:stop()
        self.shot:play()

    end

    -- Bullets Movements -- 
    for keys, values in pairs(self.Many_Bullets) do

        values.y = values.y - values.speed * dt
        --- deletion as they cross screen
        if values.y < -values.height then
            table.remove(self.Many_Bullets, keys)
        end
    end

    self.health_bar_x = self.x - 65 / 2
    self.health_bar_y = self.y - 10

    self.health_bar_width = math.max(0, self.health_bar_width)

    -- self.health_bar_width=self.health_bar_width-dt

    --  player.animation:update(dt)
    self.animation:update(dt)

end

function Player:CreateBullets()
    local Bullet = {}
    Bullet.width = 10
    Bullet.height = 17
    Bullet.y = self.y
    Bullet.x = self.x + (self.width / 2) - (Bullet.width / 2)
    Bullet.speed = 1200
    return Bullet
end

function Player:render()

    -- Bullets render

    for keys, values in pairs(self.Many_Bullets) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.bullet_image, values.x, values.y)
    end

    love.graphics.setColor(0, 1, 0)

    love.graphics.setLineWidth(2)

    love.graphics.rectangle("fill", 1100, 100, self.health_bar_width, 7)
    love.graphics.rectangle("line", 1100, 100, 135, 7)

    love.graphics.print("Health", 1100, 130)

    love.graphics.setColor(1, 1, 1)

    if self.health_bar_width > 0 then
        --love.graphics.rectangle("line", self.x,self.y,self.width,self.height)
        self.animation:draw(sprites.playerSheet, self.x + self.width / 2, self.y + self.height / 2, math.rad(0), 1, 1,
            self.width / 2, self.height / 2)
        love.graphics.draw(psystem, self.x + 20, self.y + self.height)
        love.graphics.draw(psystem, self.x + self.width - 20, self.y + self.height)
    else
        love.graphics.draw(self.exp1, self.x + self.width / 2, self.y)
    end

end

