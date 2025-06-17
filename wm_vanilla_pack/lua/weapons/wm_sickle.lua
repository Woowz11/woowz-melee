AddCSLuaFile()
if WMLib then
	local attack2 = false
	local Info = {
		Name = "#wm.weapon.sickle",
		Icon = "icons/wm_sickle.png",
		SelectionIcon = "icons/wm_sickle_i.png",
		KillIcon = "icons/wm_sickle_k.png",
		Material = MAT_METAL,
		Sharp = true,
		VModel = "models/wm/sickle/v.mdl",
		VModelPos = Vector(-4,1,0),
		VModelRot = Angle(0,-5,0),
		FOV = 100,
		WModel = "models/wm/sickle/w.mdl",
		Hold = "melee",
		Rays = {{Angle(-10,-5,0),0},{Angle(10,0,0),0.001},{Angle(30,5,0),0.001}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(2.5, -1, 0.5),
		WModelRot = Angle(180, 100, 30),
		AnimationHit = {"H1_Wpn_Melee_Sickle_Swipe"},
		AnimationDraw = "H1_Wpn_Melee_Sickle_Pullout_First",
		AnimationIdle = "H1_Wpn_Melee_Sickle_Idle",
		AnimationInspect = {"H1_Wpn_Melee_Sickle_Inspect"},
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.2,
		AttackDistance = 50,
		Damage = Vector(10,30),
		DamageProp = Vector(0,15),
		PunchAngle = Angle(5,1,0),
		BlockPos = Vector(0,3,-8),
		BlockRot = Angle(0,0,-60),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(90,0,40),
		BlockHold = "camera",
		BlockWait = 1,
		BlockPower = 0.5,
		SwingSounds = WMLib.SoundsSwing["LightSharp"],
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,2)
			if rand == 1 then
				curinfo.AnimationHit = {"H1_Wpn_Melee_Sickle_Swipe"}
				curinfo.PunchAngle = Angle(5,1,0)
				curinfo.Rays = {{Angle(-10,-5,0),0},{Angle(10,0,0),0.001},{Angle(30,5,0),0.001}}
				curinfo.AttackDistance = 50
				curinfo.SwingWait = 0
				curinfo.Sharp = true
				attack2 = false
			else
				curinfo.AnimationHit = {"H1_Wpn_Melee_Sickle_Stab"}
				curinfo.PunchAngle = Angle(20,0,0)
				curinfo.Rays = {{Angle(-10,0,0),0},{Angle(10,0,0),0.01},{Angle(30,0,0),0.01}}
				curinfo.AttackDistance = 80
				curinfo.SwingWait = 0.1
				curinfo.Sharp = false
				attack2 = true
			end
			return curinfo
		end,
		HitAfterFunction = function(rayresult,owner,dont)
			if attack2 and rayresult.Hit and not dont then
				local ent = rayresult.Entity
				if rayresult.HitWorld then
					owner:SetLocalVelocity(owner:GetAimVector() * 250)
				else
					if IsValid(ent) and IsValid(owner) then
						if ent:IsPlayer() or ent:IsNPC() and ent:Health()>0 then
							rayresult.Entity:SetLocalVelocity(owner:GetAimVector() * -250)
						else
							if IsValid(ent:GetPhysicsObject()) then
								ent:GetPhysicsObject():ApplyForceOffset( owner:GetAimVector() * -5000 , rayresult.HitPos )
							end
						end
					end
				end
			end
		end,
	}
	WMLib.CreateMelee(SWEP,Info,"vanilla")
end