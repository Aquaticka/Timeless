-- Schrodinger's Box
SMODS.Joker {
    key = "schrodinger_box",
    atlas = "JokersOne",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    discovered = true,
    config = { extra = { chance = 1, odds = 2, increase = 1.2, decrease = 0.8} },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.odds, 'schrodinger_box')
        return {vars = {new_numerator, new_denominator, card.ability.extra.increase, card.ability.extra.decrease}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'indigo', card.ability.extra.chance, card.ability.extra.odds) then
                return {
                    emult = card.ability.extra.increase
			    }
            else
                return {
                    emult = card.ability.extra.decrease
			    }
            end
        end
    end
}