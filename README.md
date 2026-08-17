# Timeless
Timeless is a gameplay mod for Balatro which contains 7 new seals, a new set of 12 Mystic Cards, corresponding Boosters, and 2 new Editions! Timeless aims to extend core content, adjust late-game build incentives, and match the visual and gameplay design of Balatro.


Table of Contents:
  1. [Content](#content)
  2. [Design Philosophy](#design-philosophy)
  3. [Mod Development](#mod-development)
  4. [Install Guide](#install-guide)

# Content

Mystic Cards:

<img width="2172" height="1626" alt="MysticCollage" src="https://github.com/user-attachments/assets/832a18ac-e066-4e1d-9a4c-c7d3b339d770" />

Seals:

<img width="951" height="542" alt="SealShelf" src="https://github.com/user-attachments/assets/12c59d8a-813c-4466-b354-b46feaf1f63d" />

<img width="223" height="205" alt="Topaz" src="https://github.com/user-attachments/assets/0c9b4f24-699e-4d00-8990-23d0a97591a7" />
<img width="266" height="210" alt="Ruby" src="https://github.com/user-attachments/assets/86a96afe-4ef1-4977-8375-8219ad4a7fd9" />
<img width="352" height="206" alt="Emerald" src="https://github.com/user-attachments/assets/2e8f9ee4-5137-4059-a552-a81fc4f050ef" />
<img width="276" height="189" alt="Citrine" src="https://github.com/user-attachments/assets/62226d79-5d5e-4249-8734-17493fa194b5" />
<img width="286" height="212" alt="Azurite" src="https://github.com/user-attachments/assets/ca5c3f59-f218-449b-8913-62805f569699" />
<img width="334" height="208" alt="Amethyst" src="https://github.com/user-attachments/assets/3f3080eb-1369-420a-ac69-643c0f19cd89" />
<img width="288" height="206" alt="Tourmaline" src="https://github.com/user-attachments/assets/e4ced701-4811-4bac-9861-ec35109cde67" />

Editions:

<img width="169" height="105" alt="2026-08-1015-32-26-ezgif com-crop" src="https://github.com/user-attachments/assets/73b23e93-6ff9-4a2e-b19f-52360ee84294" />

<img width="253" height="325" alt="Plasmatic" src="https://github.com/user-attachments/assets/01bcef40-3ca9-4214-8d28-e6258b7453f8" />
<img width="219" height="316" alt="CryonicPNG" src="https://github.com/user-attachments/assets/947c8b14-d0a2-4451-8894-033eb60b9375" />

# Design Philosophy

Timeless aims to extend core content, adjust late-game build incentives, and match the design of vanilla Balatro. Currently, builds converge on a small number of strong late-game setups, and leverage the same utility effects. This can result in repetitive gameplay across runs

# Mod Development

Working within an existing game can be trickier in some ways than building your own game.

Coding New Mechanics:
Timeless implements mechanics outside of what already exists in Balatro. This required scripting new mechanics and modifying game systems, which required the mod to understand and interact directly with the source code. The [Lovely Injector](https://github.com/ethangreen-dev/lovely-injector) provided a method to dump the game's code into its source files, and to modify/inject new code at runtime. This was used to expand the localization parser, and inject a Skip Tag check at the end of each round. This let the mod render colourful, well-formatted effect descriptions to communicate new mechanics, and ensure the Memento/Tourmaline Seal effects trigger when they should. The [Steammodded Modloader](https://github.com/Steamodded/smods) provided a method for loading scripts into the game. This was used to load scripts for Mystic Card and Seal mechanics, and to load custom shaders for the new Editions.

Problem, Goal, Solution.

Building the Library:
Emerald Seal Queuing:





# Install Guide
Instructions:
  1. Download Lovely Code Injector (https://github.com/ethangreen-dev/lovely-injector). This is a dependency for Steammodded and the Timeless mod.
  2. Download Steammodded Balatro (https://github.com/Steamodded/smods/wiki). This is the primary mod manager and modding framework used for many Balatro mods, including Timeless.
  3. Download the Timeless mod file (https://github.com/Aquaticka/Timeless/releases).
  4. Navigate to the Mods folder in your Balatro game files (%AppData%/Balatro/Mods is the default path on windows).
  5. Place the folder in your Mods folder.
  6. Launch Balatro and play!
