End = Class {
    __includes = BaseState
}

function End:init()
    self.exit_image = love.graphics.newImage('sprites/end.jpg')
end

function End:update(dt)

    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end

end

function End:render()
   
   love.graphics.print("End State",100,100)
    love.graphics.draw(self.exit_image, 0, 0)
end
