PlayState = Class {
    __includes = BaseState
}

-- local y = 0;
-- local by = 0

function PlayState:init()

    self.bg1 = 0
    self.bg2 = 0

    self.player = Player()
    self.enemies = Enemies()

    self.angle=0
    self.bg_image = love.graphics.newImage('sprites/bg5.jpg')
    self.bg2_image = love.graphics.newImage('sprites/planet.png')

    self.enemy_shot = love.audio.newSource('music/enemy_shot.wav', 'static')
    self.enemy_shot:setVolume(0.08)

    self.store = {}

    -- to keep track of active enemies that can fire--
    for j = 1, 6 do
        for i = 1, 21 do
            local squard1 = {}
            squard1.x = (i - 1) * 60
            squard1.y = (j) * 60 - 1000
            squard1.speed = 200
            squard1.width = 60
            squard1.type="alien"
            squard1.height = 60

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

    --print(counter_var)

    -- game over condition--
    if self.player.health_bar_width <= 0 then
        self.enemies.exp:stop()
        self.enemies.exp:play()
        gStateStack:push(GameOver())
    end

    --- parallax effect background
    self.bg1 = (self.bg1 + 10 * dt) % (2560 + 500)
    self.bg2 = (self.bg2 + 40 * dt) % 6000

    -- varies the attack/bullet patterns of the enemies~Level-2--
    local arr = {0.001, 0.005, 0.009, 0.08, 0.02, 0.1}

    for k, v in pairs(self.enemies.Many_Enemies) do

      

        if counter_var == 2 and v.fire == 1 then

            if math.random() < arr[math.random(1, 3)] then
                self.enemy_shot:stop()
                self.enemy_shot:play()
                table.insert(self.enemies.Many_b, self.enemies:CreateAlienBullet(v, self.player))
            end

        elseif counter_var == 3 then


            local array = {300, 200, 100, 190, 290, 150}
            local array_speed = {100, 150, 200, 250, 300, 350}

            if v.x <= -100 then

                v.dir = v.dir * -1
                v.speed = array_speed[math.random(1, 6)] * v.dir
                v.y = array[math.random(1, 6)]

            elseif v.x >= 1280 then

                v.dir = v.dir * -1
                v.speed = array_speed[math.random(1, 6)] * v.dir
                v.y = array[math.random(1, 6)]

            end

          --  print(v.dir,"hello",#gStateStack)

            if v.dir == -1 then
            
                v.x = math.max(-100, v.x + v.speed * dt)
            else
             
                v.x = math.min(1280,v.x + v.speed * dt)
                
            end

            if math.random() < arr[math.random(1, 6)] then
                self.enemy_shot:stop()
                self.enemy_shot:play()
                table.insert(self.enemies.Many_b, self.enemies:CreateAlienBullet(v, self.player))
            end
        end

        -- end
    end

    -- Detection logic for player and enemies --
    for i, _bullet in pairs(self.player.Many_Bullets) do
        for j, _enemy in pairs(self.enemies.Many_Enemies) do
            if checkCollision(_bullet.x, _bullet.y, _bullet.width, _bullet.height, _enemy.x, _enemy.y, _enemy.width,
                _enemy.height) then

                self.enemies.exp:stop()
                self.enemies.exp:play()

                self.enemies:ParticleSystem(_enemy.x + _enemy.width / 2, _enemy.y + _enemy.height / 2)

                _enemy.health = _enemy.health - 1
                print(_enemy.health)

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

    -- !!Change the variable "Many_b" name 

    -- This for loop detetc enemy bullet and player collision
    for key, _bullet in pairs(self.enemies.Many_b) do
        if checkCollision(_bullet.x, _bullet.y, _bullet.width, _bullet.height, self.player.x, self.player.y,
            self.player.width, self.player.height) then

            table.remove(self.enemies.Many_b, key)
            self.player.health_bar_width = self.player.health_bar_width - 1
            break
        end
    end
     
  

    ---- Collision between Enemies and Player
    for i, _enemy in pairs(self.enemies.Many_Enemies) do

        if checkCollision(_enemy.x, _enemy.y, _enemy.width, _enemy.height, self.player.x, self.player.y,
            self.player.width, self.player.height) then

            self.enemies:ParticleSystem(_enemy.x + _enemy.width / 2, _enemy.y + _enemy.height / 2)
            table.remove(self.enemies.Many_Enemies, i)

            if _enemy.type == "alien" or _enemy.type == "boss" then
                self.enemies.exp:stop()
            self.enemies.exp:play()
            gStateStack:push(GameOver())
                
            else 
                self.player.health_bar_width = self.player.health_bar_width - 15 * (_enemy.width / 40)
            end 

            break
        end

    end

    -- to update the status of fire in Many_Enemies table
    for j, _enemy in pairs(self.enemies.Many_Enemies) do

        for i, v in pairs(self.store) do
            if _enemy.ix == v.ix and _enemy.iy == v.iy then
                _enemy.fire = 1
            end
        end
    end

end

function PlayState:render()
    love.graphics.draw(self.bg_image, 0, -2560 + self.bg1, nil, 1, 1)
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(self.bg2_image, 0, -4000 + self.bg2, nil, 1, 1)
    love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.print(self.enemies.Many_Enemies[1].x)
    self.enemies:render()
    self.player:render()

end

