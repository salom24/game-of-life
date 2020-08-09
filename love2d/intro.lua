local intro = {}

local total = 0

function intro.update(dt)
	total = total + dt
	if total > .3 then 
		blink = false
		total = total - .3
	elseif total > .2 then
		blink = true
	end
end

function intro.draw()
	if not blink then
		love.graphics.print("Welcome to Game of Life!", 20, 20)
	end
end

function intro.keypressed(key)
	switchlevel("life")
end

return intro