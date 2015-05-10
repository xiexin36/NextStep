local StartLayer = {}

StartLayer.LoadResult = nil

local function startAnimationFinished()
    Services.showMainScene()
    Services.Static_TopRoot:removeChild(StartLayer.LoadResult.root, true)
end

local function buttonStartCallback()
    for i = 3,5 do
        local tempNode = StartLayer.LoadResult.root:getChildByTag(i)
        if nil ~= tempNode then
            tempNode:setVisible(false)
        end
    end

    local backNode = StartLayer.LoadResult.root:getChildByTag(2)
    
    local spanAni = cc.Spawn:create(cc.ScaleBy:create(1.2, 1.5), cc.MoveBy:create(1.2, cc.vertex2F(120, 0)), cc.FadeOut:create(1.3))
    local sequence = cc.Sequence:create(spanAni,
        cc.CallFunc:create(startAnimationFinished))
    backNode:runAction(sequence)
end

local function callBackProvider(luaFileName, node, callbackName)
    if node:getName() == "Button_Start" then     
        return buttonStartCallback
    end
end

function StartLayer.create()
	local startLayerFile = require("res/Start.lua")
	local result = startLayerFile.create(callBackProvider)
	StartLayer.LoadResult = result
	return result.root
end

return StartLayer