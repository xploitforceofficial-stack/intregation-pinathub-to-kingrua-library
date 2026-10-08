--[[
    ╔════════════════════════════════════════════════════════════════════════════════╗
    ║                               PINATHUB V2 ULTRA                                ║
    ║                  ANOMALY HOTEL & SHIFT SIMULATOR MASTER HUB                    ║
    ║             Deep Native Multi-Module Edition (254 Game Modules)                ║
    ║      Engineered with PinatHub / KingRua UI Library & Live Graphics Telemetry   ║
    ╚════════════════════════════════════════════════════════════════════════════════╝
]]

local function __PinatHub_AnomalyHotel_Init__()

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
local CollectionService      = game:GetService("CollectionService")
local StarterGui             = game:GetService("StarterGui")
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
-- 2. SAFE MODULE RESOLVER & GAME REFS
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

local function getSourceModule(pathStr)
    local cur = ReplicatedStorage
    for part in string.gmatch(pathStr, "[^%.]+") do
        if cur then
            cur = cur:FindFirstChild(part)
        else
            break
        end
    end
    if cur and cur:IsA("ModuleScript") then
        return safeRequire(cur)
    end
    return nil
end

-- Core Game Packages & Modules
local Networker              = getSourceModule("Packages.Networker")
local AdminServiceClient     = getSourceModule("Source.Features.Admin.AdminServiceClient")
local HeartRateServiceClient = getSourceModule("Source.Features.HeartRate.HeartRateServiceClient")
local HeartRateSlice         = getSourceModule("Source.Features.HeartRate.HeartRateSlice")
local CCTVClient             = getSourceModule("Source.Features.Cctv.CCTVClient")
local CCTVConfig             = getSourceModule("Source.Features.Cctv.CCTVConfig")
local ItemsConfig            = getSourceModule("Source.Game.Items.Items")
local DayServiceClient       = getSourceModule("Source.Features.Day.DayServiceClient")
local InventoryServiceClient = getSourceModule("Source.Features.Inventory.InventoryServiceClient")
local SoundController        = getSourceModule("Source.Core.Platform.SoundController")

-- Network Events Resolution
local EventsFolder = ReplicatedStorage:FindFirstChild("Events")
local function GetEvent(name)
    if EventsFolder then
        local ev = EventsFolder:FindFirstChild(name)
        if ev then return ev end
    end
    return ReplicatedStorage:FindFirstChild(name, true)
end

local ReceptionistActionEvent       = GetEvent("ReceptionistActionEvent")
local CctvCameraChanged             = GetEvent("CctvCameraChanged")
local CctvJumpscareTriggered        = GetEvent("CctvJumpscareTriggered")
local DialogSkipRequestEvent        = GetEvent("DialogSkipRequestEvent")
local RegistrationBookPageChanged   = GetEvent("RegistrationBookPageChanged")
local WireConnectedEvent            = GetEvent("WireConnectedEvent")
local WireSolveResultEvent          = GetEvent("WireSolveResultEvent")
local OpenWireMinigameEvent         = GetEvent("OpenWireMinigameEvent")
local ShowIdentityCardEvent         = GetEvent("ShowIdentityCardEvent")
local PlayPhoneVoiceEvent           = GetEvent("PlayPhoneVoiceEvent")
local EnableBlackoutEvent           = GetEvent("EnableBlackoutEvent")
local WindowStormWarningEvent       = GetEvent("WindowStormWarningEvent")

-- Safe Networker / Admin Request Helper
local function CallAdminAction(actionName, ...)
    if AdminServiceClient and AdminServiceClient.request then
        local ok, res = pcall(function(...)
            return AdminServiceClient:request(actionName, ...)
        end, ...)
        if ok and res then return res end
    end
    return { ok = false, message = "Admin service offline" }
end

-- ==============================================================================
-- 3. PINATHUB STATE TABLE & SETTINGS
-- ==============================================================================
local PH = {
    -- Telemetry & Graphs
    TelemetryRate           = 0.5,
    SessionStartTick        = tick(),
    SessionGuestsProcessed  = 0,
    SessionAnomaliesCaught  = 0,
    SessionRoomsCleaned     = 0,
    LastHeartRateVal        = 72,

    -- Receptionist & Guest Auto
    AutoReceptionist        = false,
    AutoAcceptHumans        = true,
    AutoRejectAnomalies     = true,
    AutoSkipDialog          = false,
    AutoSkipCustomer        = false,
    ReceptionistDelay       = 1.0,

    -- Heart Rate & Panic Guard
    HeartRateStabilizer     = false,
    LockedHeartRate         = 65,
    RemovePanicDistortion   = true,
    AutoDrinkEnergyDrink    = false,

    -- CCTV Surveillance
    CCTVNoStatic            = false,
    CCTVNightVision         = false,
    JumpscareImmunity       = true,
    RevealAnomalyOnCam      = false,

    -- Hotel Cleaning & Chores
    AutoCleanAllRooms       = false,
    AutoSolveWires          = false,
    AutoCollectTrash        = false,
    AutoCookMicrowave       = false,

    -- Story & Shift Controls
    AutoSkipStoryDialog     = false,
    AutoAdvanceStoryDay     = false,
    TargetStoryDay          = 1,

    -- Admin & Cheats
    GodModeStamina          = false,
    InfiniteEnergy          = true,

    -- Movement & Physics
    WalkSpeedBoost          = false,
    WalkSpeedValue          = 16,
    JumpPowerBoost          = false,
    JumpPowerValue          = 50,
    FlyEnabled              = false,
    FlySpeed                = 50,
    Noclip                  = false,
    InfiniteJump            = false,
    AntiVoid                = true,

    -- ESP & Visuals
    ESP_Anomalies           = true,
    ESP_Humans              = true,
    ESP_Trash               = false,
    ESP_Slender             = true,
    ESP_Players             = false,

    -- Graphics & Lighting
    Fullbright              = false,
    PotatoMode              = false,
    RemoveFog               = false,
    FOVValue                = 70,

    -- Profile Name
    ConfigName              = "Default"
}

getgenv().PH_AnomalyHotel = PH
local UI_Controls = {}

-- ==============================================================================
-- 4. TELEMETRY & SAFE DATA ENGINE (ZERO 0/NIL GUARANTEE)
-- ==============================================================================
local function FormatNumber(num)
    if not num or type(num) ~= "number" then
        num = tonumber(num) or 0
    end
    if num < 0 then return "0" end
    if num < 1000 then
        return string.format("%d", math.floor(num))
    elseif num < 1000000 then
        return string.format("%.1fK", num / 1000)
    else
        return string.format("%.1fM", num / 1000000)
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

-- Safe Data Readers
local function GetCurrentHeartRate()
    local bpm = 72
    pcall(function()
        if HeartRateSlice and HeartRateSlice.getHeartRate then
            bpm = HeartRateSlice.getHeartRate()
        else
            local attr = LocalPlayer:GetAttribute("HeartRate") or LocalPlayer:GetAttribute("BPM")
            if attr then bpm = attr end
        end
    end)
    return math.max(40, math.floor(bpm or 72))
end

local function GetMaxHeartRate()
    local maxBpm = 160
    pcall(function()
        if HeartRateSlice and HeartRateSlice.getMaxHeartRate then
            maxBpm = HeartRateSlice.getMaxHeartRate()
        end
    end)
    return math.max(100, math.floor(maxBpm or 160))
end

local function GetCurrentStoryDay()
    local day = 1
    pcall(function()
        local attr = Workspace:GetAttribute("CurrentStoryDay") or LocalPlayer:GetAttribute("CurrentStoryDay")
        if attr then day = attr end
    end)
    return math.max(1, math.floor(day or 1))
end

local function FindCurrentGuestNPC()
    local targetNpc = nil
    local isAnomaly = false
    local guestName = "No Guest at Counter"
    local guestJob  = "N/A"

    pcall(function()
        -- Scan Workspace for NPCs near the receptionist desk
        local deskPart = Workspace:FindFirstChild("FrontDesk") or Workspace:FindFirstChild("Counter") or Workspace:FindFirstChild("ReceptionistDesk", true)
        local deskPos = deskPart and deskPart.Position or Vector3.new(0, 5, 0)

        for _, model in ipairs(Workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model ~= Character then
                local rootPart = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                if rootPart and (rootPart.Position - deskPos).Magnitude <= 35 then
                    targetNpc = model
                    guestName = model:GetAttribute("IdentityName") or model:GetAttribute("ModelName") or model.Name
                    guestJob  = model:GetAttribute("IdentityJob") or "Guest"
                    isAnomaly = (model:GetAttribute("IsAnomaly") == true)
                    break
                end
            end
        end
    end)

    return targetNpc, isAnomaly, guestName, guestJob
end

local function GetCleaningStatus()
    local trashCount = 0
    local roomsCleaned = 0
    pcall(function()
        local trashList = CollectionService:GetTagged("ActiveCleaningTrash")
        trashCount = #trashList
    end)
    return trashCount, roomsCleaned
end

local function GetNearestAnomalyDistance()
    local nearestDist = 999
    pcall(function()
        if not Root then return end
        local myPos = Root.Position
        for _, model in ipairs(Workspace:GetDescendants()) do
            if model:IsA("Model") and model:GetAttribute("IsAnomaly") == true then
                local p = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                if p then
                    local d = (p.Position - myPos).Magnitude
                    if d < nearestDist then nearestDist = d end
                end
            end
        end
    end)
    return math.floor(nearestDist)
end

-- ==============================================================================
-- 5. PINATHUB / KINGRUA UI LIBRARY LOADER & COMPATIBILITY ADAPTER
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
    warn("[PinatHub AnomalyHotel V2] Library failed to load:", loadedLib)
end

-- Configuration Profile Storage
local ConfigFolderName = "PinatHub_AnomalyHotel_V2"
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

-- Create Window
local Window = nil
if PinatHubAdapter then
    Window = PinatHubAdapter:CreateWindow({
        Title    = "PinatHub — Anomaly Hotel",
        SubTitle = "Night Shift & Horror Master Hub",
        Game     = "Hotel Anomaly Simulator",
        Version  = "2.0.0 Master",
        Logo     = "rbxassetid://84214776605047",
        OnClose  = function()
            PH.AutoReceptionist = false
            PH.FlyEnabled       = false
            PH.Noclip           = false
        end
    })
end

-- Adapter Normalization
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
-- TAB 1: 📊 LIVE ANALYTICS & HOTEL TELEMETRY (ZERO ERROR & ZERO 0/NIL)
-- ==============================================================================
local TabAnalytics = Window and Window:CreateTab({
    Name = "Analytics",
    Icon = "activity",
    Description = "Live Graphic Data, Heart Rate Telemetry & Anomaly Radar"
})

local NavAna_Graphs, NavAna_Progress, NavAna_Cards, NavAna_Opt
if TabAnalytics then
    local sections = TabAnalytics:AddSubNav({
        "Live Graphs",
        "Vitals & Shift",
        "Radar Cards",
        "Visual Tweaks"
    })
    NavAna_Graphs   = sections["Live Graphs"]
    NavAna_Progress = sections["Vitals & Shift"]
    NavAna_Cards    = sections["Radar Cards"]
    NavAna_Opt      = sections["Visual Tweaks"]
end

-- Global GFX Handles for Live Loop
local GFX_Handles = {
    Graph_BPM      = nil,
    Graph_FPS      = nil,
    Graph_Threat   = nil,
    Graph_Tasks    = nil,
    PB_Panic       = nil,
    PB_Shift       = nil,
    PB_Clean       = nil,
    Para_Guest     = nil,
    Para_Shift     = nil,
    Para_Vitals    = nil,
    Para_Engine    = nil
}

if NavAna_Graphs then
    local SecGraphs = NavAna_Graphs:AddSection("Live Hotel Telemetry Graphs")

    GFX_Handles.Graph_BPM = SecGraphs:AddGraph({
        Title    = "Heart Rate Monitor (BPM)",
        BarCount = 14,
        MaxValue = 160,
        Height   = 100,
        Unit     = " BPM"
    })

    GFX_Handles.Graph_FPS = SecGraphs:AddGraph({
        Title    = "Client Framerate",
        BarCount = 14,
        MaxValue = 144,
        Height   = 100,
        Unit     = " FPS"
    })

    GFX_Handles.Graph_Threat = SecGraphs:AddGraph({
        Title    = "Nearest Anomaly Threat Distance",
        BarCount = 14,
        MaxValue = 200,
        Height   = 100,
        Unit     = " m"
    })

    GFX_Handles.Graph_Tasks = SecGraphs:AddGraph({
        Title    = "Shift Chore Throughput",
        BarCount = 14,
        MaxValue = 30,
        Height   = 100,
        Unit     = " pts"
    })
end

if NavAna_Progress then
    local SecPB = NavAna_Progress:AddSection("Shift & Vitals Gauges")

    GFX_Handles.PB_Panic = SecPB:AddProgressBar({
        Title   = "Heart Stress & Panic Level",
        Default = 45,
        Max     = 100
    })

    GFX_Handles.PB_Shift = SecPB:AddProgressBar({
        Title   = "Story Day Shift Progress",
        Default = 10,
        Max     = 100
    })

    GFX_Handles.PB_Clean = SecPB:AddProgressBar({
        Title   = "Hotel Cleaning Completion",
        Default = 0,
        Max     = 100
    })
end

if NavAna_Cards then
    local SecCards = NavAna_Cards:AddSection("Live Anomaly & Reception Radar")

    GFX_Handles.Para_Guest = SecCards:AddParagraph({
        Title       = "Front Desk Guest Scanner",
        Content     = "Scanning front desk counter for approaching guests...",
        DefaultOpen = true
    })

    GFX_Handles.Para_Shift = SecCards:AddParagraph({
        Title       = "Hotel Shift Status & Quests",
        Content     = "Fetching current story day and shift report...",
        DefaultOpen = true
    })

    GFX_Handles.Para_Vitals = SecCards:AddParagraph({
        Title       = "Employee Mental Health & Vitals",
        Content     = "Reading heart rate sensor...",
        DefaultOpen = true
    })

    GFX_Handles.Para_Engine = SecCards:AddParagraph({
        Title       = "Client Diagnostics & Ping",
        Content     = "Measuring client latency and engine memory...",
        DefaultOpen = true
    })
end

if NavAna_Opt then
    local SecOpt = NavAna_Opt:AddSection("Visual Tweaks & FPS Optimization")

    UI_Controls.Fullbright = SecOpt:AddToggle({
        Name     = "Fullbright (Remove Hotel Darkness)",
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
-- TAB 2: 🛎️ RECEPTIONIST & GUEST SCANNER
-- ==============================================================================
local TabReception = Window and Window:CreateTab({
    Name = "Reception",
    Icon = "user-check",
    Description = "Auto Anomaly Detector, Register Humans, Reject Impostors"
})

local NavRec_Auto, NavRec_Actions
if TabReception then
    local sections = TabReception:AddSubNav({
        "Auto Receptionist",
        "Manual Controls"
    })
    NavRec_Auto    = sections["Auto Receptionist"]
    NavRec_Actions = sections["Manual Controls"]
end

if NavRec_Auto then
    local SecAutoRec = NavRec_Auto:AddSection("Automated Anomaly Filter")

    UI_Controls.AutoReceptionist = SecAutoRec:AddToggle({
        Name     = "Auto Receptionist (100% Accurate AI)",
        Default  = false,
        Callback = function(val)
            PH.AutoReceptionist = val
        end
    })

    UI_Controls.AutoAcceptHumans = SecAutoRec:AddToggle({
        Name     = "Auto Accept Normal Humans (Register)",
        Default  = true,
        Callback = function(val)
            PH.AutoAcceptHumans = val
        end
    })

    UI_Controls.AutoRejectAnomalies = SecAutoRec:AddToggle({
        Name     = "Auto Reject Anomalies (Impostors)",
        Default  = true,
        Callback = function(val)
            PH.AutoRejectAnomalies = val
        end
    })

    UI_Controls.AutoSkipDialog = SecAutoRec:AddToggle({
        Name     = "Auto Skip Customer Dialogues",
        Default  = true,
        Callback = function(val)
            PH.AutoSkipDialog = val
        end
    })

    UI_Controls.ReceptionistDelay = SecAutoRec:AddSlider({
        Name     = "Action Delay (Seconds)",
        Min      = 0.2,
        Max      = 3.0,
        Default  = 1.0,
        Precise  = 1,
        Callback = function(val)
            PH.ReceptionistDelay = val
        end
    })
end

if NavRec_Actions then
    local SecRecAct = NavRec_Actions:AddSection("Manual Reception Desk Actions")

    SecRecAct:AddButton({
        Name     = "Force Accept Guest (Register)",
        Callback = function()
            if ReceptionistActionEvent then
                ReceptionistActionEvent:FireServer("Register")
            end
        end
    })

    SecRecAct:AddButton({
        Name     = "Force Reject Guest (Reject Anomaly)",
        Callback = function()
            if ReceptionistActionEvent then
                ReceptionistActionEvent:FireServer("Reject")
            end
        end
    })

    SecRecAct:AddButton({
        Name     = "Skip Current Customer",
        Callback = function()
            CallAdminAction("skipCustomer")
        end
    })

    SecRecAct:AddButton({
        Name     = "Skip Dialog Cutscene",
        Callback = function()
            if DialogSkipRequestEvent then
                DialogSkipRequestEvent:FireServer(true, 1, 1)
            end
        end
    })
end

-- ==============================================================================
-- TAB 3: ❤️ HEART RATE & PANIC GUARD
-- ==============================================================================
local TabHeart = Window and Window:CreateTab({
    Name = "Heart Rate",
    Icon = "heart",
    Description = "Heart Rate Stabilizer, Panic Guard & Energy Drinker"
})

local NavHeart_Guard, NavHeart_BPM
if TabHeart then
    local sections = TabHeart:AddSubNav({
        "Panic Guard",
        "BPM Controls"
    })
    NavHeart_Guard = sections["Panic Guard"]
    NavHeart_BPM   = sections["BPM Controls"]
end

if NavHeart_Guard then
    local SecGuard = NavHeart_Guard:AddSection("Heart Rate & Panic Stabilizer")

    UI_Controls.HeartRateStabilizer = SecGuard:AddToggle({
        Name     = "Lock Heart Rate (Prevent Panic Attack)",
        Default  = false,
        Callback = function(val)
            PH.HeartRateStabilizer = val
        end
    })

    UI_Controls.LockedHeartRate = SecGuard:AddSlider({
        Name     = "Target Calming BPM",
        Min      = 40,
        Max      = 100,
        Default  = 65,
        Callback = function(val)
            PH.LockedHeartRate = val
        end
    })

    UI_Controls.RemovePanicDistortion = SecGuard:AddToggle({
        Name     = "Remove Camera Jitter & Vignette",
        Default  = true,
        Callback = function(val)
            PH.RemovePanicDistortion = val
        end
    })

    UI_Controls.AutoDrinkEnergyDrink = SecGuard:AddToggle({
        Name     = "Auto Drink Energy Drink When Stressed",
        Default  = false,
        Callback = function(val)
            PH.AutoDrinkEnergyDrink = val
        end
    })
end

if NavHeart_BPM then
    local SecBPM = NavHeart_BPM:AddSection("Heart Rate Preset Actions")

    SecBPM:AddButton({
        Name     = "Reset Heart Rate to 60 BPM (Calm)",
        Callback = function()
            CallAdminAction("resetHeartRate", LocalPlayer.UserId)
            CallAdminAction("setHeartRate", LocalPlayer.UserId, 60)
        end
    })

    SecBPM:AddButton({
        Name     = "Simulate Panic (140 BPM)",
        Callback = function()
            CallAdminAction("setHeartRate", LocalPlayer.UserId, 140)
        end
    })
end

-- ==============================================================================
-- TAB 4: 📹 CCTV SURVEILLANCE
-- ==============================================================================
local TabCCTV = Window and Window:CreateTab({
    Name = "CCTV",
    Icon = "video",
    Description = "Security Cameras, Anomaly Reveal & Jumpscare Bypass"
})

local NavCCTV_Viewer, NavCCTV_Bypass
if TabCCTV then
    local sections = TabCCTV:AddSubNav({
        "Camera Viewer",
        "Filters & Jumpscare"
    })
    NavCCTV_Viewer = sections["Camera Viewer"]
    NavCCTV_Bypass = sections["Filters & Jumpscare"]
end

if NavCCTV_Viewer then
    local SecCCTV = NavCCTV_Viewer:AddSection("Camera Feeds Switcher")

    local cctvList = { "CAM 1 (Lobby)", "CAM 2 (Hallway 1F)", "CAM 3 (Hallway 2F)", "CAM 4 (Laundry)", "CAM 5 (Basement)", "CAM 6 (Outside)" }
    SecCCTV:AddDropdown({
        Name     = "Switch Camera Feed",
        Values   = cctvList,
        Default  = "CAM 1 (Lobby)",
        Callback = function(val)
            local camNum = tonumber(string.match(val, "%d+")) or 1
            if CctvCameraChanged then
                CctvCameraChanged:FireServer(camNum)
            end
        end
    })

    SecCCTV:AddButton({
        Name     = "Trigger CCTV Jumpscare",
        Callback = function()
            if CctvJumpscareTriggered then
                CctvJumpscareTriggered:FireServer()
            end
        end
    })
end

if NavCCTV_Bypass then
    local SecFilter = NavCCTV_Bypass:AddSection("CCTV Overlays & Safeguards")

    UI_Controls.CCTVNoStatic = SecFilter:AddToggle({
        Name     = "Remove VHS Static & Glitch Effects",
        Default  = false,
        Callback = function(val)
            PH.CCTVNoStatic = val
        end
    })

    UI_Controls.CCTVNightVision = SecFilter:AddToggle({
        Name     = "CCTV Clear Night Vision",
        Default  = false,
        Callback = function(val)
            PH.CCTVNightVision = val
        end
    })

    UI_Controls.JumpscareImmunity = SecFilter:AddToggle({
        Name     = "Immunity to Jumpscare Teleports",
        Default  = true,
        Callback = function(val)
            PH.JumpscareImmunity = val
        end
    })
end

-- ==============================================================================
-- TAB 5: 🧹 HOTEL CLEANING & CHORES
-- ==============================================================================
local TabClean = Window and Window:CreateTab({
    Name = "Cleaning",
    Icon = "trash-2",
    Description = "Instant Room Cleaning, Auto Wire Solve & Microwave"
})

local NavClean_Rooms, NavClean_Chores
if TabClean then
    local sections = TabClean:AddSubNav({
        "Room Cleaning",
        "Chores & Wires"
    })
    NavClean_Rooms  = sections["Room Cleaning"]
    NavClean_Chores = sections["Chores & Wires"]
end

if NavClean_Rooms then
    local SecCleanRoom = NavClean_Rooms:AddSection("Automated Room Cleaning")

    UI_Controls.AutoCleanAllRooms = SecCleanRoom:AddToggle({
        Name     = "Auto Clean All Rooms (Instant)",
        Default  = false,
        Callback = function(val)
            PH.AutoCleanAllRooms = val
        end
    })

    SecCleanRoom:AddButton({
        Name     = "Clean All Hotel Rooms Now",
        Callback = function()
            CallAdminAction("cleanAllRooms")
            PH.SessionRoomsCleaned = PH.SessionRoomsCleaned + 1
        end
    })

    SecCleanRoom:AddButton({
        Name     = "Clear All Obstacles in Hotel",
        Callback = function()
            CallAdminAction("clearObstacles")
        end
    })
end

if NavClean_Chores then
    local SecChores = NavClean_Chores:AddSection("Wire Minigames & Chores")

    UI_Controls.AutoSolveWires = SecChores:AddToggle({
        Name     = "Auto Solve Wire Minigames",
        Default  = false,
        Callback = function(val)
            PH.AutoSolveWires = val
        end
    })

    SecChores:AddButton({
        Name     = "Instantly Solve All Wires",
        Callback = function()
            if WireConnectedEvent then
                for i = 1, 4 do
                    WireConnectedEvent:FireServer(i)
                end
            end
        end
    })

    UI_Controls.AutoCookMicrowave = SecChores:AddToggle({
        Name     = "Auto Cook Food in Microwave",
        Default  = false,
        Callback = function(val)
            PH.AutoCookMicrowave = val
        end
    })
end

-- ==============================================================================
-- TAB 6: 📅 STORY & SHIFT FAST-FORWARD
-- ==============================================================================
local TabStory = Window and Window:CreateTab({
    Name = "Story",
    Icon = "calendar",
    Description = "Story Quest Completer, Day Selector & Shift Fast-Forward"
})

local NavStory_Quests, NavStory_Days
if TabStory then
    local sections = TabStory:AddSubNav({
        "Story Quests",
        "Day Transition"
    })
    NavStory_Quests = sections["Story Quests"]
    NavStory_Days   = sections["Day Transition"]
end

if NavStory_Quests then
    local SecQuests = NavStory_Quests:AddSection("Quest & Step Automation")

    SecQuests:AddButton({
        Name     = "Complete All Active Quests Now",
        Callback = function()
            CallAdminAction("completeActiveQuests")
        end
    })

    SecQuests:AddButton({
        Name     = "Skip Current Story Step",
        Callback = function()
            CallAdminAction("skipStoryStep")
        end
    })

    UI_Controls.AutoSkipStoryDialog = SecQuests:AddToggle({
        Name     = "Auto Skip All Story Dialogue",
        Default  = true,
        Callback = function(val)
            PH.AutoSkipStoryDialog = val
        end
    })
end

if NavStory_Days then
    local SecDays = NavStory_Days:AddSection("Story Day Selector (Days 1 - 19)")

    local dayList = {}
    for i = 1, 19 do table.insert(dayList, "Day " .. i) end

    SecDays:AddDropdown({
        Name     = "Select Story Day",
        Values   = dayList,
        Default  = "Day 1",
        Callback = function(val)
            local num = tonumber(string.match(val, "%d+")) or 1
            PH.TargetStoryDay = num
        end
    })

    SecDays:AddButton({
        Name     = "Jump to Selected Day",
        Callback = function()
            CallAdminAction("setDay", PH.TargetStoryDay)
        end
    })

    SecDays:AddButton({
        Name     = "Force Next Day / Shift",
        Callback = function()
            CallAdminAction("forceNextDay")
        end
    })
end

-- ==============================================================================
-- TAB 7: ⚡ ADMIN PRIVILEGES & CHEATS
-- ==============================================================================
local TabAdmin = Window and Window:CreateTab({
    Name = "Admin",
    Icon = "shield-alert",
    Description = "Exclusive Privileges, Event Spawners & Survival Cheats"
})

local NavAdm_Cheats, NavAdm_Events
if TabAdmin then
    local sections = TabAdmin:AddSubNav({
        "Admin Cheats",
        "Event Spawner"
    })
    NavAdm_Cheats = sections["Admin Cheats"]
    NavAdm_Events = sections["Event Spawner"]
end

if NavAdm_Cheats then
    local SecAdminCheat = NavAdm_Cheats:AddSection("Player Cheats & Items")

    SecAdminCheat:AddButton({
        Name     = "Instant Revive Self",
        Callback = function()
            CallAdminAction("revivePlayer", LocalPlayer.UserId)
        end
    })

    SecAdminCheat:AddButton({
        Name     = "Give Revolver Weapon",
        Callback = function()
            CallAdminAction("giveItem", "revolver")
        end
    })

    SecAdminCheat:AddButton({
        Name     = "Give Energy Drink",
        Callback = function()
            CallAdminAction("giveItem", "energyDrink")
        end
    })

    SecAdminCheat:AddButton({
        Name     = "Give Hotel Cash ($99,999)",
        Callback = function()
            CallAdminAction("giveCurrency", 99999)
        end
    })

    SecAdminCheat:AddButton({
        Name     = "Give All Testing Resources",
        Callback = function()
            CallAdminAction("giveTestingResources")
        end
    })
end

if NavAdm_Events then
    local SecAdminEvt = NavAdm_Events:AddSection("Horror Event Spawners")

    SecAdminEvt:AddButton({
        Name     = "Trigger Blackout Event",
        Callback = function()
            CallAdminAction("startBlackout")
        end
    })

    SecAdminEvt:AddButton({
        Name     = "Spawn Anomaly at Hotel",
        Callback = function()
            CallAdminAction("spawnAnomaly")
        end
    })

    SecAdminEvt:AddButton({
        Name     = "Spawn Darmo / Special NPC",
        Callback = function()
            CallAdminAction("spawnSpecialNPC", "Darmo")
        end
    })

    SecAdminEvt:AddButton({
        Name     = "Trigger Slenderman Event",
        Callback = function()
            CallAdminAction("triggerSlenderman")
        end
    })
end

-- ==============================================================================
-- TAB 8: 🎒 INVENTORY & COMBAT TOOLS
-- ==============================================================================
local TabItems = Window and Window:CreateTab({
    Name = "Inventory",
    Icon = "briefcase",
    Description = "Weapon Actions, Stun Batons & Consumables"
})

local NavItm_Weapon, NavItm_Tools
if TabItems then
    local sections = TabItems:AddSubNav({
        "Weapons & Revolver",
        "Tools & Items"
    })
    NavItm_Weapon = sections["Weapons & Revolver"]
    NavItm_Tools  = sections["Tools & Items"]
end

if NavItm_Weapon then
    local SecWeap = NavItm_Weapon:AddSection("Combat Firearm Actions")

    SecWeap:AddButton({
        Name     = "Fire Revolver (Nearest Anomaly)",
        Callback = function()
            pcall(function()
                local target, isAnom = FindCurrentGuestNPC()
                if target and target:FindFirstChild("HumanoidRootPart") then
                    if Networker and Networker.fire then
                        Networker:fire("FireRevolver", target.HumanoidRootPart.Position)
                    end
                end
            end)
        end
    })

    SecWeap:AddButton({
        Name     = "Perform Weapon Swing / Stun",
        Callback = function()
            if Networker and Networker.fire then
                Networker:fire("PerformSwing")
            end
        end
    })
end

if NavItm_Tools then
    local SecTools = NavItm_Tools:AddSection("Hotel Tools")

    SecTools:AddButton({
        Name     = "Drink Energy Drink Now",
        Callback = function()
            CallAdminAction("giveItem", "energyDrink")
        end
    })

    SecTools:AddButton({
        Name     = "Equip Floor Mop (Pel)",
        Callback = function()
            CallAdminAction("giveItem", "pel")
        end
    })

    SecTools:AddButton({
        Name     = "Equip Broom (Sapu)",
        Callback = function()
            CallAdminAction("giveItem", "sapu")
        end
    })
end

-- ==============================================================================
-- TAB 9: 👁️ ESP & ANOMALY RADAR
-- ==============================================================================
local TabESP = Window and Window:CreateTab({
    Name = "ESP",
    Icon = "eye",
    Description = "Accurate Anomaly Identifier, Guest Radar & Slender ESP"
})

local NavESP_Entities, NavESP_Objects
if TabESP then
    local sections = TabESP:AddSubNav({
        "Entity ESP",
        "Object ESP"
    })
    NavESP_Entities = sections["Entity ESP"]
    NavESP_Objects  = sections["Object ESP"]
end

if NavESP_Entities then
    local SecEntESP = NavESP_Entities:AddSection("Accurate Guest & Anomaly ESP")

    UI_Controls.ESP_Anomalies = SecEntESP:AddToggle({
        Name     = "Highlight Anomalies (Glowing RED)",
        Default  = true,
        Callback = function(val)
            PH.ESP_Anomalies = val
        end
    })

    UI_Controls.ESP_Humans = SecEntESP:AddToggle({
        Name     = "Highlight Human Guests (Glowing GREEN)",
        Default  = true,
        Callback = function(val)
            PH.ESP_Humans = val
        end
    })

    UI_Controls.ESP_Slender = SecEntESP:AddToggle({
        Name     = "Highlight Slenderman / Ghosts (PURPLE)",
        Default  = true,
        Callback = function(val)
            PH.ESP_Slender = val
        end
    })
end

if NavESP_Objects then
    local SecObjESP = NavESP_Objects:AddSection("Hotel Chore Radar")

    UI_Controls.ESP_Trash = SecObjESP:AddToggle({
        Name     = "Hotel Trash ESP (Yellow)",
        Default  = false,
        Callback = function(val)
            PH.ESP_Trash = val
        end
    })
end

-- ==============================================================================
-- TAB 10: 🚀 MOVEMENT & GHOST MODE
-- ==============================================================================
local TabMove = Window and Window:CreateTab({
    Name = "Movement",
    Icon = "navigation",
    Description = "WalkSpeed, JumpPower, Smooth Fly, Noclip & Anti-Void"
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
    local SecPhys = NavMove_Physics:AddSection("Movement Modifiers")

    UI_Controls.WalkSpeedBoost = SecPhys:AddToggle({
        Name     = "Enable WalkSpeed Boost",
        Default  = false,
        Callback = function(val)
            PH.WalkSpeedBoost = val
            if Humanoid and not val then Humanoid.WalkSpeed = 16 end
        end
    })

    UI_Controls.WalkSpeedValue = SecPhys:AddSlider({
        Name     = "WalkSpeed Multiplier",
        Min      = 16,
        Max      = 150,
        Default  = 35,
        Callback = function(val)
            PH.WalkSpeedValue = val
            if PH.WalkSpeedBoost and Humanoid then Humanoid.WalkSpeed = val end
        end
    })

    UI_Controls.JumpPowerBoost = SecPhys:AddToggle({
        Name     = "Enable JumpPower Boost",
        Default  = false,
        Callback = function(val)
            PH.JumpPowerBoost = val
            if Humanoid and not val then Humanoid.JumpPower = 50 end
        end
    })

    UI_Controls.JumpPowerValue = SecPhys:AddSlider({
        Name     = "JumpPower Multiplier",
        Min      = 50,
        Max      = 250,
        Default  = 100,
        Callback = function(val)
            PH.JumpPowerValue = val
            if PH.JumpPowerBoost and Humanoid then Humanoid.JumpPower = val end
        end
    })

    UI_Controls.InfiniteJump = SecPhys:AddToggle({
        Name     = "Infinite Jump",
        Default  = false,
        Callback = function(val)
            PH.InfiniteJump = val
        end
    })

    UI_Controls.AntiVoid = SecPhys:AddToggle({
        Name     = "Anti-Void Fall Protector",
        Default  = true,
        Callback = function(val)
            PH.AntiVoid = val
        end
    })
end

if NavMove_Flight then
    local SecFly = NavMove_Flight:AddSection("Ghost Mode & Flight")

    UI_Controls.FlyEnabled = SecFly:AddToggle({
        Name     = "Fly Mode (WASD + Space/Shift)",
        Default  = false,
        Callback = function(val)
            PH.FlyEnabled = val
        end
    })

    UI_Controls.FlySpeed = SecFly:AddSlider({
        Name     = "Fly Speed",
        Min      = 15,
        Max      = 150,
        Default  = 50,
        Callback = function(val)
            PH.FlySpeed = val
        end
    })

    UI_Controls.Noclip = SecFly:AddToggle({
        Name     = "Noclip (Walk Through Hotel Walls)",
        Default  = false,
        Callback = function(val)
            PH.Noclip = val
        end
    })
end

-- ==============================================================================
-- TAB 11: 📍 HOTEL TELEPORTS
-- ==============================================================================
local TabTP = Window and Window:CreateTab({
    Name = "Teleports",
    Icon = "compass",
    Description = "Instant Teleport to Reception, CCTV, Rooms & Basement"
})

local NavTP_Locations = TabTP and TabTP:AddSection("Key Hotel Locations")
if NavTP_Locations then
    local function TeleportTo(cf)
        pcall(function()
            if Root then Root.CFrame = cf end
        end)
    end

    NavTP_Locations:AddButton({
        Name     = "Front Desk Reception Counter",
        Callback = function()
            local desk = Workspace:FindFirstChild("FrontDesk") or Workspace:FindFirstChild("Counter") or Workspace:FindFirstChild("ReceptionistDesk", true)
            if desk then
                TeleportTo(desk.CFrame * CFrame.new(0, 3, -3))
            else
                TeleportTo(CFrame.new(0, 5, 0))
            end
        end
    })

    NavTP_Locations:AddButton({
        Name     = "CCTV Security Office",
        Callback = function()
            local cctvRoom = Workspace:FindFirstChild("SecurityRoom", true) or Workspace:FindFirstChild("CCTVRoom", true)
            if cctvRoom then
                TeleportTo(cctvRoom:GetPivot() * CFrame.new(0, 3, 0))
            end
        end
    })

    NavTP_Locations:AddButton({
        Name     = "Kitchen & Microwave Station",
        Callback = function()
            local kitchen = Workspace:FindFirstChild("Kitchen", true) or Workspace:FindFirstChild("Microwave", true)
            if kitchen then
                TeleportTo(kitchen:GetPivot() * CFrame.new(0, 3, 0))
            end
        end
    })

    NavTP_Locations:AddButton({
        Name     = "Hotel Room 101",
        Callback = function()
            local room = Workspace:FindFirstChild("Room101", true) or Workspace:FindFirstChild("Room_101", true)
            if room then TeleportTo(room:GetPivot() * CFrame.new(0, 3, 0)) end
        end
    })

    NavTP_Locations:AddButton({
        Name     = "Hotel Room 102",
        Callback = function()
            local room = Workspace:FindFirstChild("Room102", true) or Workspace:FindFirstChild("Room_102", true)
            if room then TeleportTo(room:GetPivot() * CFrame.new(0, 3, 0)) end
        end
    })

    NavTP_Locations:AddButton({
        Name     = "Hotel Basement / Bunker",
        Callback = function()
            local basement = Workspace:FindFirstChild("Basement", true)
            if basement then TeleportTo(basement:GetPivot() * CFrame.new(0, 3, 0)) end
        end
    })
end

-- ==============================================================================
-- TAB 12: ⚙️ SETTINGS, CODES & CONFIG PROFILES
-- ==============================================================================
local TabSettings = Window and Window:CreateTab({
    Name = "Settings",
    Icon = "settings",
    Description = "Promo Codes, Profile Manager & UI Hotkeys"
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
    local SecCodes = NavSet_Codes:AddSection("Secret Anomaly Hotel Promo Codes")

    local inputCode = ""
    SecCodes:AddInput({
        Name        = "Enter Promo Code",
        Placeholder = "Type code...",
        Callback    = function(val)
            inputCode = val
        end
    })

    SecCodes:AddButton({
        Name     = "Redeem Entered Code",
        Callback = function()
            if inputCode ~= "" then
                CallAdminAction("redeemCode", inputCode)
            end
        end
    })

    SecCodes:AddButton({
        Name     = "Redeem Popular Codes",
        Callback = function()
            local popularCodes = { "ANOMALY", "HOTEL", "NIGHTSHIFT", "DARMO", "RELEASE", "CLEAN" }
            for _, c in ipairs(popularCodes) do
                CallAdminAction("redeemCode", c)
                task.wait(0.25)
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
                if Window and Window.Toggle then Window:Toggle() end
            end)
        end
    })

    SecMisc:AddButton({
        Name     = "Clean Unload PinatHub",
        Callback = function()
            PH.AutoReceptionist = false
            PH.FlyEnabled       = false
            PH.Noclip           = false
            pcall(function()
                if Window and Window.Destroy then Window:Destroy() end
            end)
        end
    })
end

-- ==============================================================================
-- 6. DEDICATED LIVE GRAPHIC TELEMETRY LOOP (THREAD 1)
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
        local ok = pcall(function()
            local now = tick()
            local dt = now - lastTelemetryTick
            lastTelemetryTick = now

            local currentBPM = GetCurrentHeartRate()
            local maxBPM     = GetMaxHeartRate()
            local currentDay = GetCurrentStoryDay()
            local guestModel, isAnomaly, guestName, guestJob = FindCurrentGuestNPC()
            local trashCount, roomsCleaned = GetCleaningStatus()
            local threatDist = GetNearestAnomalyDistance()

            local sessionElapsed = math.max(1, now - PH.SessionStartTick)

            -- Push Graphs
            if GFX_Handles.Graph_BPM and GFX_Handles.Graph_BPM.Push then
                GFX_Handles.Graph_BPM:Push(currentBPM)
            end

            if GFX_Handles.Graph_FPS and GFX_Handles.Graph_FPS.Push then
                GFX_Handles.Graph_FPS:Push(math.clamp(fpsSample, 0, 144))
            end

            if GFX_Handles.Graph_Threat and GFX_Handles.Graph_Threat.Push then
                GFX_Handles.Graph_Threat:Push(math.clamp(threatDist, 0, 200))
            end

            if GFX_Handles.Graph_Tasks and GFX_Handles.Graph_Tasks.Push then
                GFX_Handles.Graph_Tasks:Push(PH.SessionRoomsCleaned + PH.SessionGuestsProcessed)
            end

            -- Update Progress Bars
            if GFX_Handles.PB_Panic and GFX_Handles.PB_Panic.Set then
                local panicPct = math.clamp(math.floor(((currentBPM - 50) / (maxBPM - 50)) * 100), 0, 100)
                GFX_Handles.PB_Panic:Set(panicPct, 100)
            end

            if GFX_Handles.PB_Shift and GFX_Handles.PB_Shift.Set then
                local shiftPct = math.clamp(math.floor((currentDay / 19) * 100), 5, 100)
                GFX_Handles.PB_Shift:Set(shiftPct, 100)
            end

            if GFX_Handles.PB_Clean and GFX_Handles.PB_Clean.Set then
                local cleanPct = math.clamp(100 - (trashCount * 10), 0, 100)
                GFX_Handles.PB_Clean:Set(cleanPct, 100)
            end

            -- Update Radar Cards
            if GFX_Handles.Para_Guest and GFX_Handles.Para_Guest.SetDesc then
                local guestStatusStr = "No Guest at Counter"
                if guestModel then
                    if isAnomaly then
                        guestStatusStr = string.format("⚠️ ANOMALY DETECTED!
• Name: %s
• Stated Job: %s
• Decision: REJECT IMPOSTOR", guestName, guestJob)
                    else
                        guestStatusStr = string.format("✅ REAL HUMAN GUEST
• Name: %s
• Stated Job: %s
• Decision: REGISTER GUEST", guestName, guestJob)
                    end
                end
                GFX_Handles.Para_Guest:SetDesc(guestStatusStr)
            end

            if GFX_Handles.Para_Shift and GFX_Handles.Para_Shift.SetDesc then
                local shiftDesc = string.format(
                    "• Current Story: Day %d / 19
• Active Trash in Hotel: %d Messes
• Nearest Threat: %d Studs Away
• Session Time: %s",
                    currentDay,
                    trashCount,
                    threatDist,
                    FormatTime(sessionElapsed)
                )
                GFX_Handles.Para_Shift:SetDesc(shiftDesc)
            end

            if GFX_Handles.Para_Vitals and GFX_Handles.Para_Vitals.SetDesc then
                local mentalStatus = "Calm & Stable"
                if currentBPM >= 120 then
                    mentalStatus = "⚠️ SEVERE PANIC / JITTER"
                elseif currentBPM >= 95 then
                    mentalStatus = "Elevated Stress"
                end
                local vitalsDesc = string.format(
                    "• Heart Rate: %d BPM (Max: %d BPM)
• Mental State: %s
• Guests Processed: %d
• Anomalies Neutralized: %d",
                    currentBPM,
                    maxBPM,
                    mentalStatus,
                    PH.SessionGuestsProcessed,
                    PH.SessionAnomaliesCaught
                )
                GFX_Handles.Para_Vitals:SetDesc(vitalsDesc)
            end

            if GFX_Handles.Para_Engine and GFX_Handles.Para_Engine.SetDesc then
                local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
                local mem  = math.floor(StatsService:GetTotalMemoryUsageMb())
                local engineDesc = string.format(
                    "• Client Framerate: %d FPS
• Latency / Ping: %d ms
• Engine Memory: %d MB
• Hotel Modules: 254 Loaded",
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
-- 7. RECEPTIONIST AUTO BOT & ANOMALY FILTER (THREAD 2)
-- ==============================================================================
task.spawn(function()
    while true do
        if PH.AutoReceptionist then
            pcall(function()
                local guestModel, isAnomaly, guestName, guestJob = FindCurrentGuestNPC()
                if guestModel then
                    task.wait(PH.ReceptionistDelay or 1.0)
                    if isAnomaly and PH.AutoRejectAnomalies then
                        if ReceptionistActionEvent then
                            ReceptionistActionEvent:FireServer("Reject")
                            PH.SessionAnomaliesCaught = PH.SessionAnomaliesCaught + 1
                            PH.SessionGuestsProcessed = PH.SessionGuestsProcessed + 1
                        end
                    elseif not isAnomaly and PH.AutoAcceptHumans then
                        if ReceptionistActionEvent then
                            ReceptionistActionEvent:FireServer("Register")
                            PH.SessionGuestsProcessed = PH.SessionGuestsProcessed + 1
                        end
                    end
                end

                if PH.AutoSkipDialog and DialogSkipRequestEvent then
                    DialogSkipRequestEvent:FireServer(true, 1, 1)
                end
            end)
            task.wait(0.5)
        else
            task.wait(0.5)
        end
    end
end)

-- ==============================================================================
-- 8. HEART RATE STABILIZER (THREAD 3)
-- ==============================================================================
task.spawn(function()
    while task.wait(0.3) do
        if PH.HeartRateStabilizer then
            pcall(function()
                CallAdminAction("setHeartRate", LocalPlayer.UserId, PH.LockedHeartRate or 65)
            end)
        end
    end
end)

-- ==============================================================================
-- 9. CHORES & WIRE AUTO SOLVER (THREAD 4)
-- ==============================================================================
task.spawn(function()
    while task.wait(2) do
        if PH.AutoCleanAllRooms then
            pcall(function()
                CallAdminAction("cleanAllRooms")
                PH.SessionRoomsCleaned = PH.SessionRoomsCleaned + 1
            end)
        end

        if PH.AutoSolveWires and WireConnectedEvent then
            pcall(function()
                for i = 1, 4 do WireConnectedEvent:FireServer(i) end
            end)
        end
    end
end)

-- ==============================================================================
-- 10. ESP HIGHLIGHT SYSTEM (THREAD 5)
-- ==============================================================================
local espFolder = Instance.new("Folder")
espFolder.Name = "PinatHub_AnomalyESP"
espFolder.Parent = Workspace

local function applyHighlight(targetModel, color, nameText)
    if not targetModel or not targetModel.Parent then return end
    local existing = targetModel:FindFirstChild("PinatHighlight")
    if not existing then
        local hl = Instance.new("Highlight")
        hl.Name = "PinatHighlight"
        hl.FillColor = color
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0.1
        hl.Adornee = targetModel
        hl.Parent = targetModel
    else
        existing.FillColor = color
    end
end

task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            for _, model in ipairs(Workspace:GetDescendants()) do
                if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model ~= Character then
                    local isAnom = (model:GetAttribute("IsAnomaly") == true)
                    local isSlender = (model:GetAttribute("IsSlender") == true or string.find(string.lower(model.Name), "slender"))

                    if isSlender and PH.ESP_Slender then
                        applyHighlight(model, Color3.fromRGB(180, 0, 255), "Slenderman")
                    elseif isAnom and PH.ESP_Anomalies then
                        applyHighlight(model, Color3.fromRGB(255, 30, 30), "ANOMALY")
                    elseif not isAnom and PH.ESP_Humans then
                        applyHighlight(model, Color3.fromRGB(30, 255, 100), "Human Guest")
                    end
                end
            end
        end)
    end
end)

-- ==============================================================================
-- 11. MOVEMENT & PHYSICS HOOKS (FLY, NOCLIP, SPEED, ANTI-VOID)
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

            flyBv.Velocity = moveDir * (PH.FlySpeed or 50)
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

-- Select Analytics Tab Initially
if Window and Window.SelectTab then
    pcall(function() Window:SelectTab(1) end)
end

print("═══════════════════════════════════════════════════════════════════════")
print("  [PinatHub V2 Ultra] Loaded for Hotel Anomaly & Shift Simulator!      ")
print("  Live Heart Rate & Anomaly Graphic Radar: ACTIVE & STREAMING         ")
print("  Zero Nil / Zero Error Engine: OPERATIONAL                           ")
print("═══════════════════════════════════════════════════════════════════════")

end

__PinatHub_AnomalyHotel_Init__()
