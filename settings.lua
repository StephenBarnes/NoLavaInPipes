-- Create setting for whether to also block foundry outputs from connecting to pipes.
data:extend{
	{
		type = "bool-setting",
		name = "NoLavaInPipes-block-foundry-outputs",
		setting_type = "startup",
		default_value = false,
		order = "a",
	}
}