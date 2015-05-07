--[[
一个简单的示例，新建一个精灵，并在精灵上放置了一个文本。
当调用 CreateCustomNode 时，会生成这个精灵并返回。
]]

-- 新建一个精灵。
-- 新建精灵时传入了一个图片路径作为参数。
local function CreateSprite()
    return cc.Sprite:create('temp.png') --图片资源请放在本文件所在目录 (LuaScript 目录)
end

-- 新建一个 Label，用以显示文字
local function CreateLabel()
    local label = cc.Label:create()
    label:setString('sprite0 Label from Lua')
    label:setSystemFontSize(24)
    label:setPosition(140, 50)
    label:setName('labelName') --设置 label 的名字，这个 label 的名字在下面会用到。
    label:retain()
    return label
end

-- 新建一个 table，避免全局变量污染。用以包括脚本中所定义的所有的全局方法。
local container = {}

-- 新建根节点 Node，目前这个方法的名字为固定的，必须为 CreateCustomNode。
-- 方法的最后一句必须是一个 return 语句，把新建的结点返回。
function container.CreateCustomNode()
    local rootNode = CreateSprite()
    rootNode:addChild(CreateLabel())
    return rootNode
end

-- 返回该插件所扩展的基础类型。
function container.GetBaseType()
    return 'Sprite'
end

-- 取得精灵上文本的内容。
-- root 参数即为调用 CreateCustomNode 时返回的根结点。
function container.GetLabelText(root)
    -- 在父控件中查找名字为 'labelName' 的子控件。
    local child = root:getChildByName('labelName')
    return child:getString()
end

-- 设置精灵上文本的内容。
-- root 参数即为调用 CreateCustomNode 时返回的根结点。
-- value 所赋的字符串的值。
function container.SetLabelText(root, value)
    -- 在父控件中查找名字为 'labelName' 的子控件。
    local child = root:getChildByName('labelName')
    child:setString(value)
end

-- 取得精灵上文本的字体大小。
function container.GetLabelFont(root)
    local child = root:getChildByName('labelName')
    return child:getSystemFontSize()
end

-- 设置精灵上文本的字体大小。
function container.SetLabelFont(root, value)
    local child = root:getChildByName('labelName')
    child:setSystemFontSize(value)
end

-- 取得精灵上文本是否显示。
function container.GetLabelVisible(root)
    local child = root:getChildByName('labelName')
    return child:isVisible()
end

-- 设置精灵上文本是否显示。
function container.SetLabelVisible(root, value)
    local child = root:getChildByName('labelName')
    child:setVisible(value)
end

-- 取得精灵的混合颜色。
function container.GetMixedColor(root)
    return root:getColor()
end

-- 设置精灵的混合颜色。
function container.SetMixedColor(root, value)
    root:setColor(value)
end

-- 返回纹理文件名字
function container.GetSetTextureResource(root)
    return 'temp.png'
end

-- 设置纹理
-- value 为资源的路径
-- resType 是 TextureResType 类型
-- enum class TextureResType
-- {
--     LOCAL = 0,
--     PLIST = 1
-- };
-- 这里仅为了展示接口的签名。传入的 resType 为 0。
function container.SetTextureResource(root, value, resType)
    if value == '' then -- 没有给资源，则用默认图片处理。
        root:setTexture('temp.png')
        return
    end
    if resType == 0 then -- 如果资源为 LOCAL 类型，设置纹理。
        root:setTexture(value)
    else
        root:setTexture(value)
    end
end

-- 返回这个包含所有全局方法的表
return container