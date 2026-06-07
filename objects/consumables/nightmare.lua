-- Nightmare
SMODS.Consumable {
    key = 'nightmare',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 2, y = 1 },
    config = { extra = {hands = 2, discards = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.hands, card.ability.extra.discards} }
    end,
    use = function(self, card, area, copier)
        
        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'tarot1')
        
        -- Remove hands and discards
        AqlEventModifyRunHandsAndDiscards(-card.ability.extra.hands, -card.ability.extra.discards)

        -- Get table of jokers without editions
        local editionless_jokers = AqlScriptGetEditionlessJokers(G.jokers.cards)

        -- Select random joker to give negative
        local random_joker = AqlScriptGetRandomElement(editionless_jokers, 'nightmare')
        
        -- Give chosen joker negative
        if random_joker then
            AqlEventSetEdition(random_joker, 'e_negative')
        end

        -- End delay
        delay(0.4)

    end,
    can_use = function(self, card)
        return G.jokers and #(AqlScriptGetEditionlessJokers(G.jokers.cards)) > 0 and G.GAME.current_round.hands_left > card.ability.extra.hands
    end
}