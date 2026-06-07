
SMODS.Shader {
    key = 'plasmatic',
    path = 'plasmatic.fs'
}
SMODS.Edition {
    key = 'plasmatic',
    shader = 'plasmatic',
    config = { xmult = 2.5 },
    in_shop = true,
    weight = 1,
    extra_cost = 3,
    badge_colour = ABYSS_CONST.COLOUR.Plasmatic,
    sound = { sound = "holo1", per = 1.2 * 1.1, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.xmult } }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xmult = card.edition.xmult
            }
        end
    end
}
