--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]
 MainMenu = Class {
    __includes = BaseState
}

--glevel=0

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 1

function MainMenu:enter(params)
    glevel=0
    print("main")
end

function MainMenu:init()

    self.bg2 = 0
    self.bg2_image = love.graphics.newImage('sprites/planet.png')

end

function MainMenu:update(dt)

    self.bg2 = (self.bg2 + 100 * dt) % 4500

    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') then
        if highlighted == 1 then
            highlighted = 5
        end

        highlighted = (highlighted - 1) % 5
        -- gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('down') then
        if highlighted == 4 then
            highlighted = 0
        end
        highlighted = (highlighted + 1) % 5
        -- gSounds['paddle-hit']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- gSounds['confirm']:play()

        if highlighted == 1 then

            gStateStack:pop()
            gStateStack:push(PlayState())
            gStateStack:push(DialogueState())

        elseif highlighted == 2 then
            gStateStack:pop()
            gStateStack:push(Instructions())
        elseif highlighted == 3 then
            gStateStack:pop()
            gStateStack:push(Credit())

        elseif highlighted == 4 then
            gStateStack:pop()
            gStateStack:push(End())
        end

    end

end

function MainMenu:render()

    love.graphics.setColor(1, 1, 1, 0.95)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.bg2_image, 0, -4000 + self.bg2, nil, 1, 1)

    love.graphics.setFont(love.graphics.newFont("font.otf", 50))
    love.graphics.setColor(1, 0.3, 0.9)
    love.graphics.printf("Astro Assault", 0, VIRTUAL_HEIGHT / 2 + 50 - 250, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(love.graphics.newFont("font.otf", 30))
    if highlighted == 1 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 50 - 50, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("INSTRUCTIONS", 0, VIRTUAL_HEIGHT / 2 + 150 - 50, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    if highlighted == 3 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("CREDITS", 0, VIRTUAL_HEIGHT / 2 + 250 - 50, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 4 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end

    love.graphics.printf("EXIT", 0, VIRTUAL_HEIGHT / 2 + 350 - 50, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

end
