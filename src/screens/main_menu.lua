local MainMenu = Object:extend()

local redraw_cooldown = 0
local sprites = {}

function MainMenu:update(dt)
    if love.keyboard.isDown('space') then
        current_game_state = 'game'
    end

    redraw_cooldown = redraw_cooldown - dt
    if redraw_cooldown <= 0 then
        self:UpdateSpriteLocations()
        redraw_cooldown = .5
    end
end

function MainMenu:draw()
    for i = 1, #sprites, 1
    do
        love.graphics.draw(sprites[i].atlas, sprites[i].sprite, sprites[i].position.x, sprites[i].position.y, 0, sprites[i].scale.x, sprites[i].scale.y)
    end

    love.graphics.printf('Press space to start', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
end

--- Generates a bunch of randomly positioned sprites to show on the menu for something to look at
function MainMenu:UpdateSpriteLocations()
    sprites = 
    {
        { atlas = S_Characters.atlas, sprite = S_Characters.green[love.math.random(1,2)],  position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.blue[love.math.random(1,2)],   position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.pink[love.math.random(1,2)],   position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.yellow[love.math.random(1,2)], position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.pale[love.math.random(1,2)],   position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.green[love.math.random(1,2)],  position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.blue[love.math.random(1,2)],   position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.pink[love.math.random(1,2)],   position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.yellow[love.math.random(1,2)], position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
        { atlas = S_Characters.atlas, sprite = S_Characters.pale[love.math.random(1,2)],   position = { x = love.math.random(0, 800), y = love.math.random(0, 600) }, scale = { x = -3, y = 3 } },
    }
end

return MainMenu