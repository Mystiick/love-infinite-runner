--- Slices the given texture atlas into a map on the dimensions passed in via tile_size
-- @param   tile_size   x/y size of tiles to slice
-- @output  map of quads for each row/column
function sliceSheet(atlas, tile_size)
    width, height = atlas:getDimensions()

    local output = {}

    -- Loop over each row, inside that loop, loop over each column
    for i = 0, (height/tile_size.y) - 1, 1
    do
        output[i] = {}

        for j = 0, (width/tile_size.x) - 1, 1
        do
            output[i][j] = love.graphics.newQuad(j * tile_size.x, i * tile_size.y, tile_size.x, tile_size.y, atlas:getDimensions())
        end
    end

    return output
end

--- Converts the 3d sprite_map array into a plain text object
-- @param   sprite_map      sliced character sheet containing quad mapping of characters (from sliceSheet() above)
-- @param   sprite_atlas    loaded image containing all sprites
-- @output  map of the characters using plain text
function mapCharacters(sprite_map, sprite_atlas)
    return
    {
        atlas = sprite_atlas,
        green =  { sprite_map[0][0], sprite_map[0][1] },
        blue =   { sprite_map[0][2], sprite_map[0][3] },
        pink =   { sprite_map[0][4], sprite_map[0][5] },
        yellow = { sprite_map[0][6], sprite_map[0][7] },
        pale =   { sprite_map[1][0], sprite_map[1][1] },
    }
end

function mapTiles(sprite_map, sprite_atlas)
    return 
    {
        atlas = sprite_atlas,
        
    }
end

--- Converts the 3d sprite_map array into a plain text object
-- @param   sprite_map      sliced background sheet containing quad mapping of backgrounds (from sliceSheet() above)
-- @param   sprite_atlas    loaded image containing all sprites
-- @output  map of the backgrounds using plain text
function mapBackgrounds(sprite_map, sprite_atlas)
    return
    {
        atlas = sprite_atlas,
        blue =  { sprite_map[0][0], sprite_map[0][1], sprite_map[0][2] },
        brown = { sprite_map[0][3], sprite_map[0][4], sprite_map[0][5] },
        white = { sprite_map[1][0], sprite_map[0][1], sprite_map[0][2] },
        green = { sprite_map[1][3], sprite_map[1][4], sprite_map[1][5] },
    }
end