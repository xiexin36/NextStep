local OpenLayer = {}


local function ContinueCallback()
    Services.Static_MainScene.root:removeChild(OpenLayer.Node, true)
end

local function callBackProvider(luaFileName, node, callbackName)
    if node:getName() == "ButtonContinue" then     
        return ContinueCallback
    end
end

function OpenLayer.create()
    local startLayerFile = require("res/OpenAniLayer.lua")
    local result = startLayerFile.create(callBackProvider)
    Services.Static_MainScene.root:addChild(result.root)
    result.root:setLocalZOrder(300)
    OpenLayer.Node = result.root
    result["OpenAnimation"].animation:gotoFrameAndPlay(0,false)
    return result.root
end

return OpenLayer