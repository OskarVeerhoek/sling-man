function love.load()
	background = love.graphics.newImage("field.dds")
	player = love.graphics.newImage("player.dds")
	player_x = 200 --[[ window coordinates --]]
	player_y = 100 --[[ window coordinates --]]
	player_destination_x = player_x --[[ window coordinates --]]
	player_destination_y = player_y --[[ window coordinates --]]
	player_rotation = 0 --[[ radians --]]
	use_mouse = false
end
function love.update(dt) 
	if love.keyboard.isDown("left") then
		use_mouse = false
		player_rotation = player_rotation - dt * 2
	elseif love.keyboard.isDown("right") then
		use_mouse = false
		player_rotation = player_rotation + dt * 2
	end
	if use_mouse == true then
		rotation = math.atan2(player_y - player_destination_y, player_x - player_destination_x)
		player_x = player_x - math.cos(rotation) * 60 * dt * 2
		player_y = player_y - math.sin(rotation) * 60 * dt * 2
		player_rotation = rotation - 1.570796327
		if player_x < player_destination_x + 1 and player_x > player_destination_x - 1 and player_y < player_destination_y + 1 and player_y > player_destination_y - 1 then
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