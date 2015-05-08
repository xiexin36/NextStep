local Services = {}

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

	isInit = true
end

return Services 