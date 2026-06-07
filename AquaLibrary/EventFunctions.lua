
--- EventFunctions.lua
--- This file contains all function used in calculate functions which add an event to the event manager
--- These functions will perform functionality for using consumeables, calculating seal effects, etc.



-- Add event to event manager to add joker of given key
function AqlEventAddJoker(key)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.4,
        func = function()
            if AqlScriptCheckJokerSpace() then 
                SMODS.add_card({key = key})
            end
            return true
        end
    }))

end


-- Add event to event manager to add consumable of given key
function AqlEventAddConsumable(key)

    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.4,
        func = function()
            if AqlScriptCheckConsumableSpace() then 
                SMODS.add_card({key = key})
            end
            G.GAME.consumeable_buffer = 0
            return true
        end
    }))

end


-- Adds event to event manager which displays text above card 
function AqlEventCardAttentionText(card, text, backdrop_colour)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
            attention_text({
                text = text,
                scale = 0.8,
                hold = 0.4,
                backdrop_colour = backdrop_colour,
                align = 'tm',
                major = card,
                offset = {x = 0, y = -0.05*G.CARD_H}
            })
            return true
        end
    }))

end


-- Adds event to event manager which juices given card
function AqlEventCardPop(card)

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.0,
        func = function()
            card:juice_up(0.7, 0.1)
            return true
        end
    }))

end


-- Adds event to event manager which makes card show text, and wiggle, with standard delay e.g. in scoring.
function AqlEventCardStandardText(card, text, backdrop_colour)

    AqlEventPlaySound('generic1')
    AqlEventCardAttentionText(card, text, backdrop_colour)
    AqlEventCardPop(card)
    delay(0.6)

end


-- Adds event to event manager which juices given card
function AqlEventCardWiggle(card)

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.0,
        func = function()
            card:juice_up(0.3, 0.5)
            return true
        end
    }))

end


-- Adds event to event manager which juices given consumeable and plays given sound
-- Should be run at the beginning of the script when a consumeable is used
function AqlEventConsumableOnUse(card, sound)

    sound = sound or 'tarot1' -- Initialize sound to tarot1 if value not passed

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound(sound)
            card:juice_up(0.3, 0.5)
            return true
        end
    }))

end


-- Adds event to event manager which deselects all highlighted cards
function AqlEventDeselectHighlightedCards()

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.4,
        func = function()
            G.hand:unhighlight_all()
            return true
        end
    }))

end


-- Adds event to event manager which destroys card with no delay
function AqlEventDestroyCard(card)
    
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.05,
        func = function()
            SMODS.destroy_cards({card}, nil, true, nil)
            return true
        end
    }))

end


-- Adds event to event manager which eats given card (destoys it, plays eaten sound, and shows eaten text)
function AqlEventEatCard(card, backdrop_colour)

    AqlEventPlaySound('abyss_chomp', 1.0, 2.5)
    AqlEventDestroyCard(card)
    AqlEventCardAttentionText(card, localize('abyss_eaten'), backdrop_colour)

end


-- Adds event to event manager for each card in {card_table} which flip over that card
function AqlEventFlipCard(card)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.15,
        func = function()
            card:flip()
            play_sound('card1')
            card:juice_up(0.3, 0.3)
            return true
        end
    }))

end


-- Adds event to event manager for each card in highlighted hand which flips over that card
-- Is a wrapper for AqlEventFlipCards() which passes the current highlighted cards
function AqlEventFlipHighlightedCards()

    -- Sort then flip highlighted cards
    local sorted_cards = AqlScriptCardsLeftToRight(G.hand.highlighted)
    for _, card in pairs(sorted_cards) do
        AqlEventFlipCard(card)     
    end

end


-- Adds event to event manager to increase number of hands for run by given amount
function AqlEventIncreaseRunHands(amount)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.15,
        func = function()
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + amount
            ease_hands_played(amount)
        end
    }))

end


-- Adds event to event manager to pulse/wiggle a card
function AqlEventJuiceCard(card, pulse, wiggle)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
            card:juice_up(pulse, wiggle)
            return true
        end
    }))

end


-- Adds event to event manager to set given card's enhancement to given key
function AqlEventModifyEnhancement(card, key)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
            card:set_ability(key)
            return true
        end
    }))

end


-- Adds event to event manager to modify the number of hands and discards for the run
function AqlEventModifyRunHandsAndDiscards(hands_mod, discards_mod)

    -- Prevent hands from going below 0
    if hands_mod + G.GAME.round_resets.hands < 1 then
        hands_mod = -G.GAME.round_resets.hands
    end

    -- Prevent discards from going below 0
    if discards_mod + G.GAME.round_resets.discards < 0 then
        discards_mod = -G.GAME.round_resets.discards
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.4,
        func = function()

            G.GAME.round_resets.discards = G.GAME.round_resets.discards + discards_mod
            ease_discard(discards_mod)
            
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + hands_mod
            ease_hands_played(hands_mod)

            return true

        end
    }))

end


-- Adds event to event manager to modify hand size by given amount
function AqlEventModifyHandSize(amount)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.15,
        func = function()
            G.hand:change_size(amount)
            return true
        end
    }))

end


-- Adds event to event manager to modify money by given amount
function AqlEventModifyMoney(amount)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
            ease_dollars(amount, true)
            return true
        end
    }))

end


-- Adds event to event manager to increase given card's rank by given amount
function AqlEventModifyRank(card, amount)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
            assert(SMODS.modify_rank(card, amount))
            return true
        end
    }))

end


-- Adds event to event manager which changes given card to given suit
function AqlEventModifySuit(card, suit)

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.0,
        func = function()
            assert(SMODS.change_base(card, suit))
            return true
        end
    }))

end


-- Adds event to the event manage to play given sound
function AqlEventPlaySound(sound, pitch, volume)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
            play_sound(sound, pitch, volume)
            return true
        end
    }))


end


-- Adds event to event manager which sets the edition of a card
-- Edition should be the key of the edition as defined in G.P_CENTER_POOLS.Edition e.g. "e_holo" or "abyss_plasmatic"
function AqlEventSetEdition(card, edition)

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.15,
        func = function()
            card:set_edition(edition, true, false)
            return true
        end
    }))

end
