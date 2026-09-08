

local pathing = {}

function pathing.zigzag(enemy, dt)
end

function pathing.swirl(enemy, dt)
end

function pathing.sinewave(enemy, dt)
end

function pathing.rise(enemy, dt)
end

function pathing.chase(enemy, dt)
end

function pathing.stopgo(enemy, dt)
end


function pathing.wavespeed(enemy, dt)
end



function pathing.update(enemy, dt)
    if enemy.pattern == "zigzag" then
        pathing.zigzag(enemy, dt)


elseif enemy.pattern == "swirl" then
    pathing.swirl(enemy, dt)

elseif enemy.pattern == "sinewave" then
    pathing.sinewave(enemy, dt)


elseif enemy.pattern == "rise" then
    pathing.rise(enemy, dt)


elseif enemy.pattern == "chase" then
    pathing.chase(enemy, dt)


elseif enemy.pattern == "stopgo" then
    pathing.stopgo(enemy, dt)


else enemy.pattern == "wavespeed" then
    pathing.wavespeef(enemy, dt)
end


return pathing