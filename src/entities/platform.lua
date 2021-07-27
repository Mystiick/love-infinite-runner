local Platform = Object:extend()
local TILE_SIZE = 18*3 -- 3=scale

function Platform:new(size, position, world)

    self.tiles = {}
    self.position = position
    self.body = love.physics.newBody(world, position.x, position.y)

    self.pixel_size = { x = TILE_SIZE * size, y = TILE_SIZE }

    self.shape = love.physics.newRectangleShape(self.pixel_size.x, self.pixel_size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData('platform')

    for i = 1, size, 1 do
        self.tiles[i] = 
        {
            offset = {x = -self.pixel_size.x / 2 + ((i-1)*TILE_SIZE), y = -self.pixel_size.y / 2},
            sprite = S_Tiles.grass_platform[2] --default to the center sprite
        }

        print(self.tiles[i].offset.x)

        -- If it's the first or last, update the sprite to be the end cap
        if i == 1 then
            self.tiles[i].sprite = S_Tiles.grass_platform[1]
        elseif i == size then
            self.tiles[i].sprite = S_Tiles.grass_platform[3]
        end
    end

end

return Platform