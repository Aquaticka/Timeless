-- Grief
SMODS.Consumable {
    key = 'grief',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 1, y = 1 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { }
    end,
    use = function(self, card, area, copier)
        
        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'tarot1')
        
        -- Destroy all highlighted cards
        for _, highlighted_card in pairs(AqlScriptCardsLeftToRight(G.hand.highlighted)) do
            AqlEventDestroyCard(highlighted_card)
        end

        -- Delay for timing
        delay(0.4)

    end,
    can_use = function(self, card)

        -- Can use only if all cards in highlighted hand have same suit, or same rank
        return G.hand and #G.hand.highlighted > 0 and (AqlScriptCheckMatchingRank(G.hand.highlighted) or AqlScriptCheckMatchingSuit(G.hand.highlighted))

    end
}