-- Mind
SMODS.Consumable {
    key = 'mind',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 2, y = 0 },
    config = { },
    loc_vars = function(self, info_queue, card)
        return {  }
    end,
    use = function(self, card, area, copier)
        
        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'timpani')
        
        -- Create random spectral card
        local random_spectral = AqlScriptGetRandomConsumableOfSet('Spectral', 'mind')
        AqlEventAddConsumable(random_spectral)

    end,
    can_use = function(self, card)
        return AqlScriptCheckConsumableSpace()
    end
}