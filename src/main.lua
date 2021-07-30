Object = require 'lib/classic/classic'
Sprite_Utils = require 'sprite-utils'

local Game = require 'screens/game'
local MainMenu = require 'screens/main_menu'
local WINDOW_TITLE = 'Infinite Runner'

S_Characters = nil
S_Tiles = nil
S_Backgrounds = nil

PAUSE_GAME = false

local current_game_state = 'menu'
local game_states = 
{
    ['menu'] = MainMenu(),
    ['game'] = Game(),
}

--- Called once immediately when the game launches.
--- Loads textures, sounds, and sets up the window
function love.load()
    -- Load assets
    S_Tiles = Sprite_Utils.sliceSheet('/assets/tiles_packed.png', {x=18, y=18}, Sprite_Utils.mapTiles)
    S_Characters = Sprite_Utils.sliceSheet('/assets/characters_packed.png', {x=24, y=24}, Sprite_Utils.mapCharacters)
    S_Backgrounds = Sprite_Utils.sliceSheet('/assets/backgrounds_packed.png', {x=24, y=24}, Sprite_Utils.mapBackgrounds)

    -- Setup window
    love.window.setTitle(WINDOW_TITLE)
end

--- Basic update call. Calls the update function on the current game state
function love.update(dt)
    love.window.setTitle(WINDOW_TITLE .. ' ' .. love.timer.getFPS() .. ' fps')

    if PAUSE_GAME == false then
        game_states[current_game_state]:update(dt)
    end

    if love.keyboard.isDown('escape') and love.keyboard.isDown('f1') then love.event.quit() end
end

--- Basic draw call. Calls the draw function on the current game state
function love.draw()
    game_states[current_game_state]:draw()
end

function UpdateGameState(state)
    print('setting game state to '..state)
    game_states[state]:init()
    current_game_state = state
end
