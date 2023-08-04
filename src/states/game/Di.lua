Di = Class {
    __includes = BaseState
}


local store_y = 100

local counter = 0

function Di:init()

    

    counter_var = counter_var + 1

    self.text2 = {
        [1] = {"In the not-so-distant future, you are Captain Apurv of the Indian Spacecraft 'Varja' a lone guardian",
               "sent on a daring mission to protect Earth and its allies from an ancient and",
               "malevolent extraterrestrial force known as the 'Cosmic Invaders' ", "\n",
               "Captain Apurv, your first challenge is to navigate the treacherous asteroid belt blocking",
               "the path of the Vajra and its allies. With deft maneuvers and advanced weaponry, break through",
               "the hazardous debris to pave the way for Earth's defense fleet."},
        [2] = {"The Cosmic Invaders, relentless in their pursuit of universal domination, unleash swarms ", 
                "of formidable alien spacecraft. Utilizing your Indian ingenuity, engage in intense dogfights,",
                "prove that humanity's resolve is not to be underestimated.","\n",
                "DESTROY ALL ENEMIES !!"},
        [3] = {"In the heart of enemy territory, you confront the Galactic Tyrant, a colossal and malevolent",
                "extraterrestrial being. Utilize the Vajra's resonance disruptor to weaken its armor",
                "Dodge its devastating attacks and target its exposed areas. ","\n",
                "FINISH HIM !!"},
        [4] ={"With a final, mighty blow, Captain Apurv obliterates the Galactic Tyrant, securing victory",
              "for Earth and India. The universe rejoices in their triumph",
              "\n",
              "Congratulations to Captain Apurv and the formidable spacecraft, Vajra, for their historic feat",
              "Their bravery and skill have saved countless lives"}
    }
    self.currentText2 = ""
    self.currentIndex2 = 1
    self.timer2 = 0
    self.typingSpeed2 = 0.045

    self.typing = love.audio.newSource('music/typing.mp3', 'static')
    self.typing:setVolume(0.1)

    self.delay=0.3
    self.speed=0

   -- if counter_var > 0 then
        --counter_var = counter_var + 1
    --end

    -- Concatenate all the elements in text2[0] to currentText
    for i = 1, #self.text2[counter_var] do
        print(self.currentText2)
        self.currentText2 = self.currentText2 .. self.text2[counter_var][i] .. "\n" -- Add a newline between elements
    end
end


function Di:update(dt)

    -- timer = timer + dt
    self.timer2 = self.timer2 + dt



    -- Check if it's time to display the next character
    if self.timer2 >= self.typingSpeed2 and self.currentIndex2 <= #self.currentText2 then
        -- currentText2 = currentText2:sub(currentIndex2, currentIndex2)


        if string.match(self.currentText2:sub(self.currentIndex2,self.currentIndex2), "%\n") then
            self.typing:stop()
            if self.speed<self.delay then
                self.speed=self.speed+dt
            else
                self.timer2 = 0
                self.currentIndex2 = self.currentIndex2 + 1
                self.speed=0
            end
        else
            --self.typing:play()
            self.typing:stop()
            self.typing:play()
            self.timer2 = 0
            self.currentIndex2 = self.currentIndex2 + 1
            
       
        end

        --self.currentIndex2 = self.currentIndex2 + 1

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
            self.speed=0


            if counter_var == 4 then 
                gStateStack:pop()
                gStateStack:pop()
                gStateStack:push(MainMenu())
            else    
                gStateStack:pop()
            end 
        end

    end

end

function Di:render()
    love.graphics.setBackgroundColor(1, 1, 1, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont("font.otf",24)) -- Adjust font size as desired
    -- love.graphics.print(currentText, 100, 100)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle('line',40,80,1280-80,270,30)
    love.graphics.setColor(0.05,0.05,0.05)
    love.graphics.rectangle('fill',40,80,1280-80,270,30)
    love.graphics.setColor(0,0.9,0.9)
    love.graphics.print(self.currentText2:sub(1, self.currentIndex2), 50, store_y )

end
