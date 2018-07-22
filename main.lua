platform = {}
player = {}
orientation_radians = 0
scale = {}
scale.x = 1
scale.y = 1
offset = {}
offset.x = 0
offset.y = 32	-- cause it's a 32x32 image, so it'll draw on top off the platform instead of within it

function love.load()
	-- set platform to size of screen
	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()

	-- position platform to cover the bottom half of the screen
	platform.x = 0
	platform.y = platform.height / 2

	-- position player in middle of screen
	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2

	-- load the player image
	player.img = love.graphics.newImage("assets/images/purple.png")

	-- initialize jump parameters
	player.ground = player.y -- keeps track of where the players "ground" is
	player.y_velocity = 0
	player.jump_height = -300 -- remember, negative means up.  So you can go up 300px
	player.gravity = -500	-- descend at 500px/sec

	-- set player speed
	player.speed = 200

	-- set the color to be drawn (a nice shade of pink here)
	-- TODO figure out why setting color to (232, 12, 122) causes it to go white
	love.graphics.setColor(0, 123, 123)

	-- TODO set multiple key presses to true to allow for jump "pressure" based on
	-- length of time key is held down
end

function love.update(dt)
	-- movement
	if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then
			player.x =player.x - (player.speed * dt)
		end
	end

	-- jump physics calculation
	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - (player.gravity * dt)
	end

	-- collision detection
	if player.y > player.ground then
		player.y = player.ground
		player.y_velocity = 0
	end
end

function love.draw()
	love.graphics.print("Hello world", 400, 200)	
	love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
	love.graphics.draw(player.img, player.x, player.y, 
		orientation, scale.x, scale.y, offset.x, offset.y)
end

function love.keypressed(key, u)
	--Debug
	if key == "rctrl" then
   		love.graphics.setColor(255, 255, 255)
    	debug.debug()
	end

	-- jump check
	if key == "w" then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end

end