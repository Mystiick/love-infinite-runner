local Player = Object:extend()

--- Instantiates a new player object
--- @param   sprite_sheet    love.Quad[]    # array containing the quads for animation
--- @param   atlas           love.image     # atlas associated with the sprite_sheet
--- @param   scale           integer        # for the scale of sprite and colliders
function Player:new(sprite_sheet, atlas, scale, pixel_size, world)
    self.sprite_sheet = sprite_sheet
    self.atlas = atlas
    self.scale = scale or 1
    self.animation_cooldown = 0.25
    self.frame_time = 0.0
    self.can_jump = false

    self.body = nil
    self.shape = nil
    self.fixture = nil
    self.offset = nil
    if world then 
        self.body = love.physics.newBody(world, pixel_size * scale, 0, 'dynamic')
        self.shape = love.physics.newRectangleShape(pixel_size * scale, pixel_size * scale)
        self.fixture = love.physics.newFixture(self.body, self.shape, 1)
        
        self.fixture:setUserData('player')
        self.body:setFixedRotation(true) -- Disable rotation on the collider so it doesn't fall of when less than half colliding a platform
        self.body:setSleepingAllowed(false)

        self.offset = {x = -pixel_size * scale / 2, y = -pixel_size * scale / 2}
    end

    self.current_frame = 1
end

function Player:update(dt)
    self.frame_time = self.frame_time + dt

    if self.frame_time >= self.animation_cooldown then
        self.frame_time = self.frame_time - self.animation_cooldown
        self.current_frame = ((self.current_frame) % #self.sprite_sheet) + 1
    end
end

function Player:getX()
    return self.body:getX() + self.offset.x
end

function Player:getY()
    return self.body:getY() + self.offset.y
end

function Player:getSprite()
    return self.sprite_sheet[self.current_frame]
end

function Player:jump()
    if self.can_jump then
        self.body:setLinearVelocity(0, 0)
        self.body:applyLinearImpulse(0, -1250)
        self.can_jump = false
    end
end

function Player:land()
    self.can_jump = true
end

return Player