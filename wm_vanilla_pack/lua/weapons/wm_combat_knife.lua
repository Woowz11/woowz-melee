AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.combat_knife",
		Icon = "icons/wm_combat_knife.png",
		SelectionIcon = "icons/wm_combat_knife_i.png",
		KillIcon = "icons/wm_combat_knife_k.png",
		Material = MAT_METAL,
		Sharp = true,
		VModel = "models/wm/combat_knife/v.mdl",
		VModelPos = Vector(1,2,-1),
		VModelRot = Angle(0,-5,-10),
		FOV = 75,
		WModel = "models/wm/combat_knife/w.mdl",
		Hold = "knife",
		Rays = {{Angle(-10,-15,0),0},{Angle(0,0,0),0.02},{Angle(10,15,0),0.02}},
		RaysDetails = 3,
		OnlyOneRay = true,
		WModelPos = Vector(2, -0.75, 0.5),
		WModelRot = Angle(200, 160, 0),
		AnimationHit = {"H1_Wpn_Melee_Bayonet_Knife_Swipe"},
		AnimationIdle = "H1_Wpn_Melee_Bayonet_Knife_Idle",
		AnimationDraw = "H1_Wpn_Melee_Bayonet_Knife_Pullout",
		AnimationInspect = {"H1_Wpn_Melee_Point_Knife_Inspect","H1_Wpn_Melee_Point_Knife_Pullout_First"},
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0,
		AttackDistance = 60,
		Damage = Vector(15,35),
		DamageProp = Vector(0,5),
		PunchAngle = Angle(1,5,0),
		InertiaScale = 0.25,
		SwingSounds = WMLib.SoundsSwing["LightSharp"],
		BlockPos = Vector(0,2,3),
		BlockRot = Angle(0,0,-30),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(0,0,0),
		BlockHold = "fist",
		BlockWait = 1,
		BlockPower = 0.5,
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,2)
			if rand == 1 then
				curinfo.AnimationHit = {"H1_Wpn_Melee_Bayonet_Knife_Swipe"}
				curinfo.PunchAngle = Angle(1,5,0)
				curinfo.Rays = {{Angle(-10,-15,0),0},{Angle(0,0,0),0.02},{Angle(10,15,0),0.02}}
				curinfo.AttackDistance = 60
				curinfo.Sharp = true
			else
				curinfo.AnimationHit = {"H1_Wpn_Melee_Bayonet_Knife_Stab"}
				curinfo.PunchAngle = Angle(-5,0,0)
				curinfo.Rays = {{Angle(0,0,0),0},{Angle(5,0,0),0},{Angle(-5,0,0),0},{Angle(0,0,0),0},{Angle(0,5,0),0},{Angle(0,-5,0),0}}
				curinfo.AttackDistance = 80
				curinfo.Sharp = false
			end

			return curinfo
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end