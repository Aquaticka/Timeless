-- Wish
SMODS.Consumable {
    key = 'wish',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 7, y = 0 },
    config = { max_money = 30 },
    loc_vars = function(self, info_queue, card)

        local num_improved_cards = 0
        num_improved_cards = num_improved_cards + AqlScriptCountImprovedCards( AqlScriptGetFullDeckCards() )
        num_improved_cards = math.min(num_improved_cards, self.config.max_money)

        return { vars = {num_improved_cards, card.ability.max_money} }

    end,
    use = function(self, card, area, copier)
        
        -- Play tarot sound
        AqlEventConsumableOnUse(card, 'timpani')

        -- Count improvements in full run deck
        local num_improved_cards = 0
        num_improved_cards = num_improved_cards + AqlScriptCountImprovedCards( AqlScriptGetFullDeckCards() )

        -- Limit money to maximum value as defined in config
        local money_amount = math.min(num_improved_cards, card.ability.max_money)

        -- Add money 
        AqlEventModifyMoney(money_amount)

        -- Delay for timing
        delay(0.8)

    end,
    can_use = function(self, card)
        return true
    end
}