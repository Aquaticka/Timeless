-- Swiss Cheese
SMODS.Joker {
    key = "swiss_cheese",
    atlas = "JokersOne",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = false,
    cost = 2,
    discovered = true,
    config = { extra = { dollars = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local money = card.ability.extra.dollars
            card.ability.extra.dollars = card.ability.extra.dollars - 1
            if card.ability.extra.dollars == 0 then
                SMODS.destroy_cards(card, false, true, true)
                G.GAME.pool_flags.abyss_swiss_cheese_extinct = true
                return {dollars = money, delay = 0.55, message = localize("abyss_cheese_eaten")}
            else
                return {dollars = money}
            end
        end
    end,
    in_pool = function(self, args)
        return not G.GAME.pool_flags.abyss_swiss_cheese_extinct
    end
}