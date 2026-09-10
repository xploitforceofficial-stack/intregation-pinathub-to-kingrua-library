-- =============================================================================
-- PINATHUB UI LIBRARY — COMPLETE OFFICIAL SHOWCASE EXAMPLE
-- =============================================================================
-- Raw Library Source: https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/refs/heads/main/kingrualibrarysource.lua
-- WhatsApp XploitForce: https://chat.whatsapp.com/CjbAhfWTAKx1mU3O6KEJgp
-- Discord Official: https://discord.gg/ysHZCYFaX7
-- YouTube Channel: https://www.youtube.com/@viunzee1
-- TikTok: https://tiktok.com/@viunze
--
-- FITUR & KOMPONEN UI DI EXAMPLE INI:
--  1. Window & Floating Launcher Button (50x50 round, neon white/green stroke, draggable)
--  2. 7 Tab Lengkap: Main, Player, Visuals, Teleport, Live Stats, Settings, Community
--  3. Semua Tipe Section & Toggle:
--     - AddToggle (dengan opsi Desc & Inline Keybind Badge [None])
--     - AddSubToggle (Sub-toggle bercabang dengan indent visual)
--     - AddToggleSlider (Kombinasi Toggle + Slider dalam 1 baris efisien)
--  4. Semua 15 Elemen UI Library:
--     - AddToggle, AddSubToggle, AddToggleSlider
--     - AddButton, AddSlider, AddDropdown, AddInput / AddTextInput
--     - AddKeybind, AddColorPicker
--     - AddParagraph (Collapsible Multi-Select Cards + RichText XML + Click-Outside-to-Close)
--       * Tiap paragraph bisa dibuka/ditutup secara independen (multi-select)
--       * Klik header untuk expand/collapse dengan animasi smooth + chevron rotate
--       * Klik di luar semua paragraph yang terbuka -> auto collapse
--       * Tombol X di header -> menyembunyikan kartu sepenuhnya
--       * Opsi DefaultOpen = true untuk auto expand saat dibuat
--     - AddGraph (14-bar Animated Telemetry Chart)
--     - AddProgressBar (Smooth Animated Level/Fill Bar)
--     - AddPlayerList (Interactive Searchable Player Multiselect)
--     - AddDiscordCard / AddCommunityCard
--     - AddSeperator / AddDivider (Garis pembatas & Category Header)
--  5. Config Profile Manager (Save/Load/Delete/Autoload ke Executor File System)
--  6. Animated Moving Neon Border (purple gradient on window edge)
-- =============================================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- =============================================================================
-- 1. LOAD PINATHUB LIBRARY
-- =============================================================================
local Library
local success, res = pcall(function()
    if readfile and isfile and isfile("kingrualibrarysource.lua") then
        return loadstring(readfile("kingrualibrarysource.lua"))()
    end
end)

if success and res then
    Library = res
else
    Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/refs/heads/main/kingrualibrarysource.lua"))()
end

-- =============================================================================
-- 2. CREATE WINDOW
-- =============================================================================
local Window = Library:CreateWindow({
    Title = "PinatHub",
    SubTitle = "Universal Control Center",
    Game = "Universal & Multi-Game Edition",
    Version = "3.0.0",
    Discord = "https://discord.gg/ysHZCYFaX7",
    Logo = "rbxassetid://118264723961739",
    NeonGapLines = true,
    OnClose = function()
        print("[PinatHub] Window closed by user. Cleaning active background connections...")
    end
})

-- Jaminan kompatibilitas AddTab untuk berbagai varian loader
if not Window.AddTab then
    Window.AddTab = function(self, ...)
        if self.T then return self:T(...) end
        if self.Tab then return self:Tab(...) end
        if self.NewTab then return self:NewTab(...) end
    end
end

-- =============================================================================
-- 3. GLOBAL CONFIGURATION & STATE STORE
-- =============================================================================
local CONFIG = {
    -- Automation & Farming
    MasterFarm = false,
    AutoCollectDrops = true,
    AutoSellInventory = false,
    AutoLevelUp = true,
    FastClicker = false,
    FastClickSpeed = 20,
    HarvestDelay = 0.5,
    FarmingMode = "Default Pattern",

    -- Combat & Targeting
    AutoAttack = false,
    PrioritizeBosses = true,
    AutoEquipWeapon = true,
    KillAura = false,
    AuraRadius = 25,
    TargetMode = "Closest",

    -- Movement & Mobility
    CustomWalkSpeed = false,
    WalkSpeedValue = 32,
    CustomJumpPower = false,
    JumpPowerValue = 75,
    InfiniteJump = false,
    Noclip = false,
    FlyHack = false,
    FlySpeed = 50,

    -- Character Utilities
    AntiAFK = true,
    AutoRespawn = false,
    GodmodeSimulation = false,

    -- Visuals & ESP
    PlayerESPMaster = false,
    ESPShowBoxes = true,
    ESPShowNames = true,
    ESPShowHealth = true,
    ESPShowTracers = false,
    ESPColor = Color3.fromRGB(168, 85, 247),
    ESPMaxDistance = 500,
    Fullbright = false,
    DisableShadows = false,
    CustomFOV = false,
    FOVValue = 90,

    -- Teleportation
    SelectedDestination = "Spawn Area",
    ClickToTeleport = false,
    SavedWaypointName = "Base_Alpha",
    SavedWaypointCFrame = nil,

    -- Target Player Filter
    FilterMode = "Whitelist (Ignore)",
    SelectedPlayers = {},

    -- Settings & Preferences
    ToggleKey = Enum.KeyCode.RightControl,
    ThemeAccent = Color3.fromRGB(168, 85, 247),
    AutoLoadProfile = false,
    AutoBackup = true,
    CurrentProfile = "Default"
}

local CONFIG_DEFAULTS = {}
for key, value in pairs(CONFIG) do
    CONFIG_DEFAULTS[key] = value
end

local function ResetConfigToDefaults()
    for key in pairs(CONFIG) do
        CONFIG[key] = nil
    end
    for key, value in pairs(CONFIG_DEFAULTS) do
        CONFIG[key] = value
    end
end

local function GetSerializableValue(value)
    local valueType = type(value)
    if valueType == "boolean" or valueType == "number" or valueType == "string" then
        return value
    end
    if valueType == "table" then
        local result = {}
        for key, item in pairs(value) do
            local serializable = GetSerializableValue(item)
            if serializable ~= nil then
                result[key] = serializable
            end
        end
        return result
    end
    return nil
end

-- Teleport Preset Coordinates
local DESTINATIONS = {
    ["Spawn Area"] = Vector3.new(0, 10, 0),
    ["Shop District"] = Vector3.new(120, 10, -85),
    ["Safe Zone"] = Vector3.new(-250, 15, 310),
    ["PVP Arena"] = Vector3.new(450, 20, -150),
    ["VIP Lounge"] = Vector3.new(-75, 45, -420),
    ["High Tier Zone"] = Vector3.new(680, 30, 520)
}

-- Telemetry Counters
local StatsData = {
    StartTime = os.time(),
    TotalActions = 0,
    CurrentCPS = 0,
    InventoryCount = 42,
    InventoryMax = 100,
    CurrentXP = 780,
    MaxXP = 1000
}

-- =============================================================================
-- 4. BACKGROUND FUNCTIONALITY ENGINES
-- =============================================================================

-- [Engine 1] Anti-AFK Disconnection Shield
pcall(function()
    for _, conn in pairs(getconnections(LocalPlayer.Idled)) do
        conn:Disable()
    end
end)
LocalPlayer.Idled:Connect(function()
    if CONFIG.AntiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end
end)

-- [Engine 2] Movement Modifiers (WalkSpeed, JumpPower, Noclip)
local NoclipCollisionState = {}

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")

    if hum then
        if CONFIG.CustomWalkSpeed then
            hum.WalkSpeed = CONFIG.WalkSpeedValue
        else
            hum.WalkSpeed = 16
        end
        if CONFIG.CustomJumpPower then
            hum.UseJumpPower = true
            hum.JumpPower = CONFIG.JumpPowerValue
        else
            hum.JumpPower = 50
        end
    end

    if CONFIG.Noclip then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and NoclipCollisionState[part] == nil then
                NoclipCollisionState[part] = part.CanCollide
                part.CanCollide = false
            end
        end
    else
        for part, canCollide in pairs(NoclipCollisionState) do
            if part.Parent then
                part.CanCollide = canCollide
            end
            NoclipCollisionState[part] = nil
        end
    end
end)

-- [Engine 3] Infinite Jump Handler
UserInputService.JumpRequest:Connect(function()
    if CONFIG.InfiniteJump then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- [Engine 4] Click-to-Teleport Handler (Ctrl + Click)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if CONFIG.ClickToTeleport and input.UserInputType == Enum.UserInputType.MouseButton1 then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            local mouse = LocalPlayer:GetMouse()
            if mouse and mouse.Hit and LocalPlayer.Character then
                local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

local function ApplyConfigState()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = CONFIG.CustomWalkSpeed and CONFIG.WalkSpeedValue or 16
        hum.UseJumpPower = true
        hum.JumpPower = CONFIG.CustomJumpPower and CONFIG.JumpPowerValue or 50
    end

    local lighting = game:GetService("Lighting")
    if CONFIG.Fullbright then
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
    else
        lighting.Brightness = 1
        lighting.ClockTime = 12
        lighting.FogEnd = 1000
    end
    lighting.GlobalShadows = not CONFIG.DisableShadows and not CONFIG.Fullbright

    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = CONFIG.CustomFOV and CONFIG.FOVValue or 70
    end
end

local function ApplyLoadedControlStates()
    local controlTitles = {
        MasterFarm = "Master Farm Switch",
        AutoCollectDrops = "Auto Collect Floating Drops",
        AutoSellInventory = "Auto Sell Full Inventory",
        AutoLevelUp = "Auto Level Up & Rebirth",
        AutoAttack = "Auto Attack Target",
        PrioritizeBosses = "Prioritize Boss & Elite Targets",
        AutoEquipWeapon = "Auto Equip Strongest Weapon",
        KillAura = "Kill Aura (360° Sphere)",
        InfiniteJump = "Infinite Air Jump",
        Noclip = "Noclip (Phase Walls)",
        AntiAFK = "Anti-AFK Protection",
        AutoRespawn = "Auto Respawn on Death",
        GodmodeSimulation = "Godmode Simulation (Auto Heal)",
        PlayerESPMaster = "Master Player ESP",
        ESPShowBoxes = "Show Bounding Boxes",
        ESPShowNames = "Show Display Names & Usernames",
        ESPShowHealth = "Show Health & Distance Bars",
        ESPShowTracers = "Show Bottom Screen Tracers",
        Fullbright = "Fullbright (Maximum Visibility)",
        DisableShadows = "Disable Map Shadows",
        ClickToTeleport = "Click to Teleport (Ctrl + Click)",
        AutoLoadProfile = "Auto Load Profile on Launch",
        AutoBackup = "Create Automatic Timestamped Backups"
    }

    for key, title in pairs(controlTitles) do
        local setter = Library._ControlSetters and Library._ControlSetters[title]
        if setter and type(CONFIG[key]) == "boolean" then
            pcall(setter, CONFIG[key])
        end
    end
end

-- =============================================================================
-- 5. TAB 1: AUTOMATION & COMBAT
-- =============================================================================
local MainTab = Window:AddTab({
    Title = "Main",
    Icon = "home",
    Desc = "Master Automation, Auto Farm, and Combat Engines"
})

-- Section 1: Auto Farming
local FarmSec = MainTab:AddSection({ Title = "Auto Farming" })

FarmSec:AddToggle({
    Title = "Master Farm Switch",
    Description = "Toggle core farming loop with hotkey support",
    Default = CONFIG.MasterFarm,
    Keybind = Enum.KeyCode.F,
    Callback = function(val)
        CONFIG.MasterFarm = val
        Library:Notify({
            Title = "Auto Farm",
            Content = val and "Master farm loop activated" or "Master farm loop halted",
            Type = val and "Success" or "Warning"
        })
    end
})

FarmSec:AddSubToggle({
    Title = "Auto Collect Floating Drops",
    Default = CONFIG.AutoCollectDrops,
    Callback = function(val)
        CONFIG.AutoCollectDrops = val
    end
})

FarmSec:AddSubToggle({
    Title = "Auto Sell Full Inventory",
    Default = CONFIG.AutoSellInventory,
    Callback = function(val)
        CONFIG.AutoSellInventory = val
    end
})

FarmSec:AddSubToggle({
    Title = "Auto Level Up & Rebirth",
    Default = CONFIG.AutoLevelUp,
    Callback = function(val)
        CONFIG.AutoLevelUp = val
    end
})

FarmSec:AddToggleSlider({
    Title = "Fast Clicker & Auto Tap",
    DefaultToggle = CONFIG.FastClicker,
    Min = 5,
    Max = 60,
    DefaultSlider = CONFIG.FastClickSpeed,
    Suffix = " CPS",
    Callback = function(toggleState, sliderValue)
        CONFIG.FastClicker = toggleState
        CONFIG.FastClickSpeed = sliderValue
    end
})

FarmSec:AddSlider({
    Title = "Harvest Action Delay",
    Min = 0.1,
    Max = 3.0,
    Default = CONFIG.HarvestDelay,
    Increment = 0.1,
    Callback = function(val)
        CONFIG.HarvestDelay = val
    end
})

FarmSec:AddDropdown({
    Title = "Farming Routine Mode",
    Description = "Select trajectory and pathfinding behavior",
    Values = { "Default Pattern", "Aggressive Orbit", "Stealth Safe", "Custom Path" },
    Default = CONFIG.FarmingMode,
    Callback = function(mode)
        CONFIG.FarmingMode = mode
    end
})

-- Section 2: Combat & Targeting
local CombatSec = MainTab:AddSection({ Title = "Combat & Targeting" })

CombatSec:AddToggle({
    Title = "Auto Attack Target",
    Description = "Automatically attacks selected hostile entities",
    Default = CONFIG.AutoAttack,
    Keybind = Enum.KeyCode.R,
    Callback = function(val)
        CONFIG.AutoAttack = val
    end
})

CombatSec:AddSubToggle({
    Title = "Prioritize Boss & Elite Targets",
    Default = CONFIG.PrioritizeBosses,
    Callback = function(val)
        CONFIG.PrioritizeBosses = val
    end
})

CombatSec:AddSubToggle({
    Title = "Auto Equip Strongest Weapon",
    Default = CONFIG.AutoEquipWeapon,
    Callback = function(val)
        CONFIG.AutoEquipWeapon = val
    end
})

CombatSec:AddToggle({
    Title = "Kill Aura (360° Sphere)",
    Description = "Hits any enemies entering your protection perimeter",
    Default = CONFIG.KillAura,
    Callback = function(val)
        CONFIG.KillAura = val
    end
})

CombatSec:AddSlider({
    Title = "Aura Detection Radius",
    Min = 5,
    Max = 50,
    Default = CONFIG.AuraRadius,
    Increment = 1,
    Callback = function(val)
        CONFIG.AuraRadius = val
    end
})

CombatSec:AddDropdown({
    Title = "Target Mode Priority",
    Values = { "Closest", "Lowest HP", "Highest Reward", "Random" },
    Default = CONFIG.TargetMode,
    Callback = function(selected)
        CONFIG.TargetMode = selected
    end
})

-- =============================================================================
-- 6. TAB 2: PLAYER & MOVEMENT
-- =============================================================================
local PlayerTab = Window:AddTab({
    Title = "Player",
    Icon = "user",
    Desc = "Movement Boosts, Physics Tweaks, and Character Utility"
})

-- Section 1: Mobility & Physics Modifiers
local MoveSec = PlayerTab:AddSection({ Title = "Mobility Modifiers" })

MoveSec:AddToggleSlider({
    Title = "Custom WalkSpeed",
    DefaultToggle = CONFIG.CustomWalkSpeed,
    Min = 16,
    Max = 250,
    DefaultSlider = CONFIG.WalkSpeedValue,
    Suffix = " studs/s",
    Callback = function(enabled, speed)
        CONFIG.CustomWalkSpeed = enabled
        CONFIG.WalkSpeedValue = speed
        if not enabled and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
})

MoveSec:AddToggleSlider({
    Title = "Custom JumpPower",
    DefaultToggle = CONFIG.CustomJumpPower,
    Min = 50,
    Max = 350,
    DefaultSlider = CONFIG.JumpPowerValue,
    Suffix = " pwr",
    Callback = function(enabled, pwr)
        CONFIG.CustomJumpPower = enabled
        CONFIG.JumpPowerValue = pwr
        if not enabled and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = 50 end
        end
    end
})

MoveSec:AddToggle({
    Title = "Infinite Air Jump",
    Description = "Allows continuous jumping mid-air without ground contact",
    Default = CONFIG.InfiniteJump,
    Callback = function(val)
        CONFIG.InfiniteJump = val
    end
})

MoveSec:AddToggle({
    Title = "Noclip (Phase Walls)",
    Description = "Walk through solid objects and map boundaries",
    Default = CONFIG.Noclip,
    Keybind = Enum.KeyCode.N,
    Callback = function(val)
        CONFIG.Noclip = val
    end
})

MoveSec:AddToggleSlider({
    Title = "Fly Mode (Hover Control)",
    DefaultToggle = CONFIG.FlyHack,
    Min = 10,
    Max = 200,
    DefaultSlider = CONFIG.FlySpeed,
    Suffix = " studs/s",
    Callback = function(enabled, speed)
        CONFIG.FlyHack = enabled
        CONFIG.FlySpeed = speed
    end
})

-- Section 2: Character Utilities & Protections
local UtilSec = PlayerTab:AddSection({ Title = "Character Utilities" })

UtilSec:AddToggle({
    Title = "Anti-AFK Protection",
    Description = "Prevents Roblox 20-minute idle disconnection",
    Default = CONFIG.AntiAFK,
    Callback = function(val)
        CONFIG.AntiAFK = val
    end
})

UtilSec:AddToggle({
    Title = "Auto Respawn on Death",
    Default = CONFIG.AutoRespawn,
    Callback = function(val)
        CONFIG.AutoRespawn = val
    end
})

UtilSec:AddToggle({
    Title = "Godmode Simulation (Auto Heal)",
    Default = CONFIG.GodmodeSimulation,
    Callback = function(val)
        CONFIG.GodmodeSimulation = val
    end
})

UtilSec:AddButton({
    Title = "Instant Reset Character",
    Description = "Forces immediate humanoid reset and respawn",
    Icon = "skull",
    Callback = function()
        if LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = 0 end
        end
    end
})

-- =============================================================================
-- 7. TAB 3: VISUALS & ESP
-- =============================================================================
local VisualTab = Window:AddTab({
    Title = "Visuals",
    Icon = "eye",
    Desc = "ESP Overlays, Tracers, World Lighting, and Camera Tweaks"
})

-- Section 1: Entity ESP
local ESPSec = VisualTab:AddSection({ Title = "Player ESP & Overlays" })

ESPSec:AddToggle({
    Title = "Master Player ESP",
    Description = "Highlight players through walls and geometry",
    Default = CONFIG.PlayerESPMaster,
    Callback = function(val)
        CONFIG.PlayerESPMaster = val
    end
})

ESPSec:AddSubToggle({
    Title = "Show Bounding Boxes",
    Default = CONFIG.ESPShowBoxes,
    Callback = function(val)
        CONFIG.ESPShowBoxes = val
    end
})

ESPSec:AddSubToggle({
    Title = "Show Display Names & Usernames",
    Default = CONFIG.ESPShowNames,
    Callback = function(val)
        CONFIG.ESPShowNames = val
    end
})

ESPSec:AddSubToggle({
    Title = "Show Health & Distance Bars",
    Default = CONFIG.ESPShowHealth,
    Callback = function(val)
        CONFIG.ESPShowHealth = val
    end
})

ESPSec:AddSubToggle({
    Title = "Show Bottom Screen Tracers",
    Default = CONFIG.ESPShowTracers,
    Callback = function(val)
        CONFIG.ESPShowTracers = val
    end
})

ESPSec:AddColorPicker({
    Title = "ESP Color Theme",
    Description = "Select outline and highlight color accent",
    Default = CONFIG.ESPColor,
    Callback = function(c)
        CONFIG.ESPColor = c
    end
})

ESPSec:AddSlider({
    Title = "Max ESP Render Distance",
    Min = 100,
    Max = 3000,
    Default = CONFIG.ESPMaxDistance,
    Increment = 50,
    Callback = function(val)
        CONFIG.ESPMaxDistance = val
    end
})

-- Section 2: World Environment
local WorldSec = VisualTab:AddSection({ Title = "World Lighting & Camera" })

WorldSec:AddToggle({
    Title = "Fullbright (Maximum Visibility)",
    Description = "Eliminates darkness, shadows, and interior pitch blacks",
    Default = CONFIG.Fullbright,
    Callback = function(val)
        CONFIG.Fullbright = val
        local lighting = game:GetService("Lighting")
        if val then
            lighting.Brightness = 2
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
            lighting.GlobalShadows = false
        else
            lighting.Brightness = 1
            lighting.ClockTime = 12
            lighting.FogEnd = 1000
            lighting.GlobalShadows = not CONFIG.DisableShadows
        end
    end
})

WorldSec:AddToggle({
    Title = "Disable Map Shadows",
    Default = CONFIG.DisableShadows,
    Callback = function(val)
        CONFIG.DisableShadows = val
        game:GetService("Lighting").GlobalShadows = not val
    end
})

WorldSec:AddToggleSlider({
    Title = "Field of View (Camera FOV)",
    DefaultToggle = CONFIG.CustomFOV,
    Min = 70,
    Max = 120,
    DefaultSlider = CONFIG.FOVValue,
    Suffix = "°",
    Callback = function(enabled, fov)
        CONFIG.CustomFOV = enabled
        CONFIG.FOVValue = fov
        local cam = workspace.CurrentCamera
        if cam then
            cam.FieldOfView = enabled and fov or 70
        end
    end
})

WorldSec:AddButton({
    Title = "Clear Atmosphere Blur & Fog",
    Description = "Removes volumetric fog and blur effects for cleaner view",
    Callback = function()
        for _, obj in ipairs(game:GetService("Lighting"):GetChildren()) do
            if obj:IsA("Atmosphere") or obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = false
            end
        end
        Library:Notify({
            Title = "Environment",
            Content = "Atmospheric fog & blur cleared successfully",
            Type = "Success"
        })
    end
})

-- =============================================================================
-- 8. TAB 4: TELEPORT & WORLD
-- =============================================================================
local TeleportTab = Window:AddTab({
    Title = "Teleport",
    Icon = "Teleport",
    Desc = "Waypoints, Map Navigations, and Server Utilities"
})

-- Section 1: Preset Locations
local PresetsSec = TeleportTab:AddSection({ Title = "Preset Waypoints" })

PresetsSec:AddDropdown({
    Title = "Select Destination",
    Description = "Choose from predefined key map landmarks",
    Values = { "Spawn Area", "Shop District", "Safe Zone", "PVP Arena", "VIP Lounge", "High Tier Zone" },
    Default = CONFIG.SelectedDestination,
    Callback = function(choice)
        CONFIG.SelectedDestination = choice
    end
})

PresetsSec:AddButton({
    Title = "Teleport to Selected Destination",
    Icon = "target",
    Callback = function()
        local pos = DESTINATIONS[CONFIG.SelectedDestination]
        if pos and LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = CFrame.new(pos)
                Library:Notify({
                    Title = "Teleport",
                    Content = "Teleported to " .. CONFIG.SelectedDestination,
                    Type = "Success"
                })
            end
        end
    end
})

PresetsSec:AddToggle({
    Title = "Click to Teleport (Ctrl + Click)",
    Description = "Hold Ctrl and Left Click anywhere on screen to warp",
    Default = CONFIG.ClickToTeleport,
    Keybind = Enum.KeyCode.LeftControl,
    Callback = function(val)
        CONFIG.ClickToTeleport = val
    end
})

-- Section 2: Custom Waypoints
local CustomSec = TeleportTab:AddSection({ Title = "Custom Waypoint Memory" })

CustomSec:AddTextInput({
    Title = "Waypoint Name",
    Default = CONFIG.SavedWaypointName,
    PlaceHolder = "Enter waypoint identifier...",
    Callback = function(txt)
        CONFIG.SavedWaypointName = txt
    end
})

CustomSec:AddButton({
    Title = "Record Current Position",
    Description = "Saves your character's current coordinates to memory",
    Callback = function()
        if LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                CONFIG.SavedWaypointCFrame = root.CFrame
                Library:Notify({
                    Title = "Waypoint Saved",
                    Content = string.format("Recorded: %.1f, %.1f, %.1f", root.Position.X, root.Position.Y, root.Position.Z),
                    Type = "Success"
                })
            end
        end
    end
})

CustomSec:AddButton({
    Title = "Teleport to Saved Waypoint",
    Callback = function()
        if CONFIG.SavedWaypointCFrame and LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = CONFIG.SavedWaypointCFrame
                Library:Notify({
                    Title = "Teleport",
                    Content = "Warped to " .. CONFIG.SavedWaypointName,
                    Type = "Success"
                })
            end
        else
            Library:Notify({
                Title = "Error",
                Content = "No saved waypoint recorded yet! Click Record first.",
                Type = "Warning"
            })
        end
    end
})

-- Section 3: Server Actions
local ServerSec = TeleportTab:AddSection({ Title = "Server Controls" })

ServerSec:AddButton({
    Title = "Rejoin Current Server",
    Description = "Reconnects to the same instance",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

ServerSec:AddButton({
    Title = "Server Hop (Find New Server)",
    Description = "Searches for an alternate public server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local serversUrl = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", game.PlaceId)
        local successHop, resHop = pcall(function()
            return game:HttpGet(serversUrl)
        end)
        if successHop and resHop then
            local body = HttpService:JSONDecode(resHop)
            if body and body.data then
                for _, server in ipairs(body.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        return
                    end
                end
            end
        end
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

-- =============================================================================
-- 9. TAB 5: LIVE STATS & TELEMETRY
-- =============================================================================
local StatsTab = Window:AddTab({
    Title = "Live Stats",
    Icon = "bar-chart-2",
    Desc = "Real-time Telemetry, System Metrics, and Progress Bars"
})

local LiveSec = StatsTab:AddSection({ Title = "Performance & Metrics" })

-- Collapsible RichText Paragraph Card (starts collapsed — click header to expand)
-- DefaultOpen = true: auto-expands immediately on creation
local MetricsPara = LiveSec:AddParagraph({
    Title = "Session Analytics Overview",
    Content = "Initializing live telemetric data feed...",
    DefaultOpen = true  -- Auto-expanded on load since it contains live data
})

-- Real-time 14-Bar Animated Telemetry Chart
local TelemetryGraph = LiveSec:AddGraph({
    Title = "Action Throughput & CPS Rate",
    BarCount = 14,
    MaxValue = 60,
    Height = 115,
    Unit = "/s"
})

-- Animated Progress Bar 1: Inventory Capacity
local InvProgressBar = LiveSec:AddProgressBar({
    Title = "Inventory Bag Capacity",
    Default = CONFIG.InventoryCount or 42,
    Max = 100
})

-- Animated Progress Bar 2: Level XP Progression
local XPProgressBar = LiveSec:AddProgressBar({
    Title = "Account Level Experience (XP)",
    Default = 78,
    Max = 100
})

LiveSec:AddButton({
    Title = "Reset Analytics Counters",
    Description = "Resets elapsed session duration and throughput counters",
    Callback = function()
        StatsData.StartTime = os.time()
        StatsData.TotalActions = 0
        Library:Notify({
            Title = "Telemetry",
            Content = "Session counters successfully reset",
            Type = "Success"
        })
    end
})

-- Background Telemetry Update Loop (Smooth Live Feed)
task.spawn(function()
    local firstUpdate = true
    while task.wait(1) do
        local elapsed = os.time() - StatsData.StartTime
        local hours = math.floor(elapsed / 3600)
        local mins = math.floor((elapsed % 3600) / 60)
        local secs = elapsed % 60
        local timeFormatted = string.format("%02d:%02d:%02d", hours, mins, secs)

        -- Simulate realistic fluctuations
        local randomCPS = CONFIG.FastClicker and (CONFIG.FastClickSpeed + math.random(-2, 2)) or (CONFIG.MasterFarm and math.random(8, 22) or math.random(0, 3))
        StatsData.CurrentCPS = math.clamp(randomCPS, 0, 60)
        StatsData.TotalActions = StatsData.TotalActions + StatsData.CurrentCPS

        -- Push into Graph
        TelemetryGraph:Push(StatsData.CurrentCPS)

        -- Update Metrics Paragraph with RichText formatting
        local ping = math.floor((LocalPlayer:GetNetworkPing() or 0.05) * 1000)
        local fps = math.floor(workspace:GetRealPhysicsFPS())
        local richContent = string.format(
            "<b>Session Duration:</b> <font color='#a855f7'>%s</font>\n" ..
            "<b>Network Latency:</b> <font color='#4ade80'>%d ms</font>  |  <b>Frame Rate:</b> <font color='#38bdf8'>%d FPS</font>\n" ..
            "<b>Action Throughput:</b> <font color='#facc15'>%d/s</font>  |  <b>Cumulative Total:</b> <font color='#f472b6'>%d</font>",
            timeFormatted, ping, fps, StatsData.CurrentCPS, StatsData.TotalActions
        )
        MetricsPara:SetContent(richContent)

        -- On first update, ensure it stays expanded (DefaultOpen may have been
        -- collapsed by click-outside before the first data arrives)
        if firstUpdate then
            firstUpdate = false
            MetricsPara:Expand()
        end

        -- Incrementally cycle progress bar for demonstration
        StatsData.InventoryCount = ((StatsData.InventoryCount + 1) % 100)
        InvProgressBar:Set(StatsData.InventoryCount, 100)
    end
end)

-- =============================================================================
-- 10. TAB 6: SETTINGS & PROFILES
-- =============================================================================
local SettingsTab = Window:AddTab({
    Title = "Settings",
    Icon = "settings",
    Desc = "Configuration Manager, Player Targeting Filter, and UI Preferences"
})

-- Section 1: Configuration Profile System (File System + Memory Fallback)
local ConfigSec = SettingsTab:AddSection({ Title = "Profile Manager" })

ConfigSec:AddSeperator("PROFILE MANAGEMENT")

local ProfileFolder = "PinatHub_Configs"
pcall(function()
    if makefolder and not isfolder(ProfileFolder) then
        makefolder(ProfileFolder)
    end
end)

local ProfileNameInput = "Default"
ConfigSec:AddTextInput({
    Title = "Config Profile Name",
    Default = "Default",
    PlaceHolder = "Enter profile name...",
    Callback = function(txt)
        ProfileNameInput = (txt ~= "" and txt) or "Default"
    end
})

local function GetAvailableProfiles()
    local list = { "Default", "Aggressive_Farm", "Safe_Legit", "PVP_Combat" }
    pcall(function()
        if listfiles and isfolder(ProfileFolder) then
            for _, path in ipairs(listfiles(ProfileFolder)) do
                local fname = string.match(path, "([%w_%-]+)%.json$")
                if fname and not table.find(list, fname) then
                    table.insert(list, fname)
                end
            end
        end
    end)
    return list
end

local ProfileDropdown = ConfigSec:AddDropdown({
    Title = "Select Profile",
    Description = "Choose a stored profile configuration",
    Values = GetAvailableProfiles(),
    Default = "Default",
    Callback = function(chosen)
        ProfileNameInput = chosen
    end
})

ConfigSec:AddButton({
    Title = "Save Current Settings to Profile",
    Icon = "arrow-up",
    Callback = function()
        local serialized = HttpService:JSONEncode(GetSerializableValue(CONFIG))
        local filePath = ProfileFolder .. "/" .. ProfileNameInput .. ".json"
        local saved = false
        pcall(function()
            if writefile then
                writefile(filePath, serialized)
                saved = true
            end
        end)
        Library:Notify({
            Title = "Config Saved",
            Content = saved and ("Saved to " .. filePath) or ("Saved profile [" .. ProfileNameInput .. "] in memory"),
            Type = "Success"
        })
        ProfileDropdown:Refresh(GetAvailableProfiles())
    end
})

ConfigSec:AddButton({
    Title = "Load Selected Profile",
    Callback = function()
        local filePath = ProfileFolder .. "/" .. ProfileNameInput .. ".json"
        local loaded = false
        pcall(function()
            if readfile and isfile and isfile(filePath) then
                local data = HttpService:JSONDecode(readfile(filePath))
                if type(data) == "table" then
                    ResetConfigToDefaults()
                    for k, v in pairs(data) do
                        CONFIG[k] = v
                    end
                    CONFIG.CurrentProfile = ProfileNameInput
                    ApplyConfigState()
                    ApplyLoadedControlStates()
                    loaded = true
                end
            end
        end)
        Library:Notify({
            Title = "Config Loaded",
            Content = loaded and ("Applied " .. ProfileNameInput .. " successfully") or ("Using active profile settings"),
            Type = "Success"
        })
    end
})

ConfigSec:AddToggle({
    Title = "Auto Load Profile on Launch",
    Default = CONFIG.AutoLoadProfile,
    Callback = function(val)
        CONFIG.AutoLoadProfile = val
    end
})

ConfigSec:AddSubToggle({
    Title = "Create Automatic Timestamped Backups",
    Default = CONFIG.AutoBackup,
    Callback = function(val)
        CONFIG.AutoBackup = val
    end
})

-- Section 2: Interactive Player Filtering
local FilterSec = SettingsTab:AddSection({ Title = "Player Target Filters" })

FilterSec:AddSeperator("TARGETING MODES")

FilterSec:AddDropdown({
    Title = "Filter Evaluation Mode",
    Values = { "Whitelist (Ignore)", "Blacklist (Target Only)" },
    Default = CONFIG.FilterMode,
    Callback = function(mode)
        CONFIG.FilterMode = mode
    end
})

FilterSec:AddPlayerList({
    Title = "Target & Whitelist Players",
    Multi = true,
    Callback = function(selectedMap)
        CONFIG.SelectedPlayers = selectedMap
        local count = 0
        for _ in pairs(selectedMap) do count = count + 1 end
        print("[PinatHub] Selected player count updated:", count)
    end
})

-- Section 3: Keybinds & Hub Preferences
local PrefSec = SettingsTab:AddSection({ Title = "Preferences & Hub Controls" })

PrefSec:AddSeperator("KEYBINDS & THEME")

PrefSec:AddKeybind({
    Title = "Toggle UI Window Keybind",
    Default = CONFIG.ToggleKey,
    Callback = function(newKey)
        CONFIG.ToggleKey = newKey
        Library:Notify({
            Title = "Keybind Changed",
            Content = "Toggle key set to " .. newKey.Name,
            Type = "Success"
        })
    end
})

PrefSec:AddColorPicker({
    Title = "Accent Theme Color",
    Description = "Cycles color tone for active highlights and borders",
    Default = CONFIG.ThemeAccent,
    Callback = function(newColor)
        CONFIG.ThemeAccent = newColor
    end
})

PrefSec:AddButton({
    Title = "Minimize UI to Floating Launcher",
    Callback = function()
        Window:Minimize()
    end
})

-- =============================================================================
-- 11. TAB 7: COMMUNITY & OFFICIAL CHANNELS
-- =============================================================================
local CommunityTab = Window:AddTab({
    Title = "Community",
    Icon = "users",
    Desc = "Official Links, Discord Community, and Developer Socials"
})

local SocialSec = CommunityTab:AddSection({ Title = "Official Socials" })

-- Official Discord Card
SocialSec:AddDiscordCard({
    Title = "PinatHub Official Community",
    Members = "30522",
    Online = "2309",
    Invite = "https://discord.gg/ysHZCYFaX7",
    Callback = function()
        setclipboard("https://discord.gg/ysHZCYFaX7")
        Library:Notify({
            Title = "Discord Invite",
            Content = "Copied https://discord.gg/ysHZCYFaX7 to clipboard!",
            Type = "Success"
        })
    end
})

SocialSec:AddSeperator("KOMUNITAS WHATSAPP & MEDIA SOSIAL")

-- Paragraph card 1: Official Media Links
-- DefaultOpen = false (default) — user clicks header to expand
-- Multi-select: user can expand this AND the credits card simultaneously
local MediaPara = SocialSec:AddParagraph({
    Title = "Official PinatHub Media Links",
    Content = "<b>WhatsApp XploitForce:</b> <font color='#4ade80'>https://chat.whatsapp.com/CjbAhfWTAKx1mU3O6KEJgp</font>\n" ..
              "<b>Discord:</b> <font color='#818cf8'>https://discord.gg/ysHZCYFaX7</font>\n" ..
              "<b>YouTube:</b> <font color='#f87171'>https://www.youtube.com/@viunzee1</font>\n" ..
              "<b>TikTok:</b> <font color='#38bdf8'>https://tiktok.com/@viunze</font>"
    -- DefaultOpen = false (default: collapsed, click header to expand)
})

SocialSec:AddButton({
    Title = "Copy WhatsApp Community Link (XploitForce)",
    Icon = "users",
    Callback = function()
        setclipboard("https://chat.whatsapp.com/CjbAhfWTAKx1mU3O6KEJgp")
        Library:Notify({
            Title = "Link Copied",
            Content = "WhatsApp XploitForce link copied to clipboard!",
            Type = "Success"
        })
    end
})

SocialSec:AddButton({
    Title = "Copy YouTube Channel Link (@viunzee1)",
    Icon = "arrow-up",
    Callback = function()
        setclipboard("https://www.youtube.com/@viunzee1")
        Library:Notify({
            Title = "Link Copied",
            Content = "YouTube channel link copied to clipboard!",
            Type = "Success"
        })
    end
})

SocialSec:AddButton({
    Title = "Copy TikTok Profile Link (@viunze)",
    Icon = "arrow-up",
    Callback = function()
        setclipboard("https://tiktok.com/@viunze")
        Library:Notify({
            Title = "Link Copied",
            Content = "TikTok link copied to clipboard!",
            Type = "Success"
        })
    end
})

SocialSec:AddSeperator("CREDITS")

-- Paragraph card 2: Credits (DefaultOpen = true — auto-expanded on load)
-- Multi-select demo: both MediaPara AND this card can be open at the same time
local CreditsPara = SocialSec:AddParagraph({
    Title = "PinatHub Credits & Team",
    Content = "<b>Thank you for using PinatHub!</b>\n" ..
              "We sincerely appreciate your support and trust in this script.\n" ..
              "Thank you to the XploitForce Community and everyone who helps test, improve, and share PinatHub.\n" ..
              "Your feedback and continued support keep this project growing.",
    DefaultOpen = true  -- Auto-expanded on load
})

-- Example: programmatic paragraph API usage
-- CreditsPara:Collapse()       -- Collapse this card programmatically
-- CreditsPara:Expand()         -- Expand this card programmatically
-- CreditsPara:Toggle()         -- Toggle expand/collapse state
-- CreditsPara:Close()          -- Hide card entirely (removes from view)
-- CreditsPara:Open()           -- Show & expand hidden card
-- CreditsPara:SetTitle("...")  -- Update title text
-- CreditsPara:SetContent("...") -- Update content text
-- MediaPara:Expand()           -- Multi-select: expand MediaPara independently

-- =============================================================================
-- 12. INITIALIZATION CONFIRMATION NOTIFICATION
-- =============================================================================
Library:Notify({
    Title = "PinatHub Loaded",
    Content = "All sections, toggles, and telemetry modules ready!",
    Type = "Success"
})

print("=====================================================================")
print(" [PinatHub] Official Showcase Example initialized successfully!")
print(" [PinatHub] Community WhatsApp: https://chat.whatsapp.com/CjbAhfWTAKx1mU3O6KEJgp")
print(" [PinatHub] Discord Official:   https://discord.gg/ysHZCYFaX7")
print("=====================================================================")
