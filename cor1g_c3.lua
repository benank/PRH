--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
Conquest = ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 
ScriptCB_DoFile("teleport")

--  These variables do not change
ATT = 1
DEF = 2

--  Empire Attacking (attacker is always #1)
REP = ATT
CIS = DEF

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

	    AddDeathRegion("death")
	    AddDeathRegion("death1")
	    AddDeathRegion("death2")
	    AddDeathRegion("death3")
	    AddDeathRegion("death4")



		ScriptCB_SetCanSwitchSides(1)
		

    	SetProperty ("LibCase1","MaxHealth",1000)
    	SetProperty ("LibCase2","MaxHealth",1000)
    	SetProperty ("LibCase3","MaxHealth",1000)
    	SetProperty ("LibCase4","MaxHealth",1000)
    	SetProperty ("LibCase5","MaxHealth",1000)
    	SetProperty ("LibCase6","MaxHealth",1000)
    	SetProperty ("LibCase7","MaxHealth",1000)
    	SetProperty ("LibCase8","MaxHealth",1000)
    	SetProperty ("LibCase9","MaxHealth",1000)
    	SetProperty ("LibCase10","MaxHealth",1000)
    	SetProperty ("LibCase11","MaxHealth",1000)
    	SetProperty ("LibCase12","MaxHealth",1000)
    	SetProperty ("LibCase13","MaxHealth",1000)
    	SetProperty ("LibCase14","MaxHealth",1000)


    	SetProperty ("LibCase1","CurHealth",1000)
    	SetProperty ("LibCase2","CurHealth",1000)
    	SetProperty ("LibCase3","CurHealth",1000)
    	SetProperty ("LibCase4","CurHealth",1000)
    	SetProperty ("LibCase5","CurHealth",1000)
    	SetProperty ("LibCase6","CurHealth",1000)
    	SetProperty ("LibCase7","CurHealth",1000)
    	SetProperty ("LibCase8","CurHealth",1000)
    	SetProperty ("LibCase9","CurHealth",1000)
    	SetProperty ("LibCase10","CurHealth",1000)
    	SetProperty ("LibCase11","CurHealth",1000)
    	SetProperty ("LibCase12","CurHealth",1000)
    	SetProperty ("LibCase13","CurHealth",1000)
    	SetProperty ("LibCase14","CurHealth",1000)



    	EnableSPHeroRules()
    	
    	DisableBarriers("SideDoor1")
        DisableBarriers("MainLibraryDoors")
        DisableBarriers("SideDoor2")
        DisableBarriers("SIdeDoor3")
        DisableBarriers("ComputerRoomDoor1")
        DisableBarriers("StarChamberDoor1")
        DisableBarriers("StarChamberDoor2")
        DisableBarriers("WarRoomDoor1")
        DisableBarriers("WarRoomDoor2")
        DisableBarriers("WarRoomDoor3") 
        PlayAnimation("DoorOpen01")
        PlayAnimation("DoorOpen02") 
            
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
	if ScriptCB_InMultiplayer() then
		death4ever = OnObjectKill(function(object, killer)
			if GetObjectTeam(object) == 1 then
				SetEntityMatrix(object, finalDestination)
			end
			DeactivateObject(object)
		end)
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

	SetClassProperty("prh_inf_Cor1_prop_door_1", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_cor1_prop_library_bustA", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_cor1_prop_library_bustB", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_Cor1_prop_librarystack", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_healthdroid", "PointsToUnlock", "9999")
	SetClassProperty("prh_inf_ammodroid", "PointsToUnlock", "9999")

	ccPlayer = nil
	ccMatrix = nil
	classTo = nil
	playerCurHp = nil
	
	ClassSwitcher = OnObjectDamage(function(object, damager)
		print("damage")
		if GetObjectLastHitWeaponClass(object) == "prh_weap_inf_interact" then
			ccPlayer = damager
			print("GetEntityName: ", GetEntityName(object))
			print("GetEntityClassName: ", GetEntityClassName(object))
			if GetEntityClassName(object) == "com_item_weaponrecharge" then
				classTo = "prh_inf_ammodroid"
				changeClass()
			end
			if GetEntityClassName(object) == "com_item_healthrecharge" then
				classTo = "prh_inf_healthdroid"
				changeClass()
			end
			if GetEntityClassName(object) == "cor1_prop_library_busta" then
				classTo = "prh_inf_cor1_prop_library_bustA"
				changeClass()
			end
			if GetEntityClassName(object) == "cor1_prop_library_bustb" then
				classTo = "prh_inf_cor1_prop_library_bustB"
				changeClass()
			end
			objects3 = {}
			for i=1,25 do
				objects3[i] = "libcase"..i
				if GetEntityName(object) == objects3[i] then
				classTo = "prh_inf_Cor1_prop_librarystack"
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

function ScriptInit()
    -- Designers, these two lines *MUST* be first.
   
    SetPS2ModelMemory(4056000)
    
    SetMapNorthAngle(180, 1)
    SetMaxFlyHeight(25)
    SetMaxPlayerFlyHeight (25)
    AISnipeSuitabilityDist(30)
    
    
    
    SetMemoryPoolSize("Music", 33)

    ReadDataFile("dc:ingame.lvl")
    ReadDataFile("ingame.lvl")
    
          
    ReadDataFile("sound\\cor.lvl;cor1cw")

    ReadDataFile("dc:sound\\tss.lvl;tssgcw")
    ReadDataFile("dc:SIDE\\prh.lvl",
                    "prh_inf_healthdroid",
                    "prh_inf_ammodroid",
                    "prh_inf_Cor1_prop_door_1",
                    "prh_inf_cor1_prop_library_bustA",
                    "prh_inf_seeker",
                    "prh_inf_cor1_prop_library_bustB",
                    "prh_inf_Cor1_prop_statue",
                    "prh_inf_tpose",
                    "prh_inf_Cor1_prop_librarystack")
                    
                

    SetupTeams{

        rep={
            team = REP,
            units = 32,
            reinforcements = -1,
            soldier = {"prh_inf_tpose",0, 0},
            assault = {"prh_inf_Cor1_prop_librarystack",0, 0},
            engineer = {"prh_inf_Cor1_prop_door_1",0, 0},
            sniper  = {"prh_inf_cor1_prop_library_bustA",0, 0},
            officer = {"prh_inf_cor1_prop_library_bustB",0, 0},
            special = {"prh_inf_ammodroid",0, 0},
            --marine = {"",0, 0},
            pilot = {"prh_inf_healthdroid",1, 4},
            
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
    AddWalkerType(0, 3) -- 8 droidekas (special case: 0 leg pairs)
    AddWalkerType(1, 0) -- 
    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponCnt = 210
    SetMemoryPoolSize("Aimer", 22)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 250)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 18)
    SetMemoryPoolSize("EntitySoundStream", 10)
    SetMemoryPoolSize("EntitySoundStatic", 0)
    SetMemoryPoolSize("MountedTurret",12)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 375)
    SetMemoryPoolSize("SoldierAnimation", 375)
    SetMemoryPoolSize("SoundSpaceRegion", 38)
    SetMemoryPoolSize("TentacleSimulator", 0)
    SetMemoryPoolSize("TreeGridStack", 140)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)
	SetMemoryPoolSize("EntityFlyer", 4)   

    SetSpawnDelay(10.0, 0.25)
   ReadDataFile("dc:PRH\\cor1.lvl","cor1_Conquest")
    SetDenseEnvironment("True")
         -- SetMaxFlyHeight(25)
     --SetMaxPlayerFlyHeight (25)
 AddDeathRegion("DeathRegion1")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\cor.lvl",  "cor1")
    OpenAudioStream("sound\\cor.lvl",  "cor1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(2, "Repleaving")
    SetOutOfBoundsVoiceOver(1, "Cisleaving")

    SetAmbientMusic(REP, 1.0, "rep_cor_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_cor_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "rep_cor_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_cor_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_cor_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2, "cis_cor_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_cor_amb_victory")
    SetDefeatMusic (REP, "rep_cor_amb_defeat")
    SetVictoryMusic(CIS, "cis_cor_amb_victory")
    SetDefeatMusic (CIS, "cis_cor_amb_defeat")

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
    --Tat 1 - Dune Sea
	AddCameraShot(0.527765, 0.628441, -0.367484, 0.437585, -49.736946, 12.956334, -128.235046);


end


