local Game = Object:extend()
local Player = require('/entities/player')
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
    objects.ground = 
    {
        body = love.physics.newBody(world, 800/2, 600-50/2),
        shape = love.physics.newRectangleShape(800, 50),
    }
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
    objects.ground.fixture:setUserData('floor')

    objects.player = 
    {
        body = love.physics.newBody(world, 100, 800/2, 'dynamic'), --setting to dynamic lets it move around
        shape = love.physics.newCircleShape(20)
    }
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 1) -- density of 1
    objects.player.fixture:setUserData('player')


    world:setCallbacks(beginContact)
end

function Game:update(dt)
    if love.keyboard.isDown('1') then temp = 1 end
    if love.keyboard.isDown('2') then temp = 2 end

    if love.keyboard.isDown('space') and canJump then
        objects.player.body:setLinearVelocity(0, 0)
        objects.player.body:applyLinearImpulse(0, -175)
        canJump = false
    end

    world:update(dt)
end

function Game:draw(sprite_maps)
    -- First, draw the background
    love.graphics.draw(S_Backgrounds.atlas, S_Backgrounds.brown[2], 0, 0, 0, 25, 25)
    love.graphics.draw(S_Backgrounds.atlas, S_Backgrounds.green[2], 25*24, 0, 0, 25, 25)

    -- Then draw the character
    love.graphics.draw(S_Characters.atlas, S_Characters[chosen_character][temp], objects.player.body:getX(), objects.player.body:getY(), 0, -CHAR_SCALE, CHAR_SCALE, CHAR_SIZE, CHAR_SIZE * (1-1/CHAR_SCALE)+1)

    -- Then draw the platforms/enemies
    love.graphics.setColor(0.28, 0.63, 0.05)
    love.graphics.polygon('fill', objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

    -- Reset the color to default
    love.graphics.setColor(1, 1, 1)
end

function beginContact(a, b, coll)
	print(a:getUserData()..' collided with '..b:getUserData())

    if a:getUserData() == 'player' or b:getUserData() == 'player' then
        canJump = true
    end
end

return Game