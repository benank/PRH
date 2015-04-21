--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("teleport")

    --  Empire Attacking (attacker is always #1)
    ALL = 1
    IMP = 2
    --  These variables do not change
    ATT = 2
    DEF = 1


---------------------------------------------------------------------------
-- FUNCTION:    ScriptInit
-- PURPOSE:     This function is only run once
-- INPUT:
-- OUTPUT:
-- NOTES:       The name, 'ScriptInit' is a chosen convention, and each
--              mission script must contain a version of this function, as
--              it is called from C to start the mission.
---------------------------------------------------------------------------

function ScriptPostLoad()

	AddDeathRegion("fall")
	DisableBarriers("atat")
	DisableBarriers("bombbar")

	--SetProperty("SHIELD", "SpawnPath", "")
	--SetProperty("SHIELD", "Team", "0")
	KillObject("SHIELD")

    
	------------------------- SETUP THE FIRST FEW TIMERS
	dead = CreateTimer("dead")
	win = CreateTimer("win")
	SetTimerValue(win, 300) 
	
	cool1 = CreateTimer("cool1")
	SetTimerValue(cool1, 30) 
	cool2 = CreateTimer("cool2")
	SetTimerValue(cool2, 120) 
	cool3 = CreateTimer("cool3")
	SetTimerValue(cool3, 180) 
	cool4 = CreateTimer("cool4")
	SetTimerValue(cool4, 240) 
	cool5 = CreateTimer("cool5")
	SetTimerValue(cool5, 270) 
	cool6 = CreateTimer("cool6")
	SetTimerValue(cool6, 285) 
	cool7 = CreateTimer("cool7")
	SetTimerValue(cool7, 295) 
	
	alive = CreateTimer("alive")
	SetTimerValue(alive, 1) 
	
	spawn = CreateTimer("spawn")
	SetTimerValue(spawn, 60)
	SetTimerValue(dead, 1)
	
	
	SetClassProperty("com_bldg_controlzone", "NeutralizeTime", "0.001")
	SetClassProperty("com_bldg_controlzone", "CaptureTime", "0.001")
	takerProps = GetTeamMember(1,7)
	takerProps2 = GetTeamMember(1,8)
	takerProps3 = GetTeamMember(1,9)
	takerProps4 = GetTeamMember(1,10)
	takerProps5 = GetTeamMember(1,11)
	SelectCharacterClass(takerProps,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps2,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps3,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps4,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps5,"prh_inf_healthdroid")
	print("test1")
	des1 = GetEntityMatrix("CP3")
	des2 = GetEntityMatrix("CP4")
	des3 = GetEntityMatrix("CP5")
	des4 = GetEntityMatrix("CP6")
	des5 = GetEntityMatrix("CP7")
	finalDestination = GetPathNodeDestination("ProbeDroid_Spawn",2)
	print("test2")
	--CapturePosts            = 0
	SpawnCharacter(takerProps, des1)
	SpawnCharacter(takerProps2, des2)
	SpawnCharacter(takerProps3, des3)
	SpawnCharacter(takerProps4, des4)
	SpawnCharacter(takerProps5, des5)
	SetClassProperty("prh_inf_healthdroid", "CapturePosts", 1)
	cpsCaptured = 0
	cpsCaptured1 = 0
	readyToStart = 0
	
function seekerCap()
	readyToStart = 0
	SetClassProperty("prh_inf_seeker", "CapturePosts", 1)
	takerSeekers1 = GetTeamMember(2,7)
	takerSeekers2 = GetTeamMember(2,8)
	takerSeekers3 = GetTeamMember(2,9)
	takerSeekers4 = GetTeamMember(2,10)
	takerSeekers5 = GetTeamMember(2,11)
	SelectCharacterClass(takerSeekers1,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers2,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers3,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers4,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers5,"prh_inf_seeker")
	SpawnCharacter(takerSeekers1, des1)
	SpawnCharacter(takerSeekers2, des2)
	SpawnCharacter(takerSeekers3, des3)
	SpawnCharacter(takerSeekers4, des4)
	SpawnCharacter(takerSeekers5, des5)
end
	
	captureKiller = OnFinishCapture(function(post)
		if cpsCaptured1 == 0 then
			cpsCaptured = cpsCaptured + 1.5
		elseif cpsCaptured1 == 1 then
			cpsCaptured = cpsCaptured + 2
		end
		if cpsCaptured == 7.5 then
			print("tp and kill")
			SetEntityMatrix(GetCharacterUnit(takerProps), finalDestination)
			KillObject(GetCharacterUnit(takerProps))
			SetEntityMatrix(GetCharacterUnit(takerProps2), finalDestination)
			KillObject(GetCharacterUnit(takerProps2))
			SetEntityMatrix(GetCharacterUnit(takerProps3), finalDestination)
			KillObject(GetCharacterUnit(takerProps3))
			SetEntityMatrix(GetCharacterUnit(takerProps4), finalDestination)
			KillObject(GetCharacterUnit(takerProps4))
			SetEntityMatrix(GetCharacterUnit(takerProps5), finalDestination)
			KillObject(GetCharacterUnit(takerProps5))
			SetClassProperty("prh_inf_healthdroid", "CapturePosts", 0)
			cpsCaptured = 0
			cpsCaptured1 = 1
		end
		if cpsCaptured == 10 then
			print("seekers")
			SetEntityMatrix(GetCharacterUnit(takerSeekers1), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers1))
			SetEntityMatrix(GetCharacterUnit(takerSeekers2), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers2))
			SetEntityMatrix(GetCharacterUnit(takerSeekers3), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers3))
			SetEntityMatrix(GetCharacterUnit(takerSeekers4), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers4))
			SetEntityMatrix(GetCharacterUnit(takerSeekers5), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers5))
			SetClassProperty("prh_inf_seeker", "CapturePosts", 0)
			readyToStart = 1
		end
			
	end)
		
	if (not ScriptCB_InMultiplayer()) then
		ShowObjectiveTextPopup("level.PRH.load", DEF)
		ShowObjectiveTextPopup("level.PRH.load", ATT)
	end
	if ScriptCB_InMultiplayer() then
		death4ever = OnObjectKill(function(object, killer)
			if GetObjectTeam(object) == 1 then
				SetEntityMatrix(object, finalDestination)
			end
			DeactivateObject(object)
		end)
	end

		ScriptCB_SetCanSwitchSides(1)
		
	ccPlayer = nil
	ccMatrix = nil
	classTo = nil
	playerCurHp = nil
	-- -nogamemodel
	SetClassProperty("prh_inf_dea1_crate", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_dea1_barrel", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_healthdroid", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_ammodroid", "PointsToUnlock", "9999")


	ClassSwitcher = OnObjectDamage(function(object, damager)
		print("damage")
		if GetObjectLastHitWeaponClass(object) == "prh_weap_inf_interact" then
			ccPlayer = damager
			print(GetEntityName(object))
			if GetEntityClassName(object) == "dea1_prop_crate_1" then
				classTo = "prh_inf_dea1_crate"
				print("crate")
				changeClass()
			end
			objects = {}
			for i=1,40 do
				objects[i] = "com_item_hero_healthrecharge"..i
				if GetEntityName(object) == objects[i] then
					classTo = "prh_inf_healthdroid"
					print("hpdroid")
					changeClass()
				end
			end
			objects2 = {}
			for i=1,70 do
				objects2[i] = "dea1_prop_barrel_"..i
				if GetEntityName(object) == objects2[i] then
					classTo = "prh_inf_dea1_barrel"
					print("hpdroid")
					changeClass()
				end
			end
			objects3 = {}
			for i=1,40 do
				objects3[i] = "com_item_weaponrecharge"..i
				if GetEntityName(object) == objects3[i] then
				classTo = "prh_inf_ammodroid"
				print("hpdroid")
				changeClass()
				end
			end
		end
	end)
	
function changeClass()
	print("changeClass")
	readyToStart = 0
	playerCurHp = GetObjectHealth(GetCharacterUnit(ccPlayer))
	ccMatrix = GetEntityMatrix(GetCharacterUnit(ccPlayer))
	print("cc1")
	SetEntityMatrix(GetCharacterUnit(ccPlayer), finalDestination) --teleport the guy away
	print("cc2")
	KillObject(GetCharacterUnit(ccPlayer)) --kill them
	print("cc3")
	SetClassProperty(classTo, "PointsToUnlock", "0")
	SelectCharacterClass(ccPlayer, classTo) --pick their new class
	print("cc3.5")
	SpawnCharacter(ccPlayer, ccMatrix) --spawn them back
	SetClassProperty(classTo, "PointsToUnlock", "9999")
	print("cc4")
	SetProperty(GetCharacterUnit(ccPlayer), "CurHealth", playerCurHp)
	readyToStart = 1
end
	
-------------------------------------------------- ONCE THE FIRST ONE SPAWNS START THE TIMERS
      onfirstspawn = OnCharacterSpawn(
        function(character)
            if IsCharacterHuman(character) then
                ReleaseCharacterSpawn(onfirstspawn)
                onfirstspawn = nil
				StartTimer(cool1)
				StartTimer(cool2)
				StartTimer(cool3)
				StartTimer(cool4)
				StartTimer(cool5)
				StartTimer(cool6)
				StartTimer(cool7)
            	StartTimer(spawn)
            	StartTimer(win)
				ShowTimer(win)
				readyToStart = 1
             end
        end
		)
		------------------------------------------------------------------------------
  	--------------------------------- RELEASE THE HOUNDS SPAWN TIMER
	OnTimerElapse(
	    function(timer)
			ShowMessageText("level.PRH.seekerscanspawn")
			seekerCap()
	    end,
	    spawn
		)
		-------------------------------------------------------
    ------------------------------------- VICTORY TIMER
	OnTimerElapse(
	    function(timer)
		MissionVictory(1)
		DestroyTimer(timer)
	    end,
	    win
		)
		
	-------------------------------------
		----------------------------------------------------CHECKING IF THEY ARE DEAD TIMER AND IF THEY ARE GIVE THE OTHER PEOPLE VICTORY
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.30seek")
		DestroyTimer(timer)
	    end,
	    cool1
		)
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.3minsleft")
		DestroyTimer(timer)
	    end,
	    cool2
		)
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.2minsleft")
		DestroyTimer(timer)
	    end,
	    cool3
		)
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.1minleft")
		DestroyTimer(timer)
	    end,
	    cool4
		)
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.30secsleft")
		DestroyTimer(timer)
	    end,
	    cool5
		)
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.15secsleft")
		DestroyTimer(timer)
	    end,
	    cool6
		)
		
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.5secsleft")
		DestroyTimer(timer)
	    end,
	    cool7
		)
		
	deathChecker = OnCharacterDeath(function(character, killer)
		if ScriptCB_InMultiplayer() then
			if GetNumTeamMembersAlive(1) == 0 and readyToStart == 1 then
				MissionVictory(2)
			elseif GetNumTeamMembersAlive(2) == 0 and readyToStart == 1 then
				MissionVictory(1)
			end
		end
	end)
		
 end

function ScriptInit()
	if(ScriptCB_GetPlatform() == "PS2") then
        StealArtistHeap(1024*1024)	-- steal 1MB from art heap
    end
    
    -- Designers, these two lines *MUST* be first.
    --SetPS2ModelMemory(4500000)
    SetPS2ModelMemory(3300000)
    ReadDataFile("dc:ingame.lvl")
    ReadDataFile("ingame.lvl")
    
    --  Empire Attacking (attacker is always #1)
    --local ALL = 2
    --local IMP = 1
    --  These variables do not change
    --local ATT = 1
    --local DEF = 2

    --SetAttackingTeam(ATT)


    SetMaxFlyHeight(70)
    SetMaxPlayerFlyHeight(70)
    SetGroundFlyerMap(1);

    ReadDataFile("sound\\hot.lvl;hot1gcw")
    ReadDataFile("dc:sound\\tss.lvl;tssgcw")
    ReadDataFile("SIDE\\all.lvl",
                             "all_fly_snowspeeder",
                             "all_inf_rifleman_snow",
                             "all_inf_rocketeer_snow",
                             "all_inf_engineer_snow",
                             "all_inf_sniper_snow",
                             "all_inf_officer_snow",
                             "all_hero_luke_pilot",
                             "all_inf_wookiee_snow",
                             "all_walk_tauntaun")
    ReadDataFile("SIDE\\imp.lvl",
                             "imp_inf_rifleman_snow",
                             "imp_inf_rocketeer_snow",
                             "imp_inf_sniper_snow",
                             "imp_inf_dark_trooper",
                             "imp_inf_engineer_snow",
                             "imp_inf_officer",
                             "imp_hero_darthvader",
                             "imp_walk_atat",
                             "imp_walk_atst_snow")
                             
    ReadDataFile("SIDE\\tur.lvl",
						     "tur_bldg_hoth_dishturret",
						     "tur_bldg_hoth_lasermortar")
                            
    ReadDataFile("dc:SIDE\\prh.lvl",
                    "prh_inf_healthdroid",
                    "prh_inf_ammodroid",
                    "prh_inf_all_fly_snowspeeder",
                    "prh_inf_hoth_bldg_dish_turret",
                    "prh_inf_hoth_prop_crate_3",
                    "prh_inf_hoth_prop_command_console_a",
                    "prh_inf_seeker")
					
    SetupTeams{

        all={
            team = ALL,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_healthdroid",0, 0},
            assault = {"prh_inf_ammodroid",0, 0},
            engineer   = {"prh_inf_all_fly_snowspeeder",0, 0},
            sniper  = {"prh_inf_hoth_bldg_dish_turret",0, 0},
            officer = {"prh_inf_hoth_prop_crate_3",0, 0},
            special = {"prh_inf_hoth_prop_command_console_a",0, 0},
            
        },
        
        imp={
            team = IMP,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_seeker",0, 0},
            assault = {"",0, 0},
            engineer   = {"",0, 0},
            sniper  = {"",0, 0},
            officer = {"",0, 0},
            special = {"",0, 0},
        }
    }


--Setting up Heros--

   
       --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 0) -- 0 droidekas
    AddWalkerType(1, 5) -- 6 atsts with 1 leg pairs each
    AddWalkerType(2, 2) -- 2 atats with 2 leg pairs each

	local weaponCnt = 221
    SetMemoryPoolSize("Aimer", 80)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 175)
    SetMemoryPoolSize("CommandWalker", 2)
    SetMemoryPoolSize("ConnectivityGraphFollower", 56)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityCloth", 41)
    SetMemoryPoolSize("EntityFlyer", 10)
    SetMemoryPoolSize("EntityLight", 110)
    SetMemoryPoolSize("EntitySoundStatic", 16)
    SetMemoryPoolSize("EntitySoundStream", 5)
	SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 54)
    SetMemoryPoolSize("MountedTurret", 30)
    SetMemoryPoolSize("Navigator", 63)
    SetMemoryPoolSize("Obstacle", 400)
  SetMemoryPoolSize("OrdnanceTowCable", 40) -- !!!! need +4 extra for wrapped/fallen cables !!!!
    SetMemoryPoolSize("PathFollower", 63)
	SetMemoryPoolSize("PathNode", 128)
	SetMemoryPoolSize("ShieldEffect", 0)
	SetMemoryPoolSize("ParticleTransformer::SizeTransf", 1500)
	SetMemoryPoolSize("SoldierAnimation", 700)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("UnitController", 63)
    SetMemoryPoolSize("UnitAgent", 63)
    SetMemoryPoolSize("Weapon", weaponCnt)

    ReadDataFile("HOT\\hot1.lvl", "hoth_conquest")
    --ReadDataFile("tan\\tan1.lvl", "tan1_obj")
    SetSpawnDelay(10.0, 0.25)
    SetDenseEnvironment("false")
    SetDefenderSnipeRange(170)
    AddDeathRegion("Death")


    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\hot.lvl", "hot1gcw")
    OpenAudioStream("sound\\hot.lvl", "hot1gcw")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .75, 1)
    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .5, 1)
    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .25, 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(2, "Allleaving")
    SetOutOfBoundsVoiceOver(1, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_hot_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_hot_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_hot_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_hot_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_hot_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_hot_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_hot_amb_victory")
    SetDefeatMusic (ALL, "all_hot_amb_defeat")
    SetVictoryMusic(IMP, "imp_hot_amb_victory")
    SetDefeatMusic (IMP, "imp_hot_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")


    --  Camera Stats
    --Hoth
    --Hangar
	AddCameraShot(0.621563, 0.130957, -0.755749, 0.159229, -360.420441, 42.556942, -358.410461);

end
