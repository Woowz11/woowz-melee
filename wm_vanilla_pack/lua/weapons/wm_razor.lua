AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.razor",
		Icon = "icons/wm_razor.png",
		SelectionIcon = "icons/wm_razor_i.png",
		KillIcon = "icons/wm_razor_k.png",
		Material = MAT_METAL,
		Sharp = true,
		Funny = true,
		VModel = "models/wm/razor/v.mdl",
		VModelPos = Vector(-4,1,-4),
		VModelRot = Angle(0,-5,0),
		FOV = 100,
		WModel = "models/wm/razor/w.mdl",
		Hold = "knife",
		Rays = {{Angle(0,-20,0),0},{Angle(0,0,0),0.001},{Angle(0,20,0),0.001}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(3.4, -1, -0.5),
		WModelRot = Angle(200, 150, 0),
		AnimationHit = {"H1_Wpn_Melee_Razor_Swipe"},
		AnimationDraw = "H1_Wpn_Melee_Razor_Pullout_First",
		AnimationIdle = "H1_Wpn_Melee_Razor_Idle",
		AnimationInspect = {"H1_Wpn_Melee_Razor_Inspect"},
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.1,
		AttackDistance = 50,
		Damage = Vector(5,15),
		DamageProp = Vector(0,1),
		PunchAngle = Angle(0,10,0),
		IdleScale = 2,
		InertiaScale = 0.25,
		BlockPos = Vector(3,2,-3),
		BlockRot = Angle(0,0,-40),
		WBlockPos = Vector(0,-1,0),
		WBlockRot = Angle(0,0,-20),
		BlockHold = "melee2",
		BlockWait = 1,
		BlockPower = 0.5,
		SwingSounds = WMLib.SoundsSwing["LightSharp"],
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,2)
			if rand == 1 then
				curinfo.AnimationHit = {"H1_Wpn_Melee_Razor_Swipe"}
				curinfo.PunchAngle = Angle(0,10,0)
				curinfo.Rays = {{Angle(0,-20,0),0},{Angle(0,0,0),0.001},{Angle(0,20,0),0.001}}
				curinfo.AttackDistance = 50
				curinfo.AttackHitWait = 0.1
				curinfo.OnlyOneRay = true
			else
				curinfo.AnimationHit = {"H1_Wpn_Melee_Razor_Stab"}
				curinfo.PunchAngle = Angle(5,0,0)
				curinfo.Rays = {{Angle(0,0,0),0},{Angle(10,-10,0),0.1}}
				curinfo.AttackDistance = 70
				curinfo.AttackHitWait = 0
				curinfo.OnlyOneRay = false
			end
			return curinfo
		end,
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end