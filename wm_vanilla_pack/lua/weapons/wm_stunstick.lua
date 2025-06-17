AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.stunstick",
		Icon = "icons/wm_stunstick.png",
		SelectionIcon = "icons/wm_stunstick_i.png",
		KillIcon = "icons/wm_stunstick_k.png",
		Material = MAT_METAL,
		VModel = "models/wm/stunstick/v.mdl",
		VModelPos = Vector(3.5,2,-0.5),
		VModelRot = Angle(5,-5,-3),
		FOV = 60,
		WModel = "models/wm/stunstick/w.mdl",
		Hold = "melee",
		Rays = {{Angle(-10,-20,0),0},{Angle(0,0,0),0.025},{Angle(10,20,0),0.025}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(5.2, -1.7, -6),
		WModelRot = Angle(-100, -20, 0),
		AnimationHit = {"Misscenter1"},
		AnimationDraw = "Draw",
		AnimationIdle = "Idletolow",
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.2,
		Damage = Vector(10,20),
		DamageProp = Vector(0,10),
		PunchAngle = Angle(5,5,0),
		HitSounds = {"weapons/stunstick/stunstick_fleshhit1.wav","weapons/stunstick/stunstick_fleshhit2.wav","weapons/stunstick/stunstick_impact1.wav","weapons/stunstick/stunstick_impact2.wav"},
		SwingSounds = {"weapons/stunstick/stunstick_swing1.wav","weapons/stunstick/stunstick_swing2.wav"},
		AttackDistance = 60,
		BlockPos = Vector(-3,5,-5),
		BlockRot = Angle(0,0,-40),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(0,0,0),
		BlockHold = "knife",
		BlockWait = 1,
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,3)
			if rand == 1 then
				curinfo.AnimationHit = {"Misscenter1"}
				curinfo.PunchAngle = Angle(5,5,0)
				curinfo.Rays = {{Angle(-10,-20,0),0},{Angle(0,0,0),0.025},{Angle(10,20,0),0.025}}
			elseif rand == 2 then
				curinfo.AnimationHit = {"Misscenter2"}
				curinfo.PunchAngle = Angle(5,-5,0)
				curinfo.Rays = {{Angle(-10,20,0),0},{Angle(0,0,0),0.025},{Angle(10,-20,0),0.025}}
			else
				curinfo.AnimationHit = {"Misscenter3"}
				curinfo.PunchAngle = Angle(5,0,0)
				curinfo.Rays = {{Angle(-20,0,0),0},{Angle(0,0,0),0.025},{Angle(20,0,0),0.025}}
			end

			return curinfo
		end,
		HitAfterFunction = function(rayresult,owner,dont)
			if not dont and rayresult.Hit and math.random()>0.1 then
				local effectInfo = EffectData()
				effectInfo:SetOrigin(rayresult.HitPos)
				effectInfo:SetEntity(rayresult.Entity)
				effectInfo:SetScale(1)
				effectInfo:SetMagnitude(3)
				util.Effect( "ElectricSpark", effectInfo )
				WMLib.ShockEntity(rayresult.Entity,10)
			end
		end,
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end