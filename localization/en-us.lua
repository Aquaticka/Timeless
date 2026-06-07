return {
    descriptions = {
        Edition = {
            e_abyss_plasmatic = {
                name = "Plasmatic",
                text = {
                    "{X:mult,C:white}X#1#{} Mult"
                }
            },
            e_abyss_cryonic = {
                name = "Cryonic",
                text = {
                    "{X:chips,C:white}X#1#{} Chips"
                }
            }
        },
        Joker = {
            j_abyss_swiss_cheese = {
                name = "Swiss Cheese",
                text = {
                    "{C:money}$#1#{} per round",
                    "{C:money}$-1{} per round",
                    "played"
                }
            },
            j_abyss_moldy_cheese = {
                name = "Moldy Cheese",
                text = {
                    "{X:mult,C:white}X#1#{} Mult"
                }
            },
            j_abyss_schrodinger_box = {
                name = "Schrodinger's Box",
                text = {
                    "{C:green}#1# in #2# {} chance for",
                    "{X:dark_edition,C:white}^#3#{} Mult. Otherwise,",
                    "{X:dark_edition,C:white}^#4#{} Mult."
                }
            },
            j_abyss_thought_experiment = {
                name = "Thought Experiment",
                text = {
                    "{X:mult,C:white}X#1#{} Mult at {C:attention}12:00{}, Clock ticks",
                    "when hand played or discarded",
                    "{C:inactive}(Currently {}{C:attention}#2#:00{}{C:inactive}){}"
                }
            }
        },
        abyss_Mystic = {
            c_abyss_body = {
                name = "Body",
                text = {
                    "Change the suits of {C:attention}#1#{} cards to",
                    "{C:spades}#2#{}, {C:hearts}#3#{}, {C:clubs}#4#{}, {C:diamonds}#5#{},",
                    "They gain a random enhancement"
                    
                }
            },
            c_abyss_dream = {
                name = "Dream",
                text = {
                    "{C:green}#2# in #3#{} chance for",
                    "{C:attention}+#1#{} hand size"
                }
            },
            c_abyss_grief = {
                name = "Grief",
                text = {
                    "Destroys {C:attention}all{} selected",
                    "cards if they share",
                    "a {C:attention}rank{} or {C:attention}suit{}"
                }
            },
            c_abyss_hunger = {
                name = "Hunger",
                text = {
                    "Select {C:attention}#1#{} cards. One",
                    "is destroyed, the other",
                    "gains a random {C:dark_edition}Edition{}"
                }
            },
            c_abyss_love = {
                name = "Love",
                text = {
                    "Adds a random {C:spectrum}Gem{}",
                    "{C:spectrum}Seal{} to {C:attention}#1#{} selected",
                    "cards in your hand"
                }
            },
            c_abyss_mind = {
                name = "Mind",
                text = {
                    "Creates a random",
                    "{C:spectral}Spectral{} card"
                }
            },
            c_abyss_momento = {
                name = "Momento",
                text = {
                    "Creates a",
                    "{C:attention}Voucher Tag{}"
                }
            },
            c_abyss_nightmare = {
                name = "Nightmare",
                text = {
                    "Adds {C:dark_edition}Negative{} to",
                    "a random Joker,",
                    "{C:blue}-#1#{} Hands {C:red}-#2#{} Discard"
                }
            },
            c_abyss_rebirth = {
                name = "Rebirth",
                text = {
                    "Split {C:attention}#1#{} selected card",
                    "into a copy with {C:attention}+1{} rank",
                    "and a copy with {C:attention}-1{} rank"
                }
            },
            c_abyss_spirit = {
                name = "Spirit",
                text = {
                    "Creates a random ",
                    "{C:uncommon}Uncommon{} or {C:rare}Rare{}",
                    "Joker card"
                }
            },
            c_abyss_vision= {
                name = "Vision",
                text = {
                    "Select {C:attention}#1#{} cards. Increase",
                    "their ranks by {C:attention}+1{} and {C:attention}+2{}",
                    "respectively"
                }
            },
            c_abyss_wish= {
                name = "Wish",
                text = {
                    "Gain {C:money}$1{} per improved card",
                    "in full deck, up to {C:money}$#2#{}.",
                    "{C:inactive}(Currently {C:money}$#1#{C:inactive})"
                }
            },
        },
        Other = {
            abyss_amethyst_seal = {
                name = "Amethyst Seal",
                text = {
                    "Creates a random {C:mystic}Mystic{} and",
                    "{C:spectral}Spectral{} consumable when",
                    "this card is {C:attention}destroyed{}"
                }
            },
            abyss_azurite_seal = {
                name = "Azurite Seal",
                text = {
                    "{X:chips,C:white}X#1#{} Chips when scored",
                    "if {C:attention}played hand{} is {C:attention}not{}",
                    "highest {C:planet}level{} hand"
                }
            },
            abyss_citrine_seal = {
                name = "Citrine Seal",
                text = {
                    "Earn {C:money}$#1#{} when scored",
                    "per card in played hand"
                }
            },
            abyss_emerald_seal = {
                name = "Emerald Seal",
                text = {
                    "{C:green}#1# in #2#{} chance to create a {C:dark_edition}Negative{}",
                    "copy of {C:attention}1{} consumable you possess",
                    "when scored in {C:attention}first{} hand of round"
                }
            },
            abyss_opal_seal = {
                name = "Opal Seal",
                text = {
                    "{C:attention}Temporary{} description for now!"
                }
            },
            abyss_ruby_seal = {
                name = "Ruby Seal",
                text = {
                    "{X:mult,C:white}X#1#{} to {C:attention}total{} Mult",
                    "Repeated once per {C:attention}lowest{}",
                    "hand {C:attention}playcount{}"
                }
            },
            abyss_topaz_seal = {
                name = "Topaz Seal",
                text = {
                    "Creates a {C:purple}Tarot{}",
                    "card if {C:attention}held{} in",
                    "hand at {C:attention}round end{}"
                }
            },
            abyss_tourmaline_seal = {
                name = "Tourmaline Seal",
                text = {
                    "Creates a random {C:tourmaline}Tag{}",
                    "when discarded"
                }
            },
        }
    },
    misc = {
        dictionary = {
            abyss_azurite_miss = "Cap!",
            abyss_citrine_miss = "Squirt!",
            abyss_emerald_hit = "Perkeo!",
            abyss_emerald_miss = "Nope!",
            abyss_emerald_slow = "Slowpoke!",
            abyss_ruby_miss = "Snap!",
            abyss_topaz_hit = "Sacrificed!",
            abyss_tourmaline_hit = "+1 Tag",

            abyss_dream_hit = "+1 Hand Size",

            abyss_spectral = "+1 Spectral",
            abyss_mystic = "+1 Mystic",
            abyss_tarot = "+1 Tarot",

            abyss_cheese_eaten = "Eaten!",
            abyss_cheese_munch = "Munch!",
            abyss_clock_toll = "Tock!",
            abyss_schrodinger_hit = "Cat!",
            abyss_schdoringer_miss = "Poison!",
            abyss_spectral_miss = "OooOo...",
            abyss_spectral_plus = "+1 Spectral",
            
            abyss_eaten = "Eaten!",
            abyss_miss = "Nope!",
            abyss_sacrificed = "Sacrificed!",

            k_abyss_mystic = "Mystic",

            b_abyss_mystic_cards = "Mystic Cards",
        },
        labels = {
            abyss_plasmatic = "Plasmatic",
            abyss_cryonic = "Cryonic",

            abyss_amethyst_seal = "Amethyst Seal",
            abyss_azurite_seal = "Azurite Seal",
            abyss_citrine_seal = "Citrine Seal",
            abyss_emerald_seal = "Emerald Seal",
            abyss_opal_seal = "Opal Seal",
            abyss_ruby_seal = "Ruby Seal",
            abyss_topaz_seal = "Topaz Seal",
            abyss_tourmaline_seal = "Tourmaline Seal",
        }
    }
}