local intro = {}

local total
local text
local font
local width
local w, h

function intro.load()
	total = 0
	text = "Welcome to Game of Life!"
	font = love.graphics.setNewFont(32)
	width = font:getWidth(text)
	w, h = love.graphics.getDimensions()
end

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
		love.graphics.print(text, math.floor((w-width)/2), math.floor(h/2-10))
	end
end

function intro.keypressed(key)
	switchlevel("life")
end

return intro
