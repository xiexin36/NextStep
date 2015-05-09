local HeroObject = {}

function HeroObject.init()
    local heroNodeFile = require "res/HeroNode.lua"
    local result = heroNodeFile.create()
    result.root:runAction(result.animation)
    HeroObject.Node = result.root
    HeroObject.Node:setLocalZOrder(100)
    HeroObject.Animation = result.animation
    
end

local ListView_Block

function HeroObject.start()
    ListView_Block = Services.Static_MainScene["ListView_Block"]
    addButton(0)
    addButton(1)
    addButton(2)
end


function addButton(index)
    
    local block = Services.Static_BlockObject.CreateNormalBlock()
    block.Node:retain()
    local button = ccui.Button:create(block.FilePath)
    button.BlockObject = block
      
    ListView_Block:insertCustomItem(button , index)
    button:addTouchEventListener(blockButtonCallback)
    
end

function blockButtonCallback(sender)
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
    
    ListView_Block:removeItem(index)
      
    --addButton(index)
end

-- JoyStick
function HeroObject.JoyStickCallback(luaFileName, node, callbackName)
	if node:getName()== "ButtonTop" then	    
        return ButtonTopCallback
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

function ButtonTopCallback()
    print("Up")
    HeroObject.Animation:play("Up",false) 
    Services.Static_MapObject.MoveTo(UP)  
end

function ButtonLeftCallback()
    print("Left") 
    HeroObject.Animation:play("Left",false)  
    Services.Static_MapObject.MoveTo(LEFT)
end

function ButtonDownCallback()
    print("Down") 
    HeroObject.Animation:play("Down",false)
    Services.Static_MapObject.MoveTo(DOWN)  
end

function ButtonRightCallback()
    print("Right") 
    HeroObject.Animation:play("Right",false) 
    Services.Static_MapObject.MoveTo(RIGHT) 
end
-- JoyStick

return HeroObject