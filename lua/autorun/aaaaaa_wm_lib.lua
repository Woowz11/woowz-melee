AddCSLuaFile()

local GetConVar, Color, util, math, hook, CLIENT, SERVER, table, IsValid, pairs, ragmod, timerSimple, hookAdd, debugoverlay, ColorAlpha, hookRun = GetConVar, Color, util, math, hook, CLIENT, SERVER, table, IsValid, pairs, ragmod, timer.Simple, hook.Add, debugoverlay, ColorAlpha, hook.Run

function p(text)
	if SERVER then print(text) end
end

function e(text)
	if SERVER then
		print("[WM ERROR] "..text)
	end
end

function PlaceDecal(material, entity, hit, normal, color, x,y)
	if SERVER then
		if material == nil then
			material = "decals/cross_model"
		end
		if entity == nil then
			entity = Entity(0)
		end
		if hit == nil then
			hit = Vector(0,0,0)
		end
		if normal == nil then
			normal = Vector(0,0,0)
		end
		if color == nil then
			color = Color(255,255,255)
		end
		if x == nil then
			x = 1
		end
		if y == nil then
			y = 1
		end
		local info = {
			material,entity,hit,normal,color,x,y
		}
		net.Start("wm_PlaceDecal")
		net.WriteTable(info)
		net.Send(player.GetAll())
	end
end

hookAdd("PlayerSpawnedSENT","wm_createent",function(ply,ent)
	if (ent:GetClass() == "wm_random_weapon") then
		local pos = ent:GetPos()
		local class = WMLib.GetRandomWeapon()
		if class ~= nil then
			local weapon = ents.Create(class)
			weapon:Spawn()
			weapon:SetPos(pos+Vector(0,0,30))
			weapon:SetAngles(Angle(math.random(-180,180),math.random(-180,180),math.random(-180,180)))
			undo.Create("weapon")
				undo.AddEntity(weapon)
				undo.SetPlayer(ply)
			undo.Finish()
		end
        ent:Remove()
	end
end)

WMLib = {}

local version = "0.0.4 Alpha"
local wiki = "https://woowz11.github.io/woowzsite/woowzmelee_wiki.html"

WMLib.Mods = {}
WMLib.CreateMod = function(modid, info)
	if type(modid) == "string" then
		if WMLib.Mods[modid] == nil then
			if type(info) == "table" then
				if info["Name"] == nil then
					e("There is not enough information (Name) in the modification! E8")
				else
					WMLib.Mods[modid] = info
					p("Modification ["..modid.."] created!")
				end
			else
				e("Mod information is not table! E7")
			end
		else
			e("This modification ["..modid.."] already exists! E4")
		end
	else
		e("Modification id ["..tostring(modid).."] (type:"..type(modid)..") is not a string! E5")
	end
end
WMLib.CreateMod("vanilla",{Name = "Vanilla",Author = "Woowz11"})

local shocksounds = {"ambient/energy/zap1.wav","ambient/energy/zap2.wav","ambient/energy/zap3.wav","ambient/energy/zap5.wav","ambient/energy/zap6.wav","ambient/energy/zap7.wav","ambient/energy/zap8.wav","ambient/energy/zap9.wav","ambient/energy/weld1.wav","ambient/energy/weld2.wav","ambient/energy/spark1.wav","ambient/energy/spark2.wav","ambient/energy/spark3.wav","ambient/energy/spark4.wav","ambient/energy/spark5.wav","ambient/energy/spark6.wav","weapons/stunstick/spark1.wav","weapons/stunstick/spark2.wav","weapons/stunstick/spark3.wav"}
WMLib.ShockEntity = function(entity,power)
	if IsValid(entity) then
		power = math.max(0,power)
		if power > 0 then
			local mat = entity:GetMaterialType()
			local electrmat = mat == MAT_ANTLION or mat == MAT_BLOODYFLESH or mat == MAT_FLESH or mat == MAT_GRATE or mat == MAT_ALIENFLESH or mat == MAT_CLIP or mat == MAT_METAL or mat == MAT_COMPUTER or mat == MAT_VENT		
			if entity:IsNPC() or entity:IsPlayer() then
				electrmat = true
			end
			if electrmat then
				if entity:IsPlayer() then
					if ragmod then
						ragmod:TryToRagdoll(entity)
						entity = ragmod:GetRagmodRagdoll(entity)
					end
				end
				
				for i = 1, power do
					timer.Simple(i/5,function()
						if IsValid(entity) then
							for i = 1, entity:GetPhysicsObjectCount() - 1 do
								local phys = entity:GetPhysicsObjectNum(i)

								if phys:IsValid() and entity:GetClass() == "prop_ragdoll" then
									phys:AddVelocity(VectorRand() * (power * 20))
								end
							end
							entity:EmitSound(shocksounds[math.random(1,#shocksounds)],80,math.random(80,120))
							local effect = EffectData()
							effect:SetOrigin(entity:GetPos())
							effect:SetEntity(entity)
							effect:SetScale(10)
							effect:SetMagnitude(10)
							effect:SetRadius(3)
							util.Effect("TeslaHitBoxes", effect)
						end
					end)
				end
			end
		end
	end
end

WMLib.PlaceDecal = function(material,entity,pos,normal,color,size)
	if size == nil then
		size = Vector(1,1)
	end
	PlaceDecal(material,entity,pos,normal,color,size.x,size.y)
end

WMLib.DeltaTime = function() return dt()end

WMLib.ThatWMWeapon = function(ent)
	if ent.WoowzMelee then
		if ent.WoowzMelee == true then
			return true
		end
	end
	return false
end

WMLib.GetInfo = function(w)
	if WMLib.ThatWMWeapon(w) then
		return w.WMInfo
	else
		e("The weapon ("..w:GetClass()..") is not a Woowz Melee weapon, it is impossible to get Info of this weapon! E9")
		return nil
	end
end

WMLib.Version = version
WMLib.Wiki = wiki