AddCSLuaFile()
local Info = {
	Name = "#wm.weapon.biginertia",
	VModel = "models/weapons/c_crowbar.mdl",
	VModelPos = Vector(-1,0,0),
	FOV = 70,
	WModel = "models/weapons/w_crowbar.mdl",
	Hold = "melee",
	Rays = {{Angle(-20,-20,0),0},{Angle(0,0,0),0},{Angle(20,20,0),0}},
	RaysDetails = 4,
	OnlyOneRay = true,
	WModelPos = Vector(3, -1.25, -4),
	WModelRot = Angle(270,0,70),
	AnimationHit = {"Misscenter1","Misscenter2"},
	AnimationDraw = "Draw",
	AnimationIdle = "Idle01",
	AttackWait = Vector(0.5,0,0),
	AttackHitWait = 0,
	AttackDistance = 80,
	Damage = Vector(30,30),
	DamageProp = Vector(30,30),
	InertiaScale = 10,
	PunchAngle = Angle(0,0,0),
	BlockPos = Vector(0,10,-8),
	BlockRot = Angle(0,0,-45),
	WBlockPos = Vector(4,-3,2),
	WBlockRot = Angle(-45,-45,0),
	BlockWait = 1,
	BlockPower = 0.25,
	SwingSounds = WMLib.SoundsSwing["Light"],
}
WMLib.CreateMelee(SWEP,Info,"vanilla")