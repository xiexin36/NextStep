--[[
一个简单的示例，新建了一个精灵，并在精灵上放置了一个文本。
当调用 CreateCustomNode 时，会生成这个精灵并返回。
]]

-- 新建一个 Node，这里我们新建了一个精灵。
-- 新建精灵时传入了一个图片路径作为参数。
local function CreateMyNode()
	return cc.Sprite:create('temp.png') --图片资源请放在本文件所在目录
end

-- 新建一个 Label，用以显示文字
local function CreateLabel()
	local label = cc.Label:create()
	label:setString('User0 Label From Lua')
	label:setSystemFontSize(24)
	label:setPosition(100, 100)
	label:setName('xlabelx') --设置 label 的名字，这个 label 的名字在下面会用到。
	label:retain()
	return label
end

-- 新建一个 table，避免全局变量污染。用以包括脚本中所定义的所有的全局方法。
local container = {}

-- 新建 Node，目前这个方法的名字为固定的，必须为 CreateCustomNode。
-- 方法的最后一句必须是一个 return 语句，把新建的结点返回。
function container.CreateCustomNode()
	local rootNode = CreateMyNode()
	rootNode:addChild(CreateLabel())
	return rootNode
end

-- 返回该插件所扩展的基础类型。
function container.GetBaseType()
    return 'Sprite'
end

-- 取得一个字符串。
-- root 参数即为调用 CreateCustomNode 时返回的根结点。
-- varName 参数名字，根据它可取得相应的字符串变量的值。
-- 比如，这里我们如果传入的 varName 不是 "StringValue" 的话，则什么也不做，直接返回。
-- C# 层调用时要保证这个值和 Lua 中相应的值的对应关系。
-- 现在 C# 的 LuaObject 类中有字符串属性 StringValue，在其 get 方法中传入变量名字 "StringValue"。
-- 注意，这个名字可以是任意有效的字符串，只要能唯一的标识出相应的变量即可。
function container.GetStringValue(root)
	local child = root:getChildByName('xlabelx') --根据 child 的名字取得相应的 child
	return child:getString()
end

-- 设置字符串的值。
-- root 参数即为调用 CreateCustomNode 时返回的根结点。
-- varName 参数名字，根据它对相应的字符串变量赋值。
-- value 所赋的字符串的值。
-- 比如，这里我们如果传入的 varName 不是 "StringValue" 的话，则什么也不做，直接返回。
-- C# 层调用时要保证这个值和 Lua 中相应的值的对应关系。
-- 现在 C# 的 LuaObject 类中有字符串属性 StringValue，在其 set 方法中传入变量名字 "StringValue"。
-- 注意，这个名字可以是任意有效的字符串，只要能唯一的标识出相应的变量即可。
function container.SetStringValue(root, value)
	-- 在父控件中查找名字为 'xlabelx' 的子控件。
	local child = root:getChildByName('xlabelx')
	child:setString(value..'0')
end

-- 取得一个整型数值。
function container.GetIntValue(root)
	local child = root:getChildByName('xlabelx')
	return child:getSystemFontSize()
end

-- 设置一个整形数值。
function container.SetIntValue(root, value)
	local child = root:getChildByName('xlabelx')
	child:setSystemFontSize(value)
end

-- 取得一个浮点数值。
function container.GetNumber(root)
	--local child = root:getChildByName('xlabelx')
	--return child:getSystemFontSize()
end

-- 设置一个浮点数值。
function container.SetNumber(root, value)
	--local child = root:getChildByName('xlabelx')
	--child:setSystemFontSize(value)
end

-- 取得一个布尔值。
function container.GetBoolValue(root)
	local child = root:getChildByName('xlabelx')
	return child:isVisible()
end

-- 设置一个布尔值。
function container.SetBoolValue(root, value)
	local child = root:getChildByName('xlabelx')
	child:setVisible(value)
end

-- 取得一个颜色值。
function container.GetColor3BValue(root)
	return root:getColor()
end

-- 设置一个颜色值。
function container.SetColor3BValue(root, value)
    --root:setColor({r=0, g=128, b=0})
	root:setColor(value)
end

-- 返回纹理文件名字
function container.GetTexture(root)
    return 'temp.png'
end

-- 设置纹理
function container.SetTexture(root, value, resType)
    if value == '' then
        root:setTexture('temp.png')
        return
    end
    if resType == 1 then
        root:setTexture(value)
    else
        root:setTexture(value)
    end
end

-- 返回这个包含所有全局方法的表
return container