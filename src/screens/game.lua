local Game = Object:extend()
local Player = require('/entities/player')
local Platform = require('/entities/platform')
local temp = 1
local chosen_character

local CHAR_SIZE = 24
local CHAR_SCALE = 3

--- How many pixels are in a meter
local METER_SCALE = 64
--- love.physics.world that controls the physics
local world
--- table that contains all of the physical objects
local objects = {}

local player = Player()


local function beginContact(a, b, coll)
	print(a:getUserData()..' collided with '..b:getUserData())
    
    if a:getUserData() == 'player' or b:getUserData() == 'player' then
        objects.player:land()
    end
end

function Game:init(char)
    if char == nil or char == '' then
        chosen_character = ({ 'green', 'blue', 'pink', 'yellow', 'pale' })[love.math.random(1, 5)]
        print ('choosing random character: ' .. chosen_character)
    else 
        chosen_character = char
    end

    -- Setup physics
    love.physics.setMeter(METER_SCALE)
    world = love.physics.newWorld(0, 25 * METER_SCALE, true)

    objects.player = Player(S_Characters[chosen_character], S_Characters.atlas, CHAR_SCALE, CHAR_SIZE, world)
    objects.platforms = { Platform(200, {x=345, y=550}, world), Platform(5, {x=700,y=200}, world), Platform(15, {x=1500,y=350}, world) }

    world:setCallbacks(beginContact)
end

function Game:update(dt)
    if love.keyboard.isDown('`') then PAUSE_GAME = true end
    if love.keyboard.isDown('r') then UpdateGameState('game') end

    if love.keyboard.isDown('space') and objects.player.can_jump then
        objects.player:jump()
    end

    objects.player:update(dt)
    for i = 1, #objects.platforms, 1 do
        objects.platforms[i]:update(dt)
    end

    world:update(dt)
end

function Game:draw()
    -- First, draw the background
    love.graphics.draw(S_Backgrounds.atlas, S_Backgrounds.brown[2], 0, 0, 0, 25, 25)
    love.graphics.draw(S_Backgrounds.atlas, S_Backgrounds.green[2], 25*24, 0, 0, 25, 25)

    -- Then draw the character
    love.graphics.draw(objects.player.atlas, objects.player:getSprite(), objects.player:getX(), objects.player:getY(), 0, -CHAR_SCALE, CHAR_SCALE, 24, -1)

    -- Then draw the platforms/enemies
    for i = 1, #objects.platforms, 1 do
        local temp = objects.platforms[i]

        for j = 1, #temp.tiles, 1 do
            local tile = temp.tiles[j]
            
            love.graphics.draw(S_Tiles.atlas, tile.sprite, temp.body:getX()+tile.offset.x, temp.body:getY()+tile.offset.y, 0, CHAR_SCALE, CHAR_SCALE)
        end
    end
end

return Game