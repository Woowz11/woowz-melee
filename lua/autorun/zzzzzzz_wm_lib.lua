AddCSLuaFile()

local GetConVar, Color, util, math, hook, CLIENT, SERVER, table, IsValid, pairs, ragmod, timerSimple, hookAdd, debugoverlay, ColorAlpha, hookRun = GetConVar, Color, util, math, hook, CLIENT, SERVER, table, IsValid, pairs, ragmod, timer.Simple, hook.Add, debugoverlay, ColorAlpha, hook.Run

local Convars = {
	["enabled"] = {1,"Load weapons? 0 - Disabled, 1 - Enabled"},
	["categorytop"] = {0,"Place category on top? 0 - Disabled, 1 - Enabled"},
	["onlyadmin"] = {0,"Only admin can spawn weapons? 0 - Disabled, 1 - Enabled"},
	["funny_weapons"] = {1,"Load funny weapons? 0 - Disabled, 1 - Enabled"},
	["extendeddesc"] = {0,"Enable extended weapons descriptions? 0 - Disabled, 1 - Enabled"},
	["takeweapons"] = {1,"Can pickup weapons? 0 - Disabled, 1 - Enabled"},
	["npccanuse"] = {1,"NPC can use weapons? 0 - Disabled, 1 - Enabled"},
	["npcweapons"] = {1,"Add weapons to NPC weapon selector? 0 - Disabled, 1 - Enabled"},
	
	["canblock"] = {1,"Block enabled? 0 - Disabled, 1 - Enabled"},
	["blockscale"] = {1,"Block power damage scale"},
	["legsblock"] = {0,"Block work for legs? 0 - Disabled, 1 - Enabled"},
	["distancescale"] = {1,"Weapon distance scale"},
	["attackwaitscale"] = {1,"Attack wait scale"},
	["kickscale"] = {1,"Kick power scale"},
	["inertiascale"] = {1,"Inertia scale"},
	["attackunderwater"] = {0,"Can attack underwater? 0 - Disabled, 1 - Enabled"},
	
	["damagescale"] = {1,"NPC damage scale"},
	["damagescale_player"] = {1,"Player damage scale"},
	["damagescale_prop"] = {1,"Other entity damage scale"},
	["damagescale_headshot"] = {4,"Headshot damage scale"},
	["ragdollize"] = {1,"Ragdoll when take damage? 0 - Disabled, 1 - Enabled"},
	["ragdollize_needdamage"] = {35,"How much damage would it take to ragdoll"},
	["interimhittomain"] = {0,"Makes intermediate hits to main hits? 0 - Disabled, 1 - Enabled"},
	
	["showhits"] = {0,"Show player & NPC hits? 0 - Disabled, 1 - Enabled"},
	
	["placedecals"] = {1,"Place decals? 0 - Disabled, 1 - Enabled"},
	["viewpunch"] = {1,"Enable view punch? 0 - Disabled, 1 - Enabled"},
	["viewpunchscale"] = {1,"View punch scale"},
	["camerashake"] = {1,"Enable camera shake? 0 - Disabled, 1 - Enabled"},
	["camerashakescale"] = {1,"Camera shake scale"},
	["fovscale"] = {1,"FOV scale"},
	["crosshair"] = {0,"Enable crosshair? 0 - Disabled, 1 - Enabled"},
	["customfunctions"] = {1,"Enable custom functions? 0 - Disabled, 1 - Enabled"},
	["hitsquality"] = {0,"Hits quality"},
	
	["funny_burn"] = {0,"Ignite hit objects? 0 - Disabled, 1 - Enabled"},
	["funny_shock"] = {0,"Shock hit objects? 0 - Disabled, 1 - Enabled"},
	["funny_randomnames"] = {0,"Makes random name's? 0 - Disabled, 1 - Enabled"},
	["funny_randomdecals"] = {0,"Random hit decals? 0 - Disabled, 1 - Enabled"},
	
	["debug_livetime"] = {10,"Debug overlay lifetime"},
	["debug_weapons"] = {0,"Load debug weapons? 0 - Disabled, 1 - Enabled"},
	["debug_showhit"] = {0,"Mark hit points? 0 - Disabled, 1 - Enabled"},
	["debug_showdamage"] = {0,"Mark damage? 0 - Disabled, 1 - Enabled"},
}

if not ConVarExists("wm_enabled") then
	for convar_id, convar_info in pairs(Convars) do
		CreateConVar("wm_"..convar_id, convar_info[1], { FCVAR_REPLICATED, FCVAR_ARCHIVE }, convar_info[2])
	end
end

if CLIENT then
	hookAdd("PopulateToolMenu", "CreateWoowzMeleeOptionsPanel", function()
		spawnmenu.AddToolMenuOption("Options", "Woowz11", "Woowz11WoowzMeleeConfig", "Woowz Melee", "", "", function(cpanel)
			local OptionsSelector = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "woowzmelee_config"}
		
			local OptionsDefault = {}
			for convar_id, convar_info in pairs(Convars) do
				table.insert(OptionsSelector["CVars"],"wm_"..convar_id)
				OptionsDefault["wm_"..convar_id] = ""..convar_info[1]
			end
			OptionsSelector.Options["#Default"] = OptionsDefault
			
			cpanel:AddControl("ComboBox", OptionsSelector)
			
			surface.CreateFont( "DermaLarge_WM", {
				font		= "Roboto",
				size		= 23,
				weight		= 500,
				extended	= true
			} )
		
			cpanel:Help("Mod version "..WMLib.Version)
			local urltext = vgui.Create("DLabelURL")
			urltext:SetColor( Color( 170, 170, 255 ) ) 
			urltext:SetText("Open Wiki") 
			urltext:SetURL(WMLib.Wiki)
			cpanel:AddItem(urltext)
			
			local warn = cpanel:Help("This base is in alpha version, for now it is better not to create modifications on it. Mod wiki is under development")
			warn:SetColor(Color(255,0,0))
			cpanel:Help("Mod Base"):SetFont("DermaLarge_WM")
			cpanel:CheckBox("Load weapons? (Need restart)", "wm_enabled")
			cpanel:CheckBox("Place categorys on top? (Need restart)", "wm_categorytop")
			cpanel:CheckBox("Only admin can spawn? (Need restart)", "wm_onlyadmin")
			cpanel:CheckBox("Load funny weapons? (Need restart)", "wm_funny_weapons")
			cpanel:CheckBox("Enable extended weapons descriptions? (Need restart)", "wm_extendeddesc")
			cpanel:CheckBox("Can pickup weapons?", "wm_takeweapons")
			cpanel:CheckBox("NPC can use weapons?", "wm_npccanuse")
			cpanel:CheckBox("Add weapons to NPC weapon selector? (Need restart)", "wm_npcweapons")
			cpanel:Help("Melee"):SetFont("DermaLarge_WM")
			cpanel:CheckBox("Enable block?", "wm_canblock")
			cpanel:NumSlider("Block power damage scale","wm_blockscale",0,1)
			cpanel:CheckBox("Block work for legs?", "wm_legsblock")
			cpanel:NumSlider("Weapon distance scale","wm_distancescale",0,10,1)
			cpanel:NumSlider("Attack wait scale","wm_attackwaitscale",0,10,1)
			cpanel:NumSlider("Kick scale","wm_kickscale",0,10,1)
			cpanel:NumSlider("Inertia scale","wm_inertiascale",0,10,1)
			cpanel:CheckBox("Can attack underwater?", "wm_attackunderwater")
			cpanel:Help("Damage"):SetFont("DermaLarge_WM")
			cpanel:NumSlider("NPC damage scale","wm_damagescale",0,10,1)
			cpanel:NumSlider("Player damage scale","wm_damagescale_player",0,10,1)
			cpanel:NumSlider("Other entity damage scale","wm_damagescale_prop",0,10,1)
			cpanel:NumSlider("Headshot damage scale","wm_damagescale_headshot",0,10,1)
			if ragmod then
				cpanel:CheckBox("Ragdollize then take damage?", "wm_ragdollize")
				cpanel:NumSlider("How much damage would it take to ragdoll","wm_ragdollize_needdamage",0,100,0)
			end
			cpanel:CheckBox("Makes intermediate hits to main hits?", "wm_interimhittomain")
			cpanel:Help("GUI"):SetFont("DermaLarge_WM")
			cpanel:CheckBox("Show player & NPC hits?", "wm_showhits")
			cpanel:Help("Other"):SetFont("DermaLarge_WM")
			cpanel:CheckBox("Place decals?", "wm_placedecals")
			cpanel:CheckBox("Enable view punch?", "wm_viewpunch")
			cpanel:NumSlider("View punch scale","wm_viewpunchscale",-5,5,1)
			cpanel:NumSlider("FOV scale", "wm_fovscale",0,5)
			cpanel:CheckBox("Enable camera shake?", "wm_camerashake")
			cpanel:NumSlider("Camera shake scale","wm_camerashakescale",0,10,1)
			cpanel:CheckBox("Enable crosshair?", "wm_crosshair")
			cpanel:CheckBox("Enable custom functions?", "wm_customfunctions")
			cpanel:ControlHelp("Disabling this variable can break some weapons")
			cpanel:NumSlider("Hits quality","wm_hitsquality",0,5,0)
			cpanel:ControlHelp("The higher the number, the more impact points (increases the chance of hitting thin objects)")
			cpanel:Help("Fun"):SetFont("DermaLarge_WM")
			cpanel:CheckBox("Ignite hit objects?", "wm_funny_burn")
			cpanel:CheckBox("Shock hit objects?", "wm_funny_shock")
			cpanel:CheckBox("Makes random names (Need restart)", "wm_funny_randomnames")
			cpanel:CheckBox("Random hit decals?", "wm_funny_randomdecals")
			cpanel:Help("Debug"):SetFont("DermaLarge_WM")
			cpanel:Help("To make debug work you need to enable: developer 1")
			cpanel:NumSlider("Debug overlay lifetime","wm_debug_livetime",0,30,1)
			cpanel:CheckBox("Load debug weapons? (Need restart)", "wm_debug_weapons")
			cpanel:CheckBox("Mark hit points?", "wm_debug_showhit")
			cpanel:CheckBox("Mark damage?", "wm_debug_showdamage")
		end)
	end)
end

function p(text)
	if SERVER then print(text) end
end

function e(text)
	if SERVER then
		print("[WM ERROR] "..text)
	end
end

p("_________________________________________________________________________________")
if GetConVar("wm_enabled"):GetBool() then p("WMLib loaded!") else p("WMLib disabled!") end
p("WMLib wiki - https://woowz11.github.io/woowzsite/woowzmelee_wiki.html")
p("")

local category_main = "Woowz Melee"
if GetConVar("wm_categorytop"):GetBool() then
	category_main = "!"..category_main
end

function Get(tab,key,ifnil)
	if tab[key] ~= nil then
		return tab[key]
	else
		return ifnil
	end
end

function IfNil(val,key,def)
	if val == nil then return def end
	if key == nil then
		return nil
	else
		if val[key] == nil then return def else return val[key] end
	end
end

function getRandomKeyFromTable(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys[math.random(1, #keys)]
end

function DrawSphere(pos,size,lifetime,color,typ)
	local notignore = hookRun("WM_DrawSphere",pos,size,lifetime,color,typ)
	if notignore == nil then notignore = {true,pos,size,lifetime,color,typ} end
	if IfNil(notignore,1,true) then
		net.Start("wm_ClientHitDebug")
		net.WriteTable({IfNil(notignore,2,pos),IfNil(notignore,3,size),IfNil(notignore,4,lifetime),IfNil(notignore,5,color),IfNil(notignore,6,typ)})
		net.Send(player.GetAll())
	end
end

local HitMaterialDecals = {
	[MAT_CONCRETE  ] = {"decals/wm/concrete/1","decals/wm/concrete/2","decals/wm/concrete/3","decals/wm/concrete/4"},
	[MAT_WOOD      ] = {"decals/wood/shot1","decals/wood/shot2","decals/wood/shot3","decals/wood/shot4","decals/wood/shot5",},
	[MAT_METAL     ] = {"decals/wm/metal/1","decals/wm/metal/2","decals/wm/metal/3"},
	[MAT_VENT      ] = {"decals/metal/shot1","decals/metal/shot2","decals/metal/shot3","decals/metal/shot4","decals/metal/shot5","decals/metal/shot6","decals/metal/shot7"},
	[MAT_DEFAULT   ] = {"decals/concrete/shot1","decals/concrete/shot2","decals/concrete/shot3","decals/concrete/shot4","decals/concrete/shot5"},
	[MAT_GRATE     ] = {"empty"},
	[MAT_PLASTIC   ] = {"decals/concrete/shot1","decals/concrete/shot2","decals/concrete/shot3","decals/concrete/shot4","decals/concrete/shot5"},
	[MAT_GLASS     ] = {"decals/glass/shot1","decals/glass/shot2","decals/glass/shot3","decals/glass/shot4","decals/glass/shot5"},
	[MAT_COMPUTER  ] = {"decals/metal/shot1","decals/metal/shot2","decals/metal/shot3","decals/metal/shot4","decals/metal/shot5","decals/metal/shot6","decals/metal/shot7"},
	[MAT_FLESH     ] = {"decals/flesh/blood1","decals/flesh/blood2","decals/flesh/blood3","decals/flesh/blood4","decals/flesh/blood5"},
	[MAT_GRASS     ] = {"empty"},
	[MAT_SLOSH     ] = {"empty"},
	["sharp"       ] = {"decals/manhackcut"},
	["sharp_flesh" ] = {"decals/flesh/blood1","decals/flesh/blood2","decals/flesh/blood3","decals/flesh/blood4","decals/flesh/blood5"},
}
local HitMaterialSounds = {
	[MAT_CONCRETE] = {"physics/concrete/rock_impact_hard4.wav","physics/concrete/rock_impact_hard5.wav","physics/concrete/rock_impact_hard6.wav","physics/concrete/rock_impact_hard3.wav","physics/concrete/rock_impact_hard2.wav","physics/concrete/rock_impact_hard1.wav"},
	[MAT_WOOD    ] = {"physics/wood/wood_box_impact_bullet1.wav","physics/wood/wood_box_impact_bullet2.wav","physics/wood/wood_box_impact_bullet3.wav","physics/wood/wood_box_impact_bullet4.wav"},
	[MAT_METAL   ] = {"physics/metal/metal_box_impact_bullet1.wav","physics/metal/metal_box_impact_bullet2.wav","physics/metal/metal_box_impact_bullet3.wav","physics/metal/metal_box_impact_hard1.wav","physics/metal/metal_box_impact_hard2.wav","physics/metal/metal_box_impact_hard3.wav","physics/metal/metal_solid_impact_soft1.wav"},
	[MAT_DEFAULT ] = {"physics/concrete/concrete_impact_bullet1.wav","physics/concrete/concrete_impact_bullet2.wav","physics/concrete/concrete_impact_bullet3.wav","physics/concrete/concrete_impact_bullet4.wav"},
	[MAT_GRATE   ] = {"physics/metal/metal_chainlink_impact_hard1.wav","physics/metal/metal_chainlink_impact_hard2.wav","physics/metal/metal_chainlink_impact_hard3.wav"},
	[MAT_PLASTIC ] = {"physics/plastic/plastic_box_impact_bullet4.wav","physics/plastic/plastic_box_impact_bullet5.wav","physics/plastic/plastic_box_impact_hard1.wav","physics/plastic/plastic_box_impact_hard2.wav","physics/plastic/plastic_box_impact_hard3.wav","physics/plastic/plastic_box_impact_hard4.wav"},
	[MAT_GLASS   ] = {"physics/glass/glass_impact_hard1.wav","physics/glass/glass_impact_hard2.wav","physics/glass/glass_impact_hard3.wav","physics/glass/glass_impact_soft1.wav","physics/glass/glass_impact_soft2.wav","physics/glass/glass_sheet_impact_hard1.wav","physics/glass/glass_sheet_impact_hard2.wav","physics/glass/glass_sheet_impact_hard3.wav","physics/glass/glass_sheet_impact_soft1.wav"},
	[MAT_COMPUTER] = {"physics/metal/metal_computer_impact_hard1.wav","physics/metal/metal_computer_impact_hard2.wav","physics/metal/metal_computer_impact_hard3.wav","physics/metal/metal_computer_impact_soft1.wav","physics/metal/metal_computer_impact_soft2.wav","physics/metal/metal_computer_impact_soft3.wav","physics/metal/metal_computer_impact_bullet1.wav","physics/metal/metal_computer_impact_bullet2.wav","physics/metal/metal_computer_impact_bullet3.wav"},
	[MAT_FLESH   ] = {"physics/flesh/flesh_impact_hard1.wav","physics/flesh/flesh_impact_hard2.wav","physics/flesh/flesh_impact_hard3.wav","physics/flesh/flesh_impact_hard4.wav","physics/flesh/flesh_impact_hard5.wav","physics/flesh/flesh_impact_hard6.wav"},
	[MAT_SAND    ] = {"physics/surfaces/sand_impact_bullet1.wav","physics/surfaces/sand_impact_bullet2.wav","physics/surfaces/sand_impact_bullet3.wav","physics/surfaces/sand_impact_bullet4.wav"},
	[MAT_VENT    ] = {"physics/metal/metal_grate_impact_hard1.wav","physics/metal/metal_grate_impact_hard2.wav","physics/metal/metal_grate_impact_hard3.wav"},
	[MAT_TILE    ] = {"impact/tile/1.wav","impact/tile/2.wav","impact/tile/3.wav","impact/tile/4.wav","impact/tile/5.wav"}
}
local HitMaterialSoundsSharp = {
	[MAT_DEFAULT] = {"impact/sharp/default/1.wav","impact/sharp/default/2.wav","impact/sharp/default/3.wav"},
	[MAT_METAL  ] = {"weapons/l4d2_kf2_katana/katana_impact_world1.wav","weapons/l4d2_kf2_katana/katana_impact_world2.wav"},
	[MAT_FLESH  ] = {"weapons/l4d2_kf2_katana/melee_katana_01.wav","weapons/l4d2_kf2_katana/melee_katana_02.wav","weapons/l4d2_kf2_katana/melee_katana_03.wav"},
}
local HitMaterialParticles = {
	[MAT_METAL   ] = {"MetalSpark",0},
	[MAT_DEFAULT ] = {"RagdollImpact",0}
}

local newmaterials = hookRun("WM_HitInfoLoad",HitMaterialDecals,HitMaterialSounds,HitMaterialSoundsSharp,HitMaterialParticles)
HitMaterialDecals = IfNil(newmaterials,1,HitMaterialDecals)
HitMaterialSounds = IfNil(newmaterials,2,HitMaterialSounds)
HitMaterialSoundsSharp = IfNil(newmaterials,3,HitMaterialSoundsSharp)
HitMaterialParticles = IfNil(newmaterials,4,HitMaterialParticles)

local HitMaterialDecals_Loaded = {}
for id, data in pairs(HitMaterialDecals) do
	for i, texture in pairs(data) do
		if texture ~= "empty" then
			HitMaterialDecals_Loaded[texture] = Material(texture)
		end
	end
end
p("Materials loaded!")

function PlaySoundAndEffect(ray,owner,HMS,sound,particle)
	local pitch = math.random(50,150)
	if sharp then
		pitch = math.random(100,120)
	end
	if HMS[sound] == nil then sound = MAT_DEFAULT end
	owner:EmitSound( Sound(HMS[sound][math.random(1,#HMS[sound])]),75,pitch)
	if GetConVar("wm_camerashake"):GetBool() then
		util.ScreenShake(ray.HitPos,GetConVar("wm_camerashakescale"):GetFloat(),40,1,100,true)
	end
	if HitMaterialParticles[particle] == nil then particle = MAT_DEFAULT end
	if HitMaterialParticles[particle] ~= "empty" then
		local particleinfo = HitMaterialParticles[particle]
		local effectInfo = EffectData()
		effectInfo:SetOrigin(ray.HitPos)
		effectInfo:SetEntity(ray.Entity)
		effectInfo:SetScale(10)
		util.Effect( particleinfo[1], effectInfo )
	end
end

function HitMaterial(ray,owner,info)
	local sharp = Get(info,"Sharp",false)
	
	local material = ray.MatType
	local particle = material
	local sound = material
	if material == MAT_ANTLION or material == MAT_BLOODYFLESH or material == MAT_ALIENFLESH then
		material = MAT_FLESH --не забыть про кровь зомби и т.д
		sound = MAT_FLESH
		particle = MAT_FLESH
	end
	if material == MAT_GRASS then
		sound = MAT_SAND
	end
	if material == MAT_VENT then
		particle = MAT_METAL
	end
	if material == MAT_SAND then
		material = MAT_METAL
	end
	if material == MAT_DIRT then
		material = MAT_CONCRETE
	end
	
	local HMD = HitMaterialDecals
	local HMS = HitMaterialSounds
	if sharp then
		HMS = HitMaterialSoundsSharp
		if HMD[material] ~= nil then
			if HMD[material][1] ~= "empty" then
				if material == MAT_ANTLION or material == MAT_BLOODYFLESH or material == MAT_ALIENFLESH or material == MAT_FLESH then
					material = "sharp_flesh"
				else
					material = "sharp"
				end
			end
		end
	end
	
	if HMD[material]==nil then
		material = MAT_DEFAULT
	end
	if HMS[sound]==nil then
		sound = MAT_DEFAULT
	end
	if HitMaterialParticles[particle]==nil then
		particle = MAT_DEFAULT
	end
	
	local scale = math.random(10,20)/10
	if not Get(info,"DontDecals",false) and GetConVar("wm_placedecals"):GetBool() then
		local dec = HMD[material][math.random(1,#HMD[material])]
		if GetConVar("wm_funny_randomdecals"):GetBool() then
			local randdec_table = HMD[getRandomKeyFromTable(HMD)]
			dec = randdec_table[math.random(1,#randdec_table)]
		end
		PlaceDecal(dec, ray.Entity, ray.HitPos, ray.HitNormal, Color(255,255,255), scale, scale)
	end
	PlaySoundAndEffect(ray,owner,HMS,sound,particle)
end

function PreHit(owner,info,startray)
	local forward = owner:EyeAngles() + startray
	local base = owner:EyePos() + (forward:Forward() * (Get(info,"AttackDistance",70)*math.max(0,GetConVar("wm_distancescale"):GetFloat())))
	local rayInfo = {
		start = owner:GetShootPos(),
		endpos = base,
		filter = owner,
		mask = MASK_SOLID,
	}
	local ray = util.TraceLine(rayInfo)
	if ray.Hit then
		if not ray.HitWorld then
			return true
		end
	end
	return false
end

local debugdamagehits = -1
function Hit(owner,info,startray,dont,count,entityonray,afterhit)
	if IsValid(owner) then
		local forward = owner:EyeAngles() + startray
		local base = owner:EyePos() + (forward:Forward() * (Get(info,"AttackDistance",70)*math.max(0,GetConVar("wm_distancescale"):GetFloat())))
		local rayInfo = {
			start = owner:GetShootPos(),
			endpos = base,
			filter = owner,
			mask = MASK_SOLID,
		}
		local ray = util.TraceLine(rayInfo)
		
		local damageinfo = Get(info,"Damage",Vector(10,10))
		local damage = math.random(damageinfo.x,damageinfo.y)
		local damagepinfo = Get(info,"DamageProp",Vector(0,0))
		local damagep = damage/5
		if damageinfo.x ~= 0 and damageinfo.y ~= 0 then
			damagep = math.random(damagepinfo.x,damagepinfo.y)
		end
		
		damage = damage * math.max(0,GetConVar("wm_damagescale"):GetFloat())
		damagep = damagep * math.max(0,GetConVar("wm_damagescale_prop"):GetFloat())
		
		local rayWaterInfo = {
			start = owner:GetShootPos(),
			endpos = base,
			filter = owner,
			mask = MASK_WATER,
		}
		local rayWater = util.TraceLine(rayWaterInfo)
		if rayWater.Hit then
			local watersplashsize = Get(info,"WaterSplashSize",nil)
			if watersplashsize == nil then
				watersplashsize = damagep/5
			end
			local notignore = hookRun("WM_HitWater",watersplashsize,owner,info,rayWater,startray,dont,entityonray,"watersplash")
			watersplashsize = IfNil(notignore,1,watersplashsize)
			rayWater = IfNil(notignore,2,rayWater)
			local effectstring = IfNil(notignore,3,"watersplash")
			if watersplashsize>0 then
				if rayWater.HitNormal == Vector(0,0,1) then
					local effectInfo2 = EffectData()
					effectInfo2:SetOrigin(rayWater.HitPos)
					effectInfo2:SetScale(watersplashsize)
					effectInfo2:SetEntity(rayWater.Entity);
					util.Effect(effectstring, effectInfo2)
				end
			end
		end
		
		local kickmul = Get(info,"KickScale",1) * math.max(0,GetConVar("wm_kickscale"):GetFloat())
		
		local lifetime = math.max(0,GetConVar("wm_debug_livetime"):GetFloat())
		if ray.Hit then
			local notignoreinf = hookRun("WM_Hit",owner,info,ray,startray,dont,entityonray)
			local notignore = IfNil(notignoreinf,1,true)
			owner = IfNil(notignoreinf,2,owner)
			info = IfNil(notignoreinf,3,info)
			ray = IfNil(notignoreinf,4,ray)
			dont = IfNil(notignoreinf,5,dont)
			entityonray = IfNil(notignoreinf,6,entityonray)
		
			if notignore then
				local hitcolor = Color(0,0,255)
				local hittyp = "default"
				local sharp = Get(info,"Sharp",false)
				local entity = ray.Entity
				if (ray.HitNoDraw and entity:GetClass()~="func_breakable_surf") or ray.HitSky then
					return false
				end
				
				if entityonray and ray.HitWorld and not afterhit then
					if GetConVar("wm_debug_showhit"):GetBool() then
						local size = 1
						DrawSphere(ray.HitPos,size,lifetime,Color(255,255,255),"default")
					end
					return false
				end
				
				local placedecal = false
				
				local debugdamage = GetConVar("wm_debug_showdamage"):GetBool()
				
				local hitfunc = Get(info,"HitFunction",function()end)
				if GetConVar("wm_customfunctions"):GetBool() and IsValid(owner) then
					hitfunc(ray,owner,dont)
				end
				
				if not dont then
					local hitsounds = Get(info,"HitSounds","")
					if hitsounds ~= "" then
						owner:EmitSound( Sound(hitsounds[math.random(1,#hitsounds)]),75,math.random(80,120))
					end
				
					if ray.HitWorld then
						local lineindex = 0
						placedecal = true
						
						if debugdamage then
							debugdamagehits = debugdamagehits + 1
							debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"["..debugdamagehits.."] World ["..ray.MatType.."]",lifetime*2,Color(255,255,255))
							lineindex=lineindex+1
							debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"[Entity] "..damage,lifetime*2,Color(255,0,0))
							lineindex=lineindex+1
							debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"[Player] "..(damage*GetConVar("wm_damagescale_player"):GetFloat()),lifetime*2,Color(255,255,0))
							lineindex=lineindex+1
							debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"[Prop  ] "..damagep,lifetime*2,Color(0,255,0))
							lineindex=lineindex+1
						end

					else
						if IsValid(entity) then
							if entity:IsNPC() or entity:IsPlayer() then
								local hitlegs = ray.HitBox >= 7 and ray.HitBox <= 14
							
								hitcolor = Color(255,0,0)
								local lineindex = 0
								
								local entity_weapon = entity:GetActiveWeapon()
								local ent_info = nil
								local entity_block = false
								if IsValid(entity_weapon) then
									if WMLib.ThatWMWeapon(entity_weapon) then
										ent_info = WMLib.GetInfo(entity_weapon)
										local hookentityblock = hookRun("WM_HitBlock",owner,info,entity,ent_info,entity_weapon.NowBlock,hitlegs)
										info = IfNil(hookentityblock,2,info)
										ent_info = IfNil(hookentityblock,3,ent_info)
										entity_block = IfNil(hookentityblock,1,entity_weapon.NowBlock and (not hitlegs or GetConVar("wm_legsblock"):GetBool()))
									end
								end
								
								local HMS = HitMaterialSounds
								if sharp then
									HMS = HitMaterialSoundsSharp
								end
								
								if entity_block then
									local mat = Get(ent_info,"Material",MAT_METAL)
									PlaySoundAndEffect(ray,owner,HMS,mat,mat)
								else
									local entity_vj_base = entity.IsVJBaseSNPC
									
									if entity_vj_base then
										owner:EmitSound( Sound(HMS[MAT_FLESH][math.random(1,#HMS[MAT_FLESH])]),75,math.random(50,150))
									else
										local bloodcolor = entity:GetBloodColor()
										if bloodcolor == 0 then
											local effectInfo = EffectData()
											effectInfo:SetOrigin( ray.HitPos )
											effectInfo:SetFlags(3)
											effectInfo:SetColor(0)
											effectInfo:SetScale(6)
											util.Effect( "BloodImpact", effectInfo )
											owner:EmitSound( Sound(HMS[MAT_FLESH][math.random(1,#HMS[MAT_FLESH])]),75,math.random(50,150))
											PlaceDecal(HitMaterialDecals[MAT_FLESH][math.random(1,#HitMaterialDecals[MAT_FLESH])], ray.Entity, ray.HitPos, ray.HitNormal, Color(255,255,255), 1, 1)
										elseif bloodcolor == 3 or bloodcolor == -1 then
											local effectInfo = EffectData()
											effectInfo:SetOrigin( ray.HitPos )
											util.Effect( "MetalSpark", effectInfo )
											owner:EmitSound( Sound(HMS[MAT_METAL][math.random(1,#HMS[MAT_METAL])]),75,math.random(80,120))
										else
											local effectInfo = EffectData()
											effectInfo:SetOrigin( ray.HitPos )
											effectInfo:SetFlags(3)
											effectInfo:SetColor(bloodcolor)
											effectInfo:SetScale(6)
											util.Effect( "BloodImpact", effectInfo )
											owner:EmitSound( Sound(HMS[MAT_FLESH][math.random(1,#HMS[MAT_FLESH])]),75,math.random(50,150))
										end
									end
									
								end
								
								if owner:IsPlayer() then
									entity:SetLocalVelocity( entity:GetBaseVelocity() + (owner:GetAimVector() * damage * kickmul) )
								end
								
								if entity:Health() > 0 then
									if entity:IsPlayer() then
										damage = damage * GetConVar("wm_damagescale_player"):GetFloat()
									end
								
									if ray.HitBox == 0 then
										damage = damage * math.max(0,GetConVar("wm_damagescale_headshot"):GetFloat())
										hittyp = "headshot"
									end
									
									if entity_block then
										damage = damage * Get(ent_info,"BlockPower",0.25) * math.max(GetConVar("wm_blockscale"):GetFloat(),0)
										hittyp = "block"
									end
									
									if debugdamage then
										debugdamagehits = debugdamagehits + 1
										local col_ = LerpVector(math.Clamp((entity:Health()-damage)/entity:GetMaxHealth(),0,1),Vector(255,0,0),Vector(0,255,0))
										local col = Color(col_.x,col_.y,col_.z)
										local whothat = "NPC".." ["..entity:GetClass().."]"
										if entity:IsPlayer() then
											whothat = "Player".." ["..entity:GetName().."]"
										end
										debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"["..debugdamagehits.."] "..whothat,lifetime*2,Color(255,255,255))
										lineindex=lineindex+1
										debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,entity:Health().." ("..entity:GetMaxHealth()..")".." - "..damage.." = "..(entity:Health()-damage),lifetime*2,col)
										lineindex=lineindex+1
										if ray.HitBox == 0 then
											debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Headshot x"..math.max(0,GetConVar("wm_damagescale_headshot"):GetFloat()),lifetime*2,Color(255,255,255))
											lineindex=lineindex+1
										end
										if entity_block then
											debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Block x"..(Get(ent_info,"BlockPower",0.25)*math.max(GetConVar("wm_blockscale"):GetFloat(),0)),lifetime*2,Color(255,255,255))
											lineindex=lineindex+1
										end
										if entity:Health()-damage <= 0 then
											debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Killed!",lifetime*2,Color(100,100,100))
											lineindex=lineindex+1
										end
									end
									
									entity:TakeDamage( damage, owner, owner:GetActiveWeapon() )
									if entity_block then
										local blockhitfunc = Get(ent_info,"BlockHitFunction",nil)
										if blockhitfunc ~= nil then
											blockhitfunc(entity,owner,damage)
										end
									end
									if ragmod and entity:IsPlayer() and GetConVar("wm_ragdollize"):GetBool() then
										if (ray.HitBox == 0 and not entity_block) or damage > math.max(-1,GetConVar("wm_ragdollize_needdamage"):GetInt()) then
											hittyp = "ragdollize"
											ragmod:TryToRagdoll(entity)
											ragmod:GetRagmodRagdoll(entity):GetPhysicsObject():ApplyForceOffset( owner:GetAimVector() * damage * kickmul, ray.HitPos )
											
											if debugdamage then
												debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Ragdollize",lifetime*2,Color(255,255,255))
												lineindex=lineindex+1
											end
										end
									end
									
									if owner:IsPlayer() then
										net.Start("wm_ClientHit")
										net.WriteTable({ray.HitPos})
										net.Send(owner)
									end
								end
							else
								if IsValid(entity:GetPhysicsObject()) then
									if WMLib.ThatWMWeapon(entity) then
										ray.MatType = Get(WMLib.GetInfo(entity),"Material",MAT_METAL)
									end
									hittyp = "entity"
									if entity:GetClass() ~= "prop_effect" then
										local lineindex = 0
									
										if owner:IsPlayer() then
											entity:GetPhysicsObject():ApplyForceOffset( owner:GetAimVector() * damage * 75 * kickmul , ray.HitPos )
										end
										placedecal = true
										
										if debugdamage then
											debugdamagehits = debugdamagehits + 1
											local col_ = LerpVector(math.Clamp((entity:Health()-damagep)/entity:GetMaxHealth(),0,1),Vector(255,0,0),Vector(0,255,0))
											local col = Color(col_.x,col_.y,col_.z)
											debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"["..debugdamagehits.."] "..entity:GetClass(),lifetime*2,Color(255,255,255))
											lineindex=lineindex+1
											if entity:GetClass()~="func_breakable_surf" then
												if entity:Health() > 0 then
													debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,entity:Health().." ("..entity:GetMaxHealth()..")".." - "..damagep.." = "..(entity:Health()-damagep),lifetime*2,col)
												else
													debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Entity no has health!",lifetime*2,Color(100,100,100))
												end
												lineindex=lineindex+1
												if entity:Health()-damagep <= 0 and entity:Health() > 0 then
													debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Killed!",lifetime*2,Color(100,100,100))
													lineindex=lineindex+1
												end
											else
												debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,damagep.." >= 10",lifetime*2,Color(255,0,0))
												lineindex=lineindex+1
											end
										end
											
										if entity:Health() > 0 then
											entity:TakeDamage( damagep, owner, owner:GetActiveWeapon() )
										end
										
										if entity:GetClass()=="func_breakable_surf" then
											ray.MatType = MAT_GLASS
											if damagep >= 10 then
												hittyp = "glass"
												entity:Input("Shatter",owner,owner:GetActiveWeapon())
												if debugdamage then
													debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Glass shattered",lifetime*2,Color(100,100,255))
													lineindex=lineindex+1
												end
											end
										end
										
										if ragmod then
											if ragmod:IsRagmodRagdoll(entity) then
												hitcolor = Color(255,0,0)
												hittyp = "ragdoll"
												if IsValid(entity:GetPossessor()) and not GetConVar("sbox_godmode"):GetBool() then
													local plr = entity:GetPossessor()
														if plr:Health() > 0 then												
														if GetConVar("wm_debug_showdamage"):GetBool() then
															debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Damage ragdoll",lifetime*2,Color(255,255,255))
															lineindex=lineindex+1
														end
														
														if (plr:Health() - damage) <= 0 then
															plr:Kill()
															if GetConVar("wm_debug_showdamage"):GetBool() then
																debugoverlay.EntityTextAtPosition(ray.HitPos,lineindex,"Killed!",lifetime*2,Color(100,100,100))
																lineindex=lineindex+1
															end
														else
															plr:SetHealth(plr:Health() - damage)
														end
													end
												end
											end
										end
									end
								end
							end
							if GetConVar("wm_funny_burn"):GetBool() and IsValid(entity) then
								entity:Ignite(math.random(3,20))
							end
							if GetConVar("wm_funny_shock"):GetBool() and IsValid(entity) then
								WMLib.ShockEntity(entity,10)
							end
						end
					end
				end
				if placedecal and (IsValid(entity) or ray.HitWorld) then
					HitMaterial(ray,owner,info)
				end
				
				if GetConVar("wm_debug_showhit"):GetBool() then
					local color = hitcolor
					local size = 2
					if dont then
						color = Color(Lerp(count,255,0),255,0)
						hittyp = "default"
						size = 1
					end
					DrawSphere(ray.HitPos,size,lifetime,color,hittyp)
				end
			end
		end
		
		local hitfuncaft = Get(info,"HitAfterFunction",function()end)
		if GetConVar("wm_customfunctions"):GetBool() then
			hitfuncaft(ray,owner,dont)
		end
		
		return ray.Hit
	end
	return false
end

function PickupWeapon(ply, wep)
	local class = wep:GetClass()
	if string.sub(class,1,9) == "wm_debug_" then
		if not GetConVar("wm_takeweapons"):GetBool() then return false end
		return true
	end
	if string.sub(class,1,3) == "wm_" then
		if not GetConVar("wm_takeweapons"):GetBool() then return false end
		if ply:HasWeapon(class) then return false end
	end
	
   return true
end

hookAdd("PlayerCanPickupWeapon","AllowPickUpWeapon",PickupWeapon)

function dt()
	return RealFrameTime()*200
end

if SERVER then
	util.AddNetworkString("wm_PlaceDecal")
	util.AddNetworkString("wm_ClientHit")
	util.AddNetworkString("wm_ClientHitDebug")
else
	local lasthitpos = {}
	local debughitpos = {}
	local hitmaterial = Material("sprites/wm_hit.png") 
	local debughitmaterials = {
		["default"    ] = Material("sprites/wm_sphere.png"),
		["headshot"   ] = Material("sprites/wm_sphere_headshot.png"),
		["block"      ] = Material("sprites/wm_sphere_block.png"),
		["ragdoll"    ] = Material("sprites/wm_sphere_ragdoll.png"),
		["ragdollize" ] = Material("sprites/wm_sphere_ragdollize.png"),
		["entity"     ] = Material("sprites/wm_sphere_entity.png"),
		["glass"      ] = Material("sprites/wm_sphere_glass.png")
	}
	hookAdd("HUDPaint", "woowzmelee_render", function()
		cam.Start3D()
			if GetConVar("wm_showhits"):GetBool() then
				for _, lhp in pairs(lasthitpos) do
					render.SetMaterial(hitmaterial)
					render.DrawSprite(lhp[1],lhp[3],lhp[3],ColorAlpha(Color(255,255,255),math.ceil(lhp[2])))
					lhp[2] = math.max(0,lhp[2]-0.5)
					lhp[3] = math.max(0,lhp[3]-0.01)
					lasthitpos[_] = lhp
				end
			end
			if GetConVar("wm_debug_showhit"):GetBool() then
				for _, lhp in pairs(debughitpos) do
					if lhp[4] ~= Color(255,0,0) and lhp[4] ~= Color(0,0,255) then
						render.SetMaterial(debughitmaterials[lhp[5]])
						local size = lhp[2]*4
						local alpha = 255
						if lhp[6]<math.random(0,32) then
							alpha = 0
						end
						render.DrawSprite(lhp[1],size,size,ColorAlpha(lhp[4],alpha))
						lhp[6] = math.max(0,lhp[6]-(dt()*1.5)/lhp[3])
						debughitpos[_] = lhp
					end
				end
				for _, lhp in pairs(debughitpos) do
					if lhp[4] == Color(255,0,0) or lhp[4] == Color(0,0,255) then
						render.SetMaterial(debughitmaterials[lhp[5]])
						local size = lhp[2]*4
						local alpha = 255
						if lhp[6]<math.random(0,32) then
							alpha = 0
						end
						render.DrawSprite(lhp[1],size,size,ColorAlpha(lhp[4],alpha))
						lhp[6] = math.max(0,lhp[6]-(dt()*1.5)/lhp[3])
						debughitpos[_] = lhp
					end
				end
			end
		cam.End3D()
	end)

	net.Receive("wm_PlaceDecal", function(len, ply)
		local info = net.ReadTable()
		if info[1] ~= "empty" and (IsValid(info[2]) or info[2] == Entity(0)) then
			local mat = HitMaterialDecals_Loaded[info[1]]
			if mat == nil then
				mat = Material(info[1])
			end
			util.DecalEx(mat,info[2],info[3],info[4],info[5],info[6],info[7])
		end
	end)
	
	net.Receive("wm_ClientHit", function(len, ply)
		local info = net.ReadTable()
		local index = #lasthitpos+1
		timerSimple(3,function() lasthitpos[index] = nil end)
		lasthitpos[index] = {info[1],255,8}
	end)
	
	net.Receive("wm_ClientHitDebug", function(len, ply)
		local info = net.ReadTable()
		local index = #debughitpos+1
		timerSimple(info[3],function() debughitpos[index] = nil end)
		debughitpos[index] = {info[1],info[2],info[3],info[4],info[5],255}
	end)
end

function LoadWMWeapon(SWEP,info,load_,modinfo)
	SWEP.Base = "wm_base"
	local author = tostring(Get(modinfo,"Author","Anonymous"))
	local maybe_author = tostring(Get(info,"CustomAuthor",""))
	if maybe_author ~= "" then
		author = maybe_author
	end
	SWEP.Author = author
	SWEP.ModId = modinfo["ID"]
	SWEP.Spawnable = load_
	local category = tostring(Get(info,"Category",category_main))
	if category ~= category_main and not GetConVar("wm_funny_randomnames"):GetBool() then
		category = category_main.." ["..category.."]"
	end
	SWEP.Category = category
	if CLIENT then
		list.Set("ContentCategoryIcons", category, "icons/wm_category.png")
	end
	
		local thatdebug = Get(info,"Debug",false)
	
	SWEP.AdminOnly = GetConVar("wm_onlyadmin"):GetBool() or thatdebug
	
	local name = tostring(Get(info,"Name","New Weapon"))
	if Get(info,"Funny",false) then
		name = " "..name.." "
	end
	if thatdebug then
		name = "ㅤ"..name.."ㅤ"
	end
	local t = {
		{"Dam","Entity Damage","216,47,32"},
		{"PDa","Prop Damage","93,109,216"},
		{"Del","Delay","73,216,83"},
		{"ADi","Attack Distance","234,172,49"},
		{"BPo","Block Power","234,44,196"},
		{"CFu","Has Custom Functions","230,230,230"},
		{"Fun","Funny","230,230,230"},
		{"HIn","Has Inspect Animations","230,230,230"}
	}
	local icon = tostring(Get(info,"Icon","icons/wm_empty.png"))
	if GetConVar("wm_funny_randomnames"):GetBool() and not thatdebug then
		icon = "icons/wm_empty.png"
		name = ""
		local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		for i = 1, 10 do
			local randomIndex = math.random(1, #charset)
			name = name .. charset:sub(randomIndex, randomIndex)
		end
		SWEP.DrawWeaponInfoBox = false
	else
		local desc_damage = Get(info,"Damage",Vector(10,10))
		local desc_damage_prop = Get(info,"DamageProp",Vector(0,0))
		if desc_damage_prop.x == 0 and desc_damage_prop.y == 0 then
			desc_damage_prop = Vector(desc_damage.x/5,desc_damage.y/5)
		end
		
		local inst = "From: "..modinfo["Name"].."\n\n"
		local index = 1
		if GetConVar("wm_extendeddesc"):GetBool() then
			index = 2
		end
		function inst_(i,text)
			inst = inst..t[i][index]..": "..text.."\n"
		end
		inst_(1,desc_damage.x.."-"..desc_damage.y)
		inst_(2,desc_damage_prop.x.."-"..desc_damage_prop.y)
		inst_(3,(Get(info,"AttackWait",Vector(1,0,0))[1]+Get(info,"AttackHitWait",0)))
		inst_(4,Get(info,"AttackDistance",70))
		inst_(5,math.ceil(1/math.max(Get(info,"BlockPower",0.25),0.0001))-1)
		inst_(6,tostring(Get(info,"PreAttackFunctionInfo","") ~= "" or Get(info,"HitAfterFunction","") ~= "" or Get(info,"HitFunction","") ~= ""))
		inst_(7,tostring(Get(info,"Funny",false)))
		inst_(8,tostring(Get(info,"AnimationInspect","")~=""))
		SWEP.Instructions = inst
		SWEP.DrawWeaponInfoBox = true
	end
	SWEP.PrintName = name
	SWEP.DisableDuplicator = thatdebug
	if thatdebug then
		icon = "icons/wm_debug.png"
	else
		list.Add( "NPCUsableWeapons", { class = info["Class"],	title = name }  )
	end
	SWEP.IconOverride = icon
	if CLIENT then
		local wepselectionicon = Material(Get(info,"SelectionIcon","icons/wm_empty_i.png"))
		wepselectionicon:SetInt("$ignorez",    1)
		wepselectionicon:SetInt("$vertexcolor",1)
		wepselectionicon:SetInt("$vertexalpha",1)
		wepselectionicon:SetInt("$nolod",      1)
		SWEP.WepSelectIcon = wepselectionicon
		killicon.Add(info["Class"],Get(info,"KillIcon","icons/wm_empty_k.png"),Color(255,255,255))
		
		function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
			surface.SetDrawColor( 255, 255, 255, alpha )
			surface.SetMaterial( self.WepSelectIcon )
			surface.DrawTexturedRect( x, y + 10,  256 * ScrW()/1920 , 128 * ScrH()/1080 )

			self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
		end
		
		function SWEP:PrintWeaponInfo( x, y, alpha )
			if ( self.DrawWeaponInfoBox == false ) then return end

			if ( self.InfoMarkup == nil ) then
				local text = self.Instructions
				local str = "<font=HudSelectionText>"
				
				local i = 0
				for line in text:gmatch("[^\n]+") do
					local color = "230,230,230"
					if i >= 1 then
						color = t[i][3]
					end
					str = str .. "<color="..color..",255>"..line:gsub("false","</color><color=216,47,32,255>false"):gsub("true","</color><color=73,216,83,255>true").."</color>\n"
					if i == 0 then
						str = str .. "\n"
					end
					i = i + 1
				end
				
				str = str .. "</font>"

				self.InfoMarkup = markup.Parse( str, 250 )
			end

			surface.SetDrawColor( 60, 60, 60, alpha )
			surface.SetTexture( self.SpeechBubbleLid )

			surface.DrawTexturedRect( x, y - 64 - 5, 128, 64 )
			draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )

			self.InfoMarkup:Draw( x + 5, y + 5, nil, nil, alpha )
		end
	end
	
	SWEP.IdleScale = Get(info,"IdleScale",1)
	SWEP.BobScale = Get(info,"BobbingScale",3)

	SWEP.UseHands = true
	SWEP.ViewModel = Model(tostring(Get(info,"VModel","models/weapons/c_crowbar.mdl")))
	SWEP.WorldModel = Model(tostring(Get(info,"WModel","models/weapons/w_crowbar.mdl")))
	
	function SWEP:CanBePickedUpByNPCs()
		return GetConVar("wm_npccanuse"):GetBool()
	end
	
	function SWEP:Equip(owner)
		if owner:IsNPC() then
			self:SetHoldType("melee2")
		else
			self:SetHoldType(Get(info,"Hold","melee"))
		end
	end
	
	local npcwait = 0
	function SWEP:GetCapabilities()
		if IsValid(self) then
			npcwait = npcwait+1
			local owner = self:GetOwner()
			--[[local act = owner:GetActivity()
			if act == ACT_RELOAD then
				owner:SetActivity(1)
			end
			print(act)]]
			if npcwait >= 300 then
				npcwait = 0
				if GetConVar("wm_npccanuse"):GetBool() then
					if owner:GetEnemy() ~= nil then
						local base = owner:EyePos() + (owner:EyeAngles():Forward() * (Get(info,"AttackDistance",70)*math.max(0,GetConVar("wm_distancescale"):GetFloat())))
						local rayInfo = {
							start = owner:GetShootPos(),
							endpos = base,
							filter = owner,
							mask = MASK_SOLID,
						}
						local ray = util.TraceLine(rayInfo)
						if ray.Hit then
							if IsValid(ray.Entity) then
								if ray.Entity == owner:GetEnemy() then
									self:PrimaryAttack()
								end
							end
						end
					end
				end
			end
		end
		return CAP_WEAPON_MELEE_ATTACK1
	end
	
	SWEP.WaitDraw = false
	
	function SWEP:Deploy()
		local owner = self:GetOwner()
		self:SetHoldType(Get(info,"Hold","melee"))
		local drawanim = Get(info,"AnimationDraw","Draw")
		local vm = self:GetOwner():GetViewModel()
		local drawsound = Get(info,"DrawSound","")
		if drawsound[1] ~= "" and IsValid(owner) then
			owner:EmitSound( Sound(drawsound[1]),75,100*drawsound[2])
		end
		if drawanim ~= "" then
			local drawanim_, wait = vm:LookupSequence(drawanim)
			SWEP.WaitDraw = true
			vm:SendViewModelMatchingSequence(drawanim_)
			timerSimple(wait,function()
				if IsValid(self) then
					if IsValid(owner) then
						if owner:GetActiveWeapon() == self then
							local idleanim = Get(info,"AnimationIdle","")
							if idleanim ~= "" then
								vm:SendViewModelMatchingSequence(vm:LookupSequence(idleanim))
							end
							SWEP.WaitDraw = false
						end
					end
				end
			end)
		else
			local idleanim = Get(info,"AnimationIdle","")
			if idleanim ~= "" then
				vm:SendViewModelMatchingSequence(vm:LookupSequence(idleanim))
			end
		end
		
		if IsValid(self) and SERVER then
			self.AttackWait = false
			self.BlockWait = false
			self.CoolAnim = false
		end
	end
	
	function SWEP:Initialize()
		self:SetHoldType("melee2")
		self.WoowzMelee = true
		self.WMInfo = info
		self.BlockWaitJ = 0
		self.BlockWaitI = 0
		self.NowBlock = false
		
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			local matresults = {
				[MAT_CONCRETE] = "concrete",
				[MAT_WOOD    ] = "wood",
				[MAT_GLASS   ] = "glass",
				[MAT_FLESH   ] = "flesh",
				[MAT_PLASTIC ] = "plastic"
			}
			local mat = Get(matresults,Get(info,"Material",MAT_METAL),"metal")
			phys:SetMaterial(mat)
		end
		
		if CLIENT then
			self.ClientWorldModel = ClientsideModel(SWEP.WorldModel)
			self.ClientWorldModel:SetNoDraw(true)
		end
	end

	local weaponfov = Get(info,"FOV",80)
	SWEP.ViewModelFOV = weaponfov * GetConVar("wm_fovscale"):GetFloat()
	SWEP.DrawCrosshair = GetConVar("wm_crosshair"):GetBool()
	function SWEP:Think()
		self.ViewModelFOV = weaponfov * GetConVar("wm_fovscale"):GetFloat()
		self.DrawCrosshair = GetConVar("wm_crosshair"):GetBool()
		local owner = self:GetOwner()
		if IsValid(owner) then
			if owner:IsPlayer() and SERVER then
				self.BlockWait = owner:KeyDown(IN_ATTACK2) and not self.AttackWait and GetConVar("wm_canblock"):GetBool() and not SWEP.WaitDraw or Get(info,"AutoBlock",false)
				local blockspeed = 0.06*Get(info,"BlockWait",1)
				if self.BlockWait then
					self.BlockWaitJ = math.min(self.BlockWaitJ+blockspeed,1)
					self.BlockWaitI = math.ease.InOutQuad(self.BlockWaitJ)
				else
					self.BlockWaitJ = math.max(self.BlockWaitJ-blockspeed,0)
					self.BlockWaitI = math.ease.InOutQuad(self.BlockWaitJ)
				end
				self.NowBlock = self.BlockWaitI > 0.5
				self:CallOnClient("SetBlockClient",tostring(self.BlockWait))
				if self.NowBlock then
					self:SetHoldType(Get(info,"BlockHold","melee2"))
				else
					self:SetHoldType(Get(info,"Hold","melee"))
				end
			end
		end
	end
	
	function SWEP:SetBlockClient(bool)
		if CLIENT then
			self.BlockWait = bool == "true"
			local blockspeed = 0.06*Get(info,"BlockWait",1)
			if self.BlockWait then
				self.BlockWaitJ = math.min(self.BlockWaitJ+blockspeed,1)
				self.BlockWaitI = math.ease.InOutQuad(self.BlockWaitJ)
			else
				self.BlockWaitJ = math.max(self.BlockWaitJ-blockspeed,0)
				self.BlockWaitI = math.ease.InOutQuad(self.BlockWaitJ)
			end
			self.SwayScale = Get(info,"SwayScale",3) * Lerp(self.BlockWaitI,1,0.1)
		end
	end
	
	function SWEP:GetViewModelPosition( pos, ang )
		local offsetInfo = Get(info,"VModelPos",Vector(0,0,0))
		local offset = Vector(offsetInfo.x,offsetInfo.y,offsetInfo.z)
		offset:Rotate(ang)
		
		local offset2 = Vector(0,0,math.sin(CurTime()/2)*SWEP.IdleScale)
		offset2:Rotate(ang)
		
		local offset3 = LerpVector(self.BlockWaitI,Vector(0,0,0),Get(info,"BlockPos",Vector(0,0,0)))
		offset3:Rotate(ang)
		
		pos = pos + offset + offset2 + offset3
	
		local offsetRot = Get(info,"VModelRot",Angle(0,0,0))
		ang = ang + offsetRot
		ang = ang + LerpAngle(self.BlockWaitI,Angle(0,0,0),Get(info,"BlockRot",Angle(0,0,-45)))
		
		return pos, ang
	end
	
	SWEP.WModelVisible = Get(info,"WModelVisible",true)
	
	if CLIENT then
		function SWEP:DrawWorldModel()
			local owner = self:GetOwner()
				
			if self.ClientWorldModel ~= nil then
				if IsValid(owner) and SWEP.WModelVisible then
					local offsetVec = Get(info,"WModelPos",Vector(0,0,0)) + LerpVector(self.BlockWaitI,Vector(0,0,0),Get(info,"WBlockPos",Vector(0,0,0)))
					local offsetAng = Get(info,"WModelRot",Angle(0,0,0)) + LerpAngle(self.BlockWaitI,Angle(0,0,0),Get(info,"WBlockRot",Angle(0,0,-80)))
						
					local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
					if !boneid then return end

					local matrix = owner:GetBoneMatrix(boneid)
					if !matrix then return end

					local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
					
					self.ClientWorldModel:SetPos(newPos)
					self.ClientWorldModel:SetAngles(newAng)

					self.ClientWorldModel:SetupBones()
				else
					if not SWEP.WModelVisible and IsValid(owner) and self == owner:GetActiveWeapon() then
						self.ClientWorldModel:SetPos(Vector(0,-10000,0))
					else
						self.ClientWorldModel:SetPos(self:GetPos())
					end
					self.ClientWorldModel:SetAngles(self:GetAngles())
				end
				self.ClientWorldModel:DrawModel()
				self.ClientWorldModel:DrawShadow(true)
			end
		end
	end
	
	function SWEP:Reload()
		local owner = self:GetOwner()
		if owner:IsNPC() then return false end
		if IsValid(self) and IsValid(owner) then
			if SERVER then
				local anims = Get(info,"AnimationInspect","")
				local vm = owner:GetViewModel()
				if not self.AttackWait and (not self.BlockWait or Get(info,"AutoBlock",false)) and not self.CoolAnim and anims ~= "" and IsValid(vm) then
					self.CoolAnim = true
					local anim, animwait = vm:LookupSequence(anims[math.random(1,#anims)])
					vm:SendViewModelMatchingSequence(anim)
					timerSimple(animwait,function()
						self.CoolAnim = false
						local idleanim = Get(info,"AnimationIdle","")
						if idleanim ~= "" then
							vm:SendViewModelMatchingSequence(vm:LookupSequence(idleanim))
						end
					end)
				end
			end
		end
	end
	
	function SWEP:CanPrimaryAttack() return true end
	
	function SWEP:PrimaryAttack()
		local owner = self:GetOwner()
		if IsValid(owner) and not SWEP.WaitDraw then
			local youragdoll = false
			local canattack = true
			
			if not GetConVar("wm_attackunderwater"):GetBool() then
				if owner:WaterLevel() >= 3 then
					canattack = false
				end
			end
			
			if not self.AttackWait and (not self.BlockWait or Get(info,"AutoBlock",false)) and not youragdoll and canattack then
				self.AttackWait = true
				
				local preattackfunctioninfo = Get(info,"PreAttackFunctionInfo",function(i) return i end)
				
				if GetConVar("wm_customfunctions"):GetBool() then
					info = preattackfunctioninfo(info)
					self.WMInfo = info
				end
				
				local addwait = 0
				local animstart_table = Get(info,"AnimationHit",{"Misscenter1","Misscenter2"})
				local animstart = animstart_table[math.random(1,#animstart_table)]
				local animend = Get(info,"AnimationHitEnd","")
				local _, wait2 = 0, 0
				if owner:IsPlayer() then
					local vm = owner:GetViewModel()
					if animend ~= "" then
						_, wait2 = vm:LookupSequence(animstart)
						wait2 = wait2 * Get(info,"AnimationHitEndScale",1)
						addwait = addwait + wait2
					end
					if SERVER then
						vm:SendViewModelMatchingSequence(vm:LookupSequence(animstart))
					end
					if animend ~= "" then
						timerSimple(wait2,function() 
							if SERVER then
								if ragmod then
									youragdoll = ragmod:IsRagdoll(owner)
								end
								if not youragdoll then
									if IsValid(self:GetOwner()) and IsValid(vm) then
										if self:GetOwner():GetActiveWeapon() == self then
											animend_, waitend = vm:LookupSequence(animend)
											vm:SendViewModelMatchingSequence(animend_)
											owner:SetAnimation(PLAYER_ATTACK1)
											timerSimple(waitend,function()
												local idleanim = Get(info,"AnimationIdle","")
												if IsValid(self) and IsValid(vm) then
													if idleanim ~= "" and not self.AttackWait and IsValid(self:GetOwner()) then
														if self:GetOwner():GetActiveWeapon() == self then
															vm:SendViewModelMatchingSequence(vm:LookupSequence(idleanim))
														end
													end
												end
											end)
										end
									end
								end
							end
						end)
					else
						owner:SetAnimation(PLAYER_ATTACK1)
						_, wait = vm:LookupSequence(animstart)
						timerSimple(wait,function()
							if SERVER then
								if ragmod then
									youragdoll = ragmod:IsRagdoll(owner)
								end
								local idleanim = Get(info,"AnimationIdle","")
								if not youragdoll and IsValid(self) then
									if idleanim ~= "" and not self.AttackWait and IsValid(owner) then
										if owner:GetActiveWeapon() == self then
											if IsValid(vm) then
												vm:SendViewModelMatchingSequence(vm:LookupSequence(idleanim))
											end
										end
									end
								end
							end
						end)
					end
				end
				
				local hitrays_ = Get(info,"Rays",{{Angle(0,0,0),0}})
				local raysdetails_convar = math.max(0,GetConVar("wm_hitsquality"):GetInt())
				local raysdetails = Get(info,"RaysDetails",1)+raysdetails_convar
				if owner:IsNPC() then
					raysdetails = 1+raysdetails_convar
				end
				local onlyoneray = Get(info,"OnlyOneRay",false)
				local hitrays = {}
				for i, r in pairs(hitrays_) do
					if hitrays_[i+1] ~= nil then
						local nextr = hitrays_[i+1]
						for j = 0, raysdetails do
							local newangle = LerpAngle(j/raysdetails,r[1],nextr[1])
							local newtimer = nextr[2]/raysdetails
							table.insert(hitrays,{newangle,newtimer,j ~= 0})
						end
					else
						table.insert(hitrays,r)
					end
				end
				
				if owner:IsPlayer() then
					local swingsounds = Get(info,"SwingSounds",{"weapons/melee/swing_heavy_blunt_01.wav","weapons/melee/swing_heavy_blunt_02.wav","weapons/melee/swing_heavy_blunt_03.wav"})
					if swingsounds ~= "empty" then
						timerSimple(Get(info,"SwingWait",0),function()
							if SERVER then
								local youragdoll = false
								if ragmod then
									youragdoll = ragmod:IsRagdoll(owner)
								end
								if not youragdoll and IsValid(self) then
									if IsValid(owner) then
										if owner:GetActiveWeapon() == self then
											owner:EmitSound( Sound(swingsounds[math.random(1,#swingsounds)]),50,math.random(90,110))
										end
									end	
								end	
							end
						end)
					end
				end
					if owner:IsNPC() then
						--owner:SetSchedule(SCHED_MELEE_ATTACK1)
					end
				timerSimple(Get(info,"AttackHitWait",0)+addwait, function()
					if SERVER then
						if IsValid(owner) and IsValid(self) then
							if owner:GetActiveWeapon()==self then
								local make_interim_hit_to_main_hit = GetConVar("wm_interimhittomain"):GetBool()
								if owner:IsPlayer() then
									local inertia = math.max(0,GetConVar("wm_inertiascale"):GetFloat()) * Get(info,"InertiaScale",1)
									if inertia ~= 0 then
										owner:SetLocalVelocity(owner:GetVelocity() + (owner:GetAimVector() * 100 * inertia) )
									end
									if GetConVar("wm_viewpunch"):GetBool() then
										local vp_ang = Get(info,"PunchAngle",Angle(10,0,0))
										local vp_ang_scale = GetConVar("wm_viewpunchscale"):GetFloat()
										vp_ang = Angle(vp_ang.p*vp_ang_scale,vp_ang.y*vp_ang_scale,vp_ang.r*vp_ang_scale)
										owner:ViewPunch(vp_ang)
									end
								end
								local t = 0
								local hitten = false
								local hasentityonrays = false
								if owner:IsPlayer() then
									for i, r in pairs(hitrays) do
										t = t + r[2]
										hasentityonrays = hasentityonrays or PreHit(owner,info,r[1])
									end
								end
								local afterhit = false
								for i, r in pairs(hitrays) do
									t = t + r[2]
									timerSimple(t,function()
										if ragmod and owner:IsPlayer() then
											youragdoll = ragmod:IsRagdoll(owner)
										end
										if not youragdoll then
											if r[3] ~= true and not onlyoneray then
												hitten = false
											end
											hitten = Hit(owner,info,r[1],hitten,i/#hitrays,hasentityonrays,afterhit)
											afterhit = afterhit or hitten
											if make_interim_hit_to_main_hit then
												hitten = false
											end
										end
									end)
								end
							end
						end
					end
				end)
				local attackwaitinfo = Get(info,"AttackWait",Vector(1,0,0))
				local randwait_ = attackwaitinfo.x+math.random(attackwaitinfo.y,attackwaitinfo.z)/100
				randwait_ = randwait_ * math.max(0,GetConVar("wm_attackwaitscale"):GetFloat())
				local randwait = randwait_+addwait
				timerSimple(randwait, function()
					self.AttackWait = false
					self.CoolAnim = false
				end)
			end
		end
	end
	
	function SWEP:CanSecondaryAttack() return false end
end

WMLib.Weapons = {}
WMLib.CreateMelee = function(swep,info,modid)
	if WMLib.Mods[modid] ~= nil then
		if swep ~= nil and info ~= nil then
			if string.match(swep.Folder, "^weapons/.+") then
				local class = string.match(swep.Folder, ".+/([^/]+)$")
				if string.sub(class,1,3) == "wm_" then
					local load_ = GetConVar("wm_enabled"):GetBool()
					if Get(info,"Funny",false) then
						if not GetConVar("wm_funny_weapons"):GetBool() then
							load_ = false
						end
					end
					local modinfo = WMLib.Mods[modid]
					modinfo["ID"] = modid
					info["Class"] = class
					info["Debug"] = string.sub(class,1,9) == "wm_debug_"
					if info["Debug"] and not GetConVar("wm_debug_weapons"):GetBool() then
						load_ = false
					end
					
					local hookinfo = hookRun("WM_WeaponLoad",swep,info,modid,class,info["Debug"],load_)
					load_ = IfNil(hookinfo,1,load_)
					info = IfNil(hookinfo,2,info)
					modid = IfNil(hookinfo,3,modid)
					info["Debug"] = IfNil(hookinfo,4,info["Debug"])
					
					if load_ and not info["Debug"] then
						table.insert(WMLib.Weapons,class)
					end
					LoadWMWeapon(swep,info,load_,modinfo)
				else
					e("Cannot load WM weapons because the class ["..swep.Folder..".lua] does not start with \"wm_\"! E1")
				end
			else
				e("Cannot load WM weapons because the class ["..swep.Folder..".lua] is not in the weapons hierarchy! E2")
			end
		else
			e("Cannot load WM weapons because there's no SWEP or weapon information loaded! E3")
		end
	else
		e("No modification with this id ["..tostring(modid).."] (type:"..type(modid)..") was found! E6")
	end
end

WMLib.GetRandomWeapon = function()
	if #WMLib.Weapons == 0 then return "wm_debug_default" end
	return WMLib.Weapons[math.random(1,#WMLib.Weapons)]
end

WMLib.DrawSphere = function(pos,size,lifetime,color,typ) 
	if pos == nil then pos = Vector(0,0,0) end
	if size == nil then size = 2 end
	if lifetime == nil then lifetime = 5 end
	if color == nil then color = Color(255,255,255) end
	if typ == nil then typ = "default" end
	DrawSphere(pos,size,lifetime,color,typ)
end

p("_________________________________________________________________________________")