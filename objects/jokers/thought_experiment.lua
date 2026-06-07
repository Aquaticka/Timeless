-- Thought Experiment
SMODS.Joker {
    key = "thought_experiment",
    atlas = "JokersOne",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    discovered = true,
    config = { extra = { x_mult = 3, time = 3, stroke = 3} },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult, card.ability.extra.time, card.ability.extra.stroke}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local bell = false
            if card.ability.extra.time >= 12 then
                bell = true
            end
            card.ability.extra.time = card.ability.extra.time + card.ability.extra.stroke
            if card.ability.extra.time > 12 then
                card.ability.extra.time = card.ability.extra.time - 12
            end
            if card.ability.extra.time == 12 then
                local eval = function(card) return (card.ability.extra.time == 12) end
                juice_card_until(card, eval, true)
            end
            if bell == true then
                return {
                    x_mult = card.ability.extra.x_mult
			    }
            else
                return {
                    message = localize('abyss_clock_toll')
                }
            end
        end
        if context.pre_discard then
            card.ability.extra.time = card.ability.extra.time + card.ability.extra.stroke
            if card.ability.extra.time > 12 then
                card.ability.extra.time = card.ability.extra.time - 12
            end
            if card.ability.extra.time == 12 then
                local eval = function(card) return (card.ability.extra.time == 12) end
                juice_card_until(card, eval, true)
            end
            return {
                message = localize('abyss_clock_toll')
            }
        end
    end
}