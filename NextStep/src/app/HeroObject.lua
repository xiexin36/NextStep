local HeroObject = {}

--上次站立的有效位置
HeroObject.LastDirection = nil
HeroObject.Block = nil

local function GenerateNewBlcok()
    local block = Services.Static_BlockObject.CreateNormalBlock()
    block.Node:setPosition(895, 400)
    block.Node:setLocalZOrder(10)
    block.Node:retain()
    Services.Static_MainScene.root:addChild(block.Node)
    HeroObject.Block = block
end

function HeroObject.init()
    local heroNodeFile = require "res/HeroNode.lua"
    local result = heroNodeFile.create()
    result.root:runAction(result.animation)
    HeroObject.Node = result.root
    HeroObject.Node:setLocalZOrder(100)
    HeroObject.Animation = result.animation
end

--  当前可以选择块的列表
local ListView_Block = nil
--  重置按钮块列表
local ListView_resetBtn = nil

local function GetCurrentBlock()
    --初始化小人位置
    local heroPos = Services.Static_MapObject.heroPos
    return Services.Static_MapObject.getMapTile(heroPos)
end

local eventEnabled = true
local function EventDisabled()
    if not eventEnabled then
        eventEnabled = true
        return true
    end
    eventEnabled = false
end

local function blockButtonCallback(sender)
    if EventDisabled() then return end
    --sender:addTouchEventListener(nil)
    local index = ListView_Block:getIndex(sender)
    local block = sender.BlockObject
    local x = sender:getPositionX()
    local y = sender:getPositionY()
    local worldPosition = sender:convertToWorldSpace({x,y})
    local size = block.Node:getContentSize()
    x = worldPosition.x+size.width/2
    y = worldPosition.y + size.height/2
    block.Node:setPosition(x, y)
    block.Node:setLocalZOrder(10)
    -- before add node in block, remove it first to avoid multi-times add.
    --Services.Static_MainScene.root:removeChild(block.Node)
    --Services.Static_MainScene.root:addChild(block.Node)
    block.Node:release()

    local heroPos = Services.Static_MapObject.heroPos
    --设置挂载 地图块
    Services.Static_MapObject.SetMapTile(block, heroPos)

    ListView_Block:removeItem(index)

    --local sequence = cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(x, y)), nil)
    --HeroObject.Block.Node:runAction(sequence)
end

local function addButton()
    local block = HeroObject.Block --Services.Static_BlockObject.CreateNormalBlock()
    block.Node:retain()
    local button = ccui.Button:create(block.FilePath)
    
    button.BlockObject = block
    local sprite = cc.Sprite:create("Image/Block/HighlightBlock.png")
    sprite:setAnchorPoint(0,0)
    sprite:setPosition(-4,-5)
    button.HighlightSprite = sprite
    button:addChild(sprite)

    ListView_Block:pushBackCustomItem(button)
    button:addTouchEventListener(blockButtonCallback)
    GenerateNewBlcok()
end

local function fillBlockButtonList()
	ListView_Block:removeAllItems()
	
	for i = 1, 3 do
        GenerateNewBlcok() 
        addButton()
    end

    HeroObject.DisableBlocksList()
end

local function resetButtonCallback(sender)

    local index = ListView_resetBtn:getIndex(sender)
    ListView_resetBtn:removeItem(index)
    fillBlockButtonList()
    
    local currentBlock = GetCurrentBlock()
    --如果是空格子,则更新可用块
    if currentBlock == nil then
        HeroObject.UpdateBlocksList()
    end
end

-- 初始化 重置按钮
local function fillResetButtonList()

    ListView_resetBtn:removeAllItems()
    local button = nil
    for i = 1, 3 do
        button = ccui.Button:create("Image/Button/ResetBlockNormal.png","Image/Button/ResetBlockPressed.png")
        ListView_resetBtn:pushBackCustomItem(button)
        button:addTouchEventListener(resetButtonCallback)
    end
    
end


function HeroObject.start()
    --初始化小人位置
    HeroObject.LastBlockObject = GetCurrentBlock()
    ListView_Block = Services.Static_MainScene["ListView_Block"]
    fillBlockButtonList()
    ListView_resetBtn = Services.Static_MainScene["ListView_resetBtn"]
    fillResetButtonList()    
    
    GenerateNewBlcok()           
end

-- JoyStick

local function ButtonUpCallback()
    HeroObject.MoveHero(UP,"Up")  
end

local function ButtonLeftCallback()
    HeroObject.MoveHero(LEFT,"Left")
end

local function ButtonDownCallback()
    HeroObject.MoveHero(DOWN,"Down")  
end

local function ButtonRightCallback()
    HeroObject.MoveHero(RIGHT,"Right")
end

function HeroObject.Restart()
    if EventDisabled() then 
        return 
    end
    Services.Static_MapObject.initMapData()
    Services.Static_MapObject.restart()
    HeroObject.start()
end

function HeroObject.Quit()
	--cc.Director.getInstance():endToLua()
end


function HeroObject.eventCallback(luaFileName, node, callbackName)
	if node:getName()== "ButtonUp" then	    
        return ButtonUpCallback
	end
	
    if node:getName()== "ButtonLeft" then
        return ButtonLeftCallback
    end
    
    if node:getName()== "ButtonDown" then
        return ButtonDownCallback
    end
    
    if node:getName()== "ButtonRight" then
        return ButtonRightCallback
    end
    if node:getName()== "Button_Restart" then
        return HeroObject.Restart
    end
    if node:getName()== "Button_Quit" then
        return HeroObject.Quit
    end
end

-- JoyStick
-- 控制小人不能重复移动, 多次触发
local isHeroMoving = false

function HeroObject.MoveHero(direction, animation)
    if EventDisabled() then 
       return 
    end
    if isHeroMoving then
    	return
    end
        
    --先移动小人,然后判断小人的位置是否有效
	print(animation)
	HeroObject.Animation:play(animation,false) 
	
	isHeroMoving = true
    local isOK = Services.Static_MapObject.MoveTo(direction)      
    --如果小人移动了, 则刷新
    if isOK then
        local currentBlock = GetCurrentBlock()
        --如果是空格子,则更新可用块
        if currentBlock == nil then
            HeroObject.LastDirection = direction
            HeroObject.UpdateBlocksList()
        else
            HeroObject.DisableBlocksList()
        end
    end
    
end



--禁用所有的格子
function HeroObject.DisableBlocksList()
    --初始格子都为空
    local items = ListView_Block:getItems()
    for key, var in pairs(items) do
        local button = var
        HeroObject.SetButtonState(button,false)
    end
end

--更新当前可以使用的格子, 根据小人移动过来的方向
function HeroObject.UpdateBlocksList()

    local reverseDirection = Services.Static_BlockObject.GetReverseDirection(HeroObject.LastDirection)
    
    local items = ListView_Block:getItems() 
    for key, var in pairs(items) do
        local button = var      
        local blockObject = button.BlockObject
        local isEnable = Services.Static_BlockObject.HasDirection(blockObject, reverseDirection)
        --只有在可用时才设置
        if isEnable then
            HeroObject.SetButtonState(button, isEnable)
        end
    end
        
end

--设置当前格子的状态
function HeroObject.SetButtonState(button, isEnable)
    button:setEnabled(isEnable)
    button.HighlightSprite:setVisible(isEnable)
end

--设置格子后, 生成新的格子
function HeroObject.TileMapSettedCallback()
    addButton()
    HeroObject.DisableBlocksList()
end

function HeroObject.MoveHeroEndCallback()
    isHeroMoving = false
end

return HeroObject