-- AutoMirror
-- This work is released into the public domain
-- Authored by kaen

local sd = require('stardust')

function getArgsMenu()

	local menu = { }
	if #plugin:getSelectedObjects() ~= 0 then
		local ext = sd.mergeExtents(plugin:getSelectedObjects())

		-- zero or positive numbers mean all objects are on one side of the axis, so
		-- we can make a reasonable guess about how to flip it
		autoFlipX = ext.minx * ext.maxx >= 0
		autoFlipY = ext.miny * ext.maxy >= 0

		if not (autoFlipY or autoFlipX) then
			menu[1] = ToggleMenuItem.new("Axis", { "X", "Y" }, 1, "Axis to mirror across")
		end
	end

	return "AutoMirror", "Mirror selection across axes", "Ctrl+Shift+\\", menu

end

function main()
	local objects = plugin:getSelectedObjects()
	local flipX = arg[1] == 'X' or autoFlipX
	local flipY = arg[1] == 'Y' or autoFlipY

	if #objects == 0 then
		plugin:showMessage('Please select at least one object', false)
		return
	end

	for _, obj in pairs(objects) do

		if flipX then
			local new = sd.clone(obj)
			new:setGeom(Geom.flip(obj:getGeom(), true))
			bf:addItem(new)
		end

		if flipY then
			local new = sd.clone(obj)
			new:setGeom(Geom.flip(obj:getGeom(), false))
			bf:addItem(new)
		end

		if flipY and flipX then
			local new = sd.clone(obj)
			new:setGeom(Geom.flip(Geom.flip(obj:getGeom(), false), true))
			bf:addItem(new)
		end
	end
end   

