-- Emerald Seal
SMODS.Seal {
    key = "emerald",
    atlas = "Seals",
    pos = { x = 4, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Emerald,
    config = {
        extra = {chance = 1, odds = 2}
    },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, self.config.extra.chance, self.config.extra.odds, 'emerald')
        return {vars = {new_numerator, new_denominator}}
    end,
    calculate = function(self, card, context)
        
        -- Triggers when scored
        if context.main_scoring and context.cardarea == G.play then

            -- Skips calculation if no cards in consumable slots and no cards are to be added during calculation
            if #G.consumeables.cards + G.GAME.consumeable_buffer <= 0 then
                return 
            end

            -- If not first hand of round, let player know that it won't trigger
            if G.GAME.current_round.hands_played ~= 0 then
                return { message = localize('abyss_emerald_slow'), colour = ABYSS_CONST.COLOUR.Emerald }
            end
            
            -- If Random chance misses, then tell the player that it missed
            if not (SMODS.pseudorandom_probability(self, 'emerald', self.config.extra.chance, self.config.extra.odds, 'emerald')) then
                return { message = localize('abyss_emerald_miss'), colour = ABYSS_CONST.COLOUR.Emerald }
            end
            
            -- Otherwise, add the event which will copy the card.
            -- Note that in this case I have to create an event for the return message, because the copied card would happen during the original count of the card (?)
            return {
                func = function() 
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.9,
                        func = function()
                            local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'emerald')
                            if card_to_copy then -- The check above should catch this, but since mods interactions can be messy its still good to check
                                card:juice_up(0.6, 0.1)
                                play_sound('generic1')
                                attention_text({
                                    text = localize('abyss_emerald_hit'),
                                    scale = 0.8,
                                    hold = 0.4,
                                    backdrop_colour = ABYSS_CONST.COLOUR.Emerald,
                                    align = 'tm',
                                    major = card,
                                    offset = {x = 0, y = -0.05*G.CARD_H}
                                })
                                local copied_card = copy_card(card_to_copy)
                                copied_card:set_edition("e_negative", true)
                                copied_card:add_to_deck()
                                G.consumeables:emplace(copied_card)
                            end
                            G.GAME.consumeable_buffer = 0 -- Clears the consumable buffer. Only needed if edition is not negative.
                            return true
                        end
                    }))
                end
            }

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