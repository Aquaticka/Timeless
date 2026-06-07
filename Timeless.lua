
-- Load the AquaLibrary functions
assert(SMODS.load_file('AquaLibrary/AquaLibrary.lua'))()

SMODS.Atlas({
    key = 'JokersOne',
    path = 'JokersOne.png',
    px = '71',
    py = '95'
})

SMODS.Atlas({
    key = 'Seals',
    path = 'Seals.png',
    px = '71',
    py = '95'
})

SMODS.Atlas({
    key = 'Boosters',
    path = 'Boosters.png',
    px = '71',
    py = '95'
})

SMODS.Atlas({
	key = "Consumables",
	path = "Consumables.png",
	px = 71,
	py = 95
})

SMODS.Sound({
    key = 'chomp',
    path = 'chomp.ogg',
})
SMODS.Sound({
    key = 'crystal',
    path = 'crystal.ogg',
})
SMODS.Sound({
    key = 'chime',
    path = 'chime.ogg',
})
SMODS.Sound({
    key = 'bells',
    path = 'bells.ogg',
})

-- Global mod constants
ABYSS_CONST = {

    -- Global colour constants for mod
    COLOUR = {

        Default = HEX("EEEEEE"),
        Mystic1 = HEX("c95383"),
        Mystic2 = HEX("7376d9"),
        Ruby = HEX("d65f6f"),
        Topaz = HEX("faa64e"),
        Citrine = HEX("f8e068"),
        Emerald = HEX("74e7a8"),
        Tourmaline = HEX("75c4ea"),
        Azurite = HEX("4e6ee5"),
        Amethyst = HEX("9167d9"),
        Opal = {0, 0, 0, 1}; -- Rainbow cycling. Controlled by injected code by localization_colours.toml
        Spectrum = {0, 0, 0, 1}; -- Rainbow cycling. Controlled by injected code by localization_colours.toml

        Plasmatic = HEX("ff8229"),
        Cryonic = HEX("38c3f5"),
        
    },

    SEAL_WEIGHT = 1.0,
    MYSTIC_PRICE = 4,
}

assert(SMODS.load_file('objects/editions/plasmatic.lua'))()
assert(SMODS.load_file('objects/editions/cryonic.lua'))()
assert(SMODS.load_file('objects/jokers/swiss_cheese.lua'))()
-- assert(SMODS.load_file('objects/jokers/moldy_cheese.lua'))()
-- assert(SMODS.load_file('objects/jokers/schrodinger_box.lua'))()
-- assert(SMODS.load_file('objects/jokers/thought_experiment.lua'))()

-- seals
-- assert(SMODS.load_file('objects/seals/indigo.lua'))()
-- Shader Definition

-- Gem Shader
SMODS.Shader {
    key = 'gem',
    path = 'gem.fs'
}

-- assert(SMODS.load_file('objects/editions/gem_test.lua'))()

-- Seals
SMODS.load_file('objects/seals/ruby.lua')()
SMODS.load_file('objects/seals/topaz.lua')()
SMODS.load_file('objects/seals/citrine.lua')()
SMODS.load_file('objects/seals/emerald.lua')()
SMODS.load_file('objects/seals/tourmaline.lua')()
SMODS.load_file('objects/seals/azurite.lua')()
SMODS.load_file('objects/seals/amethyst.lua')()
-- SMODS.load_file('objects/seals/opal.lua')()

-- Mystic Cards
SMODS.load_file('objects/consumables/mystic.lua')() -- main file

SMODS.load_file('objects/consumables/spirit.lua')()
SMODS.load_file('objects/consumables/body.lua')()
SMODS.load_file('objects/consumables/mind.lua')()
SMODS.load_file('objects/consumables/hunger.lua')()
SMODS.load_file('objects/consumables/vision.lua')()
SMODS.load_file('objects/consumables/love.lua')()
SMODS.load_file('objects/consumables/dream.lua')()
SMODS.load_file('objects/consumables/wish.lua')()
SMODS.load_file('objects/consumables/momento.lua')()
SMODS.load_file('objects/consumables/grief.lua')()
SMODS.load_file('objects/consumables/nightmare.lua')()
SMODS.load_file('objects/consumables/rebirth.lua')()

-- Booster Packs
SMODS.load_file('objects/boosters/mystic.lua')()


--[[
=== This is aan alternate way of loading objects which can do it recursively in a folder structure, and defining the local object differently ===
local f = SMODS.load_file('objects/seals/test_seal.lua')
local object = f()
local item = object.items
for _, item in ipairs(object.items) do
    SMODS[item.object_type](item)
end
]]