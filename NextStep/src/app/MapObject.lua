local Static_MapObject = {}

local mapData = {}

local function generateCornerPosition()
    local bornX = math.random(1, Static_MapObject.lineCount)
    local bornY = math.random(1, Static_MapObject.rowCount)

    if bornX > Static_MapObject.lineCount / 2 then
        bornX = Static_MapObject.lineCount
    else
        bornX = 1
    end

    if bornY > Static_MapObject.rowCount / 2 then
        bornY = Static_MapObject.rowCount
    else
        bornY = 1
    end

    return bornX, bornY
end

local function cleanMapData()
    for i = 1, Static_MapObject.lineCount do
        for j = 1, Static_MapObject.rowCount do
            Static_MapObject.SetMapTile(0, i, j)
        end
    end
end

local function generateTreasurePosition()
    Static_MapObject.treasurePosX = math.random(4,5)
    Static_MapObject.treasurePosY = math.random(4,5)
end





Static_MapObject.lineCount = 8
Static_MapObject.rowCount = 8
Static_MapObject.tileWidth = 80
Static_MapObject.tileHeight = 80

Static_MapObject.heroPosX = 0
Static_MapObject.heroPosY = 0
Static_MapObject.doorPosX = 0
Static_MapObject.doorPosY = 0
Static_MapObject.treasurePosX = 0;
Static_MapObject.treasurePosY = 0;


function Static_MapObject.SetMapTile(value, line, row)
    mapData[(line-1) * Static_MapObject.rowCount + row] = value
end


function Static_MapObject.getMapTile(line, row)
    return mapData[(line-1) * Static_MapObject.rowCount + row]
end


function Static_MapObject.MoveTo(curLine, curRow, side)
    local curMapTile = Static_MapObject.getMapTile(curLine, curRow)
    local resultLine = curLine
    local resultRow = curRow
    -- 调用block模块检查联通性
    if Block.CanMoveTo(curMapTile, side) then
    end
end


function Static_MapObject.tilePosToScreenPos(line, row)
    if line < 1 then
        line = 1
    end
    if row < 1 then
        row = 1
    end

    local x = (line - 1) * Static_MapObject.tileWidth + Static_MapObject.tileWidth / 2
    local y = (row - 1) * Static_MapObject.tileHeight + Static_MapObject.tileHeight / 2
    return x, y
end

function Static_MapObject.initMapData()
    cleanMapData()
    local heroX, heroY = generateCornerPosition()
    local doorX, doorY = generateCornerPosition()
    while doorX == heroX and doorY == heroY do
        doorX, doorY = generateCornerPosition()
    end
    Static_MapObject.heroPosX = heroX
    Static_MapObject.heroPosY = heroY
    Static_MapObject.doorPosX = doorX
    Static_MapObject.doorPosY = doorY

    local scrX, scrY = Static_MapObject.tilePosToScreenPos(heroX, heroY)
    cc.exports.Services.Static_HeroObject.Node:setPosition(scrX, scrY)

end



-- Init and return global map manager
math.randomseed(os.time())
Static_MapObject.initMapData()

return Static_MapObject
