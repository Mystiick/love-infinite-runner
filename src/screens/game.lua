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
local canJump = false


function Game:init(char)
    if char == nil or char == '' then        
        chosen_character = ({ 'green', 'blue', 'pink', 'yellow', 'pale' })[love.math.random(1, 5)]
        print ('choosing random character: ' .. chosen_character)
    else 
        chosen_character = char
    end

    -- Setup physics
    love.physics.setMeter(METER_SCALE)
    world = love.physics.newWorld(0, 9.81 * METER_SCALE, true)

    objects.player = 
    {
        body = love.physics.newBody(world, CHAR_SIZE * CHAR_SCALE, 0, 'dynamic'), --setting to dynamic lets it move around
        shape = love.physics.newRectangleShape(CHAR_SIZE * CHAR_SCALE, CHAR_SIZE * CHAR_SCALE),
        offset = { x = -CHAR_SIZE * CHAR_SCALE / 2, y = -CHAR_SIZE * CHAR_SCALE / 2 }
    }
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 1) -- density of 1
    objects.player.fixture:setUserData('player')
    objects.player.body:setFixedRotation(true) -- Disable rotation on the collider so it doesn't fall of when less than half colliding a platform

    objects.platforms = { Platform(11, {x=345, y=550}, world) }

    world:setCallbacks(beginContact)
end

function Game:update(dt)
    if love.keyboard.isDown('1') then temp = 1 end
    if love.keyboard.isDown('2') then temp = 2 end
    if love.keyboard.isDown('`') then PAUSE_GAME = true end

    if love.keyboard.isDown('space') and canJump then
        objects.player.body:setLinearVelocity(0, 0)
        objects.player.body:applyLinearImpulse(0, -750)
        canJump = false
    end

    world:update(dt)
end

function Game:draw(sprite_maps)
    -- First, draw the background
    love.graphics.draw(S_Backgrounds.atlas, S_Backgrounds.brown[2], 0, 0, 0, 25, 25)
    love.graphics.draw(S_Backgrounds.atlas, S_Backgrounds.green[2], 25*24, 0, 0, 25, 25)

    -- Then draw the character
    love.graphics.draw(S_Characters.atlas, S_Characters[chosen_character][temp], objects.player.body:getX()+objects.player.offset.x, objects.player.body:getY()+objects.player.offset.y, 0, -CHAR_SCALE, CHAR_SCALE, 24, -1)
    --love.graphics.rectangle('line', objects.player.body:getX()+objects.player.offset.x, objects.player.body:getY()+objects.player.offset.y, 24*3, 24*3)

    -- Then draw the platforms/enemies
    for i = 1, #objects.platforms, 1 do
        local temp = objects.platforms[i]


        for j = 1, #temp.tiles, 1 do
            local tile = temp.tiles[j]
            
            love.graphics.draw(S_Tiles.atlas, tile.sprite, temp.body:getX()+tile.offset.x, temp.body:getY()+tile.offset.y, 0, CHAR_SCALE, CHAR_SCALE)
        end
        
        --love.graphics.print('|', temp.body:getX(), temp.body:getY()) --center of the platform
        --love.graphics.polygon("fill", temp.body:getWorldPoints(temp.shape:getPoints())) --debug colliders
    end
    --love.graphics.polygon("fill", objects.player.body:getWorldPoints(objects.player.shape:getPoints())) --debug colliders
end

function beginContact(a, b, coll)
	print(a:getUserData()..' collided with '..b:getUserData())
    
    if a:getUserData() == 'player' or b:getUserData() == 'player' then
        canJump = true
    end
end

return Game