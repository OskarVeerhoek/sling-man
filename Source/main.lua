function love.load()
	background = love.graphics.newImage("field.dds")
	player = love.graphics.newImage("player.dds")
	victim = love.graphics.newImage("victim.dds");
	player_x = 200 --[[ window coordinates --]]
	player_y = 100 --[[ window coordinates --]]
	player_destination_x = player_x --[[ window coordinates --]]
	player_destination_y = player_y --[[ window coordinates --]]
	victim_x = 400 --[[ window coordinates --]]
	victim_y = 400 --[[ window coordinates --]]
	victim_alive = true
	victim_rotation = 0 --[[ radians --]]
	player_rotation = 0 --[[ radians --]]
	use_mouse = false
end
function check_victim_collision()
	if victim_x - 16 < 0 then
		victim_x = 16
	elseif victim_x + 16 > 500 then
		victim_x = 484
	end
	if victim_y - 16 < 0 then
		victim_y = 16
	elseif victim_y + 16 > 500 then
		victim_y = 484
	end
end
function check_player_collision()
	if player_x - 16 < 0 then
		player_x = 16
	elseif player_x + 16 > 500 then
		player_x = 484
	end
	if player_y - 16 < 0 then
		player_y = 16
	elseif player_y + 16 > 500 then
		player_y = 484
	end
	if player_x < victim_x + 16 and player_x > victim_x - 16 and player_y < victim_y + 16 and player_y > victim_y - 16 then
		victim_alive = false
	end
end
function love.update(dt) 
	if love.keyboard.isDown("left") then
		use_mouse = false
		player_rotation = player_rotation - dt * 2
	elseif love.keyboard.isDown("right") then
		use_mouse = false
		player_rotation = player_rotation + dt * 2
	end
	if love.mouse.isDown("l") then
		x = love.mouse.getX()
		y = love.mouse.getY()
		if x > player_x - 1 and x < player_x + 1 and y > player_y - 1 and y < player_y + 1 then
		else
			use_mouse = true
			player_destination_x = x
			player_destination_y = y
		end
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
	away_from_player_rotation = 3.141592654 + math.atan2(victim_y - player_y, victim_x - player_x)
	to_centre_rotation = 1.570796327 + math.atan2(250 - victim_y, 250 - victim_x)
	victim_rotation = away_from_player_rotation
	victim_x = victim_x - math.cos(victim_rotation) * 60 * dt * 3.5
	victim_y = victim_y - math.sin(victim_rotation) * 60 * dt * 3.5
	check_player_collision()
	check_victim_collision()
end
--[[function love.mousepressed(x, y, button)
	use_mouse = true
	player_destination_x = x
	player_destination_y = y
end--]]
function love.draw()
	love.graphics.draw(background)
	if victim_alive == true then
		love.graphics.push()
		love.graphics.translate(victim_x, victim_y)
		love.graphics.rotate(victim_rotation - 1.570796327)
		love.graphics.draw(victim, -16, -16)
		love.graphics.pop()
	end
	love.graphics.push()
	love.graphics.translate(player_x, player_y)
	love.graphics.rotate(player_rotation)
	love.graphics.draw(player, -16, -16)
	love.graphics.pop()
end