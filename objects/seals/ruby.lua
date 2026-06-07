-- Ruby Seal
SMODS.Seal {
    key = "ruby",
    atlas = "Seals",
    pos = { x = 1, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Ruby,
    config = {
        extra = { xmult = 1.5 }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.xmult}}
    end,
    calculate = function(self, card, context)

        if context.final_scoring_step and context.cardarea == G.play then
            
            -- Get a table containing the names of the lowest played hands which are visible
            local lowest_hand_playcount = AqlScriptGetLowestHandPlaycount(context.scoring_name)

            -- Add xmult, repeated for each lowest played handcount above 0.
            for i = 0, lowest_hand_playcount do
                SMODS.calculate_effect({ xmult = self.config.extra.xmult }, card)
            end

        end

    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('booster', nil, card.ARGS.send_to_shader, nil, card.children.center) -- change to abyss_<shader> to apply new shader
        end
    end
}