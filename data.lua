-- Fluid is held in "fluid boxes". Fluid boxes have pipe_connections, which can have connection_category bitmask.
-- In space-age, they make a connection_category "fusion-plasma" to stop you putting plasma in pipes.
-- So we use this same mechanism with lava. Lava is only allowed in the pipe connections of lava pumps and foundries, not pipes.
-- There is a connection category called "default" which allows general fluids. So we need foundries to also allow that.
-- If a pipe_connection has multiple categories, it allows all of them.
-- So, foundries need to have connection_category {"default", "lava"}. And then we need to make a new "lava pump" entity that only allows "lava".

-- Code to add lava category to assembling-machines's fluid boxes are in data-updates, not data, so that mods can add new assembling-machines or fluidboxes in data.

-- Create new lava pump entity.
-- Offshore pumps placed on Nauvis will be automatically converted into lava pumps.
local lavaPumpEntity = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
lavaPumpEntity.name = "lava-pump"
lavaPumpEntity.fluid_box.pipe_connections[1].connection_category = "lava"
lavaPumpEntity.placeable_by = {item = "offshore-pump", count = 1}
lavaPumpEntity.icons = {
	{
		icon = "__base__/graphics/icons/offshore-pump.png",
	},
	{
		icon = "__space-age__/graphics/icons/fluid/lava.png",
		scale = 0.3,
		shift = {7, -5},
	},
}
lavaPumpEntity.hidden_in_factoriopedia = true
lavaPumpEntity.factoriopedia_alternative = "offshore-pump"
data:extend({lavaPumpEntity})