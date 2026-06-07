-- Indigo Seal
SMODS.Seal {
    key = "opal",
    atlas = "Seals",
    pos = { x = 0, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Opal,
    order = 502,
    config = {
        extra = {chance = 1, odds = 4}
    },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, self.config.extra.chance, self.config.extra.odds, 'indigo')
        return {vars = {new_numerator, new_denominator}}
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(self, 'indigo', self.config.extra.chance, self.config.extra.odds, 'indigo') then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Spectral' })
                            card:juice_up(0.3, 0.5)
                        end
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return { message = localize('abyss_spectral_plus'), colour = ABYSS_CONST.COLOUR.Indigo }
            else
                return { message = localize('abyss_spectral_miss'), colour = ABYSS_CONST.COLOUR.Indigo }
            end
        end
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('abyss_gem', nil, card.ARGS.send_to_shader, nil, card.children.center) -- change to abyss_<shader> to apply new shader
        end
    end
}