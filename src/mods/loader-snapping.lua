local offsets = {
    [defines.direction.north] = {0, -1.5},
    [defines.direction.south] = {0, 1.5},
    [defines.direction.east] = {1.5, 0},
    [defines.direction.west] = {-1.5, 0}
}
local function add_position(position, x, y)
    return {position.x + (x or 0), position.y + (y or 0)}
end

local function check_loader(entity, e)
    local name, position, surface, force, direction,loader_type,last_user = entity.name, entity.position, entity.surface, entity.force, entity.direction, entity.loader_type, entity.last_user
    local filters = {}
    for slot = 1, entity.filter_slot_count do
        filters[slot] = entity.get_filter(slot)
    end
    entity.destroy()
    local output_offset = offsets[direction]
    local output_position = add_position(position, output_offset[1], output_offset[2])
    local output_entity = surface.find_entities_filtered{position=output_position, force=force}[1]
    local inverted_direction = (direction + 4) % 8
    if output_entity and output_entity.has_flag("player-creation") then -- Make sure that it isn't a tree or something
        if (output_entity.type == "loader" or output_entity.type == "transport-belt" or output_entity.type == "splitter"
         or (output_entity.type == "underground-belt" and output_entity.belt_to_ground_type ~= "input")) then
	         if output_entity.direction == inverted_direction then -- If the entity is one that loader belt can input from and it is facing the opposite direction then rotate the loader to connect to it
	            direction = (direction + 4) % 8
	            loader_type = "input"
			else
				loader_type = "output"
			end
        elseif output_entity.type ~= "transport-belt" and output_entity.type~="underground-belt"
        and output_entity.type ~= "splitter" and (output_entity.type ~= "loader" or output_entity.loader_type == "output") then
            -- If the entity is not one that can give belt input to the loader then change it to output to that square.
            loader_type = "input"
        else
            loader_type = "output"
        end
    end
	inverted_direction = (direction + 4) % 8
    local input_offset = offsets[inverted_direction]
    local input_position = add_position(position, input_offset[1], input_offset[2])
    local input_entity = surface.find_entities_filtered{position=input_position, force=force}[1]
    if input_entity and input_entity.has_flag("player-creation") then
        if (input_entity.type == "transport-belt" or input_entity.type == "splitter" or (input_entity.type == "underground-belt" and input_entity.belt_to_ground_type ~= "input") or input_entity.type == "loader")  then
            if input_entity.direction == inverted_direction then
                direction = (direction + 4) % 8
                loader_type = "output"
            else
                loader_type = "input"
            end
            if input_entity.type == "loader" then
                loader_type = input_entity.loader_type == "input" and "output" or "input"
            end
        else
            loader_type = "output"
        end
    end
    local new = surface.create_entity{name=name, position=position, force=force, direction=direction,type=loader_type}
    if new and new.valid then
        for slot, filter in pairs(filters) do
            new.set_filter(slot, filter)
        end
		if last_user then
            new.last_user = last_user
		end
        script.raise_event(defines.events.on_built_entity, {corrected_loader=true, player_index=e.player_index, created_entity=new})
    end
end

script.on_event(defines.events.on_built_entity, function(e)
    if e.corrected_loader then return end
    global.lrf_disabled = global.lrf_disabled or {}
    if global.lrf_disabled[e.player_index] then return end
    local entity = e.created_entity
    if entity.valid then
        if entity.type == "loader" then
            check_loader(entity, e)
        else
            local position=entity.position
            local box = entity.prototype.selection_box
            local checkArea = {{position.x+box.left_top.x-1, position.y+box.left_top.y-1}, {position.x+box.right_bottom.x+1, position.y+box.right_bottom.y+1}}
            for _, loader in pairs(entity.surface.find_entities_filtered{type="loader", area=checkArea}) do
                check_loader(loader, e)
            end
        end
    end
end)

script.on_event(defines.events.on_player_rotated_entity, function(e)
    global.lrf_disabled = global.lrf_disabled or {}
    if global.lrf_disabled[e.player_index] then return end
    local entity = e.entity
    if not entity.valid or entity.type == "loader" then return end
    local position=entity.position
    local box = entity.prototype.selection_box
    local checkArea = {{position.x+box.left_top.x-1, position.y+box.left_top.y-1}, {position.x+box.right_bottom.x+1, position.y+box.right_bottom.y+1}}
    for _, loader in pairs(entity.surface.find_entities_filtered{type="loader", area=checkArea}) do
        check_loader(loader, e)
    end
end)

script.on_event("lrf-toggle", function(event)
    global.lrf_disabled = global.lrf_disabled or {}
    local player = game.players[event.player_index]
    local newSetting = not global.lrf_disabled[player.index]
    if newSetting then
        player.print({"lrf-toggled-off"})
    else
        player.print({"lrf-toggled-on"})
    end
    global.lrf_disabled[player.index] = newSetting
end)
