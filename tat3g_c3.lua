--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("teleport")

---------------------------------------------------------------------------
-- ScriptPostLoad
---------------------------------------------------------------------------
function ScriptPostLoad()
    DisableBarriers("start_room_barrier")
    DisableBarriers("dr_left")
    DisableBarriers("circle_bar1")
    DisableBarriers("circle_bar2")
    
	----AddDeathRegion("DeathRegion01")
	--AddDeathRegion("DeathRegion02")
	--AddDeathRegion("DeathRegion03")
	--AddDeathRegion("DeathRegion04")
	--AddDeathRegion("DeathRegion05")
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
	SelectCharacterClass(takerProps,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps2,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps3,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps4,"prh_inf_healthdroid")
	print("test1")
	des1 = GetEntityMatrix("CP1")
	des2 = GetEntityMatrix("CP2")
	des3 = GetEntityMatrix("CP3")
	des4 = GetEntityMatrix("CP4")
	des5 = GetEntityMatrix("CP5")
	finalDestination = GetPathNodeDestination("boundary",1)
	print("test2")
	--CapturePosts            = 0
	SetClassProperty("com_bldg_major_controlzone", "NeutralizeTime", "0.001")
	SetClassProperty("com_bldg_major_controlzone", "CaptureTime", "0.001")
	SpawnCharacter(takerProps, des2)
	SpawnCharacter(takerProps2, des3)
	SpawnCharacter(takerProps3, des4)
	SpawnCharacter(takerProps4, des5)
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
			cpsCaptured = cpsCaptured + 1.1
		elseif cpsCaptured1 == 1 then
			cpsCaptured = cpsCaptured + 2
		end
		if cpsCaptured == 4.4 then
			print("tp and kill")
			SetEntityMatrix(GetCharacterUnit(takerProps), finalDestination)
			KillObject(GetCharacterUnit(takerProps))
			SetEntityMatrix(GetCharacterUnit(takerProps2), finalDestination)
			KillObject(GetCharacterUnit(takerProps2))
			SetEntityMatrix(GetCharacterUnit(takerProps3), finalDestination)
			KillObject(GetCharacterUnit(takerProps3))
			SetEntityMatrix(GetCharacterUnit(takerProps4), finalDestination)
			KillObject(GetCharacterUnit(takerProps4))
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
		
            
end

---------------------------------------------------------------------------
-- ScriptInit
---------------------------------------------------------------------------
function ScriptInit()
    StealArtistHeap(700*1024)   -- steal from art heap
    
    -- Designers, these two lines *MUST* be first!
    SetPS2ModelMemory(4087000)
    ReadDataFile("dc:ingame.lvl")
    ReadDataFile("ingame.lvl")

	--	Empire Attacking (attacker is always #1)
	local REP = 1
	local CIS = 2
	--	These variables do not change
	local ATT = 1
	local DEF = 2


	-- Memory settings ---------------------------------------------------------------------
	SetMemoryPoolSize("Combo::Condition", 100)
    SetMemoryPoolSize("Combo::State", 160)
    SetMemoryPoolSize("Combo::Transition", 100)
	local weaponCnt = 190
	SetMemoryPoolSize("ActiveRegion", 8)
	SetMemoryPoolSize("Aimer", 10)
	SetMemoryPoolSize("AmmoCounter", weaponCnt)
	SetMemoryPoolSize("BaseHint", 105)
	SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityCloth", 17)
	SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
	SetMemoryPoolSize("EntityLight", 141)
	SetMemoryPoolSize("EntitySoundStatic", 3)
	SetMemoryPoolSize("EntitySoundStream", 2)
	SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 50)
	SetMemoryPoolSize("MountedTurret", 1)
	SetMemoryPoolSize("Navigator", 35)
	SetMemoryPoolSize("Obstacle", 200)
	SetMemoryPoolSize("SoldierAnimation", 500)
	SetMemoryPoolSize("PathNode", 196)
	SetMemoryPoolSize("PathFollower", 35)
	SetMemoryPoolSize("RedOmniLight", 146) 
	SetMemoryPoolSize("SoundSpaceRegion", 80)
	SetMemoryPoolSize("TentacleSimulator", 12)
	SetMemoryPoolSize("TreeGridStack", 75)
	SetMemoryPoolSize("UnitAgent", 35)
	SetMemoryPoolSize("UnitController", 35)
	SetMemoryPoolSize("Weapon", weaponCnt)
	----------------------------------------------------------------------------------------


	SetTeamAggressiveness(CIS, 0.95)
	SetTeamAggressiveness(REP, 0.95)

	--ReadDataFile("dc:sound\\tat.lvl")
	ReadDataFile("sound\\tat.lvl;tat3cw")
    ReadDataFile("dc:sound\\tss.lvl;tssgcw")
    ReadDataFile("dc:SIDE\\prh.lvl",
                    "prh_inf_healthdroid",
                    "prh_inf_ammodroid",
                    "prh_inf_tat3_bldg_jabba",
                    "prh_inf_tat3_prop_bong",
                    "prh_inf_seeker",
                    "prh_inf_tat3_prop_crate_box",
                    "prh_inf_tat3_prop_crate_cylinder",
                    "prh_inf_tat3_prop_tauntaun_head",
                    "prh_inf_tat3_prop_fruittable")
                    
                

    SetupTeams{

        rep={
            team = REP,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_healthdroid",0, 0},
            assault = {"prh_inf_ammodroid",0, 0},
            engineer = {"prh_inf_tat3_prop_fruittable",0, 0},
            sniper  = {"prh_inf_tat3_prop_tauntaun_head",0, 0},
            officer = {"prh_inf_tat3_prop_crate_box",0, 0},
            special = {"prh_inf_tat3_prop_crate_cylinder",0, 0},
            marine = {"",0, 0},
            pilot = {"",0, 0},
            
        },
        
        cis={
            team = CIS,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_seeker",0, 0},
            

        }
    }


	SetSpawnDelay(10.0, 0.25)

	--	Level Stats
	ClearWalkers()
	AddWalkerType(0, 3) -- Droidekas
	AddWalkerType(1, 0)
	AddWalkerType(2, 0)

	SetSpawnDelay(10.0, 0.25)
	ReadDataFile("TAT\\tat3.lvl", "tat3_con")
	SetDenseEnvironment("true")
	--AddDeathRegion("Sarlac01")
	SetMaxFlyHeight(90)
	SetMaxPlayerFlyHeight(90)
    AISnipeSuitabilityDist(30)

	--	Sound Stats
	voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
	AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
	AudioStreamAppendSegments("sound\\global.lvl", "gam_unit_vo_slow", voiceSlow)
	AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
	
	voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
	AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)	
	
	OpenAudioStream("sound\\global.lvl",	"cw_music")
	OpenAudioStream("sound\\tat.lvl",	"tat3")
	OpenAudioStream("sound\\tat.lvl",	"tat3")
	-- OpenAudioStream("sound\\global.lvl",	"global_vo_quick")
	-- OpenAudioStream("sound\\global.lvl",	"global_vo_slow")
	OpenAudioStream("sound\\tat.lvl",	"tat3_emt")

	SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
	SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",	1)
	SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",	1)
	SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

	SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
	SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
	SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
	SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)

	SetOutOfBoundsVoiceOver(1, "repleaving")
	SetOutOfBoundsVoiceOver(2, "cisleaving")

	SetAmbientMusic(REP, 1.0, "rep_tat_amb_start",	0,1)
	SetAmbientMusic(REP, 0.8, "rep_tat_amb_middle", 1,1)
	SetAmbientMusic(REP, 0.2, "rep_tat_amb_end",	2,1)
	SetAmbientMusic(CIS, 1.0, "cis_tat_amb_start",	0,1)
	SetAmbientMusic(CIS, 0.8, "cis_tat_amb_middle", 1,1)
	SetAmbientMusic(CIS, 0.2, "cis_tat_amb_end",	2,1)

	SetVictoryMusic(REP, "rep_tat_amb_victory")
	SetDefeatMusic (REP, "rep_tat_amb_defeat")
	SetVictoryMusic(CIS, "cis_tat_amb_victory")
	SetDefeatMusic (CIS, "cis_tat_amb_defeat")

	SetSoundEffect("ScopeDisplayZoomIn",	"binocularzoomin")
	SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
	--SetSoundEffect("WeaponUnableSelect",	"com_weap_inf_weaponchange_null")
	--SetSoundEffect("WeaponModeUnableSelect",	"com_weap_inf_modechange_null")
	SetSoundEffect("SpawnDisplayUnitChange",		"shell_select_unit")
	SetSoundEffect("SpawnDisplayUnitAccept",		"shell_menu_enter")
	SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
	SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
	SetSoundEffect("SpawnDisplayBack",			"shell_menu_exit")

	--	Camera Stats	
	AddCameraShot(0.591589, 0.355856, -0.619941, 0.372911, -56.394310, -15.575965, 125.307365);

end
