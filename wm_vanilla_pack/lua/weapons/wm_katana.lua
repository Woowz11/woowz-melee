AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.katana",
		CustomAuthor = "Haveaniceday.",
		Icon = "icons/wm_katana.png",
		SelectionIcon = "icons/wm_katana_i.png",
		KillIcon = "icons/wm_katana_k.png",
		Material = MAT_METAL,
		Sharp = true,
		VModel = "models/wm/katana/v.mdl",
		VModelPos = Vector(4, -0.5, -0.4),
		VModelRot = Angle(5,-5,-1.5),
		FOV = 50,
		WModel = "models/wm/katana/w.mdl",
		Hold = "melee2",
		Rays = {{Angle(0,-50,0),0},{Angle(0,-25,0),0.015},{Angle(0,0,0),0.015},{Angle(0,25,0),0.015},{Angle(0,50,0),0.015}},
		RaysDetails = 5,
		WModelPos = Vector(4, -2, -16),
		WModelRot = Angle(0, 60, -90),
		AnimationHit = {"Swing_L"},
		AnimationDraw = "Deploy",
		AnimationIdle = "Idle",
		AttackWait = Vector(1,-30,0),
		AttackHitWait = 0.3,
		Damage = Vector(15,30),
		DamageProp = Vector(5,15),
		PunchAngle = Angle(0,10,0),
		AttackDistance = 80,
		DrawSound = {"weapons/l4d2_kf2_katana/knife_deploy.wav",0.9},
		SwingSounds = {"weapons/l4d2_kf2_katana/katana_swing_miss1.wav","weapons/l4d2_kf2_katana/katana_swing_miss2.wav"},
		BlockPos = Vector(0,0,-7),
		BlockRot = Angle(0,0,-80),
		WBlockPos = Vector(0,-7,0),
		WBlockRot = Angle(30,30,0),
		BlockHold = "knife",
		BlockWait = 0.5,
		BlockPower = 0.166,
		SwayScale = 0.5,
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,4)
			if rand == 1 then
				curinfo.AnimationHit = {"Swing_L"}
				curinfo.Rays = {{Angle(0,-50,0),0},{Angle(0,-25,0),0.015},{Angle(0,0,0),0.015},{Angle(0,25,0),0.015},{Angle(0,50,0),0.015}}
				curinfo.AttackHitWait = 0.3
				curinfo.PunchAngle = Angle(0,10,0)
			elseif rand == 2 then
				curinfo.AnimationHit = {"Swing_R2"}
				curinfo.Rays = {{Angle(0,50,0),0},{Angle(0,25,0),0.015},{Angle(0,0,0),0.015},{Angle(0,-25,0),0.015},{Angle(0,-50,0),0.015}}
				curinfo.AttackHitWait = 0.3
				curinfo.PunchAngle = Angle(0,-10,0)
			elseif rand == 3 then
				curinfo.AnimationHit = {"Swing_L2"}
				curinfo.Rays = {{Angle(0,-50,0),0},{Angle(0,-25,0),0.015},{Angle(0,0,0),0.015},{Angle(0,25,0),0.015},{Angle(0,50,0),0.015}}
				curinfo.AttackHitWait = 0.4
				curinfo.PunchAngle = Angle(0,15,0)
			else
				curinfo.AnimationHit = {"Swing_R"}
				curinfo.Rays = {{Angle(0,50,0),0},{Angle(0,25,0),0.015},{Angle(0,0,0),0.015},{Angle(0,-25,0),0.015},{Angle(0,-50,0),0.015}}
				curinfo.AttackHitWait = 0.4
				curinfo.PunchAngle = Angle(0,-15,0)
			end

			return curinfo
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end