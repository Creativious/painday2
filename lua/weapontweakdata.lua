Hooks:PostHook(WeaponTweakData, "init", "guntweaks", function(self)
    -- https://wiki.modworkshop.net/books/payday-2-mod-creation/page/weapons
    -- XL Minigun
    log("Loaded Painday weapon tweaks")
    self.shuno.stats.damage = 999
    self.shuno.DAMAGE = 1000
    self.shuno.stats.recoil = 50
    self.shuno.AMMO_MAX = 999999
    self.shuno.CLIP_AMMO_MAX = 99999
    self.shuno.stats.suppression = 8
    self.shuno.stats.reload = 99999999
    self.shuno.armor_piercing_chance = 1
    self.shuno.can_shoot_through_enemy = true
    self.shuno.can_shoot_through_shield = true
    self.shuno.can_shoot_through_wall = true
    self.shuno.timers.reload_not_empty = 0
    self.shuno.timers.reload_empty = 0
    self.shuno.timers.unequip = 0
    self.shuno.timers.equip = 0

    -- Saws
    self.saw.stats.damage = 999
    self.saw.AMMO_MAX = 99999
    self.saw.CLIP_AMMO_MAX = 999999
    self.saw.stats.reload = 9999999
    self.saw.timers.reload_not_empty = 0
    self.saw.timers.reload_empty = 0
    self.saw.timers.unequip = 0
    self.saw.timers.equip = 0

    self.saw_secondary.stats.damage = 999
    self.saw_secondary.AMMO_MAX = 99999
    self.saw_secondary.CLIP_AMMO_MAX = 999999
    self.saw_secondary.stats.reload = 9999999
    self.saw_secondary.timers.reload_not_empty = 0
    self.saw_secondary.timers.reload_empty = 0
    self.saw_secondary.timers.unequip = 0
    self.saw_secondary.timers.equip = 0


    -- 5/7
    self.lemming.sounds.fire = "rpg_fire"
    self.lemming.sounds.dryfire = "shotgun_dryfire"
    self.lemming.damage_near = 1000
	self.lemming.damage_far = 2000
    self.lemming.stats.damage = 9999
    self.lemming.stats.recoil = 50
    self.lemming.AMMO_MAX = 999999
    self.lemming.DAMAGE = 1000
    self.lemming.CLIP_AMMO_MAX = 9999999
    self.lemming.stats.suppression = 8
    self.lemming.stats.spread = 1
    self.lemming.stats.spread_moving = 1
    self.lemming.stats.reload = 99999999
    self.lemming.armor_piercing_chance = 1
    self.lemming.timers.reload_not_empty = 0
    self.lemming.timers.reload_empty = 0
    self.lemming.timers.unequip = 0
    self.lemming.timers.equip = 0
    self.lemming.can_shoot_through_enemy = true
    self.lemming.can_shoot_through_shield = true
    self.lemming.can_shoot_through_wall = true
    self.lemming.projectile_type = "rocket_frag"


end
)
