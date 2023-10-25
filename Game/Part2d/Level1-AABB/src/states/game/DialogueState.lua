DialogueState = Class {
    __includes = BaseState
}

function DialogueState:init()
    glevel=glevel+1

    -- self.image = love.graphics.newImage('sprites/credits.jpg')
end

function DialogueState:update(dt)

    if love.keyboard.wasPressed('return') then
        gStateStack:pop()

    end

end

function DialogueState:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Dialogue State", 300, 100)
    -- love.graphics.draw(self.image, 0, 0)

end
