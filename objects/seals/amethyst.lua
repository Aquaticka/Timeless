-- Amethyst Seal
SMODS.Seal {
    key = "amethyst",
    atlas = "Seals",
    pos = { x = 7, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Amethyst,
    config = {
        extra = {chance = 1, odds = 4}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    calculate = function(self, card, context)

        -- To ensure proper timing, all amethyst seal context checks are done on the first amethyst seal checked. The card.amethyst_sacrifice flag is used to keep track
        -- of whether a card has already been processed during this context check.

        -- I think the current script function used to generate a random spectral card can generate soul and black hole, which is not desired. This should be updated.

        -- Check if in discarding context
        if context.remove_playing_cards then

            -- Keep track of how many amethyst seals were sacrificed during this context check
            local sacrifice_count = 0

            -- Iterate through removed cards
            for _, removed_card in ipairs(context.removed) do

                -- For each removed card which has an amethyst seal, create the text and sound events, increment the sacrifices, and flag it as sacrificed.
                if removed_card.seal == "abyss_amethyst" and not removed_card.amethyst_sacrifice then
                    
                    AqlEventPlaySound('slice1')
                    AqlEventCardAttentionText(removed_card, localize('abyss_sacrificed'), ABYSS_CONST.COLOUR.Amethyst)
                    delay(0.1)
                    sacrifice_count = sacrifice_count + 1
                    removed_card.amethyst_sacrifice = true

                end

            end

            -- For each amethyst seal sacrificed during this context, create a spectral and mystic card.
            for i = 1, sacrifice_count do

                -- Create random mystic and spectral card
                local random_mystic = AqlScriptGetRandomConsumableOfSet('abyss_Mystic', 'amethyst')
                AqlEventAddConsumable(random_mystic)
                local random_spectral = AqlScriptGetRandomConsumableOfSet('Spectral', 'amethyst')
                AqlEventAddConsumable(random_spectral)

            end

        end


        --[[
        if context.playing_card_end_of_round and context.cardarea == G.hand and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local spectral_mystic_list = {}

            for k, v in pairs(G.P_CENTER_POOLS.abyss_Mystic) do
                table.insert(spectral_mystic_list, {v.key, 'mystic'})
            end
            for k, v in pairs(G.P_CENTER_POOLS.Spectral) do
                table.insert(spectral_mystic_list, {v.key, 'spectral'})
            end
            local random_card_data, _ = pseudorandom_element(spectral_mystic_list)
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('abyss_crystal')
                        SMODS.add_card({ key = random_card_data[1] })
                    end
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            if random_card_data[2] == 'spectral' then
                return { message = localize('abyss_amethyst_spectral'), colour = ABYSS_CONST.COLOUR.Amethyst }
            else
                return { message = localize('abyss_amethyst_mystic'), colour = ABYSS_CONST.COLOUR.Amethyst }
            end
        end
        ]]

    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center) -- change to abyss_<shader> to apply new shader
        end
    end
}