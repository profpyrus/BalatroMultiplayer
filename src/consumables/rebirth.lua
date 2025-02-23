local key = "rebirth"

SMODS.Atlas({
	key = key,
	path = "c_rebirth.png",
	px = 63,
	py = 93,
})

SMODS.Consumable({
	key = key,
	atlas = key,
	set = "Spectral",
	cost = 8,
	unlocked = true,
	discovered = true,
	in_pool = function(self)
		return G.LOBBY.code and G.LOBBY.config.multiplayer_jokers and tonumber(G.MULTIPLAYER_GAME.lives) <= 2
	end,
	use = function(self, card, area, copier)
		for i = 1, 2 do
			local joker = G.MULTIPLAYER.UTILS.get_random_joker()
			if joker then
				joker:remove_from_deck()
				joker:start_dissolve({ G.C.RED }, nil, 1.6)
				G.jokers:remove_joker(card)
			end
		end
		G.MULTIPLAYER_GAME.lives = tostring(tonumber(G.MULTIPLAYER_GAME.lives) + 2)
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		G.MULTIPLAYER.rebirth()
	end,
	mp_credits = {
		idea = { "Profpyrus" },
		art = { "Profpyrus" },
		code = { "Profpyrus" },
	},
})

table.insert(MP.cards, key)
