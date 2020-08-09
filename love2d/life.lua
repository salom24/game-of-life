-- Game of life

-- Module
local life = {}

-- Local variables
local cell, turns, alives
local play, drawing
local time
local dx, dy, size

-- Local functions
local function reset()
	cell = {}
	turns = 0
	alives = 0
	play = false
end

local function born(x, y)
	cell[x] = cell[x] or {}
	if not cell[x][y] then
		cell[x][y] = true
		alives = alives + 1
	end
end

local function die(x, y)
	if cell[x] then
		if cell[x][y] then
			cell[x][y] = nil
			alives = alives - 1
		end
		if next(cell[x]) == nil then
			cell[x] = nil
		end
	end
end

local function pass()
	local neighbours = {}
	turns = turns + 1
	for x, t in pairs(cell) do
		for y in pairs(t) do
			for i=x-1,x+1 do
				for j=y-1,y+1 do
					if i~=x or j~=y then
						neighbours[i] = neighbours[i] or {}
						-- If already exists, add one. I not, equals 1
						neighbours[i][j] = neighbours[i][j] and neighbours[i][j] + 1 or 1
					else 
						neighbours[i][j] = neighbours[i][j] or 0
					end
				end
			end
		end
	end
	for x, t in pairs(neighbours) do
		for y, n in pairs(t) do
			if n == 3 then
				born(x, y)
			elseif n ~= 2 then
				die(x, y)
			end
		end
	end
end

function life.load()
	reset()
	dx, dy = 0, 0
	-- Size of tile
	size = 5
	-- Frame time
	time = 0
end

-- Export functions
function life.update (dt)
	-- Update the game
	if play then
		time = time + dt
		if time > 0.1 then
			pass()
			time = time - 0.1
		end
	end
end

function life.draw ()
	-- Some game info
	love.graphics.print("Cells alive: "..alives.."\nTurns: "..turns.."\nFPS: "..love.timer.getFPS().."\nPosition: "..0-dx.."/"..dy)
	-- Get dimensions
	local w, h = love.graphics.getDimensions()
	-- Apply scale
	love.graphics.translate(w/2, h/2)
	love.graphics.scale(size)
	-- Apply translation
	love.graphics.translate(dx, dy)
	-- Print cells
	for x, t in pairs(cell) do
		for y in pairs(t) do
			love.graphics.rectangle("fill", x, y, 1, 1)
		end
	end
end

function life.keypressed(key)
	if key == "left" then dx = dx + 1
	elseif key == "right" then dx = dx - 1
	elseif key == "down" then dy = dy - 1
	elseif key == "up" then dy = dy + 1
	elseif key == "=" then size = size + 0.1
	elseif key == "-" then size = size - 0.1
	elseif key == "q" then love.event.quit()
	elseif key == "r" then reset()
	elseif key == "i" then switchlevel("intro")
	elseif key == "space" then play = not play end
end

function life.mousepressed(x, y, button)
	if button == 1 then
		drawing = true
		x, y = love.graphics.inverseTransformPoint(x, y)
		x = math.floor(x)
		y = math.floor(y)
		born(x, y)
	end
end

function life.mousemoved(x, y)
	if drawing then
		x, y = love.graphics.inverseTransformPoint(x, y)
		x = math.floor(x)
		y = math.floor(y)
		born(x, y)
	end
end

function life.mousereleased(x, y, button)
	if button == 1 then
		drawing = nil
	end
end

function life.wheelmoved(x, y)
	dx = dx - x
	dy = dy + y
end

return life