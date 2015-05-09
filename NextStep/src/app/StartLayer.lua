local StartLayer = {}


local function buttonStartCallback()
    Services.showMainScene()
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