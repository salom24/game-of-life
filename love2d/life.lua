-- Game cells definition

local life = {}
life.turn = 0
life.cell = {}

function life:born(x, y)
  self.cell[x..":"..y] = true
end

function life:pass()
  local neighbours = {}
  self.turn = self.turn + 1
  for k,v in pairs(self.cell) do
    _, _, x, y = string.find(k, "([-]?%d+):([-]?%d+)")
    x = tonumber(x)
    y = tonumber(y)
    if not neighbours[k] then neighbours[k] = 0 end
    for i=x-1,x+1 do
      for j=y-1,y+1 do
        if i~=x or j~=y then
          if neighbours[i..":"..j] then
            neighbours[i..":"..j] = neighbours[i..":"..j] + 1
          else
            neighbours[i..":"..j] = 1
          end
        end
      end
    end
  end
  for k,v in pairs(neighbours) do
    if v == 3 then
      self.cell[k] = true
    elseif v == 2 and self.cell[k] then
      self.cell[k] = true
    else
      self.cell[k] = nil
    end
  end
end

return life
