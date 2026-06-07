-- Spirit
SMODS.Consumable {
    key = 'spirit',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 0, y = 0 },
    config = { rarity = { 2, 3 } },
    loc_vars = function(self, info_queue, card)
        return {  }
    end,
    use = function(self, card, area, copier)
        
        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'timpani')
        
        -- Get uncommon joker key, and add event to add it to joker area
        local random_joker = AqlScriptGetRandomJokerOfRarity(card.ability.rarity, "spirit")
        AqlEventAddJoker(random_joker)

        -- Delay for timing
        delay(0.4)

    end,
    can_use = function(self, card)
        return AqlScriptCheckJokerSpace()
    end
}