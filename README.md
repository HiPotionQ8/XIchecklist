## **Usage**:
| Command | Description |
|---|---|
| `//lua load xichecklist` | load then <ins>**zone**</ins> to get the UI menu updated |
| `//xic hide` | to hide the UI |
| `//xic show` | to show the UI |
| `//xic copy` | to copy current tab to clipboard |

The following are updated by talking to NPCs (some require opening certain menus)  
will be saved in config so only need to do it once (or when need to update)

| Data | Description |
|---|---|
| Titles | speak to all [Titles NPCs](https://www.bg-wiki.com/ffxi/Category:Title_NPC) |
| Outpost Warps | speak to any [Nation Teleporter](https://www.bg-wiki.com/ffxi/Outpost#Nation_Teleporters) |
| MMM Maze Count | speak to [Chatnachoq](https://www.bg-wiki.com/ffxi/Chatnachoq) |
| Proto-Waypoint | speak to any [Proto-Waypoints](https://www.bg-wiki.com/ffxi/Waypoint#Proto-Waypoints) |
| Fishes Caught | Fish Tracker NPC [Katsunaga](https://www.bg-wiki.com/ffxi/Katsunaga) <br>`(Menu: Types of fish caught)` |
| Meeble Burrows | speak to any [Burrow Researcher](https://www.bg-wiki.com/ffxi/Burrow_Researcher) or [Burrow Investigator](https://www.bg-wiki.com/ffxi/Burrow_Investigator) <br>`(Menu: Review expedition specifics -> Zone)` |
| Atmacite levels | speak to any [Atmacite Refiner](https://www.bg-wiki.com/ffxi/Atmacite_Refiner) <br>`(Menu: Enrich Atmacite)` |
| Wing Skill | speak to chocobo kids [Arvilauge/Gonija/Kiria-Romaria](https://www.bg-wiki.com/ffxi/Category:Chocobo_Digging#Basics) |

<br>
By default anything completed is hidden from the UI, to show completed objectives (in green) edit the `settings.xml` and change the `showcompleted` to `true`

## **Tracking**:

- Monstrosity `(Monster levels / Race & Job Instincts / Monster variants)`
- Titles
- Moblin Maze Mongers `(Vouchers / Runes / Maze Count)`
- Meeble Burrows
- Types of fish caught
- Outpost Warps
- Records of Eminence (RoE) 
- Warps `(Home Points / Survival Guides / Waypoints / Proto-Waypoints)`
- Campaign Ops
- Quests `(San d'Oria / Bastok / Windurst / Jeuno / Aht Urhgan / Crystal War / Outlands / Other / Abyssea / Adoulin / Coalition)`
- Key items `(Permenant / Maps / Mounts / Claim Slips / Job KIs)`
- Magic Spells `(White Magic / Black Magic / Summoner Pacts / Ninjutsu / Bard Songs / Blue Magic / Trusts)`
- leveling related `(Merit / Job points / Master levels / Fishing Skill / Crafting Skill / Wing Skill)`




![screenshot](https://i.imgur.com/ckMMXEe.jpeg)

the menu will only show missing items like quests,key items, spells, home points, suvivsal guides , waypoint etc

![screenshot2](https://i.imgur.com/2UsoS9N.png)

![screenshot3](https://i.imgur.com/Ex6SHRJ.png)

![screenshot4](https://i.imgur.com/wUWDWqE.png)

![screenshot5](https://i.imgur.com/c9ZEjBP.png)

- this thing is free to use/share/edit/anything i dont care what you do with it


- need help mapping the warps_waypoints.lua correctly (assign numbers and #FS)




### **Changes**:

- 0.1.0 - release
- 0.1.1 - added Monstrosity levels and race/job instincts
- 0.1.2 - add Monstrosity variants
- 0.2.0 - added titles (thanks to kaytecat)
- 0.2.1 - added list of Titles by content
- 0.3.0 - added RoE Tracking (thanks to Daleterrence / Darkdoom for resources)
- 0.3.1 - added title exclusions & removed unlearnable spells
- 0.4.0 - A lot fixes
- 0.4.1 - removed non-implemented monstrosity
- 0.5.0 - added title obtain method, for quick reference in missing titles
- 0.5.2 - fixed unlearnable spells & waypoint mapping
- 0.6.0 - added Outpost warps / Monster Instincts + fixes/cleanup
- 0.7.0 - added Moblin Maze Mongers (Vouchers / Runes / Maze count) & Active Effects (Dynamis/Sortie Job KIs)
- 0.8.0 - added Proto-Waypoints
- 0.9.0 - added Fishes Caught / Meeble Burrows / Merits , moved Coalitions under Quests
- 0.9.2 - added Total Points / Mastery Rank / command to copy to clipboard
- 0.9.3 - added fishing / crafting skills.
- 0.9.4 - added Atmacite, Atmacite levels & Wing Skill.
