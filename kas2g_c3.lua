--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("teleport")

    --  Empire Attacking (attacker is always #1)
    REP = 1
    CIS = 2
    --  These variables do not change
    ATT = 1
    DEF = 2
    

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

	AddDeathRegion("deathregion")
	AddDeathRegion("deathregion2")
 
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
--	test = CreateTimer("test")
--	SetTimerValue(test, 10) 
--				StartTimer(test)
	
	spawn = CreateTimer("spawn")
	SetTimerValue(spawn, 60)
	SetTimerValue(dead, 1)
	
	SetClassProperty("com_bldg_controlzone", "NeutralizeTime", "0.001")
	SetClassProperty("com_bldg_controlzone", "CaptureTime", "0.001")
	takerProps = GetTeamMember(1,7)
	takerProps2 = GetTeamMember(1,8)
	SelectCharacterClass(takerProps,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps2,"prh_inf_healthdroid")
	print("test1")
	des1 = GetEntityMatrix("CP1CON")
	des2 = GetEntityMatrix("CP3CON")
	des3 = GetEntityMatrix("CP4CON")
	des4 = GetEntityMatrix("CP5CON")
	finalDestination = GetPathNodeDestination("wookie",0)
	print("test2")
	--CapturePosts            = 0
	SpawnCharacter(takerProps, des1)
	SpawnCharacter(takerProps2, des2)
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
	SelectCharacterClass(takerSeekers1,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers2,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers3,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers4,"prh_inf_seeker")
	SpawnCharacter(takerSeekers1, des1)
	SpawnCharacter(takerSeekers2, des2)
	SpawnCharacter(takerSeekers3, des3)
	SpawnCharacter(takerSeekers4, des4)
end
	
	captureKiller = OnFinishCapture(function(post)
		if cpsCaptured1 == 0 then
			cpsCaptured = cpsCaptured + 1.1
		elseif cpsCaptured1 == 1 then
			cpsCaptured = cpsCaptured + 2
		end
		if cpsCaptured == 2.2 then
			print("tp and kill")
			SetEntityMatrix(GetCharacterUnit(takerProps), finalDestination)
			KillObject(GetCharacterUnit(takerProps))
			SetEntityMatrix(GetCharacterUnit(takerProps2), finalDestination)
			KillObject(GetCharacterUnit(takerProps2))
			SetClassProperty("prh_inf_healthdroid", "CapturePosts", 0)
			cpsCaptured = 0
			cpsCaptured1 = 1
		end
		if cpsCaptured == 8 then
			print("seekers")
			SetEntityMatrix(GetCharacterUnit(takerSeekers1), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers1))
			SetEntityMatrix(GetCharacterUnit(takerSeekers2), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers2))
			SetEntityMatrix(GetCharacterUnit(takerSeekers3), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers3))
			SetEntityMatrix(GetCharacterUnit(takerSeekers4), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers4))
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
--				SpawnCharacter(character,destination)
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
			print("4")
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
		
    SetProperty("woodl", "MaxHealth", 15000)
    SetProperty("woodl", "CurHealth", 15000)
    SetProperty("woodr", "MaxHealth", 15000)
    SetProperty("woodr", "CurHealth", 15000)
    SetProperty("woodc", "MaxHealth", 15000)
    SetProperty("woodc", "CurHealth", 15000)
    SetProperty("gatepanel", "MaxHealth", 1000)
    SetProperty("gatepanel", "CurHealth", 1000)
    
    
     OnObjectKillName(PlayAnimDown, "gatepanel");
     OnObjectRespawnName(PlayAnimUp, "gatepanel");
     OnObjectKillName(woodl, "woodl");
     OnObjectKillName(woodc, "woodc");
     OnObjectKillName(woodr, "woodr");
     OnObjectRespawnName(woodlr, "woodl");
     OnObjectRespawnName(woodcr, "woodc");
     OnObjectRespawnName(woodrr, "woodr");
 end
 
 function PlayAnimDown()
    PauseAnimation("thegateup");
    RewindAnimation("thegatedown");
    PlayAnimation("thegatedown");
    ShowMessageText("level.kas2.objectives.gateopen",1)
    ScriptCB_SndPlaySound("KAS_obj_13")
    SetProperty("gatepanel", "MaxHealth", 2200)
--    SetProperty("gatepanel", "CurHealth", 50000)
--    PlayAnimation("gatepanel");
    --SetProperty("gatepanel", "MaxHealth", 1e+37)
    --SetProperty("gatepanel", "CurHealth", 1e+37)
      
            
      
end

function PlayAnimUp()
    PauseAnimation("thegatedown");
    RewindAnimation("thegateup");
    PlayAnimation("thegateup");
      
            
end

function woodl()
    UnblockPlanningGraphArcs("woodl");
    DisableBarriers("woodl");
    SetProperty("woodl", "MaxHealth", 1800)
--    SetProperty("woodl", "CurHealth", 15)
end
    
function woodc()
    UnblockPlanningGraphArcs("woodc");
    DisableBarriers("woodc");
    SetProperty("woodc", "MaxHealth", 1800)
--    SetProperty("woodc", "CurHealth", 15)
end
    
function woodr()
    UnblockPlanningGraphArcs("woodr");
    DisableBarriers("woodr");
    SetProperty("woodr", "MaxHealth", 1800)
--    SetProperty("woodr", "CurHealth", 15)
end

function woodlr()
	BlockPlanningGraphArcs("woodl")
	EnableBarriers("woodl")
	SetProperty("woodl", "MaxHealth", 15000)
    SetProperty("woodl", "CurHealth", 15000)
end
	
function woodcr()
	BlockPlanningGraphArcs("woodc")
	EnableBarriers("woodc")
	SetProperty("woodc", "MaxHealth", 15000)
    SetProperty("woodc", "CurHealth", 15000)
end

function woodrr()
	BlockPlanningGraphArcs("woodr")
	EnableBarriers("woodr")
	SetProperty("woodr", "MaxHealth", 15000)
    SetProperty("woodr", "CurHealth", 15000)
end

function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(800 * 1024)
    SetPS2ModelMemory(3535000)
    ReadDataFile("dc:ingame.lvl")
    ReadDataFile("ingame.lvl")
    

    SetMaxFlyHeight(70)

    ReadDataFile("sound\\kas.lvl;kas2cw")
    ReadDataFile("dc:sound\\tss.lvl;tssgcw")
    ReadDataFile("SIDE\\rep.lvl",
                                "rep_hover_fightertank",
                                "rep_fly_cat_dome",
                                "rep_hover_barcspeeder")
    ReadDataFile("SIDE\\cis.lvl",
                             "cis_tread_snailtank",
                             "cis_hover_stap",
                             "cis_walk_spider")
	ReadDataFile("SIDE\\tur.lvl",
							"tur_bldg_beam",
							"tur_bldg_recoilless_kas")
							
    ReadDataFile("dc:SIDE\\prh.lvl",
                    "prh_inf_healthdroid",
                    "prh_inf_ammodroid",
                    "prh_inf_kas2_prop_tech_pillar_2",
                    "prh_inf_seeker",
                    "prh_inf_kas2_prop_rock_L",
                    "prh_inf_kas2_prop_rock_M",
                    "prh_inf_kas2_prop_holotable")
							
    SetupTeams{

        rep={
            team = REP,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_healthdroid",0, 0},
            assault = {"prh_inf_ammodroid",0, 0},
            engineer = {"prh_inf_kas2_prop_holotable",0, 0},
            sniper  = {"prh_inf_kas2_prop_tech_pillar_2",0, 0},
            officer = {"prh_inf_kas2_prop_rock_L",0, 0},
            special = {"prh_inf_kas2_prop_rock_M",0, 0},
            
            
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
    AddWalkerType(0, 6) -- 4 droidekas (special case: 0 leg pairs)
    AddWalkerType(1, 0) --
--    AddWalkerType(2, 2) -- 2 spider walkers with 2 leg pairs each
    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponCnt = 230
    SetMemoryPoolSize("Aimer", 70)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 220)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityHover", 11)
    SetMemoryPoolSize("EntityLight", 40)
    SetMemoryPoolSize("EntityCloth", 58)
    SetMemoryPoolSize("EntityFlyer", 6)
    SetMemoryPoolSize("EntitySoundStream", 3)
    SetMemoryPoolSize("SoldierAnimation", 750)
    SetMemoryPoolSize("EntitySoundStatic", 120)
    SetMemoryPoolSize("MountedTurret", 15)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 300)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 512)
    SetMemoryPoolSize("TentacleSimulator", 8)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("KAS\\kas2.lvl", "kas2_con")
    SetDenseEnvironment("false")
    
    SetMaxFlyHeight(65)
    SetMaxPlayerFlyHeight(65)

    --  Birdies
    SetNumBirdTypes(1)
    SetBirdType(0,1.0,"bird")

    --  Fishies
    SetNumFishTypes(1)
    SetFishType(0,0.8,"fish")

    --  Local Stats
    --SetTeamName(3, "locals")
    --SetTeamIcon(3, "all_icon")
    --AddUnitClass(3, "wok_inf_warrior", 3)
    --AddUnitClass(3, "wok_inf_rocketeer", 2)
    --AddUnitClass(3, "wok_inf_mechanic", 2)
    --SetUnitCount(3, 7)
    --SetTeamAsEnemy(3,DEF)
    --SetTeamAsFriend(3,ATT)

    --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)   
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_quick", voiceQuick) 

    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\kas.lvl",  "kas")
    OpenAudioStream("sound\\kas.lvl",  "kas")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetAmbientMusic(REP, 1.0, "rep_kas_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_kas_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_kas_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_kas_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_kas_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_kas_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_kas_amb_victory")
    SetDefeatMusic (REP, "rep_kas_amb_defeat")
    SetVictoryMusic(CIS, "cis_kas_amb_victory")
    SetDefeatMusic (CIS, "cis_kas_amb_defeat")

    SetOutOfBoundsVoiceOver(1, "repleaving")
    SetOutOfBoundsVoiceOver(2, "cisleaving")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

    SetAttackingTeam(ATT)


	
	AddCameraShot(0.599996, 0.199788, -0.734979, 0.244735, 90.485336, 33.195667, -79.602295);


end
