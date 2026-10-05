-- ╔══════════════════════════════════════════════════════════════════════════════════╗
-- ║                     PinatHub HUB — Fish Game Ultimate Edition                   ║
-- ║         Complete Multi-Module Integration for Fish Game (Roblox)               ║
-- ║         Utilizing All Game Modules, Configs, Remotes, & Game Engine Logic      ║
-- ╚══════════════════════════════════════════════════════════════════════════════════╝

local function __FishGame_PinatHub_Main__()

-- ── Core Services ───────────────────────────────────────────────────────────────────
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Workspace         = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")
local SoundService      = game:GetService("SoundService")

local Camera      = Workspace.CurrentCamera or Workspace:WaitForChild("Camera")
local LocalPlayer = Players.LocalPlayer
local Character, Humanoid, Root

-- ── Character Tracker ───────────────────────────────────────────────────────────────
local function refreshChar(char)
    Character = char or LocalPlayer.Character
    Humanoid  = Character and Character:FindFirstChildOfClass("Humanoid")
    Root      = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso"))
end
refreshChar()
LocalPlayer.CharacterAdded:Connect(refreshChar)

-- ── Module Integration (Requiring Game Modules Directly) ────────────────────────────
local FishGameFolder = ReplicatedStorage:WaitForChild("FishGame", 10) or ReplicatedStorage

local GameConfig             = nil
local GameFishIndex          = nil
local GamePetAbilities       = nil
local GameResearch           = nil
local GameRunState           = nil
local GameNormalGunConfig    = nil
local GameMonetizationConfig = nil
local GameWeaponEffects      = nil

-- Safely require each game module with pcall
pcall(function()
    local cfg = FishGameFolder:FindFirstChild("Config") or ReplicatedStorage:FindFirstChild("Config")
    if cfg and cfg:IsA("ModuleScript") then GameConfig = require(cfg) end
end)

pcall(function()
    local idx = FishGameFolder:FindFirstChild("FishIndexConfig") or ReplicatedStorage:FindFirstChild("FishIndexConfig")
    if idx and idx:IsA("ModuleScript") then GameFishIndex = require(idx) end
end)

pcall(function()
    local pets = FishGameFolder:FindFirstChild("PetAbilities") or ReplicatedStorage:FindFirstChild("PetAbilities")
    if pets and pets:IsA("ModuleScript") then GamePetAbilities = require(pets) end
end)

pcall(function()
    local rsch = FishGameFolder:FindFirstChild("ResearchConfig") or ReplicatedStorage:FindFirstChild("ResearchConfig")
    if rsch and rsch:IsA("ModuleScript") then GameResearch = require(rsch) end
end)

pcall(function()
    local rs = FishGameFolder:FindFirstChild("RunState") or ReplicatedStorage:FindFirstChild("RunState")
    if rs and rs:IsA("ModuleScript") then GameRunState = require(rs) end
end)

pcall(function()
    local ngc = ReplicatedStorage:FindFirstChild("NormalGunConfig") or FishGameFolder:FindFirstChild("NormalGunConfig")
    if ngc and ngc:IsA("ModuleScript") then GameNormalGunConfig = require(ngc) end
end)

pcall(function()
    local mc = ReplicatedStorage:FindFirstChild("MonetizationConfig") or FishGameFolder:FindFirstChild("MonetizationConfig")
    if mc and mc:IsA("ModuleScript") then GameMonetizationConfig = require(mc) end
end)

pcall(function()
    local we = ReplicatedStorage:FindFirstChild("ExclusiveWeaponEffects") or FishGameFolder:FindFirstChild("ExclusiveWeaponEffects")
    if we and we:IsA("ModuleScript") then GameWeaponEffects = require(we) end
end)

print(string.format("[FishGame PinatHub] Game Modules Loaded -> Config: %s | FishIndex: %s | NormalGun: %s | Monetization: %s",
    tostring(GameConfig ~= nil), tostring(GameFishIndex ~= nil), tostring(GameNormalGunConfig ~= nil), tostring(GameMonetizationConfig ~= nil)
))

-- ── Remotes Integration ─────────────────────────────────────────────────────────────
local GameRemotes = FishGameFolder:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Remotes")

local function getRemote(name)
    if GameRemotes then
        local r = GameRemotes:FindFirstChild(name)
        if r then return r end
    end
    local direct = ReplicatedStorage:FindFirstChild(name)
    if direct then return direct end
    if FishGameFolder then
        local fgDirect = FishGameFolder:FindFirstChild(name)
        if fgDirect then return fgDirect end
    end
    return nil
end

local WeaponActionRemote            = getRemote("WeaponAction")
local UpgradeActionRemote           = getRemote("UpgradeAction")
local OrdnanceActionRemote          = getRemote("OrdnanceAction")
local SkipDayActionRemote           = getRemote("SkipDayAction")
local FishPushRemote                = getRemote("FishPush")
local StateUpdateRemote             = getRemote("StateUpdate")
local DeathStateRemote              = getRemote("DeathState")
local RespawnActionRemote           = getRemote("RespawnAction")
local TravelingMerchantActionRemote = getRemote("TravelingMerchantAction")
local BalloonPilotActionRemote      = getRemote("BalloonPilotAction")
local MedalRewardsFolder            = ReplicatedStorage:FindFirstChild("MedalRewardsRemotes")
local MedalRequestRemote            = MedalRewardsFolder and MedalRewardsFolder:FindFirstChild("Request")

-- Workspace Entity Folders & Anchors
local ActiveFishFolder  = Workspace:FindFirstChild("ActiveFish")
local DownedFishFolder  = Workspace:FindFirstChild("DownedFish")
local FishCoolerModel   = Workspace:FindFirstChild("FishCooler")
local WeaponCrateModel  = Workspace:FindFirstChild("WeaponCrate")
local MedalNpcModel     = Workspace:FindFirstChild("NPC[MEDAL]")
local DogSpot1          = Workspace:FindFirstChild("DogSpot")
local DogSpot2          = Workspace:FindFirstChild("DogSpot2")
local DogSpot3          = Workspace:FindFirstChild("DogSpot3")

Workspace.ChildAdded:Connect(function(child)
    if child.Name == "ActiveFish" then ActiveFishFolder = child
    elseif child.Name == "DownedFish" then DownedFishFolder = child
    elseif child.Name == "FishCooler" then FishCoolerModel = child
    elseif child.Name == "WeaponCrate" then WeaponCrateModel = child
    elseif child.Name == "NPC[MEDAL]" then MedalNpcModel = child
    end
end)

-- Dedicated Spawned Boss Detection in Workspace
local function findSpawnedBoss()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Model") then
            if v:GetAttribute("BossTarget") == true
                or v:GetAttribute("BossKind") ~= nil
                or v.Name == "Boss"
                or string.find(v.Name:lower(), "boss") ~= nil
                or (string.find(v.Name:lower(), "shark") ~= nil and v.Parent == Workspace) then
                return v
            end
        end
    end
    return nil
end

-- ── Live Game State Synchronization ─────────────────────────────────────────────────
local GameState = {
    Day = 1,
    TeamCash = 0,
    Phase = "Day",
    DayEndsAt = 0,
    SkipDayAvailableAt = 0,
    PhaseEndsAt = 0,
    BossActive = false,
    BossName = "None",
    BossHealth = 0,
    BossMaxHealth = 1,
    EventWarning = "",
    ShoalWarning = false,
    Upgrades = {},
    UpgradeCosts = {},
    Research = {},
    StoredFish = 0,
    -- Player's Personal Weapon State
    EquippedGun = "Mosin",
    OwnedGuns = { Mosin = true },
    Ammo = { Mosin = 1 },
    Reloading = false,
    SelectedOrdnance = "Grenade",
    DiscoveredFish = {},
    ProjectedScaleReward = 0,
}

if StateUpdateRemote and StateUpdateRemote:IsA("RemoteEvent") then
    StateUpdateRemote.OnClientEvent:Connect(function(s1, s2)
        -- s1 = Team / World Game State
        if type(s1) == "table" then
            if s1.Day then GameState.Day = math.floor(tonumber(s1.Day) or GameState.Day) end
            if s1.TeamCash then GameState.TeamCash = math.floor(tonumber(s1.TeamCash) or GameState.TeamCash) end
            if s1.StoredFish ~= nil then GameState.StoredFish = math.max(0, math.floor(tonumber(s1.StoredFish) or 0)) end
            if s1.Phase then GameState.Phase = tostring(s1.Phase) end
            if s1.DayEndsAt then GameState.DayEndsAt = tonumber(s1.DayEndsAt) or 0 end
            if s1.SkipDayAvailableAt then GameState.SkipDayAvailableAt = tonumber(s1.SkipDayAvailableAt) or 0 end
            if s1.Upgrades then GameState.Upgrades = s1.Upgrades end
            if s1.UpgradeCosts then GameState.UpgradeCosts = s1.UpgradeCosts end
            if s1.DiscoveredFish then GameState.DiscoveredFish = s1.DiscoveredFish end
            if s1.DayEventWarning then GameState.EventWarning = tostring(s1.DayEventWarning) end
            if s1.ShoalWarning ~= nil then GameState.ShoalWarning = s1.ShoalWarning end

            if type(s1.Boss) == "table" then
                GameState.BossActive = (s1.Boss.Active == true)
                GameState.BossName = tostring(s1.Boss.Name or "Boss Shark")
                GameState.BossHealth = tonumber(s1.Boss.Health) or 0
                GameState.BossMaxHealth = tonumber(s1.Boss.MaxHealth) or 1
            else
                GameState.BossActive = false
            end
        end

        -- s2 = Personal Player Weapon State & Scale Rewards
        if type(s2) == "table" then
            if s2.EquippedGun then GameState.EquippedGun = tostring(s2.EquippedGun) end
            if s2.OwnedGuns then GameState.OwnedGuns = s2.OwnedGuns end
            if s2.Ammo then GameState.Ammo = s2.Ammo end
            if s2.Reloading ~= nil then GameState.Reloading = s2.Reloading end
            if s2.SelectedOrdnance then GameState.SelectedOrdnance = tostring(s2.SelectedOrdnance) end
            if s2.ProjectedScaleReward then
                GameState.ProjectedScaleReward = math.max(0, math.floor(tonumber(s2.ProjectedScaleReward) or 0))
            end
        end
    end)
end

-- ── Fish Catalog & Rarity Setup (Synchronized with FishIndexConfig) ─────────────────
local RarityWeights = {
    Common    = 1,
    Uncommon  = 2,
    Rare      = 3,
    Epic      = 4,
    Legendary = 5,
    Mythic    = 6,
    Boss      = 7,
}

local RarityColors = {
    Common    = Color3.fromRGB(200, 200, 200),
    Uncommon  = Color3.fromRGB(87, 213, 126),
    Rare      = Color3.fromRGB(82, 181, 255),
    Epic      = Color3.fromRGB(168, 85, 255),
    Legendary = Color3.fromRGB(255, 210, 54),
    Mythic    = Color3.fromRGB(255, 91, 91),
    Boss      = Color3.fromRGB(255, 30, 30),
}

local FishCatalog = {}

local function hydrateFishCatalog()
    if GameFishIndex and type(GameFishIndex.All) == "function" then
        local allFish = GameFishIndex.All()
        if type(allFish) == "table" then
            for _, f in ipairs(allFish) do
                if f.Id then
                    FishCatalog[f.Id] = {
                        Name     = f.DisplayName or f.Id,
                        Rarity   = f.Rarity or "Common",
                        Category = f.Category or f.Kind or "Normal",
                        Health   = f.Health or 15,
                        Value    = f.Value or 10,
                        Key      = f.DiscoveryKey,
                    }
                end
            end
        end
    end

    local defaultFish = {
        Fish         = { Name = "Trout",           Rarity = "Common",    Category = "Normal", Health = 15,  Value = 10 },
        MossFish     = { Name = "Moss Trout",      Rarity = "Uncommon",  Category = "Normal", Health = 23,  Value = 15 },
        StripeFish   = { Name = "Striped Trout",   Rarity = "Rare",      Category = "Normal", Health = 42,  Value = 25 },
        TigerFish    = { Name = "Tiger Trout",     Rarity = "Rare",      Category = "Normal", Health = 65,  Value = 40 },
        KoiFish      = { Name = "Koi Trout",       Rarity = "Epic",      Category = "Normal", Health = 92,  Value = 65 },
        RainbowFish  = { Name = "Rainbow Trout",   Rarity = "Epic",      Category = "Normal", Health = 123, Value = 100 },
        ToxicFish    = { Name = "Toxic Trout",     Rarity = "Legendary", Category = "Normal", Health = 170, Value = 150 },
        ArmoredFish  = { Name = "Armored Trout",   Rarity = "Legendary", Category = "Normal", Health = 230, Value = 225 },
        VoidFish     = { Name = "Void Trout",      Rarity = "Mythic",    Category = "Normal", Health = 350, Value = 500 },

        GiantFish    = { Name = "Giant Trout",     Rarity = "Uncommon",  Category = "Giant",  Health = 300, Value = 200 },
        GiantMoss    = { Name = "Giant Moss",      Rarity = "Rare",      Category = "Giant",  Health = 460, Value = 300 },
        GiantStripe  = { Name = "Giant Striped",   Rarity = "Rare",      Category = "Giant",  Health = 840, Value = 500 },
        GiantTiger   = { Name = "Giant Tiger",     Rarity = "Epic",      Category = "Giant",  Health = 1300,Value = 800 },
        GiantKoi     = { Name = "Giant Koi",       Rarity = "Epic",      Category = "Giant",  Health = 1840,Value = 1300 },
        GiantRainbow = { Name = "Giant Rainbow",   Rarity = "Legendary", Category = "Giant",  Health = 2460,Value = 2000 },
        GiantToxic   = { Name = "Giant Toxic",     Rarity = "Legendary", Category = "Giant",  Health = 3400,Value = 3000 },
        GiantArmored = { Name = "Giant Armored",   Rarity = "Mythic",    Category = "Giant",  Health = 4600,Value = 4500 },
        GiantVoid    = { Name = "Giant Void",      Rarity = "Mythic",    Category = "Giant",  Health = 7000,Value = 10000 },

        GoldFish     = { Name = "Golden Trout",    Rarity = "Legendary", Category = "Gold",    Health = 80,  Value = 1000 },
        GiantGold    = { Name = "Giant Gold",      Rarity = "Mythic",    Category = "Gold",    Health = 1600,Value = 20000 },
        RedFish      = { Name = "Crimson Fish",    Rarity = "Legendary", Category = "Special", Health = 100, Value = 750 },
        Shark        = { Name = "Boss Shark",      Rarity = "Boss",      Category = "Boss",    Health = 2500,Value = 5000 },
        Gator        = { Name = "Ancient Gator",   Rarity = "Boss",      Category = "Boss",    Health = 3500,Value = 8000 },
    }

    for id, data in pairs(defaultFish) do
        if not FishCatalog[id] then
            FishCatalog[id] = data
        end
    end
end
hydrateFishCatalog()

local function getFishMeta(model)
    if not model then return nil end
    local kind = model:GetAttribute("FishKind") or model:GetAttribute("Kind") or model.Name
    if FishCatalog[kind] then return FishCatalog[kind] end
    for id, data in pairs(FishCatalog) do
        if string.find(model.Name, id) or (data.Name and string.find(model.Name, data.Name)) then
            return data
        end
    end
    return {
        Name = model.Name,
        Rarity = model:GetAttribute("Rarity") or "Common",
        Category = model:GetAttribute("Category") or "Normal",
        Health = tonumber(model:GetAttribute("Health")) or 50,
        Value = tonumber(model:GetAttribute("Value")) or 10,
    }
end

-- ── Gun Catalog & Setup ─────────────────────────────────────────────────────────────
local AllGunKeys = {
    "Mosin", "Pistol", "Uzi", "AWP", "MilitaryShotgun", "ArcticAK", "Vector", "GoldenScar",
    "PinkSPAS12", "ObsidianRPK", "GoldenM249", "ExclusiveArcticAK", "ExclusiveGoldenScar"
}

local GunDisplayNames = {
    Mosin               = "Mosin-Nagant (Rifle)",
    Pistol              = "Pistol (Sidearm)",
    Uzi                 = "Uzi (Submachine)",
    AWP                 = "AWP (Heavy Sniper)",
    MilitaryShotgun     = "Military Shotgun (Scatter)",
    ArcticAK            = "Arctic AK (Assault)",
    Vector              = "Vector (Rapid SMG)",
    GoldenScar          = "Golden Scar (LMG)",
    PinkSPAS12          = "Pink SPAS-12 (Legendary Shotgun)",
    ObsidianRPK         = "Obsidian RPK (Legendary Heavy)",
    GoldenM249          = "Golden M249 (Legendary Squad)",
    ExclusiveArcticAK   = "Ice Bizon (Exclusive Frost)",
    ExclusiveGoldenScar = "Lava PKM (Exclusive Inferno)",
}

-- ── PinatHub Config State Table ─────────────────────────────────────────────────────
local FG = {
    -- Combat
    AutoShoot            = false,
    AutoShootDelay       = 0.08,
    UseModuleFireRate    = true,
    SilentAim            = false,
    MultiTarget          = false,
    InstantKill          = false,
    TargetPriority       = "Bosses First",
    TargetMinRarity      = "All Fish",
    MaxTargetDistance    = 1200,
    PrioritizeBosses     = true,
    InfiniteAmmo         = false,
    AutoReload           = true,
    NoReload             = false,
    SelectedWeapon       = "Mosin",
    AutoEquipOnRespawn   = true,
    AutoOrdnance         = false,
    AutoOrdnanceKey      = "Grenade",
    AutoOrdnanceTrigger  = "When Boss Exists",
    WeaponAuraEffect     = false,

    -- Farm & Economy
    AutoPushFish         = false,
    PushRadius           = 40,
    AutoCatchDowned      = false,
    AutoCollectScales    = true,
    AutoSellCatch        = false,
    SellThreshold        = 10,
    AutoOpenFreeCrates   = false,
    AutoClaimMedals      = false,
    AutoMerchantBuy      = false,

    -- Upgrades
    AutoUpgradeAll       = false,
    UpgradesSelected     = {
        FishValue = false, FishRarity = false, FishChain = false,
        Damage = false, Magazine = false, Reload = false,
        DogSpeed = false, DogCarry = false, DogAutoDeposit = false,
        TurretCount = false, TurretDamage = false, TurretFireSpeed = false,
        RedTurretCount = false, BetterDock = false, AdditionalDogs = false,
        Airstrike = false, AirstrikeCooldown = false,
    },
    AutoResearchUnlock   = false,

    -- Survival
    GodMode              = false,
    AntiKnockback        = false,
    AutoRespawn          = false,
    AntiTsunami          = false,
    AntiFlashbang        = false,
    AntiInk              = false,
    CancelBiteDamage     = false,
    InfiniteOxygen       = false,
    WaterSurfaceWalk     = false,

    -- Movement
    SpeedHack            = false,
    SpeedMultiplier      = 32,
    Fly                  = false,
    FlySpeed             = 50,
    Noclip               = false,
    InfiniteJump         = false,
    AutoSkipDay          = false,

    -- ESP & Look
    FishESP              = false,
    FishESPShowNames     = true,
    FishESPShowDist      = true,
    BossESP              = true,
    HazardESP            = false,
    DogESP               = false,
    CrateESP             = false,

    -- Graphics & Visual Tweaks
    FieldOfView          = 70,
    CustomFOVEnabled     = false,
    Fullbright           = false,
    NoShadows            = false,
    ClearWater           = false,
    PotatoMode           = false,
    NoFog                = false,
    LockTime             = false,
    CustomTime           = 14,
    RotateSkybox         = false,
    ColorBoost           = false,
}

local function commas(n)
    local s = tostring(math.floor(tonumber(n) or 0))
    return s:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

-- ── Load PinatHub / KingRua Library ─────────────────────────────────────────────────
local PinatHubAdapter = nil

local function loadLibrary()
    if getgenv and (getgenv().PinatHubAdapter or getgenv().PinatHubLibrary) then
        return getgenv().PinatHubAdapter or getgenv().PinatHubLibrary
    end

    -- 1. Try local executor workspace file safely with pcall
    if readfile and isfile then
        local candidates = {
            "kingrualibrarysource.lua",
            "pinathublibraryREAL/kingrualibrarysource.lua",
        }
        for _, path in ipairs(candidates) do
            local fileExists = false
            pcall(function()
                fileExists = isfile(path)
            end)
            if fileExists then
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

    -- 2. Fetch from GitHub raw
    local sourceUrls = {
        "https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/main/kingrualibrarysource.lua",
        "https://raw.githubusercontent.com/stokompetgacor23-dotcom/intregation-pinathub-to-kingrua-library-1/main/kingrualibrarysource.lua",
        "https://raw.githubusercontent.com/stokompetgacor23-dotcom/intregation-pinathub-to-kingrua-library-1/refs/heads/main/kingrualibrarysource.lua",
    }
    for _, url in ipairs(sourceUrls) do
        local okGet, src = pcall(function() return game:HttpGet(url) end)
        if okGet and src and src ~= "" then
            local fn, err = loadstring(src)
            if fn then
                local okCall, res = pcall(fn)
                if okCall and res then return res end
            end
        end
    end

    error("Failed to load PinatHub library from all local and remote sources")
end

local ok, result = pcall(loadLibrary)
if ok then
    PinatHubAdapter = result
else
    warn("[FishGame PinatHub] Library load failed:", result)
end

-- ── Profile & Config Manager ────────────────────────────────────────────────────────
local ConfigFolderName = "PinatHub_FishGame"
if makefolder and isfolder and not isfolder(ConfigFolderName) then makefolder(ConfigFolderName) end
getgenv().FG_CurrentConfig = "Default"
local UI_Controls = {}

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
    name = (name and name ~= "") and name or getgenv().FG_CurrentConfig
    if not name or name == "" then name = "Default" end
    local ok = false
    pcall(function()
        if writefile then
            if makefolder and isfolder and not isfolder(ConfigFolderName) then
                makefolder(ConfigFolderName)
            end
            writefile(ConfigFolderName .. "/" .. name .. ".json", HttpService:JSONEncode(FG))
            ok = true
        end
    end)
    return ok
end

local function LoadConfig(name)
    name = (name and name ~= "") and name or getgenv().FG_CurrentConfig
    if not name or name == "" then name = "Default" end
    local path = ConfigFolderName .. "/" .. name .. ".json"
    local ok = false
    pcall(function()
        if readfile and isfile and isfile(path) then
            local data = HttpService:JSONDecode(readfile(path))
            if type(data) == "table" then
                for k, v in pairs(data) do
                    FG[k] = v
                end
                for fgKey, ctrl in pairs(UI_Controls) do
                    if ctrl and type(ctrl.Set) == "function" then
                        if fgKey:sub(1, 3) == "Up_" then
                            local upKey = fgKey:sub(4)
                            if type(FG.UpgradesSelected) == "table" and FG.UpgradesSelected[upKey] ~= nil then
                                pcall(function() ctrl:Set(FG.UpgradesSelected[upKey]) end)
                            end
                        elseif FG[fgKey] ~= nil then
                            pcall(function() ctrl:Set(FG[fgKey]) end)
                        end
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
    name = (name and name ~= "") and name or getgenv().FG_CurrentConfig
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

-- ── Weapon Equip Helper (Instant Server Fire) ───────────────────────────────────────
local function equipGun(gunId)
    if not gunId or gunId == "" then return end
    FG.SelectedWeapon = gunId
    GameState.EquippedGun = gunId
    if WeaponActionRemote then
        pcall(function()
            WeaponActionRemote:FireServer("Equip", gunId)
            WeaponActionRemote:FireServer("RequestState")
        end)
    end
    if PinatHubAdapter and PinatHubAdapter.Notify then
        pcall(function()
            PinatHubAdapter:Notify({
                Title = "Weapon Equipped",
                Content = "Equipped: " .. (GunDisplayNames[gunId] or gunId),
                Duration = 2
            })
        end)
    end
end

-- ── Create Window ───────────────────────────────────────────────────────────────────
local Window
if PinatHubAdapter then
    Window = PinatHubAdapter:CreateWindow({
        Title    = "PinatHub — Fish Game",
        SubTitle = "Module-Integrated Engine",
        Game     = "Fish Game",
        Version  = "2.2.0 Native",
        Logo     = "rbxassetid://118264723961739",
        OnClose  = function()
            FG.GodMode = false
            FG.AutoShoot = false
            FG.Fly = false
            FG.SpeedHack = false
        end,
    })
end
if not Window then
    warn("[FishGame PinatHub] Window initialization failed.")
    return
end

local function makeTab(title, icon) return Window:T({ Title = title, Icon = icon }) end

-- ── Create Tabs (Exact Lucide Icons - 0 Duplicate Home Icons) ───────────────────────
local TabCombat   = makeTab("Combat",          "crosshair")
local TabFarm     = makeTab("Farming",         "fish")
local TabUpgrade  = makeTab("Upgrades",        "arrow-up")
local TabSurvival = makeTab("Survival",        "heart")
local TabMovement = makeTab("Movement",        "teleport")
local TabESP      = makeTab("ESP & Look",      "eye")
local TabGraphics = makeTab("Graphics & Data", "sliders")
local TabSettings = makeTab("Settings",        "settings")

-- ══════════════════════════════════════════════════════════════════════════════════
-- 🎯 TAB 1: COMBAT (Weapon, Aim, & Heavy Artillery)
-- ══════════════════════════════════════════════════════════════════════════════════
do
    local combatNav = TabCombat:AddSubNav({
        Categories = {
            { Name = "Aim & Target",    Icon = "crosshair" },
            { Name = "Weapons & Ammo",  Icon = "swords" },
            { Name = "Heavy Artillery", Icon = "flame" },
            { Name = "Legendary & FX",  Icon = "sparkles" },
        },
        IncludeAll = true,
    })

    local subAim     = combatNav:GetSubTab("Aim & Target")
    local subWeapons = combatNav:GetSubTab("Weapons & Ammo")
    local subOrd     = combatNav:GetSubTab("Heavy Artillery")
    local subFX      = combatNav:GetSubTab("Legendary & FX")

    -- 1. Aim & Targeting Section
    local shootSec = subAim:AddSection({ Title = "Auto Shoot & Target System" })
    UI_Controls.AutoShoot = shootSec:AddToggle({ Title = "Auto Shoot", Flag = "Auto Shoot", Default = false, Description = "Fires using game aim raycast and server payload", Callback = function(v) FG.AutoShoot = v end })
    UI_Controls.PrioritizeBosses = shootSec:AddToggle({ Title = "Prioritize Spawned Bosses", Flag = "Prioritize Bosses", Default = true, Description = "Instantly locks onto Boss (Shark/Gator) as soon as it spawns in Workspace", Callback = function(v) FG.PrioritizeBosses = v end })
    UI_Controls.UseModuleFireRate = shootSec:AddToggle({ Title = "Use Module Fire Rate", Flag = "Module Fire Rate", Default = true, Description = "Calculates fire rate via GameConfig.GunFireInterval()", Callback = function(v) FG.UseModuleFireRate = v end })
    UI_Controls.AutoShootDelay = shootSec:AddSlider({ Title = "Custom Fire Delay (ms)", Flag = "Shoot Delay", Min = 1, Max = 50, Default = 8, Description = "Used when Module Fire Rate is disabled", Callback = function(v) FG.AutoShootDelay = v / 100 end })
    UI_Controls.SilentAim = shootSec:AddToggle({ Title = "Silent Aim", Flag = "Silent Aim", Default = false, Description = "Snaps raycast bullets directly to target pivot vector", Callback = function(v) FG.SilentAim = v end })
    UI_Controls.MultiTarget = shootSec:AddToggle({ Title = "Multi-Target / Chain Hit", Flag = "MultiTarget", Default = false, Description = "Packages up to 16 fish in candidateFish array", Callback = function(v) FG.MultiTarget = v end })
    UI_Controls.InstantKill = shootSec:AddToggle({ Title = "Instant Kill Burst", Flag = "Instant Kill", Default = false, Description = "Prioritizes low HP fish to clear waves instantly", Callback = function(v) FG.InstantKill = v end })

    shootSec:AddDropdown({
        Title = "Target Priority", Flag = "Target Priority",
        Values = {"Bosses First", "Highest Rarity", "Nearest", "Lowest HP", "Highest HP"},
        Default = "Bosses First", Multi = false,
        Callback = function(v) FG.TargetPriority = type(v) == "table" and v[1] or v or "Bosses First" end
    })

    shootSec:AddDropdown({
        Title = "Minimum Rarity Filter", Flag = "Target Min Rarity",
        Values = {"All Fish", "Uncommon+", "Rare+", "Epic+", "Legendary+", "Mythic+", "Boss Only"},
        Default = "All Fish", Multi = false,
        Callback = function(v) FG.TargetMinRarity = type(v) == "table" and v[1] or v or "All Fish" end
    })

    local defaultRange = (GameConfig and GameConfig.MaxRange) or 1200
    UI_Controls.MaxTargetDistance = shootSec:AddSlider({
        Title = "Max Target Range (Studs)", Flag = "Max Range",
        Min = 200, Max = 2500, Default = defaultRange,
        Callback = function(v) FG.MaxTargetDistance = v end
    })

    -- 2. Weapons & Ammo Section
    local gunSec = subWeapons:AddSection({ Title = "Weapons & Ammo (Config Module)" })
    UI_Controls.InfiniteAmmo = gunSec:AddToggle({ Title = "Infinite Ammo Mode", Flag = "Infinite Ammo", Default = false, Description = "Bypasses ammo check and keeps magazine full", Callback = function(v) FG.InfiniteAmmo = v end })
    UI_Controls.AutoReload = gunSec:AddToggle({ Title = "Auto Fast Reload", Flag = "Auto Fast Reload", Default = true, Description = "Sends reload packet as soon as magazine empties", Callback = function(v) FG.AutoReload = v end })
    UI_Controls.NoReload = gunSec:AddToggle({ Title = "No Reload Animation", Flag = "No Reload", Default = false, Description = "Skips weapon recoil delays", Callback = function(v) FG.NoReload = v end })
    UI_Controls.AutoEquipOnRespawn = gunSec:AddToggle({ Title = "Auto Re-Equip on Respawn", Flag = "Auto Re-Equip", Default = true, Description = "Automatically re-equips your selected weapon when respawning or round changes", Callback = function(v) FG.AutoEquipOnRespawn = v end })

    gunSec:AddDropdown({
        Title = "Select Gun to Equip (Instant Server Equip)", Flag = "Selected Weapon",
        Values = AllGunKeys, Default = "Mosin", Multi = false,
        Callback = function(v)
            local chosen = type(v) == "table" and v[1] or v or "Mosin"
            equipGun(chosen)
        end
    })

    gunSec:AddButton({
        Title = "Force Equip Selected Weapon",
        Description = "Sends WeaponAction:Equip and RequestState remotes",
        Callback = function()
            equipGun(FG.SelectedWeapon)
        end
    })

    -- 3. Heavy Artillery Section
    local ordSec = subOrd:AddSection({ Title = "Heavy Artillery (Config.Ordnance)" })
    UI_Controls.AutoOrdnance = ordSec:AddToggle({ Title = "Auto Ordnance", Flag = "Auto Ordnance", Default = false, Description = "Drops heavy ordnance on active fish/bosses", Callback = function(v) FG.AutoOrdnance = v end })

    local ordList = (GameConfig and GameConfig.OrdnanceOrder) or {"Grenade", "Dynamite", "Carpet", "Orbital", "Nuke"}
    ordSec:AddDropdown({
        Title = "Ordnance Type", Flag = "Ordnance Type",
        Values = ordList, Default = "Grenade", Multi = false,
        Callback = function(v) FG.AutoOrdnanceKey = type(v) == "table" and v[1] or v or "Grenade" end
    })

    ordSec:AddDropdown({
        Title = "Ordnance Trigger Condition", Flag = "Ordnance Trigger",
        Values = {"When Boss Exists", "Always on Cooldown", "Fish Cluster (>= 4)"},
        Default = "When Boss Exists", Multi = false,
        Callback = function(v) FG.AutoOrdnanceTrigger = type(v) == "table" and v[1] or v or "When Boss Exists" end
    })

    ordSec:AddButton({
        Title = "Trigger Ordnance Now",
        Description = "Invokes OrdnanceAction:Use on current position",
        Callback = function()
            if OrdnanceActionRemote and Root then
                pcall(function()
                    OrdnanceActionRemote:FireServer("Select", FG.AutoOrdnanceKey)
                    OrdnanceActionRemote:FireServer("Use", Root.Position)
                end)
            end
        end
    })

    -- 4. Legendary Guns & FX Section
    local fxSec = subFX:AddSection({ Title = "Legendary & Exclusive Arsenal" })
    fxSec:AddParagraph({
        Title = "NormalGunConfig Legendary Guns",
        Content = "[Legendary] Pink SPAS-12: Instant Shark Kill (3 Fish/Hit) | Obsidian RPK: Armor Penetration (2 Fish/Hit) | Golden M249: Squad Sweeper (4 Fish/Hit)",
    })
    fxSec:AddParagraph({
        Title = "MonetizationConfig Exclusive Guns",
        Content = "[Exclusive] Ice Bizon (Frost): Freezes and slows fish | Lava PKM (Inferno): Incinerates targets with elemental fire",
    })
    UI_Controls.WeaponAuraEffect = fxSec:AddToggle({
        Title = "Exclusive Weapon Elemental Aura", Flag = "Weapon Aura", Default = false,
        Description = "Applies Fire/Ice elemental tints and particles via ExclusiveWeaponEffects",
        Callback = function(v) FG.WeaponAuraEffect = v end
    })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- 🐟 TAB 2: FARMING & ECONOMY (Conveyor, Sales, Crates)
-- ══════════════════════════════════════════════════════════════════════════════════
do
    local farmNav = TabFarm:AddSubNav({
        Categories = {
            { Name = "River Harvest",     Icon = "fish" },
            { Name = "Pet Automation",    Icon = "backpack" },
            { Name = "Economy & Sales",   Icon = "dollar-sign" },
            { Name = "Merchant & Crates", Icon = "package" },
        },
        IncludeAll = true,
    })

    local subRiver    = farmNav:GetSubTab("River Harvest")
    local subPets     = farmNav:GetSubTab("Pet Automation")
    local subEcon     = farmNav:GetSubTab("Economy & Sales")
    local subMerchant = farmNav:GetSubTab("Merchant & Crates")

    -- 1. River Harvest Section
    local pushSec = subRiver:AddSection({ Title = "Fish Conveyor & Harvester (FishPush Remote)" })
    UI_Controls.AutoPushFish = pushSec:AddToggle({
        Title = "Auto Push Fish to Dock", Flag = "Auto Push Fish", Default = false,
        Description = "Invokes FishPush remote to drag fish directly into the team dock",
        Callback = function(v) FG.AutoPushFish = v end
    })
    UI_Controls.PushRadius = pushSec:AddSlider({
        Title = "Push Search Radius (Studs)", Flag = "Push Radius",
        Min = 10, Max = 150, Default = 40,
        Callback = function(v) FG.PushRadius = v end
    })

    local farmSec = subRiver:AddSection({ Title = "Downed Fish Catching (FishCooler Collection)" })
    UI_Controls.AutoCatchDowned = farmSec:AddToggle({
        Title = "Auto Down Fish Catch", Flag = "Auto Down Fish", Default = false,
        Description = "Teleports downed fish into FishCooler so team can collect cash immediately",
        Callback = function(v) FG.AutoCatchDowned = v end
    })
    farmSec:AddButton({
        Title = "Instant Collect All Downed Fish",
        Description = "Transfers all dead fish on river bank to player cooler in 1 click",
        Callback = function()
            if DownedFishFolder and FishCoolerModel and Root then
                local coolerPos = FishCoolerModel:GetPivot().Position
                for _, f in ipairs(DownedFishFolder:GetChildren()) do
                    if f:IsA("Model") and (f.PrimaryPart or f:FindFirstChildWhichIsA("BasePart")) then
                        pcall(function() f:PivotTo(CFrame.new(coolerPos)) end)
                    end
                end
            end
        end
    })

    -- 2. Pet Automation Section
    local petSec = subPets:AddSection({ Title = "Dog & Pet Automation (PetAbilities)" })
    UI_Controls.AutoCollectScales = petSec:AddToggle({
        Title = "Auto Collect Dropped Scales", Flag = "Auto Collect Scales", Default = true,
        Description = "Auto claims boss scales and bonus tokens dropped by pets",
        Callback = function(v) FG.AutoCollectScales = v end
    })
    petSec:AddParagraph({
        Title = "Active Pet Perks",
        Content = "Waffles / Biscuit: Auto carry downed fish to cooler | Dog Speed & Carry Capacity synchronized with GameConfig",
    })

    -- 3. Economy & Sales Section
    local econSec = subEcon:AddSection({ Title = "Fish Sales & Team Bank" })
    UI_Controls.AutoSellCatch = econSec:AddToggle({
        Title = "Auto Sell Catch", Flag = "Auto Sell", Default = false,
        Description = "Sells catch when cooler reaches minimum threshold",
        Callback = function(v) FG.AutoSellCatch = v end
    })
    UI_Controls.SellThreshold = econSec:AddSlider({
        Title = "Auto Sell Threshold (Count)", Flag = "Sell Threshold",
        Min = 1, Max = 50, Default = 5,
        Callback = function(v) FG.SellThreshold = v end
    })
    econSec:AddButton({
        Title = "Sell All Fish Now",
        Description = "Fires SellFish via UpgradeAction remote to cash in stored fish",
        Callback = function()
            if UpgradeActionRemote then
                pcall(function() UpgradeActionRemote:FireServer("SellFish") end)
            end
            if PinatHubAdapter and PinatHubAdapter.Notify then
                pcall(function()
                    PinatHubAdapter:Notify({
                        Title = "Sell Fish Triggered",
                        Content = "Triggered SellFish. Stored Fish: " .. tostring(GameState.StoredFish or 0),
                        Duration = 2,
                    })
                end)
            end
        end
    })

    -- 4. Merchant & Crates Section
    local crateSec = subMerchant:AddSection({ Title = "Weapon Crates & Medals (CratePresentationClient)" })
    UI_Controls.AutoOpenFreeCrates = crateSec:AddToggle({
        Title = "Auto Open Free Weapon Crates", Flag = "Auto Crates", Default = false,
        Description = "Interacts with WeaponCrate model to unbox guns for free",
        Callback = function(v) FG.AutoOpenFreeCrates = v end
    })
    crateSec:AddButton({
        Title = "Open Weapon Crate Once",
        Description = "Teleports prompt or triggers Crate unboxing",
        Callback = function()
            if WeaponCrateModel and Root then
                local prompt = WeaponCrateModel:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then fireproximityprompt(prompt) end
            end
        end
    })

    UI_Controls.AutoClaimMedals = crateSec:AddToggle({
        Title = "Auto Claim Medals (MedalClient)", Flag = "Auto Medals", Default = false,
        Description = "Interacts with NPC[MEDAL] and requests unlocked milestones",
        Callback = function(v) FG.AutoClaimMedals = v end
    })

    local merchSec = subMerchant:AddSection({ Title = "Traveling Merchant Automation (TravelingMerchantClient)" })
    UI_Controls.AutoMerchantBuy = merchSec:AddToggle({
        Title = "Auto Buy Merchant Health & Dodge", Flag = "Auto Merchant Buy", Default = false,
        Description = "Automatically purchases Health and Dodge upgrades when Traveling Merchant is active",
        Callback = function(v) FG.AutoMerchantBuy = v end
    })
    merchSec:AddButton({
        Title = "Buy Traveling Merchant Health Now",
        Description = "Invokes TravelingMerchantAction:Buy, Health",
        Callback = function()
            if TravelingMerchantActionRemote then
                pcall(function() TravelingMerchantActionRemote:InvokeServer("Buy", "Health") end)
            end
        end
    })
    merchSec:AddButton({
        Title = "Buy Traveling Merchant Dodge Now",
        Description = "Invokes TravelingMerchantAction:Buy, Dodge",
        Callback = function()
            if TravelingMerchantActionRemote then
                pcall(function() TravelingMerchantActionRemote:InvokeServer("Buy", "Dodge") end)
            end
        end
    })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- ⚡ TAB 3: UPGRADES & BASE PROGRESSION
-- ══════════════════════════════════════════════════════════════════════════════════
do
    local upgradeNav = TabUpgrade:AddSubNav({
        Categories = {
            { Name = "Gun Mastery",     Icon = "crosshair" },
            { Name = "World & Turrets", Icon = "shield" },
            { Name = "Research Lab",    Icon = "cpu" },
            { Name = "Pass & Medals",   Icon = "trophy" },
        },
        IncludeAll = true,
    })

    local subGun      = upgradeNav:GetSubTab("Gun Mastery")
    local subWorld    = upgradeNav:GetSubTab("World & Turrets")
    local subResearch = upgradeNav:GetSubTab("Research Lab")
    local subMedals   = upgradeNav:GetSubTab("Pass & Medals")

    -- 1. Gun Mastery Upgrades
    local masterSec = subGun:AddSection({ Title = "Master Upgrade Controller" })
    UI_Controls.AutoUpgradeAll = masterSec:AddToggle({
        Title = "Auto Upgrade Everything", Flag = "Auto Upgrade All", Default = false,
        Description = "Automatically buys all unlocked upgrades whenever Team Cash is sufficient",
        Callback = function(v) FG.AutoUpgradeAll = v end
    })
    masterSec:AddButton({
        Title = "Upgrade All Config Nodes Once",
        Description = "Iterates through all upgrade keys and sends UpgradeAction remote",
        Callback = function()
            if not UpgradeActionRemote then return end
            local allKeys = {
                "FishValue", "FishRarity", "FishChain",
                "Damage", "Magazine", "Reload",
                "DogSpeed", "DogCarry", "DogAutoDeposit",
                "TurretCount", "TurretDamage", "TurretFireSpeed", "RedTurretCount",
                "BetterDock", "AdditionalDogs", "Airstrike", "AirstrikeCooldown"
            }
            for _, k in ipairs(allKeys) do
                pcall(function() UpgradeActionRemote:FireServer("Upgrade", k) end)
            end
        end
    })

    local gunUpSec = subGun:AddSection({ Title = "Gun Upgrades (Config.UpgradeOrder)" })
    UI_Controls.Up_Damage = gunUpSec:AddToggle({ Title = "Bigger Bullets (Damage)", Flag = "Up_Damage", Default = false, Callback = function(v) FG.UpgradesSelected.Damage = v end })
    UI_Controls.Up_Magazine = gunUpSec:AddToggle({ Title = "Too Much Ammo (Magazine)", Flag = "Up_Magazine", Default = false, Callback = function(v) FG.UpgradesSelected.Magazine = v end })
    UI_Controls.Up_Reload = gunUpSec:AddToggle({ Title = "More Reloading (Reload)", Flag = "Up_Reload", Default = false, Callback = function(v) FG.UpgradesSelected.Reload = v end })

    -- 2. World & Turrets Upgrades
    local turretUpSec = subWorld:AddSection({ Title = "Turrets & Base Fortification (TurretAnimationClient)" })
    UI_Controls.Up_TurretCount = turretUpSec:AddToggle({ Title = "Buy Turret (TurretCount)", Flag = "Up_TurretCount", Default = false, Callback = function(v) FG.UpgradesSelected.TurretCount = v end })
    UI_Controls.Up_TurretDamage = turretUpSec:AddToggle({ Title = "Turret Damage (TurretDamage)", Flag = "Up_TurretDamage", Default = false, Callback = function(v) FG.UpgradesSelected.TurretDamage = v end })
    UI_Controls.Up_TurretFireSpeed = turretUpSec:AddToggle({ Title = "Turret Fire Speed (TurretFireSpeed)", Flag = "Up_TurretFireSpeed", Default = false, Callback = function(v) FG.UpgradesSelected.TurretFireSpeed = v end })
    UI_Controls.Up_RedTurretCount = turretUpSec:AddToggle({ Title = "Red Turret (RedTurretCount)", Flag = "Up_RedTurretCount", Default = false, Callback = function(v) FG.UpgradesSelected.RedTurretCount = v end })
    UI_Controls.Up_BetterDock = turretUpSec:AddToggle({ Title = "Build Better Dock (BetterDock)", Flag = "Up_BetterDock", Default = false, Callback = function(v) FG.UpgradesSelected.BetterDock = v end })
    UI_Controls.Up_AdditionalDogs = turretUpSec:AddToggle({ Title = "More Dogs (AdditionalDogs)", Flag = "Up_AdditionalDogs", Default = false, Callback = function(v) FG.UpgradesSelected.AdditionalDogs = v end })
    UI_Controls.Up_Airstrike = turretUpSec:AddToggle({ Title = "Unlock Airstrike (Airstrike)", Flag = "Up_Airstrike", Default = false, Callback = function(v) FG.UpgradesSelected.Airstrike = v end })
    UI_Controls.Up_AirstrikeCooldown = turretUpSec:AddToggle({ Title = "Airstrike Cooldown", Flag = "Up_AirstrikeCooldown", Default = false, Callback = function(v) FG.UpgradesSelected.AirstrikeCooldown = v end })

    -- 3. Research Lab Upgrades
    local rschSec = subResearch:AddSection({ Title = "Research Lab Upgrades (ResearchConfig)" })
    UI_Controls.AutoResearchUnlock = rschSec:AddToggle({
        Title = "Auto Unlock Research Nodes", Flag = "Auto Research", Default = false,
        Description = "Automatically unlocks research tech tree nodes via ResearchAction",
        Callback = function(v) FG.AutoResearchUnlock = v end
    })

    -- 4. Pass & Medals Section
    local passSec = subMedals:AddSection({ Title = "Fish Value & Catch Multipliers" })
    UI_Controls.Up_FishValue = passSec:AddToggle({ Title = "Valuable Fish (FishValue)", Flag = "Up_FishValue", Default = false, Callback = function(v) FG.UpgradesSelected.FishValue = v end })
    UI_Controls.Up_FishRarity = passSec:AddToggle({ Title = "Rare Fish (FishRarity)", Flag = "Up_FishRarity", Default = false, Callback = function(v) FG.UpgradesSelected.FishRarity = v end })
    UI_Controls.Up_FishChain = passSec:AddToggle({ Title = "They Found Us Bro (FishChain)", Flag = "Up_FishChain", Default = false, Callback = function(v) FG.UpgradesSelected.FishChain = v end })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- 🛡️ TAB 4: SURVIVAL & HAZARDS
-- ══════════════════════════════════════════════════════════════════════════════════
do
    local survNav = TabSurvival:AddSubNav({
        Categories = {
            { Name = "Health & Immortality", Icon = "heart" },
            { Name = "Bite & Hazards",       Icon = "shield" },
            { Name = "Water Mechanics",      Icon = "droplet" },
        },
        IncludeAll = true,
    })

    local subHealth = survNav:GetSubTab("Health & Immortality")
    local subHaz    = survNav:GetSubTab("Bite & Hazards")
    local subWater  = survNav:GetSubTab("Water Mechanics")

    -- 1. Health & Immortality Section
    local godSec = subHealth:AddSection({ Title = "Player Immortality & Health Locks" })
    UI_Controls.GodMode = godSec:AddToggle({
        Title = "GodMode (Infinite Health & Death Canceler)", Flag = "GodMode", Default = false,
        Description = "Cancels DeathState remote calls and forces Health to MaxHealth every frame",
        Callback = function(v) FG.GodMode = v end
    })
    UI_Controls.AntiKnockback = godSec:AddToggle({ Title = "Anti Knockback / Anti Fling", Flag = "Anti Knockback", Default = false, Callback = function(v) FG.AntiKnockback = v end })
    UI_Controls.AutoRespawn = godSec:AddToggle({ Title = "Instant Auto Respawn", Flag = "Auto Respawn", Default = false, Callback = function(v) FG.AutoRespawn = v end })

    -- 2. Bite & Hazard Protection Section
    local hazSec = subHaz:AddSection({ Title = "Hazard Immunity (Tsunami, Ink, Bites)" })
    UI_Controls.CancelBiteDamage = hazSec:AddToggle({
        Title = "Shark & Gator Bite Canceler", Flag = "Cancel Bite Damage", Default = true,
        Description = "Stops boss bite damage and cancels bite camera shake",
        Callback = function(v) FG.CancelBiteDamage = v end
    })
    UI_Controls.AntiTsunami = hazSec:AddToggle({ Title = "Anti Tsunami Protection", Flag = "Anti Tsunami", Default = false, Description = "Anchors player or elevates above wave level during tsunami event", Callback = function(v) FG.AntiTsunami = v end })
    UI_Controls.AntiFlashbang = hazSec:AddToggle({ Title = "Anti Flashbang Fish", Flag = "Anti Flashbang", Default = false, Description = "Removes white screen flashbang GUI instantly", Callback = function(v) FG.AntiFlashbang = v end })
    UI_Controls.AntiInk = hazSec:AddToggle({ Title = "Anti Octopus Ink", Flag = "Anti Ink", Default = false, Description = "Clears ink overlay GUI", Callback = function(v) FG.AntiInk = v end })

    -- 3. Water Mechanics Section
    local waterSec = subWater:AddSection({ Title = "Water Physics & Surface Walk" })
    UI_Controls.InfiniteOxygen = waterSec:AddToggle({
        Title = "Infinite Oxygen / No Drowning", Flag = "Infinite Oxygen", Default = false,
        Description = "Prevents oxygen depletion while underwater",
        Callback = function(v) FG.InfiniteOxygen = v end
    })
    UI_Controls.WaterSurfaceWalk = waterSec:AddToggle({
        Title = "Water Surface Walk", Flag = "Water Walk", Default = false,
        Description = "Creates an invisible solid surface over water to walk without swimming",
        Callback = function(v) FG.WaterSurfaceWalk = v end
    })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- ⚡ TAB 5: MOVEMENT & TELEPORTS
-- ══════════════════════════════════════════════════════════════════════════════════
do
    local moveNav = TabMovement:AddSubNav({
        Categories = {
            { Name = "Speed & Jump",    Icon = "zap" },
            { Name = "Flight & Noclip", Icon = "compass" },
            { Name = "Fast Teleports",  Icon = "teleport" },
        },
        IncludeAll = true,
    })

    local subSpeed = moveNav:GetSubTab("Speed & Jump")
    local subFly   = moveNav:GetSubTab("Flight & Noclip")
    local subTP    = moveNav:GetSubTab("Fast Teleports")

    -- 1. Speed & Jump Section
    local speedSec = subSpeed:AddSection({ Title = "Player WalkSpeed & Jump Mods" })
    UI_Controls.SpeedHack = speedSec:AddToggle({ Title = "SpeedHack", Flag = "SpeedHack", Default = false, Callback = function(v) FG.SpeedHack = v end })
    UI_Controls.SpeedMultiplier = speedSec:AddSlider({ Title = "WalkSpeed Multiplier", Flag = "WalkSpeed Multi", Min = 16, Max = 150, Default = 32, Callback = function(v) FG.SpeedMultiplier = v end })
    UI_Controls.InfiniteJump = speedSec:AddToggle({ Title = "Infinite Jump", Flag = "Infinite Jump", Default = false, Callback = function(v) FG.InfiniteJump = v end })

    -- 2. Flight & Noclip Section
    local flySec = subFly:AddSection({ Title = "Flight & Noclip Suite" })
    UI_Controls.Fly = flySec:AddToggle({ Title = "Fly (WASD + Space/Ctrl)", Flag = "Fly", Default = false, Callback = function(v) FG.Fly = v end })
    UI_Controls.FlySpeed = flySec:AddSlider({ Title = "Fly Speed", Flag = "Fly Speed", Min = 10, Max = 150, Default = 50, Callback = function(v) FG.FlySpeed = v end })
    UI_Controls.Noclip = flySec:AddToggle({ Title = "Noclip", Flag = "Noclip", Default = false, Callback = function(v) FG.Noclip = v end })

    -- 3. Teleports Section
    local tpSec = subTP:AddSection({ Title = "Important World Locations" })
    local function tpTo(pos)
        if Root then Root.CFrame = CFrame.new(pos) end
    end

    tpSec:AddButton({
        Title = "Teleport to Team Dock",
        Callback = function()
            tpTo(Vector3.new(0, 10, 0))
        end
    })
    tpSec:AddButton({
        Title = "Teleport to Fish Cooler",
        Callback = function()
            if FishCoolerModel then
                tpTo(FishCoolerModel:GetPivot().Position + Vector3.new(0, 5, 0))
            end
        end
    })
    tpSec:AddButton({
        Title = "Teleport to Weapon Crate",
        Callback = function()
            if WeaponCrateModel then
                tpTo(WeaponCrateModel:GetPivot().Position + Vector3.new(0, 5, 0))
            end
        end
    })
    tpSec:AddButton({
        Title = "Teleport to Medal NPC",
        Callback = function()
            if MedalNpcModel then
                tpTo(MedalNpcModel:GetPivot().Position + Vector3.new(0, 5, 0))
            end
        end
    })
    tpSec:AddButton({
        Title = "Teleport to Spawned Boss",
        Description = "Teleports right above active boss in Workspace",
        Callback = function()
            local b = findSpawnedBoss()
            if b and Root then
                local pos = b:GetPivot().Position
                Root.CFrame = CFrame.new(pos + Vector3.new(0, 25, 0))
            end
        end
    })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- 👁️ TAB 6: ESP & VISUALS (Synchronized with FishIndex & Config)
-- ══════════════════════════════════════════════════════════════════════════════════
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "PinatHub_ESP_Drawings"
ESPFolder.Parent = Workspace

local function clearESP()
    for _, child in ipairs(ESPFolder:GetChildren()) do child:Destroy() end
end

local function createBillboard(model, text, color, distText)
    local head = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not head then return end

    local bb = Instance.new("BillboardGui")
    bb.Name = "FishESP_" .. model.Name
    bb.Adornee = head
    bb.Size = UDim2.new(0, 140, 0, 40)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent = ESPFolder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.6, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.2
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Parent = bb

    local distLabel = Instance.new("TextLabel")
    distLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distLabel.Size = UDim2.new(1, 0, 0.4, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = distText or ""
    distLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 10
    distLabel.Parent = bb

    return bb, distLabel
end

local function refreshAllESP()
    clearESP()
    if not Root then return end

    -- 1. Fish ESP
    if FG.FishESP and ActiveFishFolder then
        for _, f in ipairs(ActiveFishFolder:GetChildren()) do
            if f:IsA("Model") then
                local meta = getFishMeta(f)
                local color = (meta and RarityColors[meta.Rarity]) or Color3.fromRGB(255, 255, 255)
                local dist = math.floor((Root.Position - f:GetPivot().Position).Magnitude)
                local nameText = FG.FishESPShowNames and (meta and meta.Name or f.Name) or ""
                local distText = FG.FishESPShowDist and string.format("[%dm]", dist) or ""
                createBillboard(f, nameText, color, distText)
            end
        end
    end

    -- 2. Boss ESP (Highlight Spawned Boss with Bright Crimson Red)
    if FG.BossESP then
        local boss = findSpawnedBoss()
        if boss then
            local dist = math.floor((Root.Position - boss:GetPivot().Position).Magnitude)
            local hp = boss:GetAttribute("Health") or boss:GetAttribute("BossHealth") or 2500
            createBillboard(boss, "⚠️ [BOSS] " .. boss.Name .. " (" .. tostring(hp) .. " HP)", Color3.fromRGB(255, 30, 30), string.format("[%dm]", dist))
        end
    end
end

do
    local espNav = TabESP:AddSubNav({
        Categories = {
            { Name = "Fish ESP",           Icon = "fish" },
            { Name = "Boss & Threat ESP",  Icon = "skull" },
            { Name = "World Entities",     Icon = "eye" },
        },
        IncludeAll = true,
    })

    local subFish  = espNav:GetSubTab("Fish ESP")
    local subBoss  = espNav:GetSubTab("Boss & Threat ESP")
    local subWorld = espNav:GetSubTab("World Entities")
    local fSec = subFish:AddSection({ Title = "Fish ESP (Rarity Color Coding)" })
    UI_Controls.FishESP = fSec:AddToggle({
        Title = "Fish ESP", Flag = "Fish ESP", Default = false,
        Callback = function(v)
            FG.FishESP = v
            if not v then clearESP() end
        end
    })
    UI_Controls.FishESPShowNames = fSec:AddToggle({ Title = "Show Fish Name Tags", Flag = "Show Fish Name", Default = true, Callback = function(v) FG.FishESPShowNames = v end })
    UI_Controls.FishESPShowDist = fSec:AddToggle({ Title = "Show Distance In Meters", Flag = "Show Distance", Default = true, Callback = function(v) FG.FishESPShowDist = v end })

    local bSec = subBoss:AddSection({ Title = "Boss Shark & Gator ESP" })
    UI_Controls.BossESP = bSec:AddToggle({ Title = "Boss (Shark/Gator) ESP", Flag = "Boss ESP", Default = true, Description = "Renders persistent billboard and warnings over spawned Boss", Callback = function(v) FG.BossESP = v end })

    local eSec = subWorld:AddSection({ Title = "World Entities ESP" })
    UI_Controls.DogESP = eSec:AddToggle({ Title = "Dog ESP (Waffles, Biscuit)", Flag = "Dog ESP", Default = false, Callback = function(v) FG.DogESP = v end })
    UI_Controls.CrateESP = eSec:AddToggle({ Title = "Weapon Crate & Medal NPC ESP", Flag = "Crate ESP", Default = false, Callback = function(v) FG.CrateESP = v end })
    eSec:AddButton({ Title = "Force Refresh All ESP", Callback = refreshAllESP })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- 📊 TAB 7: GRAPHICS & REAL-TIME DATA (Replaces Dashboard)
-- ══════════════════════════════════════════════════════════════════════════════════
local PerformanceStatusPara, RiverStatusPara, BossStatusPara, EconomyStatusPara, fpsGraph

do
    local gfxNav = TabGraphics:AddSubNav({
        Categories = {
            { Name = "Live Telemetry",     Icon = "bar-chart" },
            { Name = "Visual Tweaks",      Icon = "eye" },
            { Name = "Performance Boost",  Icon = "zap" },
            { Name = "Lighting & World",   Icon = "sliders" },
        },
        IncludeAll = true,
    })

    local subTelemetry = gfxNav:GetSubTab("Live Telemetry")
    local subVisuals   = gfxNav:GetSubTab("Visual Tweaks")
    local subPerf      = gfxNav:GetSubTab("Performance Boost")
    local subLighting  = gfxNav:GetSubTab("Lighting & World")

    -- 1. Live Telemetry Section (Real-Time Graph & Monitors)
    local telemSec = subTelemetry:AddSection({ Title = "Real-Time Game & System Telemetry" })

    fpsGraph = telemSec:AddGraph({
        Title = "Client FPS History",
        BarCount = 14,
        MaxValue = 120,
        Height = 90,
        Unit = " FPS",
    })

    PerformanceStatusPara = telemSec:AddParagraph({
        Title = "System Performance",
        Content = "FPS: Calculating... | Ping: Calculating...",
    })

    RiverStatusPara = telemSec:AddParagraph({
        Title = "River Fish Telemetry",
        Content = "Active River Fish: 0 | Downed Catch: 0",
    })

    BossStatusPara = telemSec:AddParagraph({
        Title = "Boss Telemetry",
        Content = "No Boss Spawned (Peaceful Waters)",
    })

    EconomyStatusPara = telemSec:AddParagraph({
        Title = "Live Economy & Scales",
        Content = "Day: 1 (Day) | Team Cash: $0 | Projected Scales: 0",
    })

    -- 2. Visual Tweaks Section
    local visSec = subVisuals:AddSection({ Title = "Camera & Viewport Customization" })
    UI_Controls.CustomFOVEnabled = visSec:AddToggle({
        Title = "Enable Custom Field of View", Flag = "Custom FOV Enabled", Default = false,
        Description = "Overrides camera FOV with custom value",
        Callback = function(v)
            FG.CustomFOVEnabled = v
            if not v and Camera then Camera.FieldOfView = 70 end
        end
    })
    UI_Controls.FieldOfView = visSec:AddSlider({
        Title = "Field Of View (FOV)", Flag = "Camera FOV",
        Min = 40, Max = 120, Default = 70,
        Callback = function(v)
            FG.FieldOfView = v
            if FG.CustomFOVEnabled and Camera then
                Camera.FieldOfView = v
            end
        end
    })
    UI_Controls.ClearWater = visSec:AddToggle({
        Title = "Clear Transparent Water", Flag = "Clear Water", Default = false,
        Description = "Removes water murkiness, waves, and reflections for crystal clear visibility",
        Callback = function(v)
            FG.ClearWater = v
            pcall(function()
                local terrain = Workspace:FindFirstChildOfClass("Terrain")
                if terrain then
                    if v then
                        terrain.WaterTransparency = 1
                        terrain.WaterWaveSize = 0
                        terrain.WaterWaveSpeed = 0
                        terrain.WaterReflectance = 0
                        terrain.WaterColor = Color3.fromRGB(160, 220, 255)
                    else
                        terrain.WaterTransparency = 0.3
                        terrain.WaterWaveSize = 0.15
                        terrain.WaterWaveSpeed = 10
                        terrain.WaterReflectance = 0.05
                    end
                end
            end)
        end
    })
    UI_Controls.NoFog = visSec:AddToggle({
        Title = "Remove Fog", Flag = "No Fog", Default = false,
        Description = "Pushes fog distance to infinite for maximum visibility",
        Callback = function(v)
            FG.NoFog = v
            if v then
                Lighting.FogEnd = 100000
                Lighting.FogStart = 0
            end
        end
    })

    -- 3. Performance Boost Section
    local perfSec = subPerf:AddSection({ Title = "Potato Mode & FPS Optimizer" })
    UI_Controls.PotatoMode = perfSec:AddToggle({
        Title = "Potato Mode (Extreme FPS Boost)", Flag = "Potato Mode", Default = false,
        Description = "Disables heavy particle emitters, smoke, trails, decals and sets plastic textures",
        Callback = function(v)
            FG.PotatoMode = v
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                        obj.Enabled = not v
                    elseif obj:IsA("BasePart") then
                        if v then
                            obj.CastShadow = false
                            if obj.Material ~= Enum.Material.SmoothPlastic then
                                obj.Material = Enum.Material.SmoothPlastic
                            end
                        end
                    end
                end
                if v then
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 100000
                end
            end)
        end
    })
    UI_Controls.NoShadows = perfSec:AddToggle({
        Title = "Disable All Shadows", Flag = "No Shadows", Default = false,
        Description = "Turns off GlobalShadows in Lighting service",
        Callback = function(v)
            FG.NoShadows = v
            Lighting.GlobalShadows = not v
        end
    })
    perfSec:AddButton({
        Title = "Clean Ground Decals & Blood",
        Description = "Deletes client side blood splatters and debris",
        Callback = function()
            pcall(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("Decal") and (string.find(obj.Name:lower(), "blood") or string.find(obj.Name:lower(), "splat")) then
                        obj:Destroy()
                    end
                end
            end)
        end
    })

    -- 4. Lighting & World Atmosphere Section
    local lightSec = subLighting:AddSection({ Title = "World Lighting & Day Time Control" })
    UI_Controls.Fullbright = lightSec:AddToggle({
        Title = "Fullbright (Night Vision Mode)", Flag = "Fullbright", Default = false,
        Description = "Forces maximum ambient lighting so dark caves and nights are fully illuminated",
        Callback = function(v)
            FG.Fullbright = v
            if v then
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 2
                Lighting.GlobalShadows = false
            end
        end
    })
    UI_Controls.LockTime = lightSec:AddToggle({
        Title = "Lock Time Of Day", Flag = "Lock Time", Default = false,
        Description = "Locks clock time to your preferred hour",
        Callback = function(v) FG.LockTime = v end
    })
    UI_Controls.CustomTime = lightSec:AddSlider({
        Title = "Clock Time (Hours)", Flag = "Clock Time",
        Min = 0, Max = 24, Default = 14,
        Callback = function(v)
            FG.CustomTime = v
            if FG.LockTime then Lighting.ClockTime = v end
        end
    })
    UI_Controls.ColorBoost = lightSec:AddToggle({
        Title = "Vibrant Color Boost", Flag = "Color Boost", Default = false,
        Description = "Applies high saturation color correction effect",
        Callback = function(v)
            FG.ColorBoost = v
            local cc = Lighting:FindFirstChild("PinatHub_ColorCorrection")
            if not cc then
                cc = Instance.new("ColorCorrectionEffect")
                cc.Name = "PinatHub_ColorCorrection"
                cc.Parent = Lighting
            end
            cc.Enabled = v
            cc.Saturation = 0.35
            cc.Contrast = 0.15
        end
    })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- ⚙️ TAB 8: SETTINGS & PROFILES
-- ══════════════════════════════════════════════════════════════════════════════════
do
    local setSec = TabSettings:AddSection({ Title = "Profile & Config Manager" })

    local profileNameInput = setSec:AddInput({
        Title = "Config Profile Name",
        PlaceHolder = "Enter config name...",
        Default = getgenv().FG_CurrentConfig or "Default",
        Callback = function(val)
            val = tostring(val or ""):gsub("^%s+", ""):gsub("%s+$", "")
            if val ~= "" then
                getgenv().FG_CurrentConfig = val
            end
        end,
    })

    local function getActiveProfile()
        local name = ""
        if profileNameInput and typeof(profileNameInput) == "Instance" and profileNameInput:IsA("TextBox") then
            name = profileNameInput.Text or ""
        elseif type(profileNameInput) == "table" and profileNameInput.Text then
            name = tostring(profileNameInput.Text)
        end
        name = tostring(name):gsub("^%s+", ""):gsub("%s+$", "")
        if name == "" then
            name = tostring(getgenv().FG_CurrentConfig or "Default"):gsub("^%s+", ""):gsub("%s+$", "")
        end
        if name == "" then name = "Default" end
        getgenv().FG_CurrentConfig = name
        return name
    end

    local configDropdown = setSec:AddDropdown({
        Title = "Saved Configs", Flag = "Config List",
        Values = GetConfigList(), Default = getgenv().FG_CurrentConfig or "Default", Multi = false,
        Callback = function(v)
            local chosen = type(v) == "table" and v[1] or v or "Default"
            chosen = tostring(chosen):gsub("^%s+", ""):gsub("%s+$", "")
            if chosen ~= "" then
                getgenv().FG_CurrentConfig = chosen
                if profileNameInput and typeof(profileNameInput) == "Instance" and profileNameInput:IsA("TextBox") then
                    profileNameInput.Text = chosen
                end
            end
        end,
    })

    setSec:AddButton({
        Title = "Save Current Config",
        Description = "Saves all current hub settings to the specified config name",
        Callback = function()
            local activeName = getActiveProfile()
            local ok = SaveConfig(activeName)
            local list = GetConfigList()
            if configDropdown and configDropdown.Refresh then
                pcall(function() configDropdown:Refresh(list, activeName) end)
            end
            if PinatHubAdapter and PinatHubAdapter.Notify then
                pcall(function()
                    PinatHubAdapter:Notify({
                        Title = "Config Saved",
                        Content = ok and ("Saved config as: " .. activeName) or "Failed to write config file!",
                        Duration = 3,
                    })
                end)
            end
        end,
    })

    setSec:AddButton({
        Title = "Load Selected Config",
        Description = "Loads settings from the specified config and updates UI controls",
        Callback = function()
            local activeName = getActiveProfile()
            local ok = LoadConfig(activeName)
            if PinatHubAdapter and PinatHubAdapter.Notify then
                pcall(function()
                    PinatHubAdapter:Notify({
                        Title = "Config Loaded",
                        Content = ok and ("Loaded config: " .. activeName) or ("Config '" .. activeName .. "' not found!"),
                        Duration = 3,
                    })
                end)
            end
        end,
    })

    setSec:AddButton({
        Title = "Delete Selected Config",
        Description = "Permanently deletes the selected config file (cannot delete Default)",
        Callback = function()
            local activeName = getActiveProfile()
            if activeName == "Default" then
                if PinatHubAdapter and PinatHubAdapter.Notify then
                    pcall(function()
                        PinatHubAdapter:Notify({
                            Title = "Cannot Delete",
                            Content = "The 'Default' config profile cannot be deleted.",
                            Duration = 3,
                        })
                    end)
                end
                return
            end
            local ok = DeleteConfig(activeName)
            getgenv().FG_CurrentConfig = "Default"
            if profileNameInput and typeof(profileNameInput) == "Instance" and profileNameInput:IsA("TextBox") then
                profileNameInput.Text = "Default"
            end
            local list = GetConfigList()
            if configDropdown and configDropdown.Refresh then
                pcall(function() configDropdown:Refresh(list, "Default") end)
            end
            if PinatHubAdapter and PinatHubAdapter.Notify then
                pcall(function()
                    PinatHubAdapter:Notify({
                        Title = "Config Deleted",
                        Content = ok and ("Deleted config: " .. activeName) or "Failed to delete file!",
                        Duration = 3,
                    })
                end)
            end
        end,
    })

    setSec:AddButton({
        Title = "Refresh Config List",
        Description = "Rescans the saved config directory for changes",
        Callback = function()
            local activeName = getActiveProfile()
            local list = GetConfigList()
            if configDropdown and configDropdown.Refresh then
                pcall(function() configDropdown:Refresh(list, activeName) end)
            end
            if PinatHubAdapter and PinatHubAdapter.Notify then
                pcall(function()
                    PinatHubAdapter:Notify({
                        Title = "Configs Refreshed",
                        Content = "Found " .. tostring(#list) .. " config profiles.",
                        Duration = 2,
                    })
                end)
            end
        end,
    })

    local hubSec = TabSettings:AddSection({ Title = "Hub Management" })
    hubSec:AddButton({
        Title = "Unload Script & Cleanup",
        Description = "Restores all settings, disconnects loops, and destroys UI",
        Callback = function()
            FG.GodMode = false
            FG.AutoShoot = false
            FG.Fly = false
            FG.SpeedHack = false
            clearESP()
            if Window then Window:Close() end
        end
    })
end

-- ══════════════════════════════════════════════════════════════════════════════════
-- 🚀 CORE AUTOMATION ENGINE & GAME MODULE LOOPS
-- ══════════════════════════════════════════════════════════════════════════════════

-- 1. Aim & Targeting Helper (Scans BOTH Workspace for Bosses and ActiveFish for regular fish)
local function getBestFishTarget()
    if not Root then return nil, nil end
    local candidates = {}
    local maxRange = (GameConfig and GameConfig.MaxRange) or FG.MaxTargetDistance

    -- 1. Scan for Boss directly in Workspace
    for _, model in ipairs(Workspace:GetChildren()) do
        if model:IsA("Model") then
            local isBoss = (model:GetAttribute("BossTarget") == true)
                or (model:GetAttribute("BossKind") ~= nil)
                or (model.Name == "Boss")
                or (string.find(model.Name:lower(), "boss") ~= nil)
                or (string.find(model.Name:lower(), "shark") ~= nil and model.Parent == Workspace)

            if isBoss then
                local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                if part then
                    local pos = part.Position
                    local dist = (Root.Position - pos).Magnitude
                    if dist <= maxRange then
                        local bossHp = tonumber(model:GetAttribute("Health"))
                            or tonumber(model:GetAttribute("BossHealth"))
                            or 2500
                        table.insert(candidates, {
                            Model = model,
                            Position = pos,
                            Distance = dist,
                            Weight = 999999, -- Boss is always absolute highest priority!
                            Category = "Boss",
                            Rarity = "Boss",
                            Health = bossHp,
                            IsBoss = true,
                        })
                    end
                end
            end
        end
    end

    -- 2. Scan for regular swimming fish in ActiveFish
    if ActiveFishFolder then
        for _, model in ipairs(ActiveFishFolder:GetChildren()) do
            local isFishTarget = (model:GetAttribute("FishTarget") == true) or (model:FindFirstChild("FishTarget") ~= nil) or model:IsA("Model")
            if isFishTarget then
                local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                if part then
                    local pos = part.Position
                    local dist = (Root.Position - pos).Magnitude
                    if dist <= maxRange then
                        local meta = getFishMeta(model)
                        local weight = (meta and RarityWeights[meta.Rarity]) or 1

                        local valid = true
                        if FG.TargetMinRarity == "Boss Only" then
                            valid = false -- Regular fish excluded when Boss Only is selected
                        elseif FG.TargetMinRarity ~= "All Fish" then
                            local targetRarityWeight = RarityWeights[FG.TargetMinRarity:gsub("%+", "")] or 1
                            if weight < targetRarityWeight then valid = false end
                        end

                        if valid then
                            table.insert(candidates, {
                                Model = model,
                                Position = pos,
                                Distance = dist,
                                Weight = weight,
                                Category = meta and meta.Category or "Normal",
                                Rarity = meta and meta.Rarity or "Common",
                                Health = meta and meta.Health or 100,
                                IsBoss = false,
                            })
                        end
                    end
                end
            end
        end
    end

    if #candidates == 0 then return nil, nil end

    -- Sort candidates based on priority
    if FG.PrioritizeBosses or FG.TargetPriority == "Bosses First" then
        table.sort(candidates, function(a, b)
            local aBoss = a.IsBoss and 1 or 0
            local bBoss = b.IsBoss and 1 or 0
            if aBoss ~= bBoss then return aBoss > bBoss end
            return a.Distance < b.Distance
        end)
    elseif FG.TargetPriority == "Highest Rarity" then
        table.sort(candidates, function(a, b)
            if a.Weight ~= b.Weight then return a.Weight > b.Weight end
            return a.Distance < b.Distance
        end)
    elseif FG.TargetPriority == "Nearest" then
        table.sort(candidates, function(a, b) return a.Distance < b.Distance end)
    elseif FG.TargetPriority == "Lowest HP" then
        table.sort(candidates, function(a, b) return a.Health < b.Health end)
    elseif FG.TargetPriority == "Highest HP" then
        table.sort(candidates, function(a, b) return a.Health > b.Health end)
    end

    local best = candidates[1]
    local multiList = {}
    if FG.MultiTarget then
        for i = 1, math.min(#candidates, 16) do
            table.insert(multiList, candidates[i].Model)
        end
    else
        table.insert(multiList, best.Model)
    end

    return best, multiList
end

-- 2. Auto Shoot Loop (Using GameConfig.GunFireInterval & WeaponAction:Fire)
local lastShootTime = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoShoot or not WeaponActionRemote or not Root then return end

    if LocalPlayer:GetAttribute("FishDead") == true or LocalPlayer:GetAttribute("FishLocalDead") == true or LocalPlayer:GetAttribute("FishVictory") == true then
        return
    end

    if GameState.Reloading and not FG.NoReload then
        return
    end

    local fireDelay = FG.AutoShootDelay
    if FG.UseModuleFireRate and GameConfig and GameConfig.Guns and type(GameConfig.GunFireInterval) == "function" then
        local currentGun = GameState.EquippedGun or FG.SelectedWeapon or "Mosin"
        local gunDef = GameConfig.Guns[currentGun] or GameConfig.Guns.Mosin
        if gunDef then
            fireDelay = GameConfig.GunFireInterval(gunDef, GameState.Upgrades, GameState.Research) or 0.15
        end
    end

    lastShootTime = lastShootTime + dt
    if lastShootTime < fireDelay then return end
    lastShootTime = 0

    local targetObj, targetList = getBestFishTarget()
    if not targetObj then return end

    local cam = Camera
    local origin = (cam and cam.CFrame.Position) or Root.Position
    local hitPos = targetObj.Position
    local dir = (hitPos - origin).Unit

    local payload = {
        origin = origin,
        direction = dir,
        target = hitPos,
        shotTime = Workspace:GetServerTimeNow(),
        candidateFish = targetList,
    }

    pcall(function()
        WeaponActionRemote:FireServer("Fire", payload)
    end)
end)

-- 3. Auto Reload Loop (Monitoring GameState.Ammo & WeaponAction:Reload)
local lastReloadCheck = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoReload or not WeaponActionRemote then return end
    lastReloadCheck = lastReloadCheck + dt
    if lastReloadCheck < 0.5 then return end
    lastReloadCheck = 0

    local currentGun = GameState.EquippedGun or FG.SelectedWeapon or "Mosin"
    local curAmmo = (GameState.Ammo and GameState.Ammo[currentGun]) or 1

    if FG.InfiniteAmmo then
        pcall(function() WeaponActionRemote:FireServer("Reload") end)
    elseif curAmmo <= 0 and not GameState.Reloading then
        pcall(function() WeaponActionRemote:FireServer("Reload") end)
    end
end)

-- 4. Auto Re-Equip Loop (Ensures Gun Stays Equipped After Respawn)
local lastEquipCheck = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoEquipOnRespawn or not WeaponActionRemote then return end
    lastEquipCheck = lastEquipCheck + dt
    if lastEquipCheck < 2 then return end
    lastEquipCheck = 0

    if GameState.EquippedGun ~= FG.SelectedWeapon and FG.SelectedWeapon then
        pcall(function()
            WeaponActionRemote:FireServer("Equip", FG.SelectedWeapon)
        end)
    end
end)

-- 5. Auto Push Fish Loop (FishPush Remote)
local lastPushTime = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoPushFish or not FishPushRemote or not Root or not ActiveFishFolder then return end
    lastPushTime = lastPushTime + dt
    if lastPushTime < 0.3 then return end
    lastPushTime = 0

    for _, f in ipairs(ActiveFishFolder:GetChildren()) do
        if f:IsA("Model") and (f.PrimaryPart or f:FindFirstChildWhichIsA("BasePart")) then
            local dist = (Root.Position - f:GetPivot().Position).Magnitude
            if dist <= FG.PushRadius then
                pcall(function()
                    FishPushRemote:FireServer(f)
                end)
            end
        end
    end
end)

-- 6. Auto Downed Catch & Sell Loops
local lastDownedCheck = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoCatchDowned or not DownedFishFolder or not FishCoolerModel then return end
    lastDownedCheck = lastDownedCheck + dt
    if lastDownedCheck < 0.5 then return end
    lastDownedCheck = 0

    local coolerPos = FishCoolerModel:GetPivot().Position
    for _, f in ipairs(DownedFishFolder:GetChildren()) do
        if f:IsA("Model") and (f.PrimaryPart or f:FindFirstChildWhichIsA("BasePart")) then
            pcall(function() f:PivotTo(CFrame.new(coolerPos)) end)
        end
    end
end)

-- 6b. Auto Sell Fish Loop (UpgradeAction:FireServer("SellFish"))
local lastSellCheck = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoSellCatch or not UpgradeActionRemote then return end
    lastSellCheck = lastSellCheck + dt
    if lastSellCheck < 1 then return end
    lastSellCheck = 0

    local threshold = math.max(1, FG.SellThreshold or 1)
    local currentStored = GameState.StoredFish or 0
    if currentStored >= threshold or (threshold == 1 and currentStored > 0) then
        pcall(function() UpgradeActionRemote:FireServer("SellFish") end)
    end
end)

-- 7. Auto Collect Scales Loop
local lastScaleCheck = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoCollectScales or not Root then return end
    lastScaleCheck = lastScaleCheck + dt
    if lastScaleCheck < 1 then return end
    lastScaleCheck = 0

    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj.Name == "ScaleToken" or obj.Name == "Scale" or string.find(obj.Name:lower(), "scale") then
            if obj:IsA("BasePart") then
                pcall(function() obj.CFrame = Root.CFrame end)
            elseif obj:IsA("Model") then
                pcall(function() obj:PivotTo(Root.CFrame) end)
            end
        end
    end
end)

-- 8. Traveling Merchant Automation Loop
local lastMerchantCheck = 0
RunService.Heartbeat:Connect(function(dt)
    if not FG.AutoMerchantBuy or not TravelingMerchantActionRemote then return end
    lastMerchantCheck = lastMerchantCheck + dt
    if lastMerchantCheck < 5 then return end
    lastMerchantCheck = 0

    pcall(function()
        TravelingMerchantActionRemote:InvokeServer("Buy", "Health")
        TravelingMerchantActionRemote:InvokeServer("Buy", "Dodge")
    end)
end)

-- 9. Auto Upgrades Loop (UpgradeAction Remote: FireServer("Upgrade", id))
local lastUpgradeTime = 0
RunService.Heartbeat:Connect(function(dt)
    if not UpgradeActionRemote then return end
    lastUpgradeTime = lastUpgradeTime + dt
    if lastUpgradeTime < 1 then return end
    lastUpgradeTime = 0

    if FG.AutoUpgradeAll then
        local allKeys = {
            "FishValue", "FishRarity", "FishChain",
            "Damage", "Magazine", "Reload",
            "DogSpeed", "DogCarry", "DogAutoDeposit",
            "TurretCount", "TurretDamage", "TurretFireSpeed", "RedTurretCount",
            "BetterDock", "AdditionalDogs", "Airstrike", "AirstrikeCooldown"
        }
        for _, k in ipairs(allKeys) do
            local cost = (GameState.UpgradeCosts and GameState.UpgradeCosts[k])
            if cost == nil or GameState.TeamCash >= cost then
                pcall(function() UpgradeActionRemote:FireServer("Upgrade", k) end)
            end
        end
    else
        for k, enabled in pairs(FG.UpgradesSelected) do
            if enabled then
                local cost = (GameState.UpgradeCosts and GameState.UpgradeCosts[k])
                if cost == nil or GameState.TeamCash >= cost then
                    pcall(function() UpgradeActionRemote:FireServer("Upgrade", k) end)
                end
            end
        end
    end
end)

-- 10. GodMode, Immortality, & Hazard Removal Loop
RunService.Heartbeat:Connect(function()
    if FG.GodMode and Humanoid then
        pcall(function()
            Humanoid.Health = Humanoid.MaxHealth
            if LocalPlayer:GetAttribute("FishDead") == true then LocalPlayer:SetAttribute("FishDead", false) end
            if LocalPlayer:GetAttribute("FishLocalDead") == true then LocalPlayer:SetAttribute("FishLocalDead", false) end
        end)
    end

    if FG.AntiKnockback and Root then
        pcall(function()
            local vel = Root.AssemblyLinearVelocity
            Root.AssemblyLinearVelocity = Vector3.new(vel.X, math.clamp(vel.Y, -100, 100), vel.Z)
        end)
    end

    if FG.AntiFlashbang or FG.AntiInk then
        pcall(function()
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if pg then
                if FG.AntiFlashbang then
                    local fb = pg:FindFirstChild("FlashbangGui") or pg:FindFirstChild("Flashbang")
                    if fb and fb:IsA("ScreenGui") then fb.Enabled = false end
                end
                if FG.AntiInk then
                    local ink = pg:FindFirstChild("InkGui") or pg:FindFirstChild("InkOverlay")
                    if ink and ink:IsA("ScreenGui") then ink.Enabled = false end
                end
            end
        end)
    end

    if FG.InfiniteOxygen then
        pcall(function()
            LocalPlayer:SetAttribute("Oxygen", 100)
            LocalPlayer:SetAttribute("FishUnderwaterOxygen", 100)
        end)
    end
end)

-- 11. Water Surface Walk Platform
local waterPlatform = nil
RunService.Heartbeat:Connect(function()
    if FG.WaterSurfaceWalk and Root then
        if not waterPlatform or not waterPlatform.Parent then
            waterPlatform = Instance.new("Part")
            waterPlatform.Name = "PinatHub_WaterWalkPlatform"
            waterPlatform.Size = Vector3.new(12, 1, 12)
            waterPlatform.Anchored = true
            waterPlatform.CanCollide = true
            waterPlatform.Transparency = 1
            waterPlatform.Parent = Workspace
        end
        waterPlatform.Position = Vector3.new(Root.Position.X, 0.5, Root.Position.Z)
    else
        if waterPlatform and waterPlatform.Parent then
            waterPlatform:Destroy()
            waterPlatform = nil
        end
    end
end)

-- 12. Movement Mods: SpeedHack & Fly Loop
RunService.Heartbeat:Connect(function()
    if FG.SpeedHack and Humanoid then
        Humanoid.WalkSpeed = FG.SpeedMultiplier
    end

    if FG.Noclip and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- Infinite Jump Listener
UserInputService.JumpRequest:Connect(function()
    if FG.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Flight Controller
local flyBodyGyro, flyBodyVel
RunService.RenderStepped:Connect(function()
    if FG.Fly and Root then
        if not flyBodyVel or not flyBodyVel.Parent then
            flyBodyVel = Instance.new("BodyVelocity")
            flyBodyVel.Velocity = Vector3.new(0, 0, 0)
            flyBodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            flyBodyVel.Parent = Root
        end
        if not flyBodyGyro or not flyBodyGyro.Parent then
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.P = 9e4
            flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyBodyGyro.CFrame = Root.CFrame
            flyBodyGyro.Parent = Root
        end

        local moveDir = Vector3.new(0, 0, 0)
        local camCF = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        flyBodyVel.Velocity = moveDir * FG.FlySpeed
        flyBodyGyro.CFrame = camCF
    else
        if flyBodyVel then
            flyBodyVel:Destroy()
            flyBodyVel = nil
        end
        if flyBodyGyro then
            flyBodyGyro:Destroy()
            flyBodyGyro = nil
        end
    end
end)

-- 13. Real-Time Telemetry & Graphics Monitor Loop (Runs every 0.5s)
local frameCount = 0
local lastFpsTime = tick()
local currentFps = 60

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastFpsTime >= 0.5 then
        currentFps = math.floor(frameCount / (now - lastFpsTime))
        frameCount = 0
        lastFpsTime = now
        if fpsGraph then
            pcall(function() fpsGraph:Push(currentFps) end)
        end
    end

    -- Camera FOV lock
    if FG.CustomFOVEnabled and Camera then
        Camera.FieldOfView = FG.FieldOfView
    end

    -- Lighting Fullbright & Shadows lock
    if FG.Fullbright then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
    end

    if FG.NoShadows then
        Lighting.GlobalShadows = false
    end

    if FG.LockTime then
        Lighting.ClockTime = FG.CustomTime
    end
end)

task.spawn(function()
    while task.wait(0.7) do
        -- Calculate Ping
        local ping = 0
        pcall(function()
            local stats = game:GetService("Stats")
            ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)

        -- River Fish population
        local activeCount = (ActiveFishFolder and #ActiveFishFolder:GetChildren()) or 0
        local downedCount = (DownedFishFolder and #DownedFishFolder:GetChildren()) or 0

        -- Boss Status
        local spawnedBoss = findSpawnedBoss()
        local bossText = "No Boss Spawned (Peaceful Waters)"
        if spawnedBoss then
            local bHp = spawnedBoss:GetAttribute("Health") or spawnedBoss:GetAttribute("BossHealth") or "Alive"
            local bName = spawnedBoss.Name
            bossText = string.format("⚠️ BOSS ACTIVE: %s | HP: %s", tostring(bName), tostring(bHp))
        elseif GameState.BossActive then
            bossText = string.format("⚠️ BOSS ACTIVE: %s | HP: %d/%d", GameState.BossName, GameState.BossHealth, GameState.BossMaxHealth)
        end

        -- Update Telemetry Paragraphs
        if PerformanceStatusPara and PerformanceStatusPara.SetText then
            pcall(function()
                PerformanceStatusPara:SetText("System Performance", string.format("FPS: %d FPS | Ping: %d ms | Render: Optimized", currentFps, ping))
            end)
        end

        if RiverStatusPara and RiverStatusPara.SetText then
            pcall(function()
                RiverStatusPara:SetText("River Fish Telemetry", string.format("Active River Fish: %d Swimming | Downed Catch: %d on Bank", activeCount, downedCount))
            end)
        end

        if BossStatusPara and BossStatusPara.SetText then
            pcall(function()
                BossStatusPara:SetText("Boss Telemetry", bossText)
            end)
        end

        if EconomyStatusPara and EconomyStatusPara.SetText then
            pcall(function()
                local projected = GameState.ProjectedScaleReward or 0
                EconomyStatusPara:SetText("Live Economy & Scales", string.format("Day %d (%s) | Team Cash: $%s | Est. Scale Reward: %s",
                    GameState.Day, GameState.Phase, commas(GameState.TeamCash), commas(projected)
                ))
            end)
        end

        -- Periodic ESP Refresh
        if FG.FishESP or FG.BossESP then
            pcall(refreshAllESP)
        end
    end
end)

print("[FishGame PinatHub] Engine v2.2.0 fully initialized and operational!")

end -- __FishGame_PinatHub_Main__

__FishGame_PinatHub_Main__()
