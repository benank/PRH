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

    TrashStuff();
    PlayAnimExtend();
    PlayAnimTakExtend();
    
    BlockPlanningGraphArcs("compactor")
    OnObjectKillName(CompactorConnectionOn, "grate01")
    
    DisableBarriers("start_room_barrier")
    DisableBarriers("dr_left")
    DisableBarriers("circle_bar1")
    DisableBarriers("circle_bar2")
	
    OnObjectRespawnName(PlayAnimExtend, "Panel-Chasm");
    OnObjectKillName(PlayAnimRetract, "Panel-Chasm");

    OnObjectRespawnName(PlayAnimTakExtend, "Panel-Tak");
    OnObjectKillName(PlayAnimTakRetract, "Panel-Tak");
     
--	MapHideCommandPosts()
--	KillObject("CP1")
--	KillObject("CP2")
--	KillObject("CP3")
--	KillObject("CP4")
--	KillObject("CP5")
--	KillObject("CP7")
--	KillObject("CP7")
    DisableBarriers("start_room_barrier")
    DisableBarriers("dr_left")
    DisableBarriers("circle_bar1")
    DisableBarriers("circle_bar2")
	

	--SetProperty("dea1_prop_crate", "IsNotTargetableByPlayer", "1")
	--SetProperty("dea1_prop_crate", "MaxHealth", "999999999")
    
	SetClassProperty("com_bldg_controlzone", "NeutralizeTime", "0.001")
	SetClassProperty("com_bldg_controlzone", "CaptureTime", "0.001")
	takerProps = GetTeamMember(1,7)
	takerProps2 = GetTeamMember(1,8)
	takerProps3 = GetTeamMember(1,9)
	SelectCharacterClass(takerProps,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps2,"prh_inf_healthdroid")
	SelectCharacterClass(takerProps3,"prh_inf_healthdroid")
	print("test1")
	des1 = GetEntityMatrix("CP1")
	des2 = GetEntityMatrix("CP2")
	des3 = GetEntityMatrix("CP3")
	des4 = GetEntityMatrix("CP4")
	des5 = GetEntityMatrix("CP5")
	des6 = GetEntityMatrix("CP7")
	des7 = GetEntityMatrix("CP6")
	finalDestination = GetPathNodeDestination("boundary",3)
	print("test2")
	--CapturePosts            = 0
	SpawnCharacter(takerProps, des1)
	SpawnCharacter(takerProps2, des2)
	SpawnCharacter(takerProps3, des3)
	SetClassProperty("prh_inf_healthdroid", "CapturePosts", 1)
	cpsCaptured = 0
	cpsCaptured1 = 0
	
function seekerCap()
	readyToStart = 0
	SetClassProperty("prh_inf_seeker", "CapturePosts", 1)
	takerSeekers1 = GetTeamMember(2,7)
	takerSeekers2 = GetTeamMember(2,8)
	takerSeekers3 = GetTeamMember(2,9)
	takerSeekers4 = GetTeamMember(2,10)
	takerSeekers5 = GetTeamMember(2,11)
	takerSeekers6 = GetTeamMember(2,12)
	takerSeekers7 = GetTeamMember(2,13)
	SelectCharacterClass(takerSeekers1,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers2,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers3,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers4,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers5,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers6,"prh_inf_seeker")
	SelectCharacterClass(takerSeekers7,"prh_inf_seeker")
	SpawnCharacter(takerSeekers1, des1)
	SpawnCharacter(takerSeekers2, des2)
	SpawnCharacter(takerSeekers3, des3)
	SpawnCharacter(takerSeekers4, des4)
	SpawnCharacter(takerSeekers5, des5)
	SpawnCharacter(takerSeekers6, des6)
	SpawnCharacter(takerSeekers7, des7)
end
	
	captureKiller = OnFinishCapture(function(post)
		if cpsCaptured1 == 0 then
			cpsCaptured = cpsCaptured + 1
		elseif cpsCaptured1 == 1 then
			cpsCaptured = cpsCaptured + 2
		end
		if cpsCaptured == 3 then
			print("tp and kill")
			SetEntityMatrix(GetCharacterUnit(takerProps), finalDestination)
			KillObject(GetCharacterUnit(takerProps))
			SetEntityMatrix(GetCharacterUnit(takerProps2), finalDestination)
			KillObject(GetCharacterUnit(takerProps2))
			SetEntityMatrix(GetCharacterUnit(takerProps3), finalDestination)
			KillObject(GetCharacterUnit(takerProps3))
			SetClassProperty("prh_inf_healthdroid", "CapturePosts", 0)
			cpsCaptured = 0
			cpsCaptured1 = 1
		end
		if cpsCaptured == 14 then
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
			SetEntityMatrix(GetCharacterUnit(takerSeekers7), finalDestination)
			KillObject(GetCharacterUnit(takerSeekers7))
			SetClassProperty("prh_inf_seeker", "CapturePosts", 0)
			readyToStart = 1
		end
			
	end)
		
		
	print("test3")
	print("test4")
	print("test5")
	--[[SetProperty("CP1", "NeutralizeTime", "-1")
	SetProperty("CP2", "NeutralizeTime", "-1")
	SetProperty("CP3", "NeutralizeTime", "-1")
	SetProperty("CP4", "NeutralizeTime", "-1")
	SetProperty("CP5", "NeutralizeTime", "-1")
	SetProperty("CP7", "NeutralizeTime", "-1")
	SetProperty("CP1", "CaptureTime", "-1")
	SetProperty("CP2", "CaptureTime", "-1")
	SetProperty("CP3", "CaptureTime", "-1")
	SetProperty("CP4", "CaptureTime", "-1")
	SetProperty("CP5", "CaptureTime", "-1")
	SetProperty("CP7", "CaptureTime", "-1")--]]

	AddDeathRegion("DeathRegion01")
	AddDeathRegion("DeathRegion02")
	AddDeathRegion("DeathRegion03")
	AddDeathRegion("DeathRegion04")
	AddDeathRegion("DeathRegion05")
	------------------------- SETUP THE FIRST FEW TIMERS
	dead = CreateTimer("dead")
	dead2 = CreateTimer("dead2")
	win = CreateTimer("win")
	spawn = CreateTimer("spawn")
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
	waiter = CreateTimer("waiter")
	SetTimerValue(waiter, 10) 

	SetTimerValue(spawn, 60)
	SetTimerValue(dead, 1)
	SetTimerValue(dead2, 1)
	
----------------------------------------------------
	if (not ScriptCB_InMultiplayer()) then
		ShowObjectiveTextPopup("level.PRH.load", DEF)
		ShowObjectiveTextPopup("level.PRH.load", ATT)
	end
-------------------------------------------------- ONCE THE FIRST ONE SPAWNS START THE TIMERS

	readyToStart = 0
	print("1")
	
    onfirstspawn = OnCharacterSpawn(
        function(character)
			if IsCharacterHuman(character) then
				ReleaseCharacterSpawn(onfirstspawn)
				--KillObject(GetCharacterUnit(takerProps))
				onfirstspawn = nil
--          	StartTimer(alive)
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
				SetReinforcementCount(1, 1)
				SetReinforcementCount(2, 1)
				--KillObject(GetCharacterUnit(takerProps))
				--KillObject(GetCharacterUnit(takerProps2))
				--KillObject(GetCharacterUnit(takerProps3))
				print("2")
			end
        end
		)
		
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
	
		ScriptCB_SetCanSwitchSides(1)
		
function changeClass()
	print("changeClass")
	readyToStart = 0
	local reinforce = GetReinforcementCount(1)
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
	SetReinforcementCount(1,reinforce)
	SpawnCharacter(ccPlayer, ccMatrix) --spawn them back
	SetClassProperty(classTo, "PointsToUnlock", "9999")
	print("cc4")
	SetProperty(GetCharacterUnit(ccPlayer), "CurHealth", playerCurHp)
	readyToStart = 1
end
		
		--------------------------------------------------------------------------------
--[[NeutralizeTime 	= 12.0
CaptureTime 	= 10.0

	boss1 = GetTeamMember(2,0)
	SelectCharacterClass(boss1,"cis_inf_rifleman")

	des1 = GetPathNodeDestination( "evil",0)
			SpawnCharacter(boss1, des1)
--]]
  	--------------------------------- RELEASE THE HOUNDS SPAWN TIMER
	OnTimerElapse(
	    function(timer)
			print("4")
			ShowMessageText("level.PRH.seekerscanspawn")
			seekerCap()
			--SetProperty("CP1", "SpawnPath", "CP1Spawn")
			--SetProperty("CP2", "SpawnPath", "CP2Spawn")
			--SetProperty("CP3", "SpawnPath", "CP3Spawn")
			--SetProperty("CP4", "SpawnPath", "")
			--SetProperty("CP5", "SpawnPath", "")
			--SetProperty("CP7", "SpawnPath", "")
			DestroyTimer(timer)
	    end,
	    spawn
		)

		-------------------------------------------------------
    ------------------------------------- VICTORY TIMER
	OnTimerElapse(
	    function(timer)
		print("4")
		MissionVictory(1)
		DestroyTimer(timer)
	    end,
	    win
		)
		
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
		
		ScriptCB_SetCanSwitchSides(1)
		--[[
	unitsAlive = {}

	unitSpawn = OnCharacterSpawn(
    function(character)
		if IsCharacterHuman(character) then
			ReleaseCharacterSpawn(unitSpawn)
			if ScriptCB_InMultiplayer() then
				playerInfo = {playerUnit = GetCharacterUnit(character)
				}
				unitsAlive[character] = playerInfo
				print("Player info recorded")
			end
		end
    end)--]]
	
	unitDeath = OnObjectKill(function(object, killer)
		if ScriptCB_InMultiplayer() then
			print("Someone died!")
			if readyToStart == 1 then
				if GetObjectTeam(object) == 1 then
					SetEntityMatrix(object, finalDestination)
					DeactivateObject(object)
				elseif GetObjectTeam(object) == 2 then
					DeactivateObject(object)
				end
			end
		end
	end)
	
	spawnthing = OnCharacterSpawn(function(character)
		if readyToStart == 1 then
			SetReinforcementCount(1, (GetNumTeamMembersAlive(1)))
			SetReinforcementCount(2, (GetNumTeamMembersAlive(2)))
		end
	end)
	
	
	deathChecker = OnCharacterDeath(function(character, killer)
		if ScriptCB_InMultiplayer() and readyToStart == 1 then
			if readyToStart == 1 then
				SetReinforcementCount(1, (GetNumTeamMembersAlive(1)))
				SetReinforcementCount(2, (GetNumTeamMembersAlive(2)))
				ScriptCB_SetSpectatorMode(0)
				--if GetNumTeamMembersAlive(1) == 0 then
				--	MissionVictory(2)
				--elseif GetNumTeamMembersAlive(2) == 0 then
				--	MissionVictory(1)
				--end
			end
		end
	end)
	
	propHit = OnObjectDamage(function(object, damager)
		if GetObjectLastHitWeaponClass(object) == "prh_weap_inf_ak47" and GetObjectTeam(object) == 0 then
			playerCurHp = GetObjectHealth(GetCharacterUnit(damager))
			SetProperty(GetCharacterUnit(damager), "CurHealth", (playerCurHp - 20))
		elseif GetObjectLastHitWeaponClass(object) == "prh_weap_inf_ak47_explosive" and GetObjectTeam(object) == 0 then
			playerCurHp = GetObjectHealth(GetCharacterUnit(damager))
			SetProperty(GetCharacterUnit(damager), "CurHealth", (playerCurHp - 75))
		end
	end)
	
	-----------TEAM 1 IS PROPS AND TEAM 2 IS SEEKERS

    

end



function CompactorConnectionOn()
    UnblockPlanningGraphArcs ("compactor")
end
--START BRIDGEWORK!

-- OPEN
function PlayAnimExtend()
      PauseAnimation("bridgeclose");    
      RewindAnimation("bridgeopen");
      PlayAnimation("bridgeopen");
    
    -- allow the AI to run across it
    UnblockPlanningGraphArcs("Connection122");
    DisableBarriers("BridgeBarrier");
    
end
-- CLOSE
function PlayAnimRetract()
      PauseAnimation("bridgeopen");
      RewindAnimation("bridgeclose");
      PlayAnimation("bridgeclose");
      
    -- prevent the AI from running across it
    BlockPlanningGraphArcs("Connection122");
    EnableBarriers("BridgeBarrier");
      
end

--START BRIDGEWORK TAK!!!

-- OPEN
function PlayAnimTakExtend()
      PauseAnimation("TakBridgeOpen");  
      RewindAnimation("TakBridgeClose");
      PlayAnimation("TakBridgeClose");
        
    -- allow the AI to run across it
    UnblockPlanningGraphArcs("Connection128");
    DisableBarriers("Barrier222");
    
end
-- CLOSE
function PlayAnimTakRetract()
      PauseAnimation("TakBridgeClose");
      RewindAnimation("TakBridgeOpen");
      PlayAnimation("TakBridgeOpen");
            
    -- prevent the AI from running across it
    BlockPlanningGraphArcs("Connection128");
    EnableBarriers("Barrier222");
      
end

function TrashStuff()

    trash_open = 1
    trash_closed = 0
    
    trash_timer = CreateTimer("trash_timer")
    SetTimerValue(trash_timer, 7)
    StartTimer(trash_timer)
    trash_death = OnTimerElapse(
        function(timer)
            if trash_open == 1 then
                AddDeathRegion("deathregion")
                SetTimerValue(trash_timer, 5)
                StartTimer(trash_timer)
                trash_closed = 1
                trash_open = 0
                print("death region added")
            
            elseif trash_closed == 1 then
                RemoveRegion("deathregion")
                SetTimerValue(trash_timer, 15)
                StartTimer(trash_timer)
                print("death region removed")
                trash_closed = 0
                trash_open = 1
            end
        end,
        trash_timer
        )
end


function ScriptInit()
    
    -- Designers, these two lines *MUST* be first.
    StealArtistHeap(512*1024)
    SetPS2ModelMemory(4000000)
    SetDenseEnvironment("true")
    ReadDataFile("dc:ingame.lvl")
    ReadDataFile("ingame.lvl")
   
    
    SetMemoryPoolSize ("SoldierAnimation", 950)    
    --  Empire Attacking (attacker is always #1)
    local ALL = 1
    local IMP = 2
    --  These variables do not change
    local ATT = 1
    local DEF = 2
    
    ReadDataFile("sound\\dea.lvl;dea1gcw")
    ReadDataFile("dc:sound\\tss.lvl;tssgcw")

    
    SetMaxFlyHeight(72)
    SetMaxPlayerFlyHeight (72)
    AISnipeSuitabilityDist(30)

    ReadDataFile("dc:SIDE\\prh.lvl",
                    "prh_inf_tpose",
                    "prh_inf_healthdroid",
                    "prh_inf_ammodroid",
                    "prh_inf_dea1_barrel",
                    "prh_inf_dea1_crate",
                    "prh_inf_seeker")
                    
                

    SetupTeams{

        all={
            team = ALL,
            units = 32,
            reinforcements = 1,
            soldier = {"prh_inf_tpose", 0, 0},
            special = {"prh_inf_healthdroid",0, 0},
            assault = {"prh_inf_ammodroid",0, 0},
            engineer = {"prh_inf_dea1_barrel",0, 0},
            officer = {"prh_inf_dea1_crate",0, 0},
            
        },
        
        imp={
            team = IMP,
            units = 32,
            reinforcements = 1,
            soldier = {"prh_inf_seeker",0, 0},
            

        }
    }

 --  Level Stats
    ClearWalkers()
    --    AddWalkerType(0, 0) -- 8 droidekas (special case: 0 leg pairs)
    --    AddWalkerType(1, 0) -- 8 droidekas (special case: 0 leg pairs)
    --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
    --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponCnt = 200
    SetMemoryPoolSize ("Aimer", 5)
    SetMemoryPoolSize ("AmmoCounter", weaponCnt)
    SetMemoryPoolSize ("BaseHint", 300)
    SetMemoryPoolSize ("EnergyBar", weaponCnt)
    SetMemoryPoolSize ("EntityCloth", 18)
    SetMemoryPoolSize ("EntityLight", 100)
    SetMemoryPoolSize ("EntitySoundStatic", 30)
    SetMemoryPoolSize ("SoundSpaceRegion", 50)    
    SetMemoryPoolSize ("MountedTurret", 0)
    SetMemoryPoolSize ("Navigator", 500)
    SetMemoryPoolSize ("Obstacle", 560)
    SetMemoryPoolSize ("PathFollower", 50)
    SetMemoryPoolSize ("PathNode", 512)
    SetMemoryPoolSize ("RedOmniLight", 130)
	SetMemoryPoolSize ("UnitAgent", 600)
    SetMemoryPoolSize ("Timer", 630)
    SetMemoryPoolSize ("ShieldEffect", 0)
    SetMemoryPoolSize ("TreeGridStack", 200)
    SetMemoryPoolSize ("UnitAgent", 50)
    SetMemoryPoolSize ("UnitController", 50)
    SetMemoryPoolSize ("Weapon", weaponCnt)
    SetMemoryPoolSize ("EntityFlyer", 6)


    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("dc:PRH\\dea1.lvl", "dea1_Conquest")
    --SetStayInTurrets(1)


    --  Movies
    --  SetVictoryMovie(ALL, "all_end_victory")
    --  SetDefeatMovie(ALL, "imp_end_victory")
    --  SetVictoryMovie(IMP, "imp_end_victory")
    --  SetDefeatMovie(IMP, "all_end_victory")

    --  Sound
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\dea.lvl",  "dea1")
    OpenAudioStream("sound\\dea.lvl",  "dea1")
    -- OpenAudioStream("sound\\cor.lvl",  "dea1gcw_emt")

    SetOutOfBoundsVoiceOver(1, "allleaving")
    SetOutOfBoundsVoiceOver(2, "impleaving")

    SetAmbientMusic(ALL, 1.0, "all_dea_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_dea_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"all_dea_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_dea_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_dea_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_dea_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_dea_amb_victory")
    SetDefeatMusic (ALL, "all_dea_amb_defeat")
    SetVictoryMusic(IMP, "imp_dea_amb_victory")
    SetDefeatMusic (IMP, "imp_dea_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --  SetSoundEffect("BirdScatter",         "birdsFlySeq1")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

   
    SetAttackingTeam(ATT)

	AddCameraShot(-0.252121, -0.041971, -0.953661, 0.158757, -259.314392, 53.514854, -182.432892);

end
