local Platform = Object:extend()
local TILE_SIZE = 18*3 -- 3=scale
local PLATFORM_SPEED = 500

--- Creates a new platform object
--- @param   size        integer    # Number of platforms to render
--- @param   position    table      # x/y table defining the center of the platform
--- @param   world       love.World # love.physics.world object to attach 
function Platform:new(size, position, world)

    self.tiles = {}
    --self.position = position
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

        -- If it's the first or last, update the sprite to be the end cap
        if i == 1 then
            self.tiles[i].sprite = S_Tiles.grass_platform[1]
        elseif i == size then
            self.tiles[i].sprite = S_Tiles.grass_platform[3]
        end
    end

end

function Platform:update(dt)
    self.body:setPosition(self.body:getX() + (-PLATFORM_SPEED * dt), self.body:getY())
end

return Platform