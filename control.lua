local mod_gui = require("mod-gui")

if not gamespeedboosted then
	gamespeedboosted = nil
end

local function create_gui(player)
	if not player or not player.valid then return end
	if settings.get_player_settings(player)["tsp_speedboostbutton"].value then
		local button_flow = mod_gui.get_button_flow(player)
		if not button_flow.togglespeedboost_button then
			button_flow.add {
				type = "sprite-button",
				name = "togglespeedboost_button",
				sprite = "togglespeedboost_off_button",
				style = "slot_button",
				tooltip = {"", {'speedboost.togglespeedboost_button'}, game.speed}
			}
		end
	elseif not settings.get_player_settings(player)["tsp_speedboostbutton"].value then
		local button_flow = mod_gui.get_button_flow(player)
		if button_flow.togglespeedboost_button then
			button_flow.togglespeedboost_button.destroy()
		end
	end
	if game.speed > 1.5 then
		gamespeedboosted = true
	end
end

local function on_gui_click(event)
	if game.speed <= 1 then	 				-- if another mod button slows down the game, reset button.
		gamespeedboosted = nil
		for idx, player in pairs(game.players) do
			mod_gui.get_button_flow(player).togglespeedboost_button.sprite = "togglespeedboost_off_button"	--update all players buttons
		end
	elseif game.speed > 1.5 then
		gamespeedboosted = true
		for idx, player in pairs(game.players) do
			if mod_gui.get_button_flow(player).togglespeedboost_button then
				mod_gui.get_button_flow(player).togglespeedboost_button.sprite = "togglespeedboost_on_button"	--update all players buttons
			end
		end
	end
	if (event.element.name == "togglespeedboost_button") then
		local player_whoclicked = game.players[event.player_index]
		if not gamespeedboosted then
			local newspeed = settings.get_player_settings(player_whoclicked)["tsp_speedboostmuliplier"].value or 5--change speed to the configured value of the player who clicked
			game.speed = newspeed
			gamespeedboosted = true
			for idx, player in pairs(game.players) do
				player.print({"", {"speedboost.togglespeedboost_button_speeded"}, newspeed})
				if mod_gui.get_button_flow(player).togglespeedboost_button then
					mod_gui.get_button_flow(player).togglespeedboost_button.sprite = "togglespeedboost_on_button"	--update all players buttons
					mod_gui.get_button_flow(player).togglespeedboost_button.tooltip = {"", {'speedboost.togglespeedboost_button'}, game.speed}
				end
			end
		elseif gamespeedboosted then
			game.speed = 1
			gamespeedboosted = nil
			for idx, player in pairs(game.players) do
				player.print({'speedboost.togglespeedboost_button_normalspeed'})
				if mod_gui.get_button_flow(player).togglespeedboost_button then
					mod_gui.get_button_flow(player).togglespeedboost_button.sprite = "togglespeedboost_off_button"	--update all players buttons
					mod_gui.get_button_flow(player).togglespeedboost_button.tooltip = {"", {'speedboost.togglespeedboost_button'}, game.speed}
				end
			end
		end
	end
end

local function on_init()
	for idx, player in pairs(game.players) do
		create_gui(player)
	end
end

local function on_configuration_changed()
	for idx, player in pairs(game.players) do
		create_gui(player)
	end
end

local function on_player_created(event)
	local player = game.players[event.player_index]
	create_gui(player)
end




script.on_init(on_init)
script.on_configuration_changed(on_configuration_changed)
script.on_event(defines.events.on_runtime_mod_setting_changed, on_configuration_changed)
script.on_event(defines.events.on_game_created_from_scenario, on_init)
script.on_event({defines.events.on_player_created, defines.events.on_player_joined_game}, on_player_created)

script.on_event(defines.events.on_gui_click, on_gui_click)



