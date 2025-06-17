AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.baseball_bat",
		Icon = "icons/wm_baseball_bat.png",
		SelectionIcon = "icons/wm_baseball_bat_i.png",
		KillIcon = "icons/wm_baseball_bat_k.png",
		Heavy = true,
		Material = MAT_METAL,
		VModel = "models/wm/baseball_bat/v.mdl",
		VModelPos = Vector(-3,-2,-1),
		VModelRot = Angle(0,-5,0),
		FOV = 80,
		WModel = "models/wm/baseball_bat/w.mdl",
		Hold = "melee2",
		Rays = {{Angle(-50,-30,0),0},{Angle(0,0,0),0.03},{Angle(50,30,0),0.03}},
		RaysDetails = 4,
		OnlyOneRay = false,
		WModelPos = Vector(3.2, -1.5, -1.5),
		WModelRot = Angle(180, 270, 0),
		AnimationHit = {"Attack_Charge_Begin"},
		AnimationHitEnd = "Attack_Charge_End",
		HitSounds = {"phx/hmetal1.wav","phx/hmetal2.wav","phx/hmetal3.wav"},
		AnimationDraw = "Draw",
		AnimationIdle = "Idle",
		AttackWait = Vector(1,-25,25),
		AttackHitWait = 0.3,
		AttackDistance = 70,
		Damage = Vector(30,40),
		DamageProp = Vector(5,20),
		KickScale = 2,
		IdleScale = 0.25,
		PunchAngle = Angle(15,2,0),
		InertiaScale = 2,
		SwingSounds = WMLib.SoundsSwing["Heavy"],
		BlockPos = Vector(0,0,5),
		BlockRot = Angle(0,0,30),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(-45,0,-10),
		BlockHold = "knife",
		BlockWait = 0.5,
		BlockPower = 0.166,
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,2)
			if rand == 1 then
				curinfo.AnimationHit = {"Attack_Quick"}
				curinfo.AnimationHitEnd = ""
				curinfo.Rays = {{Angle(-10,-50,0),0},{Angle(0,0,0),0.01},{Angle(10,50,0),0.01}}
				curinfo.OnlyOneRay = true
				curinfo.PunchAngle = Angle(2,5,0)
				curinfo.AttackWait = Vector(1,0,25)
				curinfo.Heavy = false
			else
				curinfo.AnimationHit = {"Attack_Charge_Begin"}
				curinfo.AnimationHitEnd = "Attack_Charge_End"
				curinfo.Rays = {{Angle(-50,-30,0),0},{Angle(0,0,0),0.03},{Angle(50,30,0),0.03}}
				curinfo.OnlyOneRay = false
				curinfo.PunchAngle = Angle(15,2,0)
				curinfo.AttackWait = Vector(1,-25,25)
				curinfo.Heavy = true
			end

			return curinfo
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end