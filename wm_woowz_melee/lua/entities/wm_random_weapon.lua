AddCSLuaFile()

ENT.PrintName = "#wm.entity.randomweapon"
ENT.Author = "Woowz11"
ENT.Category = "Fun + Games"
ENT.Type = "point"
ENT.IconOverride = "icons/wm_random_weapon.png"
ENT.Information = ""
ENT.Spawnable = GetConVar("wm_enabled"):GetBool()
ENT.AdminOnly = GetConVar("wm_onlyadmin"):GetBool()
ENT.NoSitAllowed = true
ENT.DisableDuplicator = true
ENT.DoNotDuplicate = true
ENT.PhysgunDisabled = true