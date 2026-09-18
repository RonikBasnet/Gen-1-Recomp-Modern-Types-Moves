return function(mod)
    print("=== Modern Types: Registering Types, Moves, and Learnsets ===")

    local TYPE_STEEL = "STEEL"
    local TYPE_DARK  = "DARK"
    local TYPE_FAIRY = "FAIRY"

    -- Safe registration wrapper for F5 hot-reloading
    local function safeRegister(registry, key, data)
        if not registry then return end
        if registry.get and registry:get(key) then
            if registry.override then registry:override(key, data) end
        else
            if registry.register then registry:register(key, data) end
        end
    end

    -- ==========================================
    -- 1. REGISTER TYPE CONSTANTS
    -- ==========================================
    safeRegister(mod.content.constants, "TYPE_STEEL", TYPE_STEEL)
    safeRegister(mod.content.constants, "TYPE_DARK",  TYPE_DARK)
    safeRegister(mod.content.constants, "TYPE_FAIRY", TYPE_FAIRY)

    -- ==========================================
    -- 2. UPDATE VANILLA MOVES & REGISTER NEW MOVES
    -- ==========================================
    if mod.content.moves and mod.content.moves.patch then
        -- Retroactively patch vanilla Gen 1 moves to their modern typings
        mod.content.moves:patch("BITE",        { type = TYPE_DARK })
        mod.content.moves:patch("GUST",        { type = "FLYING" })
        mod.content.moves:patch("KARATE_CHOP", { type = "FIGHTING" })
        mod.content.moves:patch("SAND_ATTACK", { type = "GROUND" })

        -- Register brand new moves
        safeRegister(mod.content.moves, "IRON_HEAD", {
            name = "IRON HEAD", type = TYPE_STEEL, power = 80, accuracy = 100, pp = 15,
            category = "PHYSICAL", effect = "FLINCH_SIDE_EFFECT", animation = "HEADBUTT"
        })
        safeRegister(mod.content.moves, "CRUNCH", {
            name = "CRUNCH", type = TYPE_DARK, power = 80, accuracy = 100, pp = 15,
            category = "SPECIAL", effect = "DEFENSE_DOWN_SIDE_EFFECT", animation = "BITE"
        })
        safeRegister(mod.content.moves, "MOONBLAST", {
            name = "MOONBLAST", type = TYPE_FAIRY, power = 95, accuracy = 100, pp = 15,
            category = "SPECIAL", effect = "SPECIAL_DOWN_SIDE_EFFECT", animation = "SWIFT"
        })
    end

    -- ==========================================
    -- 3. RETYPE VANILLA POKEMON
    -- ==========================================
    if mod.content.pokemon and mod.content.pokemon.patch then
        mod.content.pokemon:patch("CLEFAIRY",   { types = { TYPE_FAIRY } })
        mod.content.pokemon:patch("CLEFABLE",   { types = { TYPE_FAIRY } })
        mod.content.pokemon:patch("MAGNEMITE",  { types = { "ELECTRIC", TYPE_STEEL } })
        mod.content.pokemon:patch("MAGNETON",   { types = { "ELECTRIC", TYPE_STEEL } })
        mod.content.pokemon:patch("JIGGLYPUFF", { types = { "NORMAL", TYPE_FAIRY } })
        mod.content.pokemon:patch("WIGGLYTUFF", { types = { "NORMAL", TYPE_FAIRY } })
    end

    -- ==========================================
    -- 4. INJECT INTO LEARNSETS (Using the correct 'learnset' key)
    -- ==========================================
    local function addLearnsetMove(speciesId, targetLevel, targetMoveId)
        if not mod.content.pokemon then return end
        
        local pkmn = mod.content.pokemon:get(speciesId)
        if pkmn and pkmn.learnset then
            -- Prevent duplicates on hot-reload
            for _, entry in ipairs(pkmn.learnset) do
                if entry.move == targetMoveId and entry.level == targetLevel then return end
            end
            
            -- Insert the new move
            table.insert(pkmn.learnset, { level = targetLevel, move = targetMoveId })
            
            -- Sort chronologically by level
            table.sort(pkmn.learnset, function(a, b) return a.level < b.level end)
            
            -- Patch the registry
            mod.content.pokemon:patch(speciesId, { learnset = pkmn.learnset })
        end
    end

    -- Assign Crunch (Dark)
    addLearnsetMove("EKANS",      22, "CRUNCH")
    addLearnsetMove("ARBOK",      28, "CRUNCH")
    addLearnsetMove("GROWLITHE",  35, "CRUNCH")
    addLearnsetMove("ARCANINE",   40,  "CRUNCH")
    addLearnsetMove("AERODACTYL", 40, "CRUNCH")
    addLearnsetMove("SNORLAX",    45, "CRUNCH")

    -- Assign Moonblast (Fairy)
    addLearnsetMove("CLEFAIRY",   34, "MOONBLAST")
    addLearnsetMove("CLEFABLE",   40,  "MOONBLAST")
    addLearnsetMove("JIGGLYPUFF", 34, "MOONBLAST")
    addLearnsetMove("WIGGLYTUFF", 36,  "MOONBLAST")
    addLearnsetMove("VULPIX",     32, "MOONBLAST")
    addLearnsetMove("NINETALES",  40,  "MOONBLAST")
    addLearnsetMove("MEW",        40, "MOONBLAST")

    -- Assign Iron Head (Steel)
    addLearnsetMove("ONIX",       30, "IRON_HEAD")
    addLearnsetMove("CUBONE",     28, "IRON_HEAD")
    addLearnsetMove("MAROWAK",    32, "IRON_HEAD")
    addLearnsetMove("RHYHORN",    38, "IRON_HEAD")
    addLearnsetMove("RHYDON",     42, "IRON_HEAD")
    addLearnsetMove("TAUROS",     35, "IRON_HEAD")
    addLearnsetMove("AERODACTYL", 45, "IRON_HEAD")

    print("[Modern Types] Learnsets patched successfully!")
end