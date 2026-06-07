-- Tourmaline Seal
SMODS.Seal {
    key = "tourmaline",
    atlas = "Seals",
    pos = { x = 5, y = 0 },
    weight = ABYSS_CONST.SEAL_WEIGHT,
    badge_colour = ABYSS_CONST.COLOUR.Tourmaline,
    config = {
        extra = {tag_list = {'tag_standard', 'tag_charm', 'tag_meteor'}}
    },
    loc_vars = function(self, info_queue, card)

        -- This vanilla variable only checks for vanilla Tarots and Planets, you would have to keep track on your own for any custom consumables
        local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
        local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or localize('k_none')
        local colour = not fool_c and G.C.RED or G.C.GREEN

        if fool_c then
            info_queue[#info_queue + 1] = fool_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_tarot_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { main_end = main_end }
    end,
    calculate = function(self, card, context)

        -- Context check for discarded card
        if context.discard and context.other_card == card then

            -- Add all tag names to a table
            local tags_table = {}
            for k, _ in pairs(G.P_TAGS) do
                table.insert(tags_table, k)
            end

            -- Select and add a random tag
            local random_tag, _ = pseudorandom_element(tags_table, 'tourmaline')
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    add_tag(Tag(random_tag)) -- Add tag through event managerfor correct timing.
                    return true
                end
            }))

            -- Show Tourmaline message
            return { message = localize('abyss_tourmaline_hit'), colour = ABYSS_CONST.COLOUR.Tourmaline }

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