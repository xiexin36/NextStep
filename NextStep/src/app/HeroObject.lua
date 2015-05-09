local HeroObject = {}

--上次站立的有效位置
HeroObject.LastBlockObject = nil
HeroObject.LastDirection = nil

function HeroObject.init()
    local heroNodeFile = require "res/HeroNode.lua"
    local result = heroNodeFile.create()
    result.root:runAction(result.animation)
    HeroObject.Node = result.root
    HeroObject.Node:setLocalZOrder(100)
    HeroObject.Animation = result.animation
    
end

local ListView_Block

local function GetCurrentBlock()
    --初始化小人位置
    local heroPos = Services.Static_MapObject.heroPos
    return Services.Static_MapObject.getMapTile(heroPos)
end

local function blockButtonCallback(sender)
    --sender:addTouchEventListener(nil)
    local index=ListView_Block:getIndex(sender)
    local block = sender.BlockObject
    local x = sender:getPositionX()
    local y = sender:getPositionY()
    local worldPosition = sender:convertToWorldSpace({x,y})
    local size = block.Node:getContentSize()
    x = worldPosition.x+size.width/2
    y = worldPosition.y + size.height/2
    block.Node:setPosition(x, y)
    block.Node:setLocalZOrder(10)
    --block.Node:setColor({100,100,100})  
    Services.Static_MainScene.root:addChild(block.Node)
    block.Node:release()

    local heroPos = Services.Static_MapObject.heroPos
    --设置挂载 地图块
    Services.Static_MapObject.SetMapTile(block, heroPos)

    ListView_Block:removeItem(index)

    --addButton(index)
end

local function addButton(index)

    local block = Services.Static_BlockObject.CreateNormalBlock()
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

end

function HeroObject.start()
    --初始化小人位置
    HeroObject.LastBlockObject = GetCurrentBlock()
    
    
    ListView_Block = Services.Static_MainScene["ListView_Block"]
    addButton(0)
    addButton(1)
    addButton(2)
    
    HeroObject.DisableBlocksList()
end

-- JoyStick

local eventEnabled = true
local function EventDisabled()
    if not eventEnabled then
        eventEnabled = true
        return true
    end
    eventEnabled = false
end


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


function HeroObject.JoyStickCallback(luaFileName, node, callbackName)
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
end

-- JoyStick

function HeroObject.MoveHero(direction, animation)
    if EventDisabled() then 
       return 
    end

    --先移动小人,然后判断小人的位置是否有效
	print(animation)
	HeroObject.Animation:play(animation,false) 
    Services.Static_MapObject.MoveTo(direction)
    
    local currentBlock = GetCurrentBlock()
    
    --如果是空格子,则更新可用块
    if currentBlock == nil then 	
    	HeroObject.LastDirection = direction
    	HeroObject.UpdateBlocksList()
    else
        HeroObject.LastBlockObject = currentBlock
        HeroObject.DisableBlocksList()
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

--更新当前可以使用的格子, 根据当前小人所处的位置
function HeroObject.UpdateBlocksList()	
	local items = ListView_Block:getItems()
	
    for key, var in pairs(items) do
		local button = var
		
        local blockObject = button.BlockObject
        local isEnable = Services.Static_BlockObject.HasDirection(HeroObject.LastBlockObject, HeroObject.LastDirection)
        HeroObject.SetButtonState(button, isEnable)
	end

end

function HeroObject.SetButtonState(button, isEnable)
    button:setEnabled(isEnable)
    button.HighlightSprite:setVisible(isEnable)
end

function HeroObject.TileMapSettedCallback()
    addButton()
    HeroObject.DisableBlocksList()
end

return HeroObject