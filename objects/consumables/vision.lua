-- Vision
SMODS.Consumable {
    key = 'vision',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 4, y = 0 },
    config = { selected = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.selected} }
    end,
    use = function(self, card, area, copier)
        
        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'tarot1')
        
        -- Flip over all selected cards
        AqlEventFlipHighlightedCards()
        delay(0.4)

        -- Get table of highlighted cards sorted by x value on screen
        local left_to_right_cards = AqlScriptCardsLeftToRight(G.hand.highlighted)

        -- Increase rank of cards based on index in hand (+1, +2, +3, +4, ...)
        for index, hand_card in ipairs(left_to_right_cards) do
            AqlEventModifyRank(hand_card, index)
        end

        -- Flip over all selected cards
        delay(0.4)
        AqlEventFlipHighlightedCards()

        -- Deselect all cards
        AqlEventDeselectHighlightedCards()

    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == card.ability.selected
    end
}