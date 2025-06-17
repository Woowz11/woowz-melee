AddCSLuaFile()
if WMLib then
	function createparticles(pos,normal,count)
		WMLib.CreateParticle({
			["Position"] = pos+normal*-2,
			["Texture"] = {"effects/wm/keyboard_key","effects/wm/keyboard_key2"},
			["UseLight"] = true,
			["Lifetime"] = 100,
			["StartSize"] = 8,
			["EndSize"] = 8,
			["Count"] = count,
			["Random"] = 50,
			["Velocity"] = normal*-100,
			["Gravity"] = Vector(0,0,-200),
			["Collide"] = true,
			["Bounce"] = 0.25,
		})
	end
	local Info = {
		Name = "#wm.weapon.keyboard",
		Icon = "icons/wm_keyboard.png",
		SelectionIcon = "icons/wm_keyboard_i.png",
		KillIcon = "icons/wm_keyboard_k.png",
		Material = MAT_PLASTIC,
		VModel = "models/wm/crowbar/v.mdl",
		VModelPos = Vector(3.5,-2.5,1),
		VModelRot = Angle(5,-5,-1.5),
		VModelBones = {
			["v_me_crowbar"] = {Vector(0,0,0),Angle(0,0,0),Vector(0,0,0),false},
			["Middle06"] = {Vector(0,0,0),Angle(70,0,0),Vector(1,1,1),false},
			["Index06"] = {Vector(0,0,0),Angle(70,0,0),Vector(1,1,1),false},
			["Ring06"] = {Vector(0,0,0),Angle(70,0,0),Vector(1,1,1),false}
		},
		VModelElements = {{"models/wm/keyboard/w.mdl","ValveBiped.Bip01_R_Hand",Vector(6,-2.3,-6),Angle(90,-120,0),Vector(1,1,1)}},
		FOV = 50,
		Funny = true,
		WModel = "models/wm/keyboard/w.mdl",
		Hold = "melee",
		Rays = {{Angle(-10,25,0),0},{Angle(0,0,0),0.025},{Angle(10,-25,0),0.025}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(6.25,-2.75,-3),
		WModelRot = Angle(90, 0, 120),
		AnimationHit = {"Attack_Quick"},
		AnimationDraw = "Draw",
		AnimationIdle = "Idle",
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.3,
		Damage = Vector(5,20),
		DamageProp = Vector(0,5),
		PunchAngle = Angle(0,-5,0),
		InertiaScale = 0.5,
		AttackDistance = 65,
		BlockPos = Vector(0,10,0),
		BlockRot = Angle(0,0,-30),
		WBlockPos = Vector(1.25,-2,1),
		WBlockRot = Angle(90,-90,0),
		BlockHold = "camera",
		BobbingScale = 0.5,
		BlockPower = 0.75,
		HitAfterFunction = function(rayresult,owner,dont)
			if rayresult.Hit and not dont then
				createparticles(rayresult.HitPos,rayresult.Normal,math.random(0,5))
			end
		end,
		BlockHitFunction = function(owner,attacker,damage,fulldamage)
			if IsValid(owner) then
				if IsValid(owner:GetActiveWeapon()) then
					local pos = owner:GetActiveWeapon():GetPos()
					pos:Add(Vector(0,0,50))
					createparticles(pos,Vector((math.random()-0.5)*10,(math.random()-0.5)*10,(math.random()-0.5)*10),math.random(0,math.floor(fulldamage/2)))
				end
			end
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end