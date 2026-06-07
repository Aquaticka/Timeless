
SMODS.Shader {
    key = 'cryonic',
    path = 'cryonic.fs'
}
SMODS.Edition {
    key = 'cryonic',
    shader = 'cryonic',
    config = { xchips = 2.0 },
    in_shop = true,
    weight = 2,
    extra_cost = 3,
    badge_colour = ABYSS_CONST.COLOUR.Cryonic,
    sound = { sound = "polychrome1", per = 1.2 * 1.1, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.xchips } }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xchips = card.edition.xchips
            }
        end
    end
}
