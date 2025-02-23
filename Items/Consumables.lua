SMODS.Atlas({
	key = "asteroid",
	path = "c_asteroid.png",
	px = 71,
	py = 95,
})

SMODS.Consumable({
	key = "asteroid",
	set = "Planet",
	atlas = "asteroid",
	cost = 3,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		add_nemesis_info(info_queue)
		return { vars = { 1 } }
	end,
	in_pool = function(self)
		return G.LOBBY.code and G.LOBBY.config.multiplayer_jokers
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		G.MULTIPLAYER.asteroid()
	end,
	mp_credits = {
		idea = { "Zilver" },
		art = { "TheTrueRaven" },
		code = { "Virtualized" },
	},
})

SMODS.Atlas({
	key = "rebirth",
	path = "s_rebirth.png",
	px = 63,
	py = 93,
})

SMODS.Consumable({
	key = "rebirth",
	set = "Spectral",
	atlas = "rebirth",
	cost = 8,
	unlocked = true,
	discovered = true,
	in_pool = function(self)
		return G.LOBBY.code and G.LOBBY.config.multiplayer_jokers and tonumber(G.MULTIPLAYER_GAME.lives) <= 2
	end,
	use = function(self, card, area, copier)
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for i = 1, 2 do
					local joker = G.MULTIPLAYER.UTILS.get_random_joker()
					if joker then
						joker:remove_from_deck()
						joker:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
						G.jokers:remove_card(joker)
					end
				end
				return true
			end,
		}))
		ease_lives(1)
		G.MULTIPLAYER_GAME.lives = tostring(tonumber(G.MULTIPLAYER_GAME.lives) + 1)
	end,
	can_use = function(self, card)
		return true
	end,
	mp_credits = {
		idea = { "Profpyrus" },
		art = { "Profpyrus" },
		code = { "Profpyrus" },
	},
})
