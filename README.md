**Repository Description**

> Brings modern Pokémon typings (Steel, Dark, Fairy) to Gen 1 Recomp, complete with updated type matchups, retroactively patched vanilla Pokémon, and new signature moves injected seamlessly into level-up learnsets.

---

**README.md**

```markdown
# Gen 1 Recomp: Modern Types & Moves

A gameplay overhaul mod for the [Gen 1 Recompilation Project](https://github.com/bryanthaboi/pokemon-love2d) that introduces mechanics from later generations directly into the Kanto region. 

This mod doesn't just add the types—it fully integrates them into the game's ecosystem by updating existing Pokémon typings, modernizing vanilla moves, and adding brand-new moves to level-up learnsets.

##  Features

* **3 New Types Added:** Steel, Dark, and Fairy.
* **Modern Type Matchups:** Full offensive and defensive multipliers implemented (e.g., Fairy is immune to Dragon; Steel resists Psychic).
* **Vanilla Pokémon Retyped:** 
  * Clefairy / Clefable -> Pure Fairy
  * Jigglypuff / Wigglytuff -> Normal / Fairy
  * Magnemite / Magneton -> Electric / Steel
* **Vanilla Moves Updated:** 
  * `BITE` is now Dark.
  * `GUST` is now Flying.
  * `KARATE_CHOP` is now Fighting.
  * `SAND_ATTACK` is now Ground.
* **New Signature Moves:**
  * **Iron Head:** 80 BP, 100 Acc, Physical (Steel) - Can cause flinching.
  * **Crunch:** 80 BP, 100 Acc, Special (Dark) - Can lower Defense.
  * **Moonblast:** 95 BP, 100 Acc, Special (Fairy) - Can lower Special.
* **Dynamic Learnsets:** The new moves have been carefully injected into the chronological level-up learnsets of fitting Pokémon (e.g., Arcanine and Snorlax learn Crunch; Mew and Ninetales learn Moonblast; Onix and Aerodactyl learn Iron Head).

##  Installation

1. Download the latest release `.zip` from the Releases tab.
2. Launch Gen 1 Recomp.
3. Open the **Mod Manager** (press `F10` or navigate via the main menu).
4. Click **Import mod .zip** and select the downloaded file.
5. Ensure the mod is toggled **ON** in your load order.

*Alternatively: Extract the `modern_types` folder directly into your `%APPDATA%/pokemon-love2d/mods/` directory.*

##  Compatibility & Technical Details

* **Hot-Reload Safe:** Written with strict registry overrides to prevent duplication errors when pressing `F5` in developer mode.
* **Load Order:** Place this mod relatively high in your load order so that other mods (like UI tweaks or expanded dex mods) can read the updated type definitions.
* **Engine:** Requires `pokemon-love2d` API v2 or higher.

## 📜 License
MIT License. Feel free to fork, dissect, or include this logic in your own Gen 1 Recomp modpacks!

```
