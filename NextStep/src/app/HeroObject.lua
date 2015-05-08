local HeroObject = {}

function HeroObject.init()
    local heroNodeFile = require "res/HeroNode.lua"
    local result = heroNodeFile.create()
    result.root:runAction(result.animation)
    HeroObject.Node = result.root
    HeroObject.Animation = result.animation
       
end

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
end

function ButtonLeftCallback()
    print("Left") 
    HeroObject.Animation:play("Left",false)  
end

function ButtonDownCallback()
    print("Down") 
    HeroObject.Animation:play("Down",false)  
end

function ButtonRightCallback()
    print("Right") 
    HeroObject.Animation:play("Right",false)  
end

return HeroObject