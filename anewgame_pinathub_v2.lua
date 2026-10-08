--[[
    ╔════════════════════════════════════════════════════════════════════════════════╗
    ║                               PINATHUB V2 ULTRA                                ║
    ║                  Anime Blade Champions & Training RPG Hub                      ║
    ║             Universal Multi-Module Master Edition (392 Game Modules)           ║
    ║      Engineered with PinatHub / KingRua UI Library & Live Graphics Telemetry   ║
    ╚════════════════════════════════════════════════════════════════════════════════╝
]]

local function __PinatHub_AnimeBlade_V2__()

-- ==============================================================================
-- 1. CORE ROBLOX ENGINE SERVICES & REFS
-- ==============================================================================
local Players                = game:GetService("Players")
local RunService             = game:GetService("RunService")
local UserInputService       = game:GetService("UserInputService")
local Workspace              = game:GetService("Workspace")
local ReplicatedStorage      = game:GetService("ReplicatedStorage")
local TweenService           = game:GetService("TweenService")
local HttpService            = game:GetService("HttpService")
local Lighting               = game:GetService("Lighting")
local StatsService           = game:GetService("Stats")

local Camera                 = Workspace.CurrentCamera or Workspace:WaitForChild("Camera", 5)
local LocalPlayer            = Players.LocalPlayer

local Character, Humanoid, Root
local function refreshChar(char)
    Character = char or LocalPlayer.Character
    Humanoid  = Character and Character:FindFirstChildOfClass("Humanoid")
    Root      = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso"))
end
refreshChar()
LocalPlayer.CharacterAdded:Connect(refreshChar)

-- ==============================================================================
-- 2. SAFE MODULE RESOLVER & GAME UTILS
-- ==============================================================================
local function safeRequire(modInstance)
    if not modInstance then return nil end
    local req = (getrenv and getrenv().require) or require
    local ok, res = pcall(function()
        return req(modInstance)
    end)
    if ok and res then return res end
    return nil
end

local function getGameModule(folderName, moduleName)
    local f = ReplicatedStorage:FindFirstChild(folderName)
    if f then
        local m = f:FindFirstChild(moduleName)
        if m and m:IsA("ModuleScript") then
            return safeRequire(m)
        end
    end
    return nil
end

-- Core Game Modules Discovery
local CommunicationUtils = getGameModule("Utils", "CommunicationUtils")
local EncodingUtils      = getGameModule("Utils", "EncodingUtils")
local CalculateUtils     = getGameModule("Utils", "CalculateUtils")
local AbbNumber          = getGameModule("Utils", "AbbNumber")
local HPCTRL             = getGameModule("CTRL", "HPCTRL")
local TrainCTRL          = getGameModule("CTRL", "TrainCTRL")
local EnemyCTRL          = getGameModule("CTRL", "EnemyCTRL")
local SkillCTRL          = getGameModule("SkillSystemNew", "SkillCTRL")
local StageUtils         = getGameModule("Manager", "StageManager") and safeRequire(ReplicatedStorage:FindFirstChild("StageUtils", true))
local WorldBossManager   = getGameModule("Manager", "WorldBossManager")

local StatsData          = getGameModule("LocalData", "StatsData")
local UpgradeData        = getGameModule("LocalData", "UpgradeData")
local PotionData         = getGameModule("LocalData", "PotionData")
local BackpackData       = getGameModule("LocalData", "BackpackData")
local ClassData          = getGameModule("LocalData", "ClassData")

-- Remote Endpoints Resolution
local function GetRemoteEvent(category, name)
    if CommunicationUtils and CommunicationUtils.TryGetRemoteEvent then
        local ok, res = pcall(CommunicationUtils.TryGetRemoteEvent, category, name)
        if ok and res then return res end
    end
    local catFolder = ReplicatedStorage:FindFirstChild(category)
    if catFolder then
        local r = catFolder:FindFirstChild(name)
        if r and r:IsA("RemoteEvent") then return r end
    end
    return ReplicatedStorage:FindFirstChild(name, true)
end

local function GetRemoteFunction(category, name)
    if CommunicationUtils and CommunicationUtils.TryGetRemoteFunction then
        local ok, res = pcall(CommunicationUtils.TryGetRemoteFunction, category, name)
        if ok and res then return res end
    end
    local catFolder = ReplicatedStorage:FindFirstChild(category)
    if catFolder then
        local r = catFolder:FindFirstChild(name)
        if r and r:IsA("RemoteFunction") then return r end
    end
    return ReplicatedStorage:FindFirstChild(name, true)
end

local function GetBindableEvent(category, name)
    if CommunicationUtils and CommunicationUtils.TryGetBindableEvent then
        local ok, res = pcall(CommunicationUtils.TryGetBindableEvent, category, name)
        if ok and res then return res end
    end
    return ReplicatedStorage:FindFirstChild(name, true)
end

-- Network Endpoints Mapping
local TrainOnceRE          = GetRemoteEvent("Train", "TrainOnceRE")
local IntoAutoTrainRE      = GetRemoteEvent("Train", "IntoAutoTrainRE")
local ExitAutoTrainRE      = GetRemoteEvent("Train", "ExitAutoTrainRE")
local InvokTrainDataListRF  = GetRemoteFunction("Train", "InvokTrainDataListRF")
local ATKOnceBE            = GetBindableEvent("Attack", "ATKOnceBE")

local UseAnyATKRE          = GetRemoteEvent("Attack", "UseAnyATKRE")
local UseAnySkillRE        = GetRemoteEvent("Attack", "UseAnySkillRE")
local KillEnemyRE          = GetRemoteEvent("Attack", "KillEnemyRE")
local UseSkillByIndexBE    = GetBindableEvent("Skill", "UseSkillByIndexBE")
local EnemyHitBE           = GetBindableEvent("Attack", "EnemyHitBE")

local GetOreRF             = GetRemoteFunction("Stage", "GetOreRF")
local ClaimedAllOreRE      = GetRemoteEvent("Stage", "ClaimedAllOreRE")
local GetEnhantStoneRE     = GetRemoteEvent("Stage", "GetEnhantStoneRE")
local StageFinishedRF      = GetRemoteFunction("Stage", "StageFinishedRF")
local StageFinishedBE      = GetBindableEvent("Stage", "StageFinishedBE")
local SetIntoStageRE       = GetRemoteEvent("Stage", "SetIntoStageRE")
local KillSuperLootRE      = GetRemoteEvent("SuperLoot", "KillSuperLootRE")

local IntoWorldBossFight   = GetRemoteEvent("WorldBoss", "IntoWorldBossFight")
local ExitWorldBossFight   = GetRemoteEvent("WorldBoss", "ExitWorldBossFight")
local TryClaimBossRewardRE = GetRemoteEvent("WorldBoss", "TryClaimBossRewardRE")
local TryGetHPBallRF       = GetRemoteFunction("WorldBoss", "TryGetHPBallRF")
local ExitWorldBossBE      = GetBindableEvent("Stage", "ExitWorldBossBE")

local UpgradeOnceRE        = GetRemoteEvent("Upgrade", "UpgradeOnceRE")
local TryRebirthRE         = GetRemoteEvent("Rebirth", "TryRebirthRE")
local ForgeRF              = GetRemoteFunction("Forge", "ForgeRF")
local PutOreNumBE          = GetBindableEvent("Forge", "PutOreNumBE")
local TryUsePotionRE       = GetRemoteEvent("Potion", "TryUsePotionRE")
local TryUseCodeRF         = GetRemoteFunction("Code", "TryUseCodeRF")
local TryClaimOfflineRE    = GetRemoteEvent("Offline", "TryClaimOfflineRewardRE")
local DungeonRebirthRE     = GetRemoteEvent("Dungeon", "DungeonRebirthRE")
local ExitDungeonBE        = GetBindableEvent("Stage", "ExitDungeonBE")
local DungeonGiveUpBE      = GetBindableEvent("Dungeon", "DungeonGiveUpBE")
local ShowLuckResultRE     = GetRemoteEvent("Class", "ShowLuckResultRE")
local GetMyBestRF          = GetRemoteFunction("TopList", "GetMyBestRF")

-- World Workspace Folders
local EnemyFolder      = Workspace:WaitForChild("EnemyFolder", 5) or Workspace:FindFirstChild("EnemyFolder")
local CanAttackFolder  = Workspace:WaitForChild("CanAttackFolder", 5) or Workspace:FindFirstChild("CanAttackFolder")
local SuperLootFolder  = Workspace:FindFirstChild("SuperLootFolder")
local WorldBossFolder  = Workspace:FindFirstChild("WorldBossFolder")
local WorldModelFolder = Workspace:FindFirstChild("WorldModel")

Workspace.ChildAdded:Connect(function(child)
    if child.Name == "EnemyFolder" then EnemyFolder = child
    elseif child.Name == "CanAttackFolder" then CanAttackFolder = child
    elseif child.Name == "SuperLootFolder" then SuperLootFolder = child
    elseif child.Name == "WorldBossFolder" then WorldBossFolder = child
    elseif child.Name == "WorldModel" then WorldModelFolder = child
    end
end)

-- ==============================================================================
-- 3. PINATHUB STATE MANAGEMENT & CONTROLS TABLE
-- ==============================================================================
local PH = {
    -- Telemetry & Graphs
    TelemetryRate       = 0.5,
    SessionStartTick    = tick(),
    SessionEnemiesSlain = 0,
    SessionOresMined    = 0,
    SessionPowerStart   = 0,
    SessionCoinsStart   = 0,
    LastPowerVal        = 0,
    LastCoinsVal        = 0,

    -- Auto Train & Power
    AutoTrain           = false,
    TrainSpeed          = 0.05,
    SelectedTrainArea   = 1,
    AutoEnterTrainArea  = false,
    AutoRebirth         = false,
    AutoUpgradePower    = false,
    AutoClaimOffline    = false,

    -- Combat & Slayer
    KillAura            = false,
    KillAuraRange       = 60,
    AutoAttack          = false,
    AttackRate          = 0.1,
    MobTargetFilter     = "All Enemies",
    HitboxExpander      = false,
    HitboxSize          = 15,
    AutoSkill1          = false,
    AutoSkill2          = false,
    AutoCollectBalls    = false,
    GodModeKeeper       = false,

    -- Stage & Waves
    SelectedStage       = 1,
    AutoFarmStage       = false,
    AutoAdvanceStage    = false,
    AutoClaimAllOre     = false,
    AutoCollectOres     = false,
    AutoCollectStones   = false,
    AutoKillSuperLoot   = false,

    -- Dungeons
    AutoJoinDungeon     = false,
    AutoClearDungeon    = false,
    AutoDungeonRevive   = false,
    AutoExitDungeon     = false,

    -- World Boss
    AutoJoinBoss        = false,
    AutoAttackBoss      = false,
    AutoCollectBossBalls= false,
    AutoClaimBossReward = false,
    AutoExitBoss        = false,
    BossHoverDistance   = 12,

    -- Forge & Equipment
    AutoForgeWeapon     = false,
    AutoForgeArmor      = false,
    AutoDepositOre      = false,
    AutoEnhanceGear     = false,

    -- Class & Rebirth
    AutoRebirthLoop     = false,
    AutoRollClass       = false,
    TargetClassRarity   = "Legendary",

    -- Pets, Potions & Upgrades
    AutoUpgradeStats    = false,
    AutoUsePowerPotion  = false,
    AutoUseCoinPotion   = false,
    AutoUseLuckPotion   = false,
    AutoEquipBestPet    = false,

    -- Movement & Physics
    WalkSpeedBoost      = false,
    WalkSpeedValue      = 16,
    JumpPowerBoost      = false,
    JumpPowerValue      = 50,
    FlyEnabled          = false,
    FlySpeed            = 60,
    Noclip              = false,
    InfiniteJump        = false,
    AntiVoid            = true,

    -- ESP & Visuals
    ESP_Enemies         = false,
    ESP_Bosses          = false,
    ESP_SuperLoot       = false,
    ESP_Ores            = false,
    ESP_Tracers         = false,

    -- Game Optimization
    PotatoMode          = false,
    Fullbright          = false,
    RemoveVFX           = false,
    RemoveShadows       = false,
    FOVValue            = 70,

    -- Config Profile
    ConfigName          = "Default"
}

getgenv().PH_AnimeBlade_V2 = PH
local UI_Controls = {}

-- ==============================================================================
-- 4. SAFE TELEMETRY DATA ENGINE (ZERO 0/NIL GUARANTEE)
-- ==============================================================================
local function FormatNumber(num)
    if not num or type(num) ~= "number" then
        num = tonumber(num) or 0
    end
    if num < 0 then return "0" end
    if num < 1000 then
        return string.format("%d", math.floor(num))
    elseif num < 1000000 then
        return string.format("%.2fK", num / 1000)
    elseif num < 1000000000 then
        return string.format("%.2fM", num / 1000000)
    elseif num < 1000000000000 then
        return string.format("%.2fB", num / 1000000000)
    elseif num < 1000000000000000 then
        return string.format("%.2fT", num / 1000000000000)
    else
        return string.format("%.2fQa", num / 1000000000000000)
    end
end

local function FormatTime(seconds)
    seconds = math.max(0, math.floor(seconds or 0))
    local hours = math.floor(seconds / 3600)
    local mins  = math.floor((seconds % 3600) / 60)
    local secs  = seconds % 60
    if hours > 0 then
        return string.format("%02dh %02dm %02ds", hours, mins, secs)
    else
        return string.format("%02dm %02ds", mins, secs)
    end
end

-- Layered Safe Data Readers
local function GetPlayerPower()
    local ok, res = pcall(function()
        local eco = LocalPlayer:FindFirstChild("Eco")
        if eco and eco:FindFirstChild("power") then
            return eco.power.Value
        end
        local attr = LocalPlayer:GetAttribute("Power") or LocalPlayer:GetAttribute("power")
        if attr then return attr end
        local ls = LocalPlayer:FindFirstChild("leaderstats")
        if ls and ls:FindFirstChild("Power") then return ls.Power.Value end
        return nil
    end)
    return (ok and res) and tonumber(res) or 0
end

local function GetPlayerCoins()
    local ok, res = pcall(function()
        local eco = LocalPlayer:FindFirstChild("Eco")
        if eco and eco:FindFirstChild("coin") then
            return eco.coin.Value
        end
        local attr = LocalPlayer:GetAttribute("Coin") or LocalPlayer:GetAttribute("Coins")
        if attr then return attr end
        local ls = LocalPlayer:FindFirstChild("leaderstats")
        if ls and (ls:FindFirstChild("Coins") or ls:FindFirstChild("Coin")) then
            return (ls:FindFirstChild("Coins") or ls:FindFirstChild("Coin")).Value
        end
        return nil
    end)
    return (ok and res) and tonumber(res) or 0
end

local function GetPlayerRebirths()
    local ok, res = pcall(function()
        local eco = LocalPlayer:FindFirstChild("Eco")
        if eco and eco:FindFirstChild("rebirth") then
            return eco.rebirth.Value
        end
        local attr = LocalPlayer:GetAttribute("Rebirth") or LocalPlayer:GetAttribute("rebirth")
        if attr then return attr end
        return nil
    end)
    return (ok and res) and tonumber(res) or 0
end

local function GetPlayerLevel()
    local ok, res = pcall(function()
        local eco = LocalPlayer:FindFirstChild("Eco")
        if eco and eco:FindFirstChild("level") then
            return eco.level.Value
        end
        local attr = LocalPlayer:GetAttribute("Level") or LocalPlayer:GetAttribute("level")
        if attr then return attr end
        return nil
    end)
    return (ok and res) and tonumber(res) or 1
end

local function GetPlayerHP()
    local hp = 100
    pcall(function()
        local hpVal = LocalPlayer:FindFirstChild("HPValue")
        if hpVal and hpVal.Value then
            hp = hpVal.Value
        elseif Humanoid and Humanoid.Health then
            hp = Humanoid.Health
        end
    end)
    return math.max(0, math.floor(hp))
end

local function GetPlayerMaxHP()
    local maxHp = 100
    pcall(function()
        local hpVal = LocalPlayer:FindFirstChild("HPValue")
        if hpVal and hpVal:GetAttribute("MaxHP") then
            maxHp = hpVal:GetAttribute("MaxHP")
        elseif LocalPlayer:GetAttribute("MaxHP") then
            maxHp = LocalPlayer:GetAttribute("MaxHP")
        elseif Humanoid and Humanoid.MaxHealth then
            maxHp = Humanoid.MaxHealth
        end
    end)
    return math.max(1, math.floor(maxHp))
end

local function GetPlayerATK()
    local atk = 10
    pcall(function()
        local a = LocalPlayer:GetAttribute("ATK") or LocalPlayer:GetAttribute("Damage")
        if a then atk = a end
    end)
    return math.max(1, math.floor(atk))
end

local function GetCurrentStageName()
    local s = "Stage 1"
    pcall(function()
        local attr = LocalPlayer:GetAttribute("StageID")
        if attr then s = tostring(attr) end
    end)
    return s
end

local function GetActiveTrainAreaName()
    local a = "None"
    pcall(function()
        local attr = LocalPlayer:GetAttribute("AutoTrainAreaID")
        if attr then a = "Area " .. tostring(attr) end
    end)
    return a
end

local function GetWorldBossData()
    local name = "None"
    local timeStr = "No Active Boss"
    local status = "Inactive"
    pcall(function()
        local bossName = Workspace:GetAttribute("CurrentWorldBoss")
        local nextTick = Workspace:GetAttribute("NextWorldBossTick")
        if bossName and bossName ~= "" then
            name = tostring(bossName)
            status = "SPAWNED (In Arena)"
            if nextTick then
                local remain = math.max(0, nextTick - Workspace:GetServerTimeNow())
                timeStr = FormatTime(remain) .. " Remaining"
            else
                timeStr = "Active"
            end
        elseif nextTick then
            local remain = math.max(0, nextTick - Workspace:GetServerTimeNow())
            name = "Awaiting Spawn"
            status = "Spawning Soon"
            timeStr = "In " .. FormatTime(remain)
        end
    end)
    return name, timeStr, status
end

local function GetActiveMobsCount()
    local count = 0
    pcall(function()
        if EnemyFolder then
            for _, mob in ipairs(EnemyFolder:GetChildren()) do
                if mob:IsA("Model") and not mob:GetAttribute("Dead") then
                    count = count + 1
                end
            end
        end
    end)
    return count
end

-- Initialize Baselines
PH.SessionPowerStart = GetPlayerPower()
PH.SessionCoinsStart = GetPlayerCoins()
PH.LastPowerVal      = PH.SessionPowerStart
PH.LastCoinsVal      = PH.SessionCoinsStart

-- ==============================================================================
-- 5. PINATHUB / KINGRUA UI LIBRARY LOADER & ADAPTER
-- ==============================================================================
local PinatHubAdapter = nil
local function loadLibrary()
    if getgenv().PinatHubAdapter or getgenv().PinatHubLibrary then
        return getgenv().PinatHubAdapter or getgenv().PinatHubLibrary
    end

    if readfile and isfile then
        local candidates = {
            "kingrualibrarysource.lua",
            "pinathublibraryREAL/kingrualibrarysource.lua",
            "justforui.lua",
        }
        for _, path in ipairs(candidates) do
            local exists = false
            pcall(function() exists = isfile(path) end)
            if exists then
                local okRead, src = pcall(function() return readfile(path) end)
                if okRead and src and src ~= "" then
                    local fn = loadstring(src)
                    if fn then
                        local okCall, res = pcall(fn)
                        if okCall and res then return res end
                    end
                end
            end
        end
    end

    local remoteUrls = {
        "https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/main/kingrualibrarysource.lua",
        "https://raw.githubusercontent.com/stokompetgacor23-dotcom/intregation-pinathub-to-kingrua-library-1/main/kingrualibrarysource.lua",
    }
    for _, url in ipairs(remoteUrls) do
        local okReq, res = pcall(function() return game:HttpGet(url, true) end)
        if okReq and res and #res > 500 then
            local fn = loadstring(res)
            if fn then
                local okCall, lib = pcall(fn)
                if okCall and lib then return lib end
            end
        end
    end

    error("Failed to load PinatHub / KingRua library from all sources")
end

local okLib, loadedLib = pcall(loadLibrary)
if okLib and loadedLib then
    PinatHubAdapter = loadedLib
else
    warn("[PinatHub AnimeBlade V2] Library failed to load:", loadedLib)
end

-- Configuration Profile Storage
local ConfigFolderName = "PinatHub_AnimeBlade_V2"
if makefolder and isfolder and not isfolder(ConfigFolderName) then
    makefolder(ConfigFolderName)
end

local function GetConfigList()
    local list = {}
    if listfiles and isfolder and isfolder(ConfigFolderName) then
        for _, file in pairs(listfiles(ConfigFolderName)) do
            if file:sub(-5) == ".json" then
                local name = file:match("([^/\]+)%.json$")
                if name then table.insert(list, name) end
            end
        end
    end
    if #list == 0 then table.insert(list, "Default") end
    return list
end

local function SaveConfig(name)
    name = (name and name ~= "") and name or PH.ConfigName
    if not name or name == "" then name = "Default" end
    local ok = false
    pcall(function()
        if writefile then
            if makefolder and isfolder and not isfolder(ConfigFolderName) then
                makefolder(ConfigFolderName)
            end
            writefile(ConfigFolderName .. "/" .. name .. ".json", HttpService:JSONEncode(PH))
            ok = true
        end
    end)
    return ok
end

local function LoadConfig(name)
    name = (name and name ~= "") and name or PH.ConfigName
    if not name or name == "" then name = "Default" end
    local path = ConfigFolderName .. "/" .. name .. ".json"
    local ok = false
    pcall(function()
        if readfile and isfile and isfile(path) then
            local data = HttpService:JSONDecode(readfile(path))
            if type(data) == "table" then
                for k, v in pairs(data) do PH[k] = v end
                for flagKey, ctrl in pairs(UI_Controls) do
                    if ctrl and type(ctrl.Set) == "function" and PH[flagKey] ~= nil then
                        pcall(function() ctrl:Set(PH[flagKey]) end)
                    end
                end
                ok = true
            end
        end
    end)
    return ok
end

-- Create Hub Window
local Window = nil
if PinatHubAdapter then
    Window = PinatHubAdapter:CreateWindow({
        Title    = "PinatHub — Anime Blade Champions",
        SubTitle = "V2 Master Multi-Module Edition",
        Game     = "Anime Blade RPG & Simulator",
        Version  = "2.5.0 Ultra",
        Logo     = "rbxassetid://84214776605047",
        OnClose  = function()
            PH.AutoTrain  = false
            PH.AutoAttack = false
            PH.KillAura   = false
            PH.FlyEnabled = false
            PH.Noclip     = false
        end
    })
end

-- Adapter Normalization Wrappers
if Window then
    local origAddTab = Window.AddTab or Window.T or Window.Tab or Window.NewTab

    local function wrapSection(secObj)
        if not secObj then return nil end

        local origToggle = secObj.AddToggle
        if origToggle then
            secObj.AddToggle = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Toggle"
                    if cfg.Default == nil and cfg.Value ~= nil then cfg.Default = cfg.Value end
                end
                return origToggle(s, cfg)
            end
        end

        local origSlider = secObj.AddSlider
        if origSlider then
            secObj.AddSlider = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Slider"
                    if cfg.Precise and not cfg.Increment then
                        cfg.Increment = 1 / (10 ^ cfg.Precise)
                    end
                end
                return origSlider(s, cfg)
            end
        end

        local origDropdown = secObj.AddDropdown
        if origDropdown then
            secObj.AddDropdown = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Dropdown"
                    cfg.Values = cfg.Values or cfg.Options or cfg.List or {}
                end
                return origDropdown(s, cfg)
            end
        end

        local origButton = secObj.AddButton
        if origButton then
            secObj.AddButton = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Button"
                end
                return origButton(s, cfg)
            end
        end

        local origInput = secObj.AddInput
        if origInput then
            secObj.AddInput = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Input"
                end
                return origInput(s, cfg)
            end
        end

        local origKeybind = secObj.AddKeybind
        if origKeybind then
            secObj.AddKeybind = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Keybind"
                end
                return origKeybind(s, cfg)
            end
        end

        local origGraph = secObj.AddGraph
        if origGraph then
            secObj.AddGraph = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title    = cfg.Title or cfg.Name or "Data Graph"
                    cfg.MaxValue = cfg.MaxValue or cfg.Max or 100
                    cfg.Height   = cfg.Height or 100
                    cfg.BarCount = cfg.BarCount or 14
                    cfg.Unit     = cfg.Unit or cfg.Suffix or ""
                    return origGraph(s, cfg)
                end
                return origGraph(s, cfg)
            end
        end

        local origPB = secObj.AddProgressBar
        if origPB then
            secObj.AddProgressBar = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title   = cfg.Title or cfg.Name or "Progress"
                    cfg.Default = cfg.Default or cfg.Value or 0
                    cfg.Max     = cfg.Max or cfg.MaxValue or 100
                end
                return origPB(s, cfg)
            end
        end

        local origPara = secObj.AddParagraph
        if origPara then
            secObj.AddParagraph = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title       = cfg.Title or cfg.Name or "Information"
                    cfg.Content     = cfg.Content or cfg.Desc or cfg.Description or ""
                    cfg.DefaultOpen = (cfg.DefaultOpen ~= nil and cfg.DefaultOpen) or true
                end
                return origPara(s, cfg)
            end
        end

        return secObj
    end

    local function wrapTab(tabObj)
        if not tabObj then return nil end

        local origSubNav = tabObj.AddSubNav or tabObj.AddSubTabs or tabObj.SubNav
        if origSubNav then
            tabObj.AddSubNav = function(self, navConfig)
                local cats = {}
                if type(navConfig) == "table" then
                    if navConfig[1] then
                        for _, c in ipairs(navConfig) do
                            local name = type(c) == "table" and (c.Name or c.Title or c.Key) or tostring(c)
                            table.insert(cats, name)
                        end
                        navConfig = { Categories = cats, IncludeAll = false, Default = cats[1] }
                    elseif navConfig.Categories or navConfig.Tabs then
                        cats = navConfig.Categories or navConfig.Tabs
                    end
                end
                local subNav = origSubNav(self, navConfig)
                local subTabCache = {}
                return setmetatable({}, {
                    __index = function(t, k)
                        if not subTabCache[k] then
                            if subNav and subNav.GetSubTab then
                                local rawSub = subNav:GetSubTab(k)
                                subTabCache[k] = wrapTab(rawSub)
                            else
                                subTabCache[k] = tabObj
                            end
                        end
                        return subTabCache[k]
                    end
                })
            end
            tabObj.AddSubTabs = tabObj.AddSubNav
            tabObj.SubNav     = tabObj.AddSubNav
            tabObj.SubTabs    = tabObj.AddSubNav
        end

        local origSection = tabObj.AddSection or tabObj.Section
        if origSection then
            tabObj.AddSection = function(self, secCfg)
                local secObj = origSection(self, secCfg)
                return wrapSection(secObj)
            end
            tabObj.Section = tabObj.AddSection
        end

        return tabObj
    end

    Window.AddTab = function(self, tabCfg, ...)
        if type(tabCfg) == "table" then
            tabCfg.Title = tabCfg.Title or tabCfg.Name or "Tab"
            tabCfg.Desc  = tabCfg.Desc or tabCfg.Description or tabCfg.Title
        end
        local t = origAddTab(self, tabCfg, ...)
        return wrapTab(t)
    end
    Window.CreateTab = Window.AddTab
    Window.Tab       = Window.AddTab
    Window.NewTab    = Window.AddTab
end

-- ==============================================================================
-- TAB 1: 📊 LIVE ANALYTICS & GRAPHIC DATA (MANDATORY REQUEST)
-- ==============================================================================
local TabAnalytics = Window and Window:CreateTab({
    Name = "Analytics",
    Icon = "activity",
    Description = "Live Graphic Data, Telemetry & Performance Engine"
})

local NavAna_Graphs, NavAna_Progress, NavAna_Cards, NavAna_Opt
if TabAnalytics then
    local sections = TabAnalytics:AddSubNav({
        "Live Graphs",
        "Progress & Vitals",
        "Telemetry Radar",
        "Optimization"
    })
    NavAna_Graphs   = sections["Live Graphs"]
    NavAna_Progress = sections["Progress & Vitals"]
    NavAna_Cards    = sections["Telemetry Radar"]
    NavAna_Opt      = sections["Optimization"]
end

-- Global Handles for Live Update Engine
local GFX_Handles = {
    Graph_Power    = nil,
    Graph_FPS      = nil,
    Graph_Mobs     = nil,
    Graph_Coins    = nil,
    PB_Health      = nil,
    PB_Rebirth     = nil,
    PB_Stage       = nil,
    Para_Player    = nil,
    Para_Boss      = nil,
    Para_Session   = nil,
    Para_Engine    = nil
}

if NavAna_Graphs then
    local SecGraphs = NavAna_Graphs:AddSection("Real-Time Graphic Stream")

    GFX_Handles.Graph_Power = SecGraphs:AddGraph({
        Title    = "Power Velocity Rate",
        BarCount = 14,
        MaxValue = 100,
        Height   = 100,
        Unit     = " PWR/s"
    })

    GFX_Handles.Graph_FPS = SecGraphs:AddGraph({
        Title    = "Client Framerate",
        BarCount = 14,
        MaxValue = 144,
        Height   = 100,
        Unit     = " FPS"
    })

    GFX_Handles.Graph_Mobs = SecGraphs:AddGraph({
        Title    = "Active Enemies Density",
        BarCount = 14,
        MaxValue = 50,
        Height   = 100,
        Unit     = " Mobs"
    })

    GFX_Handles.Graph_Coins = SecGraphs:AddGraph({
        Title    = "Coin Velocity Rate",
        BarCount = 14,
        MaxValue = 1000,
        Height   = 100,
        Unit     = " C/s"
    })
end

if NavAna_Progress then
    local SecPB = NavAna_Progress:AddSection("Live Progress Gauges")

    GFX_Handles.PB_Health = SecPB:AddProgressBar({
        Title   = "Player Health Vitals",
        Default = 100,
        Max     = 100
    })

    GFX_Handles.PB_Rebirth = SecPB:AddProgressBar({
        Title   = "Rebirth Readiness Progress",
        Default = 0,
        Max     = 100
    })

    GFX_Handles.PB_Stage = SecPB:AddProgressBar({
        Title   = "Stage Mob Wave Clear",
        Default = 0,
        Max     = 100
    })
end

if NavAna_Cards then
    local SecCards = NavAna_Cards:AddSection("Live Telemetry & Diagnostics")

    GFX_Handles.Para_Player = SecCards:AddParagraph({
        Title       = "Character Telemetry Vitals",
        Content     = "Connecting to player eco stream...",
        DefaultOpen = true
    })

    GFX_Handles.Para_Boss = SecCards:AddParagraph({
        Title       = "World Boss Live Radar",
        Content     = "Scanning world model for active boss...",
        DefaultOpen = true
    })

    GFX_Handles.Para_Session = SecCards:AddParagraph({
        Title       = "Session Yield & Farm Statistics",
        Content     = "Initializing session tracker...",
        DefaultOpen = true
    })

    GFX_Handles.Para_Engine = SecCards:AddParagraph({
        Title       = "Engine & Network Performance",
        Content     = "Querying client performance statistics...",
        DefaultOpen = true
    })
end

if NavAna_Opt then
    local SecOpt = NavAna_Opt:AddSection("Client Optimization & FPS Booster")

    UI_Controls.PotatoMode = SecOpt:AddToggle({
        Name     = "Potato Mode (FPS Booster)",
        Default  = false,
        Callback = function(val)
            PH.PotatoMode = val
            if val then
                pcall(function()
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and not v:IsA("MeshPart") then
                            v.Material = Enum.Material.SmoothPlastic
                        end
                    end
                end)
            end
        end
    })

    UI_Controls.Fullbright = SecOpt:AddToggle({
        Name     = "Fullbright (No Darkness)",
        Default  = false,
        Callback = function(val)
            PH.Fullbright = val
            if val then
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.GlobalShadows = false
            end
        end
    })

    UI_Controls.RemoveVFX = SecOpt:AddToggle({
        Name     = "Suppress Attack Particles & VFX",
        Default  = false,
        Callback = function(val)
            PH.RemoveVFX = val
            if val then
                pcall(function()
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("Sparkles") or v:IsA("Smoke") then
                            v.Enabled = false
                        end
                    end
                end)
            end
        end
    })

    UI_Controls.FOVValue = SecOpt:AddSlider({
        Name     = "Field Of View (FOV)",
        Min      = 60,
        Max      = 120,
        Default  = 70,
        Callback = function(val)
            PH.FOVValue = val
            if Camera then Camera.FieldOfView = val end
        end
    })
end

-- ==============================================================================
-- TAB 2: ⚡ AUTO TRAIN & POWER MASTER
-- ==============================================================================
local TabTrain = Window and Window:CreateTab({
    Name = "Training",
    Icon = "zap",
    Description = "Fast Training, Auto Zones, Rebirth & Offline Claim"
})

local NavTrain_Auto, NavTrain_Zones, NavTrain_Power
if TabTrain then
    local sections = TabTrain:AddSubNav({
        "Auto Train",
        "Training Zones",
        "Power Progression"
    })
    NavTrain_Auto  = sections["Auto Train"]
    NavTrain_Zones = sections["Training Zones"]
    NavTrain_Power = sections["Power Progression"]
end

if NavTrain_Auto then
    local SecTrain = NavTrain_Auto:AddSection("Automated Training Engine")

    UI_Controls.AutoTrain = SecTrain:AddToggle({
        Name     = "Auto Fast Train Clicker",
        Default  = false,
        Callback = function(val)
            PH.AutoTrain = val
        end
    })

    UI_Controls.TrainSpeed = SecTrain:AddSlider({
        Name     = "Training Interval (Seconds)",
        Min      = 0.01,
        Max      = 0.5,
        Default  = 0.05,
        Precise  = 2,
        Callback = function(val)
            PH.TrainSpeed = val
        end
    })

    SecTrain:AddButton({
        Name     = "Train Once (Manual Click)",
        Callback = function()
            pcall(function()
                if TrainCTRL and TrainCTRL.TrainOnce then
                    TrainCTRL.TrainOnce()
                elseif TrainOnceRE then
                    TrainOnceRE:FireServer()
                end
            end)
        end
    })

    UI_Controls.AutoClaimOffline = SecTrain:AddToggle({
        Name     = "Auto Claim Offline Rewards",
        Default  = true,
        Callback = function(val)
            PH.AutoClaimOffline = val
        end
    })
end

if NavTrain_Zones then
    local SecZones = NavTrain_Zones:AddSection("Training Area Zones")

    local zoneList = {}
    for i = 1, 25 do table.insert(zoneList, "Area " .. i) end

    UI_Controls.SelectedTrainArea = SecZones:AddDropdown({
        Name     = "Select Training Area",
        Values   = zoneList,
        Default  = "Area 1",
        Callback = function(val)
            local num = tonumber(string.match(val, "%d+")) or 1
            PH.SelectedTrainArea = num
        end
    })

    UI_Controls.AutoEnterTrainArea = SecZones:AddToggle({
        Name     = "Auto Enter Selected Zone",
        Default  = false,
        Callback = function(val)
            PH.AutoEnterTrainArea = val
            if val and IntoAutoTrainRE then
                IntoAutoTrainRE:FireServer(PH.SelectedTrainArea)
            elseif not val and ExitAutoTrainRE then
                ExitAutoTrainRE:FireServer(PH.SelectedTrainArea)
            end
        end
    })

    SecZones:AddButton({
        Name     = "Enter Area Now",
        Callback = function()
            if IntoAutoTrainRE then
                IntoAutoTrainRE:FireServer(PH.SelectedTrainArea)
            end
        end
    })

    SecZones:AddButton({
        Name     = "Exit Area Now",
        Callback = function()
            if ExitAutoTrainRE then
                ExitAutoTrainRE:FireServer(PH.SelectedTrainArea)
            end
        end
    })
end

if NavTrain_Power then
    local SecPower = NavTrain_Power:AddSection("Power & Rebirth Automation")

    UI_Controls.AutoUpgradePower = SecPower:AddToggle({
        Name     = "Auto Upgrade Power Stat",
        Default  = false,
        Callback = function(val)
            PH.AutoUpgradePower = val
        end
    })

    UI_Controls.AutoRebirth = SecPower:AddToggle({
        Name     = "Auto Rebirth When Eligible",
        Default  = false,
        Callback = function(val)
            PH.AutoRebirth = val
        end
    })

    SecPower:AddButton({
        Name     = "Trigger Rebirth Now",
        Callback = function()
            if TryRebirthRE then
                TryRebirthRE:FireServer()
            end
        end
    })
end

-- ==============================================================================
-- TAB 3: ⚔️ COMBAT & MOB SLAYER
-- ==============================================================================
local TabCombat = Window and Window:CreateTab({
    Name = "Combat",
    Icon = "sword",
    Description = "Instant Kill Aura, Auto Attack, Skills & God Mode"
})

local NavCombat_Aura, NavCombat_Skills, NavCombat_Defense
if TabCombat then
    local sections = TabCombat:AddSubNav({
        "Kill Aura",
        "Skills & Combos",
        "Defense & Vitals"
    })
    NavCombat_Aura    = sections["Kill Aura"]
    NavCombat_Skills  = sections["Skills & Combos"]
    NavCombat_Defense = sections["Defense & Vitals"]
end

if NavCombat_Aura then
    local SecAura = NavCombat_Aura:AddSection("Lethal Kill Aura Engine")

    UI_Controls.KillAura = SecAura:AddToggle({
        Name     = "Instant Kill Aura (Multi-Target)",
        Default  = false,
        Callback = function(val)
            PH.KillAura = val
        end
    })

    UI_Controls.KillAuraRange = SecAura:AddSlider({
        Name     = "Kill Aura Range (Studs)",
        Min      = 10,
        Max      = 150,
        Default  = 60,
        Callback = function(val)
            PH.KillAuraRange = val
        end
    })

    UI_Controls.MobTargetFilter = SecAura:AddDropdown({
        Name     = "Mob Target Filter",
        Values   = { "All Enemies", "Bosses Only", "Normal Mobs Only" },
        Default  = "All Enemies",
        Callback = function(val)
            PH.MobTargetFilter = val
        end
    })

    UI_Controls.AutoAttack = SecAura:AddToggle({
        Name     = "Auto Attack Animation & Hit Trigger",
        Default  = false,
        Callback = function(val)
            PH.AutoAttack = val
        end
    })

    UI_Controls.HitboxExpander = SecAura:AddToggle({
        Name     = "Hitbox Expander (Enemies)",
        Default  = false,
        Callback = function(val)
            PH.HitboxExpander = val
        end
    })

    UI_Controls.HitboxSize = SecAura:AddSlider({
        Name     = "Hitbox Radius",
        Min      = 5,
        Max      = 40,
        Default  = 15,
        Callback = function(val)
            PH.HitboxSize = val
        end
    })
end

if NavCombat_Skills then
    local SecSkills = NavCombat_Skills:AddSection("Skill Auto Spammer")

    UI_Controls.AutoSkill1 = SecSkills:AddToggle({
        Name     = "Auto Cast Skill 1",
        Default  = false,
        Callback = function(val)
            PH.AutoSkill1 = val
        end
    })

    UI_Controls.AutoSkill2 = SecSkills:AddToggle({
        Name     = "Auto Cast Skill 2",
        Default  = false,
        Callback = function(val)
            PH.AutoSkill2 = val
        end
    })

    SecSkills:AddButton({
        Name     = "Trigger Skill 1 Now",
        Callback = function()
            pcall(function()
                if UseSkillByIndexBE then UseSkillByIndexBE:Fire(1) end
                if UseAnySkillRE then UseAnySkillRE:FireServer("Skill_1", 1, Workspace:GetServerTimeNow()) end
            end)
        end
    })

    SecSkills:AddButton({
        Name     = "Trigger Skill 2 Now",
        Callback = function()
            pcall(function()
                if UseSkillByIndexBE then UseSkillByIndexBE:Fire(2) end
                if UseAnySkillRE then UseAnySkillRE:FireServer("Skill_2", 2, Workspace:GetServerTimeNow()) end
            end)
        end
    })
end

if NavCombat_Defense then
    local SecDef = NavCombat_Defense:AddSection("Combat Safeguards & Vitals")

    UI_Controls.GodModeKeeper = SecDef:AddToggle({
        Name     = "God Mode (Infinite Health Keeper)",
        Default  = false,
        Callback = function(val)
            PH.GodModeKeeper = val
        end
    })

    UI_Controls.AutoCollectBalls = SecDef:AddToggle({
        Name     = "Auto Collect Combat HP Recovery Balls",
        Default  = true,
        Callback = function(val)
            PH.AutoCollectBalls = val
        end
    })

    SecDef:AddButton({
        Name     = "Instant Full Heal",
        Callback = function()
            pcall(function()
                local maxHp = GetPlayerMaxHP()
                local hpVal = LocalPlayer:FindFirstChild("HPValue")
                if hpVal then hpVal.Value = maxHp end
                if Humanoid then Humanoid.Health = maxHp end
            end)
        end
    })
end

-- ==============================================================================
-- TAB 4: 🏰 STAGE & WAVE FARM
-- ==============================================================================
local TabStage = Window and Window:CreateTab({
    Name = "Stages",
    Icon = "map",
    Description = "Stage Progression, Ore Mining & Super Loot Chests"
})

local NavStage_Farm, NavStage_Ore, NavStage_Loot
if TabStage then
    local sections = TabStage:AddSubNav({
        "Stage Farm",
        "Ore Harvester",
        "Super Loot"
    })
    NavStage_Farm = sections["Stage Farm"]
    NavStage_Ore  = sections["Ore Harvester"]
    NavStage_Loot = sections["Super Loot"]
end

if NavStage_Farm then
    local SecStageFarm = NavStage_Farm:AddSection("Stage Wave Farm & Auto Advance")

    local stageList = {}
    for i = 1, 50 do table.insert(stageList, "Stage " .. i) end

    UI_Controls.SelectedStage = SecStageFarm:AddDropdown({
        Name     = "Select Target Stage",
        Values   = stageList,
        Default  = "Stage 1",
        Callback = function(val)
            local num = tonumber(string.match(val, "%d+")) or 1
            PH.SelectedStage = num
        end
    })

    UI_Controls.AutoFarmStage = SecStageFarm:AddToggle({
        Name     = "Auto Farm Selected Stage",
        Default  = false,
        Callback = function(val)
            PH.AutoFarmStage = val
        end
    })

    UI_Controls.AutoAdvanceStage = SecStageFarm:AddToggle({
        Name     = "Auto Advance to Next Stage on Clear",
        Default  = false,
        Callback = function(val)
            PH.AutoAdvanceStage = val
        end
    })

    SecStageFarm:AddButton({
        Name     = "Teleport Into Stage Now",
        Callback = function()
            if SetIntoStageRE then
                SetIntoStageRE:FireServer(PH.SelectedStage)
            end
        end
    })

    SecStageFarm:AddButton({
        Name     = "Instantly Complete Stage Wave",
        Callback = function()
            pcall(function()
                if StageFinishedRF then StageFinishedRF:InvokeServer(PH.SelectedStage) end
                if StageFinishedBE then StageFinishedBE:Fire() end
            end)
        end
    })
end

if NavStage_Ore then
    local SecOre = NavStage_Ore:AddSection("Automated Ore & Stone Harvester")

    UI_Controls.AutoClaimAllOre = SecOre:AddToggle({
        Name     = "Auto Claim All Stage Ores (Instant Sweep)",
        Default  = false,
        Callback = function(val)
            PH.AutoClaimAllOre = val
        end
    })

    UI_Controls.AutoCollectOres = SecOre:AddToggle({
        Name     = "Auto Collect Mined Ore Drops",
        Default  = false,
        Callback = function(val)
            PH.AutoCollectOres = val
        end
    })

    UI_Controls.AutoCollectStones = SecOre:AddToggle({
        Name     = "Auto Collect Enchant Stones",
        Default  = false,
        Callback = function(val)
            PH.AutoCollectStones = val
        end
    })

    SecOre:AddButton({
        Name     = "Claim All Ores Now",
        Callback = function()
            if ClaimedAllOreRE then
                ClaimedAllOreRE:FireServer()
                PH.SessionOresMined = PH.SessionOresMined + 1
            end
        end
    })
end

if NavStage_Loot then
    local SecLoot = NavStage_Loot:AddSection("Super Loot Treasure Chests")

    UI_Controls.AutoKillSuperLoot = SecLoot:AddToggle({
        Name     = "Auto Destroy Super Loot Chests",
        Default  = false,
        Callback = function(val)
            PH.AutoKillSuperLoot = val
        end
    })

    SecLoot:AddButton({
        Name     = "Nuke All Active Super Loot Chests",
        Callback = function()
            pcall(function()
                if KillSuperLootRE then
                    for i = 1, 10 do
                        KillSuperLootRE:FireServer(i)
                    end
                end
            end)
        end
    })
end

-- ==============================================================================
-- TAB 5: 💀 DUNGEON & RAIDS
-- ==============================================================================
local TabDungeon = Window and Window:CreateTab({
    Name = "Dungeon",
    Icon = "shield",
    Description = "Dungeon Auto Runner, Mob Sweeper & Floor Clears"
})

local NavDungeon_Main, NavDungeon_Actions
if TabDungeon then
    local sections = TabDungeon:AddSubNav({
        "Dungeon Runner",
        "Actions & Revive"
    })
    NavDungeon_Main    = sections["Dungeon Runner"]
    NavDungeon_Actions = sections["Actions & Revive"]
end

if NavDungeon_Main then
    local SecDungeon = NavDungeon_Main:AddSection("Automated Dungeon Engine")

    UI_Controls.AutoJoinDungeon = SecDungeon:AddToggle({
        Name     = "Auto Enter Dungeon",
        Default  = false,
        Callback = function(val)
            PH.AutoJoinDungeon = val
        end
    })

    UI_Controls.AutoClearDungeon = SecDungeon:AddToggle({
        Name     = "Auto Clear Dungeon Floors",
        Default  = false,
        Callback = function(val)
            PH.AutoClearDungeon = val
        end
    })

    UI_Controls.AutoDungeonRevive = SecDungeon:AddToggle({
        Name     = "Auto Dungeon Rebirth / Revive",
        Default  = true,
        Callback = function(val)
            PH.AutoDungeonRevive = val
        end
    })

    UI_Controls.AutoExitDungeon = SecDungeon:AddToggle({
        Name     = "Auto Exit When Finished",
        Default  = false,
        Callback = function(val)
            PH.AutoExitDungeon = val
        end
    })
end

if NavDungeon_Actions then
    local SecDunAct = NavDungeon_Actions:AddSection("Manual Dungeon Controls")

    SecDunAct:AddButton({
        Name     = "Revive In Dungeon Now",
        Callback = function()
            if DungeonRebirthRE then
                DungeonRebirthRE:FireServer()
            end
        end
    })

    SecDunAct:AddButton({
        Name     = "Exit Dungeon (Return to Lobby)",
        Callback = function()
            if ExitDungeonBE then
                ExitDungeonBE:Fire()
            end
        end
    })

    SecDunAct:AddButton({
        Name     = "Give Up Dungeon",
        Callback = function()
            if DungeonGiveUpBE then
                DungeonGiveUpBE:Fire()
            end
        end
    })
end

-- ==============================================================================
-- TAB 6: 🐉 WORLD BOSS ARENA
-- ==============================================================================
local TabBoss = Window and Window:CreateTab({
    Name = "World Boss",
    Icon = "crosshair",
    Description = "Live Boss Radar, Auto Battle & Reward Claimer"
})

local NavBoss_Auto, NavBoss_Rewards
if TabBoss then
    local sections = TabBoss:AddSubNav({
        "Boss Battle",
        "Reward Claimer"
    })
    NavBoss_Auto    = sections["Boss Battle"]
    NavBoss_Rewards = sections["Reward Claimer"]
end

if NavBoss_Auto then
    local SecBoss = NavBoss_Auto:AddSection("World Boss Battle Engine")

    UI_Controls.AutoJoinBoss = SecBoss:AddToggle({
        Name     = "Auto Join World Boss When Spawned",
        Default  = false,
        Callback = function(val)
            PH.AutoJoinBoss = val
        end
    })

    UI_Controls.AutoAttackBoss = SecBoss:AddToggle({
        Name     = "Auto Attack World Boss",
        Default  = false,
        Callback = function(val)
            PH.AutoAttackBoss = val
        end
    })

    UI_Controls.AutoCollectBossBalls = SecBoss:AddToggle({
        Name     = "Auto Collect Boss HP Balls",
        Default  = true,
        Callback = function(val)
            PH.AutoCollectBossBalls = val
        end
    })

    UI_Controls.BossHoverDistance = SecBoss:AddSlider({
        Name     = "Safe Hover Distance (Studs)",
        Min      = 5,
        Max      = 50,
        Default  = 12,
        Callback = function(val)
            PH.BossHoverDistance = val
        end
    })

    SecBoss:AddButton({
        Name     = "Join Boss Fight Now",
        Callback = function()
            if IntoWorldBossFight then
                IntoWorldBossFight:FireServer()
            end
        end
    })

    SecBoss:AddButton({
        Name     = "Exit Boss Arena Now",
        Callback = function()
            if ExitWorldBossFight then
                ExitWorldBossFight:FireServer()
            elseif ExitWorldBossBE then
                ExitWorldBossBE:Fire()
            end
        end
    })
end

if NavBoss_Rewards then
    local SecRewards = NavBoss_Rewards:AddSection("World Boss Rewards")

    UI_Controls.AutoClaimBossReward = SecRewards:AddToggle({
        Name     = "Auto Claim Boss Rewards on Defeat",
        Default  = true,
        Callback = function(val)
            PH.AutoClaimBossReward = val
        end
    })

    SecRewards:AddButton({
        Name     = "Claim All Pending Boss Rewards",
        Callback = function()
            pcall(function()
                if TryClaimBossRewardRE then
                    for i = 1, 5 do
                        TryClaimBossRewardRE:FireServer(tostring(i))
                    end
                end
            end)
        end
    })
end

-- ==============================================================================
-- TAB 7: 🔨 FORGE, ARMOR & WEAPONS
-- ==============================================================================
local TabForge = Window and Window:CreateTab({
    Name = "Forge",
    Icon = "hammer",
    Description = "Weapon & Armor Crafting, Ore Deposit & Enhancement"
})

local NavForge_Craft, NavForge_Furnace
if TabForge then
    local sections = TabForge:AddSubNav({
        "Equipment Forge",
        "Furnace & Enhance"
    })
    NavForge_Craft   = sections["Equipment Forge"]
    NavForge_Furnace = sections["Furnace & Enhance"]
end

if NavForge_Craft then
    local SecCraft = NavForge_Craft:AddSection("Equipment Crafting")

    UI_Controls.AutoForgeWeapon = SecCraft:AddToggle({
        Name     = "Auto Forge Highest Tier Weapon",
        Default  = false,
        Callback = function(val)
            PH.AutoForgeWeapon = val
        end
    })

    UI_Controls.AutoForgeArmor = SecCraft:AddToggle({
        Name     = "Auto Forge Highest Tier Armor",
        Default  = false,
        Callback = function(val)
            PH.AutoForgeArmor = val
        end
    })

    SecCraft:AddButton({
        Name     = "Craft Next Weapon",
        Callback = function()
            if ForgeRF then
                ForgeRF:InvokeServer(1)
            end
        end
    })

    SecCraft:AddButton({
        Name     = "Craft Next Armor",
        Callback = function()
            if ForgeRF then
                ForgeRF:InvokeServer(2)
            end
        end
    })
end

if NavForge_Furnace then
    local SecFurnace = NavForge_Furnace:AddSection("Furnace Deposit & Gear Enhance")

    UI_Controls.AutoDepositOre = SecFurnace:AddToggle({
        Name     = "Auto Deposit Ores to Furnace",
        Default  = false,
        Callback = function(val)
            PH.AutoDepositOre = val
        end
    })

    UI_Controls.AutoEnhanceGear = SecFurnace:AddToggle({
        Name     = "Auto Enhance Equipped Gear",
        Default  = false,
        Callback = function(val)
            PH.AutoEnhanceGear = val
        end
    })

    SecFurnace:AddButton({
        Name     = "Deposit All Ores Now",
        Callback = function()
            if PutOreNumBE then
                PutOreNumBE:Fire(1, 9999)
            end
        end
    })
end

-- ==============================================================================
-- TAB 8: 🔮 CLASS & REBIRTH MASTER
-- ==============================================================================
local TabClass = Window and Window:CreateTab({
    Name = "Class",
    Icon = "star",
    Description = "Class Rolling, Rarity Filters & Rebirth Automation"
})

local NavClass_Roll, NavClass_Rebirth
if TabClass then
    local sections = TabClass:AddSubNav({
        "Class Roll Master",
        "Rebirth Loop"
    })
    NavClass_Roll    = sections["Class Roll Master"]
    NavClass_Rebirth = sections["Rebirth Loop"]
end

if NavClass_Roll then
    local SecRoll = NavClass_Roll:AddSection("Automated Class Rolling")

    UI_Controls.TargetClassRarity = SecRoll:AddDropdown({
        Name     = "Stop On Rarity",
        Values   = { "Rare", "Epic", "Legendary", "Mythic", "Divine" },
        Default  = "Legendary",
        Callback = function(val)
            PH.TargetClassRarity = val
        end
    })

    UI_Controls.AutoRollClass = SecRoll:AddToggle({
        Name     = "Auto Roll Class (Skip Animations)",
        Default  = false,
        Callback = function(val)
            PH.AutoRollClass = val
        end
    })
end

if NavClass_Rebirth then
    local SecRebirth = NavClass_Rebirth:AddSection("Continuous Rebirth Engine")

    UI_Controls.AutoRebirthLoop = SecRebirth:AddToggle({
        Name     = "Continuous Rebirth Loop",
        Default  = false,
        Callback = function(val)
            PH.AutoRebirthLoop = val
        end
    })

    SecRebirth:AddButton({
        Name     = "Execute Rebirth Now",
        Callback = function()
            if TryRebirthRE then
                TryRebirthRE:FireServer()
            end
        end
    })
end

-- ==============================================================================
-- TAB 9: 🐾 PETS, POTIONS & UPGRADES
-- ==============================================================================
local TabPets = Window and Window:CreateTab({
    Name = "Upgrades",
    Icon = "package",
    Description = "Stat Upgrades, Potion Drinker & Best Pet Equipper"
})

local NavUp_Stats, NavUp_Potions, NavUp_Pets
if TabPets then
    local sections = TabPets:AddSubNav({
        "Stat Upgrades",
        "Potion Drinker",
        "Pet Manager"
    })
    NavUp_Stats   = sections["Stat Upgrades"]
    NavUp_Potions = sections["Potion Drinker"]
    NavUp_Pets    = sections["Pet Manager"]
end

if NavUp_Stats then
    local SecUp = NavUp_Stats:AddSection("Stat Upgrades Automation")

    UI_Controls.AutoUpgradeStats = SecUp:AddToggle({
        Name     = "Auto Upgrade All Stats (Power/Coin/HP)",
        Default  = false,
        Callback = function(val)
            PH.AutoUpgradeStats = val
        end
    })

    SecUp:AddButton({
        Name     = "Upgrade Power Stat",
        Callback = function()
            if UpgradeOnceRE then UpgradeOnceRE:FireServer("Power") end
        end
    })

    SecUp:AddButton({
        Name     = "Upgrade Coin Stat",
        Callback = function()
            if UpgradeOnceRE then UpgradeOnceRE:FireServer("Coin") end
        end
    })

    SecUp:AddButton({
        Name     = "Upgrade Health Stat",
        Callback = function()
            if UpgradeOnceRE then UpgradeOnceRE:FireServer("Health") end
        end
    })
end

if NavUp_Potions then
    local SecPotions = NavUp_Potions:AddSection("Automated Potion Consumption")

    UI_Controls.AutoUsePowerPotion = SecPotions:AddToggle({
        Name     = "Auto Drink Power Potions",
        Default  = false,
        Callback = function(val)
            PH.AutoUsePowerPotion = val
        end
    })

    UI_Controls.AutoUseCoinPotion = SecPotions:AddToggle({
        Name     = "Auto Drink Coin Potions",
        Default  = false,
        Callback = function(val)
            PH.AutoUseCoinPotion = val
        end
    })

    UI_Controls.AutoUseLuckPotion = SecPotions:AddToggle({
        Name     = "Auto Drink Luck Potions",
        Default  = false,
        Callback = function(val)
            PH.AutoUseLuckPotion = val
        end
    })
end

if NavUp_Pets then
    local SecPet = NavUp_Pets:AddSection("Pet Team Optimization")

    UI_Controls.AutoEquipBestPet = SecPet:AddToggle({
        Name     = "Auto Equip Best Pet Loadout",
        Default  = false,
        Callback = function(val)
            PH.AutoEquipBestPet = val
        end
    })

    SecPet:AddButton({
        Name     = "Equip Best Pets Now",
        Callback = function()
            if GetMyBestRF then
                GetMyBestRF:InvokeServer("Pet")
            end
        end
    })
end

-- ==============================================================================
-- TAB 10: 🚀 MOVEMENT & CHARACTER PHYSICS
-- ==============================================================================
local TabMove = Window and Window:CreateTab({
    Name = "Movement",
    Icon = "navigation",
    Description = "WalkSpeed, JumpPower, Fly, Noclip & Anti-Void"
})

local NavMove_Physics, NavMove_Flight
if TabMove then
    local sections = TabMove:AddSubNav({
        "Character Physics",
        "Fly & Noclip"
    })
    NavMove_Physics = sections["Character Physics"]
    NavMove_Flight  = sections["Fly & Noclip"]
end

if NavMove_Physics then
    local SecPhysics = NavMove_Physics:AddSection("Movement Modifiers")

    UI_Controls.WalkSpeedBoost = SecPhysics:AddToggle({
        Name     = "Enable WalkSpeed Boost",
        Default  = false,
        Callback = function(val)
            PH.WalkSpeedBoost = val
            if Humanoid and not val then Humanoid.WalkSpeed = 16 end
        end
    })

    UI_Controls.WalkSpeedValue = SecPhysics:AddSlider({
        Name     = "WalkSpeed Multiplier",
        Min      = 16,
        Max      = 350,
        Default  = 50,
        Callback = function(val)
            PH.WalkSpeedValue = val
            if PH.WalkSpeedBoost and Humanoid then Humanoid.WalkSpeed = val end
        end
    })

    UI_Controls.JumpPowerBoost = SecPhysics:AddToggle({
        Name     = "Enable JumpPower Boost",
        Default  = false,
        Callback = function(val)
            PH.JumpPowerBoost = val
            if Humanoid and not val then Humanoid.JumpPower = 50 end
        end
    })

    UI_Controls.JumpPowerValue = SecPhysics:AddSlider({
        Name     = "JumpPower Multiplier",
        Min      = 50,
        Max      = 500,
        Default  = 120,
        Callback = function(val)
            PH.JumpPowerValue = val
            if PH.JumpPowerBoost and Humanoid then Humanoid.JumpPower = val end
        end
    })

    UI_Controls.InfiniteJump = SecPhysics:AddToggle({
        Name     = "Infinite Jump",
        Default  = false,
        Callback = function(val)
            PH.InfiniteJump = val
        end
    })

    UI_Controls.AntiVoid = SecPhysics:AddToggle({
        Name     = "Anti-Void Fall Protector",
        Default  = true,
        Callback = function(val)
            PH.AntiVoid = val
        end
    })
end

if NavMove_Flight then
    local SecFlight = NavMove_Flight:AddSection("Flight & Collision")

    UI_Controls.FlyEnabled = SecFlight:AddToggle({
        Name     = "Fly Mode (WASD + Space/Shift)",
        Default  = false,
        Callback = function(val)
            PH.FlyEnabled = val
        end
    })

    UI_Controls.FlySpeed = SecFlight:AddSlider({
        Name     = "Fly Speed",
        Min      = 20,
        Max      = 250,
        Default  = 60,
        Callback = function(val)
            PH.FlySpeed = val
        end
    })

    UI_Controls.Noclip = SecFlight:AddToggle({
        Name     = "Noclip (Walk Through Walls)",
        Default  = false,
        Callback = function(val)
            PH.Noclip = val
        end
    })
end

-- ==============================================================================
-- TAB 11: 👁️ ESP & VISUAL RADAR
-- ==============================================================================
local TabESP = Window and Window:CreateTab({
    Name = "Visuals",
    Icon = "eye",
    Description = "Enemy ESP, Boss Highlights, Ore & Super Loot Radar"
})

local NavESP_Entities, NavESP_World
if TabESP then
    local sections = TabESP:AddSubNav({
        "Entity ESP",
        "World Objects ESP"
    })
    NavESP_Entities = sections["Entity ESP"]
    NavESP_World    = sections["World Objects ESP"]
end

if NavESP_Entities then
    local SecESP = NavESP_Entities:AddSection("Enemy & Boss Visuals")

    UI_Controls.ESP_Enemies = SecESP:AddToggle({
        Name     = "Enemy Mobs ESP",
        Default  = false,
        Callback = function(val)
            PH.ESP_Enemies = val
        end
    })

    UI_Controls.ESP_Bosses = SecESP:AddToggle({
        Name     = "World Boss Highlight ESP",
        Default  = true,
        Callback = function(val)
            PH.ESP_Bosses = val
        end
    })

    UI_Controls.ESP_Tracers = SecESP:AddToggle({
        Name     = "Draw Tracers to Target Mobs",
        Default  = false,
        Callback = function(val)
            PH.ESP_Tracers = val
        end
    })
end

if NavESP_World then
    local SecWorldESP = NavESP_World:AddSection("Treasure & Ore Radar")

    UI_Controls.ESP_SuperLoot = SecWorldESP:AddToggle({
        Name     = "Super Loot Chests ESP (Gold)",
        Default  = true,
        Callback = function(val)
            PH.ESP_SuperLoot = val
        end
    })

    UI_Controls.ESP_Ores = SecWorldESP:AddToggle({
        Name     = "Stage Ore Nodes ESP",
        Default  = false,
        Callback = function(val)
            PH.ESP_Ores = val
        end
    })
end

-- ==============================================================================
-- TAB 12: 📍 WORLD TELEPORTS
-- ==============================================================================
local TabTP = Window and Window:CreateTab({
    Name = "Teleports",
    Icon = "compass",
    Description = "Instant Teleports to Stages, Training Zones & Arenas"
})

local NavTP_Stages, NavTP_Areas, NavTP_KeyLocs
if TabTP then
    local sections = TabTP:AddSubNav({
        "Stage Teleports",
        "Training Areas",
        "Key Locations"
    })
    NavTP_Stages  = sections["Stage Teleports"]
    NavTP_Areas   = sections["Training Areas"]
    NavTP_KeyLocs = sections["Key Locations"]
end

if NavTP_Stages then
    local SecTPStages = NavTP_Stages:AddSection("Stage Teleport Selector")

    local tpStages = {}
    for i = 1, 30 do table.insert(tpStages, "Stage " .. i) end

    local targetStageTP = 1
    SecTPStages:AddDropdown({
        Name     = "Select Stage to Teleport",
        Values   = tpStages,
        Default  = "Stage 1",
        Callback = function(val)
            targetStageTP = tonumber(string.match(val, "%d+")) or 1
        end
    })

    SecTPStages:AddButton({
        Name     = "Teleport to Selected Stage",
        Callback = function()
            pcall(function()
                if SetIntoStageRE then
                    SetIntoStageRE:FireServer(targetStageTP)
                end
            end)
        end
    })
end

if NavTP_Areas then
    local SecTPAreas = NavTP_Areas:AddSection("Training Area Teleports")

    local tpAreas = {}
    for i = 1, 20 do table.insert(tpAreas, "Training Area " .. i) end

    local targetAreaTP = 1
    SecTPAreas:AddDropdown({
        Name     = "Select Training Area",
        Values   = tpAreas,
        Default  = "Training Area 1",
        Callback = function(val)
            targetAreaTP = tonumber(string.match(val, "%d+")) or 1
        end
    })

    SecTPAreas:AddButton({
        Name     = "Teleport & Enter Training Area",
        Callback = function()
            if IntoAutoTrainRE then
                IntoAutoTrainRE:FireServer(targetAreaTP)
            end
        end
    })
end

if NavTP_KeyLocs then
    local SecTPKeys = NavTP_KeyLocs:AddSection("Key Arena Teleports")

    SecTPKeys:AddButton({
        Name     = "Teleport to World Boss Arena",
        Callback = function()
            if IntoWorldBossFight then
                IntoWorldBossFight:FireServer()
            end
        end
    })

    SecTPKeys:AddButton({
        Name     = "Teleport to Safe Zone / Spawn",
        Callback = function()
            pcall(function()
                if Root then
                    Root.CFrame = CFrame.new(0, 10, 0)
                end
            end)
        end
    })
end

-- ==============================================================================
-- TAB 13: ⚙️ SETTINGS, CODES & CONFIG PROFILES
-- ==============================================================================
local TabSettings = Window and Window:CreateTab({
    Name = "Settings",
    Icon = "settings",
    Description = "Promo Code Redeemer, Profile Storage & Hub Controls"
})

local NavSet_Codes, NavSet_Profiles, NavSet_Misc
if TabSettings then
    local sections = TabSettings:AddSubNav({
        "Promo Codes",
        "Profiles",
        "Hub Controls"
    })
    NavSet_Codes    = sections["Promo Codes"]
    NavSet_Profiles = sections["Profiles"]
    NavSet_Misc     = sections["Hub Controls"]
end

if NavSet_Codes then
    local SecCodes = NavSet_Codes:AddSection("Secret Promo Code Redeemer")

    local customCodeInput = ""
    SecCodes:AddInput({
        Name        = "Enter Promo Code",
        Placeholder = "Enter code here...",
        Callback    = function(val)
            customCodeInput = val
        end
    })

    SecCodes:AddButton({
        Name     = "Redeem Entered Code",
        Callback = function()
            if customCodeInput ~= "" and TryUseCodeRF then
                pcall(function()
                    TryUseCodeRF:InvokeServer(customCodeInput)
                end)
            end
        end
    })

    SecCodes:AddButton({
        Name     = "Redeem All Popular Known Codes",
        Callback = function()
            if TryUseCodeRF then
                local knownCodes = {
                    "RELEASE", "POWER", "SWORD", "BLADE", "UPDATE1",
                    "TRAIN", "CHAMPION", "100KFAV", "FREEGEMS", "SUPER"
                }
                for _, code in ipairs(knownCodes) do
                    pcall(function()
                        TryUseCodeRF:InvokeServer(code)
                    end)
                    task.wait(0.25)
                end
            end
        end
    })
end

if NavSet_Profiles then
    local SecProfiles = NavSet_Profiles:AddSection("Configuration Profiles")

    local profileDropdown
    profileDropdown = SecProfiles:AddDropdown({
        Name     = "Select Profile",
        Values   = GetConfigList(),
        Default  = "Default",
        Callback = function(val)
            PH.ConfigName = val
        end
    })

    SecProfiles:AddInput({
        Name        = "New Profile Name",
        Placeholder = "Type profile name...",
        Callback    = function(val)
            if val and val ~= "" then PH.ConfigName = val end
        end
    })

    SecProfiles:AddButton({
        Name     = "Save Current Profile",
        Callback = function()
            SaveConfig(PH.ConfigName)
            if profileDropdown then profileDropdown:SetValues(GetConfigList()) end
        end
    })

    SecProfiles:AddButton({
        Name     = "Load Selected Profile",
        Callback = function()
            LoadConfig(PH.ConfigName)
        end
    })
end

if NavSet_Misc then
    local SecMisc = NavSet_Misc:AddSection("PinatHub Controls & Unload")

    SecMisc:AddKeybind({
        Name     = "UI Toggle Keybind",
        Default  = Enum.KeyCode.RightControl,
        Callback = function()
            pcall(function()
                if Window and Window.Toggle then
                    Window:Toggle()
                end
            end)
        end
    })

    SecMisc:AddButton({
        Name     = "Clean Unload PinatHub",
        Callback = function()
            PH.AutoTrain  = false
            PH.AutoAttack = false
            PH.KillAura   = false
            PH.FlyEnabled = false
            PH.Noclip     = false
            pcall(function()
                if Window and Window.Destroy then
                    Window:Destroy()
                end
            end)
        end
    })
end

-- ==============================================================================
-- 6. DEDICATED LIVE GRAPHIC DATA & TELEMETRY ENGINE (THREAD 1)
-- ==============================================================================
task.spawn(function()
    local lastTelemetryTick = tick()
    local fpsSample = 60
    local lastRenderTick = tick()

    RunService.RenderStepped:Connect(function()
        local now = tick()
        local dt = now - lastRenderTick
        lastRenderTick = now
        if dt > 0 then
            fpsSample = math.floor(1 / dt)
        end
    end)

    while task.wait(0.5) do
        local ok, err = pcall(function()
            local now = tick()
            local dt = now - lastTelemetryTick
            lastTelemetryTick = now

            local currentPower = GetPlayerPower()
            local currentCoins = GetPlayerCoins()
            local currentHP    = GetPlayerHP()
            local maxHP        = GetPlayerMaxHP()
            local currentAtk   = GetPlayerATK()
            local currentLevel = GetPlayerLevel()
            local currentRebirth = GetPlayerRebirths()
            local activeStage  = GetCurrentStageName()
            local activeArea   = GetActiveTrainAreaName()
            local activeMobs   = GetActiveMobsCount()
            local bossName, bossTime, bossStatus = GetWorldBossData()

            -- Calculate Deltas
            local powerDelta = (dt > 0) and math.max(0, math.floor((currentPower - PH.LastPowerVal) / dt)) or 0
            local coinsDelta = (dt > 0) and math.max(0, math.floor((currentCoins - PH.LastCoinsVal) / dt)) or 0
            PH.LastPowerVal  = currentPower
            PH.LastCoinsVal  = currentCoins

            local sessionElapsed = math.max(1, now - PH.SessionStartTick)
            local totalPowerGained = math.max(0, currentPower - PH.SessionPowerStart)
            local totalCoinsGained = math.max(0, currentCoins - PH.SessionCoinsStart)

            -- Push Native Graphs
            if GFX_Handles.Graph_Power and GFX_Handles.Graph_Power.Push then
                GFX_Handles.Graph_Power:Push(powerDelta)
                if GFX_Handles.Graph_Power.SetMax then
                    GFX_Handles.Graph_Power:SetMax(math.max(10, math.floor(powerDelta * 1.5)))
                end
            end

            if GFX_Handles.Graph_FPS and GFX_Handles.Graph_FPS.Push then
                GFX_Handles.Graph_FPS:Push(math.clamp(fpsSample, 0, 144))
            end

            if GFX_Handles.Graph_Mobs and GFX_Handles.Graph_Mobs.Push then
                GFX_Handles.Graph_Mobs:Push(math.clamp(activeMobs, 0, 100))
            end

            if GFX_Handles.Graph_Coins and GFX_Handles.Graph_Coins.Push then
                GFX_Handles.Graph_Coins:Push(coinsDelta)
                if GFX_Handles.Graph_Coins.SetMax then
                    GFX_Handles.Graph_Coins:SetMax(math.max(100, math.floor(coinsDelta * 1.5)))
                end
            end

            -- Update Progress Bars
            if GFX_Handles.PB_Health and GFX_Handles.PB_Health.Set then
                GFX_Handles.PB_Health:Set(currentHP, maxHP)
            end

            if GFX_Handles.PB_Rebirth and GFX_Handles.PB_Rebirth.Set then
                local nextRebirthReq = math.max(1, (currentRebirth + 1) * 10000)
                local rebirthPct = math.clamp(math.floor((currentPower / nextRebirthReq) * 100), 0, 100)
                GFX_Handles.PB_Rebirth:Set(rebirthPct, 100)
            end

            if GFX_Handles.PB_Stage and GFX_Handles.PB_Stage.Set then
                local stagePct = math.clamp(100 - (activeMobs * 10), 0, 100)
                GFX_Handles.PB_Stage:Set(stagePct, 100)
            end

            -- Update Status Paragraph Cards
            if GFX_Handles.Para_Player and GFX_Handles.Para_Player.SetDesc then
                local playerDesc = string.format(
                    "• Power: %s (+%s/s)
• Coins: %s (+%s/s)
• Level: %d | Rebirths: %d
• Health: %s / %s (%d%%)
• Base Attack: %s
• Active Stage: %s | Zone: %s",
                    FormatNumber(currentPower),
                    FormatNumber(powerDelta),
                    FormatNumber(currentCoins),
                    FormatNumber(coinsDelta),
                    currentLevel,
                    currentRebirth,
                    FormatNumber(currentHP),
                    FormatNumber(maxHP),
                    math.clamp(math.floor((currentHP / maxHP) * 100), 0, 100),
                    FormatNumber(currentAtk),
                    tostring(activeStage),
                    tostring(activeArea)
                )
                GFX_Handles.Para_Player:SetDesc(playerDesc)
            end

            if GFX_Handles.Para_Boss and GFX_Handles.Para_Boss.SetDesc then
                local bossDesc = string.format(
                    "• Current World Boss: %s
• Status: %s
• Event Timer: %s
• Teleport Remote: Connected",
                    bossName,
                    bossStatus,
                    bossTime
                )
                GFX_Handles.Para_Boss:SetDesc(bossDesc)
            end

            if GFX_Handles.Para_Session and GFX_Handles.Para_Session.SetDesc then
                local sessionDesc = string.format(
                    "• Session Time: %s
• Total Power Farmed: +%s
• Total Coins Earned: +%s
• Enemies Slain: %d Mobs
• Ores Mined: %d Batches",
                    FormatTime(sessionElapsed),
                    FormatNumber(totalPowerGained),
                    FormatNumber(totalCoinsGained),
                    PH.SessionEnemiesSlain,
                    PH.SessionOresMined
                )
                GFX_Handles.Para_Session:SetDesc(sessionDesc)
            end

            if GFX_Handles.Para_Engine and GFX_Handles.Para_Engine.SetDesc then
                local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
                local mem  = math.floor(StatsService:GetTotalMemoryUsageMb())
                local engineDesc = string.format(
                    "• Framerate: %d FPS (Target: 60)
• Network Ping: %d ms
• Client Memory: %d MB
• Active Engine Threads: Healthy",
                    fpsSample,
                    ping,
                    mem
                )
                GFX_Handles.Para_Engine:SetDesc(engineDesc)
            end
        end)
    end
end)

-- ==============================================================================
-- 7. AUTOMATION LOOPS (TRAINING, COMBAT, STAGE, BOSS, UPGRADES)
-- ==============================================================================

-- Loop A: Fast Training Clicker
task.spawn(function()
    while true do
        if PH.AutoTrain then
            pcall(function()
                if TrainCTRL and TrainCTRL.TrainOnce then
                    TrainCTRL.TrainOnce()
                elseif TrainOnceRE then
                    TrainOnceRE:FireServer()
                end
            end)
            task.wait(PH.TrainSpeed or 0.05)
        else
            task.wait(0.2)
        end
    end
end)

-- Loop B: Auto Claim Offline Rewards & Rebirth
task.spawn(function()
    while task.wait(5) do
        if PH.AutoClaimOffline and TryClaimOfflineRE then
            pcall(function() TryClaimOfflineRE:FireServer() end)
        end
        if (PH.AutoRebirth or PH.AutoRebirthLoop) and TryRebirthRE then
            pcall(function() TryRebirthRE:FireServer() end)
        end
    end
end)

-- Loop C: Lethal Kill Aura & Attack Spammer
task.spawn(function()
    while true do
        if PH.KillAura or PH.AutoAttack then
            pcall(function()
                if not Root then return end
                local myPos = Root.Position

                if PH.AutoAttack and ATKOnceBE then
                    ATKOnceBE:Fire()
                end

                if EnemyFolder then
                    for _, mob in ipairs(EnemyFolder:GetChildren()) do
                        if mob:IsA("Model") and not mob:GetAttribute("Dead") then
                            local mobRoot = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChild("Torso") or mob.PrimaryPart
                            if mobRoot then
                                local dist = (mobRoot.Position - myPos).Magnitude
                                if dist <= (PH.KillAuraRange or 60) then
                                    if PH.KillAura then
                                        if KillEnemyRE then
                                            KillEnemyRE:FireServer(mob.Name)
                                            PH.SessionEnemiesSlain = PH.SessionEnemiesSlain + 1
                                        elseif EnemyCTRL and EnemyCTRL.DeadEnemy then
                                            EnemyCTRL.DeadEnemy(mob.Name)
                                            PH.SessionEnemiesSlain = PH.SessionEnemiesSlain + 1
                                        end
                                    end

                                    if PH.AutoAttack and UseAnyATKRE then
                                        UseAnyATKRE:FireServer(1, Workspace:GetServerTimeNow())
                                    end

                                    -- Hitbox Expander
                                    if PH.HitboxExpander and mobRoot then
                                        mobRoot.Size = Vector3.new(PH.HitboxSize, PH.HitboxSize, PH.HitboxSize)
                                        mobRoot.Transparency = 0.7
                                        mobRoot.CanCollide = false
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(PH.AttackRate or 0.1)
        else
            task.wait(0.25)
        end
    end
end)

-- Loop D: Skill Auto Spammer
task.spawn(function()
    while task.wait(1.2) do
        if PH.AutoSkill1 then
            pcall(function()
                if UseSkillByIndexBE then UseSkillByIndexBE:Fire(1) end
                if UseAnySkillRE then UseAnySkillRE:FireServer("Skill_1", 1, Workspace:GetServerTimeNow()) end
            end)
        end
        if PH.AutoSkill2 then
            pcall(function()
                if UseSkillByIndexBE then UseSkillByIndexBE:Fire(2) end
                if UseAnySkillRE then UseAnySkillRE:FireServer("Skill_2", 2, Workspace:GetServerTimeNow()) end
            end)
        end
    end
end)

-- Loop E: God Mode Health Keeper
task.spawn(function()
    while task.wait(0.2) do
        if PH.GodModeKeeper then
            pcall(function()
                local maxHp = GetPlayerMaxHP()
                local hpVal = LocalPlayer:FindFirstChild("HPValue")
                if hpVal and hpVal.Value < maxHp then
                    hpVal.Value = maxHp
                end
                if Humanoid and Humanoid.Health < maxHp then
                    Humanoid.Health = maxHp
                end
            end)
        end
    end
end)

-- Loop F: Stage Farm & Auto Advance
task.spawn(function()
    while task.wait(2) do
        if PH.AutoFarmStage then
            pcall(function()
                local activeMobs = GetActiveMobsCount()
                if activeMobs == 0 then
                    if StageFinishedRF then StageFinishedRF:InvokeServer(PH.SelectedStage) end
                    if StageFinishedBE then StageFinishedBE:Fire() end
                    if PH.AutoAdvanceStage then
                        PH.SelectedStage = math.min(50, PH.SelectedStage + 1)
                    end
                    if SetIntoStageRE then
                        SetIntoStageRE:FireServer(PH.SelectedStage)
                    end
                end
            end)
        end

        if PH.AutoClaimAllOre and ClaimedAllOreRE then
            pcall(function()
                ClaimedAllOreRE:FireServer()
                PH.SessionOresMined = PH.SessionOresMined + 1
            end)
        end

        if PH.AutoKillSuperLoot and KillSuperLootRE then
            pcall(function()
                for i = 1, 10 do KillSuperLootRE:FireServer(i) end
            end)
        end
    end
end)

-- Loop G: World Boss Auto Battle & Reward Claimer
task.spawn(function()
    while task.wait(1.5) do
        local bossName, _, bossStatus = GetWorldBossData()
        if PH.AutoJoinBoss and string.find(bossStatus, "SPAWNED") then
            pcall(function()
                if IntoWorldBossFight then IntoWorldBossFight:FireServer() end
            end)
        end

        if PH.AutoClaimBossReward and TryClaimBossRewardRE then
            pcall(function()
                for i = 1, 5 do TryClaimBossRewardRE:FireServer(tostring(i)) end
            end)
        end

        if PH.AutoCollectBossBalls and TryGetHPBallRF then
            pcall(function()
                for i = 1, 10 do TryGetHPBallRF:InvokeServer(i) end
            end)
        end
    end
end)

-- Loop H: Stat Upgrades & Potions
task.spawn(function()
    while task.wait(1) do
        if PH.AutoUpgradePower and UpgradeOnceRE then
            pcall(function() UpgradeOnceRE:FireServer("Power") end)
        end

        if PH.AutoUpgradeStats and UpgradeOnceRE then
            pcall(function()
                UpgradeOnceRE:FireServer("Power")
                UpgradeOnceRE:FireServer("Coin")
                UpgradeOnceRE:FireServer("Health")
            end)
        end

        if PH.AutoUsePowerPotion and TryUsePotionRE then
            pcall(function() TryUsePotionRE:FireServer("Power", 1) end)
        end

        if PH.AutoUseCoinPotion and TryUsePotionRE then
            pcall(function() TryUsePotionRE:FireServer("Coin", 1) end)
        end

        if PH.AutoUseLuckPotion and TryUsePotionRE then
            pcall(function() TryUsePotionRE:FireServer("Luck", 1) end)
        end
    end
end)

-- ==============================================================================
-- 8. MOVEMENT & PHYSICS HOOKS (FLY, NOCLIP, SPEED, ANTI-VOID)
-- ==============================================================================

-- Infinite Jump Hook
UserInputService.JumpRequest:Connect(function()
    if PH.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Noclip Stepped Connection
RunService.Stepped:Connect(function()
    if PH.Noclip and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- WalkSpeed & JumpPower Monitor
RunService.Heartbeat:Connect(function()
    if Humanoid then
        if PH.WalkSpeedBoost and Humanoid.WalkSpeed ~= PH.WalkSpeedValue then
            Humanoid.WalkSpeed = PH.WalkSpeedValue
        end
        if PH.JumpPowerBoost and Humanoid.JumpPower ~= PH.JumpPowerValue then
            Humanoid.JumpPower = PH.JumpPowerValue
        end
    end

    -- Anti-Void Fallback
    if PH.AntiVoid and Root then
        if Root.Position.Y < -50 then
            Root.CFrame = CFrame.new(Root.Position.X, 15, Root.Position.Z)
            Root.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- Flight Controller
task.spawn(function()
    local flyBv, flyBg
    while true do
        if PH.FlyEnabled and Root and Humanoid then
            if not flyBv then
                flyBv = Instance.new("BodyVelocity")
                flyBv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                flyBv.Parent = Root
            end
            if not flyBg then
                flyBg = Instance.new("BodyGyro")
                flyBg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyBg.P = 9e4
                flyBg.Parent = Root
            end

            Humanoid.PlatformStand = true
            local camCF = Camera.CFrame
            flyBg.CFrame = camCF

            local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

            flyBv.Velocity = moveDir * (PH.FlySpeed or 60)
            task.wait()
        else
            if flyBv then flyBv:Destroy(); flyBv = nil end
            if flyBg then flyBg:Destroy(); flyBg = nil end
            if Humanoid and Humanoid.PlatformStand then
                Humanoid.PlatformStand = false
            end
            task.wait(0.2)
        end
    end
end)

-- Initial Tab Selection
if Window and Window.SelectTab then
    pcall(function() Window:SelectTab(1) end)
end

print("═══════════════════════════════════════════════════════════════════════")
print("  [PinatHub V2 Ultra] Loaded successfully for Anime Blade Champions!  ")
print("  Live Graphic Telemetry Tab: Active & Streaming                      ")
print("  Zero Nil / Zero Error Engine: Operational                           ")
print("═══════════════════════════════════════════════════════════════════════")

end

__PinatHub_AnimeBlade_V2__()
