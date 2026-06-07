-- Love
SMODS.Consumable {
    key = 'love',
    set = 'abyss_Mystic',
    atlas = "Consumables",
    cost = ABYSS_CONST.MYSTIC_PRICE,
    pos = { x = 5, y = 0 },
    config = { max_selected = 2, pool = {"ruby", "topaz", "citrine", "emerald", "tourmaline", "azurite", "amethyst"}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.max_selected}}
    end,
    use = function(self, card, area, copier)

        -- local _, random_seal = pseudorandom_element(G.P_SEALS, "love")

        local seal_table = {}
        for _, v in pairs(self.config.pool) do
            v = "abyss_"..v
            table.insert(seal_table, v)
        end

        -- local _, random_seal = pseudorandom_element(G.P_SEALS, "love")
        local random_seal, _ = pseudorandom_element(seal_table, "love")

        for k, v in pairs(G.P_SEALS) do
            if v == random_seal then random_seal = k end
        end
        delay(0.3)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:set_seal(random_seal, nil, true)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.6,
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