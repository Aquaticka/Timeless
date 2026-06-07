-- Citrine Seal
SMODS.Seal {
    key = "citrine",
    atlas = "Seals",
    pos = { x = 3, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Citrine,
    config = {
        extra = {money = 1}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { dollars = #context.full_hand * self.config.extra.money }
        end
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center) -- change to abyss_<shader> to apply new shader
        end
    end
}