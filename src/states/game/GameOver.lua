GameOver = Class {
    __includes = BaseState
}

local store_y = 100
function GameOver:init()


    counter_var=-1

    self.text2 = {
        [0] = {"Captain Apurv, we regret to inform you that :(", "the Vajra has been lost in the battle.", "\n",
               "Our thoughts are with you and we will come back Strong", "\n", "Mission failed."}
    }
    self.currentText2 = ""
    self.currentIndex2 = 1
    self.timer2 = 0
    self.typingSpeed2 = 0.045

    self.typing = love.audio.newSource('music/typing.mp3', 'static')
    self.typing:setVolume(0.1)

    self.delay = 0.3
    self.speed = 0

    -- Concatenate all the elements in text2[0] to currentText
    for i = 1, #self.text2[0] do
        print(self.currentText2)
        self.currentText2 = self.currentText2 .. self.text2[0][i] .. "\n" -- Add a newline between elements
    end
end

function GameOver:update(dt)

    -- timer = timer + dt
    self.timer2 = self.timer2 + dt

    -- Check if it's time to display the next character
    if self.timer2 >= self.typingSpeed2 and self.currentIndex2 <= #self.currentText2 then
        -- currentText2 = currentText2:sub(currentIndex2, currentIndex2)

        if string.match(self.currentText2:sub(self.currentIndex2, self.currentIndex2), "%\n") then
            self.typing:stop()
            if self.speed < self.delay then
                self.speed = self.speed + dt
            else
                self.timer2 = 0
                self.currentIndex2 = self.currentIndex2 + 1
                self.speed = 0
            end
        else
            self.typing:stop()
            self.typing:play()
            self.timer2 = 0
            self.currentIndex2 = self.currentIndex2 + 1
        end

    end

    if love.keyboard.wasPressed('return') then
        if self.currentIndex2 <= #self.currentText2 then
            -- If the text is not fully displayed, show the entire text immediately
            if self.currentIndex2 == #self.currentText2 then
                self.typing:stop()
            end
            self.currentIndex2 = #self.currentText2 + 1

        else
            -- If the text is fully displayed, proceed to the next state
            self.currentText2 = ""
            self.currentIndex2 = 1
            self.timer2 = 0
            self.typingSpeed2 = 0.045
            self.text2 = ""
            self.speed = 0

            gStateStack:pop()
            gStateStack:pop()

 
            -- set to default 0 to begin from start  
            counter_var = 0
            gStateStack:push(MainMenu())
        end

    end

end

function GameOver:render()
    love.graphics.setBackgroundColor(1, 1, 1, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(24)) -- Adjust font size as desired

    love.graphics.setLineWidth(5)
    love.graphics.rectangle('line', 40, 80, 1280 - 80, 270, 30)
    love.graphics.setColor(0.05, 0.05, 0.05)
    love.graphics.rectangle('fill', 40, 80, 1280 - 80, 270, 30)
    love.graphics.setColor(0, 0.9, 0.9)
    love.graphics.print(self.currentText2:sub(1, self.currentIndex2), 50, store_y)

end
