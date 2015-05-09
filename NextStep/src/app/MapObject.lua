local MapObject = {}

local mapData = {}
local isInited = false

local function generateCornerPosition()
    local bornX = math.random(1, MapObject.mapSize.width)
    local bornY = math.random(1, MapObject.mapSize.height)

    if bornX > MapObject.mapSize.width / 2 then
        bornX = MapObject.mapSize.width
    else
        bornX = 1
    end

    if bornY > MapObject.mapSize.height / 2 then
        bornY = MapObject.mapSize.height
    else
        bornY = 1
    end

    return bornX, bornY
end

local function cleanMapData()
    for i = 1, MapObject.mapSize.height do
        for j = 1, MapObject.mapSize.width do
            MapObject.SetMapTile(nil, cc.p(i, j))
        end
    end
end

local function generateTreasurePosition()
    MapObject.treasurePos.x = math.random(4,5)
    MapObject.treasurePos.y = math.random(4,5)
end

local lightBlocks = {}
local function createCanEnterNodes()
    for i = 1,3 do
        lightBlocks[i] = cc.Sprite:create('Image/Block/HighlightBlock.png')
        lightBlocks[i]:setVisible(false)
    end
end




MapObject.mapSize = cc.size(8, 8)
MapObject.tileSize = cc.size(80, 80)
MapObject.heroPos = cc.p(0, 0)
MapObject.doorPos = cc.p(0, 0)
MapObject.treasurePos = cc.p(0, 0)

MapObject.treasureNode = nil
MapObject.outDoorNode = nil

function MapObject.SetMapTile(value, pos)
    mapData[(pos.x - 1) * MapObject.mapSize.height + pos.y] = value
end


function MapObject.getMapTile(pos)
    return mapData[(pos.x - 1) * MapObject.mapSize.height + pos.y]
end


function MapObject.MoveTo(side)
    local curMapTile = MapObject.getMapTile(MapObject.heroPos)
    local targetMapTile = nil
    local targetX = MapObject.heroPos.x
    local targetY = MapObject.heroPos.y

    local otherSide = 0
    if LEFT == side then
        otherSide = RIGHT
        targetX = MapObject.heroPos.x - 1
    elseif RIGHT == side then
        otherSide = LEFT
        targetX = MapObject.heroPos.x + 1
    elseif UP == side then
        otherSide = DOWN
        targetY = MapObject.heroPos.y + 1
    elseif DOWN == side then
        otherSide = UP
        targetY = MapObject.heroPos.y - 1
    end

    targetMapTile = MapObject.getMapTile(cc.p(targetX, targetY))

    if 0 == otherSide or (nil == curMapTile and nil == targetMapTile) or targetX < 1 or targetY < 1 or targetX > MapObject.mapSize.width or targetY > MapObject.mapSize.height then
        return false
    end

    -- 调用Block功能检查是否可以移动
    if Services.Static_BlockObject.HasDirection(curMapTile, side) and (nill == targetMapTile or Services.Static_BlockObject.HasDirection(targetMapTile, otherSide)) then
        Services.Static_HeroObject.Node:setPosition(MapObject.tilePosToScreenPos(targetX, targetY))
        MapObject.heroPos = cc.p(targetX, targetY)
        return true
    end

    return false
end


function MapObject.tilePosToScreenPos(pos)
    local x = 1
    local y = 1
    if pos.x > 1 then
        x = pos.x
    end
    if pos.y > 1 then
        y = pos.y
    end

    local xPos = (x - 1) * MapObject.tileSize.width + MapObject.tileSize.width / 2
    local yPos = (x - 1) * MapObject.tileSize.height + MapObject.tileSize.height / 2
    return xPos, yPos
end


function MapObject.checkSurroundAndHighLight()
    local curBlock = MapObject.getMapTile(MapObject.heroPos)
    if nil == curBlock then
        return
    end

    -- 是否可以向左侧移动
    if MapObject.heroPos.x > 1 then
--        if nil == MapObject.getMapTile(MapObject.heroPosX - 1, MapObject.heroPosY) and  then
    end
    -- 是否可以向右侧移动
    if MapObject.heroPos.x < MapObject.mapSize.width then
    end
    -- 是否可以向上方移动
    if MapObject.heroPos.y < MapObject.mapSize.height then
    end
    -- 是否可以向下方移动
    if MapObject.heroPos.y > 1 then
    end


end


function MapObject.initMapData()
    isInited = false
    cleanMapData()
--    local heroX, heroY = generateCornerPosition()
--    local doorX, doorY = generateCornerPosition()
--    while doorX == heroX and doorY == heroY do
--        doorX, doorY = generateCornerPosition()
--    end
    MapObject.heroPos = cc.p(1, 1)
    MapObject.doorPos = cc.p(8, 8)
    generateTreasurePosition()

    MapObject.SetMapTile(Services.Static_BlockObject.CreateStartBlock(), MapObject.heroPos)
    if nil == MapObject.treasureNode then
        MapObject.treasureNode = Services.Static_BlockObject.CreateTreasureBlock()
    end

    if nil == MapObject.outDoorNode then
        MapObject.outDoorNode = Services.Static_BlockObject.CreateExitBlock()
    end
    createCanEnterNodes()
    isInited = true
end

function MapObject.start()
    if false == isInited then
        MapObject.initMapData()
    end

    Services.Static_MainScene.root:addChild(MapObject.treasureNode.Node)
    Services.Static_MainScene.root:addChild(MapObject.outDoorNode.Node)
    local startBlock = MapObject.getMapTile(MapObject.heroPos)
    Services.Static_MainScene.root:addChild(startBlock.Node)
    for i = 1,3 do
        Services.Static_MainScene.root:addChild(lightBlocks[i])
    end

    local scrX, scrY = MapObject.tilePosToScreenPos(MapObject.heroPos)
    Services.Static_HeroObject.Node:setPosition(scrX, scrY)
    startBlock.Node:setPosition(scrX, scrY)
    MapObject.treasureNode.Node:setPosition(MapObject.tilePosToScreenPos(MapObject.treasurePos))
    MapObject.outDoorNode.Node:setPosition(MapObject.tilePosToScreenPos(MapObject.doorPos))
    MapObject.checkSurroundAndHighLight()
end


return MapObject
