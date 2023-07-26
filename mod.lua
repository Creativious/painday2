if not Painday then
    _G.Painday = {}
    Painday.mod_path = ModPath
    Painday.save_path = SavePath .. "Painday/"
    for i, v in pairs(file.GetFiles(Painday.mod_path .. "req/")) do
        local f_name = Painday.mod_path .. "req/" .. v
        log(f_name)
        if io.file_is_readable(f_name) then
            dofile(f_name)
        end
    end
    
    Painday.default_settings = {
        enable_weapon_tweaks = false,
        currently_selected_module = "",
        menu_settings = {}
    }
    Painday.settings = clone(Painday.default_settings)
    Painday.weapon_tweaks = {
        gun_tweaks = {},
        melee_tweaks = {}
    }
    Painday.language_keys = {
        [Idstring("english"):key()] = "english"
    }
end
-- if RequiredScript then
--     local file_name = Painday.mod_path .. "lua/" .. RequiredScript:gsub(".+/(.+)", "%1.lua")
--     log(file_name)
--     log(RequiredScript)
--     if io.file_is_readable(file_name) then
--         dofile(file_name)
--     end
-- end

for i, v in pairs(file.GetFiles(Painday.mod_path .. "lua/")) do
    local f_name = Painday.mod_path .. "lua/" .. v
    log(f_name)
    if io.file_is_readable(f_name) then
        dofile(f_name)
    end
end