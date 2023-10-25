Levels = Class{ }

local size_array = {50, 40, 60, 80, 120}

function Levels:return_enemy(level)

    if level == 1 then
       return self:CreateAsteriods()
    end
end

function Levels:CreateAsteriods()

    local Enemy = {}
    local index = math.random(1, 5)
    Enemy.width = size_array[index]
    Enemy.height = size_array[index]
    Enemy.x = math.random(0, WINDOW_WIDTH - Enemy.width)
    Enemy.y = math.random(-150, -130)
    Enemy.ix = -1000
    Enemy.iy = -1000
    Enemy.health = 0
    Enemy.type = "Asteriod"
    Enemy.fire = -1
    Enemy.dir = 1
    Enemy.speed = math.random(80, 950)
    Enemy.col = false
    Enemy.rotate = math.random(10, 400)
    return Enemy

end 