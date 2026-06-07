-- Topaz Seal
SMODS.Seal {
    key = "topaz",
    atlas = "Seals",
    pos = { x = 2, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Topaz,
    config = {
        extra = { give = {'c_death', 'c_abyss_rebirth'} }
    },
    loc_vars = function(self, info_queue, card)
        return
    end,
    calculate = function(self, card, context)

        -- Context check for held at end of round
        if context.playing_card_end_of_round and context.cardarea == G.hand then

            -- Check for consumable space before adding events
            if AqlScriptCheckConsumableBufferSpace() then

                -- Play card text and sound, and add random tarot card to consumables.
                local random_tarot = AqlScriptGetRandomConsumableOfSet("Tarot", 'topaz')
                AqlEventPlaySound('generic1')
                AqlEventCardAttentionText(card, localize('abyss_tarot'), ABYSS_CONST.COLOUR.Topaz)
                AqlEventCardPop(card)
                AqlEventAddConsumable(random_tarot)

            end

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