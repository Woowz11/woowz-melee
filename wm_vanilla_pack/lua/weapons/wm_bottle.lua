AddCSLuaFile()
if WMLib then
	function brokebottle(owner,glassparticlepos,normal)
		for _ = 0, 10 do
			local effectInfo = EffectData()
			effectInfo:SetOrigin(glassparticlepos+Vector(math.random()-0.5,math.random()-0.5,math.random()-0.5))
			effectInfo:SetFlags(0)
			effectInfo:SetScale(1)
			effectInfo:SetNormal(normal)
			util.Effect( "GlassImpact", effectInfo )
		end
		owner:EmitSound( "physics/glass/glass_impact_bullet1.wav",75,100)
		if owner:IsPlayer() then
			owner:StripWeapon("wm_bottle")
		else
			SafeRemoveEntity(owner:GetActiveWeapon())
		end
		
		if math.random()>0.3 or owner:IsNPC() then
			if owner:IsPlayer() then
				if owner:HasWeapon("wm_bottle_broken") then
					if owner:IsPlayer() then
						owner:StripWeapon("wm_bottle_broken")
					else
						SafeRemoveEntity(owner:GetActiveWeapon())
					end
				end
			end
			owner:Give("wm_bottle_broken")
			owner:SelectWeapon("wm_bottle_broken")
		else
			owner:TakeDamage(math.random(10,30),owner,owner)
			local effectInfo = EffectData()
			effectInfo:SetOrigin(glassparticlepos)
			effectInfo:SetScale(3)
			util.Effect( "BloodImpact", effectInfo )
			owner:SwitchToDefaultWeapon()
		end
	end
	
	local Info = {
		Name = "#wm.weapon.bottle",
		Icon = "icons/wm_bottle.png",
		SelectionIcon = "icons/wm_bottle_i.png",
		KillIcon = "icons/wm_bottle_k.png",
		Material = MAT_GLASS,
		VModel = "models/wm/combat_knife/v.mdl",
		VModelPos = Vector(1,2,-1),
		VModelRot = Angle(0,-5,-10),
		VModelBones = {["tag_weapon"] = {Vector(0,0,0),Angle(0,0,0),Vector(0,0,0),false}},
		VModelElements = {{"models/wm/bottle/w.mdl","ValveBiped.Bip01_R_Hand",Vector(2.75,-1.4,0),Angle(0,0,180),Vector(0.5,0.8,0.5)}},
		FOV = 75,
		WModel = "models/wm/bottle/w.mdl",
		Hold = "melee",
		Rays = {{Angle(-15,-20,0),0},{Angle(0,0,0),0.02},{Angle(15,20,0),0.02}},
		RaysDetails = 3,
		OnlyOneRay = true,
		WModelPos = Vector(2.5, -0.75, 0.5),
		WModelRot = Angle(200, 160, 0),
		WModelSize = Vector(0.5,0.8,0.5),
		AnimationHit = {"H1_Wpn_Melee_Bayonet_Knife_Swipe"},
		AnimationIdle = "H1_Wpn_Melee_Bayonet_Knife_Idle",
		AnimationDraw = "H1_Wpn_Melee_Bayonet_Knife_Pullout",
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0,
		AttackDistance = 55,
		Damage = Vector(5,15),
		DamageProp = Vector(0,5),
		PunchAngle = Angle(1,5,0),
		InertiaScale = 0.25,
		SwingSounds = WMLib.SoundsSwing["Light"],
		BlockPos = Vector(0,4,3),
		BlockRot = Angle(0,0,-30),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(0,0,0),
		BlockHold = "fist",
		BlockWait = 1.5,
		BlockPower = 0.5,
		DontDecals = true,
		WaterSplashSize = 2.5,
		HitSounds = {"physics/glass/glass_bottle_impact_hard1.wav","physics/glass/glass_bottle_impact_hard2.wav","physics/glass/glass_bottle_impact_hard3.wav"},
		HitAfterFunction = function(rayresult,owner,dont)
			if rayresult.Hit and not dont and math.random()>0.4 then
				brokebottle(owner,rayresult.HitPos,rayresult.Normal)
			end
		end,
		BlockHitFunction = function(owner,attacker,damage,fulldamage)
			if IsValid(owner) then
				if IsValid(owner:GetActiveWeapon()) then
					local pos = owner:GetActiveWeapon():GetPos()
					pos:Add(Vector(0,0,50))
					brokebottle(owner,pos,Vector((math.random()-0.5)*2,(math.random()-0.5)*2,(math.random()-0.5)*2))
				end
			end
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end