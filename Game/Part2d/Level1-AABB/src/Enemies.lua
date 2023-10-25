Enemies = Class {
    __includes = BaseState
}

-- local size_array = {50, 40, 60, 80, 120}
local rotationAngle = 0
local particles = {}

function Enemies:init()

    self.Many_Enemies = {}

    self.level_obj = Levels()

    self.timer = 0

    --Timer of each level 
    self.level1_timer=0.01

    self.flag=0

end

function Enemies:update(dt)
    print(self.timer)

    if glevel == 1 then
        if self.timer >= self.level1_timer  then
            self.flag = 1
        else
            self.timer = math.min(self.level1_timer, self.timer + 0.001 * dt)

            if math.random() < self.timer then
                table.insert(self.Many_Enemies, self.level_obj:return_enemy(glevel))
            end
        end
    end 

    
    if self.flag == 1 and #self.Many_Enemies == 0 then
        self.flag=0
        gStateStack:push(DialogueState())
    end 
 

    for key,value in pairs(self.Many_Enemies) do
        value.y=value.y+value.speed*dt
    end

    for key,value in pairs(self.Many_Enemies) do
        if value.y>VIRTUAL_HEIGHT+value.height then 
            table.remove(self.Many_Enemies,key)
        end 
    end
end

function Enemies:ParticleSystem(x, y)

    local psystem = love.graphics.newParticleSystem(sprites.enemySheet, 2000)

    -- lasts between 0.5-1 seconds seconds
    psystem:setParticleLifetime(1, 1.5)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward
    psystem:setLinearAcceleration(-550, -500, 550, 700)

    psystem:emit(200)

    table.insert(particles, {
        xp = x,
        yp = y,
        p = psystem
    })

end

function Enemies:render()

    love.graphics.setColor(1,0.4,0)

    for key,value in pairs(self.Many_Enemies) do
        love.graphics.rectangle("fill",value.x,value.y,value.width,value.height)
    end

end
