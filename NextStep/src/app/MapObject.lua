local MapObject = {}

local mapData = {}
local isInited = false

local function generateCornerPosition()
    local bornX = math.random(1, MapObject.lineCount)
    local bornY = math.random(1, MapObject.rowCount)

    if bornX > MapObject.lineCount / 2 then
        bornX = MapObject.lineCount
    else
        bornX = 1
    end

    if bornY > MapObject.rowCount / 2 then
        bornY = MapObject.rowCount
    else
        bornY = 1
    end

    return bornX, bornY
end

local function cleanMapData()
    for i = 1, MapObject.lineCount do
        for j = 1, MapObject.rowCount do
            MapObject.SetMapTile(nil, i, j)
        end
    end
end

local function generateTreasurePosition()
    MapObject.treasurePosX = math.random(4,5)
    MapObject.treasurePosY = math.random(4,5)
end

local lightBlocks = {}
local function createCanEnterNodes()
    for i = 1,3 do
        lightBlocks[i] = cc.Sprite:create('Image/Block/ExitBlock.png')
    end
end




MapObject.lineCount = 8
MapObject.rowCount = 8
MapObject.tileWidth = 80
MapObject.tileHeight = 80

MapObject.heroPosX = 0
MapObject.heroPosY = 0
MapObject.doorPosX = 0
MapObject.doorPosY = 0
MapObject.treasurePosX = 0;
MapObject.treasurePosY = 0;

MapObject.treasureNode = nil
MapObject.outDoorNode = nil

function MapObject.SetMapTile(value, line, row)
    mapData[(line-1) * MapObject.rowCount + row] = value
end


function MapObject.getMapTile(line, row)
    return mapData[(line-1) * MapObject.rowCount + row]
end


function MapObject.MoveTo(side)
    local curMapTile = MapObject.getMapTile(MapObject.heroPosX, MapObject.heroPosY)
    local resultLine = MapObject.heroPosX
    local resultRow = MapObject.heroPosY
    if LEFT_SIDE == side then
    end
    -- 调用Block功能检查是否可以移动
--    if Block.CanMoveTo(curMapTile, side) then
--    end
    
end


function MapObject.tilePosToScreenPos(line, row)
    if line < 1 then
        line = 1
    end
    if row < 1 then
        row = 1
    end

    local x = (line - 1) * MapObject.tileWidth + MapObject.tileWidth / 2
    local y = (row - 1) * MapObject.tileHeight + MapObject.tileHeight / 2
    return x, y
end

function MapObject.initMapData()
    isInited = false
    cleanMapData()
--    local heroX, heroY = generateCornerPosition()
--    local doorX, doorY = generateCornerPosition()
--    while doorX == heroX and doorY == heroY do
--        doorX, doorY = generateCornerPosition()
--    end
    MapObject.heroPosX = 1
    MapObject.heroPosY = 1
    MapObject.doorPosX = 8
    MapObject.doorPosY = 8
    generateTreasurePosition()

    if nil == MapObject.treasureNode then
        MapObject.treasureNode = Services.Static_BlockObject.CreateTreasureBlock()
    end

    if nil == MapObject.outDoorNode then
        MapObject.outDoorNode = Services.Static_BlockObject.CreateExitBlock()
    end
    isInited = true
end

function MapObject.start()
    if false == isInited then
        MapObject.initMapData()
    end

    Services.Static_MainScene.root:addChild(MapObject.treasureNode.Node)
    Services.Static_MainScene.root:addChild(MapObject.outDoorNode.Node)

    local scrX, scrY = MapObject.tilePosToScreenPos(MapObject.heroPosX, MapObject.heroPosX)
    Services.Static_HeroObject.Node:setPosition(scrX, scrY)
    MapObject.treasureNode.Node:setPosition(MapObject.tilePosToScreenPos(MapObject.treasurePosX, MapObject.treasurePosY))
    MapObject.outDoorNode.Node:setPosition(MapObject.tilePosToScreenPos(MapObject.doorPosX, MapObject.doorPosY))
end


-- Init and return global map manager
math.randomseed(os.time())
MapObject.initMapData()

return MapObject