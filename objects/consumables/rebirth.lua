-- Rebirth
SMODS.Consumable {
    key = 'rebirth',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 3, y = 1 },
    config = { max_selected = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.max_selected} }
    end,
    use = function(self, card, area, copier)
        -- Play tarot sound
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        -- Flip over card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[1]:flip()
                play_sound('card1', percent)
                G.hand.highlighted[1]:juice_up(0.3, 0.3)
                return true
            end
        }))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.6,
            func = function()
                local _first_dissolve = nil
                local new_cards = {}

                G.hand.highlighted[1]:juice_up(0.3, 0.3)
                play_sound('tarot2', percent)

                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copied_card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                copied_card:add_to_deck() -- This seems to set the card's instance variable added_to_deck to true
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                 table.insert(G.playing_cards, copied_card) -- I think this actually adds the card to the decklist
                G.hand:emplace(copied_card, nil) -- This sets the cardarea of the card and where in your hand/deck to move it to. 'front' for front. 
                -- Add a new location option for emplace, to place it beside the highlighted card
                copied_card:flip()
                G.hand:add_to_highlighted(copied_card, true)

                copied_card:start_materialize(nil, _first_dissolve)
                _first_dissolve = true

                new_cards[#new_cards + 1] = copied_card -- This passes a table of the newly added cards for the playing_card_added context
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))

        -- Modify card ranks
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                SMODS.modify_rank(G.hand.highlighted[1], 1)
                SMODS.modify_rank(G.hand.highlighted[2], -1)
                return true
            end
        }))

        -- Flip back over cards
        -- Put in an event for proper sequencing with above
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.25,
            func = function()
                play_sound('card1', percent)
                for i = 1, #G.hand.highlighted do

                    G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                    }), nil, true)

                end
            return true
            end
        }))
        
        -- Deselect all cards
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_selected
    end
}