Player = Class {
    __includes = BaseState
}

function Player:init()

    self.width = 60
    self.height = 60
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT - self.height;
    self.speed = 200

    self.Many_Bullets = {}

end

function Player:update(dt)

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
    love.graphics.setColor(1, 0.3, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- bullet render 

    for key, value in pairs(self.Many_Bullets) do
        love.graphics.setColor(0, 0.8, 0)
        love.graphics.rectangle("fill", value.x, value.y, value.width, value.height)
    end
end
