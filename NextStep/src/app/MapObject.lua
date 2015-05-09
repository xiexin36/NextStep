local MapObject = {}

local mapData = {}
local isInited = false

local adjustYPos = 15;

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
            local tempNode = MapObject.getMapTile(cc.p(i, j))
            if nil ~= tempNode and tempNode.Type ~= BLOCKTYPE_START and tempNode.Type ~= BLOCKTYPE_EXIT and tempNode.Type ~= BLOCKTYPE_TREASURE then
                Services.Static_MainScene.root:removeChild(tempNode.Node, true)
            end
            MapObject.SetMapTile(nil, cc.p(i, j), true)
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

local function hideAllHilightBlock()
    for i = 1,3 do
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

local function setTileAniFinished()
    print("Set tile animation finished");
    Services.Static_HeroObject.TileMapSettedCallback()
    MapObject.checkSurroundAndHighLight()
end

function MapObject.SetMapTile(value, pos, inside)
    -- inside 为 true 表示内部调用，无须动画处理，否则需要添加动画效果
    if true ~= inside then
        if nil ~= value then
            hideAllHilightBlock()
            local aniNode = value.Node
            local sequence = cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(MapObject.tilePosToScreenPos(pos))),
                cc.CallFunc:create(setTileAniFinished))
            aniNode:runAction(sequence)
        end
    end

    mapData[(pos.x - 1) * MapObject.mapSize.height + pos.y] = value
end


function MapObject.getMapTile(pos)
    return mapData[(pos.x - 1) * MapObject.mapSize.height + pos.y]
end

function MoveToFinished()
    print("Move to animation finished!")
end

function MapObject.MoveTo(side)
    local curMapTile = MapObject.getMapTile(MapObject.heroPos)
    local targetMapTile = nil
    local targetX = MapObject.heroPos.x
    local targetY = MapObject.heroPos.y

    hideAllHilightBlock()

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
        MapObject.checkSurroundAndHighLight()
        return false
    end

    -- 调用Block功能检查是否可以移动
    if (nil == curMapTile and Services.Static_BlockObject.HasDirection(targetMapTile, otherSide)) or 
        (Services.Static_BlockObject.HasDirection(curMapTile, side) and (nil == targetMapTile or Services.Static_BlockObject.HasDirection(targetMapTile, otherSide))) then

        local heroNode = Services.Static_HeroObject.Node
        local heroScrX, heroScrY = MapObject.tilePosToScreenPos(cc.p(targetX, targetY))
        heroScrY = heroScrY + adjustYPos
        local sequence = cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(heroScrX, heroScrY)),
            cc.CallFunc:create(MoveToFinished))
        heroNode:runAction(sequence)

        MapObject.heroPos = cc.p(targetX, targetY)
        MapObject.checkSurroundAndHighLight()
        return true
    end

    MapObject.checkSurroundAndHighLight()
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
    local yPos = (y - 1) * MapObject.tileSize.height + MapObject.tileSize.height / 2
    return xPos, yPos
end


function MapObject.checkSurroundAndHighLight()
    local curBlock = MapObject.getMapTile(MapObject.heroPos)

    if nil == curBlock then
        lightBlocks[1]:setPosition(MapObject.tilePosToScreenPos(MapObject.heroPos))
        lightBlocks[1]:setVisible(true)
        
        return
    end

    local hilightCount = 0

    local function checkAndSetHilight(newPos, side, curNode)
        if nil == MapObject.getMapTile(newPos) and Services.Static_BlockObject.HasDirection(curNode, side) then
            hilightCount = hilightCount + 1
            lightBlocks[hilightCount]:setPosition(MapObject.tilePosToScreenPos(newPos))
            lightBlocks[hilightCount]:setVisible(true)
        end
    end

    -- 是否可以向左侧移动
    if MapObject.heroPos.x > 1 then
        local nPos = cc.p(MapObject.heroPos.x - 1, MapObject.heroPos.y)
        checkAndSetHilight(nPos, LEFT, curBlock)
    end
    -- 是否可以向右侧移动
    if MapObject.heroPos.x < MapObject.mapSize.width then
        local nPos = cc.p(MapObject.heroPos.x + 1, MapObject.heroPos.y)
        checkAndSetHilight(nPos, RIGHT, curBlock)
    end
    -- 是否可以向上方移动
    if MapObject.heroPos.y < MapObject.mapSize.height then
        local nPos = cc.p(MapObject.heroPos.x, MapObject.heroPos.y + 1)
        checkAndSetHilight(nPos, UP, curBlock)
    end
    -- 是否可以向下方移动
    if MapObject.heroPos.y > 1 then
        local nPos = cc.p(MapObject.heroPos.x, MapObject.heroPos.y - 1)
        checkAndSetHilight(nPos, DOWN, curBlock)
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

    MapObject.SetMapTile(Services.Static_BlockObject.CreateStartBlock(), MapObject.heroPos, true)
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

    createCanEnterNodes()

    Services.Static_MainScene.root:addChild(MapObject.treasureNode.Node)
    Services.Static_MainScene.root:addChild(MapObject.outDoorNode.Node)
    local startBlock = MapObject.getMapTile(MapObject.heroPos)
    Services.Static_MainScene.root:addChild(startBlock.Node)
    for i = 1,3 do
        Services.Static_MainScene.root:addChild(lightBlocks[i])
    end
    MapObject.restart()
end

function MapObject.restart()
    local startBlock = MapObject.getMapTile(MapObject.heroPos)
    local scrX, scrY = MapObject.tilePosToScreenPos(MapObject.heroPos)
    Services.Static_HeroObject.Node:setPosition(scrX, scrY + adjustYPos)
    startBlock.Node:setPosition(scrX, scrY)
    MapObject.treasureNode.Node:setPosition(MapObject.tilePosToScreenPos(MapObject.treasurePos))
    MapObject.outDoorNode.Node:setPosition(MapObject.tilePosToScreenPos(MapObject.doorPos))
    MapObject.SetMapTile(MapObject.treasureNode, MapObject.treasurePos, true)
    MapObject.SetMapTile(MapObject.outDoorNode, MapObject.doorPos, true)
    hideAllHilightBlock()
    MapObject.checkSurroundAndHighLight()
end

return MapObject
