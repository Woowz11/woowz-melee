AddCSLuaFile()
if WMLib then
	local Info = {
		Name = "#wm.weapon.fists",
		Icon = "icons/wm_fists.png",
		SelectionIcon = "icons/wm_fists_i.png",
		KillIcon = "icons/wm_fists_k.png",
		Material = MAT_FLESH,
		VModel = "models/wm/fists/v.mdl",
		VModelPos = Vector(-6,-1,1),
		VModelRot = Angle(0,0,0),
		FOV = 70,
		Rays = {{Angle(0,0,0),0},{Angle(-5,-5,0),0},{Angle(0,0,0),0},{Angle(5,5,0),0},{Angle(0,0,0),0},{Angle(5,-5,0),0},{Angle(0,0,0),0},{Angle(-5,5,0),0}},
		RaysDetails = 2,
		OnlyOneRay = true,
		WModel = "models/props_junk/cardboard_box004a.mdl",
		WModelVisible = false,
		Hold = "fist",
		AnimationHit = {"Attack_Quick","Attack_Quick2"},
		AnimationDraw = "Draw",
		AnimationIdle = "Idle",
		AttackWait = Vector(0.5,-25,0),
		AttackHitWait = 0.3,
		Damage = Vector(10,20),
		DamageProp = Vector(0,1),
		KickScale = 1.5,
		AttackDistance = 50,
		IdleScale = 0.25,
		SwayScale = 1,
		DontDecals = true,
		SwingSounds = "empty",
		PunchAngle = Angle(1,0,0),
		InertiaScale = 0,
		BlockPos = Vector(5,0,-20),
		BlockRot = Angle(-80,0,0),
		BlockHold = "camera",
		BlockWait = 1.25,
		BlockPower = 0.5,
		WaterSplashSize = 2.5,
		HitFunction = function(rayresult,owner,dont)
			if not dont and rayresult.Hit then
				local bloodhit = false
				if rayresult.Entity == Entity(0) and not (rayresult.MatType == MAT_SAND or rayresult.MatType == MAT_GRASS or rayresult.MatType == MAT_FOLIAGE or rayresult.MatType == MAT_SNOW or rayresult.MatType == MAT_SLOSH) then
					bloodhit = true
				end
				if not (rayresult.Entity:IsNPC() or rayresult.Entity:IsPlayer()) then
					if rayresult.MatType ~= MAT_SAND and rayresult.MatType ~= MAT_GRASS and rayresult.MatType ~= MAT_FOLIAGE and rayresult.MatType ~= MAT_PLASTIC and rayresult.MatType ~= MAT_SNOW and rayresult.MatType ~= MAT_FLESH and rayresult.MatType ~= MAT_GRATE and rayresult.MatType ~= MAT_EGGSHELL and rayresult.MatType ~= MAT_BLOODYFLESH and rayresult.MatType ~= MAT_SLOSH and rayresult.MatType ~= MAT_ALIENFLESH then
						bloodhit = true
					end
				end
				if bloodhit then
					if math.random()>0.5 then
						local decals = {"decals/flesh/blood1","decals/flesh/blood2","decals/flesh/blood3","decals/flesh/blood4","decals/flesh/blood5"}
						WMLib.PlaceDecal(decals[math.random(1,#decals)],rayresult.Entity,rayresult.HitPos,rayresult.HitNormal,Color(math.random(230,255),math.random(230,255),math.random(230,255)),Vector(math.random(120,80)/100,math.random(120,80)/100))
						owner:TakeDamage(math.random(1,5),owner,owner)
					end
				end
				if rayresult.Entity then
					if rayresult.Entity:GetClass() == "npc_manhack" then
						owner:TakeDamage(math.random(20,40),rayresult.Entity,rayresult.Entity)
						local effectInfo = EffectData()
						effectInfo:SetOrigin(rayresult.HitPos)
						effectInfo:SetScale(3)
						util.Effect( "BloodImpact", effectInfo )
					end
				end
			end
		end
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end