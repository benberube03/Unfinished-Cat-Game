local enemies = {}

enemies[1] = {}
enemies[1].sprite = love.graphics.newImage('assetflipper/enemies/skull/skull1/purpskull.png')
enemies[1].width = 42
enemies[1].height = 42
enemies[1].x = -enemies[1].width
enemies[1].y = math.random(0, height - enemies[1].height)
enemies[1].speed = 500
enemies[1].scale = 1


enemies[1].frames = {}

local frame = 1

for row = 0,3 do
    for col = 0,3 do

     enemies[1].frames[frame] = love.graphics.newQuad(
        col * 42,
        row * 42,
        42,
        42,
        enemies[1].sprite:getWidth(),
        enemies[1].sprite:getHeight()
     )

     frame = frame + 1
    end
end


enemies[1].currentFrame = 1
enemies[1].animationTimer = 0

--[[enemies[2] = {}
enemies[2].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[2].x
enemies[2].y
enemies[2].speed
enemies[2].scale
enemies[2].width
enemies[2].height

enemies[2].frames = {}

for i = x,x do
    enemies[2].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[2].sprite:getWidth(),
        enemies[2].sprite:getHeight()
    )
end

enemies[2].currentFrame = 1
enemies[2].animationTimer = 0

enemies[3] = {}
enemies[3].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[3].x
enemies[3].y
enemies[3].speed
enemies[3].scale
enemies[3].width
enemies[3].height

enemies[3].frames = {}

for i = x,x do
    enemies[3].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[3].sprite:getWidth(),
        enemies[3].sprite:getHeight()
    )
end

enemies[3].currentFrame = 1
enemies[3].animationTimer = 0

enemies[4] = {}
enemies[4].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[4].x
enemies[4].y
enemies[4].speed
enemies[4].scale
enemies[4].width
enemies[4].height

enemies[4].frames = {}

for i = x,x do
    enemies[4].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[4].sprite:getWidth(),
        enemies[4].sprite:getHeight()
    )
end

enemies[4].currentFrame = 1
enemies[4].animationTimer = 0

enemies[5] = {}
enemies[5].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[5].x
enemies[5].y
enemies[5].speed
enemies[5].scale
enemies[5].width
enemies[5].height

enemies[5].frames = {}

for i = x,x do
    enemies[5].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[5].sprite:getWidth(),
        enemies[5].sprite:getHeight()
    )
end

enemies[5].currentFrame = 1
enemies[5].animationTimer = 0

enemies[6] = {}
enemies[6].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[6].x
enemies[6].y
enemies[6].speed
enemies[6].scale
enemies[6].width
enemies[6].height

enemies[6].frames = {}

for i = x,x do
    enemies[6].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[6].sprite:getWidth(),
        enemies[6].sprite:getHeight()
    )
end

enemies[6].currentFrame = 1
enemies[6].animationTimer = 0

enemies[7] = {}
enemies[7].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[7].x
enemies[7].y
enemies[7].speed
enemies[7].scale
enemies[7].width
enemies[7].height

enemies[7].frames = {}

for i = x,x do
    enemies[7].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[7].sprite:getWidth(),
        enemies[7].sprite:getHeight()
    )
end

enemies[7].currentFrame = 1
enemies[7].animationTimer = 0

enemies[8] = {}
enemies[8].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[8].x
enemies[8].y
enemies[8].speed
enemies[8].scale
enemies[8].width
enemies[8].height

enemies[8].frames = {}

for i = x,x do
    enemies[8].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[8].sprite:getWidth(),
        enemies[8].sprite:getHeight()
    )
end

enemies[8].currentFrame = 1
enemies[8].animationTimer = 0

enemies[9] = {}
enemies[9].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[9].x
enemies[9].y
enemies[9].speed
enemies[9].scale
enemies[9].width
enemies[9].height

enemies[9].frames = {}

for i = x,x do
    enemies[9].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[9].sprite:getWidth(),
        enemies[9].sprite:getHeight()
    )
end

enemies[9].currentFrame = 1
enemies[9].animationTimer = 0

enemies[10] = {}
enemies[10].sprite = love.graphics.newImage('assetflipper/enemies/x.png')
enemies[10].x
enemies[10].y
enemies[10].speed
enemies[10].scale
enemies[10].width
enemies[10].height

enemies[10].frames = {}

for i = x,x do
    enemies[10].frames[i] = love.graphics.newQuad(
        (i -1) * x,
        0,
        x,
        x,
        enemies[10].sprite:getWidth(),
        enemies[10].sprite:getHeight()
    )
end

enemies[10].currentFrame = 1
enemies[10].animationTimer = 0--]]

function resetEnemies(enemy)
    enemy.x = -enemy.width
    enemy.y = math.random(0, height - enemy.height)
end

function enemies.update(dt)

    enemies[1].x = enemies[1].x + enemies[1].speed * dt 

    enemies[1].animationTimer = enemies[1].animationTimer + dt

 if enemies[1].animationTimer >= 0.1 then
    enemies[1].currentFrame = enemies[1].currentFrame + 1
    enemies[1].animationTimer = 0
    
    if enemies[1].currentFrame > 16 then 
        enemies[1].currentFrame = 1
     end
 end
    
    if enemies[1].x > width then
        resetEnemies(enemies[1])
    end
end


function enemies.draw()
    love.graphics.draw(enemies[1].sprite, enemies[1].frames[1][enemies[1].currentFrame],
     enemies[1].x + enemies[1].width, enemies[1].y, 0, -enemies[1].scale, enemies[1].scale)
end

return enemies