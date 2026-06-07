SMODS.ConsumableType {
    key = 'abyss_Mystic',
    default = 'abyss_love',
    collection_rows = { 6, 6 },
    primary_colour = ABYSS_CONST.COLOUR.Mystic1,
    secondary_colour = ABYSS_CONST.COLOUR.Mystic1, -- Collection Tab Colour
    shop_rate = 0.5
}

SMODS.Shader {
    key = 'mystic',
    path = 'mystic.fs'
}

SMODS.DrawStep {
    key = 'mystic_shader',
    order = 15,
    func = function(self)
        if (self.ability.set == 'abyss_Mystic') and self:should_draw_base_shader() then
            self.children.center:draw_shader('abyss_mystic', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}