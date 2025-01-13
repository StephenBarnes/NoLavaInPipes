---@param entity LuaEntity
local function replaceWithLavaPump(entity)
	-- Replace this offshore pump with a "lava-pump" entity.
	if entity == nil or not entity.valid then return end
	if entity.name ~= "offshore-pump" or entity.type ~= "offshore-pump" then return end
    local surface = entity.surface
    local info = {
        name = "lava-pump",
        position = entity.position,
        quality = entity.quality,
        force = entity.force,
        fast_replace = true,
        player = entity.last_user,
		orientation = entity.orientation,
		direction = entity.direction,
    }
    entity.destroy()
    surface.create_entity(info)
end

-- When a game is loaded, replace all pumps on Vulcanus with lava-pumps.
local function initialScan()
	if game.surfaces["vulcanus"] == nil then
		return
	end
    for _, offshorePump in pairs(game.surfaces["vulcanus"].find_entities_filtered{name="offshore-pump"}) do
		replaceWithLavaPump(offshorePump)
	end
end
script.on_init(initialScan)

-- When a pump is built on Vulcanus, replace it with a lava-pump.
local function onBuilt(event)
	if event.entity ~= nil and event.entity.surface ~= nil and event.entity.surface.name ~= "vulcanus" then return end
	replaceWithLavaPump(event.entity)
end
local eventFilters = {{filter = "name", name = "offshore-pump"}}
script.on_event(defines.events.on_built_entity, onBuilt, eventFilters)
script.on_event(defines.events.on_robot_built_entity, onBuilt, eventFilters)