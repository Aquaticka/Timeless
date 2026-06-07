-- Azurite Seal
SMODS.Seal {
    key = "azurite",
    atlas = "Seals",
    pos = { x = 6, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Azurite,
    config = {
        extra = {xchips = 1.5}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.xchips} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local highest_level = 1
            local highest_hand_names = {}

            -- Note that accessing the hand level in this manner does not work with Talisman.
            -- Compatibility needs to be added for Talisman, which uses a to_big() big number object for the hand level.
            
            -- Get value of highets level hand
            for _, hand_data in pairs(G.GAME.hands) do
                if hand_data.level > highest_level then
                    highest_level = hand_data.level
                end
            end
            -- Get hands which have that level as their highest level
            for hand_name, hand_data in pairs(G.GAME.hands) do
                if hand_data.level == highest_level then
                    table.insert(highest_hand_names, hand_name)
                end
            end
            
            -- Check if the played hand is a highest level hand
            local high_hand_played = false
            for _, hand_name in ipairs(highest_hand_names) do
                if context.scoring_name == hand_name then
                    high_hand_played = true
                end
            end
            if high_hand_played == false then
                return { xchips = self.config.extra.xchips }
            else
                return {message = localize('abyss_azurite_miss'), colour = ABYSS_CONST.COLOUR.Azurite}
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