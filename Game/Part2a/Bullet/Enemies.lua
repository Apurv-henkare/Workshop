local Many_Enemies={}


local function CreateEnemies()
    local Enemy={}
    Enemy.width=math.random(30,60)
    Enemy.height=math.random(20,30)
    Enemy.x=math.random(0,VIRTUAL_WIDTH-Enemy.width)
    Enemy.y=math.random(-250,-100)
    Enemy.speed=math.random(100,800)
    return Enemy
end 


function Enemies_update(dt)

    if math.random() <1 then 
        table.insert(Many_Enemies,CreateEnemies())
    end
    
    for key,values in pairs(Many_Enemies) do

        values.y=values.y+values.speed*dt
    end

    for key,values in pairs(Many_Enemies) do
            if values.y>VIRTUAL_HEIGHT+values.width then 
                table.remove(Many_Enemies,key)
            end 
    end

end 

function Enemies_render()

    love.graphics.setColor(0,1,1)
    for key,values in pairs(Many_Enemies)do
        love.graphics.rectangle("fill",values.x,values.y,values.width,values.height)
    end 
end