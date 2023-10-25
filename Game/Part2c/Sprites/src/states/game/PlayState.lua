PlayState = Class {
    __includes = BaseState
}

function PlayState:init()

    --self.image = love.graphics.newImage('sprites/credits.jpg')
    self.player = Player()
end

function PlayState:update(dt)

    
    self.player:update(dt)

    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end

end

function PlayState:render()

    self.player:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Play State",100,100)
    --love.graphics.draw(self.image, 0, 0)

end
