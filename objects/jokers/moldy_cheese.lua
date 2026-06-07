-- Swiss Cheese
SMODS.Joker {
    key = "moldy_cheese",
    atlas = "JokersOne",
    pos = { x = 1, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
    discovered = true,
    config = { extra = { xmult = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xmult = card.ability.extra.xmult}
        end
    end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.abyss_swiss_cheese_extinct
    end
}