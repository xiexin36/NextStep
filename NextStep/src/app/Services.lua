cc.exports.Services = {}

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
    
    cc.exports.Services.Static_MainScene = result    
    result.root:addChild(Services.Static_HeroObject.Node)

      
    return result.root
end


return cc.exports.Services 