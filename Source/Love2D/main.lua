function love.load()
    background = love.graphics.newImage("field.dds")
    player = love.graphics.newImage("player.dds")
    victim = love.graphics.newImage("victim.dds");
    player_x = 200 --[[ window coordinates --]]
    player_y = 100 --[[ window coordinates --]]
    player_destination_x = player_x --[[ window coordinates --]]
    player_destination_y = player_y --[[ window coordinates --]]
    player_speed = 3
    victim_x = 550 --[[ window coordinates --]]
    victim_y = 550 --[[ window coordinates --]]
    scale = 1.0
    last_victim_x = victim_x
    last_victim_y = victim_y
    victim_alive = true
    victim_fleeing = false
    victim_speed = 1.5
    victim_destination_x = 250
    victim_desintation_y = 250
    victim_rotation = 0 --[[ radians --]]
    player_rotation = 0 --[[ radians --]]
    use_mouse = false
end
function distance(x1, y1, x2, y2)
    return math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
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
    last_victim_x = victim_x
    last_victim_y = victim_y
    if love.keyboard.isDown("left") then
        use_mouse = false
        player_rotation = player_rotation - dt * 3.5
    elseif love.keyboard.isDown("right") then
        use_mouse = false
        player_rotation = player_rotation + dt * 3.5
    end
    if love.mouse.isDown("l") then
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        if x > player_x - 1 and x < player_x + 1 and y > player_y - 1 and y < player_y + 1 then
        else
            use_mouse = true
            player_destination_x = x
            player_destination_y = y
        end
    else
        use_mouse = false
    end
    if use_mouse == true then
        local rotation = math.atan2(player_y - player_destination_y, player_x - player_destination_x)
        player_x = player_x - math.cos(rotation) * 60 * dt * player_speed
        player_y = player_y - math.sin(rotation) * 60 * dt * player_speed
        player_rotation = rotation - 1.570796327
        if player_x < player_destination_x + 1 and player_x > player_destination_x - 1 and player_y < player_destination_y + 1 and player_y > player_destination_y - 1 then
            use_mouse = false
        end
    else
        if love.keyboard.isDown("up") then
            use_mouse = false
            player_x = player_x - math.cos(player_rotation + 1.570796327) * 60 * dt * player_speed;
            player_y = player_y - math.sin(player_rotation + 1.570796327) * 60 * dt * player_speed;
        elseif love.keyboard.isDown("down") then
            use_mouse = false
            player_x = player_x + math.cos(player_rotation + 1.570796327) * 60 * dt * player_speed;
            player_y = player_y + math.sin(player_rotation + 1.570796327) * 60 * dt * player_speed;
        end
    end
    local distance_player_victim = distance(player_x, player_y, victim_x, victim_y)
    local away_from_player_rotation = 3.141592654 + math.atan2(victim_y - player_y, victim_x - player_x)
    local to_centre_rotation = math.atan2(victim_y - 250, victim_x - 250)
    if distance_player_victim < 150 then
        victim_fleeing = true
        victim_rotation = away_from_player_rotation
        victim_speed = 6 - distance_player_victim / 25
        victim_x = victim_x - math.cos(victim_rotation) * 60 * dt * victim_speed
        victim_y = victim_y - math.sin(victim_rotation) * 60 * dt * victim_speed
    else
        victim_fleeing = false
        victim_rotation = to_centre_rotation
        victim_speed = distance(victim_x, victim_y, 250, 250) / 100
        if distance(victim_x, victim_y, 250, 250) > 15 then
            victim_x = victim_x - math.cos(victim_rotation) * 60 * dt * victim_speed
            victim_y = victim_y - math.sin(victim_rotation) * 60 * dt * victim_speed
        end
    end
    victim_rotation = to_centre_rotation
    check_player_collision()
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