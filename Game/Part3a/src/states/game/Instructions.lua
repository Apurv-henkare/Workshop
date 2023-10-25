Instructions = Class {
    __includes = BaseState
}

function Instructions:init()
    --self.control = love.graphics.newImage('sprites/control.jpg')
end

function Instructions:update(dt)

    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end

end

function Instructions:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("End State",100,100)
   -- love.graphics.draw(self.control, 0, 0)
    -- love.graphics.print("Hello guys testing",200,200)
end
