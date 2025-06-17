AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.rpg_missile",
		Funny = true,
		Icon = "icons/wm_missile.png",
		SelectionIcon = "icons/wm_missile_i.png",
		KillIcon = "icons/wm_missile_k.png",
		Material = MAT_METAL,
		VModel = "models/wm/missile/v.mdl",
		VModelPos = Vector(-1,0,4),
		VModelRot = Angle(10,-5,10),
		FOV = 80,
		WModel = "models/wm/missile/w.mdl",
		Hold = "melee",
		Rays = {{Angle(0,-20,0),0},{Angle(0,0,0),0.01},{Angle(0,20,0),0.01}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(3.2, -1.5, 2),
		WModelRot = Angle(180, 120, 0),
		AnimationHit = {"H1_Wpn_Melee_Rpgdud_Swipe"},
		AnimationDraw = "H1_Wpn_Melee_Rpgdud_Pullout",
		AnimationInspect = {"H1_Wpn_Melee_Rpgdud_Inspect","H1_Wpn_Melee_Rpgdud_Pullout_First","H1_Wpn_Melee_Rpgdud_Pullout_First"},
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.1,
		AttackDistance = 70,
		SwayScale = 1,
		Damage = Vector(10,20),
		DamageProp = Vector(0,10),
		PunchAngle = Angle(0,5,0),
		BlockPos = Vector(0,10,-3),
		BlockRot = Angle(0,0,-30),
		WBlockPos = Vector(0,0.5,0),
		WBlockRot = Angle(20,0,0),
		BlockHold = "knife",
		BlockWait = 1.25,
		SwingSounds = WMLib.SoundsSwing["Light"],
		HitAfterFunction = function(rayresult,owner,dont)
			if rayresult.Hit and not dont and math.random()>0.9 then
				if owner:IsPlayer() then
					owner:StripWeapon("wm_missile")
				else
					SafeRemoveEntity(owner:GetActiveWeapon())
				end
				WMLib.PlaceDecal("decals/burn01a",rayresult.Entity,rayresult.HitPos,rayresult.HitNormal)
				local explode = ents.Create( "env_explosion" )
				explode:SetPos( rayresult.HitPos )
				explode:SetOwner( owner )
				explode:Spawn()
				explode:SetKeyValue( "iMagnitude", "150" )
				explode:Fire( "Explode", 0, 0 )
				explode:EmitSound( "weapon_AWP.Single", 400, 400 )
			end
		end,
		BlockHitFunction = function(owner,attacker,damage)
			if math.random()>0.5 or damage > 30 then
				if owner:IsPlayer() then
					owner:StripWeapon("wm_missile")
				else
					SafeRemoveEntity(owner:GetActiveWeapon())
				end
				local explode = ents.Create( "env_explosion" )
				explode:SetPos( owner:GetPos() )
				explode:SetOwner( owner )
				explode:Spawn()
				explode:SetKeyValue( "iMagnitude", "150" )
				explode:Fire( "Explode", 0, 0 )
				explode:EmitSound( "weapon_AWP.Single", 400, 400 )
			end
		end,
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end