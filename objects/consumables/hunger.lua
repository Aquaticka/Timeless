-- Hunger
SMODS.Consumable {
    key = 'hunger',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 3, y = 0 },
    config = { selected = 2 },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.selected}}
    end,
    use = function(self, card, area, copier)

        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'tarot1')

        -- Flip over all selected cards
        AqlEventFlipHighlightedCards()

        -- Select random card of selected cards to be eaten
        local eaten_card = AqlScriptGetRandomElement(G.hand.highlighted, "hunger")
        delay(0.6)
        AqlEventEatCard(eaten_card, ABYSS_CONST.COLOUR.Mystic2)

        -- Get random non-base, non-negative edition
        -- Add random edition to all remaining highlighted cards
        local random_edition = AqlScriptRandomEdition("hunger")
        for _, hand_card in pairs(G.hand.highlighted) do
            if hand_card ~= eaten_card then
                AqlEventSetEdition(hand_card, random_edition)
            end
        end

        -- Delay before ending sequence
        delay(1.0)

        -- Flip back non-eaten cards
        for _, hand_card in pairs(G.hand.highlighted) do
            if hand_card ~= eaten_card then
                AqlEventFlipCard(hand_card)
            end
        end

        -- Deselect all cards
        AqlEventDeselectHighlightedCards()
        
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 1 and #G.hand.highlighted <= card.ability.selected
    end
}