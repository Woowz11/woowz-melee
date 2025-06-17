AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.police_baton",
		Icon = "icons/wm_police_baton.png",
		SelectionIcon = "icons/wm_police_baton_i.png",
		KillIcon = "icons/wm_police_baton_k.png",
		Material = MAT_PLASTIC,
		VModel = "models/wm/police_baton/v.mdl",
		VModelPos = Vector(-1,0,-3),
		VModelRot = Angle(0,-5,10),
		FOV = 100,
		WModel = "models/wm/police_baton/w.mdl",
		Hold = "melee",
		Rays = {{Angle(0,-30,0),0},{Angle(10,0,0),0.03},{Angle(20,30,0),0.03}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(3.2, -1.5, 3.8),
		WModelRot = Angle(180, -20, 0),
		AnimationHit = {"Fire1"},
		AnimationDraw = "Draw",
		AnimationInspect = {"Inspect_Axe","Inspect_Sword","Inspect_Voodoo","Inspect_Voodoo_Secret"},
		AttackWait = Vector(1,-25,0),
		AttackHitWait = 0.2,
		AttackDistance = 70,
		Damage = Vector(10,20),
		DamageProp = Vector(0,15),
		PunchAngle = Angle(10,2,0),
		BlockPos = Vector(0,5,0),
		BlockRot = Angle(0,0,-40),
		WBlockPos = Vector(0,1,0),
		WBlockRot = Angle(0,0,10),
		BlockHold = "melee2",
		BlockWait = 1,
		SwingSounds = WMLib.SoundsSwing["Light"],
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,2)
			if rand == 1 then
				curinfo.AnimationHit = {"Fire1"}
				curinfo.PunchAngle = Angle(0,-5,0)
				curinfo.Rays = {{Angle(0,-30,0),0},{Angle(10,0,0),0.03},{Angle(20,30,0),0.03}}
				curinfo.AttackHitWait = 0.2
				curinfo.AttackDistance = 70
			else
				curinfo.AnimationHit = {"Fire2"}
				curinfo.PunchAngle = Angle(-5,0,0)
				curinfo.Rays = {{Angle(0,0,0),0},{Angle(-5,-5,0),0},{Angle(0,0,0),0},{Angle(5,5,0),0},{Angle(0,0,0),0},{Angle(5,-5,0),0},{Angle(0,0,0),0},{Angle(-5,5,0),0}}
				curinfo.AttackHitWait = 0.4
				curinfo.AttackDistance = 80
			end

			return curinfo
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end