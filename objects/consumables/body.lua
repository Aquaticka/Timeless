-- Body
SMODS.Consumable {
    key = 'body',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 1, y = 0 },
    config = { num_selected = 4, suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.num_selected, card.ability.suits[1], card.ability.suits[2], card.ability.suits[3], card.ability.suits[4]} }
    end,
    use = function(self, card, area, copier)

        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'tarot1')
        
        -- Flip over all selected cards
        AqlEventFlipHighlightedCards()
        delay(0.4)

        -- Get table of highlighted cards sorted by x value on screen
        local left_to_right_cards = AqlScriptCardsLeftToRight(G.hand.highlighted)

        -- Get random enhancement
        local random_enhancement = AqlScriptGetRandomEnhancement()

        -- Set suit of cards in order based on config suits
        -- Also sets enhancement to random enhancement
        for index, hand_card in ipairs(left_to_right_cards) do
            AqlEventModifySuit(hand_card, card.ability.suits[index])
            AqlEventModifyEnhancement(hand_card, random_enhancement)
        end

        -- Flip over all selected cards
        delay(0.4)
        AqlEventFlipHighlightedCards()

        -- Deselect all cards
        AqlEventDeselectHighlightedCards()

    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == card.ability.num_selected
    end
}