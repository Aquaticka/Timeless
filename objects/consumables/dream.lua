-- Dream
SMODS.Consumable {
    key = 'dream',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 6, y = 0 },
    config = { hand_size = 1, chance = 1, odds = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.hand_size, card.ability.chance, card.ability.odds} }
    end,
    use = function(self, card, area, copier)
        
        delay(0.4)

        -- Calculate probability. If hits, increase hand size. Display respective messagem
        local success = SMODS.pseudorandom_probability(self, 'dream', card.ability.chance, card.ability.odds, 'dream')

        -- Create events depending on success
        if success then
            AqlEventModifyHandSize(card.ability.hand_size)
            AqlEventCardPop(card)
            AqlEventPlaySound('gong')
            AqlEventCardAttentionText(card, localize('abyss_dream_hit'), ABYSS_CONST.COLOUR.Mystic1)
        else
            AqlEventCardWiggle(card)
            AqlEventPlaySound('tarot2')
            AqlEventCardAttentionText(card, localize('abyss_miss'), ABYSS_CONST.COLOUR.Mystic1)
        end

        -- Delay for timing
        delay(0.8)

    end,
    can_use = function(self, card)
        return true
    end
}