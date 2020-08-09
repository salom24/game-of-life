-- Game of life
-- Now with graphics!!

function switchlevel(level)
	-- Load new level
	l = require(level)
	if l.load then l.load() end
	-- Update callbacks
	love.update = l.update
	love.draw = l.draw
	love.keypressed = l.keypressed
	love.keyreleased = l.keyreleased
	love.mousepressed = l.mousepressed
	love.mousemoved = l.mousemoved
	love.mousereleased = l.mousereleased
	love.wheelmoved = l.wheelmoved
end 

function love.load()
	switchlevel("intro")
end