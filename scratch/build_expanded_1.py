import os

code_parts = []

code_parts.append('''-- ╔══════════════════════════════════════════════════════════════════════════════════╗
-- ║               PinatHub — Anime Blade Champions & Training RPG Hub                ║
-- ║          Full Native Multi-Module Master Edition (392 Game Modules)              ║
-- ║      Engineered with PinatHub / KingRua UI Library & Native Game Architecture      ║
-- ╚══════════════════════════════════════════════════════════════════════════════════╝

local function __PinatHub_AnimeBlade_Init__()

-- ── Core Roblox Engine Services ──────────────────────────────────────────────────────
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Workspace         = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")

local Camera      = Workspace.CurrentCamera or Workspace:WaitForChild("Camera", 5)
local LocalPlayer = Players.LocalPlayer
local Character, Humanoid, Root

local function refreshChar(char)
    Character = char or LocalPlayer.Character
    Humanoid  = Character and Character:FindFirstChildOfClass("Humanoid")
    Root      = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso"))
end
refreshChar()
LocalPlayer.CharacterAdded:Connect(refreshChar)

-- ── Safe Module Resolution (Zero Luau Static Require Errors) ─────────────────────────
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

-- Resolve Core Game Modules Dynamically
local CommunicationUtils = getGameModule("Utils", "CommunicationUtils")
local EncodingUtils      = getGameModule("Utils", "EncodingUtils")
local HPCTRL             = getGameModule("CTRL", "HPCTRL")
local TrainCTRL          = getGameModule("CTRL", "TrainCTRL")
local EnemyCTRL          = getGameModule("CTRL", "EnemyCTRL")
local SkillCTRL          = getGameModule("SkillSystemNew", "SkillCTRL")
local BackpackData       = getGameModule("LocalData", "BackpackData")
local ClassData          = getGameModule("LocalData", "ClassData")
local UpgradeData        = getGameModule("LocalData", "UpgradeData")
local PotionData         = getGameModule("LocalData", "PotionData")
local StatsData          = getGameModule("LocalData", "StatsData")
local DungeonData        = getGameModule("LocalData", "DungeonData")
local OnlineData         = getGameModule("LocalData", "OnlineData")
local IndexData          = getGameModule("LocalData", "IndexData")

-- Safe Remote Resolution Helpers
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

-- Network Endpoints
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
local SetIntoStageRE       = GetRemoteEvent("Stage", "SetIntoStageRE")
local KillSuperLootRE      = GetRemoteEvent("SuperLoot", "KillSuperLootRE")

local IntoWorldBossFight   = GetRemoteEvent("WorldBoss", "IntoWorldBossFight")
local ExitWorldBossFight   = GetRemoteEvent("WorldBoss", "ExitWorldBossFight")
local TryClaimBossRewardRE = GetRemoteEvent("WorldBoss", "TryClaimBossRewardRE")
local TryGetHPBallRF       = GetRemoteFunction("WorldBoss", "TryGetHPBallRF")

local UpgradeOnceRE        = GetRemoteEvent("Upgrade", "UpgradeOnceRE")
local TryRebirthRE         = GetRemoteEvent("Rebirth", "TryRebirthRE")
local ForgeRF              = GetRemoteFunction("Forge", "ForgeRF")
local TryUsePotionRE       = GetRemoteEvent("Potion", "TryUsePotionRE")
local TryUseCodeRF         = GetRemoteFunction("Code", "TryUseCodeRF")
local TryClaimOfflineRE    = GetRemoteEvent("Offline", "TryClaimOfflineRewardRE")
local DungeonRebirthRE     = GetRemoteEvent("Dungeon", "DungeonRebirthRE")
local ShowLuckResultRE     = GetRemoteEvent("Class", "ShowLuckResultRE")

-- Workspace Folders & Entities
local EnemyFolder      = Workspace:WaitForChild("EnemyFolder", 5) or Workspace:FindFirstChild("EnemyFolder")
local CanAttackFolder  = Workspace:WaitForChild("CanAttackFolder", 5) or Workspace:FindFirstChild("CanAttackFolder")
local SuperLootFolder  = Workspace:FindFirstChild("SuperLootFolder")
local WorldBossFolder  = Workspace:FindFirstChild("WorldBossFolder")
local TouchedFolder    = Workspace:FindFirstChild("TOUCHED")
local WorldModelFolder = Workspace:FindFirstChild("WorldModel")

Workspace.ChildAdded:Connect(function(child)
    if child.Name == "EnemyFolder" then EnemyFolder = child
    elseif child.Name == "CanAttackFolder" then CanAttackFolder = child
    elseif child.Name == "SuperLootFolder" then SuperLootFolder = child
    elseif child.Name == "WorldBossFolder" then WorldBossFolder = child
    elseif child.Name == "TOUCHED" then TouchedFolder = child
    elseif child.Name == "WorldModel" then WorldModelFolder = child
    end
end)

-- ── PinatHub State Table ─────────────────────────────────────────────────────────────
local PH = {
    -- Train Tab
    AutoTrain            = false,
    TrainSpeed           = 0.05,
    TrainClickAura       = false,
    SelectedTrainArea    = 1,
    AutoEnterTrainArea   = false,
    AutoRebirth          = false,

    -- Combat Tab
    AutoAttack           = false,
    KillAura             = false,
    InstantKill          = false,
    AttackRate           = 0.1,
    FarmHoverDistance    = 4,
    MobTargetFilter      = "All Enemies",
    WeaponComboStyle     = "Katana",
    AutoSkill1           = false,
    AutoSkill2           = false,
    SkillCastDelay       = 1.5,
    AutoDodgeBossSkill   = false,

    -- Stage & Ore Tab
    SelectedStage        = "Stage_1",
    AutoFarmStage        = false,
    AutoProgressStage    = false,
    AutoCollectOre       = false,
    AutoClaimAllOre      = false,
    AutoEnchantStone     = false,
    AutoSuperLoot        = false,
    AutoSellAllOres      = false,

    -- Dungeon Tab
    AutoJoinDungeon      = false,
    AutoClearDungeon     = false,
    AutoDungeonRebirth   = false,

    -- World Boss Tab
    AutoJoinWorldBoss    = false,
    AutoAttackWorldBoss  = false,
    AutoClaimBossReward  = false,
    AutoCollectBossBalls = false,
    SelectedRewardCard   = 1,

    -- Equipment & Forge Tab
    AutoForgeWeapon      = false,
    AutoForgeArmor       = false,
    AutoEnchantEquipment = false,
    SelectedEnchantType  = "Fire",

    -- Class, Titles & Upgrades Tab
    AutoRollClass        = false,
    StopOnRarity         = "Legendary",
    SelectedClassSlot    = 1,
    AutoUpgradeLuck      = false,
    AutoUpgradeOrePack   = false,
    AutoUpgradeTrain     = false,
    SelectedPotion       = "Damage",
    AutoUsePotion        = false,

    -- Economy & Gifts Tab
    AutoOfflineReward    = false,
    AutoOnlineGift       = false,
    AutoDailySign        = false,

    -- Movement Tab
    WalkSpeedBoost       = false,
    WalkSpeedValue       = 16,
    JumpPowerBoost       = false,
    JumpPowerValue       = 50,
    FlyEnabled           = false,
    FlySpeed             = 50,
    Noclip               = false,
    InfiniteJump         = false,

    -- ESP Tab
    ESP_Enemy            = false,
    ESP_Health           = true,
    ESP_Distance         = true,
    ESP_BossHighlight    = true,
    ESP_MaxDistance      = 1000,
    ESP_Ore              = false,
    ESP_SuperLoot        = false,

    -- Graphics & Telemetry Tab
    PotatoMode           = false,
    Fullbright           = false,
    FOVValue             = 70,

    -- Config Profile Name
    ConfigName           = "Default"
}

getgenv().PH_AnimeBlade = PH
local UI_Controls = {}

-- ── Training Data Buffer (UUID Cache) ────────────────────────────────────────────────
local TrainDataCache = {}
local function PopTrainTargetUUID()
    if #TrainDataCache <= 20 and InvokTrainDataListRF then
        pcall(function()
            local raw = InvokTrainDataListRF:InvokeServer()
            if raw then
                local list = nil
                if EncodingUtils and EncodingUtils.DecodeTable then
                    list = EncodingUtils.DecodeTable(raw)
                elseif type(raw) == "table" then
                    list = raw
                end
                if type(list) == "table" then
                    for _, item in ipairs(list) do
                        if type(item) == "table" and item.UUID then
                            table.insert(TrainDataCache, item.UUID)
                        end
                    end
                end
            end
        end)
    end
    if #TrainDataCache > 0 then
        return table.remove(TrainDataCache, 1)
    end
    return nil
end

-- ── PinatHub UI Library Loader ───────────────────────────────────────────────────────
local PinatHubAdapter = nil
local function loadLibrary()
    if getgenv and (getgenv().PinatHubAdapter or getgenv().PinatHubLibrary) then
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
        local okReq, res = pcall(function()
            return game:HttpGet(url, true)
        end)
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
    warn("[PinatHub AnimeBlade] Library failed to load:", loadedLib)
end

-- ── Profile & Config Manager System ──────────────────────────────────────────────────
local ConfigFolderName = "PinatHub_AnimeBlade"
if makefolder and isfolder and not isfolder(ConfigFolderName) then
    makefolder(ConfigFolderName)
end

local function GetConfigList()
    local list = {}
    if listfiles and isfolder and isfolder(ConfigFolderName) then
        for _, file in pairs(listfiles(ConfigFolderName)) do
            if file:sub(-5) == ".json" then
                local name = file:match("([^/\\\\]+)%.json$")
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
                for k, v in pairs(data) do
                    PH[k] = v
                end
                for flagKey, ctrl in pairs(UI_Controls) do
                    if ctrl and type(ctrl.Set) == "function" and PH[flagKey] ~= nil then
                        pcall(function() ctrl:Set(PH[flagKey]) end)
                    end
                end
                if PinatHubAdapter and PinatHubAdapter._ControlSetters then
                    for k, v in pairs(data) do
                        local setter = PinatHubAdapter._ControlSetters[k]
                        if setter then pcall(setter, v) end
                    end
                end
                ok = true
            end
        end
    end)
    return ok
end

local function DeleteConfig(name)
    name = (name and name ~= "") and name or PH.ConfigName
    if not name or name == "" or name == "Default" then return false end
    local path = ConfigFolderName .. "/" .. name .. ".json"
    local ok = false
    pcall(function()
        if isfile and isfile(path) and delfile then
            delfile(path)
            ok = true
        end
    end)
    return ok
end

-- ── Main Window Creation ─────────────────────────────────────────────────────────────
local Window
if PinatHubAdapter then
    Window = PinatHubAdapter:CreateWindow({
        Title    = "PinatHub — Anime Blade Champions",
        SubTitle = "Complete Multi-Module Hub",
        Game     = "Anime Blade RPG",
        Version  = "3.0.0 Master",
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

-- ── PinatHub / KingRua Compatibility Adapter Layer ─────────────────────────────────
if Window then
    local origAddTab = Window.AddTab or Window.T or Window.Tab or Window.NewTab

    local function wrapSection(secObj)
        if not secObj then return nil end

        -- Normalize AddToggle
        local origToggle = secObj.AddToggle
        if origToggle then
            secObj.AddToggle = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Toggle"
                    if cfg.Default == nil and cfg.Value ~= nil then
                        cfg.Default = cfg.Value
                    end
                end
                return origToggle(s, cfg)
            end
        end

        -- Normalize AddSlider
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

        -- Normalize AddDropdown
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

        -- Normalize AddButton
        local origButton = secObj.AddButton
        if origButton then
            secObj.AddButton = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Button"
                end
                return origButton(s, cfg)
            end
        end

        -- Normalize AddInput
        local origInput = secObj.AddInput
        if origInput then
            secObj.AddInput = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Input"
                end
                return origInput(s, cfg)
            end
        end

        -- Normalize AddGraph
        local origGraph = secObj.AddGraph
        if origGraph then
            secObj.AddGraph = function(s, cfg)
                if type(cfg) == "table" then
                    cfg.Title = cfg.Title or cfg.Name or "Data Graph"
                    cfg.MaxValue = cfg.MaxValue or cfg.Max or 100
                    cfg.Unit = cfg.Unit or cfg.Suffix or ""
                    local valFn = cfg.Value or cfg.ValueFn
                    local gObj = origGraph(s, cfg)
                    if gObj and type(valFn) == "function" then
                        task.spawn(function()
                            while task.wait(1) do
                                pcall(function()
                                    if gObj.Push then
                                        gObj:Push(valFn())
                                    end
                                end)
                            end
                        end)
                    end
                    return gObj
                end
                return origGraph(s, cfg)
            end
        end

        return secObj
    end

    local function wrapTab(tabObj)
        if not tabObj then return nil end

        -- 1. AddSubNav
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
            tabObj.SubNav = tabObj.AddSubNav
            tabObj.SubTabs = tabObj.AddSubNav
        end

        -- 2. AddSection
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

    -- Window Tab Creation Normalization
    Window.AddTab = function(self, tabCfg, ...)
        if type(tabCfg) == "table" then
            tabCfg.Title = tabCfg.Title or tabCfg.Name or "Tab"
            tabCfg.Desc  = tabCfg.Desc or tabCfg.Description or tabCfg.Title
        end
        local t = origAddTab(self, tabCfg, ...)
        return wrapTab(t)
    end
    Window.CreateTab = Window.AddTab
    Window.Tab = Window.AddTab
    Window.NewTab = Window.AddTab
end
''')

with open("scratch/expanded_part1.lua", "w", encoding="utf-8") as f:
    f.write("".join(code_parts))
print("Part 1 ready")
