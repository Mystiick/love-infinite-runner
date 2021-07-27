local sprite_utils = {}

--- Slices the given texture atlas into a map on the dimensions passed in via tile_size
-- @param   tile_size   x/y size of tiles to slice
-- @output  map of quads for each row/column
sprite_utils.sliceSheet = function(atlas_path, tile_size, callback)
    local atlas = love.graphics.newImage(atlas_path)
    atlas:setFilter('nearest', 'nearest')

    local width, height = atlas:getDimensions()

    local output = {}

    -- Loop over each row, inside that loop, loop over each column
    for i = 1, (height/tile_size.y), 1
    do
        output[i] = {}

        for j = 1, (width/tile_size.x), 1
        do
            output[i][j] = love.graphics.newQuad((j - 1) * tile_size.x, (i - 1) * tile_size.y, tile_size.x, tile_size.y, atlas:getDimensions())
        end
    end
    
    return callback(output, atlas)
end

--- Converts the 3d sprite_map array into a plain text object
-- @param   sprite_map      sliced character sheet containing quad mapping of characters (from sliceSheet() above)
-- @param   sprite_atlas    loaded image containing all sprites
-- @output  map of the characters using plain text
sprite_utils.mapCharacters = function(sprite_map, sprite_atlas)
    return
    {
        atlas = sprite_atlas,
        green =  { sprite_map[1][1], sprite_map[1][2] },
        blue =   { sprite_map[1][3], sprite_map[1][4] },
        pink =   { sprite_map[1][5], sprite_map[1][6] },
        yellow = { sprite_map[1][7], sprite_map[1][8] },
        pale =   { sprite_map[2][1], sprite_map[2][2] },
    }
end

--- Converts the 3d sprite_map array into a plain text object
-- @param   sprite_map      sliced background sheet containing quad mapping of tiles (from sliceSheet() above)
-- @param   sprite_atlas    loaded image containing all sprites
-- @output  map of the tiles using plain text
sprite_utils.mapTiles = function(sprite_map, sprite_atlas)
    return 
    {
        atlas = sprite_atlas,
        grass_platform = { sprite_map[1][2], sprite_map[1][3], sprite_map[1][4] },
        dirt_platform =  { sprite_map[3][2], sprite_map[3][3], sprite_map[3][4] },
        snow_platform =  { sprite_map[5][2], sprite_map[5][3], sprite_map[5][4] },
    }
end

--- Converts the 3d sprite_map array into a plain text object
-- @param   sprite_map      sliced background sheet containing quad mapping of backgrounds (from sliceSheet() above)
-- @param   sprite_atlas    loaded image containing all sprites
-- @output  map of the backgrounds using plain text
sprite_utils.mapBackgrounds = function(sprite_map, sprite_atlas)
    return
    {
        atlas = sprite_atlas,
        blue =  { sprite_map[1][1], sprite_map[1][2], sprite_map[1][3] },
        brown = { sprite_map[1][4], sprite_map[1][5], sprite_map[1][6] },
        white = { sprite_map[2][1], sprite_map[2][2], sprite_map[2][3] },
        green = { sprite_map[2][4], sprite_map[2][5], sprite_map[2][6] },
    }
end

return sprite_utils