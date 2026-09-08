function checkCollision(player, fish)
	return player.x < fish.x + fish.width
		and player.x + player.width > fish.x
		and player.y < fish.y + fish.height
		and player.y + player.height > fish.y
end

--===========================================================================================================================================--
--LOADING SHIT START--
function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	love.window.setMode(960, 540)

	math.randomseed(os.time())

	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	gameState = "menu"

	highScore = 0

	if love.filesystem.getInfo("highscore.txt") then
		local fileContents = love.filesystem.read("highscore.txt")
		highScore = tonumber(fileContents) or 0
	else
		highScore = 0
	end
	screenShake = 0

	speedMultiplier = 1.0

	score = 0
	displayScore = 0
	health = 4

	font = love.graphics.newFont("assetflipper/fontgame.ttf", 50)
	scoreFont = love.graphics.newFont("assetflipper/fontgame.ttf", 32)
	menuFont = love.graphics.newFont("assetflipper/fontgame.ttf", 80)
	deathFont = love.graphics.newFont("assetflipper/fontgame.ttf", 80)
	love.graphics.setFont(font)

	--Sprites and player--====================================================================================
	player = {}
	player.x = 400
	player.y = 300
	player.speed = 700
	player.scale = 1.25
	player.sprite = love.graphics.newImage("assetflipper/cat.png")
	player.width = 48
	player.height = 64
	player.direction = "right"
	player.direction = "left"
	player.hitTimer = 0
	player.permaHit = false

	player.frames = {}

	for i = 1, 6 do
		player.frames[i] =
			love.graphics.newQuad((i - 1) * 48, 0, 48, 64, player.sprite:getWidth(), player.sprite:getHeight())
	end

	player.currentFrame = 1
	player.animationTimer = 0
	player.flashTimer = 0

	yarn = {}
	yarn.sprite = love.graphics.newImage("assetflipper/yarn.png")
	yarn.scale = 1
	yarn.width = 32
	yarn.height = 32

	yarn.x = -yarn.width
	yarn.y = math.random(0, height - yarn.height)
	yarn.speed = 375

	fish = {}
	fish.sprite = love.graphics.newImage("assetflipper/fish.png")
	fish.scale = 1
	fish.width = 32
	fish.height = 32
	fish.x = -fish.width
	fish.y = math.random(0, height - fish.height)
	fish.speed = 350

	trex = {}
	trex.sprite = love.graphics.newImage("assetflipper/trex.png")
	trex.scale = 2
	trex.width = 32
	trex.height = 32
	trex.x = -trex.width
	trex.y = math.random(0, height - trex.height)
	trex.speed = 300

	trex.frames = {}

	for i = 1, 6 do
		trex.frames[i] = love.graphics.newQuad((i - 1) * 32, 0, 32, 32, trex.sprite:getWidth(), trex.sprite:getHeight())
	end

	trex.currentFrame = 1
	trex.animationTimer = 0

	fireskull = {}
	fireskull.scale = 2
	fireskull.width = 42
	fireskull.height = 42
	fireskull.x = -fireskull.width
	fireskull.y = math.random(0, height - fireskull.height)
	fireskull.startY = fireskull.y
	fireskull.speed = 400
	fireskull.sprites = {}

	fireskull.sprites[1] = love.graphics.newImage("assetflipper/enemies/skull/skull1/1.png")
	fireskull.sprites[2] = love.graphics.newImage("assetflipper/enemies/skull/skull2/2.png")
	fireskull.sprites[3] = love.graphics.newImage("assetflipper/enemies/skull/skull3/3.png")
	fireskull.sprites[4] = love.graphics.newImage("assetflipper/enemies/skull/skull4/4.png")
	fireskull.sprites[5] = love.graphics.newImage("assetflipper/enemies/skull/skull5/5.png")

	fireskull.sprite = fireskull.sprites[math.random(1, 5)]

	fireskull.frames = {}

	local frame = 1

	for row = 0, 3 do
		for col = 0, 3 do
			fireskull.frames[frame] = love.graphics.newQuad(
				col * 42,
				row * 42,
				42,
				42,
				fireskull.sprites[1]:getWidth(),
				fireskull.sprites[1]:getHeight()
			)
			frame = frame + 1

			fireskull.pathTimer = 0
			fireskull.path = paths[1]
			fireskull.currentFrame = 1
			fireskull.animationTimer = 0
		end

		--[[bluebird = {}
    bluebird.scale = 2
    bluebird.sprite = love.graphics.newImage('assetflipper/enemies/bluebird_sprite.png')
    bluebird.width = 42
    bluebird.height = 42
    bluebird.x = 
    bluebird.y = math.random(0, height - bluebird.height)
    bluebird.speed = 400--]]

		penguin = {}
		penguin.sprite = love.graphics.newImage("assetflipper/enemies/penguin/spin.png")
		penguin.scale = 2
		local trueWidth = 16
		local trueHeight = 16
		penguin.width = trueWidth * penguin.scale
		penguin.height = trueHeight * penguin.scale

		penguin.x = -penguin.width
		penguin.y = math.random(0, height - penguin.height)
		penguin.speed = 100
		penguin.acceleration = 250
		offsetX = 24 * penguin.scale
		offsetY = 16 * penguin.scale
		penguin.frames = {}

		for i = 1, 7 do
			penguin.frames[i] =
				love.graphics.newQuad((i - 1) * 64, 0, 64, 64, penguin.sprite:getWidth(), penguin.sprite:getHeight())
		end

		penguin.currentFrame = 1
		penguin.animationTimer = 0
		penguin.pathTimer = 0
		penguin.path = paths[9]
	end

	--SPRITESandPLAYER end--=========================================================================================

	backgrounds = {}

	backgrounds[1] = love.graphics.newImage("assetflipper/backgrounds/1.png")
	backgrounds[2] = love.graphics.newImage("assetflipper/backgrounds/2.png")
	backgrounds[3] = love.graphics.newImage("assetflipper/backgrounds/3.png")
	backgrounds[4] = love.graphics.newImage("assetflipper/backgrounds/4.png")
	backgrounds[5] = love.graphics.newImage("assetflipper/backgrounds/5.png")
	backgrounds[6] = love.graphics.newImage("assetflipper/backgrounds/6.png")
	backgrounds[7] = love.graphics.newImage("assetflipper/backgrounds/7.png")
	backgrounds[8] = love.graphics.newImage("assetflipper/backgrounds/8.png")
	backgrounds[9] = love.graphics.newImage("assetflipper/backgrounds/9.png")

	healthy = {}

	healthy.images = {}

	healthy.images[1] = love.graphics.newImage("assetflipper/Health1.png")
	healthy.images[2] = love.graphics.newImage("assetflipper/Health2.png")
	healthy.images[3] = love.graphics.newImage("assetflipper/Health3.png")
	healthy.images[4] = love.graphics.newImage("assetflipper/Health4.png")
	healthy.images[5] = love.graphics.newImage("assetflipper/Health5.png")

	healthy.scale = 2.5

	sounds = {}

	sounds.music1 = love.audio.newSource("sounds/music1.mp3", "stream")

	sounds.music1:setLooping(true)
	sounds.music1:setVolume(0.07)

	sounds.itempickup = love.audio.newSource("sounds/itempickup.wav", "static")

	sounds.hurt = love.audio.newSource("sounds/hurt.mp3", "static")
	sounds.hurt:setVolume(0.3)

	sounds.death = love.audio.newSource("sounds/death.wav", "static")

	sounds.newhighscore = love.audio.newSource("sounds/newhighscore.mp3", "static")
	sounds.newhighscore:setVolume(0.3)
	sounds.lowhp = love.audio.newSource("sounds/lowhp.mp3", "static")
	sounds.lowhp:setVolume(0.3)
end
-- LOADING END --
--=======================================================================================================================================================================--

--KEYPRESSED START-- ===============================================================================================================

function love.keypressed(key)
	if gameState == "menu" then
		if key == "return" then
			gameState = "playing"
			sounds.music1:play()
		end
	elseif gameState == "gameover" then
		if key == "r" then
			resetGame()
			gameState = "playing"
			sounds.music1:play()
		elseif key == "escape" then
			resetGame()
			gameState = "menu"
			sounds.music1:stop()
			sounds.lowhp:stop()
		end
	elseif gameState == "playing" then
		if key == "p" then
			gameState = "paused"
			sounds.music1:pause()
		end
	elseif gameState == "paused" then
		if key == "p" then
			gameState = "playing"
			sounds.music1:play()
		end
	end
end
--KEYPRESSED END--==========================================================================================================================

--HELPER FUNCTIONS START--
--=================================================================================================================================================--
function playerHit()
	player.hitTimer = 0.5
end

function resetSprites(sprite)
	sprite.x = -sprite.width

	local amplitude = 100

	sprite.y = math.random(0, height - sprite.height)

	sprite.path = paths[math.random(1, 9)]

	if sprite == penguin then
		sprite.path = paths[9]
		sprite.speed = 100
		sprite.acceleration = 250
	end

	sprite.pathTimer = 0
	sprite.startY = sprite.y

	if sprite == fireskull then
		sprite.path = paths[1]
		sprite.sprite = sprite.sprites[math.random(1, 5)]
	end
end

paths = {}

paths[1] = "sine" --done--
paths[2] = "zigzag"
paths[3] = "orbit"
paths[4] = "tempfollow"
paths[5] = "swoop"
paths[6] = "bounce"
paths[7] = "diverecover"
paths[8] = "teleport"
paths[9] = "accelerate" --done--

randomPaths = paths[math.random(1, 9)]

function pathing(sprite, dt)
	if sprite.path == "sine" then
		sprite.x = sprite.x + sprite.speed * dt

		sprite.pathTimer = sprite.pathTimer + dt

		local frequency = 4
		local amplitude = 200

		sprite.y = sprite.startY + math.sin(sprite.pathTimer * frequency) * amplitude

	--[[elseif sprite.path == "zigzag" then 
    elseif sprite.path == "orbit" then --planet or ufo or alien
    elseif sprite.path == "tempfollow" then 
    elseif sprite.path == "swoop" then --bird done
    elseif sprite.path == "bounce" then -- frog done
    elseif sprite.path == "diverecover" then 
    elseif sprite.path == "teleport" then --wizard or allien--]]
	elseif sprite.path == "accelerate" then
		sprite.speed = sprite.speed + sprite.acceleration * dt
		sprite.x = sprite.x + sprite.speed * dt
	end
end

function resetGame()
	score = 0
	health = 4
	speedMultiplier = 1.0
	resetSprites(fish)
	resetSprites(yarn)
	resetSprites(trex)
	resetSprites(fireskull)
	resetSprites(penguin)
	displayScore = 0
	player.hitTimer = 0
	player.permaHit = false
	screenShake = 0
	player.x = 400
	player.y = 300
end

function saveHighScore()
	love.filesystem.write("highscore.txt", tostring(highScore))
end
--HELPERFUNCTIONSEND--==================================================================================================================================

--=============================================================================================================================================================--
--UPDATE SHIT START--

function love.update(dt)
	if gameState == "playing" then
		displayScore = displayScore + (score - displayScore) * 15 * dt
		player.animationTimer = player.animationTimer + dt
		screenShake = math.max(0, screenShake - dt)

		if player.animationTimer >= 0.1 then
			player.currentFrame = player.currentFrame + 1
			player.animationTimer = 0

			if player.currentFrame > 6 then
				player.currentFrame = 1
			end
		end
		trex.animationTimer = trex.animationTimer + dt
		if trex.animationTimer >= 0.1 then
			trex.currentFrame = trex.currentFrame + 1
			trex.animationTimer = 0

			if trex.currentFrame > 6 then
				trex.currentFrame = 1
			end
		end

		fireskull.animationTimer = fireskull.animationTimer + dt
		if fireskull.animationTimer >= 0.1 then
			fireskull.currentFrame = fireskull.currentFrame + 1
			fireskull.animationTimer = 0

			if fireskull.currentFrame > 16 then
				fireskull.currentFrame = 1
			end
		end

		penguin.animationTimer = penguin.animationTimer + dt
		if penguin.animationTimer >= 0.1 then
			penguin.currentFrame = penguin.currentFrame + 1
			penguin.animationTimer = 0

			if penguin.currentFrame > 7 then
				penguin.currentFrame = 1
			end
		end

		if player.hitTimer > 0 then
			player.hitTimer = player.hitTimer - dt
		end

		if player.permaHit then
			player.flashTimer = player.flashTimer + dt

			if player.flashTimer >= 0.62 then
				player.flashTimer = 0
			end
		end

		if screenShake > 0 then
			shakeX = math.random(-10, 10)
			shakeY = math.random(-10, 10)
		else
			shakeX = 0
			shakeY = 0
		end

		fish.x = fish.x + fish.speed * speedMultiplier * dt

		if checkCollision(player, fish) then
			score = score + 3
			local pickup = sounds.itempickup:clone()
			pickup:setPitch(math.random(90, 110) / 100)
			pickup:play()
			speedMultiplier = speedMultiplier + 0.008
			resetSprites(fish)
		end

		if fish.x > width then
			resetSprites(fish)
		end

		pathing(fireskull, dt)
		if checkCollision(player, fireskull) then
			health = health - 1
			screenShake = 0.25
			playerHit()

			if health <= 0 then
				sounds.death:play()
			else
				sounds.hurt:clone():play()
			end

			resetSprites(fireskull)
		end

		if fireskull.x > width then
			resetSprites(fireskull)
		end

		pathing(penguin, dt)

		if checkCollision(player, penguin) then
			health = health - 1
			screenShake = 0.25
			playerHit()

			if health <= 0 then
				sounds.death:play()
			else
				sounds.hurt:clone():play()
			end
			resetSprites(penguin)
		end
		if penguin.x > width then
			resetSprites(penguin)
		end

		yarn.x = yarn.x + yarn.speed * speedMultiplier * dt

		if checkCollision(player, yarn) then
			score = score + 5
			local pickup = sounds.itempickup:clone()
			pickup:setPitch(math.random(90, 110) / 100)
			pickup:play()
			speedMultiplier = speedMultiplier + 0.01
			resetSprites(yarn)
		end

		if yarn.x > width then
			resetSprites(yarn)
		end

		trex.x = trex.x + trex.speed * speedMultiplier * dt

		if checkCollision(player, trex) then
			health = health - 1
			screenShake = 0.25
			playerHit()

			if health <= 0 then
				sounds.death:play()
			else
				sounds.hurt:clone():play()
			end

			resetSprites(trex)
		end

		if health == 1 then
			sounds.lowhp:play()
			player.permaHit = true
		end

		if trex.x > width then
			resetSprites(trex)
		end

		if love.keyboard.isDown("right") then
			if player.x + player.speed * dt <= width - player.width then
				player.x = player.x + player.speed * dt
				player.direction = "right"
			end
		end

		if love.keyboard.isDown("left") then
			if player.x - player.speed * dt >= 0 then
				player.x = player.x - player.speed * dt
				player.direction = "left"
			end
		end

		if love.keyboard.isDown("down") then
			if player.y + player.speed * dt <= height - player.sprite:getHeight() * player.scale then
				player.y = player.y + player.speed * dt
			end
		end

		if love.keyboard.isDown("up") then
			if player.y - player.speed * dt >= 0 then
				player.y = player.y - player.speed * dt
			end
		end

		if health <= 0 then
			sounds.music1:stop()
			sounds.lowhp:stop()
			if score > highScore then
				highScore = score
				saveHighScore()
				sounds.newhighscore:play()
			end

			gameState = "gameover"
		end
	end
end

--UPDATE SHIT END--
--===========================================================================================================================================================--
--===================================================================-
--DRAWING SHIT START--
function love.draw()
	if gameState == "menu" then
		--love.graphics.draw(backgrounds.clouds1[1], bgX, 0, 0, bgScale, bgScale)

		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(menuFont)
		love.graphics.printf("CAT GAME EX\nPress ENTER to Start", 0, 250, width, "center")
	elseif gameState == "playing" or gameState == "paused" then

		local bgScale = 0.5
       if score >= 600 then
    love.graphics.draw(backgrounds[9], 0, 0, 0, bgScale, bgScale)
    elseif score >= 525 then
    love.graphics.draw(backgrounds[8], 0, 0, 0, bgScale, bgScale)
    elseif score >= 475 then
    love.graphics.draw(backgrounds[7], 0, 0, 0, bgScale, bgScale)
    elseif score >= 425 then
    love.graphics.draw(backgrounds[6], 0, 0, 0, bgScale, bgScale)
    elseif score >= 375 then
    love.graphics.draw(backgrounds[5], 0, 0, 0, bgScale, bgScale)
    elseif score >= 225 then
    love.graphics.draw(backgrounds[4], 0, 0, 0, bgScale, bgScale)
    elseif score >= 150 then
    love.graphics.draw(backgrounds[3], 0, 0, 0, bgScale, bgScale)
    elseif score >= 75 then
    love.graphics.draw(backgrounds[2], 0, 0, 0, bgScale, bgScale)
    else
    love.graphics.draw(backgrounds[1], 0, 0, 0, bgScale, bgScale)
    

end
		love.graphics.push()
		love.graphics.translate(shakeX, shakeY)
		if player.permaHit then
			if player.flashTimer % 0.62 < 0.12 then
				love.graphics.setColor(1, 0, 0)
			else
				love.graphics.setColor(1, 1, 1)
			end
		elseif player.hitTimer > 0 then
			if player.hitTimer % 0.2 < 0.1 then
				love.graphics.setColor(1, 0, 0)
			else
				love.graphics.setColor(1, 1, 1)
			end
		else
			love.graphics.setColor(1, 1, 1)
		end

		if player.direction == "right" then
			love.graphics.draw(
				player.sprite,
				player.frames[player.currentFrame],
				player.x + player.width,
				player.y - 11,
				0,
				-player.scale,
				player.scale
			)
		elseif player.direction == "left" then
			love.graphics.draw(
				player.sprite,
				player.frames[player.currentFrame],
				player.x,
				player.y - 11,
				0,
				player.scale,
				player.scale
			)
		end

		love.graphics.setColor(1, 1, 1)

		love.graphics.draw(yarn.sprite, yarn.x, yarn.y, 0, yarn.scale, yarn.scale)

		love.graphics.draw(fish.sprite, fish.x, fish.y, 0, fish.scale, fish.scale)
		love.graphics.draw(
			trex.sprite,
			trex.frames[trex.currentFrame],
			trex.x + 48,
			trex.y - 7,
			0,
			-trex.scale,
			trex.scale
		)
		love.graphics.draw(
			fireskull.sprite,
			fireskull.frames[fireskull.currentFrame],
			fireskull.x - 20,
			fireskull.y - 19,
			0,
			fireskull.scale,
			fireskull.scale
		)
		love.graphics.draw(
			penguin.sprite,
			penguin.frames[penguin.currentFrame],
			penguin.x - offsetX,
			penguin.y - offsetY,
			0,
			penguin.scale,
			penguin.scale
		)

		love.graphics.setColor(1, 1, 1)
		love.graphics.pop()
		local boxWidth = 200
		local boxHeight = 45
		local boxX = width - boxWidth - 20
		local boxY = height - boxHeight - 20

		love.graphics.setColor(0, 0, 0, 0.5)
		love.graphics.rectangle("fill", boxX, boxY, boxWidth, boxHeight)

		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(scoreFont)
		love.graphics.rectangle("line", boxX, boxY, boxWidth, boxHeight)
		local shownScore = love.graphics.print("Score: " .. math.floor(displayScore + 0.5), boxX + 10, boxY + 12)

		local healthyX = width - healthy.images[1]:getWidth() - 60
		local healthyY = 20

		if health == 4 then
			love.graphics.draw(healthy.images[1], healthyX, healthyY, 0, healthy.scale, healthy.scale)
		elseif health == 3 then
			love.graphics.draw(healthy.images[2], healthyX, healthyY, 0, healthy.scale, healthy.scale)
		elseif health == 2 then
			love.graphics.draw(healthy.images[3], healthyX, healthyY, 0, healthy.scale, healthy.scale)
		elseif health == 1 then
			love.graphics.draw(healthy.images[4], healthyX, healthyY, 0, healthy.scale, healthy.scale)
		elseif health <= 0 then
			love.graphics.draw(healthy.images[5], healthyX, healthyY, 0, healthy.scale, healthy.scale)
		end

		if gameState == "paused" then
			love.graphics.setColor(0, 0, 0, 0.5)
			love.graphics.rectangle("fill", 0, 0, width, height)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("PAUSED", 0, height / 2 - 50, width, "center")
		end
	elseif gameState == "gameover" then
		--love.graphics.draw(backgrounds.clouds5[1], bgX, 0, 0, bgScale, bgScale)
		--love.graphics.draw(backgrounds.clouds5[2], bgX, 0, 0, bgScale, bgScale)
		--love.graphics.draw(backgrounds.clouds5[3], bgX, 0, 0, bgScale, bgScale)
		--love.graphics.draw(backgrounds.clouds5[4], bgX, 0, 0, bgScale, bgScale)

		love.graphics.setColor(0, 0, 0, 0.7)
		love.graphics.rectangle("fill", 0, 0, width, height)

		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(deathFont)
		love.graphics.printf(
			"GAME OVER\nPress R to Restart\nPress Escape to Main Menu\nHigh Score: " .. highScore,
			0,
			height / 2 - 50,
			width,
			"center"
		)
	end
end
--DRAWING END END--
--==================================================================================================================================================--

--fix font
-- transisitions
-- more enemies
--bosses at the end of each background, so 9 unique bosses. 9 levels, not hard. its all good man
-- sifferne tpaths and ending after playing for a certain amount of time
--vertical random differnet beams that force you into a chunk to dodge
--more backgrounds, transition swipe effect among them
-- fix collision on cat and bat
--BETTER MENUS FOR SURE
--custom unlockable cats

--maybe add rainbow score timer,
--priorty =  make main menu and end screen not dog shit
--[[love.graphics.setColor(0, 1, 0)
love.graphics.rectangle(
    "line",
    fireskull.x,
    fireskull.y,
    fireskull.width,
    fireskull.height--]]
