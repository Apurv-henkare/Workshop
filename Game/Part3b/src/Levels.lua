Levels = Class{ }

local size_array = {50, 140, 60, 80, 120}

function Levels:return_enemy(level)

    if level == 1 then
       return self:CreateAsteriods()

    elseif level == 2 then 
        return self:CreateAliens()
    else 
        return self:Boss()    
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
    Enemy.speed = math.random(80, 1550)
    Enemy.col = false
    Enemy.rotate = math.random(10, 400)
    return Enemy

end 


function Levels:CreateAliens()

    local Aliens={}
    for j = 1, 6 do
        for i = 1, 21 do

            local squard1 = {}
            squard1.x = (i - 1) * 60
            squard1.y = (j) * 60 - 1000
            squard1.speed = 200
            squard1.width = 60
            squard1.height = 60
            squard1.health = 0
            squard1.dir = 1
            squard1.type = "alien"
            squard1.ix = i
            squard1.iy = j

            if j == 6 then
                squard1.fire = 1
                print(i.." "..j)
            else
                squard1.fire = 0
            end
         --   io.write(squard1.ix, squard1.iy, " ")
            table.insert(Aliens, squard1)
        end
        --print()
    end

    return Aliens
end 

function Levels:Boss()
    local Boss = {{
        x = 300,
        y = 130,
        width = 100,
        height = 130,
        speed = 300,
        ix = -1000,
        iy = -1000,
        fire = 1,
        type = "boss",
        health = 80,
        dir = 1
    }}

    return Boss
end 
