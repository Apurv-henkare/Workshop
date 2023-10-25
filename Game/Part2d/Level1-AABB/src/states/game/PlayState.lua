PlayState = Class {
    __includes = BaseState
}



function PlayState:init()
    -- self.image = love.graphics.newImage('sprites/credits.jpg')
    self.player = Player()
    self.enemies = Enemies()

    self.bg_image = love.graphics.newImage('sprites/bg5.jpg')
    self.bg2_image = love.graphics.newImage('sprites/planet.png')

    self.bg1=0
    self.bg2=0
end

function PlayState:update(dt)

    self.player:update(dt)
    self.enemies:update(dt)

    --- parallax effect background
    self.bg1 = (self.bg1 + 10 * dt) % (2560 + 500)
    self.bg2 = (self.bg2 + 40 * dt) % 6000

    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end

    -- Detection logic for player and enemies --
    for i, _bullet in pairs(self.player.Many_Bullets) do
        for j, _enemy in pairs(self.enemies.Many_Enemies) do
            if checkCollision(_bullet, _enemy) then

                -- self.enemies.exp:stop()
                -- self.enemies.exp:play()

                -- self.enemies:ParticleSystem(_enemy.x + _enemy.width / 2, _enemy.y + _enemy.height / 2)

                _enemy.health = _enemy.health - 1

                -- print(_enemy.health)

                -- table.insert(self.store, {
                --     ix = _enemy.ix,
                --     iy = _enemy.iy - 1
                -- })

                table.remove(self.player.Many_Bullets, i)
                if (_enemy.health <= 0) then
                    table.remove(self.enemies.Many_Enemies, j)
                end

                break
            end
        end
    end

end

function PlayState:render()

    --love.graphics.print(self.curr_level, 100, 300)

    love.graphics.draw(self.bg_image, 0, -2560 + self.bg1, nil, 1, 1)
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(self.bg2_image, 0, -4000 + self.bg2, nil, 1, 1)
    self.enemies:render()
    self.player:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Play State", 100, 100)
    love.graphics.setColor(1, 1, 1, 1)

    -- love.graphics.draw(self.image, 0, 0)

end
