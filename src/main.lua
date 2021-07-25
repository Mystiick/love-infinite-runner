Object = require 'lib/classic/classic'
require 'sprite-utils'

local Game = require 'screens/game'
local MainMenu = require 'screens/main_menu'
local WINDOW_TITLE = 'Infinite Runner'

S_Characters = nil
S_Tiles = nil
S_Backgrounds = nil

current_game_state = 'menu'

local game_states = 
{
    ['menu'] = MainMenu(),
    ['game'] = Game(),
}

--- Called once immediately when the game launches.
--  Loads textures, sounds, and sets up the window
function love.load()
    -- Load assets
    local tileset_atlas = love.graphics.newImage('/assets/tiles_packed.png')
    tileset_atlas:setFilter('nearest', 'nearest')
    S_Tiles = mapTiles(sliceSheet(tileset_atlas, {x=18, y=18}), tileset_atlas)

    local character_atlas = love.graphics.newImage('/assets/characters_packed.png')
    character_atlas:setFilter('nearest', 'nearest')
    S_Characters = mapCharacters(sliceSheet(character_atlas, {x=24, y=24}), character_atlas)

    background_atlas = love.graphics.newImage('/assets/backgrounds_packed.png')
    background_atlas:setFilter('nearest', 'nearest')
    S_Backgrounds = mapBackgrounds(sliceSheet(background_atlas, {x=24, y=24}), background_atlas)  

    -- Setup window
    love.window.setMode(800, 600, {vsync=true})
    love.window.setTitle(WINDOW_TITLE)

    game_states['game']:init()
end

--- Basic update call. Calls the update function on the current game state
function love.update(dt)
    love.window.setTitle(WINDOW_TITLE .. ' ' .. love.timer.getFPS() .. ' fps')

    game_states[current_game_state]:update(dt)

    if love.keyboard.isDown('escape') and love.keyboard.isDown('f1') then love.event.quit() end
end

--- Basic draw call. Calls the draw function on the current game state
function love.draw()
    game_states[current_game_state]:draw(sprite_maps)
end
