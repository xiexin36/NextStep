Services = {}

LEFT_SIDE  = 1
RIGHT_SIDE = 2
UP_SIDE    = 3
DOWN_SIDE  = 4

local isInit = false 

function Services.init()
    if isInit then
    	return
    end
    
	local heroObjectFile = require "src/app/HeroObject.lua"
	heroObjectFile.init()
	Services.Static_HeroObject = heroObjectFile

    local mapObj = require("src/app/MapObject")
	Services.Static_MapObject = mapObj
    Services.Static_MapObject.initMapData()

	isInit = true
end


function Services.getMainScene()
    local mainSceneFile = require "res/MainScene.lua"
    
    local result = mainSceneFile.create(Services.Static_HeroObject.JoyStickCallback)
    
    Services.Static_MainScene = result    
    result.root:addChild(Services.Static_HeroObject.Node)
    result.root:addChild(Services.Static_MapObject.treasureNode)
    result.root:addChild(Services.Static_MapObject.outDoorNode)

    return result.root
end


return Services 