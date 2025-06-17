AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.hammer",
		Icon = "icons/wm_hammer.png",
		SelectionIcon = "icons/wm_hammer_i.png",
		KillIcon = "icons/wm_hammer_k.png",
		Material = MAT_METAL,
		VModel = "models/wm/hammer/v.mdl",
		VModelPos = Vector(-1,-3,-1),
		VModelRot = Angle(0,-5,5),
		FOV = 90,
		WModel = "models/wm/hammer/w.mdl",
		Hold = "melee",
		Rays = {{Angle(-5,0,0),0},{Angle(5,0,0),0.01},{Angle(15,0,0),0.01}},
		OnlyOneRay = true,
		WModelPos = Vector(3.2, -1.5, 1),
		WModelRot = Angle(180, 120, 0),
		AnimationHit = {"Attack_Quick_1","Attack_Quick_2"},
		AnimationDraw = "Draw",
		AnimationIdle = "Idle",
		AttackWait = Vector(0.8,-50,0),
		AttackHitWait = 0.35,
		Damage = Vector(5,20),
		DamageProp = Vector(10,30),
		PunchAngle = Angle(7,0,0),
		AttackDistance = 60,
		InertiaScale = 0.5,
		BlockPos = Vector(0,10,0),
		BlockRot = Angle(0,0,-40),
		WBlockPos = Vector(0,0,-1),
		WBlockRot = Angle(80,0,-30),
		BlockHold = "camera",
		BlockWait = 1,
		BlockPower = 0.5,
		SwingSounds = WMLib.SoundsSwing["Light"]
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end