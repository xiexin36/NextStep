
LEFT  = 2
UP    = 3
RIGHT = 5
DOWN  = 7

BLOCKTYPE_NORMAL = 100
BLOCKTYPE_START = 101
BLOCKTYPE_EXIT = 102
BLOCKTYPE_TREASURE = 103
BLOCKTYPE_HIGHLIGHT = 104

OppositeDirection = {}
OppositeDirection[LEFT] = RIGHT
OppositeDirection[UP] = DOWN
OppositeDirection[RIGHT] = LEFT
OppositeDirection[DOWN] = UP

BlockMask={
Block01 = LEFT,
Block02 = UP,
Block03 = RIGHT,
Block04 = DOWN,
Block05 = LEFT * UP,
Block06 = UP * RIGHT,
Block07 = RIGHT * DOWN,
Block08 = DOWN * LEFT,
Block09 = UP * DOWN,
Block10 = LEFT * RIGHT,
Block11 = LEFT * UP * RIGHT,
Block12 = UP * RIGHT * DOWN,
Block13 = LEFT * RIGHT * DOWN,
Block14 = LEFT * UP * DOWN,
Block15 = LEFT * UP * RIGHT * DOWN,
}
local function GenerateRandomType()
    local value = math.random(1, 100)
    if value <= 12 then
        return math.random(1, 4)
    end
    if value <= 40 then
        return math.random(5, 8)
    end
    if value <= 60 then
        return math.random(9, 10)
    end
    if value <= 92 then
        return math.random(11, 14)
    end
    return 15
end

local blockObject = {}

function blockObject.HasDirection(block, direction)
    local remainder = math.fmod(block.Mask, direction)
    return remainder == 0
end

function blockObject.GetReverseDirection(direction)
    return OppositeDirection[direction]
end

local function CreatBlock(blockMask, blockType, node)
    local block = {}
    block.Mask = blockMask
    block.Type = blockType
    block.Node = node
    return block
end

function blockObject.CreateNormalBlock()
--    local blockMask = math.random(1, 15)
    local blockMask = GenerateRandomType()
    local key = 'Block' .. string.format("%02d", blockMask)
    local filePath = 'Image/Block/' .. key ..'.png'
    local node = cc.Sprite:create(filePath)
    local block = CreatBlock(BlockMask[key], BLOCKTYPE_NORMAL, node)
    block.FilePath = filePath
    return block
end

function blockObject.CreateStartBlock()
    return CreatBlock(0, BLOCKTYPE_START, cc.Sprite:create('Image/Block/Block06.png'))
end

function blockObject.CreateExitBlock()
    return CreatBlock(0, BLOCKTYPE_EXIT, cc.Sprite:create('Image/Block/ExitBlock.png'))
end

function blockObject.CreateTreasureBlock()
    local tNode = CreatBlock(0, BLOCKTYPE_TREASURE, cc.Sprite:create('Image/Block/Block Treasure.png'))
    local tBox = cc.Sprite:create('Image/Other/Treasure.png')
    local tNodeSize = tNode.Node:getContentSize()
    tBox:setPosition(tNodeSize.width / 2, tNodeSize.height / 2)
    tNode.Node:addChild(tBox)
    return tNode
end

function blockObject.CreateHighlightBlock()
    return CreatBlock(0, BLOCKTYPE_HIGHLIGHT, cc.Sprite:create('Image/Block/HighlightBlock.png'))
end

return blockObject