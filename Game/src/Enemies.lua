Enemies = Class {
    __includes = BaseState
}

local size_array = {50, 40, 60, 80, 120}
local rotationAngle = 0
local particles = {}

function Enemies:init()

    self.Many_Enemies = {}

    -- change name
    self.Many_b = {}

    self.animation = animations.idle
    self.boss = animations.boss

    self.particleImage = love.graphics.newImage("sprites/part.png")
    self.image = love.graphics.newImage("sprites/alien01.png")
    self.enemy_bullet_image = love.graphics.newImage("sprites/blt2.png")

    self.exp = love.audio.newSource('music/exp.wav', 'static')
    self.exp:setVolume(0.3)

    self.timer = 0
    self.shift = 1
    self.shift1 = 0

    self.shift2 = 0
    self.speed = 200


    self.level_completed=false
    self.flag=0

    self.Aliens = {}
    self.Aliens1 = {}
    self.Aliens2 = {}

    for j = 1, 6 do

        for i = 1, 21 do
            local squard1 = {}
            squard1.x = (i - 1) * 60
            squard1.y = (j) * 60 - 1000
            squard1.speed = 200
            squard1.width = 60
            squard1.height = 60
            squard1.health = 0
            squard1.dir = 1
            squard1.type = "alien"
            squard1.ix = i
            squard1.iy = j

            if j == 6 then
                squard1.fire = 1
            else
                squard1.fire = 0
            end
            io.write(squard1.ix, squard1.iy, " ")
            table.insert(self.Aliens, squard1)
        end
        --print()
    end

    -- self.Collection={self.Aliens,self.Aliens1}
    self.Collection_index = 1;

end

function Enemies:update(dt)

    rotationAngle=(rotationAngle+100*dt)%360

    if counter_var == 1 then
        if self.timer >= 0.09 then
            self.flag =1
        else
            self.timer = math.min(0.09, self.timer + 0.001 * dt)

            if math.random() < self.timer then
                table.insert(self.Many_Enemies, self:CreateEnemy())
            end
        end

    elseif counter_var == 2 and self.flag == 0 then
        self.Many_Enemies = self.Aliens
        self.flag=1
        --counter_var = 3

    elseif counter_var == 3 and self.flag == 0  then
        self.flag=1
        self.Many_Enemies = {{
            x = 300,
            y = 130,
            width = 100,
            height = 130,
            speed = 300,
            ix = -1000,
            iy = -1000,
            fire = 1,
            type = "boss",
            health = 80,
            dir = 1
        }}

    
    end

    ---change state 

    if self.flag == 1 and #self.Many_Enemies == 0 then
        self.flag=0
        gStateStack:push(Di())
    end 
 

    if counter_var == 2 then
        self.shift1 = math.min(1000, self.shift1 + self.speed * dt)
    end 


    for i, enemy in pairs(self.Many_Enemies) do

        if counter_var == 2 then

            if self.shift1 < 1000 then
                enemy.y = enemy.y + enemy.speed * dt
            end

        elseif counter_var == 1 then
            enemy.y = enemy.y + enemy.speed * dt
            enemy.speed = enemy.speed + 900 * dt
        end

        if counter_var == 1 then
            -- Check for collision with other enemies
            for j, otherEnemy in pairs(self.Many_Enemies) do
                if i ~= j and
                    checkCollision(enemy.x, enemy.y, enemy.width, enemy.height, otherEnemy.x, otherEnemy.y,
                        otherEnemy.width, otherEnemy.height) then
                    self.exp:stop()
                    self.exp:play()
                    self:ParticleSystem(enemy.x + enemy.width / 2, enemy.y + enemy.height / 2)
                    table.remove(self.Many_Enemies, i)
                    table.remove(self.Many_Enemies, j)

                end
            end
        end

        if enemy.y > 720 then
            table.remove(self.Many_Enemies, i)
        end
    end

    for key, values in pairs(particles) do

        if values.yp > 0 and counter_var <= 1 then
            values.yp = values.yp + 200 * dt
        end

    end

    for i = #particles, 1, -1 do
        local particleSystem = particles[i].p
        particleSystem:update(dt)
        if particleSystem:getCount() == 0 then
            table.remove(particles, i)
        end
    end

    self.animation:update(dt)
    self.boss:update(dt)

end

function Enemies:ParticleSystem(x, y)

    local psystem = love.graphics.newParticleSystem(sprites.enemySheet, 2000)

    -- lasts between 0.5-1 seconds seconds
    psystem:setParticleLifetime(1, 1.5)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward
    psystem:setLinearAcceleration(-550, -500, 550, 700)

    psystem:emit(200)

    table.insert(particles, {
        xp = x,
        yp = y,
        p = psystem
    })

end

function Enemies:CreateEnemy()

    local Enemy = {}
    local index = math.random(1, 5)
    Enemy.width = size_array[index]
    Enemy.height = size_array[index]
    Enemy.x = math.random(0, WINDOW_WIDTH - Enemy.width)
    Enemy.y = math.random(-150, -130)
    Enemy.ix = -1000
    Enemy.iy = -1000
    Enemy.health = 0
    Enemy.type = "Asteriod"
    Enemy.fire = -1
    Enemy.dir = 1
    Enemy.speed = math.random(80, 950)
    Enemy.col = false
    Enemy.rotate = math.random(10, 400)
    return Enemy

end

function Enemies:CreateAlienBullet(enemy, player)
    local Bullet = {}
    Bullet.width = 10
    Bullet.height = 10
    Bullet.y = enemy.y+enemy.height
    Bullet.x = enemy.x + (enemy.width / 2) - (Bullet.width / 2)
    Bullet.speed = 400

    Bullet.py= player.y
    Bullet.px= player.x 

    Bullet.ey= enemy.y
    Bullet.ex= enemy.x 


    Bullet.angle =  math.atan2((player.y - (player.height / 2)) - enemy.y, (player.x -(player.width / 2)) - enemy.x)
    return Bullet
end

function Enemies:render()
    love.graphics.setColor(0, 1, 1)

    for keys, values in pairs(self.Many_b) do
        love.graphics.draw(self.enemy_bullet_image, values.x, values.y)
    end

    for keys, values in pairs(self.Many_Enemies) do
        love.graphics.setColor(1, 1, 1)

        love.graphics.setColor(1, 1, 1)

        if counter_var == 1 then
            self.animation:draw(sprites.enemySheet, values.x + values.width / 2, values.y + values.height / 2,
                math.rad(rotationAngle), 1 * values.width / 60, values.height / 60,
                (values.width / (2 * values.width / 60)), (values.width / (2 * values.width / 60)))

        else

            if counter_var == 3 then

                love.graphics.setColor(1, 0, 0)

                love.graphics.setLineWidth(2)
                love.graphics.rectangle('line', values.x - 25, values.y - 20, (80 * 150 / 80), 10)
                love.graphics.rectangle('fill', values.x - 25, values.y - 20, (values.health * 150 / 80), 10)

                love.graphics.setColor(1, 1, 1)
                self.boss:draw(sprites.bossSheet, values.x + 50, values.y + 65, 0, -1, -1, 100 / 2, 130 / 2)
            else

                if counter_var == 2  then
                    love.graphics.draw(self.image, values.x, values.y)
                end
            end

            if values.fire == 1 then
                love.graphics.setColor(0, 1, 1)

            else
                love.graphics.setColor(1, 1, 1)

            end
        end
    end

    -- Draw particles
    for _, pp in pairs(particles) do

        if counter_var == 1 then
            love.graphics.setColor(1, 0.8, 0)
        else
            love.graphics.setColor(0, 0.8, 1)
        end
        love.graphics.draw(pp.p, pp.xp, pp.yp, nil, 10 / 60, 5 / 60)
    end

end
