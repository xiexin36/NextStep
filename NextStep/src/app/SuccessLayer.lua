local SuccessLayer = {}

SuccessLayer.LoadResult = nil


local function buttonTryAgainCallback()
    Services.showMainScene()
    Services.Static_HeroObject.Restart()
end

local function buttonQuitCallback()
    Services.Static_HeroObject.Quit()
end

local function callBackProvider(luaFileName, node, callbackName)
    if node:getName() == "ButtonTryAgain" then     
        return buttonTryAgainCallback
    end
    if node:getName() == "ButtonQuit" then     
        return buttonQuitCallback
    end
end

function SuccessLayer.create()
	local layerFile = require("res/Success")
	local result = layerFile:create()
	SuccessLayer.LoadResult = result
	result.root:retain()
	
	return result.root
end


return SuccessLayer