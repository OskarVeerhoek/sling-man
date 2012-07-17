function love.load()
    background = love.graphics.newImage("field.dds")
    player = love.graphics.newImage("player.dds")
    victim = love.graphics.newImage("victim.dds");
    player_x = 200 --[[ window coordinates --]]
    player_y = 100 --[[ window coordinates --]]
    player_destination_x = player_x --[[ window coordinates --]]
    player_destination_y = player_y --[[ window coordinates --]]
    player_speed = 3
    victim_count = 5
    victim_alive_count = victim_count
    victims = {
    {["x"]=550,["y"]=550,["rotation"]=0,["speed"]=1.5,["dest_x"]=250,["dest_y"]=250,["alive"]=true,["fleeing"]=false},
 --   {["x"]=20,["y"]=20,["speed"]=1.5,["dest_x"]=250,["dest_y"]=250,["alive"]=true,["fleeing"]=false},
 --   {["x"]=200,["y"]=20,["speed"]=1.5,["dest_x"]=250,["dest_y"]=250,["alive"]=true,["fleeing"]=false}--]]
    }
    for i = 1, victim_count do
        victims[i] = {
            ["x"]=math.random(1500) - 750,
            ["y"]=math.random(1500) - 750,
            ["rotation"]=math.rad(math.random(360)),
            ["speed"]=math.random(300) / 100,
            ["dest_x"]=math.random(300) + 100,
            ["dest_y"]=math.random(300) + 100,
            ["alive"]=true,
            ["fleeing"]=false
        }
    end
    player_rotation = 0 --[[ radians --]]
    use_mouse = false
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
    for i = 1, victim_count do
        if math.dist(player_x, player_y, victims[i].x, victims[i].y) < 30 then
            if victims[i].alive == true then
                victims[i].alive = false
                victim_alive_count = victim_alive_count - 1
            end
        end
    end
end
function love.update(dt) 
    if love.keyboard.isDown("left") then
        use_mouse = false
        player_rotation = player_rotation - dt * 5
    elseif love.keyboard.isDown("right") then
        use_mouse = false
        player_rotation = player_rotation + dt * 5
    end
    if love.mouse.isDown("l") then
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        player_speed = math.dist(x, y, player_x, player_y) / 20
        if math.dist(x, y, player_x, player_y) > 15 then
            use_mouse = true
            player_destination_x = x
            player_destination_y = y
        else
            use_mouse = false
        end
    else
        use_mouse = false
    end
    if use_mouse == true then
        local rotation = math.atan2(player_y - player_destination_y, player_x - player_destination_x)
        player_x = player_x - math.cos(rotation) * 60 * dt * player_speed
        player_y = player_y - math.sin(rotation) * 60 * dt * player_speed
        player_rotation = rotation
        if player_x < player_destination_x + 1 and player_x > player_destination_x - 1 and player_y < player_destination_y + 1 and player_y > player_destination_y - 1 then
            use_mouse = false
        end
    else
        if love.keyboard.isDown("up") then
            use_mouse = false
            player_x = player_x - math.cos(player_rotation) * 60 * dt * player_speed;
            player_y = player_y - math.sin(player_rotation) * 60 * dt * player_speed;
        elseif love.keyboard.isDown("down") then
            use_mouse = false
            player_x = player_x + math.cos(player_rotation) * 60 * dt * player_speed;
            player_y = player_y + math.sin(player_rotation) * 60 * dt * player_speed;
        end
    end
    for i = 1, victim_count do
        local distance_player_victim = math.dist(player_x, player_y, victims[i].x, victims[i].y)
        local away_from_player_rotation = math.getAngle(victims[i].x, victims[i].y, player_x, player_y)
        local to_centre_rotation = 4.71238898 - math.getAngle(victims[i].x, victims[i].y, victims[i].dest_x, victims[i].dest_y)
        if distance_player_victim < 150 then
            victims[i].fleeing = true
            victims[i].speed = (6 - distance_player_victim / 25) * 0.8
            victims[i].x = victims[i].x - math.sin(away_from_player_rotation) * 60 * dt * victims[i].speed
            victims[i].y = victims[i].y - math.cos(away_from_player_rotation) * 60 * dt * victims[i].speed
        else
            victims[i].fleeing = false
            victims[i].rotation = to_centre_rotation
            victims[i].speed = math.dist(victims[i].x, victims[i].y, victims[i].dest_x, victims[i].dest_y) / 100
            if math.dist(victims[i].x, victims[i].y, victims[i].dest_x, victims[i].dest_y) > 40 then
                victims[i].x = victims[i].x - math.cos(victims[i].rotation) * 60 * dt * victims[i].speed
                victims[i].y = victims[i].y - math.sin(victims[i].rotation) * 60 * dt * victims[i].speed
            end
        end
        victims[i].rotation = to_centre_rotation
    end
    check_player_collision()
end
--[[function love.mousepressed(x, y, button)
    use_mouse = true
    player_destination_x = x
    player_destination_y = y
end--]]
function love.draw()
    love.graphics.draw(background)
    for i = 1, victim_count do
        if victims[i].alive == true then
            love.graphics.push()
            love.graphics.translate(victims[i].x, victims[i].y)
            love.graphics.rotate(victims[i].rotation - 1.570796327)
            love.graphics.draw(victim, -16, -16)
            love.graphics.pop()
        end
    end
    love.graphics.push()
    love.graphics.translate(player_x, player_y)
    love.graphics.rotate(player_rotation - 1.570796327)
    love.graphics.draw(player, -16, -16)
    love.graphics.pop()
    if victim_alive_count > 0 then
        love.graphics.print("Victims Alive: "..victim_alive_count, 370, 450)
    else
        love.graphics.print("You Won!", 370, 450)
    end
end
-- Averages an arbitrary number of angles.
function math.averageAngles(...)
    local x,y = 0,0
    for i=1,select('#',...) do local a= select(i,...) x, y = x+math.cos(a), y+math.sin(a) end
    return math.atan2(y, x)
end


-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two points.
function math.getAngle(x1,y1, x2,y2) return math.atan2(x2-x1, y2-y1) end


-- Returns the closest multiple of 'size' (defaulting to 10).
function math.multiple(n, size) size = size or 10 return math.round(n/size)*size end


-- Clamps a number to within a certain range.
function math.clamp(low, n, high) return math.min(math.max(n, low), high) end


-- Normalizes two numbers.
function math.normalize(x,y) local l=(x*x+y*y)^.5 if l==0 then return 0,0,0 else return x/l,y/l,l end end
-- Normalizes a table of numbers.
function math.normalize(t) local n,m = #t,0 for i=1,n do m=m+t[i] end m=1/m for i=1,n do t[i]=t[i]*m end return t end


-- Returns 'n' rounded to the nearest 'deci'th.
function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end


-- Randomly returns either -1 or 1.
function math.rsign() return math.random(2) == 2 and 1 or -1 end


-- Returns 1 if number is positive, -1 if it's negative, or 0 if it's 0.
function math.sign(n) return n>0 and 1 or n<0 and -1 or 0 end


-- Checks if two line segments intersect. Line segments are given in form of ({x,y},{x,y}, {x,y},{x,y}).
function checkIntersect(l1p1, l1p2, l2p1, l2p2)
    local function checkDir(pt1, pt2, pt3) return math.sign(((pt2.x-pt1.x)*(pt3.y-pt1.y)) - ((pt3.x-pt1.x)*(pt2.y-pt1.y))) end
    return (checkDir(l1p1,l1p2,l2p1) ~= checkDir(l1p1,l1p2,l2p2)) and (checkDir(l2p1,l2p2,l1p1) ~= checkDir(l2p1,l2p2,l1p2))
end