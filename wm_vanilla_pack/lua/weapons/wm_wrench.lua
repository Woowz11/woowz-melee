AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.wrench",
		Icon = "icons/wm_wrench.png",
		SelectionIcon = "icons/wm_wrench_i.png",
		KillIcon = "icons/wm_wrench_k.png",
		Material = MAT_METAL,
		VModel = "models/wm/wrench/v.mdl",
		VModelPos = Vector(-8,3,-1),
		VModelRot = Angle(0,-5,0),
		FOV = 80,
		WModel = "models/wm/wrench/w.mdl",
		Hold = "melee",
		Rays = {{Angle(0,-10,0),0},{Angle(0,0,0),0.025},{Angle(0,10,0),0.025}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(1.5, -1, 2),
		WModelRot = Angle(180, 150, 5),
		AnimationHit = {"Attack_Quick"},
		AnimationDraw = "Draw",
		AnimationIdle = "Idle",
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.3,
		AttackDistance = 60,
		Damage = Vector(5,20),
		DamageProp = Vector(10,30),
		PunchAngle = Angle(0,10,0),
		BlockPos = Vector(0,8,-5),
		BlockRot = Angle(5,0,-30),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(0,45,-45),
		BlockHold = "camera",
		BlockWait = 1,
		BlockPower = 0.5,
		SwingSounds = WMLib.SoundsSwing["Light"]
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end