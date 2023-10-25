PlayState = Class {
    __includes = BaseState
}

-- varies the attack/bullet patterns of the enemies~Level-2--
local arr = {0.001, 0.005, 0.009, 0.08, 0.1, 0.39}

function PlayState:init()
    -- self.image = love.graphics.newImage('sprites/credits.jpg')
    self.player = Player()
    self.enemies = Enemies()

    self.bg_image = love.graphics.newImage('sprites/bg5.jpg')
    self.bg2_image = love.graphics.newImage('sprites/planet.png')

    self.bg1 = 0
    self.bg2 = 0

    self.store = {}

    -- to keep track of active enemies that can fire--
    for j = 1, 6 do
        for i = 1, 21 do
            local squard1 = {}
            squard1.ix = i
            squard1.iy = j

            if j == 6 then
                squard1.fire = 1
                table.insert(self.store, {
                    ix = squard1.ix,
                    iy = squard1.iy
                })
            else
                squard1.fire = 0
            end
        end
    end

end

function PlayState:update(dt)

    self.player:update(dt)
    self.enemies:update(dt)

    --- parallax effect background
    self.bg1 = (self.bg1 + 10 * dt) % (2560 + 500)
    self.bg2 = (self.bg2 + 40 * dt) % 6000

    -- game over condition--
    if self.player.health_bar_width <= 0 then
        -- self.enemies.exp:stop()
        -- self.enemies.exp:play()
         gStateStack:push(GameOver())
    end

    for k, v in pairs(self.enemies.Many_Enemies) do

        if glevel == 2 and v.fire == 1 then

            if math.random() < arr[math.random(1, 3)] then
                -- self.enemy_shot:stop()
                -- self.enemy_shot:play()
                table.insert(self.enemies.Many_Bullets, self.enemies:CreateAlienBullet(v, self.player))
            end

        elseif glevel == 3 then

            local array = {300, 200, 100, 190, 290, 150}
            local array_speed = {290, 340, 500, 400, 300, 350}

            if v.x <= -100 then

                v.dir = v.dir * -1
                v.speed = array_speed[math.random(1, 6)] * v.dir
                v.y = array[math.random(1, 6)]

            elseif v.x >= 1280 then

                v.dir = v.dir * -1
                v.speed = array_speed[math.random(1, 6)] * v.dir
                v.y = array[math.random(1, 6)]

            end

            if v.dir == -1 then

                v.x = math.max(-100, v.x + v.speed * dt)
            else

                v.x = math.min(1280, v.x + v.speed * dt)

            end

            if math.random() < arr[math.random(1, 6)] then
                -- self.enemy_shot:stop()
                -- self.enemy_shot:play()
                table.insert(self.enemies.Many_Bullets, self.enemies:CreateAlienBullet(v, self.player))
            end

        end
    end

    -- Detection logic for player and enemies --
    for i, _bullet in pairs(self.player.Many_Bullets) do
        for j, _enemy in pairs(self.enemies.Many_Enemies) do
            if checkCollision(_bullet, _enemy) then

                -- self.enemies.exp:stop()
                -- self.enemies.exp:play()

                self.enemies:ParticleSystem(_enemy.x + _enemy.width / 2, _enemy.y + _enemy.height / 2)

                _enemy.health = _enemy.health - 1

                -- print(_enemy.health)

                table.insert(self.store, {
                    ix = _enemy.ix,
                    iy = _enemy.iy - 1
                })

                table.remove(self.player.Many_Bullets, i)
                if (_enemy.health <= 0) then
                    table.remove(self.enemies.Many_Enemies, j)
                end

                break
            end
        end
    end

    --  -- to update the status of fire in Many_Enemies table
    for j, _enemy in pairs(self.enemies.Many_Enemies) do

        for i, v in pairs(self.store) do
            if _enemy.ix == v.ix and _enemy.iy == v.iy then
                _enemy.fire = 1
            end
        end
    end

    -- This for loop detetc enemy bullet and player collision
    for key, _bullet in pairs(self.enemies.Many_Bullets) do

        local angle = math.atan2(self.player.y - _bullet.ey, self.player.x - _bullet.ex)

        _bullet.x = (_bullet.x + 900 * math.cos(_bullet.angle) * dt)
        _bullet.y = (_bullet.y + 900 * math.sin(_bullet.angle) * dt)

        if checkCollision(_bullet, self.player) then

            shake_timer = shake_duration
            table.remove(self.enemies.Many_Bullets, key)
            self.player.health_bar_width = self.player.health_bar_width - 1
            break
        end

    end

    for key, _bullet in pairs(self.enemies.Many_Bullets) do
        if _bullet.y > 720 or _bullet.y < -10 then
            table.remove(self.enemies.Many_Bullets, key)
        end
    end

    ---- Collision between Enemies and Player
    for i, _enemy in pairs(self.enemies.Many_Enemies) do

        if checkCollision(_enemy, self.player) then

            self.enemies:ParticleSystem(_enemy.x + _enemy.width / 2, _enemy.y + _enemy.height / 2)
            table.remove(self.enemies.Many_Enemies, i)

             shake_timer = shake_duration

            if _enemy.type == "alien" or _enemy.type == "boss" then
                -- self.enemies.exp:stop()
                -- self.enemies.exp:play()
                self.player.health_bar_width = 0
                -- gStateStack:push(GameOver())

            else
                self.player.health_bar_width = self.player.health_bar_width - 15 * (_enemy.width / 40)
            end

            break
        end

    end

end

function PlayState:render()

    -- love.graphics.print(self.curr_level, 100, 300)

    love.graphics.draw(self.bg_image, 0, -2560 + self.bg1, nil, 1, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.bg2_image, 0, -4000 + self.bg2, nil, 1, 1)
    self.enemies:render()
    self.player:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Play State", 100, 100)
    love.graphics.setColor(1, 1, 1, 1)

    -- love.graphics.draw(self.image, 0, 0)

end
