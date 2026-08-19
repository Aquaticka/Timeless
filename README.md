# Timeless
Timeless is a gameplay mod for Balatro which contains 7 new seals, a new set of 12 Mystic Cards, corresponding Boosters, and 2 new Editions! Timeless aims to extend core content, adjust late-game build incentives, and match the visual and gameplay design of Balatro.


Table of Contents:
  1. [Content](#content)
  2. [Design Philosophy](#design-philosophy)
  3. [Mod Development](#mod-development)
  4. [Install Guide](#install-guide)

# Content

Mystic Cards:
<img width="1728" height="1372" alt="MysticCanva" src="https://github.com/user-attachments/assets/686662cb-3af3-4654-9f0f-26aca8e83b27" />

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

Creating an effect library was central in the development of Timeless. In addition to being a programming exercise, the mod was also a game-design exercise. This means that as the mod was developed, play-tester feedback led to new mechanics, scrapping mechanics, and modifying mechanics, requiring a dynamic codebase to adjust to each new change. Initially, each effect was modifying and getting data directly from Balatro's systems. This was effective in getting the first few seals working, but quickly led to problems. Similar effects had inconsistent VFX and interactions, changes to common algorithms had to happen at all their instances, and modifying scripts was challenging due to bloated, unabstracted code. This resulted in sluggish development, since each adjustment or addition became a recollection challenge and required repetitive modifications. To facilitate quick iteration and development, the "Aqua Library" was created to handle common operations across scripts. Each script was decomposed into its component parts, which were abstracted into common functions for any script to use. For example, the script for the Mystic card "Hunger" can be decomposed into the following operations: trigger the consumable, flip over selected cards, destroy a random selected card, given an edition to the remaining card, flip back over the remaining card, and deselect the card. Each individual operation can then be used across mechanics, vastly reducing the amount of time taken to create and modify mechanics: "Love" can then reuse the trigger, flip, and deselection operations in addition to new operations created for its script.


Emerald Seal Queuing:

Understanding Balatro's systems was core to implementing the Emerald Seal's effect. Like many games games, Balatro uses an event manager to handle functions which are executed over a given time interval. Calculating a played hand is a central example of this: when a hand is played, all of the played cards, seals, editions, jokers, and vouchers add an event to the event queue. The order of events in the queue determines the sequence/timing of the scoring and VFX which display on screen during the hand. This works great for standard mechanics, but problems arise when a mechanic's effect depends on the game state at execution time. The Emerald Seal creates an event to select a random card of the player's consumables and randomly generate a replacement card and copies it. To destroy and replace the card, a child event must be spawned to handle removal, replacement, and copying. However, the Aqua Library's functions only added events to the end of the queue. This meant that the child events occurred after the rest of the  hand ended, resulting in the sequence happening at the wrong time and failing to update the game state dynamically. To solve this, the parent event had to spawn child events to the start of the queue, requiring this functionality to be included in the Aqua Library. This works conceptually, but the queue locally becomes a stack: the first child event to be added will be the last one to executed. By reversing the order of child events, the implementation for the Emerald seal was found: a parent event picks which card to replace, then adds a child event to copy, replace, and destroy it, which get executed in reverse order.





# Install Guide
Instructions:
  1. Download Lovely Code Injector (https://github.com/ethangreen-dev/lovely-injector). This is a dependency for Steammodded and the Timeless mod.
  2. Download Steammodded Balatro (https://github.com/Steamodded/smods/wiki). This is the primary mod manager and modding framework used for many Balatro mods, including Timeless.
  3. Download the Timeless mod file (https://github.com/Aquaticka/Timeless/releases).
  4. Navigate to the Mods folder in your Balatro game files (%AppData%/Balatro/Mods is the default path on windows).
  5. Place the folder in your Mods folder.
  6. Launch Balatro and play!
