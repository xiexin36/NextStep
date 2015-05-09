local SuccessLayer = {}

SuccessLayer.LoadResult = nil


local function buttonTryAgainCallback()   
    Services.Static_TopRoot:removeChild(SuccessLayer.LoadResult.root)
    Services.showMainScene()
    Services.Static_HeroObject.Restart()
    -- 强制刷新EventEnable
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
    local result = layerFile.create(callBackProvider)
	SuccessLayer.LoadResult = result
	result.root:retain()
	
	return result.root
end


return SuccessLayer