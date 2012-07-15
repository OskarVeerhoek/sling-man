function love.load()
	fire = love.graphics.newImage("fire.bmp")
end
function love.draw()
	love.graphics.print('Hello Anna!', 400, 300)
end
function love.draw()
	love.graphics.draw(fire, 10, 10)
end