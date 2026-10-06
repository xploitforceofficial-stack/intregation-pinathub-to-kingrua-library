-- ╔══════════════════════════════════════════════════════════════════════════════════╗
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
                local name = file:match("([^/\\]+)%.json$")
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

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 1: TRAINING & POWER
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabTrain = Window and Window:CreateTab({
    Name = "Training",
    Icon = "zap",
    Description = "Auto Click, Training Zones & Fast Power Gain"
})

local NavTrain_Auto, NavTrain_Zones, NavTrain_Rebirth
if TabTrain then
    local sections = TabTrain:AddSubNav({
        "Auto Train",
        "Training Areas",
        "Rebirth & Power"
    })
    NavTrain_Auto    = sections["Auto Train"]
    NavTrain_Zones   = sections["Training Areas"]
    NavTrain_Rebirth = sections["Rebirth & Power"]
end

-- ── [Tab 1 - Subnav: Auto Train] ─────────────────────────────────────────────────────
if NavTrain_Auto then
    local SecTrainClick = NavTrain_Auto:AddSection("Auto Click & Training Aura")

    UI_Controls.AutoTrain = SecTrainClick:AddToggle({
        Name     = "Auto Train / Clicker",
        Default  = false,
        Flag     = "AutoTrain",
        Callback = function(val)
            PH.AutoTrain = val
        end
    })

    UI_Controls.TrainSpeed = SecTrainClick:AddSlider({
        Name     = "Train Click Delay",
        Min      = 0.01,
        Max      = 0.5,
        Default  = 0.05,
        Precise  = 2,
        Flag     = "TrainSpeed",
        Callback = function(val)
            PH.TrainSpeed = val
        end
    })

    UI_Controls.TrainClickAura = SecTrainClick:AddToggle({
        Name     = "Multi-Threaded Click Aura",
        Default  = false,
        Flag     = "TrainClickAura",
        Callback = function(val)
            PH.TrainClickAura = val
        end
    })

    SecTrainClick:AddButton({
        Name     = "Train Once (Manual)",
        Callback = function()
            local uuid = PopTrainTargetUUID()
            if TrainOnceRE and uuid then
                TrainOnceRE:FireServer(uuid)
            elseif ATKOnceBE then
                ATKOnceBE:Fire()
            end
        end
    })
end

-- ── [Tab 1 - Subnav: Training Areas] ─────────────────────────────────────────────────
if NavTrain_Zones then
    local SecTrainAreas = NavTrain_Zones:AddSection("Training Area Zones")

    local AreaList = {}
    for i = 1, 11 do table.insert(AreaList, "Area " .. i) end

    UI_Controls.SelectedTrainArea = SecTrainAreas:AddDropdown({
        Name     = "Select Training Area",
        Options  = AreaList,
        Default  = "Area 1",
        Flag     = "SelectedTrainArea",
        Callback = function(val)
            local num = tonumber(string.match(val, "%d+"))
            if num then PH.SelectedTrainArea = num end
        end
    })

    UI_Controls.AutoEnterTrainArea = SecTrainAreas:AddToggle({
        Name     = "Auto Enter Selected Zone",
        Default  = false,
        Flag     = "AutoEnterTrainArea",
        Callback = function(val)
            PH.AutoEnterTrainArea = val
            if val and IntoAutoTrainRE then
                IntoAutoTrainRE:FireServer(PH.SelectedTrainArea)
            elseif not val and ExitAutoTrainRE then
                ExitAutoTrainRE:FireServer(PH.SelectedTrainArea)
            end
        end
    })

    SecTrainAreas:AddButton({
        Name     = "Teleport to Area Dummy",
        Callback = function()
            refreshChar()
            if Root and CanAttackFolder then
                local area = CanAttackFolder:FindFirstChild("TrainArea")
                if area then
                    local targetZone = area:FindFirstChild("Train_" .. PH.SelectedTrainArea)
                    if targetZone then
                        local dummy = targetZone:FindFirstChild("DUMMY", true) or targetZone:FindFirstChildWhichIsA("BasePart")
                        if dummy then
                            Root.CFrame = dummy:GetPivot() * CFrame.new(0, 0, 4)
                        end
                    end
                end
            end
        end
    })

    SecTrainAreas:AddButton({
        Name     = "Exit Current Area",
        Callback = function()
            if ExitAutoTrainRE then
                local cur = LocalPlayer:GetAttribute("AutoTrainAreaID") or PH.SelectedTrainArea
                ExitAutoTrainRE:FireServer(cur)
            end
        end
    })
end

-- ── [Tab 1 - Subnav: Rebirth & Power] ────────────────────────────────────────────────
if NavTrain_Rebirth then
    local SecRebirth = NavTrain_Rebirth:AddSection("Rebirth Automation")

    UI_Controls.AutoRebirth = SecRebirth:AddToggle({
        Name     = "Auto Rebirth (When Eligible)",
        Default  = false,
        Flag     = "AutoRebirth",
        Callback = function(val)
            PH.AutoRebirth = val
        end
    })

    SecRebirth:AddButton({
        Name     = "Force Rebirth Now",
        Callback = function()
            if TryRebirthRE then
                TryRebirthRE:FireServer()
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 2: COMBAT & SKILLS
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabCombat = Window and Window:CreateTab({
    Name = "Combat",
    Icon = "swords",
    Description = "Mob Farm, Kill Aura & Auto Skill Casting"
})

local NavCombat_Farm, NavCombat_Filter, NavCombat_Skills
if TabCombat then
    local sections = TabCombat:AddSubNav({
        "Auto Farm Mobs",
        "Target Filter",
        "Skills & Auto-Cast"
    })
    NavCombat_Farm   = sections["Auto Farm Mobs"]
    NavCombat_Filter = sections["Target Filter"]
    NavCombat_Skills = sections["Skills & Auto-Cast"]
end

-- ── [Tab 2 - Subnav: Auto Farm Mobs] ─────────────────────────────────────────────────
if NavCombat_Farm then
    local SecFarm = NavCombat_Farm:AddSection("Mob Farming & Aura")

    UI_Controls.AutoAttack = SecFarm:AddToggle({
        Name     = "Auto Attack / Mob Farm",
        Default  = false,
        Flag     = "AutoAttack",
        Callback = function(val)
            PH.AutoAttack = val
        end
    })

    UI_Controls.KillAura = SecFarm:AddToggle({
        Name     = "Kill Aura (AoE Attack)",
        Default  = false,
        Flag     = "KillAura",
        Callback = function(val)
            PH.KillAura = val
        end
    })

    UI_Controls.InstantKill = SecFarm:AddToggle({
        Name     = "Instant Kill (Server Sync)",
        Default  = false,
        Flag     = "InstantKill",
        Callback = function(val)
            PH.InstantKill = val
        end
    })

    UI_Controls.FarmHoverDistance = SecFarm:AddSlider({
        Name     = "Hover Farm Distance",
        Min      = 0,
        Max      = 15,
        Default  = 4,
        Flag     = "FarmHoverDistance",
        Callback = function(val)
            PH.FarmHoverDistance = val
        end
    })

    UI_Controls.AttackRate = SecFarm:AddSlider({
        Name     = "Attack Rate Delay",
        Min      = 0.05,
        Max      = 0.5,
        Default  = 0.1,
        Precise  = 2,
        Flag     = "AttackRate",
        Callback = function(val)
            PH.AttackRate = val
        end
    })
end

-- ── [Tab 2 - Subnav: Target Filter] ──────────────────────────────────────────────────
if NavCombat_Filter then
    local SecFilter = NavCombat_Filter:AddSection("Target Filter & Weapon Style")

    UI_Controls.MobTargetFilter = SecFilter:AddDropdown({
        Name     = "Target Filter",
        Options  = { "All Enemies", "Bosses Only", "Normal Mobs Only" },
        Default  = "All Enemies",
        Flag     = "MobTargetFilter",
        Callback = function(val)
            PH.MobTargetFilter = val
        end
    })

    UI_Controls.WeaponComboStyle = SecFilter:AddDropdown({
        Name     = "Weapon Attack Style",
        Options  = { "Katana", "Greatsword", "Auto Detect" },
        Default  = "Katana",
        Flag     = "WeaponComboStyle",
        Callback = function(val)
            PH.WeaponComboStyle = val
        end
    })

    UI_Controls.AutoDodgeBossSkill = SecFilter:AddToggle({
        Name     = "Auto Dodge Boss AoE Attacks",
        Default  = false,
        Flag     = "AutoDodgeBossSkill",
        Callback = function(val)
            PH.AutoDodgeBossSkill = val
        end
    })
end

-- ── [Tab 2 - Subnav: Skills & Auto-Cast] ─────────────────────────────────────────────
if NavCombat_Skills then
    local SecSkills = NavCombat_Skills:AddSection("Weapon Skills Auto-Cast")

    UI_Controls.AutoSkill1 = SecSkills:AddToggle({
        Name     = "Auto Cast Skill 1 (Q Key)",
        Default  = false,
        Flag     = "AutoSkill1",
        Callback = function(val)
            PH.AutoSkill1 = val
        end
    })

    UI_Controls.AutoSkill2 = SecSkills:AddToggle({
        Name     = "Auto Cast Skill 2 (E Key)",
        Default  = false,
        Flag     = "AutoSkill2",
        Callback = function(val)
            PH.AutoSkill2 = val
        end
    })

    UI_Controls.SkillCastDelay = SecSkills:AddSlider({
        Name     = "Skill Cast Interval",
        Min      = 0.5,
        Max      = 5.0,
        Default  = 1.5,
        Precise  = 1,
        Flag     = "SkillCastDelay",
        Callback = function(val)
            PH.SkillCastDelay = val
        end
    })

    SecSkills:AddButton({
        Name     = "Cast All Skills Now",
        Callback = function()
            if UseSkillByIndexBE then
                pcall(function() UseSkillByIndexBE:Fire(1) end)
                task.wait(0.2)
                pcall(function() UseSkillByIndexBE:Fire(2) end)
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 3: STAGES & ORES
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabStage = Window and Window:CreateTab({
    Name = "Stages & Ores",
    Icon = "trophy",
    Description = "Stage Progression, Mineral Mining, Auto Sell & Super Loot"
})

local NavStage_Farm, NavStage_Ore, NavStage_Sell, NavStage_Super
if TabStage then
    local sections = TabStage:AddSubNav({
        "Stage Automation",
        "Ore Collection",
        "Auto Sell Ores",
        "Super Loot"
    })
    NavStage_Farm  = sections["Stage Automation"]
    NavStage_Ore   = sections["Ore Collection"]
    NavStage_Sell  = sections["Auto Sell Ores"]
    NavStage_Super = sections["Super Loot"]
end

-- ── [Tab 3 - Subnav: Stage Automation] ───────────────────────────────────────────────
if NavStage_Farm then
    local SecStage = NavStage_Farm:AddSection("Stage Farming & Progression")

    local StageList = {}
    for i = 1, 18 do table.insert(StageList, "Stage_" .. i) end

    UI_Controls.SelectedStage = SecStage:AddDropdown({
        Name     = "Select Target Stage",
        Options  = StageList,
        Default  = "Stage_1",
        Flag     = "SelectedStage",
        Callback = function(val)
            PH.SelectedStage = val
        end
    })

    UI_Controls.AutoFarmStage = SecStage:AddToggle({
        Name     = "Auto Farm Selected Stage",
        Default  = false,
        Flag     = "AutoFarmStage",
        Callback = function(val)
            PH.AutoFarmStage = val
        end
    })

    UI_Controls.AutoProgressStage = SecStage:AddToggle({
        Name     = "Auto Progress All Stages",
        Default  = false,
        Flag     = "AutoProgressStage",
        Callback = function(val)
            PH.AutoProgressStage = val
        end
    })

    SecStage:AddButton({
        Name     = "Teleport to Stage Zone",
        Callback = function()
            refreshChar()
            if Root and WorldModelFolder then
                local stageMap = WorldModelFolder:FindFirstChild("StageMap")
                if stageMap then
                    local areaPart = stageMap:FindFirstChild("AreaPart")
                    if areaPart then
                        local target = areaPart:FindFirstChild(PH.SelectedStage)
                        if target and target:IsA("BasePart") then
                            Root.CFrame = target.CFrame * CFrame.new(0, 5, 0)
                        end
                    end
                end
            end
        end
    })

    SecStage:AddButton({
        Name     = "Claim Stage Completion Now",
        Callback = function()
            if StageFinishedRF then
                local stId = tonumber(string.match(PH.SelectedStage, "%d+")) or 1
                StageFinishedRF:InvokeServer(stId)
            end
        end
    })
end

-- ── [Tab 3 - Subnav: Ore Collection] ─────────────────────────────────────────────────
if NavStage_Ore then
    local SecOre = NavStage_Ore:AddSection("Ore & Mineral Collection")

    UI_Controls.AutoCollectOre = SecOre:AddToggle({
        Name     = "Auto Collect Dropped Ores",
        Default  = false,
        Flag     = "AutoCollectOre",
        Callback = function(val)
            PH.AutoCollectOre = val
        end
    })

    UI_Controls.AutoClaimAllOre = SecOre:AddToggle({
        Name     = "Auto Claim All Ores (Server)",
        Default  = false,
        Flag     = "AutoClaimAllOre",
        Callback = function(val)
            PH.AutoClaimAllOre = val
        end
    })

    UI_Controls.AutoEnchantStone = SecOre:AddToggle({
        Name     = "Auto Collect Enchant Stones",
        Default  = false,
        Flag     = "AutoEnchantStone",
        Callback = function(val)
            PH.AutoEnchantStone = val
        end
    })

    SecOre:AddButton({
        Name     = "Claim All Ores Now",
        Callback = function()
            if ClaimedAllOreRE then
                ClaimedAllOreRE:FireServer()
            end
        end
    })
end

-- ── [Tab 3 - Subnav: Auto Sell Ores] ─────────────────────────────────────────────────
if NavStage_Sell then
    local SecSell = NavStage_Sell:AddSection("Auto Sell Ores & Backpack Capacity")

    UI_Controls.AutoSellAllOres = SecSell:AddToggle({
        Name     = "Auto Sell All Ores (Continuous)",
        Default  = false,
        Flag     = "AutoSellAllOres",
        Callback = function(val)
            PH.AutoSellAllOres = val
        end
    })

    SecSell:AddButton({
        Name     = "Sell All Ores Now",
        Callback = function()
            if BackpackData and BackpackData.SellAll then
                pcall(function() BackpackData.SellAll() end)
            end
        end
    })
end

-- ── [Tab 3 - Subnav: Super Loot] ─────────────────────────────────────────────────────
if NavStage_Super then
    local SecSuper = NavStage_Super:AddSection("Super Loot Chest Automation")

    UI_Controls.AutoSuperLoot = SecSuper:AddToggle({
        Name     = "Auto Break Super Loot Drops",
        Default  = false,
        Flag     = "AutoSuperLoot",
        Callback = function(val)
            PH.AutoSuperLoot = val
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 4: DUNGEONS & RAIDS
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabDungeon = Window and Window:CreateTab({
    Name = "Dungeons",
    Icon = "shield",
    Description = "Dungeon Raids, Multi-Round Waves & Dungeon Rebirth"
})

local NavDungeon_Auto, NavDungeon_Actions
if TabDungeon then
    local sections = TabDungeon:AddSubNav({
        "Dungeon Automation",
        "Dungeon Actions"
    })
    NavDungeon_Auto    = sections["Dungeon Automation"]
    NavDungeon_Actions = sections["Dungeon Actions"]
end

-- ── [Tab 4 - Subnav: Dungeon Automation] ─────────────────────────────────────────────
if NavDungeon_Auto then
    local SecDungeon = NavDungeon_Auto:AddSection("Dungeon Raid Automation")

    UI_Controls.AutoJoinDungeon = SecDungeon:AddToggle({
        Name     = "Auto Step into Dungeon",
        Default  = false,
        Flag     = "AutoJoinDungeon",
        Callback = function(val)
            PH.AutoJoinDungeon = val
        end
    })

    UI_Controls.AutoClearDungeon = SecDungeon:AddToggle({
        Name     = "Auto Clear Dungeon Waves",
        Default  = false,
        Flag     = "AutoClearDungeon",
        Callback = function(val)
            PH.AutoClearDungeon = val
        end
    })

    UI_Controls.AutoDungeonRebirth = SecDungeon:AddToggle({
        Name     = "Auto Dungeon Rebirth",
        Default  = false,
        Flag     = "AutoDungeonRebirth",
        Callback = function(val)
            PH.AutoDungeonRebirth = val
        end
    })
end

-- ── [Tab 4 - Subnav: Dungeon Actions] ────────────────────────────────────────────────
if NavDungeon_Actions then
    local SecDgActions = NavDungeon_Actions:AddSection("Dungeon Quick Teleports & Controls")

    SecDgActions:AddButton({
        Name     = "Teleport to Dungeon Portal",
        Callback = function()
            refreshChar()
            if Root and TouchedFolder then
                local dg = TouchedFolder:FindFirstChild("DungeonOpen")
                if dg and dg:IsA("BasePart") then
                    Root.CFrame = dg.CFrame * CFrame.new(0, 4, 0)
                end
            end
        end
    })

    SecDgActions:AddButton({
        Name     = "Dungeon Rebirth Once",
        Callback = function()
            if DungeonRebirthRE then
                DungeonRebirthRE:FireServer()
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 5: WORLD BOSS
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabBoss = Window and Window:CreateTab({
    Name = "World Boss",
    Icon = "skull",
    Description = "World Boss Raids, Rewards, Card Flips & HP Buff Balls"
})

local NavBoss_Auto, NavBoss_Rewards, NavBoss_Balls
if TabBoss then
    local sections = TabBoss:AddSubNav({
        "World Boss Combat",
        "Boss Rewards & Cards",
        "HP Ball Collector"
    })
    NavBoss_Auto    = sections["World Boss Combat"]
    NavBoss_Rewards = sections["Boss Rewards & Cards"]
    NavBoss_Balls   = sections["HP Ball Collector"]
end

-- ── [Tab 5 - Subnav: World Boss Combat] ──────────────────────────────────────────────
if NavBoss_Auto then
    local SecBossFight = NavBoss_Auto:AddSection("World Boss Combat Automation")

    UI_Controls.AutoJoinWorldBoss = SecBossFight:AddToggle({
        Name     = "Auto Join World Boss (On Spawn)",
        Default  = false,
        Flag     = "AutoJoinWorldBoss",
        Callback = function(val)
            PH.AutoJoinWorldBoss = val
        end
    })

    UI_Controls.AutoAttackWorldBoss = SecBossFight:AddToggle({
        Name     = "Auto Attack World Boss",
        Default  = false,
        Flag     = "AutoAttackWorldBoss",
        Callback = function(val)
            PH.AutoAttackWorldBoss = val
        end
    })

    SecBossFight:AddButton({
        Name     = "Join World Boss Fight Now",
        Callback = function()
            if IntoWorldBossFight then
                IntoWorldBossFight:FireServer()
            end
            refreshChar()
            if Root and TouchedFolder then
                local wb = TouchedFolder:FindFirstChild("WorldBoss")
                if wb and wb:IsA("BasePart") then
                    Root.CFrame = wb.CFrame * CFrame.new(0, 4, 0)
                end
            end
        end
    })

    SecBossFight:AddButton({
        Name     = "Exit World Boss Fight",
        Callback = function()
            if ExitWorldBossFight then
                ExitWorldBossFight:FireServer()
            end
            refreshChar()
            if Root and TouchedFolder then
                local wbBack = TouchedFolder:FindFirstChild("WorldBoss_Back")
                if wbBack and wbBack:IsA("BasePart") then
                    Root.CFrame = wbBack.CFrame * CFrame.new(0, 4, 0)
                end
            end
        end
    })
end

-- ── [Tab 5 - Subnav: Boss Rewards & Cards] ───────────────────────────────────────────
if NavBoss_Rewards then
    local SecBossRewards = NavBoss_Rewards:AddSection("Boss Loot & Card Selection")

    UI_Controls.AutoClaimBossReward = SecBossRewards:AddToggle({
        Name     = "Auto Claim Boss Rewards",
        Default  = false,
        Flag     = "AutoClaimBossReward",
        Callback = function(val)
            PH.AutoClaimBossReward = val
        end
    })

    UI_Controls.SelectedRewardCard = SecBossRewards:AddSlider({
        Name     = "Select Reward Card (1 - 4)",
        Min      = 1,
        Max      = 4,
        Default  = 1,
        Flag     = "SelectedRewardCard",
        Callback = function(val)
            PH.SelectedRewardCard = val
        end
    })

    SecBossRewards:AddButton({
        Name     = "Claim Card Loot Now",
        Callback = function()
            if TryClaimBossRewardRE then
                local cardStr = tostring(PH.SelectedRewardCard or 1)
                TryClaimBossRewardRE:FireServer(cardStr)
            end
        end
    })
end

-- ── [Tab 5 - Subnav: HP Ball Collector] ──────────────────────────────────────────────
if NavBoss_Balls then
    local SecBalls = NavBoss_Balls:AddSection("World Boss HP & Buff Drops")

    UI_Controls.AutoCollectBossBalls = SecBalls:AddToggle({
        Name     = "Auto Collect Boss HP Balls",
        Default  = false,
        Flag     = "AutoCollectBossBalls",
        Callback = function(val)
            PH.AutoCollectBossBalls = val
        end
    })

    SecBalls:AddButton({
        Name     = "Collect All 5 HP Balls Now",
        Callback = function()
            if TryGetHPBallRF then
                for i = 1, 5 do
                    pcall(function() TryGetHPBallRF:InvokeServer(i) end)
                end
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 6: EQUIPMENT & FORGE
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabForge = Window and Window:CreateTab({
    Name = "Equipment",
    Icon = "package",
    Description = "Weapon Forging, Armor Crafting & Elemental Enchantments"
})

local NavForge_Weapon, NavForge_Armor, NavForge_Enchant
if TabForge then
    local sections = TabForge:AddSubNav({
        "Weapon Forge",
        "Armor Forge",
        "Enchantments"
    })
    NavForge_Weapon  = sections["Weapon Forge"]
    NavForge_Armor   = sections["Armor Forge"]
    NavForge_Enchant = sections["Enchantments"]
end

-- ── [Tab 6 - Subnav: Weapon Forge] ───────────────────────────────────────────────────
if NavForge_Weapon then
    local SecWepForge = NavForge_Weapon:AddSection("Katana & Greatsword Forging")

    UI_Controls.AutoForgeWeapon = SecWepForge:AddToggle({
        Name     = "Auto Forge Weapon (When Ores Ready)",
        Default  = false,
        Flag     = "AutoForgeWeapon",
        Callback = function(val)
            PH.AutoForgeWeapon = val
        end
    })

    SecWepForge:AddButton({
        Name     = "Forge Best Weapon Now",
        Callback = function()
            if ForgeRF then
                pcall(function() ForgeRF:InvokeServer({}) end)
            end
        end
    })
end

-- ── [Tab 6 - Subnav: Armor Forge] ────────────────────────────────────────────────────
if NavForge_Armor then
    local SecArmForge = NavForge_Armor:AddSection("Light Hat & Armor Forging")

    UI_Controls.AutoForgeArmor = SecArmForge:AddToggle({
        Name     = "Auto Forge Armor & Hats",
        Default  = false,
        Flag     = "AutoForgeArmor",
        Callback = function(val)
            PH.AutoForgeArmor = val
        end
    })
end

-- ── [Tab 6 - Subnav: Enchantments] ───────────────────────────────────────────────────
if NavForge_Enchant then
    local SecEnch = NavForge_Enchant:AddSection("Elemental Weapon Enchantments")

    UI_Controls.SelectedEnchantType = SecEnch:AddDropdown({
        Name     = "Select Enchant Element",
        Options  = { "Fire", "Ice", "Poison", "Thunder" },
        Default  = "Fire",
        Flag     = "SelectedEnchantType",
        Callback = function(val)
            PH.SelectedEnchantType = val
        end
    })

    UI_Controls.AutoEnchantEquipment = SecEnch:AddToggle({
        Name     = "Auto Enchant Weapon",
        Default  = false,
        Flag     = "AutoEnchantEquipment",
        Callback = function(val)
            PH.AutoEnchantEquipment = val
        end
    })

    SecEnch:AddButton({
        Name     = "Apply Selected Enchant Now",
        Callback = function()
            if BackpackData and BackpackData.EnchantEquipment then
                pcall(function()
                    BackpackData.EnchantEquipment("Weapon", PH.SelectedEnchantType, "1")
                end)
            end
        end
    })

    SecEnch:AddButton({
        Name     = "Unequip Weapon Enchant",
        Callback = function()
            if BackpackData and BackpackData.UnEnchantEquipment then
                pcall(function()
                    BackpackData.UnEnchantEquipment("Weapon", "1")
                end)
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 7: CLASS & TITLES
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabClass = Window and Window:CreateTab({
    Name = "Class & Titles",
    Icon = "sparkles",
    Description = "Class Rerolls, Title Boosts, Stat Upgrades & Potions"
})

local NavClass_Roll, NavClass_Upgrades, NavClass_Potions
if TabClass then
    local sections = TabClass:AddSubNav({
        "Class Roll",
        "Stat Upgrades",
        "Potions"
    })
    NavClass_Roll     = sections["Class Roll"]
    NavClass_Upgrades = sections["Stat Upgrades"]
    NavClass_Potions  = sections["Potions"]
end

-- ── [Tab 7 - Subnav: Class Roll] ─────────────────────────────────────────────────────
if NavClass_Roll then
    local SecClassRoll = NavClass_Roll:AddSection("Class Reroll & Luck System")

    UI_Controls.AutoRollClass = SecClassRoll:AddToggle({
        Name     = "Auto Reroll Class",
        Default  = false,
        Flag     = "AutoRollClass",
        Callback = function(val)
            PH.AutoRollClass = val
        end
    })

    UI_Controls.StopOnRarity = SecClassRoll:AddDropdown({
        Name     = "Stop On Rarity",
        Options  = { "Legendary", "Mythic" },
        Default  = "Legendary",
        Flag     = "StopOnRarity",
        Callback = function(val)
            PH.StopOnRarity = val
        end
    })

    UI_Controls.SelectedClassSlot = SecClassRoll:AddSlider({
        Name     = "Class Slot Index",
        Min      = 1,
        Max      = 6,
        Default  = 1,
        Flag     = "SelectedClassSlot",
        Callback = function(val)
            PH.SelectedClassSlot = val
        end
    })

    SecClassRoll:AddButton({
        Name     = "Roll Class Once (Manual)",
        Callback = function()
            if ClassData and ClassData.LuckOnce then
                ClassData.LuckOnce(PH.SelectedClassSlot or 1)
            end
        end
    })
end

-- ── [Tab 7 - Subnav: Stat Upgrades] ──────────────────────────────────────────────────
if NavClass_Upgrades then
    local SecStatUpg = NavClass_Upgrades:AddSection("Stats Progression Upgrades")

    UI_Controls.AutoUpgradeLuck = SecStatUpg:AddToggle({
        Name     = "Auto Upgrade Luck",
        Default  = false,
        Flag     = "AutoUpgradeLuck",
        Callback = function(val)
            PH.AutoUpgradeLuck = val
        end
    })

    UI_Controls.AutoUpgradeOrePack = SecStatUpg:AddToggle({
        Name     = "Auto Upgrade Ore Pack",
        Default  = false,
        Flag     = "AutoUpgradeOrePack",
        Callback = function(val)
            PH.AutoUpgradeOrePack = val
        end
    })

    UI_Controls.AutoUpgradeTrain = SecStatUpg:AddToggle({
        Name     = "Auto Upgrade Training Power",
        Default  = false,
        Flag     = "AutoUpgradeTrain",
        Callback = function(val)
            PH.AutoUpgradeTrain = val
        end
    })

    SecStatUpg:AddButton({
        Name     = "Upgrade Everything Once",
        Callback = function()
            if UpgradeOnceRE then
                pcall(function() UpgradeOnceRE:FireServer("Luck") end)
                pcall(function() UpgradeOnceRE:FireServer("OrePack") end)
                pcall(function() UpgradeOnceRE:FireServer("Train") end)
            end
        end
    })
end

-- ── [Tab 7 - Subnav: Potions] ────────────────────────────────────────────────────────
if NavClass_Potions then
    local SecPotions = NavClass_Potions:AddSection("Buff Potions")

    UI_Controls.SelectedPotion = SecPotions:AddDropdown({
        Name     = "Select Potion Type",
        Options  = { "Damage", "Luck", "Exp", "Power", "Coin" },
        Default  = "Damage",
        Flag     = "SelectedPotion",
        Callback = function(val)
            PH.SelectedPotion = val
        end
    })

    UI_Controls.AutoUsePotion = SecPotions:AddToggle({
        Name     = "Auto Consume Potion",
        Default  = false,
        Flag     = "AutoUsePotion",
        Callback = function(val)
            PH.AutoUsePotion = val
        end
    })

    SecPotions:AddButton({
        Name     = "Consume 5x Selected Potion",
        Callback = function()
            if TryUsePotionRE then
                TryUsePotionRE:FireServer(PH.SelectedPotion, 5)
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 8: ECONOMY & GIFTS
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabEconomy = Window and Window:CreateTab({
    Name = "Gifts & Codes",
    Icon = "gift",
    Description = "Offline Rewards, Online Gifts, Daily Sign-In & Promo Codes"
})

local NavEco_Gifts, NavEco_Codes
if TabEconomy then
    local sections = TabEconomy:AddSubNav({
        "Free Rewards",
        "Promo Codes"
    })
    NavEco_Gifts = sections["Free Rewards"]
    NavEco_Codes = sections["Promo Codes"]
end

-- ── [Tab 8 - Subnav: Free Rewards] ───────────────────────────────────────────────────
if NavEco_Gifts then
    local SecFreeRewards = NavEco_Gifts:AddSection("Daily & Online Free Rewards")

    UI_Controls.AutoOfflineReward = SecFreeRewards:AddToggle({
        Name     = "Auto Claim Offline Rewards",
        Default  = false,
        Flag     = "AutoOfflineReward",
        Callback = function(val)
            PH.AutoOfflineReward = val
        end
    })

    UI_Controls.AutoOnlineGift = SecFreeRewards:AddToggle({
        Name     = "Auto Claim Online Gifts (1-12)",
        Default  = false,
        Flag     = "AutoOnlineGift",
        Callback = function(val)
            PH.AutoOnlineGift = val
        end
    })

    UI_Controls.AutoDailySign = SecFreeRewards:AddToggle({
        Name     = "Auto Claim 30-Day Sign Rewards",
        Default  = false,
        Flag     = "AutoDailySign",
        Callback = function(val)
            PH.AutoDailySign = val
        end
    })

    SecFreeRewards:AddButton({
        Name     = "Claim Offline Reward Now",
        Callback = function()
            if TryClaimOfflineRE then
                TryClaimOfflineRE:FireServer()
            end
        end
    })
end

-- ── [Tab 8 - Subnav: Promo Codes] ────────────────────────────────────────────────────
if NavEco_Codes then
    local SecCodes = NavEco_Codes:AddSection("Promo Code Redemptions")

    local EnteredCode = ""
    SecCodes:AddInput({
        Name        = "Enter Promo Code",
        Placeholder = "CODE HERE...",
        Flag        = "EnteredCode",
        Callback    = function(text)
            EnteredCode = text
        end
    })

    SecCodes:AddButton({
        Name     = "Redeem Entered Code",
        Callback = function()
            if TryUseCodeRF and EnteredCode ~= "" then
                local res = TryUseCodeRF:InvokeServer(EnteredCode)
                if PinatHubAdapter and PinatHubAdapter.Notify then
                    PinatHubAdapter:Notify({
                        Title    = "Code Redeem",
                        Content  = tostring(res) or "Code Processed",
                        Duration = 3
                    })
                end
            end
        end
    })

    SecCodes:AddButton({
        Name     = "Redeem All Free Promo Codes",
        Callback = function()
            local commonCodes = { "RELEASE", "SWORD", "BLADE", "UPDATE1", "LIKE1000", "FREEGEMS" }
            if TryUseCodeRF then
                for _, code in ipairs(commonCodes) do
                    pcall(function() TryUseCodeRF:InvokeServer(code) end)
                    task.wait(0.2)
                end
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 9: MOVEMENT & TELEPORTS
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabMove = Window and Window:CreateTab({
    Name = "Movement",
    Icon = "teleport",
    Description = "Speed, Jump, Fly, Noclip & World Teleports"
})

local NavMove_Mods, NavMove_TP
if TabMove then
    local sections = TabMove:AddSubNav({
        "Movement Mods",
        "World Teleports"
    })
    NavMove_Mods = sections["Movement Mods"]
    NavMove_TP   = sections["World Teleports"]
end

-- ── [Tab 9 - Subnav: Movement Mods] ──────────────────────────────────────────────────
if NavMove_Mods then
    local SecMods = NavMove_Mods:AddSection("Player Physics Modifications")

    UI_Controls.WalkSpeedBoost = SecMods:AddToggle({
        Name     = "WalkSpeed Boost",
        Default  = false,
        Flag     = "WalkSpeedBoost",
        Callback = function(val)
            PH.WalkSpeedBoost = val
            refreshChar()
            if Humanoid and not val then
                Humanoid.WalkSpeed = 16
            end
        end
    })

    UI_Controls.WalkSpeedValue = SecMods:AddSlider({
        Name     = "Speed Multiplier",
        Min      = 16,
        Max      = 150,
        Default  = 16,
        Flag     = "WalkSpeedValue",
        Callback = function(val)
            PH.WalkSpeedValue = val
            if PH.WalkSpeedBoost and Humanoid then
                Humanoid.WalkSpeed = val
            end
        end
    })

    UI_Controls.JumpPowerBoost = SecMods:AddToggle({
        Name     = "JumpPower Boost",
        Default  = false,
        Flag     = "JumpPowerBoost",
        Callback = function(val)
            PH.JumpPowerBoost = val
            refreshChar()
            if Humanoid and not val then
                Humanoid.JumpPower = 50
            end
        end
    })

    UI_Controls.JumpPowerValue = SecMods:AddSlider({
        Name     = "Jump Multiplier",
        Min      = 50,
        Max      = 250,
        Default  = 50,
        Flag     = "JumpPowerValue",
        Callback = function(val)
            PH.JumpPowerValue = val
            if PH.JumpPowerBoost and Humanoid then
                Humanoid.JumpPower = val
            end
        end
    })

    UI_Controls.FlyEnabled = SecMods:AddToggle({
        Name     = "Fly (WASD + Space/Shift)",
        Default  = false,
        Flag     = "FlyEnabled",
        Callback = function(val)
            PH.FlyEnabled = val
        end
    })

    UI_Controls.FlySpeed = SecMods:AddSlider({
        Name     = "Fly Speed",
        Min      = 20,
        Max      = 150,
        Default  = 50,
        Flag     = "FlySpeed",
        Callback = function(val)
            PH.FlySpeed = val
        end
    })

    UI_Controls.Noclip = SecMods:AddToggle({
        Name     = "Noclip (Pass Through Obstacles)",
        Default  = false,
        Flag     = "Noclip",
        Callback = function(val)
            PH.Noclip = val
        end
    })

    UI_Controls.InfiniteJump = SecMods:AddToggle({
        Name     = "Infinite Jump",
        Default  = false,
        Flag     = "InfiniteJump",
        Callback = function(val)
            PH.InfiniteJump = val
        end
    })
end

-- ── [Tab 9 - Subnav: World Teleports] ────────────────────────────────────────────────
if NavMove_TP then
    local SecTP = NavMove_TP:AddSection("Instant Waypoints & Portals")

    SecTP:AddButton({
        Name     = "Teleport to Spawn",
        Callback = function()
            refreshChar()
            if Root then
                Root.CFrame = CFrame.new(0, 10, 0)
            end
        end
    })

    SecTP:AddButton({
        Name     = "Teleport to Forge Table",
        Callback = function()
            refreshChar()
            if Root and WorldModelFolder then
                local forgeTbl = WorldModelFolder:FindFirstChild("ForgeTable")
                if forgeTbl then
                    Root.CFrame = forgeTbl:GetPivot() * CFrame.new(0, 3, 4)
                end
            end
        end
    })

    SecTP:AddButton({
        Name     = "Teleport to World Boss Portal",
        Callback = function()
            refreshChar()
            if Root and TouchedFolder then
                local wb = TouchedFolder:FindFirstChild("WorldBoss")
                if wb and wb:IsA("BasePart") then
                    Root.CFrame = wb.CFrame * CFrame.new(0, 4, 0)
                end
            end
        end
    })

    SecTP:AddButton({
        Name     = "Teleport to Dungeon Portal",
        Callback = function()
            refreshChar()
            if Root and TouchedFolder then
                local dg = TouchedFolder:FindFirstChild("DungeonOpen")
                if dg and dg:IsA("BasePart") then
                    Root.CFrame = dg.CFrame * CFrame.new(0, 4, 0)
                end
            end
        end
    })

    SecTP:AddButton({
        Name     = "Teleport to Class Area",
        Callback = function()
            refreshChar()
            if Root and WorldModelFolder then
                local cMap = WorldModelFolder:FindFirstChild("ClassMap")
                if cMap then
                    Root.CFrame = cMap:GetPivot() * CFrame.new(0, 5, 0)
                end
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 10: ESP & VISUALS
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabESP = Window and Window:CreateTab({
    Name = "Visuals",
    Icon = "eye",
    Description = "Enemy Highlights, Health Bars, Ore & Loot Trackers"
})

local NavESP_Enemy, NavESP_Objects
if TabESP then
    local sections = TabESP:AddSubNav({
        "Enemy ESP",
        "Object ESP"
    })
    NavESP_Enemy   = sections["Enemy ESP"]
    NavESP_Objects = sections["Object ESP"]
end

-- ── [Tab 10 - Subnav: Enemy ESP] ─────────────────────────────────────────────────────
if NavESP_Enemy then
    local SecEnemyESP = NavESP_Enemy:AddSection("Enemy & Boss ESP")

    UI_Controls.ESP_Enemy = SecEnemyESP:AddToggle({
        Name     = "Enable Enemy ESP",
        Default  = false,
        Flag     = "ESP_Enemy",
        Callback = function(val)
            PH.ESP_Enemy = val
        end
    })

    UI_Controls.ESP_Health = SecEnemyESP:AddToggle({
        Name     = "Show Enemy Health",
        Default  = true,
        Flag     = "ESP_Health",
        Callback = function(val)
            PH.ESP_Health = val
        end
    })

    UI_Controls.ESP_Distance = SecEnemyESP:AddToggle({
        Name     = "Show Enemy Distance",
        Default  = true,
        Flag     = "ESP_Distance",
        Callback = function(val)
            PH.ESP_Distance = val
        end
    })

    UI_Controls.ESP_BossHighlight = SecEnemyESP:AddToggle({
        Name     = "Boss Special Highlight (Gold)",
        Default  = true,
        Flag     = "ESP_BossHighlight",
        Callback = function(val)
            PH.ESP_BossHighlight = val
        end
    })

    UI_Controls.ESP_MaxDistance = SecEnemyESP:AddSlider({
        Name     = "Max Render Distance",
        Min      = 50,
        Max      = 2000,
        Default  = 1000,
        Flag     = "ESP_MaxDistance",
        Callback = function(val)
            PH.ESP_MaxDistance = val
        end
    })
end

-- ── [Tab 10 - Subnav: Object ESP] ────────────────────────────────────────────────────
if NavESP_Objects then
    local SecObjESP = NavESP_Objects:AddSection("Items & Ores ESP")

    UI_Controls.ESP_Ore = SecObjESP:AddToggle({
        Name     = "Ore Drop ESP",
        Default  = false,
        Flag     = "ESP_Ore",
        Callback = function(val)
            PH.ESP_Ore = val
        end
    })

    UI_Controls.ESP_SuperLoot = SecObjESP:AddToggle({
        Name     = "Super Loot Box ESP",
        Default  = false,
        Flag     = "ESP_SuperLoot",
        Callback = function(val)
            PH.ESP_SuperLoot = val
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 11: GRAPHICS & TELEMETRY
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabGfx = Window and Window:CreateTab({
    Name = "Graphics",
    Icon = "sliders",
    Description = "Live Telemetry, Performance Graphs & FPS Optimization"
})

local NavGfx_Graphs, NavGfx_Opt
if TabGfx then
    local sections = TabGfx:AddSubNav({
        "Live Telemetry",
        "Optimization"
    })
    NavGfx_Graphs = sections["Live Telemetry"]
    NavGfx_Opt    = sections["Optimization"]
end

-- ── [Tab 11 - Subnav: Live Telemetry] ────────────────────────────────────────────────
if NavGfx_Graphs then
    local SecTelemetry = NavGfx_Graphs:AddSection("Real-Time Telemetry Monitor")

    local fpsSample = 60
    local lastTick = tick()
    RunService.RenderStepped:Connect(function()
        local now = tick()
        local dt = now - lastTick
        lastTick = now
        if dt > 0 then
            fpsSample = math.floor(1 / dt)
        end
    end)

    SecTelemetry:AddGraph({
        Name   = "Render Frame Rate (FPS)",
        Min    = 0,
        Max    = 144,
        Suffix = " FPS",
        Value  = function()
            return fpsSample
        end
    })

    SecTelemetry:AddGraph({
        Name   = "Active Enemies in Range",
        Min    = 0,
        Max    = 50,
        Suffix = " Mobs",
        Value  = function()
            local count = 0
            if EnemyFolder then
                for _, mob in ipairs(EnemyFolder:GetChildren()) do
                    if mob:IsA("Model") and not mob:GetAttribute("Dead") then
                        count = count + 1
                    end
                end
            end
            return count
        end
    })
end

-- ── [Tab 11 - Subnav: Optimization] ──────────────────────────────────────────────────
if NavGfx_Opt then
    local SecOpt = NavGfx_Opt:AddSection("Performance & Lighting Controls")

    UI_Controls.PotatoMode = SecOpt:AddToggle({
        Name     = "Potato Mode / FPS Booster",
        Default  = false,
        Flag     = "PotatoMode",
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
        Flag     = "Fullbright",
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

    UI_Controls.FOVValue = SecOpt:AddSlider({
        Name     = "Camera Field of View",
        Min      = 60,
        Max      = 120,
        Default  = 70,
        Flag     = "FOVValue",
        Callback = function(val)
            PH.FOVValue = val
            if Camera then
                Camera.FieldOfView = val
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- TAB 12: SETTINGS & CONFIG MANAGER
-- ═════════════════════════════════════════════════════════════════════════════════════
local TabSettings = Window and Window:CreateTab({
    Name = "Settings",
    Icon = "settings",
    Description = "Custom Profile Names, Save / Load & Script Controls"
})

local NavSet_Profiles, NavSet_Misc
if TabSettings then
    local sections = TabSettings:AddSubNav({
        "Config Profiles",
        "UI & Server Settings"
    })
    NavSet_Profiles = sections["Config Profiles"]
    NavSet_Misc     = sections["UI & Server Settings"]
end

-- ── [Tab 12 - Subnav: Config Profiles] ───────────────────────────────────────────────
if NavSet_Profiles then
    local SecConfig = NavSet_Profiles:AddSection("Config Profile Management")

    local ConfigDropdownRef = nil

    SecConfig:AddInput({
        Name        = "Config Profile Name",
        Placeholder = "Type profile name...",
        Flag        = "ConfigNameInput",
        Callback    = function(text)
            if text and text ~= "" then
                PH.ConfigName = text
            end
        end
    })

    ConfigDropdownRef = SecConfig:AddDropdown({
        Name     = "Select Saved Profile",
        Options  = GetConfigList(),
        Default  = "Default",
        Flag     = "SelectedProfileDropdown",
        Callback = function(selected)
            if selected and selected ~= "" then
                PH.ConfigName = selected
            end
        end
    })

    SecConfig:AddButton({
        Name     = "Save Config Profile",
        Callback = function()
            local success = SaveConfig(PH.ConfigName)
            if PinatHubAdapter and PinatHubAdapter.Notify then
                PinatHubAdapter:Notify({
                    Title    = "Config Manager",
                    Content  = success and ("Saved: " .. PH.ConfigName) or "Failed to save profile!",
                    Duration = 2.5
                })
            end
            if ConfigDropdownRef and ConfigDropdownRef.Refresh then
                ConfigDropdownRef:Refresh(GetConfigList(), PH.ConfigName)
            end
        end
    })

    SecConfig:AddButton({
        Name     = "Load Config Profile",
        Callback = function()
            local success = LoadConfig(PH.ConfigName)
            if PinatHubAdapter and PinatHubAdapter.Notify then
                PinatHubAdapter:Notify({
                    Title    = "Config Manager",
                    Content  = success and ("Loaded: " .. PH.ConfigName) or "Failed to load profile!",
                    Duration = 2.5
                })
            end
        end
    })

    SecConfig:AddButton({
        Name     = "Delete Config Profile",
        Callback = function()
            local success = DeleteConfig(PH.ConfigName)
            if PinatHubAdapter and PinatHubAdapter.Notify then
                PinatHubAdapter:Notify({
                    Title    = "Config Manager",
                    Content  = success and ("Deleted: " .. PH.ConfigName) or "Cannot delete Default!",
                    Duration = 2.5
                })
            end
            if ConfigDropdownRef and ConfigDropdownRef.Refresh then
                ConfigDropdownRef:Refresh(GetConfigList(), "Default")
            end
        end
    })

    SecConfig:AddButton({
        Name     = "Refresh Profiles List",
        Callback = function()
            if ConfigDropdownRef and ConfigDropdownRef.Refresh then
                ConfigDropdownRef:Refresh(GetConfigList(), PH.ConfigName)
            end
        end
    })
end

-- ── [Tab 12 - Subnav: UI & Server Settings] ──────────────────────────────────────────
if NavSet_Misc then
    local SecMisc = NavSet_Misc:AddSection("Script & Server Controls")

    SecMisc:AddButton({
        Name     = "Rejoin Server",
        Callback = function()
            local ts = game:GetService("TeleportService")
            ts:Teleport(game.PlaceId, LocalPlayer)
        end
    })

    SecMisc:AddButton({
        Name     = "Unload PinatHub",
        Callback = function()
            PH.AutoTrain  = false
            PH.AutoAttack = false
            PH.KillAura   = false
            PH.FlyEnabled = false
            PH.Noclip     = false
            if Window and Window.Destroy then
                Window:Destroy()
            end
        end
    })
end

-- ═════════════════════════════════════════════════════════════════════════════════════
-- BACKGROUND AUTOMATION ENGINES (RUN LOOPS)
-- ═════════════════════════════════════════════════════════════════════════════════════

-- ── Engine 1: Auto Train Loop ────────────────────────────────────────────────────────
task.spawn(function()
    while true do
        if PH.AutoTrain then
            local uuid = PopTrainTargetUUID()
            if TrainOnceRE and uuid then
                TrainOnceRE:FireServer(uuid)
                if PH.TrainClickAura then
                    for _ = 1, 3 do
                        local extraUuid = PopTrainTargetUUID()
                        if extraUuid then TrainOnceRE:FireServer(extraUuid) end
                    end
                end
            elseif ATKOnceBE then
                ATKOnceBE:Fire()
            end
            task.wait(PH.TrainSpeed or 0.05)
        else
            task.wait(0.2)
        end
    end
end)

-- ── Engine 2: Auto Rebirth Loop ──────────────────────────────────────────────────────
task.spawn(function()
    while true do
        if PH.AutoRebirth and TryRebirthRE then
            pcall(function()
                local eco = LocalPlayer:FindFirstChild("Eco")
                local lvl = eco and eco:FindFirstChild("level")
                if lvl and lvl.Value >= 25 then
                    TryRebirthRE:FireServer()
                end
            end)
            task.wait(2.5)
        else
            task.wait(1.0)
        end
    end
end)

-- ── Helper: Mob Finding & Filtering ──────────────────────────────────────────────────
local function GetTargetMobs()
    local targets = {}
    if not EnemyFolder then return targets end
    refreshChar()
    if not Root then return targets end

    for _, mob in ipairs(EnemyFolder:GetChildren()) do
        if mob:IsA("Model") and not mob:GetAttribute("Dead") then
            local mRoot = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChildWhichIsA("BasePart")
            local mHum  = mob:FindFirstChildOfClass("Humanoid")
            if mRoot and (not mHum or mHum.Health > 0) then
                local isBoss = mob:GetAttribute("IsBoss") == true
                if PH.MobTargetFilter == "All Enemies"
                    or (PH.MobTargetFilter == "Bosses Only" and isBoss)
                    or (PH.MobTargetFilter == "Normal Mobs Only" and not isBoss) then
                    table.insert(targets, mob)
                end
            end
        end
    end

    table.sort(targets, function(a, b)
        local rA = a:FindFirstChild("HumanoidRootPart") or a:FindFirstChildWhichIsA("BasePart")
        local rB = b:FindFirstChild("HumanoidRootPart") or b:FindFirstChildWhichIsA("BasePart")
        if rA and rB and Root then
            return (rA.Position - Root.Position).Magnitude < (rB.Position - Root.Position).Magnitude
        end
        return false
    end)

    return targets
end

-- ── Engine 3: Auto Attack & Kill Aura Loop ───────────────────────────────────────────
task.spawn(function()
    local comboIndex = 1
    while true do
        if PH.AutoAttack or PH.KillAura then
            refreshChar()
            local targets = GetTargetMobs()

            if #targets > 0 and Root then
                local primary = targets[1]
                local mRoot = primary:FindFirstChild("HumanoidRootPart") or primary:FindFirstChildWhichIsA("BasePart")

                if mRoot then
                    -- Teleport Behind / Above Mob
                    if PH.AutoAttack and not PH.FlyEnabled then
                        Root.CFrame = CFrame.new(mRoot.Position + Vector3.new(0, PH.FarmHoverDistance, 0), mRoot.Position)
                    end

                    -- Swing Attack
                    local style = PH.WeaponComboStyle
                    if style == "Auto Detect" then
                        local attr = LocalPlayer:GetAttribute("WeaponType")
                        style = (attr == "Great") and "Greatsword" or "Katana"
                    end

                    local prefix = (style == "Greatsword") and "G_ATK_" or "K_ATK_"
                    local atkName = prefix .. comboIndex
                    comboIndex = (comboIndex % 3) + 1

                    if UseAnyATKRE then
                        pcall(function()
                            UseAnyATKRE:FireServer(atkName, Workspace:GetServerTimeNow())
                        end)
                    end
                    if ATKOnceBE then
                        pcall(function() ATKOnceBE:Fire() end)
                    end

                    -- Instant Kill / Damage Sync
                    if PH.InstantKill then
                        if HPCTRL and HPCTRL.DamageOnce then
                            pcall(function() HPCTRL.DamageOnce(primary, 999999999) end)
                        end
                        if KillEnemyRE then
                            pcall(function() KillEnemyRE:FireServer(primary.Name) end)
                        end
                    end

                    -- Kill Aura Multi-Target
                    if PH.KillAura and #targets > 1 then
                        for i = 2, math.min(#targets, 5) do
                            local extraMob = targets[i]
                            if extraMob and KillEnemyRE and PH.InstantKill then
                                pcall(function() KillEnemyRE:FireServer(extraMob.Name) end)
                            end
                        end
                    end
                end
            end
            task.wait(PH.AttackRate or 0.1)
        else
            task.wait(0.2)
        end
    end
end)

-- ── Engine 4: Auto Weapon Skills Loop ────────────────────────────────────────────────
task.spawn(function()
    while true do
        if (PH.AutoSkill1 or PH.AutoSkill2) and UseSkillByIndexBE then
            if PH.AutoSkill1 then
                pcall(function() UseSkillByIndexBE:Fire(1) end)
                task.wait(0.2)
            end
            if PH.AutoSkill2 then
                pcall(function() UseSkillByIndexBE:Fire(2) end)
            end
            task.wait(PH.SkillCastDelay or 1.5)
        else
            task.wait(0.5)
        end
    end
end)

-- ── Engine 5: Stage Progression, Mining & Auto Sell Loop ─────────────────────────────
task.spawn(function()
    while true do
        -- Stage Progress
        if PH.AutoProgressStage and StageFinishedRF then
            pcall(function()
                local curStage = LocalPlayer:GetAttribute("StageID") or PH.SelectedStage
                local num = tonumber(string.match(tostring(curStage), "%d+")) or 1
                StageFinishedRF:InvokeServer(num)
            end)
        end

        -- Claim All Ores
        if PH.AutoClaimAllOre and ClaimedAllOreRE then
            pcall(function() ClaimedAllOreRE:FireServer() end)
        end

        -- Auto Sell All Ores
        if PH.AutoSellAllOres and BackpackData and BackpackData.SellAll then
            pcall(function() BackpackData.SellAll() end)
        end

        -- Super Loot
        if PH.AutoSuperLoot and SuperLootFolder and KillSuperLootRE then
            for _, box in ipairs(SuperLootFolder:GetChildren()) do
                pcall(function() KillSuperLootRE:FireServer(box.Name) end)
            end
        end

        task.wait(1.5)
    end
end)

-- ── Engine 6: World Boss Loop ────────────────────────────────────────────────────────
task.spawn(function()
    while true do
        local hasBoss = Workspace:GetAttribute("CurrentWorldBoss") ~= nil
        if hasBoss then
            -- Auto Join
            if PH.AutoJoinWorldBoss and IntoWorldBossFight then
                pcall(function()
                    IntoWorldBossFight:FireServer()
                end)
            end

            -- Auto Collect Buff / HP Balls
            if PH.AutoCollectBossBalls and TryGetHPBallRF then
                for i = 1, 5 do
                    pcall(function() TryGetHPBallRF:InvokeServer(i) end)
                end
            end
        end

        -- Auto Claim Rewards
        if PH.AutoClaimBossReward and TryClaimBossRewardRE then
            local cardStr = tostring(PH.SelectedRewardCard or 1)
            pcall(function() TryClaimBossRewardRE:FireServer(cardStr) end)
        end

        task.wait(2.0)
    end
end)

-- ── Engine 7: Auto Stat Upgrades & Equipment Forge Loop ──────────────────────────────
task.spawn(function()
    while true do
        -- Stat Upgrades
        if UpgradeOnceRE then
            if PH.AutoUpgradeLuck then
                pcall(function() UpgradeOnceRE:FireServer("Luck") end)
            end
            if PH.AutoUpgradeOrePack then
                pcall(function() UpgradeOnceRE:FireServer("OrePack") end)
            end
            if PH.AutoUpgradeTrain then
                pcall(function() UpgradeOnceRE:FireServer("Train") end)
            end
        end

        -- Weapon & Armor Forging
        if (PH.AutoForgeWeapon or PH.AutoForgeArmor) and ForgeRF then
            pcall(function() ForgeRF:InvokeServer({}) end)
        end

        -- Elemental Enchanting
        if PH.AutoEnchantEquipment and BackpackData and BackpackData.EnchantEquipment then
            pcall(function()
                BackpackData.EnchantEquipment("Weapon", PH.SelectedEnchantType or "Fire", "1")
            end)
        end

        -- Class Reroll
        if PH.AutoRollClass and ClassData and ClassData.LuckOnce then
            pcall(function()
                ClassData.LuckOnce(PH.SelectedClassSlot or 1)
            end)
        end

        -- Auto Consume Potions
        if PH.AutoUsePotion and TryUsePotionRE then
            pcall(function() TryUsePotionRE:FireServer(PH.SelectedPotion, 1) end)
        end

        -- Auto Offline Rewards
        if PH.AutoOfflineReward and TryClaimOfflineRE then
            pcall(function() TryClaimOfflineRE:FireServer() end)
        end

        task.wait(2.0)
    end
end)

-- ── Engine 8: Movement (Fly, Noclip, Speed, Jump) ────────────────────────────────────
local FlyBodyVel = nil
local FlyBodyGyro = nil

RunService.Stepped:Connect(function()
    refreshChar()
    if not Character or not Root then return end

    -- Noclip
    if PH.Noclip then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    -- Speed & Jump
    if Humanoid then
        if PH.WalkSpeedBoost then
            Humanoid.WalkSpeed = PH.WalkSpeedValue or 16
        end
        if PH.JumpPowerBoost then
            Humanoid.JumpPower = PH.JumpPowerValue or 50
        end
    end

    -- Fly Implementation
    if PH.FlyEnabled and Root then
        if not FlyBodyVel then
            FlyBodyVel = Instance.new("BodyVelocity")
            FlyBodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            FlyBodyVel.Parent = Root
        end
        if not FlyBodyGyro then
            FlyBodyGyro = Instance.new("BodyGyro")
            FlyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            FlyBodyGyro.P = 1e4
            FlyBodyGyro.Parent = Root
        end

        FlyBodyGyro.CFrame = Camera.CFrame
        local moveDir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        if moveDir.Magnitude > 0 then
            FlyBodyVel.Velocity = moveDir.Unit * (PH.FlySpeed or 50)
        else
            FlyBodyVel.Velocity = Vector3.zero
        end
    else
        if FlyBodyVel then FlyBodyVel:Destroy(); FlyBodyVel = nil end
        if FlyBodyGyro then FlyBodyGyro:Destroy(); FlyBodyGyro = nil end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if PH.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ── Engine 9: Visuals & ESP Engine ───────────────────────────────────────────────────
local ESP_Highlights = {}

RunService.RenderStepped:Connect(function()
    refreshChar()
    if not PH.ESP_Enemy or not EnemyFolder or not Root then
        for _, hl in pairs(ESP_Highlights) do
            if hl and hl.Parent then hl:Destroy() end
        end
        table.clear(ESP_Highlights)
        return
    end

    local maxDist = PH.ESP_MaxDistance or 1000

    for _, mob in ipairs(EnemyFolder:GetChildren()) do
        if mob:IsA("Model") and not mob:GetAttribute("Dead") then
            local mRoot = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChildWhichIsA("BasePart")
            if mRoot then
                local dist = (mRoot.Position - Root.Position).Magnitude
                if dist <= maxDist then
                    if not ESP_Highlights[mob] then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = mob
                        hl.FillTransparency = 0.6
                        hl.OutlineTransparency = 0.1
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = mob

                        local isBoss = mob:GetAttribute("IsBoss") == true
                        if isBoss and PH.ESP_BossHighlight then
                            hl.FillColor = Color3.fromRGB(255, 215, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 69, 0)
                        else
                            hl.FillColor = Color3.fromRGB(220, 20, 60)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                        ESP_Highlights[mob] = hl
                    end
                elseif ESP_Highlights[mob] then
                    ESP_Highlights[mob]:Destroy()
                    ESP_Highlights[mob] = nil
                end
            end
        elseif ESP_Highlights[mob] then
            ESP_Highlights[mob]:Destroy()
            ESP_Highlights[mob] = nil
        end
    end
end)

-- ── Notification On Success ──────────────────────────────────────────────────────────
if PinatHubAdapter and PinatHubAdapter.Notify then
    PinatHubAdapter:Notify({
        Title    = "PinatHub Loaded",
        Content  = "Anime Blade Multi-Module Master Active!",
        Duration = 4
    })
end

print("[PinatHub] Anime Blade Champions Master Edition Initialized Successfully.")

end -- End __PinatHub_AnimeBlade_Init__

pcall(__PinatHub_AnimeBlade_Init__)
