AddCSLuaFile()
if WMLib then
	local attack2 = false
	local Info = {
		Name = "#wm.weapon.ice_axe",
		Icon = "icons/wm_ice_axe.png",
		SelectionIcon = "icons/wm_ice_axe_i.png",
		KillIcon = "icons/wm_ice_axe_k.png",
		Material = MAT_METAL,
		Sharp = true,
		VModel = "models/wm/ice_axe/v.mdl",
		VModelPos = Vector(0,2,-3),
		VModelRot = Angle(0,-5,5),
		FOV = 90,
		WModel = "models/wm/ice_axe/w.mdl",
		Hold = "melee",
		Rays = {{Angle(-15,-10,0),0},{Angle(0,0,0),0.01},{Angle(15,10,0),0.01}},
		RaysDetails = 4,
		OnlyOneRay = true,
		WModelPos = Vector(2.75, -1.2, 0),
		WModelRot = Angle(180, 160, 0),
		AnimationHit = {"H1_Wpn_Melee_Ice_Pick_Putaway"},
		AnimationHitEnd = "H1_Wpn_Melee_Ice_Pick_Swipe",
		AnimationHitEndScale = 0.75,
		AnimationDraw = "H1_Wpn_Melee_Ice_Pick_Pullout_First",
		AnimationInspect = {"H1_Wpn_Melee_Ice_Pick_Inspect"},
		AttackWait = Vector(1,-50,0),
		AttackHitWait = 0.2,
		AttackDistance = 70,
		Damage = Vector(10,30),
		DamageProp = Vector(0,10),
		PunchAngle = Angle(0,5,0),
		SwingWait = 0.3,
		BlockPos = Vector(0,7,-3),
		BlockRot = Angle(0,0,-40),
		WBlockPos = Vector(0,0,0),
		WBlockRot = Angle(0,0,-20),
		BlockHold = "knife",
		BlockWait = 1,
		BlockPower = 0.5,
		SwingSounds = WMLib.SoundsSwing["LightSharp"],
		PreAttackFunctionInfo = function(curinfo)
			local rand = math.random(1,2)
			if rand == 1 then
				curinfo.AnimationHit = {"H1_Wpn_Melee_Ice_Pick_Putaway"}
				curinfo.AnimationHitEnd = "H1_Wpn_Melee_Ice_Pick_Swipe"
				curinfo.PunchAngle = Angle(0,5,0)
				curinfo.Rays = {{Angle(-15,-10,0),0},{Angle(0,0,0),0.01},{Angle(15,10,0),0.01}}
				curinfo.AttackDistance = 70
				curinfo.SwingWait = 0
				curinfo.Sharp = true
				attack2 = false
			else
				curinfo.AnimationHit = {"H1_Wpn_Melee_Ice_Pick_Stab"}
				curinfo.AnimationHitEnd = ""
				curinfo.PunchAngle = Angle(10,0,0)
				curinfo.Rays = {{Angle(-10,0,0),0},{Angle(0,0,0),0.01},{Angle(20,0,0),0.01}}
				curinfo.AttackDistance = 90
				curinfo.SwingWait = 0.2
				curinfo.Sharp = false
				attack2 = true
			end
			return curinfo
		end,
		HitAfterFunction = function(rayresult,owner,dont)
			if attack2 and rayresult.Hit and not dont then
				local ent = rayresult.Entity
				if rayresult.HitWorld then
					owner:SetLocalVelocity(owner:GetAimVector() * 500)
				else
					if IsValid(ent) and IsValid(owner) then
						if ent:IsPlayer() or ent:IsNPC() and ent:Health()>0 then
							rayresult.Entity:SetLocalVelocity(owner:GetAimVector() * -500)
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