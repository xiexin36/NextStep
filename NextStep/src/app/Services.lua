cc.exports.Services = {}

local isInit = false 

function Services.init()
    if isInit then
    	return
    end
    
	local heroObjectFile = require "src/app/HeroObject.lua"
	heroObjectFile.init()
	Services.Static_HeroObject = heroObjectFile
	
	isInit = true
end

return cc.exports.Services 