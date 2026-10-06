-- ╔══════════════════════════════════════════════════════════════════════════════════╗
-- ║        PinatHub — The Underground: Drill to the Core / SharedPlanets             ║
-- ║       Comprehensive Automation, Combat, Mining, Drill & Dungeon System           ║
-- ║           Engineered with KingRua UI Library & Native Knit Framework             ║
-- ╚══════════════════════════════════════════════════════════════════════════════════╝

local function __PinatHub_SharedPlanets_Init__()

-- ── Core Roblox Engine Services ──────────────────────────────────────────────────────
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Workspace         = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")
local Debris            = game:GetService("Debris")
local TextService       = game:GetService("TextService")
local Stats             = game:GetService("Stats")

local Camera      = Workspace.CurrentCamera or Workspace:WaitForChild("Camera", 5)
local LocalPlayer = Players.LocalPlayer
local Character, Humanoid, Root

local function refreshChar(char)
    Character = char or LocalPlayer.Character
    Humanoid  = Character and Character:FindFirstChildOfClass("Humanoid")
    Root      = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso") or Character.PrimaryPart)
end
refreshChar()
LocalPlayer.CharacterAdded:Connect(refreshChar)

-- ── Multi-Tier Knit Framework Resolver ────────────────────────────────────────────────
local Knit = nil
pcall(function()
    Knit = require(ReplicatedStorage:WaitForChild("Packages", 3):WaitForChild("Knit", 3))
end)
if not Knit then
    pcall(function()
        Knit = require(ReplicatedStorage:WaitForChild("Knit", 2))
    end)
end
if not Knit and getrenv and getrenv().require then
    pcall(function()
        Knit = getrenv().require(ReplicatedStorage.Packages.Knit)
    end)
end

-- Safe Service Resolver with Direct Remote Fallback
local function SafeGetService(svcName)
    if Knit and Knit.GetService then
        local ok, svc = pcall(function() return Knit.GetService(svcName) end)
        if ok and svc then return svc end
    end

    -- Direct Remote Proxy Fallback via ReplicatedStorage.Knit.Services
    local kFolder = ReplicatedStorage:FindFirstChild("Knit") or (ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Knit"))
    local sFolder = kFolder and kFolder:FindFirstChild("Services") and kFolder.Services:FindFirstChild(svcName)
    if sFolder then
        local proxy = { _name = svcName, _folder = sFolder }
        setmetatable(proxy, {
            __index = function(_, key)
                local rf = sFolder:FindFirstChild("RF") and sFolder.RF:FindFirstChild(key)
                if rf and rf:IsA("RemoteFunction") then
                    return function(_, ...)
                        return rf:InvokeServer(...)
                    end
                end
                local re = sFolder:FindFirstChild("RE") and sFolder.RE:FindFirstChild(key)
                if re and re:IsA("RemoteEvent") then
                    return {
                        Connect = function(_, cb) return re.OnClientEvent:Connect(cb) end,
                        Fire = function(_, ...) return re:FireServer(...) end,
                        FireServer = function(_, ...) return re:FireServer(...) end
                    }
                end
                return function() end
            end
        })
        return proxy
    end
    return nil
end

-- Safe Controller Resolver
local function SafeGetController(ctrlName)
    if Knit and Knit.GetController then
        local ok, ctrl = pcall(function() return Knit.GetController(ctrlName) end)
        if ok and ctrl then return ctrl end
    end
    return nil
end

-- Game Services
local DrillService           = SafeGetService("DrillService")
local OreService             = SafeGetService("OreService")
local BulletService          = SafeGetService("BulletService")
local InteractionService     = SafeGetService("InteractionService")
local DragService            = SafeGetService("DragService")
local PlayerService          = SafeGetService("PlayerService")
local TeleportManagerService = SafeGetService("TeleportManagerService")
local ShopService            = SafeGetService("ShopService")
local CurrencyService        = SafeGetService("CurrencyService")
local CrateStorageService    = SafeGetService("CrateStorageService")
local RankedService          = SafeGetService("RankedService")
local ToolService            = SafeGetService("ToolService")
local AdventureQuestService  = SafeGetService("AdventureQuestService")
local ResourceScannerService = SafeGetService("ResourceScannerService")
local BadgeAwardingService   = SafeGetService("BadgeAwardingService")
local ClassService           = SafeGetService("ClassService")

-- Game Controllers
local ToolController               = SafeGetController("ToolController")
local DungeonUIController          = SafeGetController("DungeonUIController")
local CrateController              = SafeGetController("CrateController")
local UIController                 = SafeGetController("UIController")
local SoundController              = SafeGetController("SoundController")
local NotificationController       = SafeGetController("NotificationController")
local CameraController             = SafeGetController("CameraController")
local DungeonLootHighlightController = SafeGetController("DungeonLootHighlightController")

-- Notification Utility
local function Notify(msg, duration, color)
    duration = duration or 3
    color = color or Color3.fromRGB(0, 255, 170)
    if NotificationController and NotificationController.PlayNotification then
        pcall(function()
            NotificationController.PlayNotification(msg, duration, color, false)
        end)
    else
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "PinatHub",
                Text = msg,
                Duration = duration
            })
        end)
    end
end


-- ── KingRua UI Library Loader & Compatibility Adapter ─────────────────────────────────
local KingRua = nil
pcall(function()
    local source = game:HttpGet("https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/main/kingrualibrarysource.lua")
    if source and #source > 100 then
        KingRua = loadstring(source)()
    end
end)

-- Fallback to local script if available
if not KingRua then
    pcall(function()
        local scr = script.Parent:FindFirstChild("kingrualibrarysource")
        if scr and scr:IsA("ModuleScript") then
            KingRua = require(scr)
        end
    end)
end

if not KingRua then
    -- Minimal standalone fallback UI engine if library download fails
    KingRua = {
        CreateWindow = function(_, cfg)
            local win = {}
            function win:AddTab(tcfg)
                local tab = { Name = tcfg.Name }
                function tab:AddSection(_)
                    local sec = {}
                    function sec:AddToggle(o) return o end
                    function sec:AddSlider(o) return o end
                    function sec:AddDropdown(o) return o end
                    function sec:AddButton(o) return o end
                    function sec:AddKeybind(o) return o end
                    function sec:AddParagraph(o) return { SetTitle = function() end, SetDesc = function() end, SetContent = function() end, Set = function() end } end
                    function sec:AddProgressBar(o) return { Set = function() end } end
                    function sec:AddGraph(o) return { Push = function() end, SetRate = function() end, SetMax = function() end, SetTitle = function() end } end
                    return sec
                end
                tab.CreateSection = tab.AddSection
                return tab
            end
            win.CreateTab = win.AddTab
            return win
        end
    }
end

-- Adapt Window methods
local origCreateWindow = KingRua.CreateWindow
KingRua.CreateWindow = function(self, config)
    local win = origCreateWindow(self, config)
    if win and not win.CreateTab and win.AddTab then
        win.CreateTab = function(s, tabConfig)
            local tabObj = s:AddTab(tabConfig)
            if tabObj and not tabObj.CreateSection and tabObj.AddSection then
                tabObj.CreateSection = function(ts, secName)
                    return ts:AddSection(secName)
                end
            end
            return tabObj
        end
    end
    return win
end

local Window = KingRua:CreateWindow({
    Title = "PinatHub",
    SubTitle = "The Underground: Drill to the Core",
    TabWidth = 175,
    Size = UDim2.fromOffset(610, 485),
    Theme = "Default"
})


-- ── State Management Table ───────────────────────────────────────────────────────────
local Flags = {
    -- Mining & Ores
    AutoMine = false,
    MiningAura = false,
    MiningAuraRadius = 30,
    MiningSpeedDelay = 0.15,
    OreFilter = "All Ores",
    AutoTweenOre = false,
    InstantBreakWalls = false,
    AutoScrapCollector = false,
    OreMagnet = false,
    AutoSellOres = false,

    -- Drill & Engine
    AutoDrillBoost = false,
    DrillBoostInterval = 1.0,
    AutoUpgradeDrill = false,
    UpgradePriority = "Drill Speed",
    AutoReroll = false,
    RerollThreshold = "Uncommon",
    AutoClassRewards = false,
    AutoRepairScreens = false,
    AutoTurretDefense = false,
    AutoVoteUnstuck = true,
    AutoContributeFuel = false,

    -- Combat & Guns
    SilentAim = false,
    SilentAimTarget = "Nearest NPC",
    KillAura = false,
    KillAuraRange = 25,
    AutoReload = false,
    GiantWormFarm = false,
    MimicKiller = false,
    NoSpreadRecoil = false,
    PerfectHammerCrit = false,

    -- Dungeon & Secrets
    AutoUnlockDoors = false,
    AutoLootChests = false,
    DungeonHighlightAlways = true,
    AutoTriggerWaves = false,
    AutoDungeonExit = false,

    -- Tools & Gear
    AutoHeal = false,
    HealThreshold = 50,
    AutoSpeedPotion = false,
    AutoAllPotions = false,
    AutoDragWeldCrates = false,
    AutoStoreTools = false,
    AutoSaveGear = false,
    InstantSelfRevive = false,
    AutoDeathChests = false,
    InfiniteBagCapacity = false,

    -- Classes & Passives Injector
    GodPassivesEnabled = false,
    TeamBuffsEnabled = false,
    AutoGodDamage = false,

    -- Crafting & Deployables
    AutoCraftAmmo = false,
    CraftAmmoType = "Pistol_Ammo",
    BlackholeSpam = false,
    GoblinArmySpam = false,
    AutoDeployDecoys = false,
    AntiTurretOverheat = false,

    -- Quests & Achievements
    AutoCompleteQuests = false,
    AutoClaimAchievements = false,

    -- Advanced Survival & Defense
    AutoRevive = false,
    InstantSelfRevive = false,
    KillFuelLeeches = false,

    -- Dungeon Advanced & Exploits
    BypassOneWayDoors = false,
    AutoScanDoors = false,

    -- Drill & Drag Advanced
    ExtendedDragReach = false,
    MuteAmbience = false,

    -- Auto Drive Drill System
    AutoDriveDrill = false,
    AutoDriveSpeed = 55,
    AutoSitDriver = true,
    DrillAntiStuck = true,

    -- Auto Collect All Items System
    AutoCollectItems = false,
    ItemCollectFilter = "All Items",
    ItemCollectRadius = 60,
    ItemCollectDelay = 0.12,
    VacuumItemsToPlayer = true,
    AutoStoreInSack = true,

    -- Performance & Lag Reducer
    DisableParticleLag = false,

    -- Player & Movement
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    JumpPowerEnabled = false,
    JumpPowerValue = 50,
    InfiniteJump = false,
    FlyEnabled = false,
    FlySpeed = 50,
    Noclip = false,
    Fullbright = false,
    AntiVoid = true,

    -- ESP & Visuals
    OreESP = false,
    OreESPMaxDist = 400,
    NpcESP = false,
    ChestESP = false,
    DrillTrackerHUD = true,
    PlayerESP = false,
    TelemetryHUD = true,

    -- Telemetry stats trackers
    SessionMined = {
        Coal = 0,
        Iron = 0,
        Gold = 0,
        Emerald = 0,
        Ruby = 0,
        Diamond = 0,
        Heartgem = 0,
        Total = 0
    },
    SessionStartTime = os.time(),

    -- Internal state
    Unloaded = false
}

-- ── Item Filtering & Collection Helpers ───────────────────────────────────────────────

local function MatchesItemFilter(item)
    if not item then return false end
    local name = item.Name:lower()
    local cat = item:GetAttribute("Category") or ""
    cat = tostring(cat):lower()
    local filter = Flags.ItemCollectFilter or "All Items"

    if filter == "All Items" then
        return true
    elseif filter == "Ores & Minerals" then
        return name:find("ore") or name:find("coal") or name:find("iron") or name:find("gold") or name:find("emerald") or name:find("ruby") or name:find("diamond") or name:find("heartgem") or cat == "ore" or cat == "gem"
    elseif filter == "Money & Sacks" then
        return name:find("money") or name:find("sack") or name:find("coin") or name:find("soulorb") or name:find("medal")
    elseif filter == "Fuel & Gas Cans" then
        return name:find("gas") or name:find("fuel") or name:find("can") or name:find("oil") or cat == "fuel"
    elseif filter == "Supply Crates & Chests" then
        return name:find("crate") or name:find("chest") or CollectionService:HasTag(item, "Crate") or CollectionService:HasTag(item, "SupplyCrate")
    elseif filter == "Consumables & Medkits" then
        return name:find("medkit") or name:find("potion") or name:find("bandage") or cat == "consumable"
    elseif filter == "Weapons & Ammo" then
        return name:find("ammo") or name:find("gun") or name:find("sword") or name:find("bullet") or name:find("pickaxe") or cat:find("gun") or cat:find("weapon") or cat == "ammo"
    elseif filter == "Crafted Placeables" then
        return item:GetAttribute("CraftedPlaceable") == true or name:find("turret") or name:find("sentry") or name:find("cannon") or name:find("decoy") or name:find("autopilot") or cat == "placeable"
    elseif filter == "Scrap & Materials" then
        return name:find("scrap") or name:find("wire") or name:find("copper") or name:find("metal") or cat == "scrap"
    end
    return true
end

local function CollectItem(item)
    if not item or not Root then return end
    pcall(function()
        local part = item:IsA("BasePart") and item or item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if not part then return end

        -- 1. Trigger ProximityPrompt
        local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt then
            pcall(function() fireproximityprompt(prompt) end)
        end

        -- 2. Trigger InteractionService
        if InteractionService and InteractionService.Interact then
            InteractionService:Interact(item)
        end

        -- 3. Vacuum item to character
        if Flags.VacuumItemsToPlayer then
            part.CFrame = Root.CFrame
        end

        -- 4. Touch interest pickup
        if firetouchinterest then
            firetouchinterest(Root, part, 0)
            firetouchinterest(Root, part, 1)
        end

        -- 5. Bag tool pickup
        if Flags.AutoStoreInSack then
            local tool = GetActiveTool()
            if tool and type(tool) == "table" and tool.Execute then
                tool.Execute:Fire({"Pickup", item})
            end
        end
    end)
end

-- ── Tool & Game Mechanics Helpers ─────────────────────────────────────────────────────

-- Retrieve current active tool instance
local function GetActiveTool()
    if ToolController and ToolController.ActiveTool then
        return ToolController.ActiveTool
    end
    if Character then
        local equipped = Character:FindFirstChildOfClass("Tool")
        if equipped then return equipped end
    end
    return nil
end

-- Fire tool action through CustomTool.Execute signal or direct method (FIXED VARARG)
local function ExecuteToolAction(action, ...)
    local args = { ... }
    local tool = GetActiveTool()
    if not tool then return false end

    -- CustomTool instance with Execute signal
    if type(tool) == "table" and tool.Execute and tool.Execute.Fire then
        pcall(function()
            local payload = { action }
            for i = 1, #args do
                table.insert(payload, args[i])
            end
            tool.Execute:Fire(payload)
        end)
        return true
    end

    -- Direct method invocation fallback
    if type(tool) == "table" then
        if action == "Swing" and tool.Swing then
            pcall(function() tool:Swing() end)
            return true
        elseif action == "Shoot" and tool.Shoot then
            pcall(function() tool:Shoot(unpack(args)) end)
            return true
        elseif action == "Consume" and tool.Consume then
            pcall(function() tool:Consume() end)
            return true
        elseif action == "Use" and tool.Use then
            pcall(function() tool:Use() end)
            return true
        elseif action == "Reload" and tool.Reload then
            pcall(function() tool:Reload() end)
            return true
        end
    end

    return false
end

-- Locate the Drill Model in Workspace
local function FindDrillModel()
    local drill = Workspace:FindFirstChild("Drill") or Workspace:FindFirstChild("DrillModel")
    if drill then return drill end

    for _, tag in ipairs({"Drill", "DrillBounds", "TreadManager"}) do
        local tagged = CollectionService:GetTagged(tag)
        if #tagged > 0 then
            local obj = tagged[1]
            local m = obj:FindFirstAncestorOfClass("Model") or obj
            if m then return m end
        end
    end

    local map = Workspace:FindFirstChild("Map") or Workspace
    for _, child in ipairs(map:GetChildren()) do
        if child.Name:lower():find("drill") then
            return child
        end
    end
    return nil
end

-- Ore Rarity & Value Resolver
local function GetOreInfo(oreInstance)
    local modelAttr = oreInstance:GetAttribute("Ore_Model") or oreInstance.Name
    local name = tostring(modelAttr)
    local rarity = "Coal"
    local color = Color3.fromRGB(150, 150, 150)
    local tier = 1

    if name:find("Heartgem") then
        rarity = "Heartgem"
        color = Color3.fromRGB(255, 60, 160)
        tier = 7
    elseif name:find("Diamond") then
        rarity = "Diamond"
        color = Color3.fromRGB(80, 230, 255)
        tier = 6
    elseif name:find("Ruby") then
        rarity = "Ruby"
        color = Color3.fromRGB(255, 45, 45)
        tier = 5
    elseif name:find("Emerald") then
        rarity = "Emerald"
        color = Color3.fromRGB(50, 255, 90)
        tier = 4
    elseif name:find("Gold") then
        rarity = "Gold"
        color = Color3.fromRGB(255, 215, 0)
        tier = 3
    elseif name:find("Iron") then
        rarity = "Iron"
        color = Color3.fromRGB(210, 210, 220)
        tier = 2
    elseif name:find("Coal") then
        rarity = "Coal"
        color = Color3.fromRGB(120, 120, 120)
        tier = 1
    end

    return rarity, color, tier
end

-- Filter check for Ore
local function MatchesOreFilter(rarity)
    local filter = Flags.OreFilter
    if filter == "All Ores" then return true end
    if filter == "Heartgem Only" then return rarity == "Heartgem" end
    if filter == "Diamond+" then return rarity == "Diamond" or rarity == "Heartgem" end
    if filter == "Ruby / Emerald+" then return rarity == "Ruby" or rarity == "Emerald" or rarity == "Diamond" or rarity == "Heartgem" end
    if filter == "Gold+" then return rarity == "Gold" or rarity == "Ruby" or rarity == "Emerald" or rarity == "Diamond" or rarity == "Heartgem" end
    if filter == "Iron+" then return rarity ~= "Coal" end
    if filter == "Coal Only" then return rarity == "Coal" end
    return true
end

-- Depth Layer resolver
local function GetCurrentDepthName(depthMeters)
    if depthMeters < 100 then return "Surface" end
    if depthMeters < 500 then return "Clay & Soil Layer" end
    if depthMeters < 1200 then return "Fossil & Iron Caverns" end
    if depthMeters < 2200 then return "Crystal & Gemstone Layer" end
    if depthMeters < 3500 then return "Toxic Zone" end
    if depthMeters < 5000 then return "Frozen Deep" end
    if depthMeters < 7500 then return "The Abyss" end
    if depthMeters < 10000 then return "The Void" end
    return "Glowing Planetary Core"
end


-- ── UI Tabs Construction ──────────────────────────────────────────────────────────────
local AnalyticsTab = Window:CreateTab({ Name = "📊 Live Analytics",   Icon = "rbxassetid://10723345518" })
local MiningTab    = Window:CreateTab({ Name = "Mining & Ores",       Icon = "rbxassetid://10723415903" })
local DrillTab     = Window:CreateTab({ Name = "Drill & Engine",      Icon = "rbxassetid://10734950309" })
local CombatTab    = Window:CreateTab({ Name = "Combat & Guns",       Icon = "rbxassetid://10734975692" })
local ClassesTab   = Window:CreateTab({ Name = "Classes & Passives",  Icon = "rbxassetid://10734975486" })
local CraftingTab  = Window:CreateTab({ Name = "Crafting & Fuel",     Icon = "rbxassetid://10734924532" })
local TacticalTab  = Window:CreateTab({ Name = "Tactical & Weapons",  Icon = "rbxassetid://10734975692" })
local DungeonTab   = Window:CreateTab({ Name = "Dungeon & Secrets",   Icon = "rbxassetid://10723346959" })
local QuestsTab    = Window:CreateTab({ Name = "Quests & Badges",     Icon = "rbxassetid://10723415903" })
local ToolsTab     = Window:CreateTab({ Name = "Tools & Gear",        Icon = "rbxassetid://10734924532" })
local PlayerTab    = Window:CreateTab({ Name = "Player & Move",       Icon = "rbxassetid://10747373176" })
local VisualsTab   = Window:CreateTab({ Name = "ESP & Visuals",       Icon = "rbxassetid://10723345518" })
local TeleportTab  = Window:CreateTab({ Name = "Teleports & Depth",   Icon = "rbxassetid://10734975486" })
local SettingsTab  = Window:CreateTab({ Name = "Settings & Info",     Icon = "rbxassetid://10734950020" })

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 0: 📊 Live Analytics & Real-Time Graphic Telemetry
-- ──────────────────────────────────────────────────────────────────────────────────────
local LiveGraphSec = AnalyticsTab:AddSection("Real-Time Depth & Velocity Chart")

local DepthProgressBar = LiveGraphSec:AddProgressBar({
    Title = "Planetary Core Descent (-10,000m)",
    Default = 0,
    Max = 10000
})

local DrillSpeedGraph = LiveGraphSec:AddGraph({
    Title = "Drill Velocity Telemetry",
    BarCount = 14,
    MaxValue = 80,
    Height = 110,
    BarColor = Color3.fromRGB(0, 255, 170),
    BarGlow = Color3.fromRGB(0, 200, 255),
    Unit = " studs/s"
})

local DepthProgressPara = LiveGraphSec:AddParagraph({
    Title = "Depth Progress Trajectory",
    Content = "Calculating trajectory...",
    DefaultOpen = true
})

local VelocityGaugePara = LiveGraphSec:AddParagraph({
    Title = "Drill Motor Status",
    Content = "Connecting telemetry feed...",
    DefaultOpen = true
})

local MiningStatsSec = AnalyticsTab:AddSection("Mined Ores Session Counter")

local OresCounterPara = MiningStatsSec:AddParagraph({
    Title = "Ore Yield Telemetry",
    Content = "Coal: 0 | Iron: 0 | Gold: 0\nEmerald: 0 | Ruby: 0 | Diamond: 0 | Heartgem: 0",
    DefaultOpen = true
})

local EconomyRadarSec = AnalyticsTab:AddSection("Economy & World Radar")

local EconomyPara = EconomyRadarSec:AddParagraph({
    Title = "Economy & Fuel Reserves",
    Content = "Cores: Syncing... | Currency: Syncing... | Larry Medals: Syncing...",
    DefaultOpen = true
})

local RadarPara = EconomyRadarSec:AddParagraph({
    Title = "Subsurface Radar & Threats",
    Content = "Living Hostiles: 0 | Worm Boss: Scanning... | Dungeon Status: Standby",
    DefaultOpen = true
})

local ClientDiagSec = AnalyticsTab:AddSection("Client Diagnostics & Performance")

local FPSGraph = ClientDiagSec:AddGraph({
    Title = "Client FPS Monitor",
    BarCount = 14,
    MaxValue = 120,
    Height = 110,
    BarColor = Color3.fromRGB(80, 160, 255),
    BarGlow = Color3.fromRGB(120, 200, 255),
    Unit = " fps"
})

local DiagPara = ClientDiagSec:AddParagraph({
    Title = "Engine Diagnostics",
    Content = "FPS: 60 | Ping: -- ms | Memory: -- MB | Uptime: 00:00:00",
    DefaultOpen = true
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 1: Mining & Ores
-- ──────────────────────────────────────────────────────────────────────────────────────
local MiningSec = MiningTab:AddSection("Ore Automation")

MiningSec:AddToggle({
    Name = "Auto Mine Ores",
    Default = false,
    Callback = function(v)
        Flags.AutoMine = v
        if v then Notify("Auto Mine Started", 2) end
    end
})

MiningSec:AddToggle({
    Name = "Mining Aura (Multi-Target)",
    Default = false,
    Callback = function(v)
        Flags.MiningAura = v
        if v then Notify("Mining Aura Enabled", 2) end
    end
})

MiningSec:AddSlider({
    Name = "Mining Aura Radius",
    Min = 10,
    Max = 60,
    Default = 30,
    Precision = 1,
    Callback = function(v)
        Flags.MiningAuraRadius = v
    end
})

MiningSec:AddSlider({
    Name = "Mining Swing Interval (s)",
    Min = 0.05,
    Max = 0.5,
    Default = 0.15,
    Precision = 2,
    Callback = function(v)
        Flags.MiningSpeedDelay = v
    end
})

MiningSec:AddDropdown({
    Name = "Target Ore Filter",
    Options = {
        "All Ores",
        "Heartgem Only",
        "Diamond+",
        "Ruby / Emerald+",
        "Gold+",
        "Iron+",
        "Coal Only"
    },
    Default = "All Ores",
    Callback = function(v)
        Flags.OreFilter = v
        Notify("Ore Filter: " .. tostring(v), 2)
    end
})

MiningSec:AddToggle({
    Name = "Auto Tween to Nearest Ore",
    Default = false,
    Callback = function(v)
        Flags.AutoTweenOre = v
    end
})

local ItemCollectorSec = MiningTab:AddSection("Auto Collect All Items & World Vacuum")

ItemCollectorSec:AddToggle({
    Name = "Auto Collect All Items",
    Default = false,
    Callback = function(v)
        Flags.AutoCollectItems = v
        if v then Notify("Item Collector Active", 2) end
    end
})

ItemCollectorSec:AddDropdown({
    Name = "Item Filter Category",
    Options = {
        "All Items",
        "Ores & Minerals",
        "Money & Sacks",
        "Fuel & Gas Cans",
        "Supply Crates & Chests",
        "Consumables & Medkits",
        "Weapons & Ammo",
        "Crafted Placeables",
        "Scrap & Materials"
    },
    Default = "All Items",
    Callback = function(v)
        Flags.ItemCollectFilter = v
    end
})

ItemCollectorSec:AddSlider({
    Name = "Collect Search Radius",
    Min = 15,
    Max = 200,
    Default = 60,
    Precision = 1,
    Callback = function(v)
        Flags.ItemCollectRadius = v
    end
})

ItemCollectorSec:AddSlider({
    Name = "Collection Speed Delay (s)",
    Min = 0.05,
    Max = 0.5,
    Default = 0.12,
    Precision = 2,
    Callback = function(v)
        Flags.ItemCollectDelay = v
    end
})

ItemCollectorSec:AddToggle({
    Name = "Vacuum Teleport Items to Player",
    Default = true,
    Callback = function(v)
        Flags.VacuumItemsToPlayer = v
    end
})

ItemCollectorSec:AddToggle({
    Name = "Auto Store in Sack / Bag",
    Default = true,
    Callback = function(v)
        Flags.AutoStoreInSack = v
    end
})

ItemCollectorSec:AddButton({
    Name = "Sweep & Collect All Items In Radius Now",
    Callback = function()
        pcall(function()
            local count = 0
            local itemsFolder = Workspace:FindFirstChild("Items")
            local list = {}
            if itemsFolder then
                for _, it in ipairs(itemsFolder:GetChildren()) do table.insert(list, it) end
            end
            for _, tag in ipairs({"Ore", "SupplyCrate", "GasCan", "Crate"}) do
                for _, obj in ipairs(CollectionService:GetTagged(tag)) do table.insert(list, obj) end
            end
            for _, item in ipairs(list) do
                if item:IsDescendantOf(Workspace) and Root then
                    local p = item:IsA("BasePart") and item.Position or item:GetPivot().Position
                    if (p - Root.Position).Magnitude <= (Flags.ItemCollectRadius or 60) then
                        if MatchesItemFilter(item) then
                            CollectItem(item)
                            count = count + 1
                        end
                    end
                end
            end
            Notify(string.format("Collected %d items in radius!", count), 2)
        end)
    end
})

local RockWallSec = MiningTab:AddSection("Wall & Scrap Utilities")

RockWallSec:AddToggle({
    Name = "Auto Drill Rock Walls",
    Default = false,
    Callback = function(v)
        Flags.InstantBreakWalls = v
        if v then Notify("Rock Wall Breaker Active", 2) end
    end
})

RockWallSec:AddToggle({
    Name = "Auto Scrap Shredder Collector",
    Default = false,
    Callback = function(v)
        Flags.AutoScrapCollector = v
        if v then Notify("Scrap Collector Active", 2) end
    end
})

RockWallSec:AddToggle({
    Name = "Ore Magnet (Vacuum Drops)",
    Default = false,
    Callback = function(v)
        Flags.OreMagnet = v
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 2: Drill & Engine
-- ──────────────────────────────────────────────────────────────────────────────────────
local DrillDriveSec = DrillTab:AddSection("Auto Drive & Vehicle Controls")

DrillDriveSec:AddToggle({
    Name = "Auto Drive Drill (Core Descent Mode)",
    Default = false,
    Callback = function(v)
        Flags.AutoDriveDrill = v
        if v then Notify("Auto Drive Engaged", 2) end
    end
})

DrillDriveSec:AddSlider({
    Name = "Target Drive Speed (studs/s)",
    Min = 20,
    Max = 120,
    Default = 55,
    Precision = 1,
    Callback = function(v)
        Flags.AutoDriveSpeed = v
    end
})

DrillDriveSec:AddToggle({
    Name = "Auto Sit in Driver Seat",
    Default = true,
    Callback = function(v)
        Flags.AutoSitDriver = v
    end
})

DrillDriveSec:AddToggle({
    Name = "Drill Anti-Stuck Auto-Unjam",
    Default = true,
    Callback = function(v)
        Flags.DrillAntiStuck = v
    end
})

DrillDriveSec:AddButton({
    Name = "Sit in Driver Seat Now",
    Callback = function()
        pcall(function()
            local drill = FindDrillModel()
            if drill and Humanoid then
                local seat = drill:FindFirstChild("DrillPhysicsSeat", true) or drill:FindFirstChildWhichIsA("VehicleSeat", true) or drill:FindFirstChildWhichIsA("Seat", true)
                if seat then
                    seat:Sit(Humanoid)
                    Notify("Seated in Driver Seat", 2)
                else
                    Notify("Driver seat not found on Drill", 2)
                end
            end
        end)
    end
})

DrillDriveSec:AddButton({
    Name = "Emergency Drill Unstuck / Downward Nudge",
    Callback = function()
        pcall(function()
            local drill = FindDrillModel()
            if drill then
                local prim = drill.PrimaryPart or drill:FindFirstChildWhichIsA("BasePart")
                if prim then
                    prim.AssemblyLinearVelocity = Vector3.new(0, -60, 0)
                end
                if TeleportManagerService and TeleportManagerService.VoteUnstuck then
                    TeleportManagerService:VoteUnstuck(true)
                end
                Notify("Drill Downward Nudge Applied", 2)
            end
        end)
    end
})

local DrillSec = DrillTab:AddSection("Drill Speed & Nitro")

DrillSec:AddToggle({
    Name = "Auto Drill Boost (Infinite Velocity)",
    Default = false,
    Callback = function(v)
        Flags.AutoDrillBoost = v
        if v then Notify("Drill Nitro Boost Active", 2) end
    end
})

DrillSec:AddSlider({
    Name = "Boost Activation Rate (s)",
    Min = 0.2,
    Max = 3.0,
    Default = 1.0,
    Precision = 1,
    Callback = function(v)
        Flags.DrillBoostInterval = v
    end
})

local DrillUpgSec = DrillTab:AddSection("Upgrades & Maintenance")

DrillUpgSec:AddToggle({
    Name = "Auto Buy Drill Upgrades",
    Default = false,
    Callback = function(v)
        Flags.AutoUpgradeDrill = v
        if v then Notify("Auto Upgrades Enabled", 2) end
    end
})

DrillUpgSec:AddDropdown({
    Name = "Upgrade Card Priority",
    Options = {
        "Drill Speed",
        "Drill Health & Shield",
        "Fuel Leech & Efficiency",
        "Cheapest Available"
    },
    Default = "Drill Speed",
    Callback = function(v)
        Flags.UpgradePriority = v
    end
})

DrillUpgSec:AddToggle({
    Name = "Auto Reroll Low Tier Offers",
    Default = false,
    Callback = function(v)
        Flags.AutoReroll = v
    end
})

DrillUpgSec:AddToggle({
    Name = "Auto Claim Class Boost Cards",
    Default = false,
    Callback = function(v)
        Flags.AutoClassRewards = v
    end
})

DrillUpgSec:AddToggle({
    Name = "Auto Repair Machine Stations",
    Default = false,
    Callback = function(v)
        Flags.AutoRepairScreens = v
    end
})

DrillUpgSec:AddToggle({
    Name = "Auto Defend Turrets (Sentry/Guard)",
    Default = false,
    Callback = function(v)
        Flags.AutoTurretDefense = v
    end
})

DrillUpgSec:AddToggle({
    Name = "Auto Vote Unstuck (Yes)",
    Default = true,
    Callback = function(v)
        Flags.AutoVoteUnstuck = v
    end
})

DrillUpgSec:AddButton({
    Name = "Trigger Unstuck Vote Now",
    Callback = function()
        if TeleportManagerService and TeleportManagerService.VoteUnstuck then
            pcall(function()
                TeleportManagerService:VoteUnstuck(true)
                Notify("Unstuck Vote Submitted", 2)
            end)
        end
    end
})

local DrillAdvancedSec = DrillTab:AddSection("Deep Mechanics & Crate Handling")

DrillAdvancedSec:AddToggle({
    Name = "Super Drag Reach (200 Studs Crate/Ore Grab)",
    Default = false,
    Callback = function(v)
        Flags.ExtendedDragReach = v
        if v then Notify("Super Drag Reach Enabled (200 Studs)", 2) end
    end
})

DrillAdvancedSec:AddButton({
    Name = "Instant Weld All Crates to Drill Hull",
    Callback = function()
        pcall(function()
            local dc = DragController or (Knit and Knit.GetController and Knit.GetController("DragController"))
            if dc and dc.Weld then
                dc:Weld()
                Notify("Weld Triggered on Held/Nearest Crate", 2)
            else
                Notify("DragController not ready", 2)
            end
        end)
    end
})

DrillAdvancedSec:AddToggle({
    Name = "Mute Cave & Vampire Ambience",
    Default = false,
    Callback = function(v)
        Flags.MuteAmbience = v
        pcall(function()
            local sc = Knit and Knit.GetController and Knit.GetController("SettingsController")
            if sc and sc.SetAmbienceSoundForcedMuted then
                sc:SetAmbienceSoundForcedMuted(v)
            end
        end)
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 3: Combat & Guns
-- ──────────────────────────────────────────────────────────────────────────────────────
local CombatSec = CombatTab:AddSection("Targeting & Weapons")

CombatSec:AddToggle({
    Name = "Silent Aim (Guns & Projectiles)",
    Default = false,
    Callback = function(v)
        Flags.SilentAim = v
        if v then Notify("Silent Aim Enabled", 2) end
    end
})

CombatSec:AddDropdown({
    Name = "Silent Aim Priority",
    Options = {
        "Nearest NPC",
        "Giant Worm Boss",
        "Fuel Leech Mobs",
        "Blinker Mobs",
        "Mimic Chests"
    },
    Default = "Nearest NPC",
    Callback = function(v)
        Flags.SilentAimTarget = v
    end
})

CombatSec:AddToggle({
    Name = "Melee Kill Aura (Swords/Tools)",
    Default = false,
    Callback = function(v)
        Flags.KillAura = v
        if v then Notify("Melee Kill Aura Active", 2) end
    end
})

CombatSec:AddSlider({
    Name = "Kill Aura Range",
    Min = 10,
    Max = 40,
    Default = 25,
    Precision = 1,
    Callback = function(v)
        Flags.KillAuraRange = v
    end
})

CombatSec:AddToggle({
    Name = "Auto Fast Reload",
    Default = false,
    Callback = function(v)
        Flags.AutoReload = v
    end
})

CombatSec:AddToggle({
    Name = "No Recoil & Zero Spread",
    Default = false,
    Callback = function(v)
        Flags.NoSpreadRecoil = v
    end
})

CombatSec:AddToggle({
    Name = "Champion Hammer Always Critical",
    Default = false,
    Callback = function(v)
        Flags.PerfectHammerCrit = v
    end
})

local BossSec = CombatTab:AddSection("Boss & Elite Farming")

BossSec:AddToggle({
    Name = "Giant Worm Boss Auto-Farm",
    Default = false,
    Callback = function(v)
        Flags.GiantWormFarm = v
        if v then Notify("Giant Worm Farming Active", 2) end
    end
})

BossSec:AddToggle({
    Name = "Auto Eliminate Mimic Chests",
    Default = false,
    Callback = function(v)
        Flags.MimicKiller = v
    end
})

local CombatSurvivalSec = CombatTab:AddSection("Elite Defense & Survival")

CombatSurvivalSec:AddToggle({
    Name = "Auto Kill Fuel Leeches (Save Drill Fuel)",
    Default = false,
    Callback = function(v)
        Flags.KillFuelLeeches = v
        if v then Notify("Fuel Leech Auto-Defense Active", 2) end
    end
})

CombatSurvivalSec:AddToggle({
    Name = "Auto Instant Revive (Death Screen Bypass)",
    Default = false,
    Callback = function(v)
        Flags.AutoRevive = v
        if v then Notify("Instant Revive Active", 2) end
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 4: Classes & Passives Injector (NEW DEEP GAME MODULE INTEGRATION)
-- ──────────────────────────────────────────────────────────────────────────────────────
local ClassSec = ClassesTab:AddSection("God Passives Modifier")

ClassSec:AddToggle({
    Name = "Inject God Mode Passives",
    Default = false,
    Callback = function(v)
        Flags.GodPassivesEnabled = v
        if v then
            pcall(function()
                LocalPlayer:SetAttribute("GunsPierceEnemies", true)
                LocalPlayer:SetAttribute("GunsPierceStoneEnemies", true)
                LocalPlayer:SetAttribute("DungeonLootHighlight", true)
                LocalPlayer:SetAttribute("NightVision", true)
                LocalPlayer:SetAttribute("PickaxeDamageMultiplier", 10)
                LocalPlayer:SetAttribute("CriticalPickaxeChance", 1.0)
                LocalPlayer:SetAttribute("CriticalPickaxeMultiplier", 10)
                LocalPlayer:SetAttribute("AmmoGrantMultiplier", 5)
            end)
            Notify("God Passives Injected!", 3)
        end
    end
})

ClassSec:AddToggle({
    Name = "Inject Team Multiplier Auras",
    Default = false,
    Callback = function(v)
        Flags.TeamBuffsEnabled = v
        if v then
            pcall(function()
                LocalPlayer:SetAttribute("ClassTeamSpeedMultiplier", 2.0)
                LocalPlayer:SetAttribute("ClassTeamHealthMultiplier", 3.0)
                LocalPlayer:SetAttribute("ClassTeamGunDamageMultiplier", 3.0)
                LocalPlayer:SetAttribute("ClassTeamFuelContributionMultiplier", 5.0)
                LocalPlayer:SetAttribute("ClassTeamPickaxeDamageMultiplier", 5.0)
                LocalPlayer:SetAttribute("ClassTeamGoldBarDropChance", 1.0)
                LocalPlayer:SetAttribute("ClassTeamIronBarDropChance", 1.0)
                LocalPlayer:SetAttribute("ClassTeamPristineGemChance", 1.0)
                LocalPlayer:SetAttribute("PriestBlessingGunDamageMultiplier", 3.0)
                LocalPlayer:SetAttribute("ExecutionerRunMaxHealthStacks", 50)
            end)
            Notify("Team Auras Injected!", 3)
        end
    end
})

local ClassPickerSec = ClassesTab:AddSection("Local Class Unlocker")

local selectedClass = "Miner"
ClassPickerSec:AddDropdown({
    Name = "Select Class to Spoof",
    Options = {
        "Miner",
        "Tank",
        "Gunslinger",
        "Scout",
        "Mechanic",
        "Crafter",
        "Salvager",
        "Driller",
        "Racer",
        "Witch",
        "Demolitionist",
        "Engineer",
        "Samurai",
        "Executioner",
        "Bounty Hunter",
        "Priest",
        "Goblin King"
    },
    Default = "Miner",
    Callback = function(v)
        selectedClass = v
    end
})

ClassPickerSec:AddButton({
    Name = "Apply Class Spoof Locally",
    Callback = function()
        pcall(function()
            LocalPlayer:SetAttribute("SelectedClass", selectedClass)
            LocalPlayer:SetAttribute("EquippedClass", selectedClass)
            Notify("Applied Class: " .. tostring(selectedClass), 2)
        end)
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 5: Crafting & Gas Fuel (NEW GAME MODULE INTEGRATION)
-- ──────────────────────────────────────────────────────────────────────────────────────
local FuelSec = CraftingTab:AddSection("Drill Fuel Automation")

FuelSec:AddToggle({
    Name = "Auto Contribute Gas Can Fuel",
    Default = false,
    Callback = function(v)
        Flags.AutoContributeFuel = v
        if v then Notify("Auto Fuel Contributor Active", 2) end
    end
})

FuelSec:AddButton({
    Name = "Contribute All Gas Cans Now",
    Callback = function()
        pcall(function()
            local drill = FindDrillModel()
            if not drill then
                Notify("Drill not located", 2, Color3.fromRGB(255, 60, 60))
                return
            end
            local fuelTouch = drill:FindFirstChild("FuelTouch", true) or drill
            for _, item in ipairs(Workspace:GetChildren()) do
                if item.Name == "GasCan" or item:GetAttribute("RealName") == "GasCan" then
                    if DragService and DragService.Request then
                        DragService:Request(item)
                        if DragService.Weld then DragService:Weld(item) end
                    end
                end
            end
            Notify("Contributed Gas Cans to Drill", 2)
        end)
    end
})

local AutoCraftSec = CraftingTab:AddSection("Crafting Catalog Utilities")

AutoCraftSec:AddDropdown({
    Name = "Ammo to Auto-Craft",
    Options = {
        "Pistol_Ammo",
        "Shotgun_Ammo",
        "Rifle_Ammo",
        "Special_Ammo"
    },
    Default = "Pistol_Ammo",
    Callback = function(v)
        Flags.CraftAmmoType = v
    end
})

AutoCraftSec:AddToggle({
    Name = "Auto Craft Ammo When Empty",
    Default = false,
    Callback = function(v)
        Flags.AutoCraftAmmo = v
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 6: Tactical & Special Weapons (NEW GAME MODULE INTEGRATION)
-- ──────────────────────────────────────────────────────────────────────────────────────
local TacSec = TacticalTab:AddSection("Special Super Weapons")

TacSec:AddToggle({
    Name = "Blackhole Vortex Aura Spammer",
    Default = false,
    Callback = function(v)
        Flags.BlackholeSpam = v
        if v then Notify("Blackhole Vortex Activated", 2) end
    end
})

TacSec:AddToggle({
    Name = "Goblin King Scepter Minion Spammer",
    Default = false,
    Callback = function(v)
        Flags.GoblinArmySpam = v
    end
})

TacSec:AddToggle({
    Name = "Anti-Turret Overheat (Zero Cooldown)",
    Default = false,
    Callback = function(v)
        Flags.AntiTurretOverheat = v
        if v then Notify("Turret Overheat Disabled", 2) end
    end
})

TacSec:AddToggle({
    Name = "Auto Deploy Decoys & Minefield",
    Default = false,
    Callback = function(v)
        Flags.AutoDeployDecoys = v
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 7: Dungeon & Secrets
-- ──────────────────────────────────────────────────────────────────────────────────────
local DungeonSec = DungeonTab:AddSection("Dungeon Exploration")

DungeonSec:AddToggle({
    Name = "Auto Unlock Dungeon Doors",
    Default = false,
    Callback = function(v)
        Flags.AutoUnlockDoors = v
        if v then Notify("Auto Door Unlocker Active", 2) end
    end
})

DungeonSec:AddToggle({
    Name = "Auto Loot Dungeon Chests",
    Default = false,
    Callback = function(v)
        Flags.AutoLootChests = v
        if v then Notify("Chest Looter Active", 2) end
    end
})

DungeonSec:AddToggle({
    Name = "Full Loot Highlighter (Always On)",
    Default = true,
    Callback = function(v)
        Flags.DungeonHighlightAlways = v
    end
})

DungeonSec:AddToggle({
    Name = "Auto Engage Dungeon Waves",
    Default = false,
    Callback = function(v)
        Flags.AutoTriggerWaves = v
    end
})

DungeonSec:AddToggle({
    Name = "Bypass One-Way Doors (Walk Through Barriers)",
    Default = false,
    Callback = function(v)
        Flags.BypassOneWayDoors = v
        pcall(function()
            for _, door in ipairs(CollectionService:GetTagged("OneWayDoor")) do
                if door:IsA("BasePart") then
                    door.CanCollide = not v
                    door.Transparency = v and 0.65 or 0
                end
            end
        end)
        if v then Notify("One-Way Barriers Disabled", 2) end
    end
})

DungeonSec:AddToggle({
    Name = "Auto Scan Dungeon Doors (Reveal Rooms)",
    Default = false,
    Callback = function(v)
        Flags.AutoScanDoors = v
        if v then Notify("Auto Scan Doors Active", 2) end
    end
})

local DungeonTPSSec = DungeonTab:AddSection("Dungeon Room Teleports")

DungeonTPSSec:AddButton({
    Name = "Teleport to Vampire Mansion",
    Callback = function()
        pcall(function()
            local mansion = Workspace:FindFirstChild("VampireMansion")
            if not mansion then
                local tagged = CollectionService:GetTagged("VampireMansion")
                if tagged and #tagged > 0 then mansion = tagged[1] end
            end
            if mansion and Root then
                local p = mansion:GetPivot()
                Root.CFrame = p + Vector3.new(0, 5, 0)
                Notify("Teleported to Vampire Mansion", 2)
            else
                Notify("Vampire Mansion not spawned in current zone", 2)
            end
        end)
    end
})

DungeonTPSSec:AddButton({
    Name = "Teleport to Spider Pit",
    Callback = function()
        pcall(function()
            local pit = Workspace:FindFirstChild("SpiderPit")
            if not pit then
                local tagged = CollectionService:GetTagged("SpiderPit")
                if tagged and #tagged > 0 then pit = tagged[1] end
            end
            if pit and Root then
                local p = pit:GetPivot()
                Root.CFrame = p + Vector3.new(0, 5, 0)
                Notify("Teleported to Spider Pit", 2)
            else
                Notify("Spider Pit not spawned in current zone", 2)
            end
        end)
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 8: Quests & Badges (NEW GAME MODULE INTEGRATION)
-- ──────────────────────────────────────────────────────────────────────────────────────
local QuestSec = QuestsTab:AddSection("Story & Side Quests")

QuestSec:AddToggle({
    Name = "Auto Track Story Milestones",
    Default = false,
    Callback = function(v)
        Flags.AutoCompleteQuests = v
    end
})

QuestSec:AddToggle({
    Name = "Auto Claim Achievement Badges",
    Default = false,
    Callback = function(v)
        Flags.AutoClaimAchievements = v
        if v and BadgeAwardingService and BadgeAwardingService.Award then
            pcall(function()
                BadgeAwardingService:Award("Excalibur")
                BadgeAwardingService:Award("SlickBrick")
                BadgeAwardingService:Award("ParticipationAward")
            end)
            Notify("Badges Checked & Claimed", 2)
        end
    end
})

QuestSec:AddButton({
    Name = "Trigger Depth Layer Milestones Now",
    Callback = function()
        pcall(function()
            local distance = math.floor(math.abs(Root and Root.Position.Y or 0))
            if UIController and UIController.UnlockLocation then
                UIController:UnlockLocation(GetCurrentDepthName(distance))
            end
            Notify("Milestone Broadcast Sent", 2)
        end)
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 9: Tools & Gear
-- ──────────────────────────────────────────────────────────────────────────────────────
local GearSec = ToolsTab:AddSection("Consumables & Survival")

GearSec:AddToggle({
    Name = "Auto Use Medkit (Emergency Heal)",
    Default = false,
    Callback = function(v)
        Flags.AutoHeal = v
    end
})

GearSec:AddSlider({
    Name = "Heal Trigger Health (%)",
    Min = 20,
    Max = 80,
    Default = 50,
    Precision = 1,
    Callback = function(v)
        Flags.HealThreshold = v
    end
})

GearSec:AddToggle({
    Name = "Auto Speed Potion (Permanent Buff)",
    Default = false,
    Callback = function(v)
        Flags.AutoSpeedPotion = v
    end
})

GearSec:AddToggle({
    Name = "Auto Drink All Available Potions",
    Default = false,
    Callback = function(v)
        Flags.AutoAllPotions = v
    end
})

GearSec:AddToggle({
    Name = "Instant Self Revive on Death",
    Default = false,
    Callback = function(v)
        Flags.InstantSelfRevive = v
        if v then Notify("Instant Revive Active", 2) end
    end
})

GearSec:AddToggle({
    Name = "Auto Save Gear on Depth Run",
    Default = false,
    Callback = function(v)
        Flags.AutoSaveGear = v
    end
})

GearSec:AddToggle({
    Name = "Auto Retrieve Death Chests",
    Default = false,
    Callback = function(v)
        Flags.AutoDeathChests = v
    end
})

local StorageSec = ToolsTab:AddSection("Crates & Storage")

StorageSec:AddToggle({
    Name = "Auto Drag & Weld Crates to Drill",
    Default = false,
    Callback = function(v)
        Flags.AutoDragWeldCrates = v
    end
})

StorageSec:AddButton({
    Name = "Save Gear to Server Now",
    Callback = function()
        if PlayerService and PlayerService.SaveGear then
            pcall(function()
                PlayerService:SaveGear()
                Notify("Gear Saved Successfully", 2)
            end)
        end
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 10: Player & Movement
-- ──────────────────────────────────────────────────────────────────────────────────────
local MoveSec = PlayerTab:AddSection("Movement Speed & Jump")

MoveSec:AddToggle({
    Name = "Enable Custom WalkSpeed",
    Default = false,
    Callback = function(v)
        Flags.WalkSpeedEnabled = v
        if not v and Humanoid then Humanoid.WalkSpeed = 16 end
    end
})

MoveSec:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 150,
    Default = 16,
    Precision = 1,
    Callback = function(v)
        Flags.WalkSpeedValue = v
    end
})

MoveSec:AddToggle({
    Name = "Enable Custom JumpPower",
    Default = false,
    Callback = function(v)
        Flags.JumpPowerEnabled = v
        if not v and Humanoid then Humanoid.JumpPower = 50 end
    end
})

MoveSec:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 250,
    Default = 50,
    Precision = 1,
    Callback = function(v)
        Flags.JumpPowerValue = v
    end
})

MoveSec:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(v)
        Flags.InfiniteJump = v
    end
})

local FlySec = PlayerTab:AddSection("Flight & Physics")

FlySec:AddToggle({
    Name = "Fly Mode (Smooth Mobile/PC)",
    Default = false,
    Callback = function(v)
        Flags.FlyEnabled = v
        if v then Notify("Fly Mode Enabled", 2) end
    end
})

FlySec:AddSlider({
    Name = "Fly Speed",
    Min = 20,
    Max = 200,
    Default = 50,
    Precision = 1,
    Callback = function(v)
        Flags.FlySpeed = v
    end
})

FlySec:AddToggle({
    Name = "Noclip (Walk Through Rocks/Walls)",
    Default = false,
    Callback = function(v)
        Flags.Noclip = v
    end
})

FlySec:AddToggle({
    Name = "Fullbright (Clear Cave Darkness)",
    Default = false,
    Callback = function(v)
        Flags.Fullbright = v
    end
})

FlySec:AddToggle({
    Name = "Anti-Void & Drill Tether Protection",
    Default = true,
    Callback = function(v)
        Flags.AntiVoid = v
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 11: ESP & Visuals
-- ──────────────────────────────────────────────────────────────────────────────────────
local EspSec = VisualsTab:AddSection("ESP Highlights")

EspSec:AddToggle({
    Name = "Ore ESP (Rarity Color Coded)",
    Default = false,
    Callback = function(v)
        Flags.OreESP = v
    end
})

EspSec:AddSlider({
    Name = "Ore ESP Max Distance (Studs)",
    Min = 100,
    Max = 1000,
    Default = 400,
    Precision = 10,
    Callback = function(v)
        Flags.OreESPMaxDist = v
    end
})

EspSec:AddToggle({
    Name = "Enemy & Boss ESP (Health/Box)",
    Default = false,
    Callback = function(v)
        Flags.NpcESP = v
    end
})

EspSec:AddToggle({
    Name = "Chest & Supply Crate ESP",
    Default = false,
    Callback = function(v)
        Flags.ChestESP = v
    end
})

EspSec:AddToggle({
    Name = "Teammate / Player ESP",
    Default = false,
    Callback = function(v)
        Flags.PlayerESP = v
    end
})

local HudSec = VisualsTab:AddSection("Drill HUD Tracker")

HudSec:AddToggle({
    Name = "Drill Depth & Velocity Tracker",
    Default = true,
    Callback = function(v)
        Flags.DrillTrackerHUD = v
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 12: Teleports & Depth
-- ──────────────────────────────────────────────────────────────────────────────────────
local TpSec = TeleportTab:AddSection("Core Locations")

TpSec:AddButton({
    Name = "Teleport to Drill Cab / Platform",
    Callback = function()
        local drill = FindDrillModel()
        if drill and Root then
            local pv = drill:GetPivot()
            Root.CFrame = pv * CFrame.new(0, 10, 0)
            Notify("Teleported to Drill", 2)
        else
            Notify("Drill not found!", 2, Color3.fromRGB(255, 60, 60))
        end
    end
})

TpSec:AddButton({
    Name = "Teleport to Surface / Lobby",
    Callback = function()
        if TeleportManagerService and TeleportManagerService.TeleportToLobby then
            pcall(function()
                TeleportManagerService:TeleportToLobby(true)
                Notify("Teleporting to Lobby...", 2)
            end)
        elseif Root then
            Root.CFrame = CFrame.new(0, 50, 0)
            Notify("Teleported to Surface", 2)
        end
    end
})

TpSec:AddButton({
    Name = "Teleport to Nearest High-Value Ore",
    Callback = function()
        if not Root then return end
        local bestOre = nil
        local bestTier = -1
        local closestDist = math.huge

        for _, ore in ipairs(CollectionService:GetTagged("Ore")) do
            if ore:IsDescendantOf(Workspace) then
                local _, _, tier = GetOreInfo(ore)
                local pos = ore:IsA("BasePart") and ore.Position or ore:GetPivot().Position
                local dist = (pos - Root.Position).Magnitude
                if tier > bestTier or (tier == bestTier and dist < closestDist) then
                    bestTier = tier
                    bestOre = ore
                    closestDist = dist
                end
            end
        end

        if bestOre then
            local pos = bestOre:IsA("BasePart") and bestOre.Position or bestOre:GetPivot().Position
            Root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 3), pos)
            Notify("Teleported to " .. bestOre.Name, 2)
        else
            Notify("No high-value ores found nearby", 2, Color3.fromRGB(255, 60, 60))
        end
    end
})

TpSec:AddButton({
    Name = "Teleport to Nearest Dungeon Door",
    Callback = function()
        if not Root then return end
        local closestDoor = nil
        local closestDist = math.huge

        for _, tag in ipairs({"DungeonDoor", "DungeonTreasureDoor", "DungeonArenaDoor"}) do
            for _, door in ipairs(CollectionService:GetTagged(tag)) do
                if door:IsDescendantOf(Workspace) then
                    local pos = door:IsA("BasePart") and door.Position or door:GetPivot().Position
                    local dist = (pos - Root.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestDoor = door
                    end
                end
            end
        end

        if closestDoor then
            local pos = closestDoor:IsA("BasePart") and closestDoor.Position or closestDoor:GetPivot().Position
            Root.CFrame = CFrame.new(pos + Vector3.new(0, 2, 4), pos)
            Notify("Teleported to Dungeon Door", 2)
        else
            Notify("No dungeon doors found nearby", 2, Color3.fromRGB(255, 60, 60))
        end
    end
})

local DepthSec = TeleportTab:AddSection("Depth Layer Presets")

local selectedDepth = "Layer 1: Dirt & Coal (250m)"
DepthSec:AddDropdown({
    Name = "Select Depth Layer",
    Options = {
        "Surface (0m)",
        "Layer 1: Dirt & Coal (250m)",
        "Layer 2: Iron Caverns (750m)",
        "Layer 3: Gemstone Cavern (1,500m)",
        "Layer 4: Toxic Zone (2,500m)",
        "Layer 5: Spider / Vampire Lair (4,000m)",
        "Layer 6: Magma Core (6,500m)",
        "Layer 7: The Underground Core (10,000m+)"
    },
    Default = "Layer 1: Dirt & Coal (250m)",
    Callback = function(v)
        selectedDepth = v
    end
})

DepthSec:AddButton({
    Name = "Teleport to Selected Depth",
    Callback = function()
        if not Root then return end
        local depthMap = {
            ["Surface (0m)"] = 10,
            ["Layer 1: Dirt & Coal (250m)"] = -250,
            ["Layer 2: Iron Caverns (750m)"] = -750,
            ["Layer 3: Gemstone Cavern (1,500m)"] = -1500,
            ["Layer 4: Toxic Zone (2,500m)"] = -2500,
            ["Layer 5: Spider / Vampire Lair (4,000m)"] = -4000,
            ["Layer 6: Magma Core (6,500m)"] = -6500,
            ["Layer 7: The Underground Core (10,000m+)"] = -10000
        }
        local y = depthMap[selectedDepth] or -250
        Root.CFrame = CFrame.new(Root.Position.X, y, Root.Position.Z)
        Notify("Teleported to " .. tostring(selectedDepth), 2)
    end
})

-- ──────────────────────────────────────────────────────────────────────────────────────
-- TAB 13: Settings & Info
-- ──────────────────────────────────────────────────────────────────────────────────────
local SetSec = SettingsTab:AddSection("Preferences & Keybinds")

SetSec:AddKeybind({
    Name = "Toggle Menu Visibility",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        if Window and Window.Toggle then
            Window:Toggle()
        end
    end
})

SetSec:AddButton({
    Name = "Unload PinatHub Completely",
    Callback = function()
        Flags.Unloaded = true
        if Window and Window.Destroy then
            pcall(function() Window:Destroy() end)
        end
        Notify("PinatHub Unloaded Cleanly", 3)
    end
})

local PerfSec = SettingsTab:AddSection("Performance & Lag Optimization")

PerfSec:AddToggle({
    Name = "Disable Heavy Mining Dust & Particle Lag",
    Default = false,
    Callback = function(v)
        Flags.DisableParticleLag = v
        if v then
            pcall(function()
                for _, emitter in ipairs(Workspace:GetDescendants()) do
                    if emitter:IsA("ParticleEmitter") or emitter:IsA("Smoke") or emitter:IsA("Fire") then
                        emitter.Enabled = false
                    end
                end
            end)
            Notify("Heavy Particle Emitters Disabled", 2)
        end
    end
})

local InfoSec = SettingsTab:AddSection("Information")
InfoSec:AddParagraph({
    Title = "PinatHub v3.5 (SharedPlanets Edition)",
    Content = "The most comprehensive suite for The Underground: Drill to the Core.\nIncludes Real-Time Telemetry Graphics, Knit Service Bypasses, God Passives, Tactical Weapons & Full Automation."
})


-- ── Automation Background Engines ─────────────────────────────────────────────────────

-- 1. Auto Mine & Mining Aura Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoMine or Flags.MiningAura then
            pcall(function()
                if not Root or not Character then return end

                local targets = {}
                local taggedOres = CollectionService:GetTagged("Ore")
                local maxDist = Flags.MiningAura and Flags.MiningAuraRadius or 20

                for _, ore in ipairs(taggedOres) do
                    if ore:IsDescendantOf(Workspace) then
                        local rarity = GetOreInfo(ore)
                        if MatchesOreFilter(rarity) then
                            local orePos = ore:IsA("BasePart") and ore.Position or ore:GetPivot().Position
                            local dist = (orePos - Root.Position).Magnitude
                            if dist <= maxDist then
                                table.insert(targets, ore)
                                if not Flags.MiningAura then
                                    break
                                end
                            end
                        end
                    end
                end

                if #targets > 0 then
                    -- Execute Pickaxe Swing against targeted ores
                    local tool = GetActiveTool()
                    if tool then
                        if type(tool) == "table" and tool.Execute then
                            tool.Execute:Fire({ "Swing", targets })
                        elseif type(tool) == "table" and tool.Swing then
                            tool:Swing()
                        elseif tool:IsA("Tool") then
                            tool:Activate()
                        end
                    end

                    -- Update Telemetry Stats for Mined Ores
                    for _, ore in ipairs(targets) do
                        local r = GetOreInfo(ore)
                        if Flags.SessionMined[r] then
                            Flags.SessionMined[r] = Flags.SessionMined[r] + 1
                            Flags.SessionMined.Total = Flags.SessionMined.Total + 1
                        end
                    end

                    -- Auto Tween to nearest ore if enabled
                    if Flags.AutoTweenOre and targets[1] then
                        local pos = targets[1]:IsA("BasePart") and targets[1].Position or targets[1]:GetPivot().Position
                        local targetCF = CFrame.new(pos + Vector3.new(0, 2, 3), pos)
                        Root.CFrame = Root.CFrame:Lerp(targetCF, 0.35)
                    end
                end
            end)
        end
        task.wait(Flags.MiningSpeedDelay or 0.15)
    end
end)

-- 2. Rock Wall Breaker Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.InstantBreakWalls then
            pcall(function()
                if not Root then return end
                local walls = CollectionService:GetTagged("RockWall")
                local nearbyWalls = {}

                for _, wall in ipairs(walls) do
                    if wall:IsDescendantOf(Workspace) then
                        local pos = wall:IsA("BasePart") and wall.Position or wall:GetPivot().Position
                        if (pos - Root.Position).Magnitude <= 25 then
                            table.insert(nearbyWalls, wall)
                        end
                    end
                end

                if #nearbyWalls > 0 then
                    ExecuteToolAction("Swing", nearbyWalls)
                end
            end)
        end
        task.wait(0.2)
    end
end)

-- 3. Auto Drill Nitro Boost Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoDrillBoost then
            pcall(function()
                local tool = GetActiveTool()
                if tool and (type(tool) == "table" or tool:IsA("Tool")) then
                    ExecuteToolAction("Use")
                end
            end)
        end
        task.wait(Flags.DrillBoostInterval or 1.0)
    end
end)

-- 4. Auto Drill Upgrades & Card Management
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoUpgradeDrill and DrillService then
            pcall(function()
                if DrillService.FetchOptions then
                    local options, version = DrillService:FetchOptions()
                    if type(options) == "table" and #options > 0 then
                        local bestOption = options[1]
                        for _, opt in ipairs(options) do
                            local name = tostring(opt.Name or opt.UpgradeName or ""):lower()
                            if Flags.UpgradePriority == "Drill Speed" and name:find("speed") then
                                bestOption = opt
                                break
                            elseif Flags.UpgradePriority == "Drill Health & Shield" and (name:find("health") or name:find("shield") or name:find("armor")) then
                                bestOption = opt
                                break
                            elseif Flags.UpgradePriority == "Fuel Leech & Efficiency" and (name:find("fuel") or name:find("leech")) then
                                bestOption = opt
                                break
                            end
                        end

                        if Flags.AutoReroll and DrillService.Reroll then
                            local rarity = tostring(bestOption.Rarity or "Common")
                            if rarity == "Common" or (rarity == "Uncommon" and Flags.RerollThreshold == "Rare") then
                                DrillService:Reroll(version)
                                task.wait(0.5)
                                return
                            end
                        end

                        if DrillService.UpgradeDrill and bestOption then
                            local upgName = bestOption.Name or bestOption.UpgradeName
                            if upgName then
                                DrillService:UpgradeDrill(upgName, version)
                            end
                        end
                    end
                end

                if Flags.AutoClassRewards and DrillService and DrillService.ChooseClassReward then
                    pcall(function()
                        DrillService:ChooseClassReward(1, "Boost")
                    end)
                end
            end)
        end
        task.wait(2.5)
    end
end)

-- 5. Auto Unstuck & Defense Turret Monitor
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoVoteUnstuck and TeleportManagerService and TeleportManagerService.VoteUnstuck then
            pcall(function()
                TeleportManagerService:VoteUnstuck(true)
            end)
        end

        if Flags.AutoTurretDefense and BulletService then
            pcall(function()
                local npcs = Workspace:FindFirstChild("Npc")
                if npcs and #npcs:GetChildren() > 0 then
                    local targetNpc = npcs:GetChildren()[1]
                    local tPart = targetNpc:FindFirstChild("HumanoidRootPart") or targetNpc.PrimaryPart
                    if tPart and Root then
                        local dist = (tPart.Position - Root.Position).Magnitude
                        if dist <= 80 then
                            ExecuteToolAction("Shoot", tPart, false, Root.Position, tPart.Position, dist)
                        end
                    end
                end
            end)
        end
        task.wait(1.5)
    end
end)

-- 6. Combat Kill Aura & Silent Aim Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.KillAura or Flags.GiantWormFarm or Flags.MimicKiller then
            pcall(function()
                if not Root then return end
                local npcs = Workspace:FindFirstChild("Npc")
                local hitTargets = {}

                if npcs then
                    for _, npc in ipairs(npcs:GetChildren()) do
                        if npc:IsA("Model") then
                            local h = npc:FindFirstChildOfClass("Humanoid")
                            local part = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
                            local isWorm = CollectionService:HasTag(npc, "Worm") or npc.Name:lower():find("worm")
                            local isMimic = npc.Name:lower():find("mimic")

                            if (not h or h.Health > 0) and part then
                                local dist = (part.Position - Root.Position).Magnitude

                                if Flags.GiantWormFarm and isWorm and dist <= 50 then
                                    table.insert(hitTargets, npc)
                                elseif Flags.MimicKiller and isMimic and dist <= 30 then
                                    table.insert(hitTargets, npc)
                                elseif Flags.KillAura and dist <= (Flags.KillAuraRange or 25) then
                                    table.insert(hitTargets, npc)
                                end
                            end
                        end
                    end
                end

                if Flags.GiantWormFarm and #hitTargets == 0 then
                    for _, w in ipairs(CollectionService:GetTagged("Worm")) do
                        if w:IsDescendantOf(Workspace) then
                            local wp = w:IsA("BasePart") and w or w:FindFirstChild("HumanoidRootPart") or w.PrimaryPart
                            if wp and (wp.Position - Root.Position).Magnitude <= 50 then
                                table.insert(hitTargets, w)
                            end
                        end
                    end
                end

                if #hitTargets > 0 then
                    ExecuteToolAction("Swing", hitTargets)
                end
            end)
        end
        task.wait(0.12)
    end
end)

-- 7. Auto Fast Reload Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoReload then
            pcall(function()
                local tool = GetActiveTool()
                if tool and type(tool) == "table" and tool.DisplayTool then
                    local ammo = tool.DisplayTool:GetAttribute("Ammo") or 0
                    if ammo <= 0 then
                        ExecuteToolAction("Reload")
                    end
                end
            end)
        end
        task.wait(0.25)
    end
end)

-- 8. Dungeon Doors & Chest Loot Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoUnlockDoors and InteractionService then
            pcall(function()
                for _, tag in ipairs({"DungeonDoor", "DungeonTreasureDoor", "DungeonArenaDoor", "OneWayDoor"}) do
                    for _, door in ipairs(CollectionService:GetTagged(tag)) do
                        if door:IsDescendantOf(Workspace) and Root then
                            local pos = door:IsA("BasePart") and door.Position or door:GetPivot().Position
                            if (pos - Root.Position).Magnitude <= 30 then
                                InteractionService:Interact(door)
                            end
                        end
                    end
                end
            end)
        end

        if Flags.AutoLootChests and InteractionService then
            pcall(function()
                for _, chest in ipairs(CollectionService:GetTagged("DungeonLootHighlightTarget")) do
                    if chest:IsDescendantOf(Workspace) and Root then
                        local pos = chest:IsA("BasePart") and chest.Position or chest:GetPivot().Position
                        if (pos - Root.Position).Magnitude <= 25 then
                            InteractionService:Interact(chest)
                        end
                    end
                end
                for _, crate in ipairs(CollectionService:GetTagged("SupplyCrate")) do
                    if crate:IsDescendantOf(Workspace) and Root then
                        local pos = crate:IsA("BasePart") and crate.Position or crate:GetPivot().Position
                        if (pos - Root.Position).Magnitude <= 20 then
                            InteractionService:Interact(crate)
                        end
                    end
                end
            end)
        end
        task.wait(0.4)
    end
end)

-- 9. Auto Heal, Speed Potion & Survival Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoHeal and Humanoid and Humanoid.Health > 0 then
            pcall(function()
                local hpPct = (Humanoid.Health / Humanoid.MaxHealth) * 100
                if hpPct <= (Flags.HealThreshold or 50) then
                    ExecuteToolAction("Consume")
                end
            end)
        end

        if Flags.AutoSpeedPotion or Flags.AutoAllPotions then
            pcall(function()
                ExecuteToolAction("Consume")
            end)
        end

        if Flags.AutoSaveGear and PlayerService and PlayerService.SaveGear then
            pcall(function()
                PlayerService:SaveGear()
            end)
        end

        if Flags.AutoDeathChests and CrateController and CrateController.OpenDeathChest then
            pcall(function()
                for _, crate in ipairs(CollectionService:GetTagged("SupplyCrate")) do
                    if crate:GetAttribute("DeathChest") == true and Root then
                        local pos = crate:IsA("BasePart") and crate.Position or crate:GetPivot().Position
                        if (pos - Root.Position).Magnitude <= 25 then
                            CrateController:OpenDeathChest(crate)
                        end
                    end
                end
            end)
        end

        task.wait(1.5)
    end
end)

-- 10. Tactical Super Weapons Engine (Blackhole, Goblin Minions, Turret Overheat)
task.spawn(function()
    while not Flags.Unloaded do
        -- Blackhole Spammer
        if Flags.BlackholeSpam and Root then
            pcall(function()
                local npcs = Workspace:FindFirstChild("Npc")
                if npcs and #npcs:GetChildren() > 0 then
                    local target = npcs:GetChildren()[1]
                    local tPos = target:GetPivot().Position
                    ExecuteToolAction("Shoot", target, false, Root.Position, tPos, 50)
                end
            end)
        end

        -- Goblin King Scepter Spammer
        if Flags.GoblinArmySpam then
            pcall(function()
                ExecuteToolAction("Use")
                ExecuteToolAction("Swing", {})
            end)
        end

        -- Anti Turret Overheat
        if Flags.AntiTurretOverheat then
            pcall(function()
                for _, turret in ipairs(CollectionService:GetTagged("GuardTurret")) do
                    turret:SetAttribute("Overheated", false)
                    turret:SetAttribute("Heat", 0)
                end
                for _, sentry in ipairs(CollectionService:GetTagged("SentryTurret")) do
                    sentry:SetAttribute("Overheated", false)
                    sentry:SetAttribute("Heat", 0)
                end
            end)
        end

        task.wait(0.3)
    end
end)

-- 10.1 Auto Drive Drill Engine
task.spawn(function()
    local lastY = 0
    local stuckTicks = 0

    while not Flags.Unloaded do
        if Flags.AutoDriveDrill then
            pcall(function()
                local drill = FindDrillModel()
                if drill and Character and Humanoid and Root then
                    local seat = drill:FindFirstChild("DrillPhysicsSeat", true) or drill:FindFirstChildWhichIsA("VehicleSeat", true) or drill:FindFirstChildWhichIsA("Seat", true)

                    -- Auto Sit in driver seat
                    if seat and Humanoid.SeatPart ~= seat and Flags.AutoSitDriver then
                        seat:Sit(Humanoid)
                    end

                    -- Throttle vehicle forward
                    if seat and seat:IsA("VehicleSeat") then
                        seat.Throttle = 1
                    end

                    -- Apply physical downward velocity propulsion
                    local primary = drill.PrimaryPart or drill:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        local curY = primary.Position.Y
                        local vel = primary.AssemblyLinearVelocity
                        local targetSpd = Flags.AutoDriveSpeed or 55

                        if vel.Y > -targetSpd then
                            primary.AssemblyLinearVelocity = Vector3.new(vel.X * 0.7, -targetSpd, vel.Z * 0.7)
                        end

                        -- Anti-stuck detection
                        if Flags.DrillAntiStuck then
                            if math.abs(curY - lastY) < 1.0 then
                                stuckTicks = stuckTicks + 1
                                if stuckTicks >= 3 then
                                    primary.AssemblyLinearVelocity = Vector3.new(0, -targetSpd * 1.5, 0)
                                    if TeleportManagerService and TeleportManagerService.VoteUnstuck then
                                        TeleportManagerService:VoteUnstuck(true)
                                    end
                                    stuckTicks = 0
                                end
                            else
                                stuckTicks = 0
                            end
                            lastY = curY
                        end
                    end

                    -- Auto trigger boost / nitro
                    ExecuteToolAction("Use")

                    -- Auto clear rock walls in drill path
                    local walls = CollectionService:GetTagged("RockWall")
                    local nearbyWalls = {}
                    local drillPos = drill:GetPivot().Position
                    for _, wall in ipairs(walls) do
                        if wall:IsDescendantOf(Workspace) then
                            local wp = wall:IsA("BasePart") and wall.Position or wall:GetPivot().Position
                            if (wp - drillPos).Magnitude <= 40 then
                                table.insert(nearbyWalls, wall)
                            end
                        end
                    end
                    if #nearbyWalls > 0 then
                        ExecuteToolAction("Swing", nearbyWalls)
                    end
                end
            end)
        end
        task.wait(0.3)
    end
end)

-- 10.2 Auto Collect All Items Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoCollectItems and Root then
            pcall(function()
                local itemsFolder = Workspace:FindFirstChild("Items")
                local candidates = {}

                if itemsFolder then
                    for _, it in ipairs(itemsFolder:GetChildren()) do
                        table.insert(candidates, it)
                    end
                end

                for _, tag in ipairs({"Ore", "SupplyCrate", "GasCan", "Crate"}) do
                    for _, it in ipairs(CollectionService:GetTagged(tag)) do
                        if it:IsDescendantOf(Workspace) then
                            table.insert(candidates, it)
                        end
                    end
                end

                local radius = Flags.ItemCollectRadius or 60
                for _, item in ipairs(candidates) do
                    if not Flags.AutoCollectItems then break end
                    if item:IsDescendantOf(Workspace) and item ~= Character and not item:IsDescendantOf(Character) then
                        local p = item:IsA("BasePart") and item.Position or item:GetPivot().Position
                        if (p - Root.Position).Magnitude <= radius then
                            if MatchesItemFilter(item) then
                                CollectItem(item)
                                task.wait(0.02)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(Flags.ItemCollectDelay or 0.12)
    end
end)

-- 10.3 Performance Particle Lag Reducer Engine
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.DisableParticleLag then
            pcall(function()
                for _, emitter in ipairs(Workspace:GetDescendants()) do
                    if emitter:IsA("ParticleEmitter") or emitter:IsA("Smoke") or emitter:IsA("Fire") then
                        emitter.Enabled = false
                    end
                end
            end)
        end
        task.wait(3.0)
    end
end)

-- 10.5 Deep Mechanics Automation Engines (FuelLeech, Doors, Drag Reach, Screen Repair)
task.spawn(function()
    while not Flags.Unloaded do
        -- Kill Fuel Leeches attacking Drill
        if Flags.KillFuelLeeches and Root then
            pcall(function()
                local leechTargets = {}
                for _, tag in ipairs({"FuelLeech", "VoidFuelLeech", "MagmaFuelLeech"}) do
                    for _, leech in ipairs(CollectionService:GetTagged(tag)) do
                        if leech:IsDescendantOf(Workspace) then
                            local p = leech:IsA("BasePart") and leech.Position or leech:GetPivot().Position
                            if (p - Root.Position).Magnitude <= 35 then
                                table.insert(leechTargets, leech)
                            end
                        end
                    end
                end
                if #leechTargets > 0 then
                    ExecuteToolAction("Swing", leechTargets)
                end
            end)
        end

        -- Bypass OneWayDoor barriers
        if Flags.BypassOneWayDoors then
            pcall(function()
                for _, door in ipairs(CollectionService:GetTagged("OneWayDoor")) do
                    if door:IsA("BasePart") and door.CanCollide then
                        door.CanCollide = false
                        door.Transparency = 0.65
                    end
                end
            end)
        end

        -- Auto Scan Dungeon Doors
        if Flags.AutoScanDoors and ResourceScannerService and ResourceScannerService.ScanDoor then
            pcall(function()
                ResourceScannerService:ScanDoor()
            end)
        end

        -- Auto Repair Drill Screens
        if Flags.AutoRepairScreens then
            pcall(function()
                local dsc = DrillSyncController or (Knit and Knit.GetController and Knit.GetController("DrillSyncController"))
                if dsc and dsc.SetScreenRepaired then
                    dsc:SetScreenRepaired(true)
                end
            end)
        end

        -- Super Drag Reach (Hook DragRange)
        if Flags.ExtendedDragReach then
            pcall(function()
                local dc = DragController or (Knit and Knit.GetController and Knit.GetController("DragController"))
                if dc then
                    dc.GetDragRange = function()
                        return Flags.ExtendedDragReach and 200 or 16
                    end
                end
            end)
        end

        task.wait(0.5)
    end
end)

-- 11. Instant Self Revive Handler
if LocalPlayer then
    local function bindRevive(char)
        local hum = char and char:WaitForChild("Humanoid", 5)
        if hum then
            hum.Died:Connect(function()
                if (Flags.InstantSelfRevive or Flags.AutoRevive) then
                    task.wait(0.2)
                    pcall(function()
                        local dsc = Knit and Knit.GetController and Knit.GetController("DeathScreenController")
                        if dsc and dsc.RequestRevive then
                            dsc:RequestRevive()
                        elseif PlayerService and PlayerService.SelfRevive then
                            PlayerService:SelfRevive()
                        elseif PlayerService and PlayerService.CanUseTutorialFreeRevive then
                            PlayerService:CanUseTutorialFreeRevive()
                        end
                        Notify("Self Revive Triggered!", 2)
                    end)
                end
            end)
        end
    end
    if LocalPlayer.Character then bindRevive(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(bindRevive)
end

-- 12. Player Movement Modifications (WalkSpeed, JumpPower, Fly, Noclip)
RunService.Stepped:Connect(function()
    if Flags.Unloaded then return end

    if Flags.Noclip and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    if Humanoid then
        if Flags.WalkSpeedEnabled and Humanoid.WalkSpeed ~= Flags.WalkSpeedValue then
            Humanoid.WalkSpeed = Flags.WalkSpeedValue
        end
        if Flags.JumpPowerEnabled and Humanoid.JumpPower ~= Flags.JumpPowerValue then
            Humanoid.JumpPower = Flags.JumpPowerValue
        end
    end

    if Flags.AntiVoid and Root then
        if Root.Position.Y < -15000 then
            local drill = FindDrillModel()
            if drill then
                Root.CFrame = drill:GetPivot() * CFrame.new(0, 10, 0)
                Root.AssemblyLinearVelocity = Vector3.zero
                Notify("Rescued from Void!", 2)
            else
                Root.CFrame = CFrame.new(0, 50, 0)
                Root.AssemblyLinearVelocity = Vector3.zero
            end
        end
    end
end)

-- Infinite Jump Listener
UserInputService.JumpRequest:Connect(function()
    if Flags.InfiniteJump and Humanoid and not Flags.Unloaded then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Fullbright Engine
task.spawn(function()
    local origAmbient = Lighting.Ambient
    local origBrightness = Lighting.Brightness
    local origFogEnd = Lighting.FogEnd

    while not Flags.Unloaded do
        if Flags.Fullbright then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 3
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        end
        task.wait(1.0)
    end

    Lighting.Ambient = origAmbient
    Lighting.Brightness = origBrightness
    Lighting.FogEnd = origFogEnd
    Lighting.GlobalShadows = true
end)


-- ── ESP Visuals System & Real-Time Telemetry HUD ───────────────────────────────────────
local EspFolder = Instance.new("Folder")
EspFolder.Name = "PinatHub_SharedPlanets_ESP"
EspFolder.Parent = Workspace

local ActiveESPs = {}

local function CreateESP(adornee, text, color, offset)
    if not adornee or ActiveESPs[adornee] then return end
    offset = offset or Vector3.new(0, 2.5, 0)

    local bb = Instance.new("BillboardGui")
    bb.Name = "PinatESP"
    bb.Adornee = adornee
    bb.Size = UDim2.new(0, 140, 0, 36)
    bb.StudsOffset = offset
    bb.AlwaysOnTop = true
    bb.Parent = EspFolder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Text = text or ""
    label.Parent = bb

    local hl = Instance.new("Highlight")
    hl.Name = "PinatHighlight"
    hl.Adornee = adornee
    hl.FillColor = color or Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.75
    hl.OutlineColor = color or Color3.fromRGB(255, 255, 255)
    hl.OutlineTransparency = 0.2
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = bb

    ActiveESPs[adornee] = { Gui = bb, Label = label, Highlight = hl }
end

local function ClearESP(adornee)
    if ActiveESPs[adornee] then
        if ActiveESPs[adornee].Gui then ActiveESPs[adornee].Gui:Destroy() end
        ActiveESPs[adornee] = nil
    end
end

-- ESP Heartbeat Refresh Loop
RunService.Heartbeat:Connect(function()
    if Flags.Unloaded then
        for adornee, _ in pairs(ActiveESPs) do ClearESP(adornee) end
        return
    end

    if not Root then return end

    -- 1. Ore ESP
    if Flags.OreESP then
        local ores = CollectionService:GetTagged("Ore")
        local maxDist = Flags.OreESPMaxDist or 400

        for _, ore in ipairs(ores) do
            if ore:IsDescendantOf(Workspace) then
                local pos = ore:IsA("BasePart") and ore.Position or ore:GetPivot().Position
                local dist = math.floor((pos - Root.Position).Magnitude)

                if dist <= maxDist then
                    local rarity, color = GetOreInfo(ore)
                    local hp = ore:FindFirstChild("Health") and ore.Health.Value or "Ore"
                    local text = string.format("[%s]\n%s HP | %dm", rarity, tostring(hp), dist)

                    if not ActiveESPs[ore] then
                        CreateESP(ore, text, color)
                    else
                        ActiveESPs[ore].Label.Text = text
                    end
                else
                    ClearESP(ore)
                end
            else
                ClearESP(ore)
            end
        end
    else
        for _, ore in ipairs(CollectionService:GetTagged("Ore")) do
            if ActiveESPs[ore] then ClearESP(ore) end
        end
    end

    -- 2. NPC & Boss ESP
    if Flags.NpcESP then
        local npcs = Workspace:FindFirstChild("Npc")
        if npcs then
            for _, npc in ipairs(npcs:GetChildren()) do
                if npc:IsA("Model") and npc:IsDescendantOf(Workspace) then
                    local hum = npc:FindFirstChildOfClass("Humanoid")
                    local root = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart

                    if root and (not hum or hum.Health > 0) then
                        local dist = math.floor((root.Position - Root.Position).Magnitude)
                        local hpText = hum and string.format("%d/%d HP", math.floor(hum.Health), math.floor(hum.MaxHealth)) or "Enemy"
                        local name = npc.Name
                        local text = string.format("[NPC: %s]\n%s | %dm", name, hpText, dist)

                        local isWorm = CollectionService:HasTag(npc, "Worm") or name:lower():find("worm")
                        local color = isWorm and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(255, 120, 40)

                        if not ActiveESPs[npc] then
                            CreateESP(npc, text, color, Vector3.new(0, 3.5, 0))
                        else
                            ActiveESPs[npc].Label.Text = text
                        end
                    else
                        ClearESP(npc)
                    end
                end
            end
        end
    end

    -- 3. Chest & Supply Crate ESP
    if Flags.ChestESP then
        for _, chest in ipairs(CollectionService:GetTagged("DungeonLootHighlightTarget")) do
            if chest:IsDescendantOf(Workspace) then
                local pos = chest:IsA("BasePart") and chest.Position or chest:GetPivot().Position
                local dist = math.floor((pos - Root.Position).Magnitude)
                local text = string.format("[Treasure Chest]\n%dm", dist)

                if not ActiveESPs[chest] then
                    CreateESP(chest, text, Color3.fromRGB(255, 215, 0))
                else
                    ActiveESPs[chest].Label.Text = text
                end
            else
                ClearESP(chest)
            end
        end
        for _, crate in ipairs(CollectionService:GetTagged("SupplyCrate")) do
            if crate:IsDescendantOf(Workspace) then
                local pos = crate:IsA("BasePart") and crate.Position or crate:GetPivot().Position
                local dist = math.floor((pos - Root.Position).Magnitude)
                local isDeath = crate:GetAttribute("DeathChest") == true
                local text = isDeath and string.format("[Death Chest]\n%dm", dist) or string.format("[Supply Crate]\n%dm", dist)
                local color = isDeath and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(70, 180, 255)

                if not ActiveESPs[crate] then
                    CreateESP(crate, text, color)
                else
                    ActiveESPs[crate].Label.Text = text
                end
            else
                ClearESP(crate)
            end
        end
    end
end)

-- ── Drill Tracker Real-Time HUD & Live Telemetry Graphics ─────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PinatHub_DrillTracker"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local HudFrame = Instance.new("Frame")
HudFrame.Name = "TrackerCard"
HudFrame.Size = UDim2.new(0, 220, 0, 80)
HudFrame.Position = UDim2.new(0.015, 0, 0.45, 0)
HudFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
HudFrame.BackgroundTransparency = 0.25
HudFrame.BorderSizePixel = 0
HudFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", HudFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke", HudFrame)
UIStroke.Color = Color3.fromRGB(0, 255, 170)
UIStroke.Thickness = 1.2

local TitleLabel = Instance.new("TextLabel", HudFrame)
TitleLabel.Size = UDim2.new(1, -12, 0, 20)
TitleLabel.Position = UDim2.new(0, 6, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "PINATHUB - LIVE TELEMETRY"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
TitleLabel.TextSize = 11
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local DepthLabel = Instance.new("TextLabel", HudFrame)
DepthLabel.Size = UDim2.new(1, -12, 0, 18)
DepthLabel.Position = UDim2.new(0, 6, 0, 26)
DepthLabel.BackgroundTransparency = 1
DepthLabel.Font = Enum.Font.GothamMedium
DepthLabel.Text = "Depth: Calculating..."
DepthLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
DepthLabel.TextSize = 11
DepthLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedLabel = Instance.new("TextLabel", HudFrame)
SpeedLabel.Size = UDim2.new(1, -12, 0, 18)
SpeedLabel.Position = UDim2.new(0, 6, 0, 46)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.Text = "Velocity: Syncing..."
SpeedLabel.TextColor3 = Color3.fromRGB(170, 180, 200)
SpeedLabel.TextSize = 11
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Live Telemetry Graphics Engine (Updates both UI Tab and On-Screen HUD)
task.spawn(function()
    local lastFpsTime = os.clock()
    local frameCount = 0
    local currentFps = 60

    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = os.clock()
        if now - lastFpsTime >= 1.0 then
            currentFps = frameCount
            frameCount = 0
            lastFpsTime = now
        end
    end)

    while not Flags.Unloaded do
        pcall(function()
            local drill = FindDrillModel()
            local yPos = Root and Root.Position.Y or 0
            local speedVal = 0

            if drill then
                local pv = drill:GetPivot()
                yPos = pv.Position.Y
                local prim = drill.PrimaryPart or drill:FindFirstChildWhichIsA("BasePart")
                if prim then
                    speedVal = math.floor(prim.AssemblyLinearVelocity.Magnitude)
                end
            end

            local depthMeters = math.floor(math.abs(yPos))
            local layerName = GetCurrentDepthName(depthMeters)

            -- Update HUD
            if Flags.DrillTrackerHUD then
                HudFrame.Visible = true
                DepthLabel.Text = string.format("Depth: -%dm (%s)", depthMeters, layerName)
                SpeedLabel.Text = string.format("Drill Speed: %d studs/s", speedVal)
            else
                HudFrame.Visible = false
            end

            -- Update Native Animated Progress Bar & Bar Charts
            if DepthProgressBar and DepthProgressBar.Set then
                DepthProgressBar:Set(depthMeters, 10000)
            end
            if DrillSpeedGraph and DrillSpeedGraph.Push then
                DrillSpeedGraph:Push(speedVal)
            end
            if FPSGraph and FPSGraph.Push then
                FPSGraph:Push(currentFps)
            end

            -- Update Analytics Tab Visual Graphs
            if DepthProgressPara and DepthProgressPara.SetDesc then
                local pct = math.clamp(depthMeters / 10000, 0, 1)
                local barLen = 16
                local filled = math.floor(pct * barLen)
                local barStr = string.rep("█", filled) .. string.rep("░", barLen - filled)
                local depthGraphText = string.format("[%s] %.1f%%\nCurrent Depth: -%dm\nBiome Layer: %s", barStr, pct * 100, depthMeters, layerName)
                DepthProgressPara:SetDesc(depthGraphText)
            end

            if VelocityGaugePara and VelocityGaugePara.SetDesc then
                local speedPct = math.clamp(speedVal / 80, 0, 1)
                local speedBarLen = 14
                local filledSpd = math.floor(speedPct * speedBarLen)
                local speedBar = string.rep("■", filledSpd) .. string.rep("□", speedBarLen - filledSpd)
                local gaugeText = string.format("[%s] %d studs/s\nMotor Status: %s", speedBar, speedVal, speedVal > 0 and "Tunneling Active" or "Engine Idle")
                VelocityGaugePara:SetDesc(gaugeText)
            end

            if OresCounterPara and OresCounterPara.SetDesc then
                local sm = Flags.SessionMined
                local oresText = string.format("Total Mined: %d Ores\nCoal: %d | Iron: %d | Gold: %d\nEmerald: %d | Ruby: %d | Diamond: %d\nHeartgems: %d",
                    sm.Total, sm.Coal, sm.Iron, sm.Gold, sm.Emerald, sm.Ruby, sm.Diamond, sm.Heartgem)
                OresCounterPara:SetDesc(oresText)
            end

            if EconomyPara and EconomyPara.SetDesc then
                local cores = LocalPlayer:GetAttribute("Cores") or 0
                local coins = 0
                if CurrencyService and CurrencyService.GetCurrency then
                    coins = CurrencyService:GetCurrency() or 0
                end
                local medals = LocalPlayer:GetAttribute("LarryMedals") or 0
                local econText = string.format("Cores: %s | Coins: %s\nLarry Medals: %s", tostring(cores), tostring(coins), tostring(medals))
                EconomyPara:SetDesc(econText)
            end

            if RadarPara and RadarPara.SetDesc then
                local npcs = Workspace:FindFirstChild("Npc")
                local npcCount = npcs and #npcs:GetChildren() or 0
                local worms = CollectionService:GetTagged("Worm")
                local wormStatus = #worms > 0 and "WARNING: Giant Worm Detected!" or "Clear"
                local inDung = LocalPlayer:GetAttribute("InDungeon") == true
                local radarText = string.format("Hostiles Nearby: %d\nWorm Boss Status: %s\nDungeon Zone: %s", npcCount, wormStatus, inDung and "Inside Dungeon" or "Tunnels")
                RadarPara:SetDesc(radarText)
            end

            if DiagPara and DiagPara.SetDesc then
                local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
                local mem = math.floor(Stats:GetTotalMemoryUsageMb())
                local uptimeSec = os.time() - Flags.SessionStartTime
                local hrs = math.floor(uptimeSec / 3600)
                local mins = math.floor((uptimeSec % 3600) / 60)
                local secs = uptimeSec % 60
                local diagText = string.format("FPS: %d | Ping: %d ms | Memory: %d MB\nSession Time: %02d:%02d:%02d", currentFps, ping, mem, hrs, mins, secs)
                DiagPara:SetDesc(diagText)
            end
        end)
        task.wait(0.5)
    end
    ScreenGui:Destroy()
end)

-- ── Mobile Floating Logo Toggle Button ────────────────────────────────────────────────
local MobileToggleGui = Instance.new("ScreenGui")
MobileToggleGui.Name = "PinatHub_MobileToggle"
MobileToggleGui.ResetOnSpawn = false
MobileToggleGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local ToggleBtn = Instance.new("ImageButton", MobileToggleGui)
ToggleBtn.Name = "PinatMobileBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.015, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
ToggleBtn.Image = "rbxassetid://10723415903"
ToggleBtn.ImageColor3 = Color3.fromRGB(0, 255, 170)

local BtnCorner = Instance.new("UICorner", ToggleBtn)
BtnCorner.CornerRadius = UDim.new(0, 23)

local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Color3.fromRGB(0, 255, 170)
BtnStroke.Thickness = 1.5

-- Draggable implementation for Mobile Button
local dragging, dragStart, startPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    if Window and Window.Toggle then
        Window:Toggle()
    end
end)

-- Cleanup on unload
task.spawn(function()
    while not Flags.Unloaded do
        task.wait(1)
    end
    MobileToggleGui:Destroy()
    ScreenGui:Destroy()
    EspFolder:Destroy()
end)

Notify("PinatHub SharedPlanets loaded successfully!", 4)

end -- end of __PinatHub_SharedPlanets_Init__

__PinatHub_SharedPlanets_Init__()
