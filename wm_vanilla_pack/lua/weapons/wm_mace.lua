AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.mace",
		Icon = "icons/wm_mace.png",
		SelectionIcon = "icons/wm_mace_i.png",
		KillIcon = "icons/wm_mace_k.png",
		Material = MAT_METAL,
		Heavy = false,
		VModel = "models/wm/mace/v.mdl",
		VModelPos = Vector(-3,0,-1),
		VModelRot = Angle(0,-5,-10),
		FOV = 70,
		WModel = "models/wm/mace/w.mdl",
		Hold = "melee2",
		Rays = {{Angle(0,-30,0),0},{Angle(0,0,0),0.1},{Angle(0,30,0),0.1}},
		RaysDetails = 3,
		OnlyOneRay = true,
		WModelPos = Vector(3.2, -1.5, -2.5),
		WModelRot = Angle(180, 270, 0),
		AnimationHit = {"Slash1"},
		AnimationDraw = "Draw",
		AttackWait = Vector(1.5,0,50),
		AttackHitWait = 0.7,
		AttackDistance = 60,
		Damage = Vector(35,45),
		DamageProp = Vector(10,30),
		IdleScale = 0.5,
		SwayScale = 4,
		KickScale = 2,
		InertiaScale = 1.5,
		PunchAngle = Angle(0,-5,0),
		BlockPos = Vector(-2,0,-10),
		BlockRot = Angle(0,0,-70),
		WBlockPos = Vector(1,-1,1),
		WBlockRot = Angle(-45,0,0),
		BlockHold = "knife",
		BlockWait = 0.5,
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,3)
			if rand == 1 then
				curinfo.AnimationHit = {"Slash1"}
				curinfo.PunchAngle = Angle(0,-5,0)
				curinfo.Rays = {{Angle(0,30,0),0},{Angle(0,0,0),0.075},{Angle(0,-30,0),0.075}}
				curinfo.AttackHitWait = 0.3
				curinfo.AttackDistance = 60
				curinfo.Heavy = false
			elseif rand == 2 then
				curinfo.AnimationHit = {"Slash3"}
				curinfo.PunchAngle = Angle(0,5,0)
				curinfo.Rays = {{Angle(0,-30,0),0},{Angle(0,0,0),0.075},{Angle(0,30,0),0.075}}
				curinfo.AttackHitWait = 0.3
				curinfo.AttackDistance = 60
				curinfo.Heavy = false
			else
				curinfo.AnimationHit = {"Slash2"}
				curinfo.PunchAngle = Angle(-5,0,0)
				curinfo.Rays = {{Angle(0,0,0),0},{Angle(-5,-5,0),0},{Angle(0,0,0),0},{Angle(5,5,0),0},{Angle(0,0,0),0},{Angle(5,-5,0),0},{Angle(0,0,0),0},{Angle(-5,5,0),0}}
				curinfo.AttackHitWait = 0.4
				curinfo.AttackDistance = 80
				curinfo.Heavy = true
			end

			return curinfo
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end