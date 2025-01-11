-- Adjust foundries, chem plants, and cryo plants to allow lava connections.
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