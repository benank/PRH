--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("teleport")

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
    DisableBarriers("start_room_barrier")
    DisableBarriers("dr_left")
    DisableBarriers("circle_bar1")
    DisableBarriers("circle_bar2")
    
	AddDeathRegion("DeathRegion01")
	AddDeathRegion("DeathRegion02")
	AddDeathRegion("DeathRegion03")
	AddDeathRegion("DeathRegion04")
	AddDeathRegion("DeathRegion05")
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
	des1 = GetEntityMatrix("CP1")
	des2 = GetEntityMatrix("CP2")
	des3 = GetEntityMatrix("CP3")
	des4 = GetEntityMatrix("CP4")
	des5 = GetEntityMatrix("CP5")
	des6 = GetEntityMatrix("CP6")
	des7 = GetEntityMatrix("CP7")
	finalDestination = GetPathNodeDestination("boundary",3)
	print("test2")
	--CapturePosts            = 0
	SpawnCharacter(takerProps, des1)
	SpawnCharacter(takerProps2, des2)
	SpawnCharacter(takerProps3, des3)
	SpawnCharacter(takerProps4, des4)
	SpawnCharacter(takerProps5, des6)
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
	takerSeekers6 = GetTeamMember(2,12)
	SelectCharacterClass(takerSeekers1,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers2,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers3,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers4,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers5,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers6,"prh_inf_seeker")
	SpawnCharacter(takerSeekers1, des1)
	SpawnCharacter(takerSeekers2, des2)
	SpawnCharacter(takerSeekers3, des3)
	SpawnCharacter(takerSeekers4, des4)
	SpawnCharacter(takerSeekers5, des5)
	SpawnCharacter(takerSeekers6, des6)
end
	
	captureKiller = OnFinishCapture(function(post)
		if cpsCaptured1 == 0 then
			cpsCaptured = cpsCaptured + 1
		elseif cpsCaptured1 == 1 then
			cpsCaptured = cpsCaptured + 2
		end
		if cpsCaptured == 5 then
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
		if cpsCaptured == 12 then
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
			SetEntityMatrix(GetCharacterUnit(takerSeekers6), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers6))
			SetClassProperty("prh_inf_seeker", "CapturePosts", 0)
			readyToStart = 1
		end
			
	end)
		
	if (not ScriptCB_InMultiplayer()) then
		ShowObjectiveTextPopup("level.PRH.load", DEF)
		ShowObjectiveTextPopup("level.PRH.load", ATT)
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
--	OnTimerElapse(
--	    function(timer, player)
--		SpawnCharacter(player, GetPathPoint(CP7Spawn, 1))
--	    DestroyTimer(timer)
--	    end,
	--    second
--		)
--		kill = OnObjectKill( 
--			function(object, killer) 
		--		if killer and IsCharacterHuman(killer) and GetObjectTeam(object) == DEF then
--				if GetNumTeamMembersAlive(1) == 0 then
--					MissionVictory(2)
--					ReleaseObjectKill(kill)
--				end 
--			end 
--		) 
		------------------------------------------------------------------------------
  	--------------------------------- RELEASE THE HOUNDS SPAWN TIMER
	OnTimerElapse(
	    function(timer)
		ShowMessageText("level.PRH.seekerscanspawn")
		seekerCap()
	    DestroyTimer(timer)
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
		
            
    
    AddDeathRegion("deathregion")
    AddDeathRegion("deathregion2")
    AddDeathRegion("deathregion3")
    AddDeathRegion("deathregion4")
    AddDeathRegion("deathregion5")
    
 end
function ScriptInit()
    StealArtistHeap(800*1024)
    -- Designers, these two lines *MUST* be first.
    SetPS2ModelMemory(3500000)
    ReadDataFile("ingame.lvl")
    
    --  REP Attacking (attacker is always #1)
    local REP = 1
    local CIS = 2
    --  These variables do not change
    local ATT = 1
    local DEF = 2

    SetTeamAggressiveness(CIS, 1.0)
    SetTeamAggressiveness(REP, 1.0)

    SetMemoryPoolSize("Music", 40)

    ReadDataFile("sound\\geo.lvl;geo1cw")
    ReadDataFile("dc:sound\\tss.lvl;tssgcw")
    ReadDataFile("dc:SIDE\\prh.lvl",
                    "prh_inf_healthdroid",
                    "prh_inf_ammodroid",
                    "prh_inf_geo_bldg_stonespire_1",
                    "prh_inf_geo_bldg_stonespire_4",
                    "prh_inf_seeker",
                    "prh_inf_geo_prop_boulder_2",
                    "prh_inf_geo_prop_cliff_stones_1")
    ReadDataFile("SIDE\\rep.lvl",
                             "rep_fly_assault_dome",
                             "rep_fly_gunship_dome",
                             "rep_fly_jedifighter_dome",
                             "rep_walk_atte")
                             
    ReadDataFile("SIDE\\cis.lvl",
                             "cis_fly_droidfighter_dome",
                             "cis_tread_hailfire",
                             --"cis_hover_stap",
                             "cis_walk_spider")
	ReadDataFile("SIDE\\tur.lvl",
                             "tur_bldg_geoturret")
                    
                

    SetupTeams{

        rep={
            team = REP,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_healthdroid",0, 0},
            assault = {"prh_inf_ammodroid",0, 0},
            engineer = {"",0, 0},
            sniper  = {"prh_inf_geo_bldg_stonespire_1",0, 0},
            officer = {"prh_inf_geo_bldg_stonespire_4",0, 0},
            special = {"prh_inf_geo_prop_boulder_2",0, 0},
            marine = {"prh_inf_geo_prop_cliff_stones_1",0, 0},
            pilot = {"",1, 4},
            
        },
        
        cis={
            team = CIS,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_seeker",0, 0},
            

        }
    }


    --  Level Stats

    ClearWalkers()
    SetMemoryPoolSize("EntityWalker", -1)
    AddWalkerType(0, 3) -- 8 droidekas (special case: 0 leg pairs)
    AddWalkerType(2, 3) -- 2 spider walkers with 2 leg pairs each
    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponcnt = 240
    SetMemoryPoolSize("Aimer", 50)
    SetMemoryPoolSize("AmmoCounter", weaponcnt)
    SetMemoryPoolSize("BaseHint", 100)
    SetMemoryPoolSize("CommandWalker", 1)
    SetMemoryPoolSize("EnergyBar", weaponcnt)
    SetMemoryPoolSize("EntityFlyer", 6)
    SetMemoryPoolSize("EntityHover", 9)
    SetMemoryPoolSize("EntityLight", 50)
    SetMemoryPoolSize("EntitySoundStream", 4)
    SetMemoryPoolSize("MountedTurret", 10)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 450)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 100)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("SoldierAnimation", 500)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponcnt)



    --  Attacker Stats
    
    --teamATT = ConquestTeam:New{team = ATT}
    --teamATT:AddBleedThreshold(21, 0.75)
    --teamATT:AddBleedThreshold(11, 2.25)
    --teamATT:AddBleedThreshold(1, 3.0)
    --teamATT:Init()
  --  SetTeamAsEnemy(ATT,3)
 --   SetTeamAsEnemy(3,ATT)

    --  Defender Stats
    
    --teamDEF = ConquestTeam:New{team = DEF}
    --teamDEF:AddBleedThreshold(21, 0.75)
    --teamDEF:AddBleedThreshold(11, 2.25)
    --teamDEF:AddBleedThreshold(1, 3.0)
    --teamDEF:Init()
   -- SetTeamAsFriend(DEF,3)

    --  Local Stats
  --  SetTeamName(3, "locals")
  --  SetUnitCount(3, 7)
  --  AddUnitClass(3, "geo_inf_geonosian", 7)    
 --   SetTeamAsFriend(3, DEF)
    --SetTeamName(4, "locals")
    --AddUnitClass(4, "rep_inf_jedimale",1)
    --AddUnitClass(4, "rep_inf_jedimaleb",1)
    --AddUnitClass(4, "rep_inf_jedimaley",1)
    --SetUnitCount(4, 3)
    --SetTeamAsFriend(4, ATT)

    ReadDataFile("GEO\\geo1.lvl", "geo1_conquest")

    SetDenseEnvironment("false")
    SetMinFlyHeight(-65)
    SetMaxFlyHeight(50)
    SetMaxPlayerFlyHeight(50)



    --  Birdies
    --SetNumBirdTypes(1)
    --SetBirdType(0.0,10.0,"dragon")
    --SetBirdFlockMinHeight(90.0)

    --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\geo.lvl",  "geo1cw")
    OpenAudioStream("sound\\geo.lvl",  "geo1cw")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(1, "repleaving")
    SetOutOfBoundsVoiceOver(2, "cisleaving")

    SetAmbientMusic(REP, 1.0, "rep_GEO_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_GEO_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "rep_GEO_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_GEO_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_GEO_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2, "cis_GEO_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_geo_amb_victory")
    SetDefeatMusic (REP, "rep_geo_amb_defeat")
    SetVictoryMusic(CIS, "cis_geo_amb_victory")
    SetDefeatMusic (CIS, "cis_geo_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")


    --ActivateBonus(CIS, "SNEAK_ATTACK")
    --ActivateBonus(REP, "SNEAK_ATTACK")

    SetAttackingTeam(ATT)

    --Opening Satalite Shot
    --Geo
    --Mountain
    AddCameraShot(0.996091, 0.085528, -0.022005, 0.001889, -6.942698, -59.197201, 26.136919)
    --Wrecked Ship
    AddCameraShot(0.906778, 0.081875, -0.411906, 0.037192, 26.373968, -59.937874, 122.553581)
    --War Room  
    --AddCameraShot(0.994219, 0.074374, 0.077228, -0.005777, 90.939568, -49.293945, -69.571136)
end

