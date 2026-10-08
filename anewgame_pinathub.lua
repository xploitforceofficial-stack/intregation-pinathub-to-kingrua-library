-- [[
    PinatHub - Anomaly Hotel & Night Shift Simulator
    Comprehensive Automation, Telemetry, Security & Admin Suite
    Engineered with KingRua UI Library & Native Game Remotes
]]

local function __PinatHub_AnomalyHotel_Init__()

-- Core Engine Services
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

-- Defensive LocalPlayer & Character Resolution (0 Nil Indexing Errors)
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    local startWait = tick()
    repeat
        task.wait(0.05)
        LocalPlayer = Players.LocalPlayer
    until LocalPlayer or (tick() - startWait > 10)
end

local Camera = Workspace.CurrentCamera or Workspace:WaitForChild("Camera", 5)
local Character, Humanoid, Root

local function refreshChar(char)
    Character = char or (LocalPlayer and LocalPlayer.Character)
    Humanoid  = Character and Character:FindFirstChildOfClass("Humanoid")
    Root      = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso") or Character.PrimaryPart)
end

if LocalPlayer then
    refreshChar(LocalPlayer.Character)
    if LocalPlayer.CharacterAdded then
        LocalPlayer.CharacterAdded:Connect(refreshChar)
    end
end

-- Game Network & Remote Access Layer
local Remotes = {}
local function resolveRemotes()
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    local eventsFolder = ReplicatedStorage:FindFirstChild("Events") or (packages and packages:FindFirstChild("Events"))
    
    local function scan(dir)
        if not dir then return end
        for _, item in ipairs(dir:GetDescendants()) do
            if item:IsA("RemoteEvent") or item:IsA("RemoteFunction") then
                Remotes[item.Name] = item
            end
        end
    end
    
    scan(eventsFolder)
    scan(packages)
    scan(ReplicatedStorage)
end
resolveRemotes()

local function GetRemote(name)
    if Remotes[name] then return Remotes[name] end
    resolveRemotes()
    return Remotes[name]
end

local function FireEvent(name, ...)
    local rem = GetRemote(name)
    if rem and rem:IsA("RemoteEvent") then
        pcall(function(...) rem:FireServer(...) end, ...)
    end
end

local function InvokeFunc(name, ...)
    local rem = GetRemote(name)
    if rem and rem:IsA("RemoteFunction") then
        local s, res = pcall(function(...) return rem:InvokeServer(...) end, ...)
        if s then return res end
    end
    return nil
end

-- Game Client Modules Resolution
local AdminServiceClient = nil
local CombatSystemClient = nil
local IndicatorSystemClient = nil
pcall(function()
    for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
        if desc:IsA("ModuleScript") then
            if desc.Name == "AdminServiceClient" then
                AdminServiceClient = require(desc)
            elseif desc.Name == "CombatSystemClient" then
                CombatSystemClient = require(desc)
            elseif desc.Name == "IndicatorSystemClient" then
                IndicatorSystemClient = require(desc)
            end
        end
    end
end)

local function RequestAdmin(action, ...)
    if AdminServiceClient and AdminServiceClient.request then
        pcall(function(...) AdminServiceClient:request(action, ...) end, ...)
        return true
    end
    local adminEvent = GetRemote("AdminActionRequest") or GetRemote("AdminRequest") or GetRemote("AdminServiceClient")
    if adminEvent and adminEvent:IsA("RemoteEvent") then
        pcall(function(...) adminEvent:FireServer(action, ...) end, ...)
        return true
    end
    return false
end

-- Centralized State & Flags Table (Structured after sharedplanets_pinathub.lua)
local Flags = {
    -- Telemetry & Graphics
    Fullbright = false,
    PotatoMode = false,
    RemoveFog = false,
    CustomFOV = 70,
    
    -- Reception
    AutoReceptionist = false,
    AutoSkipDialogue = false,
    AutoOpenIDCard = false,
    ReceptionDelay = 0.5,
    AutoTurnPages = false,
    
    -- Heart Rate & Stress
    LockHeartRate = false,
    LockedBPM = 70,
    AutoResetPanic = false,
    PanicThreshold = 110,
    AutoDrinkEnergy = false,
    MuteHeartbeat = false,
    RemovePanicEffects = false,
    InfiniteStamina = false,
    
    -- CCTV
    RemoveVhsNoise = false,
    BlockJumpscare666 = false,
    NightVisionEnhance = false,
    
    -- Cleaning & Housekeeping
    AutoCleanRooms = false,
    AutoVacuumTrash = false,
    AutoLockWindows = false,
    InstantWireSolver = false,
    InstantInteract = false,
    
    -- Kitchen & Cooking
    AutoMicrowave = false,
    
    -- Story & Days
    AutoCompleteQuests = false,
    FastForwardStory = false,
    TargetStoryDay = 1,
    
    -- Monsters & Threats
    AntiSlenderman = false,
    DangerAlarm = false,
    AutoCleanMonsters = false,
    
    -- Combat
    AutoFireRevolver = false,
    CombatRange = 40,
    RapidFire = false,
    AutoMeleeSwing = false,
    
    -- Roles & Upgrades
    AutoClaimCodex = false,
    
    -- Admin & Privilege
    AdminInvis = false,
    AnomalySpawnRate = 50,
    
    -- ESP & Visuals
    ESP_Anomaly = false,
    ESP_Human = false,
    ESP_Monster = false,
    ESP_Trash = false,
    ESP_Doors = false,
    ESP_Players = false,
    ESP_Indicators = false,
    
    -- Movement
    WalkSpeed = 16,
    JumpPower = 50,
    InfJump = false,
    FlyEnabled = false,
    FlySpeed = 50,
    Noclip = false,
    AntiVoid = false,
    
    -- Optimization & Preferences (Matching sharedplanets_pinathub.lua)
    DisableScreamerVFX = false,
    DisableParticleDust = false,
    MenuKeybind = Enum.KeyCode.RightControl,
    CurrentConfigName = "Default",
    Unloaded = false
}

-- Telemetry Helper Functions
local function GetCurrentHeartRate()
    if LocalPlayer then
        local attr = LocalPlayer:GetAttribute("HeartRate")
        if type(attr) == "number" and attr > 0 then return math.floor(attr) end
    end
    if Character then
        local attr = Character:GetAttribute("HeartRate")
        if type(attr) == "number" and attr > 0 then return math.floor(attr) end
    end
    return 72
end

local function GetCurrentStoryDay()
    local val = Workspace:GetAttribute("CurrentStoryDay") or Workspace:GetAttribute("StoryDay") or Workspace:GetAttribute("Day")
    if type(val) == "number" and val >= 1 then return math.floor(val) end
    return 1
end

local function GetNearestAnomalyDistance()
    if not Root then return 999 end
    local shortest = 999
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= Character then
            if obj:GetAttribute("IsAnomaly") == true or obj.Name:find("Slender") or obj.Name:find("Monster") then
                local pivot = obj:GetPivot().Position
                local d = (pivot - Root.Position).Magnitude
                if d < shortest then shortest = d end
            end
        end
    end
    return math.floor(shortest)
end

local function GetTrashCount()
    local tagged = CollectionService:GetTagged("ActiveCleaningTrash")
    return #tagged
end

local function FindCurrentGuestNPC()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= Character then
            local isAnomaly = obj:GetAttribute("IsAnomaly")
            if isAnomaly ~= nil then
                return obj, isAnomaly
            end
            if obj.Name:find("Guest") or obj.Name:find("Customer") or obj.Name:find("Visitor") then
                return obj, (isAnomaly == true)
            end
        end
    end
    return nil, false
end

-- Clean Notification Helper (No Emojis)
local function Notify(msg, dur)
    dur = dur or 3
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "PinatHub",
            Text = tostring(msg),
            Duration = dur
        })
    end)
end

-- Config Profiles Management (Matching sharedplanets_pinathub.lua & PinatHub Architecture)
local ConfigFolder = "PinatHub_HotelConfigs"
local function SaveConfig(name)
    name = (name and name ~= "") and name or Flags.CurrentConfigName
    if not name or name == "" then name = "Default" end
    Flags.CurrentConfigName = name
    pcall(function()
        if writefile then
            if makefolder and not isfolder(ConfigFolder) then
                makefolder(ConfigFolder)
            end
            local data = {}
            for k, v in pairs(Flags) do
                local t = typeof(v)
                if t == "boolean" or t == "number" or t == "string" then
                    data[k] = v
                end
            end
            writefile(ConfigFolder .. "/" .. name .. ".json", HttpService:JSONEncode(data))
            Notify("Configuration Saved: " .. name, 2.5)
        else
            Notify("Filesystem write not supported", 2.5)
        end
    end)
end

local function LoadConfig(name)
    name = (name and name ~= "") and name or Flags.CurrentConfigName
    if not name or name == "" then name = "Default" end
    pcall(function()
        local path = ConfigFolder .. "/" .. name .. ".json"
        if readfile and isfile and isfile(path) then
            local raw = readfile(path)
            local data = HttpService:JSONDecode(raw)
            if type(data) == "table" then
                for k, v in pairs(data) do
                    if Flags[k] ~= nil then
                        Flags[k] = v
                    end
                end
                Notify("Configuration Loaded: " .. name, 2.5)
                return
            end
        end
        Notify("Config File Not Found: " .. name, 2.5)
    end)
end

local function ListConfigs()
    local list = { "Default" }
    pcall(function()
        if listfiles and isfolder and isfolder(ConfigFolder) then
            for _, f in ipairs(listfiles(ConfigFolder)) do
                local clean = f:match("([^/\\]+)%.json$")
                if clean and clean ~= "Default" then
                    table.insert(list, clean)
                end
            end
        end
    end)
    return list
end

-- Load KingRua UI Library with Guaranteed Fallback
local KingRua = nil
pcall(function()
    local raw = game:HttpGet("https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/main/kingrualibrarysource.lua")
    if raw and #raw > 500 then
        KingRua = loadstring(raw)()
    end
end)

if not KingRua then
    KingRua = {
        CreateWindow = function(_, cfg)
            local win = {}
            function win:AddTab(tcfg)
                local tab = { Name = tcfg.Name }
                function tab:AddSubNav(navCfg)
                    local def = (navCfg and navCfg.Default) or "All"
                    return {
                        ActiveCategory = def,
                        RegisteredSections = {},
                        RegisterSection = function(s, cat, card) end,
                        SelectCategory = function(s, cat) end
                    }
                end
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

-- Adapt Window & Tab methods to guarantee AddSubNav & CreateSection
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
            if tabObj and not tabObj.AddSubNav then
                tabObj.AddSubNav = function(ts, navCfg)
                    local def = (navCfg and navCfg.Default) or "All"
                    return {
                        ActiveCategory = def,
                        RegisteredSections = {},
                        RegisterSection = function(s, cat, card) end,
                        SelectCategory = function(s, cat) end
                    }
                end
            end
            return tabObj
        end
    end
    return win
end

-- Create Main Window (No Emojis)
local Window = KingRua:CreateWindow({
    Title = "PinatHub",
    SubTitle = "Anomaly Hotel Night Shift Simulator",
    TabWidth = 175,
    Size = UDim2.fromOffset(630, 495),
    Theme = "Default"
})

-- SubNav Registration Helper
local function RegSection(subNav, category, secObj)
    if subNav and subNav.RegisterSection then
        pcall(function() subNav:RegisterSection(category, secObj) end)
    end
    return secObj
end

-- 16 Master Tabs with 16 Unique Verified Icons (No Emojis, No Missing, No Duplicates)
local Tab_Analytics = Window:CreateTab({ Name = "Analytics",      Icon = "rbxassetid://10709770317" })
local Tab_Reception = Window:CreateTab({ Name = "Reception",      Icon = "rbxassetid://10709783474" })
local Tab_HeartRate = Window:CreateTab({ Name = "Heart Rate",      Icon = "rbxassetid://10723406885" })
local Tab_CCTV      = Window:CreateTab({ Name = "CCTV",            Icon = "rbxassetid://10747374938" })
local Tab_Cleaning  = Window:CreateTab({ Name = "Cleaning",        Icon = "rbxassetid://10747372167" })
local Tab_Kitchen   = Window:CreateTab({ Name = "Kitchen",         Icon = "rbxassetid://10723376114" })
local Tab_Story     = Window:CreateTab({ Name = "Story & Days",    Icon = "rbxassetid://10723387563" })
local Tab_Monsters  = Window:CreateTab({ Name = "Monsters",        Icon = "rbxassetid://10734962068" })
local Tab_Combat    = Window:CreateTab({ Name = "Combat",          Icon = "rbxassetid://10709818534" })
local Tab_Roles     = Window:CreateTab({ Name = "Roles & Skins",   Icon = "rbxassetid://10747373426" })
local Tab_Admin     = Window:CreateTab({ Name = "Admin Tools",     Icon = "rbxassetid://7733920644"  })
local Tab_Inventory = Window:CreateTab({ Name = "Inventory",       Icon = "rbxassetid://10709769841" })
local Tab_ESP       = Window:CreateTab({ Name = "ESP & Visuals",   Icon = "rbxassetid://10723346959" })
local Tab_Movement  = Window:CreateTab({ Name = "Movement",        Icon = "rbxassetid://10747373176" })
local Tab_Teleport  = Window:CreateTab({ Name = "Teleports",       Icon = "rbxassetid://7733992789"  })
local Tab_Settings  = Window:CreateTab({ Name = "Settings & Info", Icon = "rbxassetid://10734950309" })

-- ==============================================================================
-- TAB 1: Analytics
-- ==============================================================================
local SubNav_Analytics = Tab_Analytics:AddSubNav({
    Categories = { "All", "Telemetry", "Gauges", "Radar", "Display" },
    Default = "All",
    IncludeAll = true
})

local Sec_Telemetry = RegSection(SubNav_Analytics, "Telemetry", Tab_Analytics:AddSection("Live Hotel Telemetry"))
local BPMGraph = Sec_Telemetry:AddGraph({
    Title = "Heart Rate Pulse Monitor",
    BarCount = 14,
    MaxValue = 180,
    Height = 100,
    BarColor = Color3.fromRGB(255, 75, 75),
    BarGlow = Color3.fromRGB(255, 120, 120),
    Unit = " BPM"
})

local ThreatGraph = Sec_Telemetry:AddGraph({
    Title = "Anomaly Proximity Distance",
    BarCount = 14,
    MaxValue = 150,
    Height = 100,
    BarColor = Color3.fromRGB(255, 170, 0),
    BarGlow = Color3.fromRGB(255, 210, 80),
    Unit = " studs"
})

local FPSGraph = Sec_Telemetry:AddGraph({
    Title = "Client Framerate Diagnostics",
    BarCount = 14,
    MaxValue = 120,
    Height = 100,
    BarColor = Color3.fromRGB(0, 200, 255),
    BarGlow = Color3.fromRGB(80, 230, 255),
    Unit = " fps"
})

local Sec_Gauges = RegSection(SubNav_Analytics, "Gauges", Tab_Analytics:AddSection("Shift Gauges & Vitals"))
local PanicProgressBar = Sec_Gauges:AddProgressBar({
    Title = "Employee Panic Stress Meter",
    Default = 20,
    Max = 100
})

local CleanProgressBar = Sec_Gauges:AddProgressBar({
    Title = "Hotel Cleanliness Rating",
    Default = 85,
    Max = 100
})

local StoryProgressBar = Sec_Gauges:AddProgressBar({
    Title = "Shift Day Progression (Day 1 - 19)",
    Default = 1,
    Max = 19
})

local Sec_Radar = RegSection(SubNav_Analytics, "Radar", Tab_Analytics:AddSection("Radar & Status Cards"))
local ScannerCard = Sec_Radar:AddParagraph({
    Title = "Front Desk Scanner Feed",
    Content = "Scanning front desk guest queue...",
    DefaultOpen = true
})

local ShiftCard = Sec_Radar:AddParagraph({
    Title = "Shift Status & Story Target",
    Content = "Connecting to hotel shift dispatcher...",
    DefaultOpen = true
})

local VitalsCard = Sec_Radar:AddParagraph({
    Title = "Employee Vitals & Stress",
    Content = "Syncing local player telemetry...",
    DefaultOpen = true
})

local EngineCard = Sec_Radar:AddParagraph({
    Title = "Engine & Client Diagnostics",
    Content = "Calculating FPS, Ping and Memory...",
    DefaultOpen = true
})

local Sec_Display = RegSection(SubNav_Analytics, "Display", Tab_Analytics:AddSection("Visual & Display Tweaks"))
Sec_Display:AddToggle({
    Name = "Fullbright (Max Ambient Lighting)",
    Default = false,
    Callback = function(v)
        Flags.Fullbright = v
        if v then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = Color3.fromRGB(40, 40, 40)
            Lighting.OutdoorAmbient = Color3.fromRGB(40, 40, 40)
            Lighting.Brightness = 1
        end
    end
})

Sec_Display:AddToggle({
    Name = "Potato Mode (FPS Boost & Texture Reducer)",
    Default = false,
    Callback = function(v)
        Flags.PotatoMode = v
        if v then
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                        obj.Material = Enum.Material.SmoothPlastic
                    end
                end
            end)
        end
    end
})

Sec_Display:AddToggle({
    Name = "Remove 3D Atmospheric Fog",
    Default = false,
    Callback = function(v)
        Flags.RemoveFog = v
        if v then
            Lighting.FogEnd = 100000
        else
            Lighting.FogEnd = 300
        end
    end
})

Sec_Display:AddSlider({
    Name = "Camera Field of View (FOV)",
    Min = 60,
    Max = 120,
    Default = 70,
    Precision = 1,
    Callback = function(v)
        Flags.CustomFOV = v
        if Camera then Camera.FieldOfView = v end
    end
})

-- ==============================================================================
-- TAB 2: Reception
-- ==============================================================================
local SubNav_Reception = Tab_Reception:AddSubNav({
    Categories = { "All", "Automation", "Manual", "Book" },
    Default = "All",
    IncludeAll = true
})

local Sec_RecAuto = RegSection(SubNav_Reception, "Automation", Tab_Reception:AddSection("Receptionist Automation"))
Sec_RecAuto:AddToggle({
    Name = "Auto Receptionist AI (100% Accurate Impostor Filter)",
    Default = false,
    Callback = function(v)
        Flags.AutoReceptionist = v
        if v then Notify("Auto Receptionist AI Enabled", 2) end
    end
})

Sec_RecAuto:AddSlider({
    Name = "Check-In Processing Delay (s)",
    Min = 0.1,
    Max = 2.0,
    Default = 0.5,
    Precision = 2,
    Callback = function(v)
        Flags.ReceptionDelay = v
    end
})

Sec_RecAuto:AddToggle({
    Name = "Auto Fast Skip Guest Dialogue",
    Default = false,
    Callback = function(v)
        Flags.AutoSkipDialogue = v
    end
})

Sec_RecAuto:AddToggle({
    Name = "Auto Open Identity Card",
    Default = false,
    Callback = function(v)
        Flags.AutoOpenIDCard = v
    end
})

local Sec_RecManual = RegSection(SubNav_Reception, "Manual", Tab_Reception:AddSection("Manual Receptionist Controls"))
Sec_RecManual:AddButton({
    Name = "Force Register Current Guest (Accept)",
    Callback = function()
        FireEvent("ReceptionistActionEvent", "Register")
        Notify("Force Registered Guest", 2)
    end
})

Sec_RecManual:AddButton({
    Name = "Force Reject Impostor Anomaly (Reject)",
    Callback = function()
        FireEvent("ReceptionistActionEvent", "Reject")
        Notify("Force Rejected Anomaly", 2)
    end
})

Sec_RecManual:AddButton({
    Name = "Skip Current Customer (Admin Bypass)",
    Callback = function()
        RequestAdmin("skipCustomer")
        Notify("Skipped Customer via Admin Service", 2)
    end
})

local Sec_RecBook = RegSection(SubNav_Reception, "Book", Tab_Reception:AddSection("Guest Book & Dialogue"))
Sec_RecBook:AddButton({
    Name = "Turn Guest Book Next Page",
    Callback = function()
        FireEvent("RegistrationBookPageChanged", 2)
    end
})

Sec_RecBook:AddButton({
    Name = "Turn Guest Book Previous Page",
    Callback = function()
        FireEvent("RegistrationBookPageChanged", 1)
    end
})

Sec_RecBook:AddButton({
    Name = "Skip Active Dialogue Sequence",
    Callback = function()
        FireEvent("DialogSkipRequestEvent", true)
    end
})

-- ==============================================================================
-- TAB 3: Heart Rate
-- ==============================================================================
local SubNav_HeartRate = Tab_HeartRate:AddSubNav({
    Categories = { "All", "Immunity", "Effects", "Consumables", "Presets" },
    Default = "All",
    IncludeAll = true
})

local Sec_HRImmunity = RegSection(SubNav_HeartRate, "Immunity", Tab_HeartRate:AddSection("Heart Rate Immunity & Lock"))
Sec_HRImmunity:AddToggle({
    Name = "Lock Heart Rate (Anti-Panic & Death Immunity)",
    Default = false,
    Callback = function(v)
        Flags.LockHeartRate = v
        if v then Notify("Heart Rate Locked at " .. tostring(Flags.LockedBPM) .. " BPM", 2) end
    end
})

Sec_HRImmunity:AddSlider({
    Name = "Locked Heart Rate Target (BPM)",
    Min = 60,
    Max = 100,
    Default = 70,
    Precision = 1,
    Callback = function(v)
        Flags.LockedBPM = v
    end
})

Sec_HRImmunity:AddToggle({
    Name = "Auto Reset Panic on Spike",
    Default = false,
    Callback = function(v)
        Flags.AutoResetPanic = v
    end
})

Sec_HRImmunity:AddSlider({
    Name = "Panic Trigger Threshold (BPM)",
    Min = 90,
    Max = 160,
    Default = 110,
    Precision = 1,
    Callback = function(v)
        Flags.PanicThreshold = v
    end
})

local Sec_HREffects = RegSection(SubNav_HeartRate, "Effects", Tab_HeartRate:AddSection("Panic Effects & Audio"))
Sec_HREffects:AddToggle({
    Name = "Remove Screen Red Vignette & Camera Jitter",
    Default = false,
    Callback = function(v)
        Flags.RemovePanicEffects = v
    end
})

Sec_HREffects:AddToggle({
    Name = "Mute Rapid Heartbeat Audio",
    Default = false,
    Callback = function(v)
        Flags.MuteHeartbeat = v
    end
})

local Sec_HRConsumables = RegSection(SubNav_HeartRate, "Consumables", Tab_HeartRate:AddSection("Stamina & Consumables"))
Sec_HRConsumables:AddToggle({
    Name = "Auto Drink Energy Drink on Stress",
    Default = false,
    Callback = function(v)
        Flags.AutoDrinkEnergy = v
    end
})

Sec_HRConsumables:AddToggle({
    Name = "Infinite Employee Sprint & Stamina",
    Default = false,
    Callback = function(v)
        Flags.InfiniteStamina = v
    end
})

local Sec_HRPresets = RegSection(SubNav_HeartRate, "Presets", Tab_HeartRate:AddSection("BPM Presets & Testing"))
Sec_HRPresets:AddButton({
    Name = "Apply Calm Pulse Preset (60 BPM)",
    Callback = function()
        RequestAdmin("setHeartRate", 60)
        Notify("Set Heart Rate to 60 BPM", 2)
    end
})

Sec_HRPresets:AddButton({
    Name = "Simulate Panic Attack (140 BPM)",
    Callback = function()
        RequestAdmin("setHeartRate", 140)
        Notify("Set Heart Rate to 140 BPM", 2)
    end
})

-- ==============================================================================
-- TAB 4: CCTV
-- ==============================================================================
local SubNav_CCTV = Tab_CCTV:AddSubNav({
    Categories = { "All", "Feeds", "Enhancements", "Protection" },
    Default = "All",
    IncludeAll = true
})

local Sec_CCTVFeeds = RegSection(SubNav_CCTV, "Feeds", Tab_CCTV:AddSection("Camera Feeds & Switcher"))
Sec_CCTVFeeds:AddDropdown({
    Name = "Select Active Camera Feed",
    Options = {
        "CAM 1 - Main Lobby",
        "CAM 2 - Hallway Section A",
        "CAM 3 - Hallway Section B",
        "CAM 4 - Kitchen & Pantry",
        "CAM 5 - Basement Power Breaker",
        "CAM 6 - Backyard & Alley"
    },
    Default = "CAM 1 - Main Lobby",
    Callback = function(v)
        local id = tonumber(v:match("CAM (%d+)")) or 1
        FireEvent("CctvCameraChanged", id)
        Notify("Switched to Camera " .. tostring(id), 2)
    end
})

Sec_CCTVFeeds:AddButton({
    Name = "Cycle Next Camera Feed",
    Callback = function()
        FireEvent("CctvCameraChanged", 2)
    end
})

Sec_CCTVFeeds:AddButton({
    Name = "Cycle Previous Camera Feed",
    Callback = function()
        FireEvent("CctvCameraChanged", 1)
    end
})

local Sec_CCTVEnhance = RegSection(SubNav_CCTV, "Enhancements", Tab_CCTV:AddSection("Visual Enhancements"))
Sec_CCTVEnhance:AddToggle({
    Name = "Remove VHS Glitch & Static Noise Overlay",
    Default = false,
    Callback = function(v)
        Flags.RemoveVhsNoise = v
    end
})

Sec_CCTVEnhance:AddToggle({
    Name = "Enhanced Thermal Night Vision",
    Default = false,
    Callback = function(v)
        Flags.NightVisionEnhance = v
    end
})

local Sec_CCTVProtect = RegSection(SubNav_CCTV, "Protection", Tab_CCTV:AddSection("Jumpscare Protection"))
Sec_CCTVProtect:AddToggle({
    Name = "Jumpscare 666 Immunity (Block Screamer)",
    Default = false,
    Callback = function(v)
        Flags.BlockJumpscare666 = v
    end
})

Sec_CCTVProtect:AddButton({
    Name = "Test Trigger CCTV Jumpscare",
    Callback = function()
        FireEvent("CctvJumpscareTriggered")
    end
})

-- ==============================================================================
-- TAB 5: Cleaning
-- ==============================================================================
local SubNav_Cleaning = Tab_Cleaning:AddSubNav({
    Categories = { "All", "Housekeeping", "Minigames", "Interactions" },
    Default = "All",
    IncludeAll = true
})

local Sec_CleanHouse = RegSection(SubNav_Cleaning, "Housekeeping", Tab_Cleaning:AddSection("Housekeeping Automation"))
Sec_CleanHouse:AddButton({
    Name = "Clean All Hotel Rooms Instantly",
    Callback = function()
        RequestAdmin("cleanAllRooms")
        Notify("All Hotel Rooms Cleaned", 2)
    end
})

Sec_CleanHouse:AddToggle({
    Name = "Loop Auto Clean Hotel Rooms",
    Default = false,
    Callback = function(v)
        Flags.AutoCleanRooms = v
    end
})

Sec_CleanHouse:AddToggle({
    Name = "Auto Vacuum Active Trash to Inventory",
    Default = false,
    Callback = function(v)
        Flags.AutoVacuumTrash = v
    end
})

local Sec_CleanMini = RegSection(SubNav_Cleaning, "Minigames", Tab_Cleaning:AddSection("Minigames & Security"))
Sec_CleanMini:AddToggle({
    Name = "Instant Wire Minigame Auto-Solver",
    Default = false,
    Callback = function(v)
        Flags.InstantWireSolver = v
    end
})

Sec_CleanMini:AddToggle({
    Name = "Auto Lock Hotel Windows",
    Default = false,
    Callback = function(v)
        Flags.AutoLockWindows = v
    end
})

local Sec_CleanInteract = RegSection(SubNav_Cleaning, "Interactions", Tab_Cleaning:AddSection("Proximity Interactions"))
Sec_CleanInteract:AddToggle({
    Name = "Instant Proximity Prompt Interaction",
    Default = false,
    Callback = function(v)
        Flags.InstantInteract = v
    end
})

-- ==============================================================================
-- TAB 6: Kitchen
-- ==============================================================================
local SubNav_Kitchen = Tab_Kitchen:AddSubNav({
    Categories = { "All", "Microwave", "Cooking Menu", "Dispenser" },
    Default = "All",
    IncludeAll = true
})

local Sec_Microwave = RegSection(SubNav_Kitchen, "Microwave", Tab_Kitchen:AddSection("Microwave Automation"))
Sec_Microwave:AddToggle({
    Name = "Auto Cook Food in Microwave",
    Default = false,
    Callback = function(v)
        Flags.AutoMicrowave = v
    end
})

Sec_Microwave:AddButton({
    Name = "Start Microwave Heating Cycle",
    Callback = function()
        FireEvent("StartCookingEvent", "Microwave")
        Notify("Started Microwave Cycle", 2)
    end
})

local Sec_CookingMenu = RegSection(SubNav_Kitchen, "Cooking Menu", Tab_Kitchen:AddSection("Quick Cooking Menu"))
Sec_CookingMenu:AddButton({
    Name = "Cook Nasi Goreng (Fried Rice)",
    Callback = function()
        FireEvent("CookingFinishedEvent", "NasiGoreng")
        Notify("Cooked Nasi Goreng", 2)
    end
})

Sec_CookingMenu:AddButton({
    Name = "Cook Classic Beef Burger",
    Callback = function()
        FireEvent("CookingFinishedEvent", "Burger")
        Notify("Cooked Burger", 2)
    end
})

Sec_CookingMenu:AddButton({
    Name = "Cook Pepperoni Pizza",
    Callback = function()
        FireEvent("CookingFinishedEvent", "Pizza")
        Notify("Cooked Pizza", 2)
    end
})

Sec_CookingMenu:AddButton({
    Name = "Cook Hotdog",
    Callback = function()
        FireEvent("CookingFinishedEvent", "Hotdog")
    end
})

Sec_CookingMenu:AddButton({
    Name = "Cook Fish and Chips",
    Callback = function()
        FireEvent("CookingFinishedEvent", "FishChips")
    end
})

local Sec_Dispenser = RegSection(SubNav_Kitchen, "Dispenser", Tab_Kitchen:AddSection("Refrigerator & Drink Dispenser"))
Sec_Dispenser:AddButton({
    Name = "Dispense Warm Tea",
    Callback = function()
        FireEvent("GrabDrinkEvent", "WarmTea")
    end
})

Sec_Dispenser:AddButton({
    Name = "Dispense Black Coffee",
    Callback = function()
        FireEvent("GrabDrinkEvent", "BlackCoffee")
    end
})

Sec_Dispenser:AddButton({
    Name = "Dispense Fresh Orange Juice",
    Callback = function()
        FireEvent("GrabDrinkEvent", "OrangeJuice")
    end
})

Sec_Dispenser:AddButton({
    Name = "Dispense Cold Energy Drink",
    Callback = function()
        FireEvent("GrabDrinkEvent", "EnergyDrink")
    end
})

-- ==============================================================================
-- TAB 7: Story & Days
-- ==============================================================================
local SubNav_Story = Tab_Story:AddSubNav({
    Categories = { "All", "Progression", "Quests", "Night Helpers" },
    Default = "All",
    IncludeAll = true
})

local Sec_Progression = RegSection(SubNav_Story, "Progression", Tab_Story:AddSection("Shift & Day Progression"))
Sec_Progression:AddDropdown({
    Name = "Jump to Story Day",
    Options = {
        "Day 1 - The First Shift",
        "Day 2 - Strange Sounds",
        "Day 3 - Flickering Lights",
        "Day 4 - Uninvited Guest",
        "Day 5 - Cold Breath",
        "Day 6 - Missing Items",
        "Day 7 - Basement Noises",
        "Day 8 - Room 104 Curse",
        "Day 9 - Darmo Warning",
        "Day 10 - Shadow at Desk",
        "Day 11 - Power Cut Nightmare",
        "Day 12 - Blood Stains",
        "Day 13 - Knocking on Glass",
        "Day 14 - Kuntilanak Cry",
        "Day 15 - Gendorowo Roar",
        "Day 16 - Lockdown Protocol",
        "Day 17 - Impostor Invasion",
        "Day 18 - Zombie Outbreak",
        "Day 19 - Slenderman Final Night"
    },
    Default = "Day 1 - The First Shift",
    Callback = function(v)
        local dayNum = tonumber(v:match("Day (%d+)")) or 1
        Flags.TargetStoryDay = dayNum
        RequestAdmin("setDay", dayNum)
        Notify("Switched Story to Day " .. tostring(dayNum), 2)
    end
})

Sec_Progression:AddButton({
    Name = "Force Complete Shift (Next Day)",
    Callback = function()
        RequestAdmin("forceNextDay")
        Notify("Shift Completed - Advancing to Next Day", 2)
    end
})

Sec_Progression:AddButton({
    Name = "Skip Current Story Step",
    Callback = function()
        RequestAdmin("skipStoryStep")
        Notify("Skipped Story Step", 2)
    end
})

local Sec_StoryQuests = RegSection(SubNav_Story, "Quests", Tab_Story:AddSection("Story Quests & Dialogue"))
Sec_StoryQuests:AddButton({
    Name = "Complete All Active Quests Now",
    Callback = function()
        RequestAdmin("completeActiveQuests")
        Notify("Completed Active Quests", 2)
    end
})

Sec_StoryQuests:AddToggle({
    Name = "Auto Complete Quests on Trigger",
    Default = false,
    Callback = function(v)
        Flags.AutoCompleteQuests = v
    end
})

Sec_StoryQuests:AddToggle({
    Name = "Auto Skip Story Dialogue Sequences",
    Default = false,
    Callback = function(v)
        Flags.FastForwardStory = v
    end
})

local Sec_NightHelpers = RegSection(SubNav_Story, "Night Helpers", Tab_Story:AddSection("Special Night Helpers"))
Sec_NightHelpers:AddButton({
    Name = "Call Darmo / Rahmat Assistant",
    Callback = function()
        RequestAdmin("spawnDarmo")
        Notify("Darmo Assistant Dispatched", 2)
    end
})

Sec_NightHelpers:AddButton({
    Name = "Day 18 Zombie Defense Assist",
    Callback = function()
        RequestAdmin("giveItem", "Revolver", 99)
        RequestAdmin("clearObstacles")
        Notify("Zombie Defense Helper Activated", 2)
    end
})

Sec_NightHelpers:AddButton({
    Name = "Day 19 Slenderman Final Assist",
    Callback = function()
        Flags.AntiSlenderman = true
        RequestAdmin("resetHeartRate")
        Notify("Slenderman Immunity Activated", 2)
    end
})

-- ==============================================================================
-- TAB 8: Monsters
-- ==============================================================================
local SubNav_Monsters = Tab_Monsters:AddSubNav({
    Categories = { "All", "Threat Radar", "Defense", "Monster Spawner", "Environment" },
    Default = "All",
    IncludeAll = true
})

local Sec_ThreatRadar = RegSection(SubNav_Monsters, "Threat Radar", Tab_Monsters:AddSection("Threat Radar & Cleaner"))
Sec_ThreatRadar:AddButton({
    Name = "Despawn All Hostiles Instantly",
    Callback = function()
        RequestAdmin("clearObstacles")
        Notify("Despawned All Hostiles & Obstacles", 2)
    end
})

Sec_ThreatRadar:AddToggle({
    Name = "Continuous Auto Despawn Monsters",
    Default = false,
    Callback = function(v)
        Flags.AutoCleanMonsters = v
    end
})

local Sec_MonsterDefense = RegSection(SubNav_Monsters, "Defense", Tab_Monsters:AddSection("Monster Defense & Radar"))
Sec_MonsterDefense:AddToggle({
    Name = "Anti-Slenderman Stare Shield",
    Default = false,
    Callback = function(v)
        Flags.AntiSlenderman = v
    end
})

Sec_MonsterDefense:AddToggle({
    Name = "Proximity Threat Alarm Audio",
    Default = false,
    Callback = function(v)
        Flags.DangerAlarm = v
    end
})

local Sec_MonsterSpawner = RegSection(SubNav_Monsters, "Monster Spawner", Tab_Monsters:AddSection("Monster Spawner"))
Sec_MonsterSpawner:AddButton({
    Name = "Spawn Slenderman",
    Callback = function()
        RequestAdmin("triggerSlenderman")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Kuntilanak",
    Callback = function()
        RequestAdmin("spawnAnomaly", "Kuntilanak")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Gendorowo",
    Callback = function()
        RequestAdmin("spawnAnomaly", "Gendorowo")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Giant Spider",
    Callback = function()
        RequestAdmin("spawnAnomaly", "LabaLaba")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Trash Ghost",
    Callback = function()
        RequestAdmin("spawnAnomaly", "HantuSampah")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Pot Monster",
    Callback = function()
        RequestAdmin("spawnAnomaly", "MonsterPot")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Zombie",
    Callback = function()
        RequestAdmin("spawnAnomaly", "Zombie")
    end
})

Sec_MonsterSpawner:AddButton({
    Name = "Spawn Darmo NPC",
    Callback = function()
        RequestAdmin("spawnDarmo")
    end
})

local Sec_Environment = RegSection(SubNav_Monsters, "Environment", Tab_Monsters:AddSection("Environment & Events"))
Sec_Environment:AddButton({
    Name = "Trigger Hotel Power Blackout",
    Callback = function()
        RequestAdmin("startBlackout")
        Notify("Hotel Power Cut Triggered", 2)
    end
})

Sec_Environment:AddButton({
    Name = "Restore Hotel Breaker Power",
    Callback = function()
        RequestAdmin("restorePower")
        Notify("Hotel Power Restored", 2)
    end
})

-- ==============================================================================
-- TAB 9: Combat
-- ==============================================================================
local SubNav_Combat = Tab_Combat:AddSubNav({
    Categories = { "All", "Revolver", "Melee", "Arsenal" },
    Default = "All",
    IncludeAll = true
})

local Sec_Revolver = RegSection(SubNav_Combat, "Revolver", Tab_Combat:AddSection("Revolver Combat System"))
Sec_Revolver:AddToggle({
    Name = "Auto Aim & Fire Revolver at Anomalies",
    Default = false,
    Callback = function(v)
        Flags.AutoFireRevolver = v
    end
})

Sec_Revolver:AddSlider({
    Name = "Revolver Target Range (studs)",
    Min = 15,
    Max = 80,
    Default = 40,
    Precision = 1,
    Callback = function(v)
        Flags.CombatRange = v
    end
})

Sec_Revolver:AddToggle({
    Name = "Rapid Fire Mode",
    Default = false,
    Callback = function(v)
        Flags.RapidFire = v
    end
})

Sec_Revolver:AddButton({
    Name = "Fire Revolver at Nearest Anomaly Now",
    Callback = function()
        if CombatSystemClient and CombatSystemClient.fire then
            local targetPos = Vector3.new(0, 0, 0)
            if Root then targetPos = Root.Position + (Root.CFrame.LookVector * 10) end
            CombatSystemClient:fire("FireRevolver", targetPos)
            Notify("Fired Revolver", 1.5)
        end
    end
})

local Sec_Melee = RegSection(SubNav_Combat, "Melee", Tab_Combat:AddSection("Melee & Stun Defense"))
Sec_Melee:AddToggle({
    Name = "Auto Melee Swing at Hostiles",
    Default = false,
    Callback = function(v)
        Flags.AutoMeleeSwing = v
    end
})

Sec_Melee:AddButton({
    Name = "Stun Nearest Hostile NPC",
    Callback = function()
        local npc = FindCurrentGuestNPC()
        if npc then
            FireEvent("HitNPC", npc)
            Notify("Stunned NPC", 1.5)
        end
    end
})

local Sec_Arsenal = RegSection(SubNav_Combat, "Arsenal", Tab_Combat:AddSection("Weapon Equipment"))
Sec_Arsenal:AddButton({
    Name = "Equip Revolver Firearm",
    Callback = function()
        RequestAdmin("giveItem", "Revolver", 6)
    end
})

Sec_Arsenal:AddButton({
    Name = "Equip Shock Baton",
    Callback = function()
        RequestAdmin("giveItem", "ShockBaton", 1)
    end
})

Sec_Arsenal:AddButton({
    Name = "Equip Mop Weapon",
    Callback = function()
        RequestAdmin("giveItem", "Mop", 1)
    end
})

-- ==============================================================================
-- TAB 10: Roles & Skins
-- ==============================================================================
local SubNav_Roles = Tab_Roles:AddSubNav({
    Categories = { "All", "Job Class", "Class Upgrades", "Monster Skins", "Codex" },
    Default = "All",
    IncludeAll = true
})

local Sec_JobClass = RegSection(SubNav_Roles, "Job Class", Tab_Roles:AddSection("Job Class Selector"))
local SelectedClass = "Intern"
Sec_JobClass:AddDropdown({
    Name = "Select Employee Role",
    Options = { "Intern", "Bellhop", "Cleaner", "Waiter", "Inspector", "TheHunter" },
    Default = "Intern",
    Callback = function(v)
        SelectedClass = v
    end
})

Sec_JobClass:AddButton({
    Name = "Apply Selected Employee Role",
    Callback = function()
        FireEvent("ClassChangedEvent", SelectedClass)
        Notify("Role Applied: " .. SelectedClass, 2)
    end
})

local Sec_ClassUpg = RegSection(SubNav_Roles, "Class Upgrades", Tab_Roles:AddSection("Class Upgrades"))
Sec_ClassUpg:AddButton({
    Name = "Instant Max Class Upgrade (Level 7)",
    Callback = function()
        for i = 1, 7 do
            FireEvent("requestPromptUpgrade", SelectedClass, i)
        end
        Notify("Max Upgraded Class " .. SelectedClass, 2)
    end
})

local Sec_MonsterSkins = RegSection(SubNav_Roles, "Monster Skins", Tab_Roles:AddSection("Monster Skins Unlocker"))
local SelectedSkin = "Kuntilanak"
Sec_MonsterSkins:AddDropdown({
    Name = "Select Monster Skin",
    Options = { "Kuntilanak", "Gendorowo", "Spider", "Pot Monster" },
    Default = "Kuntilanak",
    Callback = function(v)
        SelectedSkin = v
    end
})

Sec_MonsterSkins:AddButton({
    Name = "Equip Selected Monster Skin",
    Callback = function()
        FireEvent("SkinEquippedEvent", SelectedSkin)
        Notify("Equipped Skin: " .. SelectedSkin, 2)
    end
})

local Sec_Codex = RegSection(SubNav_Roles, "Codex", Tab_Roles:AddSection("Codex & Rewards"))
Sec_Codex:AddToggle({
    Name = "Auto Claim Anomaly Codex Rewards",
    Default = false,
    Callback = function(v)
        Flags.AutoClaimCodex = v
    end
})

Sec_Codex:AddButton({
    Name = "Claim All Codex Discoveries Now",
    Callback = function()
        FireEvent("ClaimCodexRewardsEvent", "All")
        Notify("Claimed All Codex Rewards", 2)
    end
})

-- ==============================================================================
-- TAB 11: Admin Tools
-- ==============================================================================
local SubNav_Admin = Tab_Admin:AddSubNav({
    Categories = { "All", "Privileges", "Currency", "Arsenal" },
    Default = "All",
    IncludeAll = true
})

local Sec_AdminPriv = RegSection(SubNav_Admin, "Privileges", Tab_Admin:AddSection("Admin Privileges"))
Sec_AdminPriv:AddButton({
    Name = "Revive Local Player Instantly",
    Callback = function()
        RequestAdmin("revivePlayer", LocalPlayer and LocalPlayer.Name or "")
        Notify("Revived Player", 2)
    end
})

Sec_AdminPriv:AddToggle({
    Name = "Toggle Admin Invisibility",
    Default = false,
    Callback = function(v)
        Flags.AdminInvis = v
        RequestAdmin("toggleAdminInvis", v)
    end
})

Sec_AdminPriv:AddSlider({
    Name = "Anomaly Spawn Rate Slider (%)",
    Min = 0,
    Max = 100,
    Default = 50,
    Precision = 1,
    Callback = function(v)
        Flags.AnomalySpawnRate = v
        RequestAdmin("setAnomalyChance", v / 100)
    end
})

local Sec_AdminCurr = RegSection(SubNav_Admin, "Currency", Tab_Admin:AddSection("Currency & Anomaly Spawner"))
Sec_AdminCurr:AddButton({
    Name = "Give 10,000 Cash",
    Callback = function()
        RequestAdmin("giveCurrency", 10000)
        Notify("Gave 10,000 Cash", 2)
    end
})

Sec_AdminCurr:AddButton({
    Name = "Give 50,000 Cash",
    Callback = function()
        RequestAdmin("giveCurrency", 50000)
        Notify("Gave 50,000 Cash", 2)
    end
})

Sec_AdminCurr:AddButton({
    Name = "Give Max 99,999 Cash",
    Callback = function()
        RequestAdmin("giveCurrency", 99999)
        Notify("Gave 99,999 Cash", 2)
    end
})

local Sec_AdminArsenal = RegSection(SubNav_Admin, "Arsenal", Tab_Admin:AddSection("Item & Weapon Spawner"))
Sec_AdminArsenal:AddButton({
    Name = "Spawn Revolver Firearm",
    Callback = function()
        RequestAdmin("giveItem", "Revolver", 6)
    end
})

Sec_AdminArsenal:AddButton({
    Name = "Spawn Shock Baton",
    Callback = function()
        RequestAdmin("giveItem", "ShockBaton", 1)
    end
})

Sec_AdminArsenal:AddButton({
    Name = "Spawn A-Ray Anomaly Gun",
    Callback = function()
        RequestAdmin("giveItem", "ARayGun", 1)
    end
})

Sec_AdminArsenal:AddButton({
    Name = "Spawn 5x Energy Drinks",
    Callback = function()
        RequestAdmin("giveItem", "EnergyDrink", 5)
    end
})

-- ==============================================================================
-- TAB 12: Inventory
-- ==============================================================================
local SubNav_Inventory = Tab_Inventory:AddSubNav({
    Categories = { "All", "Consumables", "Item Actions" },
    Default = "All",
    IncludeAll = true
})

local Sec_Consumables = RegSection(SubNav_Inventory, "Consumables", Tab_Inventory:AddSection("Quick Consumables"))
Sec_Consumables:AddButton({
    Name = "Drink Energy Drink",
    Callback = function()
        FireEvent("ConsumeItemEvent", "EnergyDrink")
    end
})

Sec_Consumables:AddButton({
    Name = "Eat Burger",
    Callback = function()
        FireEvent("ConsumeItemEvent", "Burger")
    end
})

Sec_Consumables:AddButton({
    Name = "Eat Pizza",
    Callback = function()
        FireEvent("ConsumeItemEvent", "Pizza")
    end
})

Sec_Consumables:AddButton({
    Name = "Drink Hot Coffee",
    Callback = function()
        FireEvent("ConsumeItemEvent", "BlackCoffee")
    end
})

Sec_Consumables:AddButton({
    Name = "Drink Warm Tea",
    Callback = function()
        FireEvent("ConsumeItemEvent", "WarmTea")
    end
})

local Sec_ItemActions = RegSection(SubNav_Inventory, "Item Actions", Tab_Inventory:AddSection("Item Actions"))
Sec_ItemActions:AddButton({
    Name = "Drop Currently Held Item",
    Callback = function()
        FireEvent("DropItemEvent")
        Notify("Dropped Held Item", 1.5)
    end
})

-- ==============================================================================
-- TAB 13: ESP & Visuals
-- ==============================================================================
local SubNav_ESP = Tab_ESP:AddSubNav({
    Categories = { "All", "Entity ESP", "Task ESP", "World Indicators" },
    Default = "All",
    IncludeAll = true
})

local Sec_EntityESP = RegSection(SubNav_ESP, "Entity ESP", Tab_ESP:AddSection("Entity ESP Highlights"))
Sec_EntityESP:AddToggle({
    Name = "Highlight Anomalies (Red Highlight)",
    Default = false,
    Callback = function(v)
        Flags.ESP_Anomaly = v
    end
})

Sec_EntityESP:AddToggle({
    Name = "Highlight Human Guests (Green Highlight)",
    Default = false,
    Callback = function(v)
        Flags.ESP_Human = v
    end
})

Sec_EntityESP:AddToggle({
    Name = "Highlight Monsters & Bosses (Purple Highlight)",
    Default = false,
    Callback = function(v)
        Flags.ESP_Monster = v
    end
})

Sec_EntityESP:AddToggle({
    Name = "Highlight Other Players (Blue Highlight)",
    Default = false,
    Callback = function(v)
        Flags.ESP_Players = v
    end
})

local Sec_TaskESP = RegSection(SubNav_ESP, "Task ESP", Tab_ESP:AddSection("Task & Object ESP"))
Sec_TaskESP:AddToggle({
    Name = "Highlight Trash & Housekeeping Tasks (Yellow)",
    Default = false,
    Callback = function(v)
        Flags.ESP_Trash = v
    end
})

Sec_TaskESP:AddToggle({
    Name = "Highlight Room Doors 101 - 105 (Cyan)",
    Default = false,
    Callback = function(v)
        Flags.ESP_Doors = v
    end
})

local Sec_WorldIndicators = RegSection(SubNav_ESP, "World Indicators", Tab_ESP:AddSection("World & Objective Indicators"))
Sec_WorldIndicators:AddToggle({
    Name = "Show Active Objective Beams",
    Default = false,
    Callback = function(v)
        Flags.ESP_Indicators = v
        if IndicatorSystemClient and IndicatorSystemClient.toggle then
            IndicatorSystemClient:toggle(v)
        end
    end
})

-- ==============================================================================
-- TAB 14: Movement
-- ==============================================================================
local SubNav_Movement = Tab_Movement:AddSubNav({
    Categories = { "All", "Locomotion", "3D Flight", "Physics" },
    Default = "All",
    IncludeAll = true
})

local Sec_Locomotion = RegSection(SubNav_Movement, "Locomotion", Tab_Movement:AddSection("Locomotion Modifiers"))
Sec_Locomotion:AddSlider({
    Name = "WalkSpeed Modifier",
    Min = 16,
    Max = 150,
    Default = 16,
    Precision = 1,
    Callback = function(v)
        Flags.WalkSpeed = v
        if Humanoid then Humanoid.WalkSpeed = v end
    end
})

Sec_Locomotion:AddSlider({
    Name = "JumpPower Modifier",
    Min = 50,
    Max = 250,
    Default = 50,
    Precision = 1,
    Callback = function(v)
        Flags.JumpPower = v
        if Humanoid then Humanoid.JumpPower = v end
    end
})

Sec_Locomotion:AddToggle({
    Name = "Infinite Jump (Spacebar Air Jump)",
    Default = false,
    Callback = function(v)
        Flags.InfJump = v
    end
})

local Sec_Flight = RegSection(SubNav_Movement, "3D Flight", Tab_Movement:AddSection("3D Flight Engine"))
Sec_Flight:AddToggle({
    Name = "Enable 3D Flight (WASD + Space/Shift)",
    Default = false,
    Callback = function(v)
        Flags.FlyEnabled = v
    end
})

Sec_Flight:AddSlider({
    Name = "Flight Velocity Speed",
    Min = 20,
    Max = 150,
    Default = 50,
    Precision = 1,
    Callback = function(v)
        Flags.FlySpeed = v
    end
})

local Sec_Physics = RegSection(SubNav_Movement, "Physics", Tab_Movement:AddSection("Physics & Collision Bypasses"))
Sec_Physics:AddToggle({
    Name = "Noclip (Pass Through Hotel Walls & Locked Doors)",
    Default = false,
    Callback = function(v)
        Flags.Noclip = v
    end
})

Sec_Physics:AddToggle({
    Name = "Anti-Void Protection",
    Default = false,
    Callback = function(v)
        Flags.AntiVoid = v
    end
})

-- ==============================================================================
-- TAB 15: Teleports
-- ==============================================================================
local SubNav_Teleport = Tab_Teleport:AddSubNav({
    Categories = { "All", "Work Areas", "Guest Rooms", "Dynamic Targets" },
    Default = "All",
    IncludeAll = true
})

local function TeleportTo(cf)
    if Root then
        Root.CFrame = cf
    end
end

local Sec_WorkAreas = RegSection(SubNav_Teleport, "Work Areas", Tab_Teleport:AddSection("Work Areas & Security"))
Sec_WorkAreas:AddButton({
    Name = "Front Desk Counter",
    Callback = function()
        TeleportTo(CFrame.new(12, 4, -45))
        Notify("Teleported to Front Desk", 1.5)
    end
})

Sec_WorkAreas:AddButton({
    Name = "Receptionist Computer Desk",
    Callback = function()
        TeleportTo(CFrame.new(16, 4, -48))
        Notify("Teleported to Computer Desk", 1.5)
    end
})

Sec_WorkAreas:AddButton({
    Name = "CCTV Security Office",
    Callback = function()
        TeleportTo(CFrame.new(-30, 4, -80))
        Notify("Teleported to CCTV Office", 1.5)
    end
})

Sec_WorkAreas:AddButton({
    Name = "Kitchen & Microwave",
    Callback = function()
        TeleportTo(CFrame.new(-15, 4, -20))
        Notify("Teleported to Kitchen", 1.5)
    end
})

Sec_WorkAreas:AddButton({
    Name = "Basement & Breaker Panel",
    Callback = function()
        TeleportTo(CFrame.new(0, -18, -120))
        Notify("Teleported to Basement", 1.5)
    end
})

local Sec_GuestRooms = RegSection(SubNav_Teleport, "Guest Rooms", Tab_Teleport:AddSection("Guest Rooms"))
Sec_GuestRooms:AddButton({
    Name = "Guest Room 101",
    Callback = function()
        TeleportTo(CFrame.new(45, 4, -10))
        Notify("Teleported to Room 101", 1.5)
    end
})

Sec_GuestRooms:AddButton({
    Name = "Guest Room 102",
    Callback = function()
        TeleportTo(CFrame.new(65, 4, -10))
        Notify("Teleported to Room 102", 1.5)
    end
})

Sec_GuestRooms:AddButton({
    Name = "Guest Room 103",
    Callback = function()
        TeleportTo(CFrame.new(45, 4, 30))
        Notify("Teleported to Room 103", 1.5)
    end
})

Sec_GuestRooms:AddButton({
    Name = "Guest Room 104",
    Callback = function()
        TeleportTo(CFrame.new(65, 4, 30))
        Notify("Teleported to Room 104", 1.5)
    end
})

Sec_GuestRooms:AddButton({
    Name = "Guest Room 105",
    Callback = function()
        TeleportTo(CFrame.new(85, 4, 10))
        Notify("Teleported to Room 105", 1.5)
    end
})

local Sec_DynamicTP = RegSection(SubNav_Teleport, "Dynamic Targets", Tab_Teleport:AddSection("Dynamic Entity Teleports"))
Sec_DynamicTP:AddButton({
    Name = "Teleport to Current Guest NPC",
    Callback = function()
        local npc = FindCurrentGuestNPC()
        if npc and Root then
            local pv = npc:GetPivot()
            Root.CFrame = pv + Vector3.new(0, 0, 3)
            Notify("Teleported to Current Guest", 1.5)
        end
    end
})

Sec_DynamicTP:AddButton({
    Name = "Teleport to Nearest Active Trash",
    Callback = function()
        local tagged = CollectionService:GetTagged("ActiveCleaningTrash")
        if #tagged > 0 and Root then
            local nearest = tagged[1]
            if nearest:IsA("BasePart") then
                Root.CFrame = nearest.CFrame + Vector3.new(0, 3, 0)
            else
                Root.CFrame = nearest:GetPivot() + Vector3.new(0, 3, 0)
            end
            Notify("Teleported to Nearest Trash", 1.5)
        end
    end
})

-- ==============================================================================
-- TAB 16: Settings & Info (Structured & Powered like sharedplanets_pinathub.lua)
-- ==============================================================================
local SubNav_Settings = Tab_Settings:AddSubNav({
    Categories = { "All", "Preferences", "Profiles", "Optimization", "Information" },
    Default = "All",
    IncludeAll = true
})

local Sec_Preferences = RegSection(SubNav_Settings, "Preferences", Tab_Settings:AddSection("Preferences & Keybinds"))
Sec_Preferences:AddKeybind({
    Name = "Toggle Menu Visibility",
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        if Window and Window.Toggle then
            Window:Toggle()
        end
    end
})

Sec_Preferences:AddButton({
    Name = "Unload PinatHub Completely",
    Callback = function()
        Flags.Unloaded = true
        if Window and Window.Destroy then
            pcall(function() Window:Destroy() end)
        end
        Notify("PinatHub Unloaded Cleanly", 3)
    end
})

local Sec_Profiles = RegSection(SubNav_Settings, "Profiles", Tab_Settings:AddSection("Config Profiles Manager"))
Sec_Profiles:AddDropdown({
    Name = "Select Active Profile",
    Options = ListConfigs(),
    Default = "Default",
    Callback = function(v)
        Flags.CurrentConfigName = v
    end
})

Sec_Profiles:AddButton({
    Name = "Save Current Profile to File",
    Callback = function()
        SaveConfig(Flags.CurrentConfigName)
    end
})

Sec_Profiles:AddButton({
    Name = "Load Selected Profile",
    Callback = function()
        LoadConfig(Flags.CurrentConfigName)
    end
})

Sec_Profiles:AddButton({
    Name = "Reset All Flags to Defaults",
    Callback = function()
        Flags.WalkSpeed = 16
        Flags.JumpPower = 50
        Flags.AutoReceptionist = false
        Flags.LockHeartRate = false
        Flags.LockedBPM = 70
        Flags.AutoCleanRooms = false
        Flags.AutoVacuumTrash = false
        Flags.ESP_Anomaly = false
        Flags.ESP_Human = false
        Flags.ESP_Monster = false
        Flags.ESP_Trash = false
        Flags.FlyEnabled = false
        Flags.Noclip = false
        Notify("Reset All Flags to Default", 2)
    end
})

local Sec_Optimization = RegSection(SubNav_Settings, "Optimization", Tab_Settings:AddSection("Performance & Lag Optimization"))
Sec_Optimization:AddToggle({
    Name = "Disable Screamer & Jumpscare Effects",
    Default = false,
    Callback = function(v)
        Flags.DisableScreamerVFX = v
        if v then Notify("Screamer Effects Disabled", 2) end
    end
})

Sec_Optimization:AddToggle({
    Name = "Disable Heavy Particle Emitters & Dust Lag",
    Default = false,
    Callback = function(v)
        Flags.DisableParticleDust = v
        if v then
            pcall(function()
                for _, emitter in ipairs(Workspace:GetDescendants()) do
                    if emitter:IsA("ParticleEmitter") or emitter:IsA("Smoke") or emitter:IsA("Fire") then
                        emitter.Enabled = false
                    end
                end
            end)
            Notify("Particle Emitters Disabled", 2)
        end
    end
})

local Sec_Information = RegSection(SubNav_Settings, "Information", Tab_Settings:AddSection("Information"))
Sec_Information:AddParagraph({
    Title = "PinatHub Night Shift Edition",
    Content = "Comprehensive Automation, Telemetry, Security & Admin Suite\nEngineered with KingRua UI Library & Native Game Remotes\nClean interface with zero emojis, full SubNav category filtering, and real-time radar graphics.",
    DefaultOpen = true
})

-- ==============================================================================
-- Automation Background Engines
-- ==============================================================================

-- 1. Real-Time Telemetry & Radar Data Stream
task.spawn(function()
    local lastBpm = 72
    local lastThreat = 999
    while not Flags.Unloaded do
        pcall(function()
            local bpm = GetCurrentHeartRate()
            lastBpm = bpm
            if BPMGraph and BPMGraph.Push then
                BPMGraph:Push(bpm)
            end

            local threat = GetNearestAnomalyDistance()
            lastThreat = threat
            if ThreatGraph and ThreatGraph.Push then
                ThreatGraph:Push(threat)
            end

            local fps = 60
            local dt = RunService.RenderStepped:Wait()
            if dt > 0 then fps = math.clamp(math.floor(1 / dt), 1, 144) end
            if FPSGraph and FPSGraph.Push then
                FPSGraph:Push(fps)
            end

            if PanicProgressBar and PanicProgressBar.Set then
                local panicPct = math.clamp(math.floor(((bpm - 60) / 80) * 100), 0, 100)
                PanicProgressBar:Set(panicPct, 100)
            end

            if CleanProgressBar and CleanProgressBar.Set then
                local trashCount = GetTrashCount()
                local cleanPct = math.clamp(100 - (trashCount * 8), 10, 100)
                CleanProgressBar:Set(cleanPct, 100)
            end

            if StoryProgressBar and StoryProgressBar.Set then
                local day = GetCurrentStoryDay()
                StoryProgressBar:Set(day, 19)
            end

            if ScannerCard and ScannerCard.SetDesc then
                local guest, isAnomaly = FindCurrentGuestNPC()
                if guest then
                    local statusStr = isAnomaly and "IMPOSTOR ANOMALY DETECTED" or "VERIFIED HUMAN GUEST"
                    ScannerCard:SetDesc("Guest: " .. guest.Name .. "\nVerification: " .. statusStr)
                else
                    ScannerCard:SetDesc("Guest: No Guest at Counter\nDesk Queue: Clear")
                end
            end

            if ShiftCard and ShiftCard.SetDesc then
                local day = GetCurrentStoryDay()
                local trash = GetTrashCount()
                ShiftCard:SetDesc("Shift Day: Day " .. tostring(day) .. " / 19\nPending Trash Chores: " .. tostring(trash))
            end

            if VitalsCard and VitalsCard.SetDesc then
                local bpmState = (bpm < 85 and "Calm / Normal") or (bpm < 115 and "Elevated / Nervous") or "PANIC SPIKE"
                VitalsCard:SetDesc("Heart Rate: " .. tostring(bpm) .. " BPM (" .. bpmState .. ")\nStress Lock: " .. (Flags.LockHeartRate and "Active" or "Disabled"))
            end

            if EngineCard and EngineCard.SetDesc then
                local mem = 0
                pcall(function() mem = math.floor(Stats:GetTotalMemoryUsageMb()) end)
                EngineCard:SetDesc("FPS: " .. tostring(fps) .. " | Memory: " .. tostring(mem) .. " MB")
            end
        end)
        task.wait(1)
    end
end)

-- 2. Receptionist Impostor AI Automation Loop
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoReceptionist then
            pcall(function()
                local guest, isAnomaly = FindCurrentGuestNPC()
                if guest then
                    if Flags.AutoOpenIDCard then
                        FireEvent("ShowIdentityCardEvent")
                    end
                    if Flags.AutoSkipDialogue then
                        FireEvent("DialogSkipRequestEvent", true)
                    end
                    task.wait(Flags.ReceptionDelay or 0.5)
                    if isAnomaly then
                        FireEvent("ReceptionistActionEvent", "Reject")
                    else
                        FireEvent("ReceptionistActionEvent", "Register")
                    end
                    task.wait(1.5)
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- 3. Heart Rate Lock & Stress Reset Loop
task.spawn(function()
    while not Flags.Unloaded do
        pcall(function()
            if Flags.LockHeartRate then
                RequestAdmin("setHeartRate", Flags.LockedBPM or 70)
            end
            if Flags.AutoResetPanic then
                local bpm = GetCurrentHeartRate()
                if bpm > (Flags.PanicThreshold or 110) then
                    RequestAdmin("resetHeartRate")
                end
            end
            if Flags.AutoDrinkEnergy then
                local bpm = GetCurrentHeartRate()
                if bpm > (Flags.PanicThreshold or 110) then
                    FireEvent("ConsumeItemEvent", "EnergyDrink")
                end
            end
            if Flags.RemovePanicEffects then
                local vfx = Camera and Camera:FindFirstChild("HeartRatePanicEffectsPre")
                if vfx then vfx:Destroy() end
            end
            if Flags.MuteHeartbeat then
                for _, s in ipairs(Workspace:GetDescendants()) do
                    if s:IsA("Sound") and (s.Name:find("Heart") or s.Name:find("Pulse")) then
                        s.Volume = 0
                    end
                end
            end
        end)
        task.wait(0.2)
    end
end)

-- 4. CCTV VHS Glitch Remover Loop
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.RemoveVhsNoise then
            pcall(function()
                for _, ui in ipairs(Players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do
                    if ui.Name:find("Vhs") or ui.Name:find("Noise") or ui.Name:find("Glitch") then
                        if ui:IsA("GuiObject") then ui.Visible = false end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

-- 5. Housekeeping Auto Clean & Vacuum Loop
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoCleanRooms then
            pcall(function()
                RequestAdmin("cleanAllRooms")
            end)
        end
        if Flags.AutoVacuumTrash then
            pcall(function()
                local tagged = CollectionService:GetTagged("ActiveCleaningTrash")
                if Root and #tagged > 0 then
                    for _, trash in ipairs(tagged) do
                        local prompt = trash:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            fireproximityprompt(prompt, 0)
                        end
                    end
                end
            end)
        end
        if Flags.InstantWireSolver then
            pcall(function()
                for i = 1, 4 do
                    FireEvent("WireConnectedEvent", i)
                end
                FireEvent("WireSolveResultEvent", true)
            end)
        end
        task.wait(1)
    end
end)

-- 6. Proximity Prompt Enhancer Loop
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.InstantInteract then
            pcall(function()
                for _, p in ipairs(Workspace:GetDescendants()) do
                    if p:IsA("ProximityPrompt") then
                        p.HoldDuration = 0
                        p.MaxActivationDistance = 50
                    end
                end
            end)
        end
        task.wait(1.5)
    end
end)

-- 7. Auto Microwave Cooking Loop
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoMicrowave then
            pcall(function()
                FireEvent("StartCookingEvent", "Microwave")
                task.wait(3)
                FireEvent("CookingFinishedEvent", "CookedMeal")
            end)
        end
        task.wait(2)
    end
end)

-- 8. Combat Auto Revolver & Melee Loop
task.spawn(function()
    while not Flags.Unloaded do
        if Flags.AutoFireRevolver then
            pcall(function()
                if CombatSystemClient and CombatSystemClient.fire and Root then
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj:IsA("Model") and obj ~= Character then
                            if obj:GetAttribute("IsAnomaly") == true or obj.Name:find("Slender") or obj.Name:find("Monster") then
                                local pos = obj:GetPivot().Position
                                local dist = (pos - Root.Position).Magnitude
                                if dist <= (Flags.CombatRange or 40) then
                                    CombatSystemClient:fire("FireRevolver", pos)
                                    if not Flags.RapidFire then break end
                                end
                            end
                        end
                    end
                end
            end)
        end
        if Flags.AutoMeleeSwing then
            pcall(function()
                if CombatSystemClient and CombatSystemClient.fire then
                    CombatSystemClient:fire("PerformSwing")
                end
            end)
        end
        task.wait(Flags.RapidFire and 0.15 or 0.5)
    end
end)

-- 9. ESP & Highlights Engine
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "PinatHub_HotelESP"
ESPFolder.Parent = Workspace

local function CreateHighlight(target, color)
    if not target or not target:IsA("Model") then return end
    local existing = target:FindFirstChild("PinatHighlight")
    if not existing then
        local h = Instance.new("Highlight")
        h.Name = "PinatHighlight"
        h.FillColor = color
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.Adornee = target
        h.Parent = target
    else
        existing.FillColor = color
        existing.Enabled = true
    end
end)

task.spawn(function()
    while not Flags.Unloaded do
        pcall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj ~= Character then
                    local isAnomaly = obj:GetAttribute("IsAnomaly")
                    if isAnomaly == true and Flags.ESP_Anomaly then
                        CreateHighlight(obj, Color3.fromRGB(255, 50, 50))
                    elseif isAnomaly == false and Flags.ESP_Human then
                        CreateHighlight(obj, Color3.fromRGB(50, 255, 50))
                    elseif (obj.Name:find("Slender") or obj.Name:find("Monster")) and Flags.ESP_Monster then
                        CreateHighlight(obj, Color3.fromRGB(180, 50, 255))
                    end
                end
            end
            if Flags.ESP_Players then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        CreateHighlight(p.Character, Color3.fromRGB(50, 150, 255))
                    end
                end
            end
            if Flags.ESP_Trash then
                for _, trash in ipairs(CollectionService:GetTagged("ActiveCleaningTrash")) do
                    if trash:IsA("Model") then
                        CreateHighlight(trash, Color3.fromRGB(255, 255, 50))
                    end
                end
            end
        end)
        task.wait(1.5)
    end
end)

-- 10. Locomotion, Noclip & Flight Engine
UserInputService.JumpRequest:Connect(function()
    if Flags.InfJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Stepped:Connect(function()
    if Flags.Noclip and Character then
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end
    if Flags.AntiVoid and Root then
        if Root.Position.Y < -50 then
            Root.CFrame = CFrame.new(12, 5, -45)
        end
    end
end)

task.spawn(function()
    local flyBodyPos, flyBodyGyro
    while not Flags.Unloaded do
        if Flags.FlyEnabled and Root then
            if not flyBodyPos then
                flyBodyPos = Instance.new("BodyPosition")
                flyBodyPos.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                flyBodyPos.Position = Root.Position
                flyBodyPos.Parent = Root
            end
            if not flyBodyGyro then
                flyBodyGyro = Instance.new("BodyGyro")
                flyBodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
                flyBodyGyro.CFrame = Root.CFrame
                flyBodyGyro.Parent = Root
            end
            local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            flyBodyPos.Position = flyBodyPos.Position + (moveDir * ((Flags.FlySpeed or 50) / 10))
            flyBodyGyro.CFrame = Camera.CFrame
        else
            if flyBodyPos then flyBodyPos:Destroy(); flyBodyPos = nil end
            if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
        end
        RunService.RenderStepped:Wait()
    end
end)

-- Select Tab 1 (Analytics) as Initial Focus
pcall(function()
    if Window and Window.SelectTab then
        Window:SelectTab(1)
    end
end)

Notify("PinatHub Initialized Successfully", 3)
return Window
end

return __PinatHub_AnomalyHotel_Init__()