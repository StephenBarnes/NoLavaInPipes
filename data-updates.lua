-- Adjust foundries, chem plants, cryo plants, assembling machines to allow lava connections.
-- This is data-updates, not data, in case mods add new assembling-machines or new fluidboxes.
for _, machine in pairs(data.raw["assembling-machine"]) do
	for _, fluidBox in pairs(machine.fluid_boxes or {}) do
		if fluidBox.production_type == "input" then
			for _, pipeConnection in pairs(fluidBox.pipe_connections or {}) do
				if pipeConnection.connection_category == nil then
					pipeConnection.connection_category = {"default", "lava"}
				elseif type(pipeConnection.connection_category) == "string" then
					pipeConnection.connection_category = {pipeConnection.connection_category, "lava"}
				else
					table.insert(pipeConnection.connection_category, "lava")
				end
			end
		end
	end
end

-- If setting is enabled, also block foundry fluid outputs from connecting to pipes.
if settings.startup["NoLavaInPipes-block-foundry-outputs"].value then
	for _, fluidBox in pairs(data.raw["assembling-machine"]["foundry"].fluid_boxes) do
		if fluidBox.production_type == "output" then
			for _, pipeConnection in pairs(fluidBox.pipe_connections) do
				pipeConnection.connection_category = {"lava"}
			end
		end
	end
end