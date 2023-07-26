---Returns the language of the game
---@return string
function Painday:get_game_language()
    return self.language_keys[SystemInfo:language():key()] or "english"
end

---Returns the modded language
---@return string
function Painday:get_modded_language()
    local mod_language = PD2KR and "korean" or PD2PTBR and "portuguese"
    if mod_language then
        return mod_language
    end
    local mod_language_table = {
        ["PAYDAY 2 THAI LANGUAGE Mod"] = "thai"
    }
    for _, mod in pairs(BLT and BLT.Mods:Mods() or {}) do
        if mod:IsEnabled() and mod_language_table[mod:GetName()] then
            return mod_language_table[mod:GetName()]
        end
    end
end


function Painday:load_localization(path, localization_manager)
    localization_manager = localization_manager or managers.localization
    if not localization_manager then
        log("[Painday] ERROR: No localization manager available to load localization for " .. path .. "!")
        return
    end

    local language
    local system_language = self:get_game_language()
    local blt_language = BLT.Localization:get_language().language
    local mod_language = self:get_modded_language()

    if io.file_is_readable(path .. system_language .. ".txt") then
        language = system_language
    end
    if io.file_is_readable(path .. blt_language .. ".txt") then
        language = blt_language
    end
    if mod_language and io.file_is_readable(path .. mod_language .. ".txt") then
        language = mod_language
    end

    if io.file_is_readable(path .. "english.txt") then
        localization_manager:load_localization_file(path .. "english.txt")
    end
    if language and language ~= "english" then
        localization_manager:load_localization_file(path .. language .. ".txt")
    end
    return language or "english"
end


Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInitPainday", function(loc)

    Painday:load_localization(Painday.mod_path .. "loc/", loc)

end)

function Painday:save()
    if not FileIO:DirectoryExists(self.save_path) then
        FileIO:MakeDir(self.save_path)
    end
    local file = io.open(self.save_path .. "painday_settings.txt", "w+")
    if file then
        file:write(json.encode(self.settings))
    end
end

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end

function Painday:load()
    if not FileIO:DirectoryExists(self.save_path) then
        return
    end
    local painday_settings_path = self.save_path .. "painday_settings.txt"
    local file = io.open(painday_settings_path, "r")
    if file then
        local data = file:read("*all")
        if data == "" then
            return
        end
        data = json.decode(data)
        file:close()
        for k, v in pairs(data) do
            if not table.contains(self.default_settings, k) then
                self.settings[k] = v
            end
        end
    end
end


function Painday:get_weapon_gun_list()
    local weapons = Global.blackmarket_manager.weapons
    local owned_weapons = {}
    for k,v in weapons do
        if v.owned then
            owned_weapons[k] = v
        end
    end
end

function Painday:get_weapon_gun_tweak_data(weapon_id)
    return tweak-data.weapon[weapon_id] or {}
end