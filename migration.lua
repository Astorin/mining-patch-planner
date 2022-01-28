local conf = require("configuration")

local current_version = 010100 -- 1.1.0

---@param player LuaPlayer
local function reset_gui(player)
	if player.gui.left["mpp_settings_frame"] then
		local cursor_stack = player.cursor_stack
		if cursor_stack and cursor_stack.valid and cursor_stack.valid_for_read and cursor_stack.name == "mining-patch-planner" then
			cursor_stack.clear()
		end
		player.gui.left["mpp_settings_frame"].destroy()
	end
end

script.on_configuration_changed(function(config_changed_data)
    if config_changed_data.mod_changes["mining-patch-planner"] then
		local version = global.version or 0

		if version < current_version then
			global.tasks = {}
			for player_index, data in ipairs(global.players) do
				---@type LuaPlayer
				local player = game.players[player_index]
				reset_gui(player)
				conf.initialize_global(player_index)
			end
		end
		global.version = current_version
    end
end)
