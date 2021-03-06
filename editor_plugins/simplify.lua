-- Polygon simplification
-- Simplify (a.k.a smooth) polygons using midpoint reduction
-- This work is released into the public domain
-- Authored by kaen
local sd = require('stardust')

function getArgsMenu()
	return "Simplify I", "Simplify polygons by removing a single vertex", "Ctrl+-"
end

function main()

	local objects = plugin:getSelectedObjects()

	for k, v in pairs(objects) do
		if type(v:getGeom()) == "table" then
			newGeom = sd.simplify(v:getGeom())
			v:setGeom(newGeom)
		end
	end
end   

