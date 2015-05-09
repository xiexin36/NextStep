Services = {}

local isInit = false 

Services.Static_TopRoot = nil

function Services.init()
    if isInit then
    	return
    end
    
	local heroObjectFile = require "src/app/HeroObject.lua"
	heroObjectFile.init()
	Services.Static_HeroObject = heroObjectFile

    local blockObj = require("src/app/BlockObject")
    Services.Static_BlockObject = blockObj

    local mapObj = require("src/app/MapObject")
	Services.Static_MapObject = mapObj
    Services.Static_MapObject.initMapData()

	isInit = true
end


function Services.showMainScene()
    Services.Static_TopRoot:removeAllChildren()
	local mainScene = Services.getMainScene()
	Services.Static_TopRoot:addChild(mainScene)
end

function Services.showSuccess()
    Services.Static_TopRoot:removeAllChildren()
    local successLayer = Services.getSuccessLayer()
    Services.Static_TopRoot:addChild(successLayer)
    
end

function Services.getStartLayer()
	local startLayerFile = require("app/StartLayer")
    Services.Static_StartLayer = startLayerFile
    
    local root = startLayerFile.create()	
    return root
end

function Services.getMainScene()
    
    if Services.Static_MainScene ~= nil then
    	return Services.Static_MainScene.root
    end
    
    Services.init()

    local mainSceneFile = require "res/MainScene.lua"
    
    local result = mainSceneFile.create(Services.Static_HeroObject.eventCallback)
    --保留主场景
    result.root:retain()
    
    Services.Static_MainScene = result
    result.root:addChild(Services.Static_HeroObject.Node)

    Services.Static_HeroObject.start()
    Services.Static_MapObject.start()

    return result.root
end

function Services.getSuccessLayer()
    if Services.Static_SuccessLayer ~=nil then
    	return Services.Static_SuccessLayer.LoadResult.root
    end
    local successLayerFile = require("app.SuccessLayer")
    Services.Static_SuccessLayer = successLayerFile

    local root = successLayerFile.create()    
    return root
end

-- Init ramdomize seed
math.randomseed(os.time())

return Services 