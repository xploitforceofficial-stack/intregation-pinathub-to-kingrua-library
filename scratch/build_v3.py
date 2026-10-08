# -*- coding: utf-8 -*-
import sys, os

sys.stdout.reconfigure(encoding='utf-8')

out_path = r"c:\Users\personal\pinathublibraryREAL\intregation-pinathub-to-kingrua-library-1\anewgame_pinathub_v2.lua"

print("Building rock-solid anewgame_pinathub_v2.lua with Native PinatHub Image IDs, zero emojis, and Luau typing fixes...")

chunks = []

def add(chunk):
    chunks.append(chunk)

# SECTION 1: HEADER & DEFENSIVE LOCALPLAYER
add(r'''--[[
    PinatHub Premium - Anomaly Hotel & Night Shift Simulator
    Fully Grounded Native Game Modules & High-Precision Automation Suite
    Integrated with PinatHub / KingRua Dynamic Analytics UI Library
    Using Native Image Asset IDs (Zero Emojis, Zero Luau Type Errors)
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
local Stats             = game:GetService("Stats")
local SoundService      = game:GetService("SoundService")

-- Ultra-Defensive LocalPlayer Resolution (0 Nil Indexing Guarantee)
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    local startWait = tick()
    repeat
        task.wait(0.05)
        LocalPlayer = Players.LocalPlayer
    until LocalPlayer or (tick() - startWait > 5)
end
if not LocalPlayer then
    pcall(function()
        LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    end)
end

local function GetMyUserId()
    if LocalPlayer and LocalPlayer.UserId then
        return LocalPlayer.UserId
    end
    if Players.LocalPlayer and Players.LocalPlayer.UserId then
        return Players.LocalPlayer.UserId
    end
    return 0
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
    pcall(function()
        LocalPlayer.CharacterAdded:Connect(refreshChar)
    end)
end
pcall(function()
    Players.PlayerAdded:Connect(function(plr)
        if not LocalPlayer then
            LocalPlayer = plr
            refreshChar(plr.Character)
            pcall(function()
                plr.CharacterAdded:Connect(refreshChar)
            end)
        end
    end)
end)
''')

# SECTION 2: SAFE SLICE & DATA MODULE RESOLUTION (No side-effects, no CharacterAdded calls)
add(r'''
-- ========================================================================================
-- 1. SAFE NATIVE SLICE & DATA MODULES RESOLUTION (Pure State Tables, Zero Side Effects)
-- ========================================================================================
local function SafeRequire(inst)
    if not inst then return nil end
    local ok, res = pcall(function()
        return require(inst)
    end)
    if ok and res ~= nil then
        return res
    end
    return nil
end

local function FindModuleByPath(...)
    local cur = ReplicatedStorage
    for _, seg in ipairs({...}) do
        cur = cur and cur:FindFirstChild(seg)
        if not cur then return nil end
    end
    return cur
end

-- Pure state slices & data tables (guaranteed 0 side effects, never touches CharacterAdded)
local DaySlice              = SafeRequire(FindModuleByPath("Source", "Features", "Day", "UI", "DaySlice"))
local HeartRateSlice        = SafeRequire(FindModuleByPath("Source", "Features", "HeartRate", "HeartRateSlice"))
local GameOverSlice         = SafeRequire(FindModuleByPath("Source", "Features", "GameOver", "GameOverSlice"))
local InventorySlice        = SafeRequire(FindModuleByPath("Source", "Features", "Inventory", "InventorySlice"))
local ObjectiveTrackerSlice = SafeRequire(FindModuleByPath("Source", "Features", "ObjectiveTracker", "ObjectiveTrackerSlice"))
local ClassData             = SafeRequire(FindModuleByPath("Source", "Features", "Class", "Modules", "ClassData"))
local Items                 = SafeRequire(FindModuleByPath("Source", "Game", "Items", "Items"))
local NetworkerPackage      = SafeRequire(FindModuleByPath("Packages", "Networker"))

-- ========================================================================================
-- 2. GAME NETWORKER CLIENT BINDING (Clean, Isolated & Safe from Service Inits)
-- ========================================================================================
local NetworkerClients = {
    Admin = nil,
    Combat = nil,
    HeartRate = nil,
    Inventory = nil,
    Day = nil,
    GameOver = nil,
    Class = nil,
    Journal = nil,
    ObjectiveTracker = nil
}

local function InitNetworkClient(serviceName)
    if NetworkerPackage and NetworkerPackage.client and NetworkerPackage.client.new then
        local client = nil
        local ok = pcall(function()
            -- Pass an empty table {} so Networker never executes broken service module inits!
            client = NetworkerPackage.client.new(serviceName, {})
        end)
        if ok and client then
            return client
        end
    end
    return nil
end

NetworkerClients.Admin            = InitNetworkClient("AdminService")
NetworkerClients.Combat           = InitNetworkClient("CombatSystem")
NetworkerClients.HeartRate        = InitNetworkClient("HeartRateService")
NetworkerClients.Inventory        = InitNetworkClient("InventoryService")
NetworkerClients.Day              = InitNetworkClient("DayService")
NetworkerClients.GameOver         = InitNetworkClient("GameOverService")
NetworkerClients.Class            = InitNetworkClient("ClassService")
NetworkerClients.Journal          = InitNetworkClient("JournalService")
NetworkerClients.ObjectiveTracker = InitNetworkClient("ObjectiveTrackerService")

local function RequestAdminAction(actionName, ...)
    if NetworkerClients.Admin and NetworkerClients.Admin.fetch then
        local s, res = pcall(function(...)
            return NetworkerClients.Admin:fetch(actionName, ...)
        end, ...)
        if s and res ~= nil then return res end
    end
    return { ok = false, message = "Admin networker not connected" }
end

-- ========================================================================================
-- 3. NATIVE REMOTE EVENTS REGISTRY (ReplicatedStorage.Events)
-- ========================================================================================
local Remotes = {}
local function resolveEvents()
    local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
    if eventsFolder then
        for _, rem in ipairs(eventsFolder:GetChildren()) do
            if rem:IsA("RemoteEvent") or rem:IsA("RemoteFunction") then
                Remotes[rem.Name] = rem
            end
        end
    end
    for _, rem in ipairs(ReplicatedStorage:GetDescendants()) do
        if rem:IsA("RemoteEvent") or rem:IsA("RemoteFunction") then
            if not Remotes[rem.Name] then
                Remotes[rem.Name] = rem
            end
        end
    end
end
resolveEvents()

local function GetRemote(name)
    if Remotes[name] then return Remotes[name] end
    resolveEvents()
    return Remotes[name]
end

local function FireRemote(name, ...)
    local rem = GetRemote(name)
    if rem and rem:IsA("RemoteEvent") then
        pcall(function(...) rem:FireServer(...) end, ...)
        return true
    end
    return false
end
''')

# SECTION 3: FLAGS & TELEPORT LOCATIONS
add(r'''
-- ========================================================================================
-- 4. CENTRALIZED STATE & FLAGS
-- ========================================================================================
local Flags = {
    -- Telemetry & Visuals
    Fullbright = false,
    PotatoMode = false,
    RemoveFog = false,
    CustomFOV = 70,

    -- Receptionist
    AutoReceptionist = false,
    AutoNudgeToDesk = true,
    AutoSkipDialogue = true,
    AutoTurnPages = false,
    ReceptionDelay = 0.5,

    -- Cleaning & Chores
    AutoCleanTrash = false,
    AutoEquipCleaningTools = true,
    AutoSolveWires = false,
    AutoClearObstacles = false,

    -- Heart Rate & Stress
    LockHeartRate = false,
    LockedBPM = 70,
    AutoDrinkEnergy = false,
    PanicThreshold = 110,
    MuteHeartbeat = false,
    RemovePanicEffects = false,

    -- CCTV
    RemoveVhsNoise = false,
    ClearNightVision = false,
    BlockJumpscare666 = false,

    -- Combat & Defense
    AutoRevolverAimbot = false,
    AutoMeleeAura = false,
    MeleeAuraDistance = 15,

    -- Story & Shifts
    AutoProgressStory = false,
    AutoSkipStoryDialogue = false,

    -- Movement
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    SmoothFly = false,
    FlySpeed = 50,
    Noclip = false,

    -- ESP
    ESPAnomaly = true,
    ESPHuman = true,
    ESPObstacle = true,
    ESPTrash = true,
    ESPTracer = false,
}

local TeleportLocations = {
    ["Meja Resepsionis"] = Vector3.new(-12, 4, 35),
    ["Ruang CCTV Keamanan"] = Vector3.new(-38, 4, 60),
    ["Dapur Restoran"] = Vector3.new(42, 4, 45),
    ["Kamar 101"] = Vector3.new(-65, 4, 15),
    ["Kamar 102"] = Vector3.new(-65, 4, -15),
    ["Kamar 103"] = Vector3.new(65, 4, 15),
    ["Kamar 104"] = Vector3.new(65, 4, -15),
    ["Basement & Generator"] = Vector3.new(0, -18, -40),
    ["Pintu Masuk Utama"] = Vector3.new(0, 4, 90),
}
''')

# SECTION 4: KINGRUA UI WITH NATIVE IMAGE ASSET IDS & INDICATOR
add(r'''
-- ========================================================================================
-- 5. KINGRUA UI LIBRARY INTEGRATION (With Native PinatHub Image Labels & Lucide Asset IDs)
-- ========================================================================================
local KingRua = {}
do
    local CoreGui = game:GetService("CoreGui")
    local gethui = gethui or function() return CoreGui end

    local TabIcons = {
        ["Analytics"]     = "rbxassetid://10709770317", -- Bar Chart 2
        ["Resepsionis"]   = "rbxassetid://10709783474", -- Clipboard Check
        ["Kebersihan"]    = "rbxassetid://10747372167", -- Sparkles / Clean
        ["Detak Jantung"] = "rbxassetid://10723406885", -- Heart / Pulse
        ["CCTV"]          = "rbxassetid://10747374938", -- Video / Camera
        ["Pertahanan"]    = "rbxassetid://10709818534", -- Crosshair / Combat
        ["Alur Cerita"]   = "rbxassetid://10723387563", -- Calendar / Folder
        ["Inventaris"]    = "rbxassetid://10709769841", -- Backpack / Equipment
        ["Kehidupan"]     = "rbxassetid://7733920644",  -- Zap / Life
        ["Visual ESP"]    = "rbxassetid://10723346959", -- Eye / ESP Vision
        ["Pergerakan"]    = "rbxassetid://7734020989",  -- Navigation / Waypoint
        ["Pengaturan"]    = "rbxassetid://10734950309", -- Settings / Cog

        ["bar-chart-2"]     = "rbxassetid://10709770317",
        ["clipboard-check"] = "rbxassetid://10709783474",
        ["sparkles"]        = "rbxassetid://10747372167",
        ["heart"]           = "rbxassetid://10723406885",
        ["video"]           = "rbxassetid://10747374938",
        ["camera"]          = "rbxassetid://10747374938",
        ["crosshair"]       = "rbxassetid://10709818534",
        ["target"]          = "rbxassetid://10709818534",
        ["calendar"]        = "rbxassetid://10723387563",
        ["folder"]          = "rbxassetid://10723387563",
        ["backpack"]        = "rbxassetid://10709769841",
        ["zap"]             = "rbxassetid://7733920644",
        ["eye"]             = "rbxassetid://10723346959",
        ["navigation"]      = "rbxassetid://7734020989",
        ["settings"]        = "rbxassetid://10734950309",
    }

    local function ResolveIcon(iconInput, fallbackTitle)
        if type(iconInput) == "string" and iconInput ~= "" then
            if string.sub(iconInput, 1, 13) == "rbxassetid://" or string.sub(iconInput, 1, 10) == "rbxasset://" or string.sub(iconInput, 1, 4) == "http" then
                return iconInput
            end
            if TabIcons[iconInput] then
                return TabIcons[iconInput]
            end
            local lower = string.lower(iconInput)
            if TabIcons[lower] then
                return TabIcons[lower]
            end
        end
        if fallbackTitle and TabIcons[fallbackTitle] then
            return TabIcons[fallbackTitle]
        end
        return "rbxassetid://10734950309"
    end

    function KingRua:CreateWindow(cfg)
        cfg = cfg or {}
        local titleText = cfg.Title or "PinatHub"
        local subTitleText = cfg.SubTitle or "Hotel Anomaly v2.0"

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PinatHub_AnomalyHotel_GUI"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.DisplayOrder = 9999
        pcall(function() ScreenGui.Parent = gethui() end)
        if not ScreenGui.Parent then ScreenGui.Parent = CoreGui end

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.fromOffset(720, 480)
        MainFrame.Position = UDim2.new(0.5, -360, 0.5, -240)
        MainFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 10)
        MainCorner.Parent = MainFrame

        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = Color3.fromRGB(45, 50, 70)
        MainStroke.Thickness = 1.5
        MainStroke.Parent = MainFrame

        -- Dragging logic
        local dragging, dragInput, dragStart, startPos
        MainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        MainFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        -- Top Bar
        local TopBar = Instance.new("Frame")
        TopBar.Name = "TopBar"
        TopBar.Size = UDim2.new(1, 0, 0, 48)
        TopBar.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
        TopBar.BorderSizePixel = 0
        TopBar.Parent = MainFrame

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Text = titleText .. "  <font color='#508cff'>" .. subTitleText .. "</font>"
        TitleLabel.RichText = true
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextSize = 16
        TitleLabel.TextColor3 = Color3.fromRGB(240, 242, 255)
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Size = UDim2.new(1, -120, 1, 0)
        TitleLabel.Position = UDim2.new(0, 16, 0, 0)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Parent = TopBar

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.fromOffset(28, 28)
        CloseBtn.Position = UDim2.new(1, -38, 0.5, -14)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(215, 65, 65)
        CloseBtn.Text = "X"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.TextSize = 13
        CloseBtn.BorderSizePixel = 0
        CloseBtn.Parent = TopBar
        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 6)
        CloseCorner.Parent = CloseBtn
        CloseBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)

        local MinBtn = Instance.new("TextButton")
        MinBtn.Size = UDim2.fromOffset(28, 28)
        MinBtn.Position = UDim2.new(1, -72, 0.5, -14)
        MinBtn.BackgroundColor3 = Color3.fromRGB(45, 50, 68)
        MinBtn.Text = "-"
        MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinBtn.Font = Enum.Font.GothamBold
        MinBtn.TextSize = 15
        MinBtn.BorderSizePixel = 0
        MinBtn.Parent = TopBar
        local MinCorner = Instance.new("UICorner")
        MinCorner.CornerRadius = UDim.new(0, 6)
        MinCorner.Parent = MinBtn
        MinBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)

        -- Sidebar (Tabs)
        local Sidebar = Instance.new("ScrollingFrame")
        Sidebar.Name = "Sidebar"
        Sidebar.Size = UDim2.new(0, 175, 1, -48)
        Sidebar.Position = UDim2.new(0, 0, 0, 48)
        Sidebar.BackgroundColor3 = Color3.fromRGB(19, 21, 30)
        Sidebar.BorderSizePixel = 0
        Sidebar.ScrollBarThickness = 2
        Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
        Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Sidebar.Parent = MainFrame

        local SidebarLayout = Instance.new("UIListLayout")
        SidebarLayout.Padding = UDim.new(0, 3)
        SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        SidebarLayout.Parent = Sidebar
        local SidebarPad = Instance.new("UIPadding")
        SidebarPad.PaddingTop = UDim.new(0, 8)
        SidebarPad.PaddingBottom = UDim.new(0, 8)
        SidebarPad.Parent = Sidebar

        -- Content Container
        local ContentContainer = Instance.new("Frame")
        ContentContainer.Name = "ContentContainer"
        ContentContainer.Size = UDim2.new(1, -175, 1, -48)
        ContentContainer.Position = UDim2.new(0, 175, 0, 48)
        ContentContainer.BackgroundColor3 = Color3.fromRGB(14, 15, 22)
        ContentContainer.BorderSizePixel = 0
        ContentContainer.Parent = MainFrame

        local WindowObj = {
            Tabs = {},
            ActiveTab = nil,
            ScreenGui = ScreenGui,
            MainFrame = MainFrame,
        }

        function WindowObj:SelectTab(idx)
            for i, tab in ipairs(self.Tabs) do
                if i == idx then
                    tab.Page.Visible = true
                    tab.Button.BackgroundColor3 = Color3.fromRGB(36, 42, 65)
                    tab.IconImage.ImageColor3 = Color3.fromRGB(120, 180, 255)
                    tab.Label.TextColor3 = Color3.fromRGB(240, 245, 255)
                    tab.Indicator.Visible = true
                    self.ActiveTab = tab
                else
                    tab.Page.Visible = false
                    tab.Button.BackgroundColor3 = Color3.fromRGB(24, 26, 38)
                    tab.IconImage.ImageColor3 = Color3.fromRGB(150, 155, 175)
                    tab.Label.TextColor3 = Color3.fromRGB(170, 175, 195)
                    tab.Indicator.Visible = false
                end
            end
        end

        function WindowObj:CreateTab(tcfg)
            tcfg = tcfg or {}
            local tabTitle = tcfg.Title or "Tab"
            local tabIcon = ResolveIcon(tcfg.Icon, tabTitle)

            local TabBtn = Instance.new("TextButton")
            TabBtn.Size = UDim2.new(1, -12, 0, 32)
            TabBtn.BackgroundColor3 = Color3.fromRGB(24, 26, 38)
            TabBtn.Text = ""
            TabBtn.BorderSizePixel = 0
            TabBtn.Parent = Sidebar

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = TabBtn

            -- PinatHub Left Accent Indicator Bar
            local ActiveIndicator = Instance.new("Frame")
            ActiveIndicator.Name = "ActiveIndicator"
            ActiveIndicator.Parent = TabBtn
            ActiveIndicator.AnchorPoint = Vector2.new(0, 0.5)
            ActiveIndicator.Position = UDim2.new(0, 2, 0.5, 0)
            ActiveIndicator.Size = UDim2.new(0, 3, 0.62, 0)
            ActiveIndicator.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
            ActiveIndicator.BorderSizePixel = 0
            ActiveIndicator.Visible = false

            local IndCorner = Instance.new("UICorner")
            IndCorner.CornerRadius = UDim.new(1, 0)
            IndCorner.Parent = ActiveIndicator

            -- PinatHub Image Icon (Zero Emojis)
            local IconImage = Instance.new("ImageLabel")
            IconImage.Name = "Icon"
            IconImage.Parent = TabBtn
            IconImage.AnchorPoint = Vector2.new(0, 0.5)
            IconImage.Position = UDim2.new(0, 10, 0.5, 0)
            IconImage.Size = UDim2.fromOffset(15, 15)
            IconImage.BackgroundTransparency = 1
            IconImage.Image = tabIcon
            IconImage.ImageColor3 = Color3.fromRGB(150, 155, 175)
            IconImage.ScaleType = Enum.ScaleType.Fit

            -- PinatHub Tab Label
            local TabLabel = Instance.new("TextLabel")
            TabLabel.Name = "Label"
            TabLabel.Parent = TabBtn
            TabLabel.BackgroundTransparency = 1
            TabLabel.Position = UDim2.new(0, 32, 0, 0)
            TabLabel.Size = UDim2.new(1, -36, 1, 0)
            TabLabel.Font = Enum.Font.GothamMedium
            TabLabel.Text = tabTitle
            TabLabel.TextColor3 = Color3.fromRGB(170, 175, 195)
            TabLabel.TextSize = 12
            TabLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Page = Instance.new("ScrollingFrame")
            Page.Name = "Page_" .. tabTitle
            Page.Size = UDim2.new(1, 0, 1, 0)
            Page.BackgroundTransparency = 1
            Page.BorderSizePixel = 0
            Page.ScrollBarThickness = 4
            Page.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 100)
            Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
            Page.Visible = false
            Page.Parent = ContentContainer

            local PageLayout = Instance.new("UIListLayout")
            PageLayout.Padding = UDim.new(0, 8)
            PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            PageLayout.Parent = Page

            local PagePad = Instance.new("UIPadding")
            PagePad.PaddingTop = UDim.new(0, 10)
            PagePad.PaddingBottom = UDim.new(0, 14)
            PagePad.PaddingLeft = UDim.new(0, 12)
            PagePad.PaddingRight = UDim.new(0, 12)
            PagePad.Parent = Page

            local TabObj = {
                Button = TabBtn,
                IconImage = IconImage,
                Label = TabLabel,
                Indicator = ActiveIndicator,
                Page = Page,
                Title = tabTitle,
            }

            local function activateTab()
                for _, t in ipairs(WindowObj.Tabs) do
                    t.Page.Visible = false
                    t.Button.BackgroundColor3 = Color3.fromRGB(24, 26, 38)
                    t.IconImage.ImageColor3 = Color3.fromRGB(150, 155, 175)
                    t.Label.TextColor3 = Color3.fromRGB(170, 175, 195)
                    t.Indicator.Visible = false
                end
                Page.Visible = true
                TabBtn.BackgroundColor3 = Color3.fromRGB(36, 42, 65)
                IconImage.ImageColor3 = Color3.fromRGB(120, 180, 255)
                TabLabel.TextColor3 = Color3.fromRGB(240, 245, 255)
                ActiveIndicator.Visible = true
                WindowObj.ActiveTab = TabObj
            end

            TabBtn.MouseButton1Click:Connect(activateTab)

            -- SECTION BUILDER
            function TabObj:AddSection(sTitle)
                local SecFrame = Instance.new("Frame")
                SecFrame.Size = UDim2.new(1, -4, 0, 28)
                SecFrame.BackgroundTransparency = 1
                SecFrame.Parent = Page

                local SecLabel = Instance.new("TextLabel")
                SecLabel.Text = string.upper(sTitle)
                SecLabel.Font = Enum.Font.GothamBold
                SecLabel.TextSize = 12
                SecLabel.TextColor3 = Color3.fromRGB(90, 150, 255)
                SecLabel.TextXAlignment = Enum.TextXAlignment.Left
                SecLabel.Size = UDim2.new(1, 0, 1, 0)
                SecLabel.BackgroundTransparency = 1
                SecLabel.Parent = SecFrame

                local SecObj = {}
                function SecObj:AddToggle(ocfg) return TabObj:AddToggle(ocfg, SecFrame) end
                function SecObj:AddSlider(ocfg) return TabObj:AddSlider(ocfg, SecFrame) end
                function SecObj:AddButton(ocfg) return TabObj:AddButton(ocfg, SecFrame) end
                function SecObj:AddDropdown(ocfg) return TabObj:AddDropdown(ocfg, SecFrame) end
                function SecObj:AddParagraph(ocfg) return TabObj:AddParagraph(ocfg, SecFrame) end
                function SecObj:AddProgressBar(ocfg) return TabObj:AddProgressBar(ocfg, SecFrame) end
                function SecObj:AddGraph(ocfg) return TabObj:AddGraph(ocfg, SecFrame) end
                return SecObj
            end

            -- TOGGLE
            function TabObj:AddToggle(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Toggle"
                local state = ocfg.Default == true
                local callback = ocfg.Callback or function() end

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, 40)
                Card.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
                Card.BorderSizePixel = 0
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Lbl = Instance.new("TextLabel")
                Lbl.Text = title
                Lbl.Font = Enum.Font.GothamMedium
                Lbl.TextSize = 13
                Lbl.TextColor3 = Color3.fromRGB(225, 230, 245)
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Size = UDim2.new(1, -60, 1, 0)
                Lbl.Position = UDim2.new(0, 12, 0, 0)
                Lbl.BackgroundTransparency = 1
                Lbl.Parent = Card

                local Switch = Instance.new("TextButton")
                Switch.Size = UDim2.fromOffset(44, 22)
                Switch.Position = UDim2.new(1, -54, 0.5, -11)
                Switch.BackgroundColor3 = state and Color3.fromRGB(60, 130, 255) or Color3.fromRGB(40, 44, 60)
                Switch.Text = ""
                Switch.BorderSizePixel = 0
                Switch.Parent = Card

                local SwitchCorner = Instance.new("UICorner")
                SwitchCorner.CornerRadius = UDim.new(0, 11)
                SwitchCorner.Parent = Switch

                local Dot = Instance.new("Frame")
                Dot.Size = UDim2.fromOffset(16, 16)
                Dot.Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dot.BorderSizePixel = 0
                Dot.Parent = Switch
                local DotCorner = Instance.new("UICorner")
                DotCorner.CornerRadius = UDim.new(0, 8)
                DotCorner.Parent = Dot

                local function setVal(v)
                    state = v
                    TweenService:Create(Switch, TweenInfo.new(0.2), {
                        BackgroundColor3 = state and Color3.fromRGB(60, 130, 255) or Color3.fromRGB(40, 44, 60)
                    }):Play()
                    TweenService:Create(Dot, TweenInfo.new(0.2), {
                        Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                    }):Play()
                    task.spawn(callback, state)
                end

                Switch.MouseButton1Click:Connect(function()
                    setVal(not state)
                end)

                return {
                    Set = setVal,
                    Get = function() return state end
                }
            end

            -- SLIDER
            function TabObj:AddSlider(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Slider"
                local minVal = ocfg.Min or 0
                local maxVal = ocfg.Max or 100
                local curVal = ocfg.Default or minVal
                local callback = ocfg.Callback or function() end

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, 48)
                Card.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
                Card.BorderSizePixel = 0
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Lbl = Instance.new("TextLabel")
                Lbl.Text = title
                Lbl.Font = Enum.Font.GothamMedium
                Lbl.TextSize = 13
                Lbl.TextColor3 = Color3.fromRGB(225, 230, 245)
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Size = UDim2.new(1, -70, 0, 22)
                Lbl.Position = UDim2.new(0, 12, 0, 4)
                Lbl.BackgroundTransparency = 1
                Lbl.Parent = Card

                local ValLbl = Instance.new("TextLabel")
                ValLbl.Text = tostring(curVal)
                ValLbl.Font = Enum.Font.GothamBold
                ValLbl.TextSize = 13
                ValLbl.TextColor3 = Color3.fromRGB(120, 180, 255)
                ValLbl.TextXAlignment = Enum.TextXAlignment.Right
                ValLbl.Size = UDim2.new(0, 50, 0, 22)
                ValLbl.Position = UDim2.new(1, -62, 0, 4)
                ValLbl.BackgroundTransparency = 1
                ValLbl.Parent = Card

                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, -24, 0, 8)
                SliderBar.Position = UDim2.new(0, 12, 0, 32)
                SliderBar.BackgroundColor3 = Color3.fromRGB(40, 44, 60)
                SliderBar.BorderSizePixel = 0
                SliderBar.Parent = Card
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 4)
                BarCorner.Parent = SliderBar

                local Fill = Instance.new("Frame")
                local pct = math.clamp((curVal - minVal) / math.max(1, (maxVal - minVal)), 0, 1)
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                Fill.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
                Fill.BorderSizePixel = 0
                Fill.Parent = SliderBar
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(0, 4)
                FillCorner.Parent = Fill

                local sliding = false
                local function updateSlide(input)
                    local barPos = SliderBar.AbsolutePosition.X
                    local barSize = SliderBar.AbsoluteSize.X
                    local rel = math.clamp((input.Position.X - barPos) / barSize, 0, 1)
                    local v = math.floor(minVal + rel * (maxVal - minVal))
                    curVal = v
                    ValLbl.Text = tostring(v)
                    Fill.Size = UDim2.new(rel, 0, 1, 0)
                    task.spawn(callback, v)
                end

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        sliding = true
                        updateSlide(input)
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        sliding = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        updateSlide(input)
                    end
                end)

                return {
                    Set = function(v)
                        curVal = math.clamp(v, minVal, maxVal)
                        ValLbl.Text = tostring(curVal)
                        local r = math.clamp((curVal - minVal) / math.max(1, (maxVal - minVal)), 0, 1)
                        Fill.Size = UDim2.new(r, 0, 1, 0)
                        task.spawn(callback, curVal)
                    end
                }
            end

            -- BUTTON
            function TabObj:AddButton(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Button"
                local desc = ocfg.Desc or ""
                local callback = ocfg.Callback or function() end

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, desc ~= "" and 48 or 38)
                Card.BackgroundColor3 = Color3.fromRGB(24, 27, 40)
                Card.BorderSizePixel = 0
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Btn = Instance.new("TextButton")
                Btn.Size = UDim2.fromScale(1, 1)
                Btn.BackgroundTransparency = 1
                Btn.Text = ""
                Btn.Parent = Card

                local Lbl = Instance.new("TextLabel")
                Lbl.Text = title
                Lbl.Font = Enum.Font.GothamBold
                Lbl.TextSize = 13
                Lbl.TextColor3 = Color3.fromRGB(235, 240, 255)
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Size = UDim2.new(1, -40, 0, 20)
                Lbl.Position = UDim2.new(0, 12, 0, desc ~= "" and 6 or 9)
                Lbl.BackgroundTransparency = 1
                Lbl.Parent = Card

                if desc ~= "" then
                    local DescLbl = Instance.new("TextLabel")
                    DescLbl.Text = desc
                    DescLbl.Font = Enum.Font.Gotham
                    DescLbl.TextSize = 11
                    DescLbl.TextColor3 = Color3.fromRGB(150, 155, 175)
                    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
                    DescLbl.Size = UDim2.new(1, -40, 0, 16)
                    DescLbl.Position = UDim2.new(0, 12, 0, 26)
                    DescLbl.BackgroundTransparency = 1
                    DescLbl.Parent = Card
                end

                local Arrow = Instance.new("TextLabel")
                Arrow.Text = ">"
                Arrow.Font = Enum.Font.GothamBold
                Arrow.TextSize = 14
                Arrow.TextColor3 = Color3.fromRGB(80, 140, 255)
                Arrow.Size = UDim2.fromOffset(24, 24)
                Arrow.Position = UDim2.new(1, -30, 0.5, -12)
                Arrow.BackgroundTransparency = 1
                Arrow.Parent = Card

                Btn.MouseButton1Click:Connect(function()
                    TweenService:Create(Card, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(45, 55, 80)}):Play()
                    task.delay(0.1, function()
                        TweenService:Create(Card, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 27, 40)}):Play()
                    end)
                    task.spawn(callback)
                end)

                return Btn
            end

            -- DROPDOWN
            function TabObj:AddDropdown(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Dropdown"
                local options = ocfg.Options or {}
                local default = ocfg.Default or (options[1] or "")
                local callback = ocfg.Callback or function() end
                local isOpen = false

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, 42)
                Card.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
                Card.BorderSizePixel = 0
                Card.ClipsDescendants = true
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Lbl = Instance.new("TextLabel")
                Lbl.Text = title
                Lbl.Font = Enum.Font.GothamMedium
                Lbl.TextSize = 13
                Lbl.TextColor3 = Color3.fromRGB(225, 230, 245)
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Size = UDim2.new(0.5, 0, 0, 42)
                Lbl.Position = UDim2.new(0, 12, 0, 0)
                Lbl.BackgroundTransparency = 1
                Lbl.Parent = Card

                local SelBtn = Instance.new("TextButton")
                SelBtn.Size = UDim2.new(0.45, 0, 0, 28)
                SelBtn.Position = UDim2.new(0.52, 0, 0, 7)
                SelBtn.BackgroundColor3 = Color3.fromRGB(34, 38, 54)
                SelBtn.Text = tostring(default) .. "  v"
                SelBtn.Font = Enum.Font.GothamBold
                SelBtn.TextSize = 12
                SelBtn.TextColor3 = Color3.fromRGB(120, 180, 255)
                SelBtn.BorderSizePixel = 0
                SelBtn.Parent = Card
                local SelCorner = Instance.new("UICorner")
                SelCorner.CornerRadius = UDim.new(0, 4)
                SelCorner.Parent = SelBtn

                local DropList = Instance.new("Frame")
                DropList.Size = UDim2.new(1, -24, 0, #options * 26)
                DropList.Position = UDim2.new(0, 12, 0, 44)
                DropList.BackgroundTransparency = 1
                DropList.Parent = Card

                local DropLayout = Instance.new("UIListLayout")
                DropLayout.Padding = UDim.new(0, 2)
                DropLayout.Parent = DropList

                for _, opt in ipairs(options) do
                    local OptBtn = Instance.new("TextButton")
                    OptBtn.Size = UDim2.new(1, 0, 0, 24)
                    OptBtn.BackgroundColor3 = Color3.fromRGB(28, 31, 46)
                    OptBtn.Text = tostring(opt)
                    OptBtn.Font = Enum.Font.Gotham
                    OptBtn.TextSize = 12
                    OptBtn.TextColor3 = Color3.fromRGB(200, 205, 225)
                    OptBtn.BorderSizePixel = 0
                    OptBtn.Parent = DropList
                    local OptCorner = Instance.new("UICorner")
                    OptCorner.CornerRadius = UDim.new(0, 4)
                    OptCorner.Parent = OptBtn

                    OptBtn.MouseButton1Click:Connect(function()
                        SelBtn.Text = tostring(opt) .. "  v"
                        isOpen = false
                        Card.Size = UDim2.new(1, -4, 0, 42)
                        task.spawn(callback, opt)
                    end)
                end

                SelBtn.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    if isOpen then
                        Card.Size = UDim2.new(1, -4, 0, 48 + (#options * 26))
                    else
                        Card.Size = UDim2.new(1, -4, 0, 42)
                    end
                end)

                return {
                    Set = function(v)
                        SelBtn.Text = tostring(v) .. "  v"
                        task.spawn(callback, v)
                    end
                }
            end

            -- PARAGRAPH / TELEMETRY CARD
            function TabObj:AddParagraph(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Info"
                local content = ocfg.Content or ocfg.Desc or "Data"

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, 72)
                Card.BackgroundColor3 = Color3.fromRGB(20, 22, 32)
                Card.BorderSizePixel = 0
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Stroke = Instance.new("UIStroke")
                Stroke.Color = Color3.fromRGB(38, 42, 60)
                Stroke.Thickness = 1
                Stroke.Parent = Card

                local TitleLbl = Instance.new("TextLabel")
                TitleLbl.Text = title
                TitleLbl.Font = Enum.Font.GothamBold
                TitleLbl.TextSize = 13
                TitleLbl.TextColor3 = Color3.fromRGB(90, 160, 255)
                TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
                TitleLbl.Size = UDim2.new(1, -24, 0, 20)
                TitleLbl.Position = UDim2.new(0, 12, 0, 8)
                TitleLbl.BackgroundTransparency = 1
                TitleLbl.Parent = Card

                local ContentLbl = Instance.new("TextLabel")
                ContentLbl.Text = content
                ContentLbl.Font = Enum.Font.Gotham
                ContentLbl.TextSize = 11
                ContentLbl.TextColor3 = Color3.fromRGB(200, 205, 225)
                ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
                ContentLbl.TextYAlignment = Enum.TextYAlignment.Top
                ContentLbl.Size = UDim2.new(1, -24, 1, -34)
                ContentLbl.Position = UDim2.new(0, 12, 0, 30)
                ContentLbl.BackgroundTransparency = 1
                ContentLbl.TextWrapped = true
                ContentLbl.Parent = Card

                local CardApi = {}
                function CardApi:SetTitle(t) TitleLbl.Text = tostring(t or "") end
                function CardApi:SetDesc(d) ContentLbl.Text = tostring(d or "") end
                function CardApi:SetContent(c) ContentLbl.Text = tostring(c or "") end
                function CardApi:Set(t, c)
                    if t then TitleLbl.Text = tostring(t) end
                    if c then ContentLbl.Text = tostring(c) end
                end
                return CardApi
            end

            -- PROGRESS BAR
            function TabObj:AddProgressBar(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Progress"
                local curVal = ocfg.Default or 0
                local maxVal = ocfg.Max or 100
                local barColor = ocfg.Color or Color3.fromRGB(60, 140, 255)

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, 48)
                Card.BackgroundColor3 = Color3.fromRGB(20, 22, 32)
                Card.BorderSizePixel = 0
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Lbl = Instance.new("TextLabel")
                Lbl.Text = title
                Lbl.Font = Enum.Font.GothamMedium
                Lbl.TextSize = 12
                Lbl.TextColor3 = Color3.fromRGB(210, 215, 235)
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Size = UDim2.new(1, -70, 0, 18)
                Lbl.Position = UDim2.new(0, 12, 0, 6)
                Lbl.BackgroundTransparency = 1
                Lbl.Parent = Card

                local ValLbl = Instance.new("TextLabel")
                ValLbl.Text = tostring(curVal) .. " / " .. tostring(maxVal)
                ValLbl.Font = Enum.Font.GothamBold
                ValLbl.TextSize = 12
                ValLbl.TextColor3 = barColor
                ValLbl.TextXAlignment = Enum.TextXAlignment.Right
                ValLbl.Size = UDim2.new(0, 70, 0, 18)
                ValLbl.Position = UDim2.new(1, -82, 0, 6)
                ValLbl.BackgroundTransparency = 1
                ValLbl.Parent = Card

                local Bar = Instance.new("Frame")
                Bar.Size = UDim2.new(1, -24, 0, 8)
                Bar.Position = UDim2.new(0, 12, 0, 30)
                Bar.BackgroundColor3 = Color3.fromRGB(36, 40, 56)
                Bar.BorderSizePixel = 0
                Bar.Parent = Card
                local BarCorn = Instance.new("UICorner")
                BarCorn.CornerRadius = UDim.new(0, 4)
                BarCorn.Parent = Bar

                local Fill = Instance.new("Frame")
                local pct = math.clamp(curVal / math.max(1, maxVal), 0, 1)
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                Fill.BackgroundColor3 = barColor
                Fill.BorderSizePixel = 0
                Fill.Parent = Bar
                local FillCorn = Instance.new("UICorner")
                FillCorn.CornerRadius = UDim.new(0, 4)
                FillCorn.Parent = Fill

                return {
                    Set = function(v, m)
                        if m then maxVal = m end
                        curVal = math.clamp(v or 0, 0, maxVal)
                        ValLbl.Text = tostring(curVal) .. " / " .. tostring(maxVal)
                        local p = math.clamp(curVal / math.max(1, maxVal), 0, 1)
                        TweenService:Create(Fill, TweenInfo.new(0.2), {Size = UDim2.new(p, 0, 1, 0)}):Play()
                    end
                }
            end

            -- DYNAMIC LIVE GRAPH
            function TabObj:AddGraph(ocfg, parentFrame)
                ocfg = ocfg or {}
                local title = ocfg.Title or "Live Graph"
                local height = ocfg.Height or 80
                local minVal = ocfg.Min or 0
                local maxVal = ocfg.Max or 180
                local lineCol = ocfg.Color or Color3.fromRGB(60, 180, 255)
                local dataHistory = {}
                local maxSamples = 28

                for i = 1, maxSamples do
                    table.insert(dataHistory, minVal)
                end

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -4, 0, height + 36)
                Card.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
                Card.BorderSizePixel = 0
                Card.Parent = parentFrame or Page

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 6)
                Corner.Parent = Card

                local Stroke = Instance.new("UIStroke")
                Stroke.Color = Color3.fromRGB(36, 40, 56)
                Stroke.Thickness = 1
                Stroke.Parent = Card

                local Lbl = Instance.new("TextLabel")
                Lbl.Text = title
                Lbl.Font = Enum.Font.GothamBold
                Lbl.TextSize = 12
                Lbl.TextColor3 = Color3.fromRGB(220, 225, 245)
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.Size = UDim2.new(1, -70, 0, 20)
                Lbl.Position = UDim2.new(0, 10, 0, 4)
                Lbl.BackgroundTransparency = 1
                Lbl.Parent = Card

                local ValLbl = Instance.new("TextLabel")
                ValLbl.Text = tostring(minVal)
                ValLbl.Font = Enum.Font.GothamBold
                ValLbl.TextSize = 13
                ValLbl.TextColor3 = lineCol
                ValLbl.TextXAlignment = Enum.TextXAlignment.Right
                ValLbl.Size = UDim2.new(0, 60, 0, 20)
                ValLbl.Position = UDim2.new(1, -70, 0, 4)
                ValLbl.BackgroundTransparency = 1
                ValLbl.Parent = Card

                local GraphArea = Instance.new("Frame")
                GraphArea.Size = UDim2.new(1, -20, 0, height)
                GraphArea.Position = UDim2.new(0, 10, 0, 28)
                GraphArea.BackgroundColor3 = Color3.fromRGB(12, 13, 19)
                GraphArea.BorderSizePixel = 0
                GraphArea.ClipsDescendants = true
                GraphArea.Parent = Card

                local GraphCorn = Instance.new("UICorner")
                GraphCorn.CornerRadius = UDim.new(0, 4)
                GraphCorn.Parent = GraphArea

                local bars = {}
                for i = 1, maxSamples do
                    local bar = Instance.new("Frame")
                    local stepW = 1 / maxSamples
                    bar.Size = UDim2.new(stepW, -1, 0.1, 0)
                    bar.Position = UDim2.new((i - 1) * stepW, 0, 0.9, 0)
                    bar.BackgroundColor3 = lineCol
                    bar.BorderSizePixel = 0
                    bar.Parent = GraphArea
                    table.insert(bars, bar)
                end

                local GraphApi = {}
                function GraphApi:Push(val)
                    val = tonumber(val) or minVal
                    ValLbl.Text = string.format("%.1f", val)
                    table.remove(dataHistory, 1)
                    table.insert(dataHistory, val)

                    for i, v in ipairs(dataHistory) do
                        local bar = bars[i]
                        if bar then
                            local norm = math.clamp((v - minVal) / math.max(1, (maxVal - minVal)), 0.05, 1)
                            bar.Size = UDim2.new(bar.Size.X.Scale, bar.Size.X.Offset, norm, 0)
                            bar.Position = UDim2.new(bar.Position.X.Scale, bar.Position.X.Offset, 1 - norm, 0)
                        end
                    end
                end

                function GraphApi:SetTitle(t) Lbl.Text = tostring(t or "") end
                return GraphApi
            end

            table.insert(WindowObj.Tabs, TabObj)
            return TabObj
        end

        return WindowObj
    end
end
''')

# SECTION 5: DEFENSIVE TELEMETRY ENGINE
add(r'''
-- ========================================================================================
-- 6. DEFENSIVE TELEMETRY ENGINE (Zero Nil, Zero Error, Zero 0/nil Guaranteed)
-- ========================================================================================
local function GetCurrentHeartRate()
    if HeartRateSlice and HeartRateSlice.useHeartRate then
        local s, v = pcall(function() return HeartRateSlice.useHeartRate() end)
        if s and type(v) == "number" and v > 0 then return v end
    end
    if HeartRateSlice and HeartRateSlice.getHeartRate then
        local s, v = pcall(function() return HeartRateSlice.getHeartRate() end)
        if s and type(v) == "number" and v > 0 then return v end
    end
    if LocalPlayer then
        local attr = LocalPlayer:GetAttribute("HeartRate")
        if type(attr) == "number" and attr > 0 then return attr end
    end
    return 72
end

local function GetMaxHeartRate()
    if HeartRateSlice and HeartRateSlice.getMaxHeartRate then
        local s, v = pcall(function() return HeartRateSlice.getMaxHeartRate() end)
        if s and type(v) == "number" and v > 0 then return v end
    end
    if LocalPlayer then
        local attr = LocalPlayer:GetAttribute("MaxHeartRate")
        if type(attr) == "number" and attr > 0 then return attr end
    end
    return 160
end

local function GetCurrentStoryDay()
    if DaySlice and DaySlice.getCurrentDay then
        local s, v = pcall(function() return DaySlice.getCurrentDay() end)
        if s and type(v) == "number" and v > 0 then return v end
    end
    local wsDay = Workspace:GetAttribute("CurrentStoryDay") or Workspace:GetAttribute("StoryDay")
    if type(wsDay) == "number" and wsDay > 0 then return wsDay end
    return 1
end

local function FindReceptionComputer()
    local path = {"Map", "Lobby", "receiptionis", "Resepsionis", "Computer", "Part"}
    local cur = Workspace
    for _, seg in ipairs(path) do
        cur = cur and cur:FindFirstChild(seg)
        if not cur then break end
    end
    if cur and cur:IsA("BasePart") then return cur end
    local interaction = Workspace:FindFirstChild("InteractionObject")
    if interaction then
        local comp = interaction:FindFirstChild("Computer") or interaction:FindFirstChild("Resepsionis")
        if comp and comp:IsA("BasePart") then return comp end
    end
    for _, d in ipairs(Workspace:GetDescendants()) do
        if d:IsA("BasePart") and (d.Name == "Computer" or d.Name == "ResepsionisPart") then
            return d
        end
    end
    return nil
end

local function FindCurrentGuestNPC()
    local comp = FindReceptionComputer()
    local checkPos = comp and comp.Position or Vector3.new(-12, 4, 35)

    local bestNpc, bestDist = nil, 28
    for _, item in ipairs(Workspace:GetChildren()) do
        if item:IsA("Model") and item:FindFirstChildOfClass("Humanoid") and item ~= Character then
            local root = item:FindFirstChild("HumanoidRootPart") or item.PrimaryPart or item:FindFirstChild("Head")
            if root then
                local dist = (root.Position - checkPos).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestNpc = item
                end
            end
        end
    end
    return bestNpc
end

local function GetNearestAnomalyDistance()
    if not Root then return 999 end
    local minDist = 999
    for _, item in ipairs(Workspace:GetChildren()) do
        if item:IsA("Model") and item ~= Character then
            if item:GetAttribute("IsAnomaly") == true or item:GetAttribute("AnomalyType") ~= nil or string.find(item.Name, "Anomaly") then
                local part = item:FindFirstChild("HumanoidRootPart") or item.PrimaryPart or item:FindFirstChild("Head")
                if part then
                    local d = (part.Position - Root.Position).Magnitude
                    if d < minDist then
                        minDist = d
                    end
                end
            end
        end
    end
    return minDist
end

local function GetCleaningStatus()
    local totalTrash = 0
    local pcallOk, tagged = pcall(function() return CollectionService:GetTagged("ActiveCleaningTrash") end)
    if pcallOk and type(tagged) == "table" and #tagged > 0 then
        totalTrash = #tagged
    else
        for _, item in ipairs(Workspace:GetDescendants()) do
            if item:GetAttribute("IsSpawnedCleaningItem") == true and item.Parent then
                totalTrash = totalTrash + 1
            end
        end
    end
    return math.max(0, totalTrash)
end
''')

# SECTION 6: AUTOMATION SYSTEMS & GAME LOOPS (Fix fireproximityprompt argument count)
add(r'''
-- ========================================================================================
-- 7. NATIVE AUTOMATION SYSTEMS & GAME LOOPS
-- ========================================================================================

-- AUTO RECEPTIONIST LOOP
task.spawn(function()
    while true do
        task.wait(Flags.ReceptionDelay)
        if Flags.AutoReceptionist then
            pcall(function()
                local guest = FindCurrentGuestNPC()
                local comp = FindReceptionComputer()
                local deskPos = comp and comp.Position or Vector3.new(-12, 4, 35)

                if guest then
                    -- Nudge player close to reception desk so server proximity check passes
                    if Flags.AutoNudgeToDesk and Root and (Root.Position - deskPos).Magnitude > 18 then
                        Root.CFrame = CFrame.new(deskPos + Vector3.new(0, 3, 4))
                        task.wait(0.2)
                    end

                    local isAnomaly = guest:GetAttribute("IsAnomaly") == true
                    local cannotReject = guest:GetAttribute("CannotReject") == true

                    if isAnomaly and not cannotReject then
                        -- Reject Anomaly
                        local rem = GetRemote("ReceptionistActionEvent")
                        if rem then
                            rem:FireServer("Reject")
                        else
                            RequestAdminAction("skipCustomer")
                        end
                    else
                        -- Register Human Guest
                        local rem = GetRemote("ReceptionistActionEvent")
                        if rem then
                            rem:FireServer("Register")
                        end
                    end

                    -- Auto skip dialogue
                    if Flags.AutoSkipDialogue then
                        FireRemote("DialogSkipRequestEvent", true, guest:GetAttribute("DialogId"), 1)
                    end
                end
            end)
        end
    end
end)

-- AUTO CLEANING & TRASH CHORES
task.spawn(function()
    while true do
        task.wait(0.8)
        if Flags.AutoCleanTrash then
            pcall(function()
                local cleanedAny = false
                for _, desc in ipairs(Workspace:GetDescendants()) do
                    if desc:IsA("ProximityPrompt") and desc.Enabled then
                        local model = desc:FindFirstAncestorOfClass("Model") or desc.Parent
                        local isTrash = (model and model:GetAttribute("IsSpawnedCleaningItem") == true)
                            or string.find(string.lower(desc.ActionText), "bersihkan")
                            or string.find(string.lower(desc.ActionText), "ambil")
                            or string.find(string.lower(desc.ActionText), "sapu")
                            or string.find(string.lower(desc.ActionText), "pel")
                            or string.find(string.lower(desc.ObjectText), "sampah")

                        if isTrash and Root then
                            local promptPart = desc.Parent:IsA("BasePart") and desc.Parent or (model and (model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")))
                            if promptPart then
                                local promptName = string.lower(desc.Name)
                                local trashType = model and model:GetAttribute("TrashType") or ""
                                local needTool = nil

                                if trashType == "Dry" or string.find(promptName, "sapu") then
                                    needTool = "sapu"
                                elseif trashType == "Wet" or string.find(promptName, "pel") then
                                    needTool = "pel"
                                end

                                if needTool and LocalPlayer and LocalPlayer.Backpack then
                                    local tool = LocalPlayer.Backpack:FindFirstChild(needTool)
                                    if tool and Humanoid then
                                        Humanoid:EquipTool(tool)
                                        task.wait(0.15)
                                    end
                                end

                                -- Fix: Exactly 1 argument for fireproximityprompt
                                if fireproximityprompt then
                                    pcall(function()
                                        fireproximityprompt(desc)
                                    end)
                                elseif desc.InputHoldBegin then
                                    desc:InputHoldBegin()
                                    task.wait(desc.HoldDuration + 0.05)
                                    desc:InputHoldEnd()
                                end
                                cleanedAny = true
                            end
                        end
                    end
                end

                if not cleanedAny then
                    RequestAdminAction("cleanAllRooms")
                end
            end)
        end

        -- Auto Solve Wires
        if Flags.AutoSolveWires then
            pcall(function()
                FireRemote("WireConnectedEvent", 1)
                FireRemote("WireConnectedEvent", 2)
                FireRemote("WireConnectedEvent", 3)
                FireRemote("WireConnectedEvent", 4)
                FireRemote("WireSolveResultEvent", true)
            end)
        end

        -- Auto Clear Obstacles
        if Flags.AutoClearObstacles then
            pcall(function()
                RequestAdminAction("clearObstacles")
            end)
        end
    end
end)

-- HEART RATE LOCK & ENERGY DRINK STABILIZER
task.spawn(function()
    while true do
        task.wait(0.5)
        if Flags.LockHeartRate then
            pcall(function()
                if HeartRateSlice then
                    if HeartRateSlice.setHeartRate then
                        HeartRateSlice.setHeartRate(Flags.LockedBPM)
                    end
                    if HeartRateSlice.clearNotifications then
                        HeartRateSlice.clearNotifications()
                    end
                end
                if LocalPlayer then
                    LocalPlayer:SetAttribute("HeartRate", Flags.LockedBPM)
                end
                if NetworkerClients.Admin then
                    RequestAdminAction("setHeartRate", GetMyUserId(), Flags.LockedBPM)
                end
            end)
        end

        if Flags.AutoDrinkEnergy then
            pcall(function()
                local curBpm = GetCurrentHeartRate()
                if curBpm >= Flags.PanicThreshold then
                    if LocalPlayer and LocalPlayer.Backpack then
                        local drink = LocalPlayer.Backpack:FindFirstChild("energyDrink")
                        if drink and Humanoid then
                            Humanoid:EquipTool(drink)
                            task.wait(0.2)
                            if drink.Activate then drink:Activate() end
                        end
                    end
                end
            end)
        end

        if Flags.MuteHeartbeat then
            pcall(function()
                for _, s in ipairs(SoundService:GetDescendants()) do
                    if s:IsA("Sound") and (string.find(string.lower(s.Name), "heart") or string.find(string.lower(s.Name), "panic")) then
                        s.Volume = 0
                    end
                end
            end)
        end
    end
end)

-- COMBAT & ANOMALY DEFENSE
task.spawn(function()
    while true do
        task.wait(0.3)
        if Flags.AutoRevolverAimbot and Root then
            pcall(function()
                local nearestNpc, nearestDist = nil, 60
                for _, item in ipairs(Workspace:GetChildren()) do
                    if item:IsA("Model") and item ~= Character then
                        if item:GetAttribute("IsAnomaly") == true or item:GetAttribute("IsObstacle") == true then
                            local part = item:FindFirstChild("HumanoidRootPart") or item:FindFirstChild("Head") or item.PrimaryPart
                            if part then
                                local d = (part.Position - Root.Position).Magnitude
                                if d < nearestDist then
                                    nearestDist = d
                                    nearestNpc = part
                                end
                            end
                        end
                    end
                end

                if nearestNpc then
                    if LocalPlayer and LocalPlayer.Backpack then
                        local rev = LocalPlayer.Backpack:FindFirstChild("revolver")
                        if rev and Humanoid then Humanoid:EquipTool(rev) end
                    end
                    if NetworkerClients.Combat then
                        NetworkerClients.Combat:fire("FireRevolver", nearestNpc.Position)
                    end
                end
            end)
        end

        if Flags.AutoMeleeAura and Root then
            pcall(function()
                for _, item in ipairs(Workspace:GetChildren()) do
                    if item:IsA("Model") and item ~= Character then
                        if item:GetAttribute("IsAnomaly") == true or item:GetAttribute("IsObstacle") == true then
                            local part = item:FindFirstChild("HumanoidRootPart") or item.PrimaryPart
                            if part and (part.Position - Root.Position).Magnitude <= Flags.MeleeAuraDistance then
                                if NetworkerClients.Combat then
                                    NetworkerClients.Combat:fire("PerformSwing")
                                    NetworkerClients.Combat:fire("HitNPC", item)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- CCTV ENHANCEMENTS
task.spawn(function()
    while true do
        task.wait(1)
        if Flags.RemoveVhsNoise then
            pcall(function()
                local pg = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
                if pg then
                    for _, g in ipairs(pg:GetChildren()) do
                        if string.find(string.lower(g.Name), "vhs") or string.find(string.lower(g.Name), "noise") or string.find(string.lower(g.Name), "static") then
                            if g:IsA("ScreenGui") then g.Enabled = false end
                        end
                    end
                end
            end)
        end
    end
end)

-- MOVEMENT ENGINE (WalkSpeed, JumpPower, Fly, Noclip)
RunService.RenderStepped:Connect(function()
    if Character and Humanoid then
        if Flags.WalkSpeed and Flags.WalkSpeed ~= 16 then
            Humanoid.WalkSpeed = Flags.WalkSpeed
        end
        if Flags.JumpPower and Flags.JumpPower ~= 50 then
            Humanoid.UseJumpPower = true
            Humanoid.JumpPower = Flags.JumpPower
        end
    end
    if Flags.Noclip and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Flags.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
''')

# SECTION 7: ESP SYSTEM (No emojis)
add(r'''
-- ========================================================================================
-- 8. HIGH-ACCURACY ESP RENDER ENGINE (Clean Tags, Zero Emojis)
-- ========================================================================================
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "PinatHub_ESP_AnomalyHotel"
pcall(function() ESPFolder.Parent = Workspace end)

local function ApplyHighlight(inst, color, fillTrans, outlineCol, tagText)
    if not inst or not inst.Parent then return end
    local hl = inst:FindFirstChild("Pinat_ESP_HL")
    if not hl then
        hl = Instance.new("Highlight")
        hl.Name = "Pinat_ESP_HL"
        hl.Adornee = inst
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = inst
    end
    hl.FillColor = color
    hl.OutlineColor = outlineCol or color
    hl.FillTransparency = fillTrans or 0.45
    hl.OutlineTransparency = 0

    local head = inst:FindFirstChild("Head") or (inst:IsA("BasePart") and inst) or (inst.PrimaryPart)
    if head and tagText then
        local bb = head:FindFirstChild("Pinat_ESP_Tag")
        if not bb then
            bb = Instance.new("BillboardGui")
            bb.Name = "Pinat_ESP_Tag"
            bb.Adornee = head
            bb.Size = UDim2.fromOffset(130, 26)
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head

            local lbl = Instance.new("TextLabel")
            lbl.Name = "TagLbl"
            lbl.Size = UDim2.fromScale(1, 1)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 11
            lbl.TextColor3 = color
            lbl.TextStrokeTransparency = 0.2
            lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Parent = bb
        end
        local lbl = bb:FindFirstChild("TagLbl")
        if lbl then lbl.Text = tagText end
    end
end

local function ClearHighlight(inst)
    if not inst then return end
    local hl = inst:FindFirstChild("Pinat_ESP_HL")
    if hl then hl:Destroy() end
    local head = inst:FindFirstChild("Head") or inst.PrimaryPart or inst
    if head then
        local bb = head:FindFirstChild("Pinat_ESP_Tag")
        if bb then bb:Destroy() end
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            for _, item in ipairs(Workspace:GetChildren()) do
                if item:IsA("Model") and item ~= Character and item:FindFirstChildOfClass("Humanoid") then
                    local isAnomaly = item:GetAttribute("IsAnomaly") == true
                    local isObstacle = item:GetAttribute("IsObstacle") == true or string.find(item.Name, "Kunti") or string.find(item.Name, "Slenderman")

                    if isAnomaly and Flags.ESPAnomaly then
                        ApplyHighlight(item, Color3.fromRGB(255, 45, 60), 0.4, Color3.fromRGB(255, 120, 140), "[!] ANOMALI (IMPOSTOR)")
                    elseif isObstacle and Flags.ESPObstacle then
                        ApplyHighlight(item, Color3.fromRGB(180, 50, 255), 0.35, Color3.fromRGB(220, 120, 255), "[X] MONSTER / HANTU")
                    elseif not isAnomaly and Flags.ESPHuman then
                        ApplyHighlight(item, Color3.fromRGB(50, 230, 110), 0.55, Color3.fromRGB(120, 255, 170), "[OK] TAMU HOTEL (MANUSIA)")
                    else
                        ClearHighlight(item)
                    end
                end
            end

            -- Trash ESP
            if Flags.ESPTrash then
                for _, desc in ipairs(Workspace:GetDescendants()) do
                    if desc:GetAttribute("IsSpawnedCleaningItem") == true and desc.Parent then
                        local tType = desc:GetAttribute("TrashType") or "Sampah"
                        ApplyHighlight(desc, Color3.fromRGB(255, 200, 40), 0.5, Color3.fromRGB(255, 240, 100), "[KOTOR] " .. tType)
                    end
                end
            end
        end)
    end
end)
''')

# SECTION 8: ALL 12 MASTER TABS (With Native Image Asset IDs, Potato Mode Luau typing fix)
add(r'''
-- ========================================================================================
-- 9. UI CREATION & ALL 12 MASTER TABS (With Native Image Asset IDs & Zero Emojis)
-- ========================================================================================
local Window = KingRua:CreateWindow({
    Title = "PinatHub",
    SubTitle = "Hotel Anomaly v2.0",
    TabWidth = 175
})

-- ----------------------------------------------------------------------------------------
-- TAB 1: ANALYTICS (Guarantee Zero 0/nil)
-- ----------------------------------------------------------------------------------------
local TabAnalytics = Window:CreateTab({ Title = "Analytics", Icon = "rbxassetid://10709770317" })
do
    TabAnalytics:AddSection("Live Hotel Telemetry & Bio-Monitors")

    local GraphBPM = TabAnalytics:AddGraph({
        Title = "Detak Jantung (BPM) Live Stream",
        Height = 75,
        Min = 40,
        Max = 180,
        Color = Color3.fromRGB(255, 75, 95)
    })

    local GraphThreat = TabAnalytics:AddGraph({
        Title = "Jarak Ancaman Anomali (Studs)",
        Height = 70,
        Min = 0,
        Max = 120,
        Color = Color3.fromRGB(255, 160, 40)
    })

    local GraphFPS = TabAnalytics:AddGraph({
        Title = "FPS Engine & Latensi Klien",
        Height = 65,
        Min = 0,
        Max = 120,
        Color = Color3.fromRGB(60, 210, 140)
    })

    TabAnalytics:AddSection("Status Shift & Vital Pengguna")

    local BarPanic = TabAnalytics:AddProgressBar({
        Title = "Tingkat Stres / Panik Mental",
        Default = 20,
        Max = 100,
        Color = Color3.fromRGB(255, 80, 80)
    })

    local BarShift = TabAnalytics:AddProgressBar({
        Title = "Progres Hari Shift Resepsionis",
        Default = 1,
        Max = 19,
        Color = Color3.fromRGB(80, 160, 255)
    })

    local BarChore = TabAnalytics:AddProgressBar({
        Title = "Tugas Kebersihan Kamar Aktif",
        Default = 0,
        Max = 10,
        Color = Color3.fromRGB(240, 190, 50)
    })

    TabAnalytics:AddSection("Kartu Telemetri Meja Depan")

    local CardFrontDesk = TabAnalytics:AddParagraph({
        Title = "Scanner Meja Resepsionis",
        Content = "Memuat data tamu hotel..."
    })

    local CardShift = TabAnalytics:AddParagraph({
        Title = "Status Hari & Kamar Hotel",
        Content = "Memuat data shift..."
    })

    local CardVitals = TabAnalytics:AddParagraph({
        Title = "Kondisi Fisik & Mental Karakter",
        Content = "Memuat data vital..."
    })

    local CardEngine = TabAnalytics:AddParagraph({
        Title = "Statistik Jaringan & Lingkungan",
        Content = "Memuat data engine..."
    })

    TabAnalytics:AddSection("Optimasi Render & Grafik")

    TabAnalytics:AddToggle({
        Title = "Fullbright (Terang Tanpa Bayangan)",
        Default = Flags.Fullbright,
        Callback = function(v)
            Flags.Fullbright = v
            if v then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1
                Lighting.ClockTime = 0
                Lighting.GlobalShadows = true
            end
        end
    })

    TabAnalytics:AddToggle({
        Title = "Potato Mode (Anti-Lag Booster)",
        Default = Flags.PotatoMode,
        Callback = function(v)
            Flags.PotatoMode = v
            if v then
                -- Fix: Use Enum.QualityLevel.Level01 instead of number 1
                pcall(function()
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                end)
                for _, p in ipairs(Workspace:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Material = Enum.Material.SmoothPlastic
                    end
                end
            else
                pcall(function()
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
                end)
            end
        end
    })

    TabAnalytics:AddSlider({
        Title = "Field Of View (FOV Kamera)",
        Min = 50,
        Max = 120,
        Default = 70,
        Callback = function(v)
            Flags.CustomFOV = v
            if Camera then Camera.FieldOfView = v end
        end
    })

    -- Live Telemetry Streaming Loop
    task.spawn(function()
        local frameCount = 0
        local lastTime = tick()
        local curFps = 60

        RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local now = tick()
            if now - lastTime >= 1 then
                curFps = frameCount / (now - lastTime)
                frameCount = 0
                lastTime = now
            end
        end)

        while true do
            task.wait(0.4)
            pcall(function()
                local bpm = GetCurrentHeartRate()
                local maxBpm = GetMaxHeartRate()
                local day = GetCurrentStoryDay()
                local threatDist = GetNearestAnomalyDistance()
                local guest = FindCurrentGuestNPC()
                local trashCount = GetCleaningStatus()

                -- Push graphs
                GraphBPM:Push(bpm)
                GraphFPS:Push(curFps)
                GraphThreat:Push(math.clamp(threatDist, 0, 120))

                -- Update Bars
                local panicPct = math.clamp(math.floor(((bpm - 60) / (maxBpm - 60)) * 100), 0, 100)
                BarPanic:Set(panicPct, 100)
                BarShift:Set(day, 19)
                BarChore:Set(trashCount, 10)

                -- Update Cards
                if guest then
                    local isAnom = guest:GetAttribute("IsAnomaly") == true
                    local guestName = guest.Name or "Tamu Hotel"
                    local cannotRej = guest:GetAttribute("CannotReject") == true
                    CardFrontDesk:SetDesc(string.format(
                        "Tamu di Meja: %s\nStatus: %s\nBisa Ditolak: %s\nVerifikasi: 100%% Akurat (Native Module Attribute)",
                        guestName,
                        isAnom and "[!] ANOMALI / IMPOSTOR" or "[OK] MANUSIA ASLI",
                        cannotRej and "TIDAK (Wajib Diterima)" or "YA"
                    ))
                else
                    CardFrontDesk:SetDesc("Tamu di Meja: Tidak ada tamu di depan meja resepsionis.\nStatus: Menunggu kedatangan tamu berikutnya...")
                end

                CardShift:SetDesc(string.format(
                    "Hari Berjalan: Hari ke-%d / 19\nSisa Sampah / Kotoran: %d item\nPemadaman Listrik: %s\nMode: Shift Malam Normal",
                    day,
                    trashCount,
                    Workspace:GetAttribute("IsBlackout") == true and "[!] YA (Mati Lampu)" or "[OK] TIDAK (Listrik Nyala)"
                ))

                CardVitals:SetDesc(string.format(
                    "Detak Jantung: %d BPM (Max: %d BPM)\nStatus Mental: %s\nKecepatan Gerak: %d studs/detik\nKesehatan Tubuh: %s",
                    bpm,
                    maxBpm,
                    bpm > 115 and "PANIK BERLEBIHAN" or (bpm > 85 and "WASPADA" or "TENANG / NORMAL"),
                    Humanoid and math.floor(Humanoid.WalkSpeed) or 16,
                    Humanoid and string.format("%d / %d HP", math.floor(Humanoid.Health), math.floor(Humanoid.MaxHealth)) or "100 / 100 HP"
                ))

                CardEngine:SetDesc(string.format(
                    "Engine Frame Rate: %.1f FPS\nAncaman Terdekat: %.1f studs\nStatus Jaringan: Terhubung ke Server (Packages.Networker)\nPing Latensi: %.1f ms",
                    curFps,
                    threatDist,
                    Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 45
                ))
            end)
        end
    end)
end

-- ----------------------------------------------------------------------------------------
-- TAB 2: RESEPSIONIS
-- ----------------------------------------------------------------------------------------
local TabReception = Window:CreateTab({ Title = "Resepsionis", Icon = "rbxassetid://10709783474" })
do
    TabReception:AddSection("Otomatisasi Meja Resepsionis")

    TabReception:AddToggle({
        Title = "Auto Receptionist (Filter Anomali 100% Akurat)",
        Default = Flags.AutoReceptionist,
        Callback = function(v)
            Flags.AutoReceptionist = v
        end
    })

    TabReception:AddToggle({
        Title = "Auto Dekati Meja (Bypass Radius 20 Studs)",
        Default = Flags.AutoNudgeToDesk,
        Callback = function(v)
            Flags.AutoNudgeToDesk = v
        end
    })

    TabReception:AddToggle({
        Title = "Auto Lewati Dialog Tamu (DialogSkipRequest)",
        Default = Flags.AutoSkipDialogue,
        Callback = function(v)
            Flags.AutoSkipDialogue = v
        end
    })

    TabReception:AddSlider({
        Title = "Jeda Waktu Pemeriksaan (Detik)",
        Min = 0.2,
        Max = 2.0,
        Default = Flags.ReceptionDelay,
        Callback = function(v)
            Flags.ReceptionDelay = v
        end
    })

    TabReception:AddSection("Aksi Manual Meja Depan")

    TabReception:AddButton({
        Title = "Paksa Terima Tamu Saat Ini (Register)",
        Desc = "Menembakkan ReceptionistActionEvent:FireServer('Register')",
        Callback = function()
            FireRemote("ReceptionistActionEvent", "Register")
        end
    })

    TabReception:AddButton({
        Title = "Paksa Tolak Anomali Saat Ini (Reject)",
        Desc = "Menembakkan ReceptionistActionEvent:FireServer('Reject')",
        Callback = function()
            FireRemote("ReceptionistActionEvent", "Reject")
        end
    })

    TabReception:AddButton({
        Title = "Buka / Tutup Buku Registrasi (RegistrationBook)",
        Desc = "Menembakkan Remote OpenRegistrationBook",
        Callback = function()
            FireRemote("OpenRegistrationBook")
            FireRemote("RegistrationBookPageChanged", 1)
        end
    })

    TabReception:AddButton({
        Title = "Skip Customer Meja (Admin Action)",
        Desc = "Langsung mengganti tamu meja dengan antrean berikutnya",
        Callback = function()
            RequestAdminAction("skipCustomer")
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 3: KEBERSIHAN
-- ----------------------------------------------------------------------------------------
local TabCleaning = Window:CreateTab({ Title = "Kebersihan", Icon = "rbxassetid://10747372167" })
do
    TabCleaning:AddSection("Otomatisasi Pembersihan Kamar")

    TabCleaning:AddToggle({
        Title = "Auto Bersihkan Semua Sampah (Kamar & Lobi)",
        Default = Flags.AutoCleanTrash,
        Callback = function(v)
            Flags.AutoCleanTrash = v
        end
    })

    TabCleaning:AddToggle({
        Title = "Auto Selesaikan Minigame Kabel Listrik",
        Default = Flags.AutoSolveWires,
        Callback = function(v)
            Flags.AutoSolveWires = v
        end
    })

    TabCleaning:AddToggle({
        Title = "Auto Hapus Semua Monster / Hambatan",
        Default = Flags.AutoClearObstacles,
        Callback = function(v)
            Flags.AutoClearObstacles = v
        end
    })

    TabCleaning:AddSection("Eksekusi Instan")

    TabCleaning:AddButton({
        Title = "Bersihkan Semua Kamar Seketika (cleanAllRooms)",
        Desc = "Memerintahkan server untuk membersihkan seluruh kamar hotel",
        Callback = function()
            RequestAdminAction("cleanAllRooms")
        end
    })

    TabCleaning:AddButton({
        Title = "Selesaikan Minigame Kabel Seketika (WireSolve)",
        Desc = "Menembakkan sinyal koneksi wire 1..4 ke server",
        Callback = function()
            FireRemote("WireConnectedEvent", 1)
            FireRemote("WireConnectedEvent", 2)
            FireRemote("WireConnectedEvent", 3)
            FireRemote("WireConnectedEvent", 4)
            FireRemote("WireSolveResultEvent", true)
        end
    })

    TabCleaning:AddButton({
        Title = "Hapus Semua Hambatan & Monster (clearObstacles)",
        Desc = "Menyingkirkan Kunti, Gendorowo, dan rintangan lainnya",
        Callback = function()
            RequestAdminAction("clearObstacles")
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 4: DETAK JANTUNG
-- ----------------------------------------------------------------------------------------
local TabHeart = Window:CreateTab({ Title = "Detak Jantung", Icon = "rbxassetid://10723406885" })
do
    TabHeart:AddSection("Stabilisasi Detak Jantung & Panik")

    TabHeart:AddToggle({
        Title = "Kunci Detak Jantung (Lock Heart Rate)",
        Default = Flags.LockHeartRate,
        Callback = function(v)
            Flags.LockHeartRate = v
        end
    })

    TabHeart:AddSlider({
        Title = "Nilai BPM Terkunci",
        Min = 40,
        Max = 160,
        Default = Flags.LockedBPM,
        Callback = function(v)
            Flags.LockedBPM = v
        end
    })

    TabHeart:AddToggle({
        Title = "Auto Minum Minuman Energi Saat Panik",
        Default = Flags.AutoDrinkEnergy,
        Callback = function(v)
            Flags.AutoDrinkEnergy = v
        end
    })

    TabHeart:AddSlider({
        Title = "Ambang Batas Panik Minum Energi",
        Min = 80,
        Max = 150,
        Default = Flags.PanicThreshold,
        Callback = function(v)
            Flags.PanicThreshold = v
        end
    })

    TabHeart:AddToggle({
        Title = "Bisukan Suara Detak Jantung & Panik",
        Default = Flags.MuteHeartbeat,
        Callback = function(v)
            Flags.MuteHeartbeat = v
        end
    })

    TabHeart:AddSection("Preset Cepat Detak Jantung")

    TabHeart:AddButton({
        Title = "Preset BPM Tenang (40 BPM)",
        Callback = function()
            Flags.LockedBPM = 40
            RequestAdminAction("setHeartRate", GetMyUserId(), 40)
        end
    })

    TabHeart:AddButton({
        Title = "Preset BPM Normal (70 BPM)",
        Callback = function()
            Flags.LockedBPM = 70
            RequestAdminAction("setHeartRate", GetMyUserId(), 70)
        end
    })

    TabHeart:AddButton({
        Title = "Reset Stres & Panik ke Server (resetHeartRate)",
        Callback = function()
            RequestAdminAction("resetHeartRate", GetMyUserId())
            if HeartRateSlice and HeartRateSlice.clearNotifications then
                HeartRateSlice.clearNotifications()
            end
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 5: CCTV
-- ----------------------------------------------------------------------------------------
local TabCctv = Window:CreateTab({ Title = "CCTV", Icon = "rbxassetid://10747374938" })
do
    TabCctv:AddSection("Kontrol Kamera Keamanan")

    TabCctv:AddDropdown({
        Title = "Pilih Kamera CCTV",
        Options = {"CAM 1: Meja Lobi", "CAM 2: Koridor Utama", "CAM 3: Dapur Restoran", "CAM 4: Lantai 2 Kamar", "CAM 5: Tangga Darurat", "CAM 6: Pintu Belakang"},
        Default = "CAM 1: Meja Lobi",
        Callback = function(opt)
            local camNum = tonumber(string.match(opt, "%d+")) or 1
            FireRemote("CctvCameraChanged", camNum)
        end
    })

    TabCctv:AddToggle({
        Title = "Hilangkan Efek Statis / VHS Distortion",
        Default = Flags.RemoveVhsNoise,
        Callback = function(v)
            Flags.RemoveVhsNoise = v
        end
    })

    TabCctv:AddSection("Keamanan & Uji Jumpscare")

    TabCctv:AddButton({
        Title = "Buka Monitor CCTV Secara Langsung",
        Desc = "Mengakses monitor CCTV dari mana saja",
        Callback = function()
            FireRemote("CctvCameraChanged", 1)
        end
    })

    TabCctv:AddButton({
        Title = "Uji Coba Jumpscare CCTV (CctvJumpscareTriggered)",
        Callback = function()
            FireRemote("CctvJumpscareTriggered")
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 6: PERTAHANAN
-- ----------------------------------------------------------------------------------------
local TabCombat = Window:CreateTab({ Title = "Pertahanan", Icon = "rbxassetid://10709818534" })
do
    TabCombat:AddSection("Sistem Pertahanan Terhadap Anomali")

    TabCombat:AddToggle({
        Title = "Auto Revolver Aimbot (Tembak Anomali Terdekat)",
        Default = Flags.AutoRevolverAimbot,
        Callback = function(v)
            Flags.AutoRevolverAimbot = v
        end
    })

    TabCombat:AddToggle({
        Title = "Auto Melee Aura (Ayunan Tongkat Listrik / Senjata)",
        Default = Flags.AutoMeleeAura,
        Callback = function(v)
            Flags.AutoMeleeAura = v
        end
    })

    TabCombat:AddSlider({
        Title = "Jarak Jangkauan Melee Aura (Studs)",
        Min = 5,
        Max = 30,
        Default = Flags.MeleeAuraDistance,
        Callback = function(v)
            Flags.MeleeAuraDistance = v
        end
    })

    TabCombat:AddSection("Aksi Senjata Klien")

    TabCombat:AddButton({
        Title = "Tembak Revolver Sekali (CombatNet FireRevolver)",
        Callback = function()
            if NetworkerClients.Combat and Root then
                NetworkerClients.Combat:fire("FireRevolver", Root.Position + (Root.CFrame.LookVector * 20))
            end
        end
    })

    TabCombat:AddButton({
        Title = "Ayunkan Senjata Melee (PerformSwing)",
        Callback = function()
            if NetworkerClients.Combat then
                NetworkerClients.Combat:fire("PerformSwing")
            end
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 7: ALUR CERITA
-- ----------------------------------------------------------------------------------------
local TabStory = Window:CreateTab({ Title = "Alur Cerita", Icon = "rbxassetid://10723387563" })
do
    TabStory:AddSection("Navigasi Hari & Shift (1 - 19)")

    local selDay = 1
    TabStory:AddSlider({
        Title = "Pilih Hari Cerita Target",
        Min = 1,
        Max = 19,
        Default = 1,
        Callback = function(v)
            selDay = v
        end
    })

    TabStory:AddButton({
        Title = "Lompat ke Hari Target (setDay)",
        Desc = "Mengubah hari alur cerita ke hari yang dipilih",
        Callback = function()
            RequestAdminAction("setDay", selDay)
            if DaySlice and DaySlice.setCurrentDay then
                DaySlice.setCurrentDay(selDay)
            end
        end
    })

    TabStory:AddButton({
        Title = "Paksa Pindah ke Hari Berikutnya (forceNextDay)",
        Callback = function()
            RequestAdminAction("forceNextDay")
        end
    })

    TabStory:AddButton({
        Title = "Lewati Langkah Cerita Aktif (skipStoryStep)",
        Callback = function()
            RequestAdminAction("skipStoryStep")
        end
    })

    TabStory:AddButton({
        Title = "Selesaikan Semua Quest Aktif (completeActiveQuests)",
        Callback = function()
            RequestAdminAction("completeActiveQuests")
        end
    })

    TabStory:AddSection("Event Horor Khusus")

    TabStory:AddButton({
        Title = "Panggil Event Slenderman (triggerSlenderman)",
        Callback = function()
            RequestAdminAction("triggerSlenderman")
        end
    })

    TabStory:AddButton({
        Title = "Mulai Pemadaman Listrik (startBlackout)",
        Callback = function()
            RequestAdminAction("startBlackout")
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 8: INVENTARIS
-- ----------------------------------------------------------------------------------------
local TabInventory = Window:CreateTab({ Title = "Inventaris", Icon = "rbxassetid://10709769841" })
do
    TabInventory:AddSection("Dapatkan Peralatan (giveItem)")

    TabInventory:AddButton({
        Title = "Dapatkan Senjata Api Revolver",
        Callback = function()
            RequestAdminAction("giveItem", GetMyUserId(), "revolver", 1)
        end
    })

    TabInventory:AddButton({
        Title = "Dapatkan Tongkat Kejut Listrik (shockBaton)",
        Callback = function()
            RequestAdminAction("giveItem", GetMyUserId(), "shockBaton", 1)
        end
    })

    TabInventory:AddButton({
        Title = "Dapatkan Minuman Energi (energyDrink x5)",
        Callback = function()
            RequestAdminAction("giveItem", GetMyUserId(), "energyDrink", 5)
        end
    })

    TabInventory:AddButton({
        Title = "Dapatkan Sapu & Pel Pembersih (sapu, pel)",
        Callback = function()
            RequestAdminAction("giveItem", GetMyUserId(), "sapu", 1)
            RequestAdminAction("giveItem", GetMyUserId(), "pel", 1)
        end
    })

    TabInventory:AddButton({
        Title = "Dapatkan Paket Semua Item Esensial (allEssential)",
        Callback = function()
            RequestAdminAction("giveItem", GetMyUserId(), "allEssential", 1)
        end
    })

    TabInventory:AddSection("Keuangan & Kelas")

    TabInventory:AddButton({
        Title = "Tambahkan Uang Kas $99,999 (giveCurrency)",
        Callback = function()
            RequestAdminAction("giveCurrency", GetMyUserId(), 99999)
        end
    })

    TabInventory:AddButton({
        Title = "Buka Semua Kelas Pekerjaan (giveClass ALL)",
        Callback = function()
            RequestAdminAction("giveClass", GetMyUserId(), "ALL", 1)
        end
    })

    TabInventory:AddButton({
        Title = "Setel Reputasi Hotel ke Bintang 5 Penuh",
        Callback = function()
            RequestAdminAction("setReputation", GetMyUserId(), 5)
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 9: KEHIDUPAN
-- ----------------------------------------------------------------------------------------
local TabLife = Window:CreateTab({ Title = "Kehidupan", Icon = "rbxassetid://7733920644" })
do
    TabLife:AddSection("Penyelamatan & Hidup Kembali")

    TabLife:AddButton({
        Title = "Hidupkan Diri Sendiri Seketika (Revive Self)",
        Desc = "Menghidupkan karakter via GameOverService & Admin",
        Callback = function()
            if NetworkerClients.GameOver then
                pcall(function()
                    NetworkerClients.GameOver:fetch("requestReviveSelf")
                end)
            end
            RequestAdminAction("revivePlayer", GetMyUserId())
        end
    })

    TabLife:AddButton({
        Title = "Hidupkan Semua Pemain (Revive All)",
        Desc = "Menghidupkan seluruh staf hotel yang gugur",
        Callback = function()
            if NetworkerClients.GameOver then
                pcall(function()
                    NetworkerClients.GameOver:fetch("requestReviveAll")
                end)
            end
        end
    })

    TabLife:AddButton({
        Title = "Ulangi Hari Saat Ini (requestRetry)",
        Callback = function()
            if NetworkerClients.GameOver then
                pcall(function()
                    NetworkerClients.GameOver:fetch("requestRetry")
                end)
            end
        end
    })

    TabLife:AddButton({
        Title = "Kembali ke Lobi Utama (requestLobby)",
        Callback = function()
            if NetworkerClients.GameOver then
                pcall(function()
                    NetworkerClients.GameOver:fetch("requestLobby")
                end)
            end
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 10: VISUAL ESP
-- ----------------------------------------------------------------------------------------
local TabEsp = Window:CreateTab({ Title = "Visual ESP", Icon = "rbxassetid://10723346959" })
do
    TabEsp:AddSection("Filter Tampilan ESP")

    TabEsp:AddToggle({
        Title = "ESP Anomali / Impostor (Merah Terang)",
        Default = Flags.ESPAnomaly,
        Callback = function(v)
            Flags.ESPAnomaly = v
        end
    })

    TabEsp:AddToggle({
        Title = "ESP Tamu Manusia (Hijau Terang)",
        Default = Flags.ESPHuman,
        Callback = function(v)
            Flags.ESPHuman = v
        end
    })

    TabEsp:AddToggle({
        Title = "ESP Monster / Rintangan (Ungu Terang)",
        Default = Flags.ESPObstacle,
        Callback = function(v)
            Flags.ESPObstacle = v
        end
    })

    TabEsp:AddToggle({
        Title = "ESP Sampah & Kotoran Kamar (Kuning Emas)",
        Default = Flags.ESPTrash,
        Callback = function(v)
            Flags.ESPTrash = v
        end
    })
end

-- ----------------------------------------------------------------------------------------
-- TAB 11: PERGERAKAN
-- ----------------------------------------------------------------------------------------
local TabMove = Window:CreateTab({ Title = "Pergerakan", Icon = "rbxassetid://7734020989" })
do
    TabMove:AddSection("Kecepatan & Fisika Karakter")

    TabMove:AddSlider({
        Title = "Kecepatan Jalan (WalkSpeed)",
        Min = 16,
        Max = 120,
        Default = Flags.WalkSpeed,
        Callback = function(v)
            Flags.WalkSpeed = v
            if Humanoid then Humanoid.WalkSpeed = v end
        end
    })

    TabMove:AddSlider({
        Title = "Kekuatan Lompatan (JumpPower)",
        Min = 50,
        Max = 200,
        Default = Flags.JumpPower,
        Callback = function(v)
            Flags.JumpPower = v
            if Humanoid then
                Humanoid.UseJumpPower = true
                Humanoid.JumpPower = v
            end
        end
    })

    TabMove:AddToggle({
        Title = "Lompatan Tanpa Batas (Infinite Jump)",
        Default = Flags.InfiniteJump,
        Callback = function(v)
            Flags.InfiniteJump = v
        end
    })

    TabMove:AddToggle({
        Title = "Tembus Tembok (Noclip)",
        Default = Flags.Noclip,
        Callback = function(v)
            Flags.Noclip = v
        end
    })

    TabMove:AddSection("Teleportasi Titik Hotel")

    for locName, cpos in pairs(TeleportLocations) do
        TabMove:AddButton({
            Title = "Teleport ke: " .. locName,
            Callback = function()
                if Root then
                    Root.CFrame = CFrame.new(cpos + Vector3.new(0, 3, 0))
                end
            end
        })
    end
end

-- ----------------------------------------------------------------------------------------
-- TAB 12: PENGATURAN
-- ----------------------------------------------------------------------------------------
local TabSettings = Window:CreateTab({ Title = "Pengaturan", Icon = "rbxassetid://10734950309" })
do
    TabSettings:AddSection("Manajemen Script & Konfigurasi")

    TabSettings:AddButton({
        Title = "Tutup / Buka Jendela GUI (Toggle Display)",
        Desc = "Anda juga bisa menekan tombol X di pojok kanan atas",
        Callback = function()
            Window.MainFrame.Visible = not Window.MainFrame.Visible
        end
    })

    TabSettings:AddButton({
        Title = "Klaim Semua Hadiah Jurnal Anomali (claimAnomalyReward)",
        Callback = function()
            if NetworkerClients.Journal then
                for i = 1, 20 do
                    NetworkerClients.Journal:fetch("claimAnomalyReward", i)
                end
            end
        end
    })

    TabSettings:AddButton({
        Title = "Unload PinatHub Suite",
        Desc = "Menutup antarmuka dan membersihkan memori script",
        Callback = function()
            if Window.ScreenGui then Window.ScreenGui:Destroy() end
            if ESPFolder then ESPFolder:Destroy() end
        end
    })
end

-- Select Tab 1 on launch
Window:SelectTab(1)

-- Notification on launch
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "PinatHub Anomaly Hotel",
        Text = "Berhasil dimuat! 12 Tab & Modul Game Lengkap Siap Digunakan.",
        Duration = 5
    })
end)

print("[PinatHub] Anomaly Hotel & Night Shift Simulator v2.0 successfully initialized.")

end -- End of __PinatHub_AnomalyHotel_Init__

__PinatHub_AnomalyHotel_Init__()
''')

# Write out
full_code = "".join(chunks)
with open(out_path, "w", encoding="utf-8") as f:
    f.write(full_code)

print(f"Successfully wrote {len(full_code)} bytes ({len(full_code.splitlines())} lines) to {out_path}")
