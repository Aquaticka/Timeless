
--- ScriptFunctions.lua
--- This file contains all function used in calculate functions which retrieve some sort of data or return some useful value
--- These functions will perform functionality for using consumeables, calculating seal effects, etc.


-- File-scope variables

-- The default seed for random effects in this function
local default_seed = "abyss"



-- Returns a table representing the cards in hand ordered from left to right as shown on screen
function AqlScriptCardsLeftToRight(card_table)

    local new_table = {}

    -- Make a shallow copy of the table
    for i, v in ipairs(card_table) do
        table.insert(new_table, v)
    end

    -- Selection Sort in-place by card location on screen (same method as death tarot)
    for i = 1, #new_table - 1 do

        -- Get leftmost element in subarray
        local leftmost_card_x = new_table[i].T.x
        local leftmost_card_index = i
        
        -- Find element in subarray with smallest x value (i.e. leftmost on screen)
        for j = i, #new_table do 
            if new_table[j].T.x < leftmost_card_x then
                leftmost_card_x = new_table[j].T.x
                leftmost_card_index = j
            end
        end

        -- Swap selected card with next table element
        local temp_card = new_table[leftmost_card_index]
        new_table[leftmost_card_index] = new_table[i]
        new_table[i] = temp_card

    end

    return new_table

end


-- Returns true if there is space for jokers in jokers area. False otherwise.
function AqlScriptCheckJokerSpace()

    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
        return true
    else
        return false
    end

end



-- Returns true if there is space for consumables in consumables area, including the event buffer. False otherwise.
function AqlScriptCheckConsumableBufferSpace()

    if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
        return true
    else
        return false
    end

end


-- Returns true if there is space for consumables in consumables area. False otherwise.
function AqlScriptCheckConsumableSpace()

    if G.consumeables.config.card_limit > #G.consumeables.cards then
        return true
    else
        return false
    end

end


-- Returns true if all cards in card_table have matching suit
function AqlScriptCheckMatchingSuit(card_table)

    local suit = AqlScriptGetCardSuit(card_table[1])

    local matching = true
    for _, card in pairs(card_table) do
        if AqlScriptGetCardSuit(card) ~= suit then
            matching = false
        end
    end

    return matching

end


-- Returns true if all cards in card_table have matching suit
function AqlScriptCheckMatchingRank(card_table)

    local rank = AqlScriptGetCardRank(card_table[1])

    local matching = true
    for _, card in pairs(card_table) do
        if AqlScriptGetCardRank(card) ~= rank then
            matching = false
        end
    end

    return matching

end


-- Returns an integer representing the number of enhanced, seal, or edition cards in card_table
-- Can pass G.hand.cards, G.discard.cards, or G.deck.cards to count the number of cards in hand, already played/discarded, or deck.
function AqlScriptCountImprovedCards(card_table)

    local num_improved_cards = 0

    -- Count each improved card in given card_table
    for _, card in ipairs(card_table) do
        if card.edition or card.seal or card.config.center.set ~= "Default" then
            num_improved_cards = num_improved_cards + 1
        end
    end

    return num_improved_cards

end


-- Returns an integer represent given card's rank
function AqlScriptGetCardRank(card)
    
    return card.config.card.value

end


-- Returns a string representing given card's suit
function AqlScriptGetCardSuit(card)
    
    return card.config.card.suit

end


-- Returns a table containing all jokers in given joker_table without an edition
function AqlScriptGetEditionlessJokers(joker_table)

    local editionless_jokers = {}

    for _, joker in pairs(joker_table) do
        if not joker.edition then
            table.insert(editionless_jokers, joker)
        end
    end

    return editionless_jokers

end


-- Returns a table containing all card object in full run deck (includes hand and played/discarded cards during round)
function AqlScriptGetFullDeckCards()

    local deck_cards = {}

    -- Get deck cards
    if G.deck and G.deck.cards then
        for _, card in ipairs(G.deck.cards) do 
            table.insert(deck_cards, card)
        end
    end
    
    -- Get hand cards
    if G.hand and G.hand.cards then
        for _, card in ipairs(G.hand.cards) do 
            table.insert(deck_cards, card)
        end
    end
    
    -- Get played/discarded cards
    if G.discard and G.discard.cards then
        for _, card in ipairs(G.discard.cards) do 
            table.insert(deck_cards, card)
        end
    end

    -- Return full deck cardlist
    return deck_cards

end



-- Returns an integer representing the number of plays for lowest played hand
-- Pass context.scoring_name if checking during G.play cardarea, since playcount is incremented before hand is calculated
function AqlScriptGetLowestHandPlaycount(scoring_hand)

    local lowest_playcount = nil

    -- Get value of lowest playcount hand
    for hand_name, hand_data in pairs(G.GAME.hands) do

        -- Only count visible hands
        if hand_data.visible then

            local hand_playcount = hand_data.played

            -- Playcount gets incremented before calculate function runs, so we have to subtract out the hand we just played if function is run in scoring context
            if scoring_hand == hand_name then
                hand_playcount = hand_playcount - 1
            end
            
            -- Update lowest hand playcount if new minimum value is found
            if not lowest_playcount then
                lowest_playcount = hand_playcount
            elseif hand_data.played < lowest_playcount then
                lowest_playcount = hand_playcount
            end

        end

    end

    return lowest_playcount

end


-- Returns a table containing strings representing the names of all hands with lowest playcount
-- Pass context.scoring_name if checking during G.play cardarea, since playcount is incremented before hand is calculated
function AqlScriptGetLowestPlayedHands(scoring_hand)

    local lowest_playcount = AqlScriptGetLowestHandPlaycount(scoring_hand)
    local lowest_played_hands = {}

    -- Iterate through all hands
    for hand_name, hand_data in pairs(G.GAME.hands) do

        -- Only check visible hands
        if hand_data.visible then

            -- If hand playcount matches lowest playcount, add to lowest played hands table
            if hand_data.played == lowest_playcount then
                table.insert(lowest_played_hands, hand_name)
            end

        end

    end

    return lowest_played_hands

end


-- Returns the key of a random consumable of given set (i.e. "Tarot", "Spectral", "abyss_Mystic", ...etc.)
-- Can pass a string of given set, or a table of strings of sets
function AqlScriptGetRandomConsumableOfSet(set, seed)

    seed = seed or default_seed

    local consumable_table = {}

    -- Check whether string or table was passed
    if type(set) == "table" then -- If table passed

        -- For each set in set table
        for _, v in pairs(set) do
            
            -- Add jokers of given set to pool
            for _, consumable in pairs(G.P_CENTER_POOLS.Consumeables) do
                print(consumable)
                if consumable.set == v then
                    table.insert(consumable_table, consumable.key)
                end
            end

        end

    else -- If string passed
        
        -- Add jokers of given set to pool
        for _, consumable in pairs(G.P_CENTER_POOLS.Consumeables) do
            if consumable.set == set then
                table.insert(consumable_table, consumable.key)
            end
        end

    end

    -- Get random element in pool
    local random_consumable = AqlScriptGetRandomElement(consumable_table, seed)
    return random_consumable and random_consumable

end


-- Returns a random element in given table
function AqlScriptGetRandomElement(table, seed)

    seed = seed or default_seed

    local random_element, _ = pseudorandom_element(table, seed)
    return random_element

end


-- Returns a random enhancement
function AqlScriptGetRandomEnhancement(seed)

    seed = seed or default_seed

    local random_enhancement, _ = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, seed)
    return random_enhancement.key
    
end


-- Returns the key of a random joker of a given rarity
-- Rarity can be an integer representing the rarity, or a table of integers representing allowed rarities
function AqlScriptGetRandomJokerOfRarity(rarity, seed)

    seed = seed or default_seed

    local joker_table = {}

    -- Check whether integer or table was passed
    if type(rarity) == "table" then -- If table passed

        -- For each rarity in rarity table
        for _, v in pairs(rarity) do
            
            -- Add jokers of given rarity to pool
            for _, joker in pairs(G.P_CENTER_POOLS.Joker) do
                if joker.rarity == v then
                    table.insert(joker_table, joker.key)
                end
            end

        end

    else -- If integer passed
            
        -- Add jokers of given rarity to pool
        for _, joker in pairs(G.P_CENTER_POOLS.Joker) do
            if joker.rarity == rarity then
                table.insert(joker_table, joker.key)
            end
        end

    end

    -- Get random element in pool
    local random_joker = AqlScriptGetRandomElement(joker_table, seed)
    return random_joker and random_joker

end



-- Returns a random edition key from table G.P_CENTER_POOLS.Edition, excluding base edition and negative edition
-- e.g. returns "e_holo" or "abyss_plasmatic"
-- Return value can be used to set edition with card:set_edition(random_edition)
function AqlScriptRandomEdition(seed)
    
    seed = seed or default_seed

    -- Create table of all editions other than base and negative
    local edition_table = {}
    for k, edition in pairs(G.P_CENTER_POOLS.Edition) do
        if edition.key ~= 'e_base' and edition.key ~= 'e_negative' then
            edition_table[k] = edition.key
        end
    end

    -- Return random value from edition table with given seed
    local random_edition, _ = pseudorandom_element(edition_table, seed)
    return random_edition

end

