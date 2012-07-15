function love.load()
	background = love.graphics.newImage("field.bmp")
	player = love.graphics.newImage("player2.png")
	player_x = 100 --[[ window coordinates --]]
	player_y = 100 --[[ window coordinates --]]
	player_destination_x = player_x --[[ window coordinates --]]
	player_destination_y = player_y --[[ window coordinates --]]
	player_rotation = 0 --[[ radians --]]
	use_mouse = false
end
function love.update(dt) 
	if love.keyboard.isDown("left") then
		player_rotation = player_rotation - dt
	elseif love.keyboard.isDown("right") then
		player_rotation = player_rotation + dt
	end
	if use_mouse == true then
		player_rotation = math.atan2(player_y - player_destination_y, player_x - player_destination_x)
		player_x = player_x - math.cos(player_rotation)
		player_y = player_y - math.sin(player_rotation)
		if player_x == player_destination_x and player_y == player_destination_y then
			use_mouse = false
		end
	end
	if love.keyboard.isDown("up") then
		use_mouse = false
		player_x = player_x - math.cos(player_rotation + 1.570796327) * 60 * dt * 2;
		player_y = player_y - math.sin(player_rotation + 1.570796327) * 60 * dt * 2;
	elseif love.keyboard.isDown("down") then
		use_mouse = false
		player_x = player_x + math.cos(player_rotation + 1.570796327) * 60 * dt * 2;
		player_y = player_y + math.sin(player_rotation + 1.570796327) * 60 * dt * 2;
	end
end
function love.mousepressed(x, y, button)
	use_mouse = true
	player_destination_x = x
	player_destination_y = y
end
function love.draw()
	love.graphics.draw(background)
	love.graphics.push()
	--[[love.graphics.rotate(player_rotation)
	love.graphics.translate(player_x, player_y)--]]
	love.graphics.translate(player_x, player_y)
	love.graphics.rotate(player_rotation)
	love.graphics.draw(player, -16, -16)
	love.graphics.pop()
end