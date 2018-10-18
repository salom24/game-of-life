-- Main file

function love.load()
  game = require "life"
  -- Center of window
  ix = love.graphics.getWidth()/2
  iy = love.graphics.getHeight()/2
  -- Ofsett
  ox, oy = 0, 0
  -- Size of tile
  size = 5
  -- Game status
  play = false
  -- Frame time
  time = 0
end

function love.update (dt)
  -- Keyboard and mouse handling
  if love.keyboard.isDown("left") then ox = ox + 10/size end
  if love.keyboard.isDown("right") then ox = ox - 10/size end
  if love.keyboard.isDown("up") then oy = oy + 10/size end
  if love.keyboard.isDown("down") then oy = oy - 10/size end
  if love.keyboard.isDown("+") then size = size + .1 end
  if love.keyboard.isDown("-") then size = size - .1 end
  if love.keyboard.isDown("space") then
    if play then play = false else play = true end
  end
  if love.mouse.isDown(1) then
    local x, y = love.mouse.getPosition()
    x = math.floor((x - ox - ix)/size)
    y = math.floor((y - oy - iy)/size)
    game:born(x,y)
  end
  -- Update the game
  if play then
    time = time + dt
    if time > 0.1 then
      game:pass()
      time = 0
    end
  end
end

function love.draw ()
  for k,v in pairs(game.cell) do
    _, _, x, y = string.find(k, "([-]?%d+):([-]?%d+)")
    love.graphics.rectangle("fill", ix+(ox+x)*size, iy+(oy+y)*size, size, size)
  end
end
