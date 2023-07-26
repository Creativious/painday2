function Painday:create_menu()
    if self.menu then
        return
    end

    self.menu_title_size = 22
    self.menu_items_size = 18
    self.menu_padding = 16
    self.menu_background_color = Color.black:with_alpha(0.75)
    self.menu_accent_color = BeardLib.Options:GetValue("MenuColor"):with_alpha(0.75)
    self.menu_highlight_color = self.menu_accent_color:with_alpha(0.075)
    self.menu_grid_item_color = Color.black:with_alpha(0.5)

    self.menu = MenuUI:new({
        name = "PaindayConfigurationMenu",
        layer = 1000,
        background_blur = true,
        animate_toggle = true,
        text_offset = 3,
        show_help_time = 0.5,
        border_size = 1,
        accent_color = self.menu_accent_color,
        highlight_color = self.menu_highlight_color,
        localized = true,
        use_default_close_key = true,
        disable_player_controls = true
    })

    self.menu_w = self.menu._panel:w()
    self.menu_h = self.menu._panel:h()

    self._menu_w_left = self.menu_w / 3.5 - self.menu_padding
    self._menu_w_right = self.menu_w - self._menu_w_left - self.menu_padding * 2

    local menu = self.menu:Menu({
        background_color = self.menu_background_color
    })

    local title = menu:DivGroup({
        text = "painday_menu_main_name",
        size = 26,
        background_color = Color.transparent,
        position = {self.menu_padding, self.menu_padding}
    })

    local module_management = menu:DivGroup({
        text = "painday_module_config_name",
        size = self.menu_title_size,
        inherit_values = {
            size = self.menu_items_size
        },
        border_bottom = true,
        border_position_below_title = true,
        w = self._menu_w_left,
        position = { self.menu_padding, title:Bottom()}
    })

    module_management:Toggle({
        name = "weapon_tweaks_toggle",
        text = "painday_weapon_tweaks_toggle_name",
        help = "painday_weapon_tweaks_toggle_name_desc",
        on_callback = function(item) self.settings.enable_weapon_tweaks = item:Value()
            self:save()
        end,
        value = self.settings.enable_weapon_tweaks
    })

    self.modules_menu = menu:DivGroup({
        name = "painday_module_notebook_menu",
        text = "painday_module_notebook_modules_name",
        position = {module_management:Right(), module_management:Y()},
        size = self.menu_title_size,
        border_bottom = true,
        border_position_below_title = true,
        w = self._menu_w_left * 2
    })

    self.module_selector = module_management:ComboBox({
        name = "painday_module_selector_combobox",
        text = "painday_module_selector_combobox_name",
        enabled = self.settings.enable_weapon_tweaks,
        items = {},
        on_callback = function(item)
            log("Selected item", tostring(item:SelectedItem()))
            log("Index", tostring(item:Value()))
        end
    })

end

function Painday:set_menu_state(enabled)
    self:create_menu()
    if enabled and not self.menu:Enabled() then
        self.menu:Enable()
    elseif not enabled then
        self.menu:Disable()
    end
end

function Painday:create_weapon_tweaks_module_menu()
    self.weapon_tweaks_module_menu = self.modules_menu:DivGroup({
        localized = false,
        name = "painday_module_weapon_tweaks_menu",
        text = "painday_module_weapon_tweaks_menu_title",
        position = {self.modules_menu:X(), self.modules_menu:Y()},
        max_height = self.menu_h / 2,
        enabled = false
    })
end

function Painday:referesh_module_selector()
    self.module_selector:SetEnabled(self.settings.enable_weapon_tweaks)
    self.module_selector:Clear()
    local items = {}
    if self.settings.enable_weapon_tweaks then
        self:create_weapon_tweaks_module_menu()
        self.weapon_tweaks_module_menu:Disable()
        
    end
end


Hooks:Add("MenuManagerPostInitialize", "MenuManagerPostInitializePainday", function(menu_manager)
    Painday:load()
    MenuCallbackHandler.painday_open_menu = function ()
        Painday:set_menu_state(true)
    end

    MenuHelperPlus:AddButton({
        id = "PaindayConfigurationMenu",
        title = "painday_menu_main_name",
        desc = "painday_menu_main_desc",
        node_name = "blt_options",
        callback = "painday_open_menu"
    })
end)