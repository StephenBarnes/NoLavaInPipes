-- Fluid is held in "fluid boxes". Fluid boxes have pipe_connections, which can have connection_category bitmask.
-- In space-age, they make a connection_category "fusion-plasma" to stop you putting plasma in pipes.
-- So we use this same mechanism with lava. Lava is only allowed in the pipe connections of lava pumps and foundries, not pipes.
-- There is a connection category called "default" which allows general fluids. So we need foundries to also allow that.
-- If a pipe_connection has multiple categories, it allows all of them.
-- So, foundries need to have connection_category {"default", "lava"}. And then we need to make a new "lava pump" entity that only allows "lava".

-- Code to add lava category to assembling-machines's fluid boxes are in data-updates, not data, so that mods can add new assembling-machines or fluidboxes in data.

-- Create new lava pump item.
local lavaPumpItem = table.deepcopy(data.raw.item["offshore-pump"])
lavaPumpItem.order = lavaPumpItem.order .. "-lava"
lavaPumpItem.name = "lava-pump"
lavaPumpItem.place_result = "lava-pump"
lavaPumpItem.icons = {
	{
		icon = "__base__/graphics/icons/offshore-pump.png",
	},
	{
		icon = "__space-age__/graphics/icons/fluid/lava.png",
		scale = 0.3,
		shift = {7, -5},
	},
}

-- Create new lava pump entity.
local lavaPumpEntity = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
lavaPumpEntity.name = "lava-pump"
lavaPumpEntity.minable.result = "lava-pump"
lavaPumpEntity.fluid_box.pipe_connections[1].connection_category = "lava"

-- Create recipe for lava pump.
-- For offshore pump, recipe is 2 iron gear wheel + 3 pipe.
-- When starting on Vulcanus, you have stone, and iron+copper+tungsten ores, and carbon. Also after mining 1 rock you can make tungsten carbide.
-- So, make the recipe 2 iron gear wheel + 3 pipe + some tungsten carbide.
local lavaPumpRecipe = table.deepcopy(data.raw["recipe"]["offshore-pump"])
lavaPumpRecipe.name = "lava-pump"
table.insert(lavaPumpRecipe.ingredients, {type="item", name="tungsten-carbide", amount=5})
lavaPumpRecipe.results = { {type="item", name="lava-pump", amount=1} }
lavaPumpRecipe.main_product = "lava-pump"

-- Add lava pump recipe to tech.
table.insert(data.raw.technology.foundry.effects, 1, {type="unlock-recipe", recipe="lava-pump"})

-- Block placement of normal pumps on Vulcanus.
-- Could do this with a new collision layer for lava, but it's easier to just block building them on Vulcanus.
data.raw["offshore-pump"]["offshore-pump"].surface_conditions = {
	{
		property = "pressure",
		max = 3000,
	},
}

-- Also block placement of lava pumps anywhere but Vulcanus, so that people don't try to use them as water pumps on eg Nauvis and then they won't connect to pipes.
lavaPumpEntity.surface_conditions = {
	{
		property = "pressure",
		min = 3000,
	},
}

data:extend({
	lavaPumpItem,
	lavaPumpEntity,
	lavaPumpRecipe,
})