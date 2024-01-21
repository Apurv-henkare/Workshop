Enemies = Class {
    __includes = BaseState
}

-- local size_array = {50, 40, 60, 80, 120}
local rotationAngle = 0
local particles = {}

function Enemies:init()

    self.Many_Enemies = {}
    self.Many_Bullets = {}
    self.animation = animations.idle

    self.level_obj = Levels()

    self.timer = 0
    self.shift1 = 0

    -- Timer of each level 
    self.level1_timer = 0.09

    self.flag = 0

    self.particleImage = love.graphics.newImage("sprites/part.png")
    self.image = love.graphics.newImage("sprites/alien01.png")
    self.enemy_bullet_image = love.graphics.newImage("sprites/blt2.png")

    self.exp = love.audio.newSource('music/exp.wav', 'static')
    self.exp:setVolume(0.3)


end

function Enemies:update(dt)
    --  print(self.timer)

    if glevel == 1 then

        if self.timer >= self.level1_timer then
            self.flag = 1
        else
            self.timer = math.min(self.level1_timer, self.timer + 0.004*dt)

            if math.random() < self.timer then
                table.insert(self.Many_Enemies, self.level_obj:return_enemy(glevel))
            end
        end

    elseif glevel == 2 and self.flag == 0 then
        self.Many_Enemies = self.level_obj:return_enemy(glevel)
        self.animation=animations.idle
        self.flag = 1
    elseif glevel == 3 and self.flag == 0  then 
        self.Many_Enemies = self.level_obj:return_enemy(glevel)
        self.animation=animations.boss
        self.flag = 1
    end



    -- if self.flag == 1 and #self.Many_Enemies == 0 then
    --     self.flag = 0
    --     gStateStack:push(DialogueState())
    -- end

    if glevel == 2 then
        self.shift1 = math.min(1000, self.shift1 + 200 * dt)
    end

    for i, enemy in pairs(self.Many_Enemies) do

        if glevel == 2 then

            if self.shift1 < 1000 then
                enemy.y = enemy.y + enemy.speed * dt
            end

        elseif glevel == 1 then
            enemy.y = enemy.y + enemy.speed * dt
            --enemy.speed = enemy.speed + 900 * dt
        end

        if glevel == 1 then
            -- Check for collision with other enemies
            for j, otherEnemy in pairs(self.Many_Enemies) do
                if i ~= j and checkCollision(enemy, otherEnemy) then
                    self:ParticleSystem(enemy.x + enemy.width / 2, enemy.y + enemy.height / 2)
                    self.exp:stop()
                    self.exp:play()
                    table.remove(self.Many_Enemies, i)
                    table.remove(self.Many_Enemies, j)

                end
            end
        end

        if enemy.y > 800 then
            table.remove(self.Many_Enemies, i)
        end

    end

    for key, values in pairs(particles) do

        if values.yp > 0 and glevel <= 1 then
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

end

function Enemies:ParticleSystem(x, y)

    local psystem = love.graphics.newParticleSystem(sprites.enemySheet, 2000)

    -- lasts between 0.5-1 seconds seconds
    psystem:setParticleLifetime(0.5, 1)

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

    -- if player and enemy and player.x ~= enemy.x then
        Bullet.angle = math.atan2((player.y+player.width/2)  - Bullet.y, player.x - Bullet.x)
    -- else
    --     Bullet.angle = 0 -- Default angle (you can change this if needed)
    -- end 

    
    return Bullet
end

function Enemies:render()

    love.graphics.setColor(0, 1, 1)

    for keys, values in pairs(self.Many_Bullets) do
        love.graphics.draw(self.enemy_bullet_image, values.x, values.y)
    end

    love.graphics.setColor(1, 1, 1)

    for key, values in pairs(self.Many_Enemies) do

        if glevel == 1 then

           -- love.graphics.rectangle('line',values.x,values.y,values.width,values.height)
            self.animation:draw(sprites.enemySheet, values.x + values.width / 2, values.y + values.height / 2,
            math.rad(0), 1 * values.width / 60, values.height / 60,
            (values.width / (2 * values.width / 60)), (values.width / (2 * values.width / 60)))

        else

            if glevel == 3 then

                love.graphics.setColor(1, 0, 0)

                love.graphics.setLineWidth(2)
                love.graphics.rectangle('line', values.x - 25, values.y - 20, (80 * 150 / 80), 10)
                love.graphics.rectangle('fill', values.x - 25, values.y - 20, (values.health * 150 / 80), 10)

                love.graphics.setColor(1, 1, 1)
                self.animation:draw(sprites.bossSheet, values.x + 50, values.y + 65, 0, -1, -1, 100 / 2, 130 / 2)
            else


                if glevel == 2 then

                    if values.fire == 0 then
                        love.graphics.setColor(1, 1, 1)
                    else
        
                        love.graphics.setColor(1, 0, 1)
                    end
                
                    love.graphics.draw(self.image, values.x, values.y)
                end
            end


        end
    end

     -- Draw particles
     for _, pp in pairs(particles) do

        if glevel == 1 then
            love.graphics.setColor(1, 0.8, 0)
        else
            love.graphics.setColor(0, 0.8, 1)
        end
        love.graphics.draw(pp.p, pp.xp, pp.yp, nil, 10 / 60, 5 / 60)
    end

end
