data:extend({
	-- Startup
	{
		type = "bool-setting",
		name = "SnisSetting-inventory_size",
		setting_type = "startup",
		default_value = true,
		order = "a",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "SnisSetting-loader",
		setting_type = "startup",
		default_value = true,
		order = "a",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "SnisSetting-loader-sapping",
		setting_type = "startup",
		default_value = true,
		order = "a",
		per_user = true
	},
	{
		type = "bool-setting",
		name = "SnisSetting-toolbelt",
		setting_type = "startup",
		default_value = true,
		order = "a",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "SnisSetting-logistic",
		setting_type = "startup",
		default_value = true,
		order = "a",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "SnisSetting-waterfill",
		setting_type = "startup",
		default_value = true,
		order = "a",
		per_user = false
	},
	-- Global
--	{
--		type = "bool-setting",
--		name = "SnisSetting-",
--		setting_type = "runtime-global",
--		default_value = true,
--		order = "a",
--		per_user = false
--	},
})
