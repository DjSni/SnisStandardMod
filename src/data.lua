require("config")

-- Loader Hinzuf�gen
if settings.startup["SnisSetting-loader"].value == true then
	require("mods.loader")
end

-- Loader-Snapping
if settings.startup["SnisSetting-loader-sapping"].value == true then
	require("mods.loader-snapping-toggle")
end

-- Gr��eren Inventar
local inven_big = (settings.startup["SnisSetting-inventory_size"].value)
if inven_big == true then
	require("mods.inventory")
end

-- Gr��eren Werkzeugg�rtel
if settings.startup["SnisSetting-toolbelt"].value == true then
	require("mods.toolbelt")
end

-- logistic (trash) slots
if settings.startup["SnisSetting-logistic"].value == true then
	require("mods.logistic")
end

