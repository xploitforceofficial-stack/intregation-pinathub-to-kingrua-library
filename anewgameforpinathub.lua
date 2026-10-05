-- Script Path: game:GetService("ReplicatedStorage").FishGame.Config
-- Took 0.05s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.FishGame.Config
-- Decompile time: 53.11 ms

local v1, v2, v3
local u833 = {TotalFish = 100000}
local u2 = {
    Easy = {
        FishGoal = 10000,
        NormalFishSpawnMultiplier = 1.5,
        FishCashMultiplier = 1.5,
        HostileMultiplier = 1,
        BossHealthMultiplier = 0.5,
        BossDamageMultiplier = 1,
        EventMultiplier = 1,
        LeaderboardEligible = true,
    },
}
u2.Normal = {
    NormalFishSpawnMultiplier = 1,
    FishCashMultiplier = 1,
    HostileMultiplier = 1,
    BossHealthMultiplier = 1,
    BossDamageMultiplier = 1,
    EventMultiplier = 1,
    LeaderboardEligible = true,
    FishGoal = u833.TotalFish,
}
u2.Hard = {
    FishGoal = 150000,
    NormalFishSpawnMultiplier = 1,
    FishCashMultiplier = 0.75,
    HostileMultiplier = 2,
    BossHealthMultiplier = 1,
    BossDamageMultiplier = 1,
    EventMultiplier = 1,
    LeaderboardEligible = true,
}
u833.Difficulties = {Easy = 1, Normal = 1, Hard = 2}

function u833.ValidDifficulty(a1) -- Line: 26 -- upvalues: u2 (val)
    if typeof(a1) == "string" and u2[a1] ~= nil then
        return a1
    end
    return "Normal"
end

function u833.DifficultySettings(a1) -- Line: 29 -- upvalues: u2 (val), u833 (val)
    return u2[u833.ValidDifficulty(a1)]
end

function u833.FishGoal(a1) -- Line: 32 -- upvalues: u833 (val)
    return u833.DifficultySettings(a1).FishGoal
end

function u833.DifficultyMultiplier(a1) -- Line: 36 -- upvalues: u833 (val)
    return u833.DifficultySettings(a1).HostileMultiplier
end

u833.CombatDamageScale = 10
u833.BaseMoneyPerFish = 1
u833.BaseCatchChance = 0.25
u833.SparkleMultiplier = 2
u833.SparklePatchCount = 3
u833.SparklePatchDiameter = 30
u833.SparklePatchSpeed = 9
u833.RemoteLimitPerSecond = 35
u833.MaxRange = 1200
u833.BulletRadius = 4.5
u833.FishChainRange = 65
u833.BaseOrdnanceCooldown = 60
u833.YardVisualCap = 200
u833.SharedFishVisualCap = 200
u833.FishFlightCaps = {Desktop = 250, Console = 200, Mobile = 200}
u833.FirstDayDuration = 180
u833.DayDuration = 300
u833.SkipDay = {AvailableAfter = 120}

function u833.DayDurationForDay(a1) -- Line: 63 -- upvalues: u833 (val) -- types: a1: number
    if math.max(1, (math.floor((tonumber(a1)) or 1))) == 1 then
        return u833.FirstDayDuration
    end
    return u833.DayDuration
end

u833.DayCycle = {
    DuskDuration = 6,
    BossSpawnDelay = 3,
    BossIntroDuration = 4,
    BossRewardDuration = 30,
    DawnDuration = 8,
    DayClockTime = 13.5,
    NightClockTime = 0.15,
    DuskClockTime = 19.5,
    DawnClockTime = 7,
}
u833.DeveloperProducts = {
    UpgradeProductId = 3711312241,
    UpgradePriceRobux = 49,
    RespawnProductId = 3659240920,
    RespawnPriceRobux = 29,
    PilotForeverProductId = 3708065771,
    PendingUpgradeStoreName = "FishPendingRobuxUpgrades_v1",
    UpgradeProductIds = {
        [9] = 3711312172,
        [19] = 3711312185,
        [29] = 3711312201,
        [39] = 3711312222,
        [49] = 3711312241,
        [59] = 3711312297,
    },
}
u833.Death = {
    RespawnWindow = 15,
    RespawnInvulnerability = 10,
    LobbyPlaceId = 113945994875620,
    SoundId = "rbxassetid://108015334317314",
    SoundVolume = 1,
    RespawnPriceRobux = u833.DeveloperProducts.RespawnPriceRobux,
    RespawnProductId = u833.DeveloperProducts.RespawnProductId,
}
u833.Persistence = {
    ProfileStoreName = "FishPlayerProfiles_v1",
    LifetimeFishOrderedStoreName = "FishLifetimeCaught_v1",
    TotalDaysOrderedStoreName = "FishHighestDay_v1",
    AutosaveInterval = 120,
    SaveAttempts = 3,
    SoloRunStoreName = "FishSoloRuns_v1",
    SoloRunAutosaveInterval = 30,
}
u833.ScaleEconomy = {BaseRunReward = 0, PerBossDefeated = 20, FishPerBonusScale = 50, MaximumFishBonus = 30}
u833.Music = {
    DaySoundId = "rbxassetid://140242542470126",
    DayVolume = 0.24,
    DayFadeOutDuration = 4.5,
    DayFadeInDuration = 2.5,
    BossSoundId = "rbxassetid://1846426912",
    BossVolume = 0.3,
    BossFadeInDuration = 2.5,
    BossFadeOutDuration = 1.25,
}
u833.Victory = {
    WinSoundId = "rbxassetid://132919665409307",
    WinSoundVolume = 1,
    MusicSoundId = "rbxassetid://127348322119521",
    MusicVolume = 0.4,
    MusicFadeInDuration = 3,
    OldMusicFadeOutDuration = 2.5,
}
u833.InterfaceSounds = {
    BuySoundId = "rbxassetid://133292918309565",
    BuySoundVolume = 0.8,
    OpenCloseSoundId = "rbxassetid://127877437691780",
    OpenCloseSoundVolume = 0.75,
    ReloadBulletSoundId = "rbxassetid://139827026287805",
    ReloadBulletSoundVolume = 0.8,
    PickupFishSoundId = "rbxassetid://5852470908",
    PickupFishSoundVolume = 0.9,
    SellFishSoundId = "rbxassetid://72764897006138",
    SellFishSoundVolume = 0.9,
}
u833.Ambience = {
    RiverSoundId = "rbxassetid://9119646672",
    RiverVolume = 0.7,
    RiverFullVolumeDistance = 25,
    RiverFadeDistance = 190,
    BirdSoundId = "rbxassetid://161361470",
    BirdVolume = 0.22,
    NightSoundId = "rbxassetid://179507208",
    NightVolume = 0.24,
    BossWarningNightVolume = 0.65,
    BossCombatNightVolume = 0.12,
    BossWarningFadeDuration = 1.25,
    BossRevealDuckDuration = 0.45,
    CrossfadeDuration = 2.75,
}
u833.Notifications = {
    SoundId = "rbxassetid://77108301434063",
    SoundVolume = 0.9,
    DiscoveryColor = Color3.fromRGB(91, 214, 255),
    MoneyColor = Color3.fromRGB(105, 255, 112),
    BossColor = Color3.fromRGB(255, 91, 91),
    GoldColor = Color3.fromRGB(255, 216, 61),
}
u833.DogNames = {"Waffles", "Biscuit", "Pickles"}
u833.Dogs = {BaseSpeed = 16, MaximumSpeed = 120, BarkRollOffMaxDistance = 145}
u833.Tutorial = {
    DogSpeed = 35,
    FishSpeedMultiplier = 0.45,
    CompletionMessageDuration = 4,
    DayTwoUpgradeReminderDelay = 30,
    DayTwoUpgradeReminderMaximumLevels = 2,
    HighlightColor = Color3.fromRGB(70, 255, 105),
    FishIncomingColor = Color3.fromRGB(255, 0, 32),
}
u833.Shoals = {
    WarningDuration = 8,
    WarningSoundId = "rbxassetid://1014740409",
    WarningSoundVolume = 1,
    Duration = 20,
    WarningIntervalMultiplier = 3,
    WarningCapMultiplier = 0.35,
    SpawnIntervalMultiplier = 0.2,
    SpawnBurst = 3,
    ActiveCapBonus = 48,
    BreachChance = 0.58,
    FirstDayAt = 120,
    FirstWindow = {90, 115},
    OnlyWindow = {205, 225},
    SecondWindow = {205, 230},
}
u833.DayEvents = {
    MinimumTimeAfterDayStart = 35,
    MinimumTimeBeforeNight = 55,
    Tsunami = {
        MinDay = 2,
        GuaranteedDay = 3,
        GuaranteedDelay = 35,
        CooldownDays = 1,
        BaseChancePerDay = 0.2,
        ChanceGrowthPerDay = 0.015,
        MaximumChancePerDay = 0.32,
        WarningDuration = 4.5,
        MinimumWaves = 3,
        MaximumWaves = 5,
        WaveSpacingMin = 4.5,
        WaveSpacingMax = 5.5,
        SpawnOffsetMax = 70,
        SwayDistanceMin = 14,
        SwayDistanceMax = 24,
        SwayPeriodMin = 5.5,
        SwayPeriodMax = 8,
        TravelPadding = 20,
        Damage = 20,
        FlingForwardSpeed = 135,
        FlingUpSpeed = 55,
        ControlLockDuration = 0.55,
        WaveSoundId = "rbxassetid://109932725679871",
        WaveSoundVolume = 3,
        WaveSoundMinDistance = 450,
        WaveSoundMaxDistance = 3000,
        Variants = {
            {
                Name = "Easy",
                Template = "EasyTsunamiWave",
                Weight = 74,
                Speed = 30.8,
                GapWidth = 105,
            },
            {
                Name = "Medium",
                Template = "MediumTsunamiWave",
                Weight = 20,
                Speed = 35,
                GapWidth = 55,
            },
            {
                Name = "Hard",
                Template = "HardTsunamiWave",
                Weight = 6,
                Speed = 39.9,
                GapWidth = 25,
            },
        },
    },
}
u833.RiverHazards = {
    ExplosiveBarrel = {
        MinDay = 2,
        SpawnChance = 0.0065,
        Template = "ExplosiveBarrel",
        DisplayName = "Explosive Barrel",
        HealthInExpectedShots = 1,
        Speed = 0.62,
        Scale = 1,
        BlastRadius = 68,
        Rotation = CFrame.identity,
        BlastDamage = 40 * u833.CombatDamageScale,
    },
    FlashbangFish = {
        MinDay = 2,
        SpawnChance = 0.003,
        Template = "Fish",
        DisplayName = "Flashbang Fish",
        HealthInExpectedShots = 1.25,
        Value = 40,
        Speed = 0.9,
        Scale = 2.5,
        AttackSpeed = 36,
        TrackingInterval = 0.14,
        RetreatSpeed = 38,
        HitRadius = 6,
        BiteDamage = 0,
        PostBiteSpeedMultiplier = 0.7,
        FlashRadius = 100,
        MaximumBlindDuration = 5,
        MaximumBrightness = 5,
        Rotation = CFrame.Angles(0, 1.5707963267948966, 0),
    },
    GiantFish = {
        MinDay = 2,
        SpawnChance = 0.012,
        CombinedFish = 20,
        ScaleMultiplier = 4.5,
        SpeedMultiplier = 0.42,
    },
    Gator = {
        MinDay = 2,
        SpawnChance = 0.0035,
        Template = "Gator",
        DisplayName = "Alligator",
        BaseHealth = 150,
        HealthPerDay = 25,
        BaseValue = 200,
        ValuePerDay = 35,
        Scale = 1,
        Speed = 0.5,
        AggroRadius = 32,
        AlertDuration = 1,
        AttackSpeed = 38,
        TrackingInterval = 0.2,
        RetreatSpeed = 18,
        BiteDamage = 20,
        HitRadius = 6,
        AttackCooldown = 5,
        PostBiteSpeedMultiplier = 0.55,
        PassiveSoundId = "rbxassetid://9114628818",
        AttackSoundId = "rbxassetid://121887934885380",
        BiteSoundId = "rbxassetid://108790087307118",
        Rotation = CFrame.Angles(1.5707963267948966, 0, 0),
    },
    Octopus = {
        MinDay = 2,
        SpawnChance = 0.004,
        Template = "Octopus",
        DisplayName = "Octopus",
        HealthInExpectedShots = 5,
        BaseValue = 75,
        ValuePerDay = 15,
        Scale = 1,
        Speed = 0.72,
        InkRadius = 20,
        InkDuration = 4,
        InkSoundId = "rbxassetid://126940490629306",
        Rotation = CFrame.identity,
    },
    Kayak = {
        MinDay = 2,
        SpawnChance = 0.004,
        Template = "Kayak",
        DisplayName = "Kayakers",
        BaseHealth = 150,
        HealthPerDay = 35,
        Scale = 1,
        Speed = 0.75,
        FloatAwayDuration = 6,
        Rotation = CFrame.identity,
    },
}
u833.RiverEncounters = {
    MinDay = 2,
    BaseChancePerDay = 0.28,
    ChanceGrowthPerDay = 0.015,
    MaximumChancePerDay = 0.42,
    MinimumTimeAfterDayStart = 45,
    NightClearance = 12,
    HealthPerAdditionalPlayer = 0.55,
    PirateShip = {
        Weight = 55,
        Template = "PirateShip",
        DisplayName = "Pirate Ship",
        HealthInExpectedShots = 45,
        Duration = 72,
        TravelPadding = 50,
        FireIntervalMin = 6,
        FireIntervalMax = 8,
        ProjectileDuration = 2.1,
        ProjectileArcHeight = 16,
        ProjectileRadius = 7,
        Damage = 10,
        FireSoundId = "rbxassetid://138726661215326",
        RewardFractionMin = 0.3333333333333333,
        RewardFractionMax = 0.5,
        Rotation = CFrame.identity,
    },
    Submarine = {
        Weight = 45,
        Template = "Submarine",
        DisplayName = "Submarine",
        HealthInExpectedShots = 30,
        Duration = 32,
        TravelPadding = 40,
        SubmergeDepth = 45,
        SubmergeCyclesMin = 2,
        SubmergeCyclesMax = 3,
        LateralDistanceMin = 32,
        LateralDistanceMax = 58,
        LateralCyclesMin = 1.5,
        LateralCyclesMax = 2.75,
        FireIntervalMin = 5,
        FireIntervalMax = 7,
        ProjectileDuration = 2.8,
        ProjectileArcHeight = 24,
        ProjectileRadius = 8,
        Damage = 20,
        RewardFractionMin = 0.3333333333333333,
        RewardFractionMax = 0.5,
        Rotation = CFrame.Angles(0, 3.141592653589793, 0),
    },
}
u833.BalloonPilot = {
    MinDay = 2,
    BaseChancePerDay = 0.32,
    ChanceGrowthPerDay = 0.02,
    MaximumChancePerDay = 0.48,
    ArrivalDelayMin = 35,
    ArrivalDelayMax = 75,
    ArrivalDuration = 7,
    FlightSpeed = 16,
    FlightHeightVariation = 6,
    DropIntervalMin = 13,
    DropIntervalMax = 18,
    BombRadius = 54,
    BombDropSoundId = "rbxassetid://120430503624654",
    BombDropSoundVolume = 1.5,
    BombDropSoundMinDistance = 150,
    BombDropSoundMaxDistance = 1200,
    TalkSoundId = "rbxassetid://98114391420903",
    CostFractionOfBossReward = 0.5,
    BombDamage = 6 * u833.CombatDamageScale,
    CostMultipliers = {OneDay = 1, ThreeDays = 2.5},
}
u833.TravelingMerchant = {
    MinDay = 2,
    EveryDays = 2,
    ArrivalDelay = 25,
    MaxLevel = 5,
    HealthPerLevel = 15,
    DodgeChancePerLevel = 0.05,
    CostPerDay = 0.2,
    CostPerLevel = 0.65,
    BaseCosts = {Health = 150, Dodge = 225},
}
u833.Feedback = {
    FishHealthBillboardScale = 1.15,
    FishHealthBillboardClearance = 2,
    RedFishBiteShakeStrength = 9,
    RedFishBiteShakeDuration = 0.55,
    GatorBiteShakeStrength = 17,
    GatorBiteShakeDuration = 0.75,
    BossBiteShakeStrength = 13,
    BossBiteShakeDuration = 0.75,
    BossDeathStartSoundId = "rbxassetid://8789851536",
    BossDeathStartSoundVolume = 1.25,
    BossWaterImpactBassSoundId = "rbxassetid://18894156513",
    BossWaterImpactBassVolume = 1.6,
    BossWaterImpactSplashSoundId = "rbxassetid://128701355933535",
    BossWaterImpactSplashVolume = 1.35,
    BossWaterImpactShakeStrength = 19,
    BossWaterImpactShakeDuration = 1.15,
    BossRewardSoundId = "rbxassetid://139075138086569",
    BossRewardSoundVolume = 1.25,
    BossRevealShakeStrength = 16,
    BossRevealShakeDuration = 3.2,
    BossRevealBassDropVolume = 1.7,
    ShoalWarningShakeStrength = 16,
    ShoalWarningShakeDuration = 3.2,
    ShoalWarningBassDropVolume = 1.7,
    ShoalArrivalShakeStrength = 11,
    ShoalArrivalShakeDuration = 1,
    TsunamiWarningShakeStrength = 18,
    TsunamiWarningShakeDuration = 3.4,
    TsunamiArrivalShakeStrength = 9,
    TsunamiArrivalShakeDuration = 0.8,
    TsunamiProximityShakeDistance = 260,
    TsunamiProximityShakeStrength = 16,
    TsunamiHitShakeStrength = 14,
    TsunamiHitShakeDuration = 0.7,
    RiverEncounterSinkShakeStrength = 15,
    RiverEncounterSinkShakeDuration = 1,
    TutorialSurvivalShakeStrength = 24,
    TutorialSurvivalShakeDuration = 5,
    BassDropSoundId = "rbxassetid://9040550851",
    TutorialSurvivalBassDropVolume = 1.5,
    NightfallBeepSoundId = "rbxassetid://2124207508",
    NightfallBeepVolume = 1.1,
}
u833.Boss = {
    PlaceholderTemplate = "Shark",
    Scale = 2.25,
    Damage = 70,
    FirstBossDamage = 40,
    ChargeSpeed = 58,
    ChargeMinimumDuration = 1.1,
    ChargeMaximumDuration = 3.25,
    GuaranteedChargeHit = true,
    TrackingInterval = 0.12,
    TelegraphDuration = 1.75,
    RoamDuration = 8,
    BaseMovementSpeed = 20,
    MovementSpeedPerDay = 4,
    RetreatDuration = 1.8,
    RecoverDuration = 2.6,
    DeathFlightDuration = 2,
    DeathSinkDuration = 1.5,
    DeathSinkDepth = 18,
    DeathSinkForwardDistance = 4,
    AreaPadding = 3,
    AreaHeightOffset = 2.2,
    HitRadius = 8,
    PartyHealthPerExtraPlayer = 1,
    HealthGrowthAfterBenchmarks = 1.38,
    AirstrikeDamageMultiplier = 2,
    FinalName = "THE FINAL SHARK",
    FinalTemplate = "Shark",
    Rotation = CFrame.Angles(0, 3.141592653589793, 0),
    HealthBenchmarks = {60, 700, 1400, 2600, 4500, 7000},
    Days = {
        {Name = "BIG LARRY", Template = "Shark", Reward = 150},
        {Name = "POINTY PETE", Template = "PointyShark", Reward = 400},
        {Name = "MR. WHISKERS", Template = "WhiskerShark", Reward = 1000},
        {Name = "ZAPPY", Template = "WireShark", Reward = 2400},
        {Name = "TIN TEETH", Template = "IronShark", Reward = 5000},
        {Name = "QUEEN CHOMPY", Template = "PiranhaQueen", Reward = 9000},
        {Name = "RED FRED", Template = "BloodShark", Reward = 15000},
        {Name = "MUDDY BUDDY", Template = "LakeShark", Reward = 24000},
        {Name = "GLOWBERT", Template = "NuclearShark", Reward = 36000},
        {Name = "KEVIN", Template = "FishShark", Reward = 50000},
    },
}
u833.CategoryUnlockDays = {
    Gun = 1,
    Dog = 1,
    Fish = 3,
    Turret = 5,
    Building = 7,
}
u833.Turrets = {
    NormalCount = 4,
    RedCount = 2,
    NormalRange = 75,
    RedRange = 150,
    BaseFireInterval = 2,
    MinimumFireInterval = 0.5,
    FireIntervalPerLevel = 0.15,
    ShotSoundId = "rbxassetid://97987614286292",
    ShotSoundVolume = 0.16,
    ShotPitchMin = 0.94,
    ShotPitchMax = 1.06,
}
u833.Airstrike = {
    StartingCooldown = 180,
    MinimumCooldown = 90,
    PlaneSpeed = 105,
    DropInterval = 0.45,
    BombFallDivisor = 45,
    BombFallMinimum = 1.25,
    BombFallMaximum = 2.6,
    BombRadius = 54.6,
    TravelPadding = 100,
    PlaneYawOffsetDegrees = 270,
    PlaneSoundId = "rbxassetid://7048400833",
    PlaneSoundVolume = 0.85,
    AlarmSoundId = "rbxassetid://138656991212198",
    AlarmSoundVolume = 1.25,
    BombFallingSoundId = "rbxassetid://130980269444154",
    BombFallingSoundVolume = 0.75,
    BombDamage = 20 * u833.CombatDamageScale,
}
u833.FishLane = {
    SpawnInterval = 0.8,
    MaxActive = 36,
    SwimSpeed = 34,
    SwimSwayMin = 0.45,
    SwimSwayMax = 0.9,
    SwimBobMin = 0.1,
    SwimBobMax = 0.24,
    SpeedVariationMin = 0.08,
    SpeedVariationMax = 0.12,
    BreachChance = 0.24,
    BreachStartMin = 0.38,
    BreachStartMax = 0.74,
    BreachDurationMin = 0.8,
    BreachDurationMax = 1.1,
    BreachHeightMin = 3.5,
    BreachHeightMax = 10.5,
    LaunchDuration = 0.9,
    LaunchHeight = 17,
    ExplosiveLaunchHeight = 34,
    DownedLifetime = 300,
    DownedVisualCap = 200,
    GlobalModelScaleMultiplier = 1.3,
    ModelScaleMultiplier = 1.3,
    GradeWeightDayGrowth = 0.16,
    GradeWeightRarityBoost = 0.5,
    HealthScaleEveryDays = 5,
    Types = {
        {
            Id = "Fish",
            DisplayName = "Trout",
            Grade = 1,
            MinDay = 1,
            Weight = 100,
            Health = 1.5,
            Value = 10,
            Scale = 1,
            Speed = 1,
        },
        {
            Id = "MossFish",
            DisplayName = "Moss Trout",
            Grade = 2,
            MinDay = 2,
            Weight = 28,
            Health = 2.3,
            Value = 15,
            Scale = 1.1,
            Speed = 0.92,
        },
        {
            Id = "StripeFish",
            DisplayName = "Striped Trout",
            Grade = 3,
            MinDay = 3,
            Weight = 16,
            Health = 4.2,
            Value = 25,
            Scale = 1.2,
            Speed = 1.08,
        },
        {
            Id = "TigerFish",
            DisplayName = "Tiger Trout",
            Grade = 4,
            MinDay = 4,
            Weight = 10,
            Health = 6.5,
            Value = 40,
            Scale = 1.3,
            Speed = 1.12,
        },
        {
            Id = "KoiFish",
            DisplayName = "Koi Trout",
            Grade = 5,
            MinDay = 5,
            Weight = 6,
            Health = 9.2,
            Value = 65,
            Scale = 1.42,
            Speed = 0.98,
        },
        {
            Id = "RainbowFish",
            DisplayName = "Rainbow Trout",
            Grade = 6,
            MinDay = 6,
            Weight = 4,
            Health = 12.3,
            Value = 100,
            Scale = 1.55,
            Speed = 1.15,
        },
        {
            Id = "ToxicFish",
            DisplayName = "Toxic Trout",
            Grade = 7,
            MinDay = 7,
            Weight = 2.5,
            Health = 17,
            Value = 150,
            Scale = 1.7,
            Speed = 1.2,
        },
        {
            Id = "ArmoredFish",
            DisplayName = "Armored Trout",
            Grade = 8,
            MinDay = 8,
            Weight = 1.5,
            Health = 23,
            Value = 225,
            Scale = 1.88,
            Speed = 0.82,
        },
        {
            Id = "VoidFish",
            DisplayName = "Void Trout",
            Grade = 10,
            MinDay = 10,
            Weight = 0.3,
            Health = 35,
            Value = 500,
            Scale = 2.1,
            Speed = 1.25,
        },
    },
}
for i, v in ipairs(u833.FishLane.Types) do
    v.Kind = "Fish"
    v.Rotation = CFrame.Angles(0, 1.5707963267948966, 0)
end
u833.Sharks = {
    MinDay = 3,
    Template = "Shark",
    DisplayName = "Shark",
    BaseChance = 0.004,
    ChancePerDay = 0.0015,
    MaximumChance = 0.02,
    HealthInExpectedShots = 2,
    BaseValue = 75,
    ValuePerDay = 35,
    Scale = 1,
    Speed = 1.12,
    AttackSpeed = 38,
    TrackingInterval = 0.16,
    RetreatSpeed = 38,
    BiteDamage = 15,
    HitRadius = 7,
    PostBiteSpeedMultiplier = 0.7,
    TargetSoundId = "rbxassetid://1014740409",
    TargetSoundVolume = 1,
    Rotation = CFrame.Angles(0, 3.141592653589793, 0),
}
u833.Whales = {
    MinDay = 5,
    Template = "Whale",
    DisplayName = "Whale",
    BaseChance = 0.0008,
    ChancePerDay = 0.0002,
    RarityChancePerLevel = 0.0003,
    MaximumChance = 0.0045,
    HealthInExpectedShots = 8,
    BaseValue = 500,
    ValuePerDay = 250,
    Scale = 1,
    Speed = 0.45,
    Rotation = CFrame.identity,
}
u833.GoldenFish = {
    MinDay = 2,
    Template = "GoldFish",
    DisplayName = "Goldie",
    MaximumPerDay = 2,
    SpawnSoundId = "rbxassetid://135192579587427",
    SpawnSoundVolume = 1,
    GuaranteeWindowStart = 0.18,
    GuaranteeWindowEnd = 0.62,
    BaseChance = 0.002,
    ChancePerDay = 0.0003,
    RarityChancePerLevel = 0.00045,
    MaximumChance = 0.007,
    HealthInExpectedShots = 2.5,
    BaseValue = 300,
    ValuePerDay = 150,
    Scale = 1.34,
    Speed = 1.15,
    Rotation = CFrame.Angles(0, 1.5707963267948966, 0),
}
u833.WaterSplashBursts = {Gunshot = 1, Shot = 4, FishLanding = 6, JumpLanding = 5}
u833.RedFish = {
    Chance = 0.08,
    FirstDayUnlockSeconds = 15,
    FirstDayGuaranteedAttackCount = 2,
    ConversionMinProgress = 0.05,
    ConversionMaxProgress = 0.28,
    MaxSimultaneousAttackers = 2,
    AttackSpeed = 46.4,
    TrackingInterval = 0.2,
    RetreatSpeed = 48,
    BiteDamage = 5,
    HitRadius = 5.5,
    PostBiteSpeedMultiplier = 0.8,
    DroneSoundId = "rbxassetid://1838789059",
    DroneSoundVolume = 2.1,
    DroneSoundPitchMin = 0.88,
    DroneSoundPitchMax = 1.12,
    BiteSoundId = "rbxassetid://77219596258211",
    BiteSoundVolume = 1.4,
    FirstDayGuaranteedAttackWindow = {15, 25},
}
u833.Icons = {
    Cash = "rbxassetid://15402858705",
    Coin = "rbxassetid://17368060122",
    Luck = "rbxassetid://17368084270",
    Speed = "rbxassetid://17368052918",
    Bomb = "rbxassetid://15403027709",
    Inventory = "rbxassetid://15402958715",
}
u833.GunOrder = {"Mosin", "Pistol", "Uzi", "AWP", "MilitaryShotgun", "ArcticAK", "Vector", "GoldenScar"}
u833.Guns = {
    Mosin = {
        DisplayName = "Mosin",
        ScaleCost = 0,
        FishPerHit = 1.5,
        DamageCurve = "Mosin",
        DamagePerUpgrade = 1,
        MagazineSize = 1,
        MagazinePerUpgrade = 1,
        FireInterval = 0.95,
        ReloadTime = 2,
        Automatic = false,
        Recoil = 1.15,
        ModelScale = 0.62,
        ShotRadiusMultiplier = 1,
        ShotPitch = 1,
        ShotVolume = 0.38,
        ViewOffset = CFrame.new(0.58, -0.8, -2.2),
        MuzzleOffset = CFrame.new(0.55, -0.56, -4.15),
        ModelRotation = CFrame.identity,
        Color = Color3.fromRGB(131, 176, 215),
    },
    Uzi = {
        DisplayName = "Uzi",
        ScaleCost = 150,
        FishPerHit = 1.5,
        DamagePerUpgrade = 1,
        MagazineSize = 8,
        MagazinePerUpgrade = 2,
        FireInterval = 0.2,
        ReloadTime = 1.8,
        Automatic = true,
        Recoil = 0.45,
        ModelScale = 0.78,
        ShotRadiusMultiplier = 0.36,
        CandidateValidationPadding = 1,
        ShotPitch = 1.14,
        ShotVolume = 0.3,
        ViewOffset = CFrame.new(0.6, -0.8, -2.55),
        MuzzleOffset = CFrame.new(0.56, -0.58, -3.85),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(255, 157, 84),
    },
    Vector = {
        DisplayName = "Vector",
        ScaleCost = 900,
        FishPerHit = 1,
        DamagePerUpgrade = 1,
        MagazineSize = 2,
        MagazinePerUpgrade = 3,
        FireInterval = 0.19,
        ReloadTime = 2.9,
        Automatic = true,
        Recoil = 0.34,
        ModelScale = 0.76,
        ShotRadiusMultiplier = 0.25,
        CandidateValidationPadding = 1,
        ShotPitch = 1.07,
        ShotVolume = 0.32,
        ViewOffset = CFrame.new(0.6, -0.82, -2.65),
        MuzzleOffset = CFrame.new(0.56, -0.6, -4.05),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(83, 231, 217),
    },
    MilitaryShotgun = {
        DisplayName = "Military Shotgun",
        ScaleCost = 400,
        FishPerHit = 2,
        DamagePerUpgrade = 2,
        OneShotSharks = true,
        SharkOneShotRange = 45,
        MagazineSize = 1,
        MagazinePerUpgrade = 1,
        FireInterval = 1.15,
        ReloadTime = 3.3,
        Automatic = false,
        Recoil = 1.65,
        ModelScale = 0.66,
        ShotRadiusMultiplier = 2.6,
        ShotPitch = 0.78,
        ShotVolume = 0.45,
        ViewOffset = CFrame.new(0.58, -0.78, -2.75),
        MuzzleOffset = CFrame.new(0.55, -0.57, -4.9),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(255, 202, 92),
    },
    ArcticAK = {
        DisplayName = "Arctic AK",
        ScaleCost = 600,
        FishPerHit = 2,
        DamagePerUpgrade = 1,
        MagazineSize = 3,
        MagazinePerUpgrade = 3,
        FireInterval = 0.38,
        ReloadTime = 3.4,
        Automatic = true,
        Recoil = 1.05,
        ModelScale = 0.72,
        ShotRadiusMultiplier = 0.32,
        CandidateValidationPadding = 1,
        ShotPitch = 0.9,
        ShotVolume = 0.4,
        ViewOffset = CFrame.new(0.6, -0.8, -2.8),
        MuzzleOffset = CFrame.new(0.56, -0.58, -4.78),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(119, 204, 255),
    },
    GoldenScar = {
        DisplayName = "Golden SCAR",
        ScaleCost = 1400,
        FishPerHit = 2,
        DamagePerUpgrade = 2,
        MagazineSize = 4,
        MagazinePerUpgrade = 4,
        FireInterval = 0.32,
        ReloadTime = 3,
        Automatic = true,
        Recoil = 0.55,
        ModelScale = 0.7,
        ShotRadiusMultiplier = 0.32,
        CandidateValidationPadding = 1,
        ShotPitch = 0.98,
        ShotVolume = 0.38,
        ViewOffset = CFrame.new(0.6, -0.8, -2.88),
        MuzzleOffset = CFrame.new(0.56, -0.58, -5),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(255, 210, 54),
    },
    AWP = {
        DisplayName = "AWP",
        ScaleCost = 250,
        FishPerHit = 4,
        DamagePerUpgrade = 3,
        OneShotSharks = true,
        OneShotGoldenFish = true,
        MagazineSize = 1,
        MagazinePerUpgrade = 1,
        FireInterval = 1.5,
        ReloadTime = 4.3,
        Automatic = false,
        Recoil = 1.8,
        ModelScale = 0.55,
        ShotRadiusMultiplier = 0.7,
        ShotPitch = 0.72,
        ShotVolume = 0.46,
        ViewOffset = CFrame.new(0.58, -0.77, -2.72),
        MuzzleOffset = CFrame.new(0.54, -0.55, -4.95),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(184, 117, 255),
    },
    Pistol = {
        DisplayName = "Makarov",
        ScaleCost = 100,
        FishPerHit = 1,
        DamagePerUpgrade = 0.5,
        MagazineSize = 8,
        FireInterval = 0.22,
        ReloadTime = 1.35,
        Automatic = false,
        Recoil = 0.48,
        ModelScale = 0.95,
        ViewOffset = CFrame.new(0.62, -0.72, -2.05),
        ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0),
        Color = Color3.fromRGB(82, 181, 255),
    },
    Shotgun = {
        DisplayName = "Double Barrel",
        FishPerHit = 5,
        MagazineSize = 2,
        FireInterval = 0.72,
        ReloadTime = 1.75,
        Automatic = false,
        Recoil = 1.35,
        ModelScale = 0.82,
        ViewOffset = CFrame.new(0.58, -0.7, -2.65),
        ModelRotation = CFrame.identity,
        Color = Color3.fromRGB(255, 173, 79),
    },
    Tommy = {
        DisplayName = "Tommy Gun",
        FishPerHit = 1,
        MagazineSize = 30,
        FireInterval = 0.115,
        ReloadTime = 1.85,
        Automatic = true,
        Recoil = 0.36,
        ModelScale = 0.78,
        ViewOffset = CFrame.new(0.58, -0.78, -2.75),
        ModelRotation = CFrame.identity,
        Color = Color3.fromRGB(113, 224, 157),
    },
    Rifle = {
        DisplayName = "M16A2",
        FishPerHit = 2,
        MagazineSize = 20,
        FireInterval = 0.18,
        ReloadTime = 1.65,
        Automatic = true,
        Recoil = 0.48,
        ModelScale = 0.72,
        ViewOffset = CFrame.new(0.62, -0.76, -2.8),
        ModelRotation = CFrame.Angles(0, 1.5707963267948966, 0),
        Color = Color3.fromRGB(112, 155, 255),
    },
    LMG = {
        DisplayName = "LMG",
        Enabled = false,
        FishPerHit = 1,
        DamagePerUpgrade = 1,
        MagazineSize = 5,
        MagazinePerUpgrade = 5,
        FireInterval = 0.3,
        ReloadTime = 5.5,
        Automatic = true,
        Recoil = 0.82,
        ModelScale = 0.62,
        ShotRadiusMultiplier = 0.28,
        CandidateValidationPadding = 1,
        ShotPitch = 0.8,
        ShotVolume = 0.42,
        ViewOffset = CFrame.new(0.56, -0.9, -3.05),
        MuzzleOffset = CFrame.new(0.54, -0.62, -5.1),
        ModelRotation = (CFrame.Angles(1.5707963267948966, 0, 0)) * CFrame.Angles(0, 3.141592653589793, 0),
        Color = Color3.fromRGB(220, 134, 255),
    },
    Rocket = {
        DisplayName = "RPG-7",
        FishPerHit = 25,
        MagazineSize = 1,
        FireInterval = 2.5,
        ReloadTime = 2.5,
        Automatic = false,
        Recoil = 1.8,
        ModelScale = 0.58,
        ViewOffset = CFrame.new(0.54, -0.82, -3.2),
        ModelRotation = CFrame.Angles(0, 1.5707963267948966, 0),
        Color = Color3.fromRGB(255, 102, 87),
    },
    Minigun = {
        DisplayName = "MG42 Overdrive",
        FishPerHit = 4,
        MagazineSize = 100,
        FireInterval = 0.08,
        ReloadTime = 4,
        Automatic = true,
        Recoil = 0.3,
        ModelScale = 0.62,
        ViewOffset = CFrame.new(0.56, -0.92, -3.15),
        ModelRotation = CFrame.Angles(1.5707963267948966, 0, 0),
        Color = Color3.fromRGB(255, 92, 147),
    },
}
u833.WeaponLuck = {
    [0] = {Shotgun = 60, Tommy = 40},
    {Shotgun = 45, Tommy = 40, Rifle = 15},
    {Shotgun = 35, Tommy = 35, Rifle = 22, LMG = 8},
    {
        Shotgun = 28,
        Tommy = 30,
        Rifle = 25,
        LMG = 12,
        Rocket = 5,
    },
    {
        Shotgun = 22,
        Tommy = 27,
        Rifle = 25,
        LMG = 16,
        Rocket = 8,
        Minigun = 2,
    },
    {
        Shotgun = 15,
        Tommy = 23,
        Rifle = 25,
        LMG = 20,
        Rocket = 13,
        Minigun = 4,
    },
    {
        Shotgun = 10,
        Tommy = 18,
        Rifle = 24,
        LMG = 23,
        Rocket = 18,
        Minigun = 7,
    },
}
u833.OrdnanceOrder = {"Grenade", "Dynamite", "Carpet", "Orbital", "Nuke"}
u833.Ordnance = {
    Grenade = {
        DisplayName = "Grenade",
        Fish = 25,
        ImpactDelay = 0.7,
        Color = Color3.fromRGB(87, 213, 126),
    },
    Dynamite = {
        DisplayName = "Dynamite",
        Fish = 75,
        ImpactDelay = 1,
        Color = Color3.fromRGB(255, 112, 74),
    },
    Carpet = {
        DisplayName = "Carpet Bombing",
        Fish = 350,
        ImpactDelay = 1.45,
        Color = Color3.fromRGB(255, 175, 71),
    },
    Orbital = {
        DisplayName = "Orbital Strike",
        Fish = 1000,
        ImpactDelay = 1.8,
        Color = Color3.fromRGB(103, 203, 255),
    },
    Nuke = {
        DisplayName = "Nuke",
        Fish = 3000,
        ImpactDelay = 2.4,
        Color = Color3.fromRGB(255, 235, 92),
    },
}
u833.OrdnanceLuck = {
    [0] = {Grenade = 70, Dynamite = 30},
    {Grenade = 65, Dynamite = 35},
    {Grenade = 60, Dynamite = 40},
    {Grenade = 55, Dynamite = 40, Carpet = 5},
    {Grenade = 50, Dynamite = 40, Carpet = 10},
    {Grenade = 45, Dynamite = 40, Carpet = 15},
    {Grenade = 42, Dynamite = 38, Carpet = 20},
    {Grenade = 38, Dynamite = 36, Carpet = 22, Orbital = 4},
    {Grenade = 34, Dynamite = 34, Carpet = 25, Orbital = 7},
    {Grenade = 30, Dynamite = 32, Carpet = 28, Orbital = 10},
    {Grenade = 27, Dynamite = 30, Carpet = 29, Orbital = 14},
    {
        Grenade = 25,
        Dynamite = 28,
        Carpet = 30,
        Orbital = 16,
        Nuke = 1,
    },
    {
        Grenade = 22,
        Dynamite = 26,
        Carpet = 31,
        Orbital = 19,
        Nuke = 2,
    },
}
u833.UpgradeCategories = {
    Fish = {"FishValue", "FishRarity", "FishChain"},
    Gun = {"Magazine", "Reload", "Damage"},
    Dog = {"DogSpeed", "DogCarry", "DogAutoDeposit"},
    Turret = {"TurretCount", "TurretDamage", "TurretFireSpeed"},
    Building = {"BetterDock", "RedTurretCount", "AdditionalDogs", "Airstrike", "AirstrikeCooldown"},
}
u833.UpgradeOrder = {
    "FishValue",
    "FishRarity",
    "FishChain",
    "Magazine",
    "Reload",
    "Damage",
    "DogSpeed",
    "DogCarry",
    "DogAutoDeposit",
    "TurretCount",
    "TurretDamage",
    "TurretFireSpeed",
    "BetterDock",
    "RedTurretCount",
    "AdditionalDogs",
    "Airstrike",
    "AirstrikeCooldown",
}
u833.Upgrades = {
    FishChain = {
        Name = "They Found Us Bro",
        Max = 10,
        Costs = {120, 222, 411, 760, 1406, 5000, 15000, 45000, 135000, 405000},
    },
    FishValue = {Name = "Valuable Fish", Infinite = true, Growth = 2.2, Costs = {75, 130, 225, 390, 675}},
    FishRarity = {Name = "Rare Fish", Infinite = true, Growth = 2.35, Costs = {120, 210, 368, 643, 1125}},
    Magazine = {Name = "Too Much Ammo", Infinite = true, BaseCost = 75, Growth = 1.432},
    Reload = {Name = "More Reloading", Max = 24, BaseCost = 60, Growth = 1.354},
    Damage = {
        Name = "Bigger Bullets",
        Infinite = true,
        Growth = 1.167,
        Costs = {24, 28, 32, 38, 44, 52, 60, 71, 83, 97, 113, 132, 154, 180, 211, 246},
    },
    DogAutoDeposit = {Name = "Good Boy", Max = 1, BaseCost = 100, Growth = 1},
    DogSpeed = {
        Name = "Fast Boy",
        Max = 15,
        DiminishedAfter = 6,
        LateIncrement = 10,
        Costs = {5, 15, 45, 100, 225, 500, 1500, 4000, 10000, 25000, 60000, 140000, 320000, 720000, 1600000},
    },
    DogCarry = {
        Name = "Fat Boy",
        Max = 15,
        DiminishedAfter = 5,
        LateIncrement = 1,
        Costs = {
            20,
            100,
            300,
            900,
            2500,
            7500,
            20000,
            50000,
            120000,
            280000,
            650000,
            1500000,
            3400000,
            7600000,
            17000000,
        },
    },
    TurretCount = {Name = "Buy Next Turret", Max = 4, BaseCost = 750, Growth = 1.75},
    TurretDamage = {Name = "Turret Damage", Infinite = true, BaseCost = 350, Growth = 1.55},
    TurretFireSpeed = {Name = "Turret Fire Speed", Max = 10, BaseCost = 450, Growth = 1.45},
    BetterDock = {Name = "Build Better Dock", Max = 1, BaseCost = 8000, Growth = 1},
    RedTurretCount = {Name = "Buy Red Turret", Max = 2, BaseCost = 6000, Growth = 1.7},
    AdditionalDogs = {Name = "More Dogs", Max = 2, BaseCost = 4500, Growth = 2},
    Airstrike = {Name = "Call In Airstrike", Max = 1, BaseCost = 12000, Growth = 1},
    AirstrikeCooldown = {Name = "Airstrike Recharge Speed", Max = 5, BaseCost = 3000, Growth = 1.6},
}

local function upgradeLevel(a1, a2) -- Line: 1058 -- types: a2: string
    return (math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1[a2])) or 0))))
end

function u833.UpgradeCost(a1, a2) -- Line: 1063 -- upvalues: u833 (val) -- types: a1: string, a2: number
    local v1 = u833.Upgrades[a1]
    if not v1 then
        return (1 / 0)
    end
    local v2 = math.max(0, (math.floor((tonumber(a2)) or 0)))
    if not v1.Costs then
        if v1.CostBase and v1.CostStep then
            return (math.floor(v1.CostBase + v1.CostStep * v2 + 0.5))
        end
        return (math.floor(v1.BaseCost * v1.Growth ^ v2 + 0.5))
    end
    local v3 = v1.Costs[v2 + 1]
    if v3 then
        return v3
    end
    if v1.Infinite == true and v1.Growth then
        return (math.floor(v1.Costs[#v1.Costs] * v1.Growth ^ (v2 - #v1.Costs + 1) + 0.5))
    end
    return (1 / 0)
end

function u833.UpgradeRobuxPrice(a1) -- Line: 1082 -- types: a1: number
    local v1 = math.max(1, (math.floor((tonumber(a1)) or 1)))
    if v1 <= 5 then
        return 9
    end
    if v1 <= 10 then
        return 19
    end
    if v1 <= 15 then
        return 29
    end
    if v1 <= 20 then
        return 39
    end
    if v1 <= 25 then
        return 49
    end
    return 59
end

function u833.UpgradeProductIdForLevel(a1) -- Line: 1092 -- upvalues: u833 (val) -- types: a1: number
    return (math.max(0, (math.floor((tonumber((u833.DeveloperProducts.UpgradeProductIds or {})[(u833.UpgradeRobuxPrice(a1))])) or 0))))
end

function u833.IsUpgradeMaxed(a1, a2) -- Line: 1098 -- upvalues: u833 (val) -- types: a1: string, a2: number
    local v1 = u833.Upgrades[a1]
    if v1 and v1.Infinite ~= true then
        local v2 = math.max(0, (math.floor((tonumber(a2)) or 0)))
        return math.max(0, (tonumber(v1.Max)) or 0) <= v2
    end
    return false
end

function u833.MagazineSize(a1, a2) -- Line: 1104
    local MagazineSize = a1.MagazineSize
    return MagazineSize + (math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.Magazine)) or 0)))) * (a1.MagazinePerUpgrade or 1)
end

function u833.GunFireInterval(a1, a2, a3) -- Line: 1108
    local v1 = math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.Reload)) or 0)))
    local v2 = if not (v1 <= 12) then 0.9 ^ (v1 - 12) * 0.12 + 0.18 else 1 - v1 * 0.7 / 12
    local v3 = math.max(0.25, 1 - (math.max(0, (math.floor((if typeof(a3) ~= "table" then nil else tonumber(a3.FireRate)) or 0)))) * 0.06)
    return a1.FireInterval * v2 * v3
end

function u833.ReloadTime(a1, a2) -- Line: 1117
    return (math.max(0.38, a1.ReloadTime * 0.88 ^ (math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.Reload)) or 0))))))
end

function u833.GunDamage(a1, a2) -- Line: 1121 -- upvalues: u833 (val)
    local v1 = math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.Damage)) or 0)))
    if a1.DamageCurve == "Mosin" then
        return v1 * 7 + 15 + v1 * (v1 + 1) / 2
    end
    return (a1.FishPerHit + v1 * (math.max(0, (tonumber(a1.DamagePerUpgrade)) or 1))) * u833.CombatDamageScale
end

function u833.ShotRadius(a1, a2) -- Line: 1131 -- upvalues: u833 (val)
    return u833.BulletRadius * (a1.ShotRadiusMultiplier or 1)
end

function u833.RunScaleReward(a1, a2) -- Line: 1135 -- upvalues: u833 (val) -- types: a1: number, a2: number
    local ScaleEconomy = u833.ScaleEconomy
    local v1 = math.max(0, (math.floor((tonumber(a1)) or 0)))
    local v2 = math.min(ScaleEconomy.MaximumFishBonus, (math.floor((math.max(0, (math.floor((tonumber(a2)) or 0)))) / ScaleEconomy.FishPerBonusScale)))
    return ScaleEconomy.BaseRunReward + v1 * ScaleEconomy.PerBossDefeated + v2
end

function u833.DogSpeed(a1) -- Line: 1143 -- upvalues: u833 (val)
    local v1 = math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1.DogSpeed)) or 0)))
    local v2 = {16, 20, 30, 45, 65, 90, 120}
    local DogSpeed_2 = u833.Upgrades.DogSpeed
    local DiminishedAfter = DogSpeed_2.DiminishedAfter
    return v2[math.min(v1, DiminishedAfter) + 1] + (math.max(0, v1 - DiminishedAfter)) * DogSpeed_2.LateIncrement
end

function u833.DogCapacity(a1) -- Line: 1152 -- upvalues: u833 (val)
    local v1 = {1, 2, 3, 5, 8, 12}
    local v2 = math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1.DogCarry)) or 0)))
    local DogCarry_2 = u833.Upgrades.DogCarry
    local DiminishedAfter = DogCarry_2.DiminishedAfter
    return v1[math.min(v2, DiminishedAfter) + 1] + (math.max(0, v2 - DiminishedAfter)) * DogCarry_2.LateIncrement
end

function u833.TurretFireInterval(a1) -- Line: 1161 -- upvalues: u833 (val)
    return (math.max(
        u833.Turrets.MinimumFireInterval,
        u833.Turrets.BaseFireInterval - (math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1.TurretFireSpeed)) or 0)))) * u833.Turrets.FireIntervalPerLevel
    ))
end

function u833.TurretDamage(a1) -- Line: 1169
    local v1 = math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1.TurretDamage)) or 0)))
    return v1 * 7 + 15 + v1 * (v1 + 1) / 2
end

function u833.AirstrikeCooldown(a1) -- Line: 1174 -- upvalues: u833 (val)
    return (math.max(
        u833.Airstrike.MinimumCooldown,
        u833.Airstrike.StartingCooldown * (1 - (math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1.AirstrikeCooldown)) or 0)))) * 0.1)
    ))
end

function u833.DaySpawnInterval(a1) -- Line: 1180 -- types: a1: number
    local v1 = math.max(1, (math.floor(a1)))
    local v2 = {0.4, 0.9, 1.9, 2.71, 3.35, 3.95, 4.5, 5, 5.45, 5.85}
    local v3 = v2[v1] or math.min(8, v2[#v2] + (v1 - #v2) * 0.25)
    return 1 / v3
end

function u833.DaySpawnBurst(a1) -- Line: 1188 -- types: a1: number
    return 1
end

function u833.DayActiveFishCap(a1) -- Line: 1195 -- types: a1: number
    local v1 = math.max(1, (math.floor(a1)))
    local v2 = {24, 32, 45, 60, 72, 84, 96, 108, 116, 120}
    return v2[v1] or math.min(180, v2[#v2] + (v1 - #v2) * 6)
end

function u833.DayRedAttackerCap(a1, a2) -- Line: 1201 -- types: a1: number, a2: number?
    return (math.clamp(math.floor((math.max(0, a1 - 1)) / 2) + 2, 2, 8)) + math.clamp(math.floor((tonumber(a2)) or 1), 1, 4) - 1
end

function u833.ShoalRedBudgets(a1) -- Line: 1209 -- types: a1: number
    local v1 = {{1}, {2}, {3}, {2, 4}, {3, 5}, {4, 6}, {5, 8}, {6, 10}, {8, 12}, {10, 15}}
    return table.clone(v1[math.clamp(math.floor(a1), 1, 10)])
end

function u833.BossDefinition(a1) -- Line: 1218 -- upvalues: u833 (val) -- types: a1: number
    local v1 = math.max(1, (math.floor(a1)))
    local v2 = table.clone(u833.Boss.Days[(v1 - 1) % #u833.Boss.Days + 1])
    if #u833.Boss.Days < v1 then
        local v3 = v1 - #u833.Boss.Days
        v2.Reward = math.floor(u833.Boss.Days[#u833.Boss.Days].Reward * 1.2 ^ v3 + 0.5)
        v2.Name = v2.Name .. "  " .. tostring((math.floor((v1 - 1) / #u833.Boss.Days)) + 1)
    end
    local HealthBenchmarks = u833.Boss.HealthBenchmarks
    local v4 = #HealthBenchmarks
    local v5 = if not (v1 <= v4) then math.floor(HealthBenchmarks[v4] * u833.Boss.HealthGrowthAfterBenchmarks ^ (v1 - v4) + 0.5) else HealthBenchmarks[v1]
    v2.Health = v5
    local Template = v2.Template or u833.Boss.PlaceholderTemplate
    v2.Template = Template
    return v2
end

function u833.FinalBossDefinition(a1) -- Line: 1242 -- upvalues: u833 (val) -- types: a1: number
    local v1 = u833.BossDefinition(a1)
    v1.Name = u833.Boss.FinalName
    v1.Template = u833.Boss.FinalTemplate
    return v1
end

function u833.BalloonPilotCost(a1, a2) -- Line: 1249 -- upvalues: u833 (val) -- types: a1: number, a2: string
    return (math.max(
        25,
        (math.floor((math.max(100, (math.max(0, (tonumber((u833.BossDefinition(a1)).Reward)) or 0)) * u833.BalloonPilot.CostFractionOfBossReward)) * ((tonumber(u833.BalloonPilot.CostMultipliers[a2])) or 1) / 25 + 0.5)) * 25
    ))
end

function u833.TravelingMerchantCost(a1, a2, a3) -- Line: 1256
    -- upvalues: u833 (val)
    return (math.max(
        25,
        (math.floor((tonumber(u833.TravelingMerchant.BaseCosts[a2]) or 150) * (1 + (math.max(0, (math.floor(a1)) - 1)) * u833.TravelingMerchant.CostPerDay) * (1 + (math.max(0, (math.floor(a3)))) * u833.TravelingMerchant.CostPerLevel) / 25 + 0.5)) * 25
    ))
end

function u833.BossMovementSpeed(a1) -- Line: 1263 -- upvalues: u833 (val) -- types: a1: number
    return u833.Boss.BaseMovementSpeed + ((math.max(1, (math.floor((tonumber(a1)) or 1)))) - 1) * u833.Boss.MovementSpeedPerDay
end

function u833.ExpectedPlayerDamage(a1) -- Line: 1268 -- upvalues: u833 (val) -- types: a1: number
    return (math.max(1, (math.floor((math.max(0, a1 - 1)) * 0.75)) + 2)) * u833.CombatDamageScale
end

function u833.FishGradeWeight(a1, a2, a3, a4) -- Line: 1273 -- upvalues: u833 (val) -- types: a2: number, a4: number?
    if a2 < (a1.MinDay or 1) then
        return 0
    end
    local v1 = math.max(1, (tonumber(a1.Grade)) or 1)
    return (math.max(
        0,
        (a1.Weight or 0) * (1 + (math.max(0, a2 - (a1.MinDay or 1))) * u833.FishLane.GradeWeightDayGrowth * v1 ^ 1.25) * (1 + ((math.max(0, (math.floor((if typeof(a3) ~= "table" then nil else tonumber(a3.FishRarity)) or 0)))) + math.max(0, (math.floor((tonumber(a4)) or 0)))) * u833.FishLane.GradeWeightRarityBoost * ((v1 - 1) / 9))
    ))
end

function u833.FishGradeHealth(a1, a2) -- Line: 1286 -- upvalues: u833 (val) -- types: a2: number
    return (math.floor((math.max(0.1, (a1.Health or 1) + (math.floor((math.max(0, a2 - (a1.MinDay or 1))) / u833.FishLane.HealthScaleEveryDays)))) * u833.CombatDamageScale + 0.5))
end

function u833.SharkSpawnChance(a1) -- Line: 1295 -- upvalues: u833 (val) -- types: a1: number
    if a1 < u833.Sharks.MinDay then
        return 0
    end
    return (math.min(u833.Sharks.MaximumChance, u833.Sharks.BaseChance + (a1 - u833.Sharks.MinDay) * u833.Sharks.ChancePerDay))
end

function u833.WhaleSpawnChance(a1, a2, a3) -- Line: 1300 -- upvalues: u833 (val) -- types: a1: number, a3: number?
    if a1 < u833.Whales.MinDay then
        return 0
    end
    return (math.min(
        u833.Whales.MaximumChance,
        u833.Whales.BaseChance + (a1 - u833.Whales.MinDay) * u833.Whales.ChancePerDay + ((math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.FishRarity)) or 0)))) + math.max(0, (math.floor((tonumber(a3)) or 0)))) * u833.Whales.RarityChancePerLevel
    ))
end

function u833.GoldenFishSpawnChance(a1, a2) -- Line: 1309 -- upvalues: u833 (val) -- types: a1: number
    if a1 < u833.GoldenFish.MinDay then
        return 0
    end
    return (math.min(
        u833.GoldenFish.MaximumChance,
        u833.GoldenFish.BaseChance + (a1 - u833.GoldenFish.MinDay) * u833.GoldenFish.ChancePerDay + math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.FishRarity)) or 0))) * u833.GoldenFish.RarityChancePerLevel
    ))
end

function u833.SharkHealth(a1) -- Line: 1317 -- upvalues: u833 (val) -- types: a1: number
    return (u833.ExpectedPlayerDamage(a1)) * u833.Sharks.HealthInExpectedShots
end

function u833.WhaleHealth(a1) -- Line: 1321 -- upvalues: u833 (val) -- types: a1: number
    return (math.floor((u833.GunDamage(u833.Guns.Mosin, {Damage = math.max(0, a1 * 2 - 1)})) * u833.Whales.HealthInExpectedShots + 0.5))
end

function u833.GoldenFishHealth(a1) -- Line: 1327 -- upvalues: u833 (val) -- types: a1: number
    return (math.floor((u833.GunDamage(u833.Guns.Mosin, {Damage = math.max(0, a1 * 2 - 1)})) * u833.GoldenFish.HealthInExpectedShots + 0.5))
end

function u833.SharkValue(a1) -- Line: 1333 -- upvalues: u833 (val) -- types: a1: number
    return u833.Sharks.BaseValue + (math.max(0, a1 - u833.Sharks.MinDay)) * u833.Sharks.ValuePerDay
end

function u833.WhaleValue(a1) -- Line: 1337 -- upvalues: u833 (val) -- types: a1: number
    return u833.Whales.BaseValue + (math.max(0, a1 - u833.Whales.MinDay)) * u833.Whales.ValuePerDay
end

function u833.GoldenFishValue(a1) -- Line: 1341 -- upvalues: u833 (val) -- types: a1: number
    return u833.GoldenFish.BaseValue + (math.max(0, a1 - u833.GoldenFish.MinDay)) * u833.GoldenFish.ValuePerDay
end

function u833.FishCashValue(a1, a2, a3) -- Line: 1345 -- types: a1: number, a3: number?
    return (math.max(
        1,
        (math.floor(a1 * ((math.max(0, (math.floor((if typeof(a2) ~= "table" then nil else tonumber(a2.FishValue)) or 0)))) * 0.2 + 1) + (math.max(0, (tonumber(a3)) or 0)) + 0.5))
    ))
end

function u833.FishChainChance(a1, a2) -- Line: 1350 -- types: a2: number?
    return (math.clamp(
        math.max(0, (math.floor((if typeof(a1) ~= "table" then nil else tonumber(a1.FishChain)) or 0))) * 0.1 + math.max(0, (tonumber(a2)) or 0),
        0,
        1
    ))
end

function u833.weightedRoll(a1, a2) -- Line: 1354 -- upvalues: u833 (val) -- types: a1: table, a2: userdata?
    local v1
    local v2 = (a2 or Random.new()):NextNumber(0, 100)
    local v3 = 0
    for i, v in ipairs(u833.GunOrder) do
        v1 = a1[v]
        if v1 then
            v3 = v3 + v1
            if v2 <= v3 then
                return v
            end
        end
    end
    for i2, i3 in ipairs(u833.OrdnanceOrder) do
        v1 = a1[i3]
        if v1 then
            v3 = v3 + v1
            if v2 <= v3 then
                return i3
            end
        end
    end
    for k in pairs(a1) do
        return k
    end
    error("Cannot roll an empty weight table")
end

local NormalGunConfig = require((game:GetService("ReplicatedStorage")):WaitForChild("NormalGunConfig"))
for i2, i3 in ipairs(NormalGunConfig.Order) do
    v3 = NormalGunConfig.Guns[i3]
    v1 = table.clone(v3.Stats)
    v1.DisplayName = v3.DisplayName
    v1.ScaleCost = v3.ScaleCost
    v1.ModelScale = v3.ModelScale
    v1.ViewOffset = v3.ViewOffset
    v1.ModelRotation = CFrame.Angles(0, -1.5707963267948966, 0)
    v1.Color = v3.Color
    u833.Guns[i3] = v1
    table.insert(u833.GunOrder, i3)
end
for i4, j in ipairs((require((game:GetService("ReplicatedStorage")):WaitForChild("MonetizationConfig"))).ExclusiveGuns) do
    v1 = table.clone(u833.Guns[j.BaseId])
    v1.DisplayName = j.DisplayName
    v1.Exclusive = true
    v1.Element = j.Element
    v1.ModelScale = j.ModelScale
    v2 = if j.Element ~= "Ice" then Color3.fromRGB(255, 95, 28) else Color3.fromRGB(93, 205, 255)
    v1.Color = v2
    v1.ScaleCost = 1000000000
    u833.Guns[j.Id] = v1
    table.insert(u833.GunOrder, j.Id)
end
return u833
 -- Script Path: game:GetService("ReplicatedStorage").FishGame.FishIndexConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.FishGame.FishIndexConfig
-- Decompile time: 8.85 ms

local v1
local u140 = {}
local u1 = {
    {
        Id = "Fish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Trout",
        Rarity = "Common",
        DiscoveryKey = "Fish:Fish",
        MinDay = 1,
        Health = 15,
        Value = 10,
        Weight = 100,
    },
    {
        Id = "MossFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Moss Trout",
        Rarity = "Uncommon",
        DiscoveryKey = "Fish:MossFish",
        MinDay = 2,
        Health = 23,
        Value = 15,
        Weight = 28,
    },
    {
        Id = "StripeFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Striped Trout",
        Rarity = "Rare",
        DiscoveryKey = "Fish:StripeFish",
        MinDay = 3,
        Health = 42,
        Value = 25,
        Weight = 16,
    },
    {
        Id = "TigerFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Tiger Trout",
        Rarity = "Rare",
        DiscoveryKey = "Fish:TigerFish",
        MinDay = 4,
        Health = 65,
        Value = 40,
        Weight = 10,
    },
    {
        Id = "KoiFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Koi Trout",
        Rarity = "Epic",
        DiscoveryKey = "Fish:KoiFish",
        MinDay = 5,
        Health = 92,
        Value = 65,
        Weight = 6,
    },
    {
        Id = "RainbowFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Rainbow Trout",
        Rarity = "Epic",
        DiscoveryKey = "Fish:RainbowFish",
        MinDay = 6,
        Health = 123,
        Value = 100,
        Weight = 4,
    },
    {
        Id = "ToxicFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Toxic Trout",
        Rarity = "Legendary",
        DiscoveryKey = "Fish:ToxicFish",
        MinDay = 7,
        Health = 170,
        Value = 150,
        Weight = 2.5,
    },
    {
        Id = "ArmoredFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Armored Trout",
        Rarity = "Legendary",
        DiscoveryKey = "Fish:ArmoredFish",
        MinDay = 8,
        Health = 230,
        Value = 225,
        Weight = 1.5,
    },
    {
        Id = "VoidFish",
        Kind = "Fish",
        Category = "Normal",
        DisplayName = "Void Trout",
        Rarity = "Mythic",
        DiscoveryKey = "Fish:VoidFish",
        MinDay = 10,
        Health = 350,
        Value = 500,
        Weight = 0.3,
    },
    {
        Id = "Fish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Trout",
        Rarity = "Uncommon",
        DiscoveryKey = "GiantFish:Fish",
        MinDay = 2,
        Health = 300,
        Value = 200,
        Weight = 100,
        SpawnChance = 0.012,
    },
    {
        Id = "MossFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Moss Trout",
        Rarity = "Rare",
        DiscoveryKey = "GiantFish:MossFish",
        MinDay = 2,
        Health = 460,
        Value = 300,
        Weight = 28,
        SpawnChance = 0.012,
    },
    {
        Id = "StripeFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Striped Trout",
        Rarity = "Epic",
        DiscoveryKey = "GiantFish:StripeFish",
        MinDay = 3,
        Health = 840,
        Value = 500,
        Weight = 16,
        SpawnChance = 0.012,
    },
    {
        Id = "TigerFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Tiger Trout",
        Rarity = "Epic",
        DiscoveryKey = "GiantFish:TigerFish",
        MinDay = 4,
        Health = 1300,
        Value = 800,
        Weight = 10,
        SpawnChance = 0.012,
    },
    {
        Id = "KoiFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Koi Trout",
        Rarity = "Legendary",
        DiscoveryKey = "GiantFish:KoiFish",
        MinDay = 5,
        Health = 1840,
        Value = 1300,
        Weight = 6,
        SpawnChance = 0.012,
    },
    {
        Id = "RainbowFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Rainbow Trout",
        Rarity = "Legendary",
        DiscoveryKey = "GiantFish:RainbowFish",
        MinDay = 6,
        Health = 2460,
        Value = 2000,
        Weight = 4,
        SpawnChance = 0.012,
    },
    {
        Id = "ToxicFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Toxic Trout",
        Rarity = "Mythic",
        DiscoveryKey = "GiantFish:ToxicFish",
        MinDay = 7,
        Health = 3400,
        Value = 3000,
        Weight = 2.5,
        SpawnChance = 0.012,
    },
    {
        Id = "ArmoredFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Armored Trout",
        Rarity = "Mythic",
        DiscoveryKey = "GiantFish:ArmoredFish",
        MinDay = 8,
        Health = 4600,
        Value = 4500,
        Weight = 1.5,
        SpawnChance = 0.012,
    },
    {
        Id = "VoidFish",
        Kind = "GiantFish",
        Category = "Giant",
        DisplayName = "Giant Void Trout",
        Rarity = "Mythic",
        DiscoveryKey = "GiantFish:VoidFish",
        MinDay = 10,
        Health = 7000,
        Value = 10000,
        Weight = 0.3,
        SpawnChance = 0.012,
    },
    {
        Id = "GoldFish",
        Kind = "GoldenFish",
        Category = "Gold",
        DisplayName = "Goldie",
        Rarity = "Legendary",
        DiscoveryKey = "GoldenFish:GoldFish",
        MinDay = 2,
        Health = 105,
        Value = 300,
        SpawnChance = 0.002,
        Template = "GoldFish",
    },
    {
        Id = "Shark",
        Kind = "Shark",
        Category = "Special",
        DisplayName = "Shark",
        Rarity = "Epic",
        DiscoveryKey = "Shark:Shark",
        MinDay = 3,
        Health = 60,
        Value = 75,
        SpawnChance = 0.004,
        Template = "Shark",
    },
    {
        Id = "Whale",
        Kind = "Whale",
        Category = "Special",
        DisplayName = "Whale",
        Rarity = "Mythic",
        DiscoveryKey = "Whale:Whale",
        MinDay = 5,
        Health = 984,
        Value = 500,
        SpawnChance = 0.0008,
        Template = "Whale",
    },
    {
        Id = "Fish",
        Kind = "FlashbangFish",
        Category = "Special",
        DisplayName = "Flashbang Fish",
        Rarity = "Legendary",
        DiscoveryKey = "FlashbangFish:Fish",
        MinDay = 2,
        Health = 25,
        Value = 40,
        SpawnChance = 0.003,
        Template = "Fish",
    },
    {
        Id = "BigLarry",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "BIG LARRY",
        Rarity = "Boss",
        DiscoveryKey = "Boss:BigLarry",
        MinDay = 1,
        Health = 60,
        Value = 150,
        Template = "Shark",
        BossDay = 1,
    },
    {
        Id = "PointyPete",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "POINTY PETE",
        Rarity = "Boss",
        DiscoveryKey = "Boss:PointyPete",
        MinDay = 2,
        Health = 700,
        Value = 400,
        Template = "PointyShark",
        BossDay = 2,
    },
    {
        Id = "MrWhiskers",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "MR. WHISKERS",
        Rarity = "Boss",
        DiscoveryKey = "Boss:MrWhiskers",
        MinDay = 3,
        Health = 1400,
        Value = 1000,
        Template = "WhiskerShark",
        BossDay = 3,
    },
    {
        Id = "Zappy",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "ZAPPY",
        Rarity = "Boss",
        DiscoveryKey = "Boss:Zappy",
        MinDay = 4,
        Health = 2600,
        Value = 2400,
        Template = "WireShark",
        BossDay = 4,
    },
    {
        Id = "TinTeeth",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "TIN TEETH",
        Rarity = "Boss",
        DiscoveryKey = "Boss:TinTeeth",
        MinDay = 5,
        Health = 4500,
        Value = 5000,
        Template = "IronShark",
        BossDay = 5,
    },
    {
        Id = "QueenChompy",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "QUEEN CHOMPY",
        Rarity = "Boss",
        DiscoveryKey = "Boss:QueenChompy",
        MinDay = 6,
        Health = 7000,
        Value = 9000,
        Template = "PiranhaQueen",
        BossDay = 6,
    },
    {
        Id = "RedFred",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "RED FRED",
        Rarity = "Boss",
        DiscoveryKey = "Boss:RedFred",
        MinDay = 7,
        Health = 9660,
        Value = 15000,
        Template = "BloodShark",
        BossDay = 7,
    },
    {
        Id = "MuddyBuddy",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "MUDDY BUDDY",
        Rarity = "Boss",
        DiscoveryKey = "Boss:MuddyBuddy",
        MinDay = 8,
        Health = 13331,
        Value = 24000,
        Template = "LakeShark",
        BossDay = 8,
    },
    {
        Id = "Glowbert",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "GLOWBERT",
        Rarity = "Boss",
        DiscoveryKey = "Boss:Glowbert",
        MinDay = 9,
        Health = 18397,
        Value = 36000,
        Template = "NuclearShark",
        BossDay = 9,
    },
    {
        Id = "Kevin",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "KEVIN",
        Rarity = "Boss",
        DiscoveryKey = "Boss:Kevin",
        MinDay = 10,
        Health = 25387,
        Value = 50000,
        Template = "FishShark",
        BossDay = 10,
    },
    {
        Id = "FinalShark",
        Kind = "Boss",
        Category = "Boss",
        DisplayName = "THE FINAL SHARK",
        Rarity = "Boss",
        DiscoveryKey = "Boss:FinalShark",
        MinDay = 11,
        Health = 25387,
        Value = 50000,
        Template = "Shark",
        BossDay = 11,
    },
}
local v2 = {}
for i, v in ipairs(u1) do
    if v.Kind == "Boss" and v.Id ~= "FinalShark" then
        table.insert(v2, v)
    end
end
for i2 = 2, 3 do
    for i3, j in ipairs(v2) do
        v1 = table.clone(j)
        v1.Id = j.Id .. tostring(i2)
        v1.DisplayName = j.DisplayName .. " " .. tostring(i2)
        v1.DiscoveryKey = "Boss:" .. j.Id .. tostring(i2)
        v1.MinDay = (i2 - 1) * 10 + (j.BossDay or 1)
        v1.BossDay = v1.MinDay
        table.insert(u1, v1)
    end
end
local u109 = {}
for i4, k in ipairs(u1) do
    u109[k.DiscoveryKey] = k
end

function u140.All() -- Line: 89 -- upvalues: u1 (val)
    return u1
end

function u140.Key(a1, a2) -- Line: 93
    return (tostring(a1 or "Fish")) .. ":" .. tostring(a2 or "Fish")
end

function u140.KeyForDefinition(a1) -- Line: 97 -- upvalues: u140 (val)
    if type(a1) ~= "table" then
        return u140.Key("Fish", "Fish")
    end
    if a1.Giant == true then
        return u140.Key("GiantFish", a1.Id or a1.DisplayName)
    end
    return u140.Key(a1.Kind, a1.Id or a1.DisplayName)
end

function u140.GetByKey(a1) -- Line: 107 -- upvalues: u109 (val)
    if typeof(a1) ~= "string" then
        return nil
    end
    return u109[a1]
end

function u140.GetByDefinition(a1) -- Line: 112 -- upvalues: u140 (val)
    return u140.GetByKey(u140.KeyForDefinition(a1))
end

local function normalizedBossName(a1) -- Line: 116
    return (string.gsub(string.gsub(string.gsub(string.lower((tostring(a1 or ""))), "%s+", " "), "^%s+", ""), "%s+$", ""))
end

function u140.GetByBossName(a1) -- Line: 124 -- upvalues: normalizedBossName (val), u1 (val)
    local v1 = normalizedBossName(a1)
    for i, v in ipairs(u1) do
        if v.Kind == "Boss" and normalizedBossName(v.DisplayName) == v1 then
            return v
        end
    end
    return nil
end

return table.freeze(u140)
-- Script Path: game:GetService("ReplicatedStorage").FishGame.PetAbilities
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.FishGame.PetAbilities
-- Decompile time: 7.32 ms

local u0 = {}
u0.TeamCaps = table.freeze({BossHealthReduction = 0.6, AdditionalDogs = 2})
local u21 = table.freeze({
    Common = table.freeze({Minimum = 1, DropRange = 0.18}),
    Rare = table.freeze({Minimum = 1, DropRange = 0.35}),
    Epic = table.freeze({Minimum = 1, DropRange = 1.37}),
    Legendary = table.freeze({Minimum = 1, DropRange = 1.68}),
    Dragon = table.freeze({Minimum = 1, DropRange = 2}),
})
local u29 = table.freeze({
    [60] = 0,
    [24] = 0.1875,
    [10] = 0.375,
    [5] = 0.625,
    1,
})
local u30 = {
    {
        Id = "Bear",
        DisplayName = "Biscuit",
        SpeciesName = "Bear",
        Rarity = "Common",
        EggTier = "CommonEgg",
        EggWeight = 60,
        IconAssetId = "94676365635623",
        Effect = "WeaponDamage",
        Power = 3,
        Description = "Every team weapon hit deals +3 damage.",
    },
    {
        Id = "Mouse",
        DisplayName = "Nibbles",
        SpeciesName = "Mouse",
        Rarity = "Common",
        EggTier = "CommonEgg",
        EggWeight = 24,
        IconAssetId = "106438952781674",
        Effect = "DogCapacity",
        Power = 1,
        Description = "Every dog carries +1 fish per trip.",
    },
    {
        Id = "Panda",
        DisplayName = "Bao",
        SpeciesName = "Panda",
        Rarity = "Common",
        EggTier = "CommonEgg",
        EggWeight = 10,
        IconAssetId = "128578949988471",
        Effect = "FishValue",
        Power = 5,
        Description = "Every fish the team catches is worth +$5.",
    },
    {
        Id = "Dino",
        DisplayName = "Pickles",
        SpeciesName = "Dino",
        Rarity = "Common",
        EggTier = "CommonEgg",
        EggWeight = 5,
        IconAssetId = "78314573936533",
        Effect = "DogSpeed",
        Power = 8,
        Description = "Every dog moves +8 studs per second faster.",
    },
    {
        Id = "Spider",
        DisplayName = "Buttons",
        SpeciesName = "Spider",
        Rarity = "Common",
        EggTier = "CommonEgg",
        EggWeight = 1,
        IconAssetId = "86250807151254",
        Effect = "AdditionalDogs",
        Power = 1,
        Description = "The team starts with +1 working dog.",
    },
    {
        Id = "Bat",
        DisplayName = "Pip",
        SpeciesName = "Bat",
        Rarity = "Rare",
        EggTier = "RareEgg",
        EggWeight = 60,
        IconAssetId = "91622414496057",
        Effect = "WeaponDamage",
        Power = 6,
        Description = "Every team weapon hit deals +6 damage.",
    },
    {
        Id = "Alien",
        DisplayName = "Bloop",
        SpeciesName = "Alien",
        Rarity = "Rare",
        EggTier = "RareEgg",
        EggWeight = 24,
        IconAssetId = "89985954280507",
        Effect = "FishValue",
        Power = 10,
        Description = "Every fish the team catches is worth +$10.",
    },
    {
        Id = "FrostWolf",
        DisplayName = "Snowball",
        SpeciesName = "Frost Wolf",
        Rarity = "Rare",
        EggTier = "RareEgg",
        EggWeight = 10,
        IconAssetId = "92750864949714",
        Effect = "BossHealthReduction",
        Power = 0.1,
        Description = "Bosses spawn with 10% less health.",
    },
    {
        Id = "ShadowDeer",
        DisplayName = "Moonbeam",
        SpeciesName = "Shadow Deer",
        Rarity = "Rare",
        EggTier = "RareEgg",
        EggWeight = 5,
        IconAssetId = "124971927446803",
        Effect = "DogCapacity",
        Power = 2,
        Description = "Every dog carries +2 fish per trip.",
    },
    {
        Id = "Paragon",
        DisplayName = "Prism",
        SpeciesName = "Paragon",
        Rarity = "Rare",
        EggTier = "RareEgg",
        EggWeight = 1,
        IconAssetId = "100393998665397",
        Effect = "ScaleBonus",
        Power = 25,
        Description = "Every player receives +25 Scales at the end of the run.",
    },
    {
        Id = "Crawler",
        DisplayName = "Tater",
        SpeciesName = "Crawler",
        Rarity = "Epic",
        EggTier = "EpicEgg",
        EggWeight = 60,
        IconAssetId = "114769937709087",
        Effect = "DogSpeed",
        Power = 16,
        Description = "Every dog moves +16 studs per second faster.",
    },
    {
        Id = "ManaFox",
        DisplayName = "Miso",
        SpeciesName = "Mana Fox",
        Rarity = "Epic",
        EggTier = "EpicEgg",
        EggWeight = 24,
        IconAssetId = "108726830975256",
        Effect = "FishRarity",
        Power = 1,
        Description = "Rare fish spawn as if Fish Rarity were +1 level.",
    },
    {
        Id = "ManaLord",
        DisplayName = "Wizbit",
        SpeciesName = "Mana Lord",
        Rarity = "Epic",
        EggTier = "EpicEgg",
        EggWeight = 10,
        IconAssetId = "124317303307301",
        Effect = "PassiveIncome",
        Power = 3,
        Description = "Earns the team $3 per second on Day 1, plus another $3 each day.",
    },
    {
        Id = "LavaSlime",
        DisplayName = "Sizzle",
        SpeciesName = "Lava Slime",
        Rarity = "Epic",
        EggTier = "EpicEgg",
        EggWeight = 5,
        IconAssetId = "115705351307739",
        Effect = "TurretDamage",
        Power = 15,
        Description = "Every team turret shot deals +15 damage.",
    },
    {
        Id = "TheDuke",
        DisplayName = "Nugget",
        SpeciesName = "The Duke",
        Rarity = "Epic",
        EggTier = "EpicEgg",
        EggWeight = 1,
        IconAssetId = "88318575992799",
        Effect = "ScaleBonus",
        Power = 40,
        Description = "Every player receives +40 Scales at the end of the run.",
    },
    {
        Id = "Bunny",
        DisplayName = "Mochi",
        SpeciesName = "Bunny",
        Rarity = "Legendary",
        EggTier = "LegendaryEgg",
        EggWeight = 60,
        IconAssetId = "117663011693004",
        Effect = "DogCapacity",
        Power = 4,
        Description = "Every dog carries +4 fish per trip.",
    },
    {
        Id = "GoldenPig",
        DisplayName = "Sir Waddles",
        SpeciesName = "Golden Pig",
        Rarity = "Legendary",
        EggTier = "LegendaryEgg",
        EggWeight = 24,
        IconAssetId = "98994424190815",
        Effect = "PassiveIncome",
        Power = 6,
        Description = "Earns the team $6 per second on Day 1, plus another $6 each day.",
    },
    {
        Id = "GlowMoth",
        DisplayName = "Twinkle",
        SpeciesName = "Glow Moth",
        Rarity = "Legendary",
        EggTier = "LegendaryEgg",
        EggWeight = 10,
        IconAssetId = "75635307699074",
        Effect = "FishRarity",
        Power = 2,
        Description = "Rare fish spawn as if Fish Rarity were +2 levels.",
    },
    {
        Id = "Pyromidium",
        DisplayName = "Ember",
        SpeciesName = "Pyromidium",
        Rarity = "Legendary",
        EggTier = "LegendaryEgg",
        EggWeight = 5,
        IconAssetId = "75800489012311",
        Effect = "TurretDamage",
        Power = 30,
        Description = "Every team turret shot deals +30 damage.",
    },
    {
        Id = "TheQueen",
        DisplayName = "Peaches",
        SpeciesName = "The Queen",
        Rarity = "Legendary",
        EggTier = "LegendaryEgg",
        EggWeight = 1,
        IconAssetId = "115261531585324",
        Effect = "AdditionalDogs",
        Power = 2,
        Description = "The team starts with +2 working dogs.",
    },
    {
        Id = "BabyDragon",
        DisplayName = "Pebble",
        SpeciesName = "Baby Dragon",
        Rarity = "Dragon",
        EggTier = "DragonEgg",
        EggWeight = 60,
        IconAssetId = "85884075920947",
        Effect = "WeaponDamage",
        Power = 18,
        Description = "Every team weapon hit deals +18 damage.",
    },
    {
        Id = "ShadowDragon",
        DisplayName = "Smudge",
        SpeciesName = "Shadow Dragon",
        Rarity = "Dragon",
        EggTier = "DragonEgg",
        EggWeight = 24,
        IconAssetId = "97838093693017",
        Effect = "FishValue",
        Power = 40,
        Description = "Every fish the team catches is worth +$40.",
    },
    {
        Id = "InkGuardian",
        DisplayName = "Inky",
        SpeciesName = "Ink Guardian",
        Rarity = "Dragon",
        EggTier = "DragonEgg",
        EggWeight = 10,
        IconAssetId = "78509381453119",
        Effect = "DogSpeed",
        Power = 35,
        Description = "Every dog moves +35 studs per second faster.",
    },
    {
        Id = "CrimsonKnight",
        DisplayName = "Ruby",
        SpeciesName = "Crimson Knight",
        Rarity = "Dragon",
        EggTier = "DragonEgg",
        EggWeight = 5,
        IconAssetId = "116780107007284",
        Effect = "BossHealthReduction",
        Power = 0.3,
        Description = "Bosses spawn with 30% less health.",
    },
    {
        Id = "TheEmperor",
        DisplayName = "Dumpling",
        SpeciesName = "The Emperor",
        Rarity = "Dragon",
        EggTier = "DragonEgg",
        EggWeight = 1,
        IconAssetId = "136000985192512",
        Effect = "ScaleBonus",
        Power = 75,
        Description = "Every player receives +75 Scales at the end of the run.",
    },
}
local u56 = {}
for i, j in u30 do
    u56[j.Id] = j
end

function u0.All() -- Line: 147 -- upvalues: u30 (val)
    return u30
end

function u0.Get(a1) -- Line: 151 -- upvalues: u56 (val)
    if typeof(a1) == "string" then
        return u56[a1]
    end
    return nil
end

function u0.SizeMultiplier(a1) -- Line: 155 -- upvalues: u0 (val), u21 (val), u29 (val)
    local v1
    if type(if typeof(a1) ~= "string" then a1 else u0.Get(a1)) ~= "table" then
        return 1
    end
    local v2 = u21[v1.Rarity]
    if not v2 then
        return 1
    end
    return v2.Minimum + v2.DropRange * (u29[(math.floor((tonumber(v1.EggWeight)) or 0))] or 0)
end

function u0.IsValid(a1) -- Line: 164 -- upvalues: u0 (val)
    return u0.Get(a1) ~= nil
end

function u0.PetsForEgg(a1) -- Line: 168 -- upvalues: u30 (val) -- types: a1: string
    local v1 = {}
    for i, j in u30 do
        if j.EggTier == a1 then
            table.insert(v1, j)
        end
    end
    table.sort(v1, function(a1, a2) -- Line: 173
        return a2.EggWeight < a1.EggWeight
    end)
    return v1
end

function u0.EquippedId(a1) -- Line: 177 -- upvalues: u0 (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute("EquippedPet")
    if u0.IsValid(Attribute) then
        return Attribute
    end
    return nil
end

function u0.PlayerEffect(a1, a2) -- Line: 182 -- upvalues: u0 (val) -- types: a1: userdata, a2: string
    local v1 = u0.Get(u0.EquippedId(a1))
    if v1 and v1.Effect == a2 then
        return v1.Power
    end
    return 0
end

function u0.TeamTotal(a1, a2) -- Line: 187 -- upvalues: u0 (val) -- types: a1: table, a2: string
    local v1 = 0
    for i, j in a1 do
        v1 = v1 + u0.PlayerEffect(j, a2)
    end
    local v2 = u0.TeamCaps[a2]
    if typeof(v2) == "number" then
        return (math.min(v2, v1))
    end
    return v1
end

function u0.TeamMaximum(a1, a2) -- Line: 196 -- upvalues: u0 (val) -- types: a1: table, a2: string
    local v1 = 0
    for i, j in a1 do
        v1 = math.max(v1, (u0.PlayerEffect(j, a2)))
    end
    return v1
end

return table.freeze(u0)
-- Script Path: game:GetService("ReplicatedStorage").FishGame.ResearchConfig
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.FishGame.ResearchConfig
-- Decompile time: 12.23 ms

local u0 = {}
u0.Categories = {
    {
        Id = "Handling",
        Name = "GUN HANDLING",
        Subtitle = "Reload and fire faster",
        Icon = "rbxassetid://17368052918",
        Color = Color3.fromRGB(67, 156, 255),
    },
    {
        Id = "Economy",
        Name = "FISH & MONEY",
        Subtitle = "Catch and sell more",
        Icon = "rbxassetid://15402858705",
        Color = Color3.fromRGB(42, 204, 128),
    },
    {
        Id = "Weapons",
        Name = "WEAPON CRATE",
        Subtitle = "Better and cheaper guns",
        Icon = "rbxassetid://17368084270",
        Color = Color3.fromRGB(177, 92, 255),
    },
    {
        Id = "Ordnance",
        Name = "ORDNANCE",
        Subtitle = "Better deliveries, faster",
        Icon = "rbxassetid://15403027709",
        Color = Color3.fromRGB(255, 143, 55),
    },
}
u0.Nodes = {
    RL1 = {
        Name = "Quick Hands I",
        Category = "Handling",
        Q = -1,
        R = 0,
        Cost = 150,
        Stat = "Reload",
        Rank = 1,
        Description = "Reload all guns 8% faster.",
        Parents = {},
    },
    RL2 = {
        Name = "Quick Hands II",
        Category = "Handling",
        Q = -2,
        R = 0,
        Cost = 400,
        Stat = "Reload",
        Rank = 2,
        Description = "Reload all guns 16% faster.",
        Parents = {"RL1"},
    },
    RL3 = {
        Name = "Quick Hands III",
        Category = "Handling",
        Q = -2,
        R = -1,
        Cost = 900,
        Stat = "Reload",
        Rank = 3,
        Description = "Reload all guns 24% faster.",
        Parents = {"RL2"},
    },
    RL4 = {
        Name = "Quick Hands IV",
        Category = "Handling",
        Q = -3,
        R = -1,
        Cost = 1800,
        Stat = "Reload",
        Rank = 4,
        Description = "Reload all guns 32% faster.",
        Parents = {"RL3"},
    },
    RL5 = {
        Name = "Quick Hands V",
        Category = "Handling",
        Q = -4,
        R = -1,
        Cost = 3500,
        Stat = "Reload",
        Rank = 5,
        Description = "Reload all guns 40% faster.",
        Parents = {"RL4"},
    },
    FR1 = {
        Name = "Rapid Action I",
        Category = "Handling",
        Q = 1,
        R = -1,
        Cost = 150,
        Stat = "FireRate",
        Rank = 1,
        Description = "Fire all guns 6% faster.",
        Parents = {},
    },
    FR2 = {
        Name = "Rapid Action II",
        Category = "Handling",
        Q = 2,
        R = -2,
        Cost = 400,
        Stat = "FireRate",
        Rank = 2,
        Description = "Fire all guns 12% faster.",
        Parents = {"FR1"},
    },
    FR3 = {
        Name = "Rapid Action III",
        Category = "Handling",
        Q = 3,
        R = -2,
        Cost = 900,
        Stat = "FireRate",
        Rank = 3,
        Description = "Fire all guns 18% faster.",
        Parents = {"FR2"},
    },
    FR4 = {
        Name = "Rapid Action IV",
        Category = "Handling",
        Q = 4,
        R = -3,
        Cost = 1800,
        Stat = "FireRate",
        Rank = 4,
        Description = "Fire all guns 24% faster.",
        Parents = {"FR3"},
    },
    FR5 = {
        Name = "Rapid Action V",
        Category = "Handling",
        Q = 5,
        R = -3,
        Cost = 3500,
        Stat = "FireRate",
        Rank = 5,
        Description = "Fire all guns 30% faster.",
        Parents = {"FR4"},
    },
    FY1 = {
        Name = "Wider Nets I",
        Category = "Economy",
        Q = -1,
        R = 0,
        Cost = 150,
        Stat = "FishYield",
        Rank = 1,
        Description = "Guns launch 10% more fish.",
        Parents = {},
    },
    FY2 = {
        Name = "Wider Nets II",
        Category = "Economy",
        Q = -2,
        R = 0,
        Cost = 400,
        Stat = "FishYield",
        Rank = 2,
        Description = "Guns launch 20% more fish.",
        Parents = {"FY1"},
    },
    FY3 = {
        Name = "Wider Nets III",
        Category = "Economy",
        Q = -2,
        R = 1,
        Cost = 900,
        Stat = "FishYield",
        Rank = 3,
        Description = "Guns launch 30% more fish.",
        Parents = {"FY2"},
    },
    FY4 = {
        Name = "Wider Nets IV",
        Category = "Economy",
        Q = -3,
        R = 1,
        Cost = 1800,
        Stat = "FishYield",
        Rank = 4,
        Description = "Guns launch 40% more fish.",
        Parents = {"FY3"},
    },
    FY5 = {
        Name = "Wider Nets V",
        Category = "Economy",
        Q = -4,
        R = 2,
        Cost = 3500,
        Stat = "FishYield",
        Rank = 5,
        Description = "Guns launch 50% more fish.",
        Parents = {"FY4"},
    },
    MV1 = {
        Name = "Better Buyer I",
        Category = "Economy",
        Q = 0,
        R = 1,
        Cost = 150,
        Stat = "MoneyValue",
        Rank = 1,
        Description = "Each fish sells for 10% more.",
        Parents = {},
    },
    MV2 = {
        Name = "Better Buyer II",
        Category = "Economy",
        Q = 0,
        R = 2,
        Cost = 400,
        Stat = "MoneyValue",
        Rank = 2,
        Description = "Each fish sells for 20% more.",
        Parents = {"MV1"},
    },
    MV3 = {
        Name = "Better Buyer III",
        Category = "Economy",
        Q = 1,
        R = 2,
        Cost = 900,
        Stat = "MoneyValue",
        Rank = 3,
        Description = "Each fish sells for 30% more.",
        Parents = {"MV2"},
    },
    MV4 = {
        Name = "Better Buyer IV",
        Category = "Economy",
        Q = 1,
        R = 3,
        Cost = 1800,
        Stat = "MoneyValue",
        Rank = 4,
        Description = "Each fish sells for 40% more.",
        Parents = {"MV3"},
    },
    MV5 = {
        Name = "Better Buyer V",
        Category = "Economy",
        Q = 2,
        R = 3,
        Cost = 3500,
        Stat = "MoneyValue",
        Rank = 5,
        Description = "Each fish sells for 50% more.",
        Parents = {"MV4"},
    },
    WL1 = {
        Name = "Weapon Luck I",
        Category = "Weapons",
        Q = 1,
        R = 0,
        Cost = 250,
        Stat = "WeaponLuck",
        Rank = 1,
        Description = "Improves the weapon crate loot table.",
        Parents = {},
    },
    WL2 = {
        Name = "Weapon Luck II",
        Category = "Weapons",
        Q = 2,
        R = 0,
        Cost = 600,
        Stat = "WeaponLuck",
        Rank = 2,
        Description = "Improves the weapon crate loot table.",
        Parents = {"WL1"},
    },
    WL3 = {
        Name = "Weapon Luck III",
        Category = "Weapons",
        Q = 3,
        R = 0,
        Cost = 1200,
        Stat = "WeaponLuck",
        Rank = 3,
        Description = "Improves the weapon crate loot table.",
        Parents = {"WL2"},
    },
    WL4 = {
        Name = "Weapon Luck IV",
        Category = "Weapons",
        Q = 4,
        R = 0,
        Cost = 2500,
        Stat = "WeaponLuck",
        Rank = 4,
        Description = "Adds a chance for the minigun.",
        Parents = {"WL3", "WD3"},
    },
    WL5 = {
        Name = "Weapon Luck V",
        Category = "Weapons",
        Q = 5,
        R = 0,
        Cost = 5000,
        Stat = "WeaponLuck",
        Rank = 5,
        Description = "Greatly improves rare weapon odds.",
        Parents = {"WL4", "WD4"},
    },
    WL6 = {
        Name = "Weapon Luck VI",
        Category = "Weapons",
        Q = 6,
        R = 0,
        Cost = 9000,
        Stat = "WeaponLuck",
        Rank = 6,
        Description = "Best possible weapon crate odds.",
        Parents = {"WL5"},
    },
    WD1 = {
        Name = "Cheaper Rolls I",
        Category = "Weapons",
        Q = 2,
        R = 1,
        Cost = 300,
        Stat = "WeaponDiscount",
        Rank = 1,
        Description = "Weapon rolls cost 10% less.",
        Parents = {"WL2"},
    },
    WD2 = {
        Name = "Cheaper Rolls II",
        Category = "Weapons",
        Q = 3,
        R = 1,
        Cost = 800,
        Stat = "WeaponDiscount",
        Rank = 2,
        Description = "Weapon rolls cost 20% less.",
        Parents = {"WD1"},
    },
    WD3 = {
        Name = "Cheaper Rolls III",
        Category = "Weapons",
        Q = 4,
        R = 1,
        Cost = 1800,
        Stat = "WeaponDiscount",
        Rank = 3,
        Description = "Weapon rolls cost 30% less.",
        Parents = {"WD2"},
    },
    WD4 = {
        Name = "Cheaper Rolls IV",
        Category = "Weapons",
        Q = 5,
        R = 1,
        Cost = 4000,
        Stat = "WeaponDiscount",
        Rank = 4,
        Description = "Weapon rolls cost 40% less.",
        Parents = {"WD3"},
    },
    OL1 = {
        Name = "Ordnance Luck I",
        Category = "Ordnance",
        Q = 0,
        R = 1,
        Cost = 150,
        Stat = "OrdnanceLuck",
        Rank = 1,
        Description = "Improves free ordnance deliveries.",
        Parents = {},
    },
    OL2 = {
        Name = "Ordnance Luck II",
        Category = "Ordnance",
        Q = -1,
        R = 2,
        Cost = 250,
        Stat = "OrdnanceLuck",
        Rank = 2,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL1"},
    },
    OL3 = {
        Name = "Ordnance Luck III",
        Category = "Ordnance",
        Q = -1,
        R = 3,
        Cost = 400,
        Stat = "OrdnanceLuck",
        Rank = 3,
        Description = "Adds Carpet Bombing to the crate.",
        Parents = {"OL2"},
    },
    OL4 = {
        Name = "Ordnance Luck IV",
        Category = "Ordnance",
        Q = 0,
        R = 3,
        Cost = 650,
        Stat = "OrdnanceLuck",
        Rank = 4,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL3", "OC3"},
    },
    OL5 = {
        Name = "Ordnance Luck V",
        Category = "Ordnance",
        Q = 0,
        R = 4,
        Cost = 1000,
        Stat = "OrdnanceLuck",
        Rank = 5,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL4", "OC4"},
    },
    OL6 = {
        Name = "Ordnance Luck VI",
        Category = "Ordnance",
        Q = -1,
        R = 5,
        Cost = 1500,
        Stat = "OrdnanceLuck",
        Rank = 6,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL5"},
    },
    OL7 = {
        Name = "Ordnance Luck VII",
        Category = "Ordnance",
        Q = -1,
        R = 6,
        Cost = 2200,
        Stat = "OrdnanceLuck",
        Rank = 7,
        Description = "Adds Orbital Strike to the crate.",
        Parents = {"OL6"},
    },
    OL8 = {
        Name = "Ordnance Luck VIII",
        Category = "Ordnance",
        Q = 0,
        R = 6,
        Cost = 3000,
        Stat = "OrdnanceLuck",
        Rank = 8,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL7", "OC6"},
    },
    OL9 = {
        Name = "Ordnance Luck IX",
        Category = "Ordnance",
        Q = 0,
        R = 7,
        Cost = 4000,
        Stat = "OrdnanceLuck",
        Rank = 9,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL8", "OC7"},
    },
    OL10 = {
        Name = "Ordnance Luck X",
        Category = "Ordnance",
        Q = -1,
        R = 8,
        Cost = 5500,
        Stat = "OrdnanceLuck",
        Rank = 10,
        Description = "Improves free ordnance deliveries.",
        Parents = {"OL9"},
    },
    OL11 = {
        Name = "Ordnance Luck XI",
        Category = "Ordnance",
        Q = -1,
        R = 9,
        Cost = 7500,
        Stat = "OrdnanceLuck",
        Rank = 11,
        Description = "Adds the Nuke to the crate.",
        Parents = {"OL10"},
    },
    OL12 = {
        Name = "Ordnance Luck XII",
        Category = "Ordnance",
        Q = 0,
        R = 9,
        Cost = 10000,
        Stat = "OrdnanceLuck",
        Rank = 12,
        Description = "Best possible ordnance odds.",
        Parents = {"OL11"},
    },
    OC1 = {
        Name = "Faster Delivery I",
        Category = "Ordnance",
        Q = 1,
        R = 1,
        Cost = 250,
        Stat = "OrdnanceCooldown",
        Rank = 1,
        Description = "Delivery cooldown becomes 56 seconds.",
        Parents = {"OL1"},
    },
    OC2 = {
        Name = "Faster Delivery II",
        Category = "Ordnance",
        Q = 1,
        R = 2,
        Cost = 600,
        Stat = "OrdnanceCooldown",
        Rank = 2,
        Description = "Delivery cooldown becomes 52 seconds.",
        Parents = {"OC1"},
    },
    OC3 = {
        Name = "Faster Delivery III",
        Category = "Ordnance",
        Q = 1,
        R = 3,
        Cost = 1200,
        Stat = "OrdnanceCooldown",
        Rank = 3,
        Description = "Delivery cooldown becomes 48 seconds.",
        Parents = {"OC2", "OL4"},
    },
    OC4 = {
        Name = "Faster Delivery IV",
        Category = "Ordnance",
        Q = 1,
        R = 4,
        Cost = 2500,
        Stat = "OrdnanceCooldown",
        Rank = 4,
        Description = "Delivery cooldown becomes 44 seconds.",
        Parents = {"OC3", "OL5"},
    },
    OC5 = {
        Name = "Faster Delivery V",
        Category = "Ordnance",
        Q = 1,
        R = 5,
        Cost = 4500,
        Stat = "OrdnanceCooldown",
        Rank = 5,
        Description = "Delivery cooldown becomes 40 seconds.",
        Parents = {"OC4"},
    },
    OC6 = {
        Name = "Faster Delivery VI",
        Category = "Ordnance",
        Q = 1,
        R = 6,
        Cost = 7000,
        Stat = "OrdnanceCooldown",
        Rank = 6,
        Description = "Delivery cooldown becomes 36 seconds.",
        Parents = {"OC5", "OL8"},
    },
    OC7 = {
        Name = "Faster Delivery VII",
        Category = "Ordnance",
        Q = 1,
        R = 7,
        Cost = 10000,
        Stat = "OrdnanceCooldown",
        Rank = 7,
        Description = "Delivery cooldown becomes 32 seconds.",
        Parents = {"OC6", "OL9"},
    },
    OA1 = {
        Name = "Auto-Loader",
        Category = "Ordnance",
        Q = 2,
        R = 5,
        Cost = 7500,
        Stat = "AutoLoader",
        Rank = 1,
        Description = "Automatically gives each delivery to a random active player.",
        Parents = {"OC5"},
    },
}

function u0.IsRevealed(a1, a2) -- Line: 68 -- upvalues: u0 (val) -- types: a1: string, a2: table
    local v1 = u0.Nodes[a1]
    if not v1 then
        return false
    end
    if #v1.Parents == 0 then
        return true
    end
    for i, v in ipairs(v1.Parents) do
        if a2[v] then
            return true
        end
    end
    return false
end

function u0.Count() -- Line: 78 -- upvalues: u0 (val)
    local v1 = 0
    for k in pairs(u0.Nodes) do
        v1 = v1 + 1
    end
    return v1
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").FishGame.RunState
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.FishGame.RunState
-- Decompile time: 11.28 ms

local u0 = {}
local Players = game:GetService("Players")
local Dogs = game:GetService("ReplicatedStorage"):WaitForChild("Dogs")

local function dogModelForId(a1) -- Line: 9 -- upvalues: Dogs (val) -- types: a1: string?
    if typeof(a1) ~= "string" then
        return nil
    end
    local v1 = Dogs:FindFirstChild(a1)
    if v1 and v1:IsA("Model") and v1:GetAttribute("DogId") == a1 then
        return v1
    end
    for i, v in ipairs(Dogs:GetChildren()) do
        if v:IsA("Model") and v:GetAttribute("DogId") == a1 then
            return v
        end
    end
    return nil
end

u0.Data = {
    FishRemaining = 10000,
    FishCaught = 0,
    BossesDefeated = 0,
    StoredFish = 0,
    StoredFishValue = 0,
    TeamCash = 0,
    Selling = false,
    Day = 1,
    DayEndsAt = 0,
    SkipDayAvailableAt = 0,
    Phase = "Tutorial",
    Difficulty = "Normal",
    PhaseEndsAt = 0,
    ShoalWarning = false,
    ShoalActive = false,
    ShoalEndsAt = 0,
    DayEventWarning = "",
    FinalBossTriggered = false,
    FinalBossPending = false,
    FinalBossActive = false,
    MajorEventDay = 0,
    MajorEventKind = "",
    LastTsunamiDay = 0,
    PilotHiredThroughDay = 0,
    PilotForever = false,
    PilotActive = false,
    PilotGuidanceActive = false,
    MerchantAvailable = false,
    MerchantGuidanceActive = false,
    MerchantUpgrades = {Health = 0, Dodge = 0},
    SpawnEnabled = false,
    TutorialActive = true,
    TutorialStage = "Waiting",
    TutorialDogName = "Waffles",
    SpawnInterval = 0.8,
    SpawnBurst = 1,
    MaxActiveFish = 36,
    ForcedRedSpawns = 0,
    GoldenFishSpawnedDay = 0,
    GoldenFishSpawnCountDay = 0,
    GoldenFishSpawnCount = 0,
    GuaranteedGoldenAt = 0,
    RedAttackerCap = 2,
    Boss = {
        Active = false,
        Name = "",
        Health = 0,
        MaxHealth = 0,
        Reward = 0,
        Invulnerable = false,
    },
    AirstrikeReadyAt = 0,
    AirstrikeActive = false,
    Upgrades = {
        FishChain = 0,
        FishValue = 0,
        FishRarity = 0,
        Magazine = 0,
        Reload = 0,
        Damage = 0,
        DogAutoDeposit = 0,
        DogSpeed = 0,
        DogCarry = 0,
        TurretCount = 0,
        TurretDamage = 0,
        TurretFireSpeed = 0,
        BetterDock = 0,
        RedTurretCount = 0,
        AdditionalDogs = 0,
        Airstrike = 0,
        AirstrikeCooldown = 0,
    },
    Research = {
        Reload = 0,
        FireRate = 0,
        FishYield = 0,
        MoneyValue = 0,
        WeaponLuck = 0,
        WeaponDiscount = 0,
        OrdnanceLuck = 0,
        OrdnanceCooldown = 0,
        AutoLoader = 0,
    },
    OwnedResearch = {},
    OrdnanceReadyAt = 0,
    OrdnancePending = nil,
}
u0.PlayerStates = {}
u0.VisualFish = {}
u0.ActiveVisualFish = 0

function u0.TryReserveMajorEvent(a1, a2) -- Line: 118 -- upvalues: u0 (val)
    local v1 = math.max(1, (math.floor((tonumber(a1)) or 1)))
    local v2 = tostring(a2 or "")
    if v2 ~= "" and u0.Data.Phase == "Day" and math.floor((tonumber(u0.Data.Day)) or 0) == v1 then
        if math.floor((tonumber(u0.Data.MajorEventDay)) or 0) == v1 then
            return false
        end
        u0.Data.MajorEventDay = v1
        u0.Data.MajorEventKind = v2
        return true
    end
    return false
end

function u0.RegisterFishBatch(a1, a2) -- Line: 133
    return 0
end

u0.PartySize = 1

function u0.MarkDirty() end

function u0.Broadcast() end

function u0.SendState(a1) end

function u0.RecordTeamFishCaught(a1) end

function u0.StoreFish(a1, a2) -- Line: 139
    return false
end

function u0.ApplyWorldUpgrades(a1) end

function u0.ApplyDogUpgrades(a1) end

function u0.DamageFishInRadius(a1, a2, a3) -- Line: 142
    return 0
end

function u0.FindTurretTarget(a1, a2, a3) -- Line: 143
    return nil, nil
end

function u0.DamageFish(a1, a2) -- Line: 144
    return false
end

function u0.CallAirstrike() -- Line: 145
    return false
end

function u0.DropAirstrikeBomb(a1, a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 146
    return false
end

function u0.DamagePlayer(a1, a2, a3) -- Line: 157
    if not a2 then
        return false
    end
    a2:TakeDamage((math.max(0, (tonumber(a3)) or 0)))
    return true
end

function u0.GetBossShotHit(a1, a2, a3, a4) -- Line: 164
    return nil
end

function u0.GetBossTarget(a1, a2) -- Line: 165
    return nil, nil
end

function u0.DamageBoss(a1, a2) -- Line: 166
    return false
end

function u0.DamageBossInRadius(a1, a2, a3) -- Line: 167
    return 0
end

function u0.StartBoss(a1, a2) -- Line: 168
    return false
end

function u0.ActivateBoss() end

function u0.RemoveBoss() end

function u0.OnBossDefeated(a1, a2) end

function u0.TriggerFinalBoss() -- Line: 172
    return false
end

function u0.StopGameplayForVictory() end

function u0.CompleteVictory() end

function u0.RefillPlayers() end

function u0.DebugNextDay() -- Line: 176
    return false
end

function u0.DebugStartNight() -- Line: 177
    return false
end

function u0.DebugStartShoal() -- Line: 178
    return false
end

function u0.DebugStartTsunami() -- Line: 179
    return false
end

function u0.DebugSpawnRiverHazard(a1) -- Line: 180
    return nil
end

function u0.DebugStartBalloonPilot() -- Line: 181
    return false
end

function u0.DebugStartTravelingMerchant() -- Line: 182
    return false
end

function u0.SpawnRiverEncounter(a1) -- Line: 183
    return nil
end

function u0.RetireRiverEncounter(a1) -- Line: 184
    return false
end

function u0.CompleteTutorial() -- Line: 185
    return false
end

function u0.OnTutorialDogReady(a1, a2) end

function u0.GetLifetimeLeaderboardPosition(a1) -- Line: 187
    return 0
end

function u0.GrantRunScales(a1, a2) -- Line: 188
    return false, 0
end

function u0.StoreDogFish(a1, a2) -- Line: 189
    return false
end

function u0.GetTeamPetEffect(a1) -- Line: 190
    return 0
end

function u0.DiscoverBoss(a1, a2) -- Line: 191
    return false
end

function u0.GetTeamDogEffect(a1) -- Line: 192 -- upvalues: Players (val), dogModelForId (val)
    local Attribute, v1, v2
    if typeof(a1) ~= "string" then
        return 0
    end
    local v3 = 0
    for i, v in ipairs(Players:GetPlayers()) do
        if v:GetAttribute("DogSystemLoaded") == true then
            for i2 = 1, 3 do
                v1 = if i2 ~= 1 then "EquippedDog" .. tostring(i2) else "EquippedDog"
                Attribute = v:GetAttribute(v1)
                v2 = dogModelForId(Attribute)
                if v2
                    and v2:IsA("Model")
                    and v2:GetAttribute("DogId") == Attribute
                    and v2:GetAttribute("DogEffect") == a1 then
                    v3 = v3 + math.max(0, (tonumber((v2:GetAttribute("DogPower")))) or 0)
                end
            end
        end
    end
    return v3
end

function u0.CanPurchaseUpgrade(a1, a2) -- Line: 213
    return false
end

function u0.ReservePaidUpgrade(a1, a2, a3) -- Line: 214
    return false
end

function u0.ReleasePaidUpgradeReservation(a1) end

function u0.GrantPaidUpgrade(a1, a2, a3) -- Line: 216
    return false
end

function u0.PromptUpgradePurchase(a1, a2) -- Line: 217
    return false
end

function u0.PromptPilotForeverPurchase(a1) -- Line: 218
    return false
end

function u0.GrantPilotForeverPurchase(a1) -- Line: 219
    return false
end

function u0.PromptRespawnPurchase(a1) -- Line: 220
    return false
end

function u0.RespawnPlayer(a1) -- Line: 221
    return false
end

u0.UpgradePurchasesReady = false
u0.PilotForeverPurchasesReady = false
u0.RespawnPurchasesReady = false
return u0
-- Script Path: game:GetService("ReplicatedStorage").FishSurvival.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.FishSurvival.Config
-- Decompile time: 3.06 ms

local u0 = {
    TotalFish = 100000,
    MaxPlayers = 4,
    DayLength = 210,
    FlockLength = 40,
    IntermissionLength = 10,
    StudioDayLength = 55,
    StudioFlockLength = 15,
    StudioIntermissionLength = 5,
    ActiveFishCap = 140,
    CollectibleCap = 180,
    HitMarkerImage = "rbxassetid://1648883000",
}
u0.World = {Origin = Vector3.new(0, 300, 0), FlightHalfWidth = 105, FlightDepth = 75, GroundY = 302}
u0.Weapons = {
    Starter = {
        Name = "Fish Popper",
        Damage = 1,
        Magazine = 3,
        Reload = 2.1,
        FireInterval = 0.42,
        ClusterRadius = 5,
        MaxTargets = 3,
        Cost = 0,
    },
    Repeater = {
        Name = "Lake Repeater",
        Damage = 2,
        Magazine = 6,
        Reload = 1.8,
        FireInterval = 0.3,
        ClusterRadius = 5.5,
        MaxTargets = 4,
        Cost = 30,
    },
    Boomstick = {
        Name = "School Boomstick",
        Damage = 5,
        Magazine = 2,
        Reload = 2.3,
        FireInterval = 0.62,
        ClusterRadius = 10,
        MaxTargets = 8,
        Cost = 90,
    },
    AutoPopper = {
        Name = "Auto Popper",
        Damage = 3,
        Magazine = 14,
        Reload = 1.9,
        FireInterval = 0.14,
        ClusterRadius = 6,
        MaxTargets = 5,
        Cost = 240,
    },
}
u0.WeaponOrder = {"Starter", "Repeater", "Boomstick", "AutoPopper"}
u0.FishTypes = {
    {
        Id = "Bluegill",
        MinDay = 1,
        Weight = 64,
        Health = 1,
        Value = 6,
        Size = Vector3.new(3.4000000953674316, 1.7000000476837158, 1.7000000476837158),
        Color = Color3.fromRGB(75, 176, 255),
    },
    {
        Id = "Bass",
        MinDay = 3,
        Weight = 24,
        Health = 2,
        Value = 14,
        Size = Vector3.new(4.099999904632568, 2, 2),
        Color = Color3.fromRGB(90, 190, 105),
    },
    {
        Id = "Catfish",
        MinDay = 6,
        Weight = 10,
        Health = 4,
        Value = 34,
        Size = Vector3.new(4.800000190734863, 2.0999999046325684, 2.0999999046325684),
        Color = Color3.fromRGB(112, 117, 145),
    },
    {
        Id = "Golden Koi",
        MinDay = 10,
        Weight = 2,
        Health = 7,
        Value = 120,
        Size = Vector3.new(4.5, 2, 2),
        Color = Color3.fromRGB(255, 198, 54),
    },
}
u0.UpgradeCategories = {
    Fish = {"FishChain", "FishValue", "FishRarity"},
    Gun = {"Magazine", "Reload", "Damage"},
    Dog = {"DogAutoDeposit", "DogSpeed", "DogCarry"},
}
u0.UpgradeOrder = {
    "FishChain",
    "FishValue",
    "FishRarity",
    "Magazine",
    "Reload",
    "Damage",
    "DogAutoDeposit",
    "DogSpeed",
    "DogCarry",
}
u0.Upgrades = {
    FishChain = {Name = "They Found Us Bro", Max = 5, BaseCost = 120, Growth = 1.85},
    FishValue = {Name = "Valuable Fish", Max = 10, BaseCost = 75, Growth = 1.58},
    FishRarity = {Name = "Rare Fish", Max = 5, BaseCost = 180, Growth = 1.9},
    Magazine = {Name = "Too Much Ammo", Max = 14, BaseCost = 75, Growth = 1.432},
    Reload = {Name = "More Reloading", Max = 12, BaseCost = 60, Growth = 1.354},
    Damage = {Name = "Bigger Bullets", Max = 18, BaseCost = 30, Growth = 1.48},
    DogAutoDeposit = {Name = "Good Boy", Max = 1, BaseCost = 450, Growth = 1},
    DogSpeed = {Name = "Fast Boy", Max = 8, BaseCost = 35, Growth = 1.62},
    DogCarry = {Name = "Fat Boy", Max = 10, BaseCost = 40, Growth = 1.55},
}

function u0.UpgradeCost(a1, a2) -- Line: 63 -- upvalues: u0 (val) -- types: a1: string, a2: number
    local v1 = u0.Upgrades[a1]
    if not v1 then
        return (1 / 0)
    end
    return (math.floor(v1.BaseCost * v1.Growth ^ a2 + 0.5))
end

function u0.FishHealth(a1, a2) -- Line: 69 -- types: a1: number, a2: number
    return a1 + math.floor((math.max(0, a2 - 1)) / 6)
end

function u0.SpawnInterval(a1) -- Line: 73 -- types: a1: number
    return (math.max(0.16, 1.05 - (a1 - 1) * 0.032))
end

function u0.SpawnBatch(a1) -- Line: 77 -- types: a1: number
    return (math.clamp(math.floor((a1 - 1) / 4) + 1, 1, 8))
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").PetMotion
-- Took 0.07s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.PetMotion
-- Decompile time: 73.09 ms

local RunService = game:GetService("RunService")
local u5 = {}
u5.DefaultTuning = table.freeze({
    BounceHeightStuds = 0.9,
    BounceHz = 3,
    SwayStuds = 0.45,
    SwayHz = 1.6,
    LeanDegrees = 13,
    BankDegrees = 9,
    IdleBobStuds = 0.18,
    IdleBobHz = 1,
})
local u9 = {
    hop = true,
    fast = true,
    heavy = true,
    scuttle = true,
    hover = true,
}

local function smoothstep(a1) -- Line: 87 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function smootherstep(a1) -- Line: 92 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * v1 * (v1 * (v1 * 6 - 15) + 10)
end

local function yawFromDirection(a1) -- Line: 97 -- types: a1: vector
    return (math.atan2(-a1.X, -a1.Z))
end

local function directionFromYaw(a1) -- Line: 101 -- types: a1: number
    return (Vector3.new(-math.sin(a1), 0, -(math.cos(a1))))
end

local function lerpAngle(a1, a2, a3) -- Line: 105 -- types: a1: number, a2: number, a3: number
    return a1 + ((a2 - a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * a3
end

local function tuningWith(a1) -- Line: 110 -- upvalues: u5 (val) -- types: a1: table?
    local DefaultTuning = u5.DefaultTuning
    local v1 = a1 or {}
    local v2 = {}
    local BounceHeightStuds = v1.BounceHeightStuds or DefaultTuning.BounceHeightStuds
    v2.BounceHeightStuds = BounceHeightStuds
    local BounceHz = v1.BounceHz or DefaultTuning.BounceHz
    v2.BounceHz = BounceHz
    local SwayStuds = v1.SwayStuds or DefaultTuning.SwayStuds
    v2.SwayStuds = SwayStuds
    local SwayHz = v1.SwayHz or DefaultTuning.SwayHz
    v2.SwayHz = SwayHz
    local LeanDegrees = v1.LeanDegrees or DefaultTuning.LeanDegrees
    v2.LeanDegrees = LeanDegrees
    local BankDegrees = v1.BankDegrees or DefaultTuning.BankDegrees
    v2.BankDegrees = BankDegrees
    local IdleBobStuds = v1.IdleBobStuds or DefaultTuning.IdleBobStuds
    v2.IdleBobStuds = IdleBobStuds
    local IdleBobHz = v1.IdleBobHz or DefaultTuning.IdleBobHz
    v2.IdleBobHz = IdleBobHz
    return v2
end

local function flattenDirection(a1, a2) -- Line: 125 -- types: a1: vector, a2: vector?
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    if 0.001 < v1.Magnitude then
        return v1.Unit
    end
    if a2 then
        local v2 = Vector3.new(a2.X, 0, a2.Z)
        if 0.001 < v2.Magnitude then
            return v2.Unit
        end
    end
    return (Vector3.new(0, 0, -1))
end

local function movementMultipliers(a1) -- Line: 139 -- types: a1: string
    if a1 == "hover" then
        return 0.45, 1.2, 1.45, 0.45
    end
    if a1 == "fast" then
        return 0.75, 1.45, 1.35, 1.35
    end
    if a1 == "scuttle" then
        return 0.28, 2, 1.35, 0.85
    end
    if a1 == "heavy" then
        return 1.15, 0.85, 0.75, 0.8
    end
    return 1, 1, 1, 1
end

local function canContinue(a1, a2) -- Line: 152 -- types: a1: userdata, a2: function?
    if not a1.Parent then
        return false
    end
    local v1 = true
    if a2 ~= nil then
        v1 = a2()
    end
    return v1
end

local function facingYaw(a1, a2) -- Line: 159 -- types: a1: userdata, a2: table?
    if a2 and a2.FacingYawDegrees ~= nil then
        return a2.FacingYawDegrees
    end
    return tonumber((a1:GetAttribute("PetFacingYawDegrees"))) or 0
end

local function visualCFrame(a1, a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 166
    -- upvalues: 
    local v1, v2, v3, v4
    if a5 == "hover" then
        v4 = 0.45
        v1 = 1.2
        v2 = 1.45
        v3 = 0.45
    elseif a5 == "fast" then
        v4 = 0.75
        v1 = 1.45
        v2 = 1.35
        v3 = 1.35
    elseif a5 == "scuttle" then
        v4 = 0.28
        v1 = 2
        v2 = 1.35
        v3 = 0.85
    elseif a5 ~= "heavy" then
        v4 = 1
        v1 = 1
        v2 = 1
        v3 = 1
    else
        v4 = 1.15
        v1 = 0.85
        v2 = 0.75
        v3 = 0.8
    end
    local v5 = Vector3.new(-a2.Z, 0, a2.X)
    local v6 = a1
    local v7 = 0
    local v8 = 0
    if not a6 then
        v6 = v6 + Vector3.new(0, (math.sin(a4)) * a7.IdleBobStuds * (a9 or 1), 0)
    else
        local v9 = a9 or 1
        local v10 = math.sin(a4 * v1) ^ 2 * a7.BounceHeightStuds * v4 * v9
        local v11 = (math.sin(a4 * 0.5 * a7.SwayHz + 1.0471975511965976)) * a7.SwayStuds * v2 * v9
        local v12 = math.clamp(a3 / 10, 0.25, 1.25)
        v7 = -math.rad(a7.LeanDegrees) * v12 * v3 * v9
        v8 = (math.sin(a4 * 0.5 + 1.5707963267948966)) * math.rad(a7.BankDegrees) * v2 * v9
        if a5 == "hover" then
            v10 = ((math.sin(a4 * 0.45)) * a7.BounceHeightStuds * v4 + 0.25) * v9
            v7 = v7 * 0.45
        end
        v6 = v6 + ((Vector3.new(0, v10, 0)) + v5 * v11)
    end
    return (CFrame.lookAt(v6, v6 + a2)) * CFrame.Angles(v7, math.rad(a8), v8)
end

local function pathLength(a1) -- Line: 214 -- types: a1: function
    local v1
    local v2 = 0
    local v3 = a1(0)
    for i = 1, 10 do
        v1 = a1(i / 10)
        v2 = v2 + (v1 - v3).Magnitude
    end
    return v2
end

local function moveAlong(a1, a2, a3, a4) -- Line: 225
    -- upvalues: tuningWith (val), u5 (val), pathLength (val), visualCFrame (val), RunService (val)
    local Angles, ShouldContinue, Unit_2, Unit_3, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    if not a1.Parent then
        return false
    end
    local v13 = a4 or {}
    local v14 = tuningWith(v13.Tuning)
    local Personality = v13.Personality or u5.ResolvePersonality(a1)
    local v15 = math.max(0.5, v13.Speed or 7)
    local LookVector = a1:GetPivot().LookVector
    local v16 = Vector3.new(LookVector.X, 0, LookVector.Z)
    local Unit = if not (0.001 < v16.Magnitude) then Vector3.new(0, 0, -1) else v16.Unit
    local v17 = pathLength(a2)
    v16 = math.max(0.18, v13.Duration or v17 / v15)
    local v18 = os.clock()
    local v19 = math.max(1, (math.floor(v16 * v14.BounceHz + 0.5)))
    local v20 = if Personality ~= "hover" then if Personality ~= "fast" then if Personality ~= "scuttle" then if Personality ~= "heavy" then 1 else 0.85 else 2 else 1.45 else 1.2
    local v21 = 0
    local v22 = v18
    local FacingYawDegrees = if not v13 then tonumber((a1:GetAttribute("PetFacingYawDegrees"))) or 0 else if v13.FacingYawDegrees == nil then tonumber((a1:GetAttribute("PetFacingYawDegrees"))) or 0 else v13.FacingYawDegrees
    local v23 = a1
    while true do
        ShouldContinue = v13.ShouldContinue
        if v23.Parent then
            v2 = true
            if ShouldContinue ~= nil then
                v2 = ShouldContinue()
            end
        else
            v2 = false
        end
        if not v2 then
            return false
        end
        v2 = math.clamp((os.clock() - v18) / v16, 0, 1)
        v4 = math.clamp(v2, 0, 1)
        v3 = v4 * v4 * v4 * (v4 * (v4 * 6 - 15) + 10)
        v5 = v24(v3)
        v6 = Vector3.new(v5.X, 0, v5.Z)
        if 0.001 < v6.Magnitude then
            Unit_2 = v6.Unit
        elseif not Unit then
            Unit_2 = Vector3.new(0, 0, -1)
        else
            v7 = Vector3.new(Unit.X, 0, Unit.Z)
            Unit_2 = if not (0.001 < v7.Magnitude) then Vector3.new(0, 0, -1) else v7.Unit
        end
        v7 = math.clamp(math.clamp(v2 / 0.22, 0, 1), 0, 1)
        v5 = v7 * v7 * v7 * (v7 * (v7 * 6 - 15) + 10)
        v8 = math.atan2(-Unit.X, -Unit.Z)
        v7 = v8 + ((math.atan2(-Unit_2.X, -Unit_2.Z) - v8 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v5
        v6 = Vector3.new(-math.sin(v7), 0, -(math.cos(v7)))
        v9 = math.clamp(math.min(v2 / 0.11, (1 - v2) / 0.11, 1), 0, 1)
        v7 = v9 * v9 * (3 - v9 * 2)
        v8 = v2 * 3.141592653589793 * v19
        v9 = v1(v3)
        if v13.JumpHeightStuds and 0 < v13.JumpHeightStuds then
            v9 = v9 + Vector3.new(0, (math.sin(v2 * 3.141592653589793)) * v13.JumpHeightStuds, 0)
        end
        v10 = visualCFrame(v9, v6, v15, v8, Personality, true, v14, FacingYawDegrees, v7)
        if v13.FlipTurns and v13.FlipTurns ~= 0 then
            Angles = CFrame.Angles
            v12 = math.clamp(v2, 0, 1)
            v10 = v10 * Angles(v12 * v12 * v12 * (v12 * (v12 * 6 - 15) + 10) * 3.141592653589793 * 2 * v13.FlipTurns, 0, 0)
        end
        v23:PivotTo(v10)
        v11 = math.floor(v8 * v20 / 3.141592653589793)
        if v21 < v11 then
            v22 = os.clock()
            if v13.OnGroundContact then
                v13.OnGroundContact()
            end
        end
        if v2 >= 1 then
            break
        end
        RunService.RenderStepped:Wait()
    end
    if v13.OnGroundContact and 0.14 < os.clock() - v22 then
        v13.OnGroundContact()
    end
    v2 = v1(1)
    v4 = v24(1)
    v5 = Vector3.new(v4.X, 0, v4.Z)
    if 0.001 < v5.Magnitude then
        Unit_3 = v5.Unit
    elseif not Unit then
        Unit_3 = Vector3.new(0, 0, -1)
    else
        v6 = Vector3.new(Unit.X, 0, Unit.Z)
        Unit_3 = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, -1) else v6.Unit
    end
    v23:PivotTo((CFrame.lookAt(v2, v2 + Unit_3)) * (CFrame.Angles(0, math.rad(FacingYawDegrees), 0)))
    return true
end

function u5.ResolvePersonality(a1) -- Line: 319 -- upvalues: u9 (val) -- types: a1: userdata
    local v1
    local Attribute = a1:GetAttribute("PetMotionStyle")
    if typeof(Attribute) == "string" then
        v1 = string.lower(Attribute)
        if u9[v1] then
            return v1
        end
    end
    v1 = string.lower(a1.Name)
    if not string.find(v1, "bat")
        and not string.find(v1, "moth")
        and not string.find(v1, "dragon")
        and not string.find(v1, "bird") then
        if not string.find(v1, "mouse") and not string.find(v1, "fox") and not string.find(v1, "wolf") then
            if not string.find(v1, "spider") and not string.find(v1, "crawler") then
                if not string.find(v1, "panda") and not string.find(v1, "bear") and not string.find(v1, "pig") then
                    return "hop"
                end
                return "heavy"
            end
            return "scuttle"
        end
        return "fast"
    end
    return "hover"
end

function u5.PrepareModel(a1) -- Line: 353 -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    if not PrimaryPart then
        local Root = a1:FindFirstChild("Root", true)
        if Root and Root:IsA("BasePart") then
            PrimaryPart = Root
        end
    end
    if not PrimaryPart then
        PrimaryPart = a1:FindFirstChildWhichIsA("BasePart", true)
    end
    if PrimaryPart and not a1.PrimaryPart then
        a1.PrimaryPart = PrimaryPart
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanTouch = false
            j.CanQuery = false
            j.Massless = true
        end
    end
    return PrimaryPart
end

function u5.MoveTo(a1, a2, a3) -- Line: 382 -- upvalues: moveAlong (val) -- types: a1: userdata, a2: vector, a3: table?
    local Position = a1:GetPivot().Position
    local u7 = a2 - Position
    return (moveAlong(a1, function(a1) -- Line: 387 -- upvalues: Position (val), a2 (val) -- types: a1: number
        return Position:Lerp(a2, a1)
    end, function(a1) -- Line: 390 -- upvalues: u7 (val) -- types: a1: number
        return u7
    end, a3))
end

function u5.MoveCurve(a1, a2, a3, a4) -- Line: 399
    -- upvalues: moveAlong (val)
    local Position = a1:GetPivot().Position
    return (moveAlong(a1, function(a1) -- Line: 403 -- upvalues: Position (val), a2 (val), a3 (val) -- types: a1: number
        local v1 = 1 - a1
        return v1 * v1 * Position + v1 * 2 * a1 * a2 + a1 * a1 * a3
    end, function(a1) -- Line: 409 -- upvalues: a2 (val), Position (val), a3 (val) -- types: a1: number
        return (1 - a1) * 2 * (a2 - Position) + a1 * 2 * (a3 - a2)
    end, a4))
end

function u5.Idle(a1, a2, a3) -- Line: 418
    -- upvalues: tuningWith (val), u5 (val), RunService (val)
    local ShouldContinue, v1, v2, v3, v4, v5
    if not a1.Parent then
        return false
    end
    local v6 = a3 or {}
    local v7 = tuningWith(v6.Tuning)
    local Personality = v6.Personality or u5.ResolvePersonality(a1)
    local Pivot = a1:GetPivot()
    local Position = Pivot.Position
    local LookVector = Pivot.LookVector
    local v8 = Vector3.new(LookVector.X, 0, LookVector.Z)
    local Unit = if not (0.001 < v8.Magnitude) then Vector3.new(0, 0, -1) else v8.Unit
    local v9 = os.clock()
    v8 = v6.Phase or 0
    local FacingYawDegrees = if not v6 or v6.FacingYawDegrees == nil then tonumber((a1:GetAttribute("PetFacingYawDegrees"))) or 0 else v6.FacingYawDegrees
    local v10 = math.max(0, a2)
    local v11 = a1
    while os.clock() - v9 < v10 do
        ShouldContinue = v6.ShouldContinue
        if v11.Parent then
            v1 = true
            if ShouldContinue ~= nil then
                v1 = ShouldContinue()
            end
        else
            v1 = false
        end
        if not v1 then
            return false
        end
        v1 = os.clock() - v9
        v2 = v1 * 3.141592653589793 * 2 * v7.IdleBobHz + v8
        v4 = math.clamp(math.min(v1 / 0.12, (v10 - v1) / 0.12, 1), 0, 1)
        v3 = v4 * v4 * (3 - v4 * 2)
        if Personality ~= "hover"
            and Personality ~= "fast"
            and Personality ~= "scuttle"
            and Personality ~= "heavy" then end
        Vector3.new(-Unit.Z, 0, Unit.X)
        v5 = Position + Vector3.new(0, (math.sin(v2)) * v7.IdleBobStuds * (v3 or 1), 0)
        v11:PivotTo((CFrame.lookAt(v5, v5 + Unit)) * (CFrame.Angles(0, math.rad(FacingYawDegrees), 0)))
        RunService.RenderStepped:Wait()
    end
    v11:PivotTo((CFrame.lookAt(Position, Position + Unit)) * (CFrame.Angles(0, math.rad(FacingYawDegrees), 0)))
    return true
end

function u5.FollowTarget(a1, a2, a3) -- Line: 453
    -- upvalues: tuningWith (val), u5 (val), RunService (val)
    local Angles_2, Magnitude, ShouldContinue, Unit_2, Unit_3, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22
    if not a1.Parent then
        return false
    end
    local v23 = a3 or {}
    local v24 = tuningWith(v23.Tuning)
    if not v23.Personality then
        u5.ResolvePersonality(a1)
    end
    local v25 = math.max(1, v23.BaseSpeed or v23.Speed or 18)
    local v26 = math.max(0, v23.CatchUpSpeedPerStud or 1.15)
    local v27 = math.max(v25, v23.MaxSpeed or 42)
    local v28 = math.max(1, v23.Responsiveness or 11)
    local v29 = math.max(0.1, v23.StopDistance or 0.85)
    local v30 = math.max(v29, v23.StartDistance or v29)
    local v31 = math.max(v30 + 1, v23.TeleportDistance or 55)
    local v32 = math.max(0, v23.IdleTurnDelay or 0.16)
    local v33 = math.max(1, v23.FlipIntervalMin or 7)
    local v34 = math.max(v33, v23.FlipIntervalMax or 14)
    local v35 = math.max(0.25, v23.FlipDuration or 0.62)
    local v36 = math.clamp(v23.FlipChance or 0.65, 0, 1)
    local v37 = math.max(0, v23.JumpHeightStuds or 5.2)
    local FacingYawDegrees = if not v23 or v23.FacingYawDegrees == nil then tonumber((a1:GetAttribute("PetFacingYawDegrees"))) or 0 else v23.FacingYawDegrees
    local v38 = Random.new()
    local Pivot = a1:GetPivot()
    local Position = Pivot.Position
    local LookVector = Pivot.LookVector
    local v39 = Vector3.new(LookVector.X, 0, LookVector.Z)
    local Unit = if not (0.001 < v39.Magnitude) then Vector3.new(0, 0, -1) else v39.Unit
    local v40 = 0
    v39 = 0
    local v41 = 0
    local v42 = os.clock() + v38:NextNumber(v33, v34)
    local v43 = nil
    local v44 = os.clock()
    local v45 = false
    local v46 = v44
    local v47 = a1
    while true do
        ShouldContinue = v23.ShouldContinue
        if v47.Parent then
            v2 = true
            if ShouldContinue ~= nil then
                v2 = ShouldContinue()
            end
        else
            v2 = false
        end
        if not v2 then
            break
        end
        RunService.RenderStepped:Wait()
        v2 = os.clock()
        v3 = math.clamp(v2 - v44, 0.004166666666666667, 0.05)
        v4, v5 = v1()
        v6 = Vector3.new(0, 0, 0)
        v7 = false
        if v4 then
            v8 = Vector3.new(v4.X - Position.X, 0, v4.Z - Position.Z)
            Magnitude = v8.Magnitude
            if v31 < Magnitude then
                Position = v4
                v41 = 0
                v45 = false
                v46 = v2
            elseif not v45 then
                if v30 < Magnitude then
                    v45 = true
                end
            elseif Magnitude <= v29 then
                v45 = false
                v46 = v2
            end
            if v45 then
                v11 = v8 * (1 - math.exp(-v28 * v3))
                v13 = math.min(v27, v25 + Magnitude * v26) * v3
                if v13 < v11.Magnitude then
                    v11 = v11.Unit * v13
                end
                v6 = v11
                Position = Position + v11
                v7 = 0.0001 < v11.Magnitude
            end
            v10 = 1 - (math.exp(v3 * -14))
            Position = Vector3.new(Position.X, Position.Y + (v4.Y - Position.Y) * v10, Position.Z)
        end
        v41 = v41 + ((if not v7 then 0 else 1) - v41) * (1 - math.exp(v3 * -10))
        v9 = v6.Magnitude / v3
        if v7 then
            v10 = math.clamp(0.8 + v9 / 22, 0.85, 2.1)
            v40 = v40 + 3.141592653589793 * v24.BounceHz * v10 * v3
            v14 = Vector3.new(v6.X, 0, v6.Z)
            if 0.001 < v14.Magnitude then
                Unit_2 = v14.Unit
            elseif not Unit then
                Unit_2 = Vector3.new(0, 0, -1)
            else
                v15 = Vector3.new(Unit.X, 0, Unit.Z)
                Unit_2 = if not (0.001 < v15.Magnitude) then Vector3.new(0, 0, -1) else v15.Unit
            end
            v12 = 1 - (math.exp(v3 * -12))
            v14 = math.atan2(-Unit.X, -Unit.Z)
            v13 = v14 + ((math.atan2(-Unit_2.X, -Unit_2.Z) - v14 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v12
            Unit = Vector3.new(-math.sin(v13), 0, -(math.cos(v13)))
        elseif v5 and v32 <= v2 - v46 then
            v11 = v5 - Position
            v13 = Vector3.new(v11.X, 0, v11.Z)
            if 0.001 < v13.Magnitude then
                Unit_3 = v13.Unit
            elseif not Unit then
                Unit_3 = Vector3.new(0, 0, -1)
            else
                v14 = Vector3.new(Unit.X, 0, Unit.Z)
                Unit_3 = if not (0.001 < v14.Magnitude) then Vector3.new(0, 0, -1) else v14.Unit
            end
            v11 = 1 - (math.exp(v3 * -5))
            v13 = math.atan2(-Unit.X, -Unit.Z)
            v12 = v13 + ((math.atan2(-Unit_3.X, -Unit_3.Z) - v13 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v11
            Unit = Vector3.new(-math.sin(v12), 0, -(math.cos(v12)))
        end
        v10 = math.floor(v40 / 3.141592653589793)
        if v7 and v39 < v10 then
            if v23.OnGroundContact then
                v23.OnGroundContact()
            end
        end
        if v7 and not v43 and v42 <= v2 then
            if v38:NextNumber() <= v36 then
                v43 = v2
            end
            v42 = v2 + v38:NextNumber(v33, v34)
        end
        v11 = nil
        if v43 and 1 <= (math.clamp((v2 - v43) / v35, 0, 1)) then end
        v12 = Vector3.new(-Unit.Z, 0, Unit.X)
        v13 = math.sin(v40) ^ 2 * v24.BounceHeightStuds * v41
        v14 = (math.sin(v40 * 0.5 + 1.0471975511965976)) * v24.SwayStuds * v41
        v15 = (math.sin(v2 * 3.141592653589793 * 2 * v24.IdleBobHz)) * v24.IdleBobStuds * (1 - v41)
        v16 = if not v11 then 0 else math.sin(v11 * 3.141592653589793) * v37
        v17 = math.clamp(v9 / 18, 0, 1)
        v18 = -math.rad(v24.LeanDegrees) * v17 * v41
        v19 = (math.sin(v40 * 0.5 + 1.5707963267948966)) * math.rad(v24.BankDegrees) * v41
        v20 = Position + Vector3.new(0, v13 + v15 + v16, 0) + v12 * v14
        v21 = (CFrame.lookAt(v20, v20 + Unit)) * CFrame.Angles(v18, math.rad(FacingYawDegrees), v19)
        if v11 then
            Angles_2 = CFrame.Angles
            v22 = math.clamp(v11, 0, 1)
            v21 = v21 * Angles_2(v22 * v22 * v22 * (v22 * (v22 * 6 - 15) + 10) * 3.141592653589793 * 2, 0, 0)
        end
        v47:PivotTo(v21)
    end
    return false
end

function u5.FollowPath(a1, a2, a3) -- Line: 601 -- upvalues: u5 (val) -- types: a1: userdata, a2: table
    local v1 = a3 or {}
    for i, j in a2 do
        if not u5.MoveTo(a1, j, v1) then
            return false
        end
        if 0 < (v1.PauseSeconds or 0) and not u5.Idle(a1, v1.PauseSeconds, v1) then
            return false
        end
    end
    return true
end

function u5.QuadraticBezier(a1, a2, a3, a4) -- Line: 615 -- types: a1: vector, a2: vector, a3: vector, a4: number?
    local v1, v2
    local v3 = {}
    local v4 = math.max(2, (math.floor(a4 or 6)))
    for i = 1, v4 do
        v2 = i / v4
        v1 = 1 - v2
        table.insert(v3, v1 * v1 * a1 + v1 * 2 * v2 * a2 + v2 * v2 * a3)
    end
    return v3
end

return u5
-- Script Path: game:GetService("StarterPlayer").StarterCharacterScripts.DisableSwimming
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterCharacterScripts.DisableSwimming
-- Decompile time: 0.65 ms

local Humanoid = script.Parent:WaitForChild("Humanoid")
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
if (Humanoid:GetState()) == Enum.HumanoidStateType.Swimming then
    Humanoid:ChangeState(Enum.HumanoidStateType.Running)
end
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.AmbientTruckClient
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.AmbientTruckClient
-- Decompile time: 8.91 ms

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local u10 = {}

local function createLoopingSound(a1, a2, a3, a4, a5) -- Line: 16
    -- upvalues: 
    local Sound = Instance.new("Sound")
    Sound.Name = a2
    Sound.SoundId = a3
    Sound.Volume = a4
    Sound.Looped = true
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.RollOffMinDistance = 18
    Sound.RollOffMaxDistance = a5
    Sound.Parent = a1
    Sound:Play()
    return Sound
end

local function cframeAtDistance(a1, a2) -- Line: 30 -- types: a1: table, a2: number
    local v1
    for i, v in ipairs(a1) do
        if a2 <= v.StartsAt + v.Length then
            v1 = if not (0 < v.Length) then 1 else math.clamp((a2 - v.StartsAt) / v.Length, 0, 1)
            return v.From:Lerp(v.To, v1)
        end
    end
    return a1[#a1].To
end

local function controlTruck(a1) -- Line: 40
    -- upvalues: u10 (val), Workspace (val), RunService (val), cframeAtDistance (val)
    if not u10[a1] and a1:GetAttribute("AmbientTruckPass") == true then
        u10[a1] = true
        local BasePart = a1:FindFirstChildWhichIsA("BasePart", true)
        local v1 = tonumber((a1:GetAttribute("TravelSpeed")))
        local v2 = tonumber((a1:GetAttribute("PassStartedAt")))
        if BasePart and v1 and not (v1 <= 0) and v2 then
            local Attribute_3, Magnitude, v3, v4, v5
            local v6 = {}
            for i = 1, 4 do
                Attribute_3 = a1:GetAttribute("PathCFrame" .. (tostring(i)))
                if typeof(Attribute_3) ~= "CFrame" then
                    u10[a1] = nil
                    return
                end
                table.insert(v6, Attribute_3)
            end
            local v7 = {}
            local v8 = 0
            local v9 = #v6 - 1
            for j = 1, v9 do
                v3 = v6[j]
                v4 = v6[j + 1]
                Magnitude = (v4.Position - v3.Position).Magnitude
                table.insert(v7, {From = v3, To = v4, StartsAt = v8, Length = Magnitude})
                v8 = v8 + Magnitude
            end
            local Sound_2 = Instance.new("Sound")
            Sound_2.Name = "AmbientTruckEngine"
            Sound_2.SoundId = "rbxassetid://532147820"
            Sound_2.Volume = 0.55
            Sound_2.Looped = true
            Sound_2.RollOffMode = Enum.RollOffMode.InverseTapered
            Sound_2.RollOffMinDistance = 18
            Sound_2.RollOffMaxDistance = 190
            Sound_2.Parent = BasePart
            Sound_2:Play()
            local v10 = tostring((a1:GetAttribute("MusicSoundId")) or "")
            local Sound_3 = nil
            if v10 ~= "" then
                Sound_3 = Instance.new("Sound")
                Sound_3.Name = "AmbientTruckMusic"
                Sound_3.SoundId = v10
                Sound_3.Volume = 0.5
                Sound_3.Looped = true
                Sound_3.RollOffMode = Enum.RollOffMode.InverseTapered
                Sound_3.RollOffMinDistance = 18
                Sound_3.RollOffMaxDistance = 145
                Sound_3.Parent = BasePart
                Sound_3:Play()
            end
            v3 = tostring((a1:GetAttribute("HornSoundId")) or "")
            v4 = tonumber((a1:GetAttribute("HornAtDistance"))) or -1
            local v11 = math.max(0, ((Workspace:GetServerTimeNow()) - v2) * v1)
            local v12 = true
            if v3 ~= "" then
                v12 = v4 <= v11
            end
            while a1.Parent do
                if not (v11 < v8) then
                    break
                end
                RunService.RenderStepped:Wait()
                v5 = math.clamp((Workspace:GetServerTimeNow() - v2) * v1, 0, v8)
                a1:PivotTo((cframeAtDistance(v7, v5)))
                if not v12 and v11 < v4 and v4 <= v5 then
                    local Sound = Instance.new("Sound")
                    Sound.Name = "AmbientTruckHorn"
                    Sound.SoundId = v3
                    Sound.Volume = 0.9
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
                    Sound.RollOffMinDistance = 25
                    Sound.RollOffMaxDistance = 240
                    Sound.Parent = BasePart
                    Sound.Ended:Once(function() -- Line: 99 -- upvalues: Sound (val)
                        Sound:Destroy()
                    end)
                    Sound:Play()
                end
            end
            if a1.Parent then
                a1:PivotTo((cframeAtDistance(v7, v8)))
            end
            Sound_2:Stop()
            if Sound_3 then
                Sound_3:Stop()
            end
            u10[a1] = nil
            return
        end
        u10[a1] = nil
        return
    end
end

Workspace.ChildAdded:Connect(function(a1) -- Line: 111 -- upvalues: controlTruck (val) -- types: a1: userdata
    if a1:IsA("Model") and a1.Name == "AmbientFishTruck" then
        task.spawn(controlTruck, a1)
    end
end)
for i, v in ipairs(Workspace:GetChildren()) do
    if v:IsA("Model") and v.Name == "AmbientFishTruck" then
        task.spawn(controlTruck, v)
    end
end
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.BalloonPilotClient
-- Took 0.03s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.BalloonPilotClient
-- Decompile time: 34.10 ms

local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FishGame = ReplicatedStorage:WaitForChild("FishGame")
local Config = require(FishGame:WaitForChild("Config"))
local Remotes = FishGame:WaitForChild("Remotes")
local BalloonPilotAction = Remotes:WaitForChild("BalloonPilotAction")
local StateUpdate = Remotes:WaitForChild("StateUpdate")
local PilotShop = PlayerGui:WaitForChild("PilotShop")
local Frame = PilotShop:WaitForChild("Frame")
local CloseButton = Frame:WaitForChild("A_Header"):WaitForChild("CloseButton")
local Frame_2 = Frame:WaitForChild("Body"):WaitForChild("Frame")
local u99 = Frame_2:WaitForChild("1DayButton")
local u103 = Frame_2:WaitForChild("3DayButton")
local ForeverButton = Frame_2:WaitForChild("ForeverButton")
local Amount = ((Frame:WaitForChild("SellAndMoney")):WaitForChild("Cash")):WaitForChild("Amount")
local v1 = {u99.Position, u103.Position, ForeverButton.Position}
table.sort(v1, function(a1, a2) -- Line: 35 -- types: a1: CFrame, a2: CFrame
    if a1.X.Scale ~= a2.X.Scale then
        return a1.X.Scale < a2.X.Scale
    end
    return a1.X.Offset < a2.X.Offset
end)
u99.LayoutOrder = 1
u103.LayoutOrder = 2
ForeverButton.LayoutOrder = 3
u99.Position = v1[1]
u103.Position = v1[2]
ForeverButton.Position = v1[3]
PilotShop.Enabled = false
local BalloonPilotBlur = Lighting:FindFirstChild("BalloonPilotBlur")
if not BalloonPilotBlur or not BalloonPilotBlur:IsA("BlurEffect") then
    if BalloonPilotBlur then
        BalloonPilotBlur:Destroy()
    end
    BalloonPilotBlur = Instance.new("BlurEffect")
    BalloonPilotBlur.Name = "BalloonPilotBlur"
    BalloonPilotBlur.Size = 0
    BalloonPilotBlur.Enabled = false
    BalloonPilotBlur.Parent = Lighting
end
local OpenScale = Frame:FindFirstChild("OpenScale")
if not OpenScale or not OpenScale:IsA("UIScale") then
    if OpenScale then
        OpenScale:Destroy()
    end
    OpenScale = Instance.new("UIScale")
    OpenScale.Name = "OpenScale"
    OpenScale.Parent = Frame
end

local function makeSound(a1, a2, a3) -- Line: 65
    -- upvalues: SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = a1
    Sound.SoundId = a2
    Sound.Volume = a3
    Sound.Parent = SoundService
    return Sound
end

local TalkSoundId = Config.BalloonPilot.TalkSoundId
local u196 = Instance.new("Sound")
u196.Name = "BalloonPilotTalk"
u196.SoundId = TalkSoundId
u196.Volume = 0.7
u196.Parent = SoundService
local OpenCloseSoundId = Config.InterfaceSounds.OpenCloseSoundId
local u204 = Instance.new("Sound")
u204.Name = "BalloonPilotClose"
u204.SoundId = OpenCloseSoundId
u204.Volume = 0.55
u204.Parent = SoundService
local BuySoundId = Config.InterfaceSounds.BuySoundId
local u212 = Instance.new("Sound")
u212.Name = "BalloonPilotHire"
u212.SoundId = BuySoundId
u212.Volume = 0.72
u212.Parent = SoundService
local Position = Frame.Position
local u217 = 70
local u218 = false
local u219 = false
local u220 = false
local u221 = false
local CameraMode = LocalPlayer.CameraMode
local Custom = Enum.CameraType.Custom
local MouseBehavior = UserInputService.MouseBehavior
local MouseIconEnabled = UserInputService.MouseIconEnabled
local u238 = nil
local u239 = nil
local u244 = "BalloonPilotCamera_" .. tostring(LocalPlayer.UserId)
local v2 = "BalloonWorldMotion_" .. tostring(LocalPlayer.UserId)

local function balloonFacing(a1, a2) -- Line: 92 -- types: a1: vector, a2: vector
    local v1 = Vector3.new(a2.X - a1.X, 0, a2.Z - a1.Z)
    if v1.Magnitude < 0.1 then
        v1 = Vector3.new(0, 0, -1)
    end
    return CFrame.lookAt(a1, a1 + v1.Unit, (Vector3.new(0, 1, 0)))
end

RunService:BindToRenderStep(v2, Enum.RenderPriority.Camera.Value + 20, function() -- Line: 98 -- upvalues: Workspace (val), balloonFacing (val)
    local Attribute, Attribute_2, v1, v2, v3, v4, v5, v6
    local FishWorldEvents = Workspace:FindFirstChild("FishWorldEvents")
    if not FishWorldEvents then
        return
    end
    local ServerTimeNow = Workspace:GetServerTimeNow()
    for i, v in ipairs(FishWorldEvents:GetChildren()) do
        if v:IsA("Model") then
            if v.Name == "BalloonPilotBomber" or v.Name == "BalloonPilotArrival" then
                Attribute = v:GetAttribute("FlightStart")
                Attribute_2 = v:GetAttribute("FlightFinish")
                v6 = tonumber((v:GetAttribute("FlightStartedAt")))
                v1 = tonumber((v:GetAttribute("FlightDuration")))
                if typeof(Attribute) == "Vector3" and typeof(Attribute_2) == "Vector3" and v6 and v1 then
                    v2 = math.clamp((ServerTimeNow - v6) / math.max(0.1, v1), 0, 1)
                    v3 = tonumber((v:GetAttribute("FlightArcHeight"))) or 0
                    v4 = if v.Name ~= "BalloonPilotArrival" then math.sin(v2 * 3.141592653589793 * 2) * v3 else math.sin(v2 * 3.141592653589793) * v3
                    v5 = balloonFacing((Attribute:Lerp(Attribute_2, v2 * v2 * (3 - v2 * 2))) + Vector3.new(0, 1, 0) * v4, Attribute_2)
                    v:PivotTo(v5)
                end
            end
        end
    end
end)

local function beginModalInput(a1) -- Line: 122
    -- upvalues: PlayerGui (val), CameraMode (ref), LocalPlayer (val), MouseBehavior (ref), UserInputService (val)
    -- upvalues: MouseIconEnabled (ref), Custom (ref), u238 (ref), u239 (ref), RunService (val), u244 (val), u218 (ref)
    -- upvalues: Workspace (val)
    local MedalTVUI = PlayerGui:FindFirstChild("MedalTVUI")
    if MedalTVUI and MedalTVUI:IsA("ScreenGui") then
        MedalTVUI.Enabled = false
    end
    CameraMode = LocalPlayer.CameraMode
    MouseBehavior = UserInputService.MouseBehavior
    MouseIconEnabled = UserInputService.MouseIconEnabled
    if a1 then
        Custom = a1.CameraType
        u238 = a1.CFrame
        u239 = a1.Focus
        a1.CameraType = Enum.CameraType.Scriptable
    end
    LocalPlayer:SetAttribute("FishResearchOpen", true)
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseIconEnabled = true
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    RunService:UnbindFromRenderStep(u244)
    RunService:BindToRenderStep(u244, Enum.RenderPriority.Camera.Value + 10, function() -- Line: 139
        -- upvalues: u218 (upval), Workspace (upval), u238 (upval), u239 (upval), UserInputService (upval)
        if not u218 then
            return
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera and u238 then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.CFrame = u238
            if u239 then
                CurrentCamera.Focus = u239
            end
        end
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end)
end

local function endModalInput() -- Line: 152
    -- upvalues: RunService (val), u244 (val), Workspace (val), Custom (ref), LocalPlayer (val), CameraMode (ref)
    -- upvalues: UserInputService (val), MouseIconEnabled (ref), MouseBehavior (ref), u238 (ref), u239 (ref)
    RunService:UnbindFromRenderStep(u244)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CameraType = Custom
    end
    LocalPlayer.CameraMode = CameraMode
    UserInputService.MouseIconEnabled = MouseIconEnabled
    UserInputService.MouseBehavior = MouseBehavior
    LocalPlayer:SetAttribute("FishResearchOpen", false)
    u238 = nil
    u239 = nil
end

local function commas(a1) -- Line: 164 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.max(0, (math.floor(a1)))))
    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function buttonLabel(a1) -- Line: 173 -- types: a1: userdata
    local TextLabel = a1:FindFirstChild("TextLabel")
    if TextLabel and TextLabel:IsA("TextLabel") then
        return TextLabel
    end
    return nil
end

local function applyState(a1) -- Line: 178 -- upvalues: Amount (val), commas (val), u99 (val), u103 (val)
    if type(a1) ~= "table" then
        return
    end
    Amount.Text = "$" .. commas(tonumber(a1.Cash) or 0)
    local Costs = a1.Costs
    if type(Costs) == "table" then
        local TextLabel = u99:FindFirstChild("TextLabel")
        local v1 = if not TextLabel then nil else if not TextLabel:IsA("TextLabel") then nil else TextLabel
        local TextLabel_2 = u103:FindFirstChild("TextLabel")
        local v2 = if not TextLabel_2 then nil else if not TextLabel_2:IsA("TextLabel") then nil else TextLabel_2
        if v1 then
            v1.Text = "$" .. commas(tonumber(Costs.OneDay) or 0)
        end
        if v2 then
            v2.Text = "$" .. commas(tonumber(Costs.ThreeDays) or 0)
        end
    end
end

local function invoke(a1, a2) -- Line: 190 -- upvalues: BalloonPilotAction (val) -- types: a1: string, a2: string?
    local success, result = pcall(function() -- Line: 191 -- upvalues: BalloonPilotAction (upval), a1 (val), a2 (val)
        return BalloonPilotAction:InvokeServer(a1, a2)
    end)
    if success then
        return result
    end
    return nil
end

local function closeUI(a1) -- Line: 197
    -- upvalues: u220 (ref), u218 (ref), PilotShop (val), u219 (ref), RunService (val), u244 (val), Workspace (val)
    -- upvalues: Custom (ref), LocalPlayer (val), CameraMode (ref), UserInputService (val), MouseIconEnabled (ref)
    -- upvalues: MouseBehavior (ref), u238 (ref), u239 (ref), u204 (val), TweenService (val), OpenScale (ref)
    -- upvalues: Frame (val), Position (val), BalloonPilotBlur (ref), u217 (ref), GuiService (val)
    if a1 then
        u220 = true
    end
    if not u218 then
        PilotShop.Enabled = false
        return
    end
    u218 = false
    u219 = false
    RunService:UnbindFromRenderStep(u244)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CameraType = Custom
    end
    LocalPlayer.CameraMode = CameraMode
    UserInputService.MouseIconEnabled = MouseIconEnabled
    UserInputService.MouseBehavior = MouseBehavior
    LocalPlayer:SetAttribute("FishResearchOpen", false)
    u238 = nil
    u239 = nil
    u204:Play()
    local CurrentCamera_2 = Workspace.CurrentCamera
    TweenService:Create(OpenScale, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.84}):Play()
    TweenService:Create(
        Frame,
        TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = Position + UDim2.fromOffset(0, 18)}
    ):Play()
    TweenService:Create(BalloonPilotBlur, TweenInfo.new(0.18), {Size = 0}):Play()
    if CurrentCamera_2 then
        TweenService:Create(CurrentCamera_2, TweenInfo.new(0.22), {FieldOfView = u217}):Play()
    end
    task.delay(0.18, function() -- Line: 211
        -- upvalues: u218 (upval), PilotShop (upval), BalloonPilotBlur (upval), Frame (upval), Position (upval)
        -- upvalues: OpenScale (upval), GuiService (upval)
        if u218 then
            return
        end
        PilotShop.Enabled = false
        BalloonPilotBlur.Enabled = false
        Frame.Position = Position
        OpenScale.Scale = 1
        GuiService.SelectedObject = nil
    end)
end

local function openUI() -- Line: 221
    -- upvalues: u218 (ref), Workspace (val), u217 (ref), beginModalInput (val), PilotShop (val), Frame (val)
    -- upvalues: Position (val), OpenScale (ref), BalloonPilotBlur (ref), u196 (val), TweenService (val)
    -- upvalues: GuiService (val), u99 (val), BalloonPilotAction (val), applyState (val)
    if u218 then
        return
    end
    u218 = true
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        u217 = CurrentCamera.FieldOfView
    end
    beginModalInput(CurrentCamera)
    PilotShop.Enabled = true
    Frame.Visible = true
    Frame.Position = Position + UDim2.fromOffset(0, 22)
    OpenScale.Scale = 0.78
    BalloonPilotBlur.Enabled = true
    BalloonPilotBlur.Size = 0
    u196.TimePosition = 0
    u196:Play()
    TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = Position}):Play()
    TweenService:Create(OpenScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    TweenService:Create(BalloonPilotBlur, TweenInfo.new(0.22), {Size = 12}):Play()
    if CurrentCamera then
        TweenService:Create(CurrentCamera, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {FieldOfView = u217 + 6}):Play()
    end
    if GuiService:IsTenFootInterface() then
        GuiService.SelectedObject = u99
    end
    task.spawn(function() -- Line: 240 -- upvalues: BalloonPilotAction (upval), u218 (upval), applyState (upval)
        local u1 = "Open"
        local u2 = nil
        local success, result = pcall(function() -- Line: 191 -- upvalues: BalloonPilotAction (upval), u1 (val), u2 (val)
            return BalloonPilotAction:InvokeServer(u1, u2)
        end)
        local v1 = if not success then nil else result
        if u218 then
            applyState(v1)
        end
    end)
end

local function hire(a1) -- Line: 246
    -- upvalues: u219 (ref), u218 (ref), u99 (val), u103 (val), ForeverButton (val), TweenService (val)
    -- upvalues: BalloonPilotAction (val), applyState (val), u212 (val), closeUI (val)
    if not u219 and u218 then
        local v1
        u219 = true
        local u6 = if a1 ~= "OneDay" then if a1 ~= "ThreeDays" then ForeverButton else u103 else u99
        local Size = u6.Size
        TweenService:Create(u6, TweenInfo.new(0.07, Enum.EasingStyle.Quad), {Size = Size - UDim2.fromOffset(5, 3)}):Play()
        task.delay(0.08, function() -- Line: 252 -- upvalues: u6 (val), TweenService (upval), Size (val)
            if u6.Parent then
                TweenService:Create(u6, TweenInfo.new(0.14, Enum.EasingStyle.Back), {Size = Size}):Play()
            end
        end)
        local u32 = "Hire"
        local success, result = pcall(function() -- Line: 191 -- upvalues: BalloonPilotAction (upval), u32 (val), a1 (val)
            return BalloonPilotAction:InvokeServer(u32, a1)
        end)
        u219 = false
        if type(if not success then nil else result) ~= "table" then
            return
        end
        applyState(v1.State)
        if v1.Success == true then
            u212:Play()
            closeUI(false)
        end
        return
    end
end

u99.Activated:Connect(function() -- Line: 282 -- upvalues: hire (val)
    hire("OneDay")
end)
u103.Activated:Connect(function() -- Line: 283 -- upvalues: hire (val)
    hire("ThreeDays")
end)
ForeverButton.Activated:Connect(function() -- Line: 265
    -- upvalues: u219 (ref), u218 (ref), ForeverButton (val), TweenService (val), BalloonPilotAction (val)
    -- upvalues: applyState (val)
    if not u219 and u218 then
        u219 = true
        local Size = ForeverButton.Size
        TweenService:Create(ForeverButton, TweenInfo.new(0.07, Enum.EasingStyle.Quad), {Size = Size - UDim2.fromOffset(5, 3)}):Play()
        task.delay(0.08, function() -- Line: 272 -- upvalues: ForeverButton (upval), TweenService (upval), Size (val)
            if ForeverButton.Parent then
                TweenService:Create(ForeverButton, TweenInfo.new(0.14, Enum.EasingStyle.Back), {Size = Size}):Play()
            end
        end)
        local u28 = "PromptForever"
        local u29 = nil
        local success, result = pcall(function() -- Line: 191 -- upvalues: BalloonPilotAction (upval), u28 (val), u29 (val)
            return BalloonPilotAction:InvokeServer(u28, u29)
        end)
        local v1 = if not success then nil else result
        u219 = false
        if type(v1) == "table" then
            applyState(v1.State)
        end
        return
    end
end)
CloseButton.Activated:Connect(function() -- Line: 285 -- upvalues: closeUI (val)
    closeUI(true)
end)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 286 -- upvalues: u218 (ref), closeUI (val)
    if not a2 and u218 then
        if a1.KeyCode == Enum.KeyCode.Escape or a1.KeyCode == Enum.KeyCode.E then
            closeUI(true)
        end
    end
end)
StateUpdate.OnClientEvent:Connect(function(a1) -- Line: 292 -- upvalues: u218 (ref), Amount (val), commas (val)
    if u218 and type(a1) == "table" and a1.TeamCash ~= nil then
        Amount.Text = "$" .. commas(tonumber(a1.TeamCash) or 0)
    end
end)

local function rootPart() -- Line: 298 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function zoneTouch() -- Line: 304 -- upvalues: Workspace (val)
    local FishWorldEvents = Workspace:FindFirstChild("FishWorldEvents")
    local BalloonPilotShop = FishWorldEvents and FishWorldEvents:FindFirstChild("BalloonPilotShop")
    local PilotShopOpenArea = BalloonPilotShop and BalloonPilotShop:FindFirstChild("PilotShopOpenArea")
    local Touch = PilotShopOpenArea and PilotShopOpenArea:FindFirstChild("Touch", true)
    if Touch and Touch:IsA("BasePart") then
        return Touch
    end
    return nil
end

local function insideZone() -- Line: 312 -- upvalues: LocalPlayer (val), zoneTouch (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v1 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    local v2 = zoneTouch()
    if v1 and v2 then
        local v3 = v2.CFrame:PointToObjectSpace(v1.Position)
        local v4 = v2.Size * 0.5
        local v5 = false
        if (math.abs(v3.X)) <= v4.X then
            v5 = false
            if (math.abs(v3.Z)) <= v4.Z then
                v5 = (math.abs(v3.Y)) <= math.max(v4.Y + 6, 7)
            end
        end
        return v5
    end
    return false
end

local u385 = 0
RunService.Heartbeat:Connect(function(a1) -- Line: 324
    -- upvalues: u385 (ref), insideZone (val), u221 (ref), u220 (ref), openUI (val), closeUI (val), u218 (ref)
    -- upvalues: zoneTouch (val)
    u385 = u385 + a1
    if u385 < 0.1 then
        return
    end
    u385 = 0
    local v1 = insideZone()
    if v1 and not u221 and not u220 then
        openUI()
    end
    if v1 then
        if u218 and not zoneTouch() then
            closeUI(false)
        end
    elseif u221 then
        u220 = false
        closeUI(false)
    elseif u218 and not zoneTouch() then
        closeUI(false)
    end
    u221 = v1
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.BlurWorldVisibilityClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.BlurWorldVisibilityClient
-- Decompile time: 12.47 ms

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local u128 = {}
local u129 = {}
local u130 = {}
local u23 = false
local u131 = false

local function inWorld(a1) -- Line: 19 -- upvalues: Workspace (val), PlayerGui (val) -- types: a1: userdata
    if a1:FindFirstAncestorWhichIsA("ViewportFrame") then
        return false
    end
    if a1:IsA("BillboardGui") then
        return a1:IsDescendantOf(Workspace) or a1:IsDescendantOf(PlayerGui)
    end
    if not a1:IsA("Highlight") then
        return false
    end
    local v1 = a1:IsDescendantOf(Workspace)
    if not v1 then
        v1 = false
        if a1.Adornee ~= nil then
            v1 = a1.Adornee:IsDescendantOf(Workspace)
        end
    end
    return v1
end

local function properties(a1) -- Line: 30 -- types: a1: userdata
    if a1:IsA("BillboardGui") then
        return {"PlayerToHideFrom"}
    end
    return {"FillTransparency", "OutlineTransparency"}
end

local function hiddenValue(a1) -- Line: 35 -- upvalues: LocalPlayer (val) -- types: a1: userdata
    if a1:IsA("BillboardGui") then
        return LocalPlayer
    end
    return 1
end

local function apply(a1, a2) -- Line: 39
    -- upvalues: properties (val), LocalPlayer (val), u23 (ref)
    local v1
    local v2 = a1
    for i, j in properties(a1) do
        v1 = if not v2:IsA("BillboardGui") then 1 else LocalPlayer
        if not u23 then
            if v2[j] == v1 then
                v2[j] = v3.Values[j]
            end
        elseif v2[j] ~= v1 then
            v3.Values[j] = v2[j]
            v2[j] = v1
        end
    end
end

local function unwatchDecoration(a1) -- Line: 54
    -- upvalues: u128 (val), u23 (ref), properties (val), LocalPlayer (val)
    local v1 = u128[a1]
    if not v1 then
        return
    end
    u128[a1] = nil
    for i, j in v1.Connections do
        j:Disconnect()
    end
    if u23 then
        local v2
        local v3 = a1
        for k, n in properties(a1) do
            v2 = v3[n]
            if v2 == (if not v3:IsA("BillboardGui") then 1 else LocalPlayer) then
                v3[n] = v1.Values[n]
            end
        end
    end
end

local function refresh() -- Line: 69
    -- upvalues: u131 (ref), Workspace (val), u129 (val), Lighting (val), u23 (ref), u128 (val), apply (val)
    if u131 then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = false
    for i in u129 do
        if i.Enabled then
            if i:IsDescendantOf(Lighting) then
                v1 = true
                break
            end
            if CurrentCamera and i:IsDescendantOf(CurrentCamera) then
                v1 = true
                break
            end
        end
    end
    if u23 == v1 then
        return
    end
    u23 = v1
    for j, k in u128 do
        apply(j, k)
    end
end

local function watchDecoration(a1) -- Line: 87
    -- upvalues: u128 (val), inWorld (val), properties (val), u23 (ref), LocalPlayer (val), unwatchDecoration (val)
    -- upvalues: apply (val)
    if not u128[a1] and inWorld(a1) then
        local u6 = {Values = {}, Connections = {}}
        for i, j in properties(a1) do
            u6.Values[j] = a1[j]
            table.insert(u6.Connections, ((a1:GetPropertyChangedSignal(j)):Connect(function() -- Line: 93
                -- upvalues: u128 (upval), a1 (val), u6 (val), u23 (upval), a1 (val), j (val), LocalPlayer (upval)
                if u128[a1] ~= u6 then
                    return
                end
                if not u23 then
                    u6.Values[j] = a1[j]
                    return
                end
                local v1 = a1[j]
                if v1 == (if not a1:IsA("BillboardGui") then 1 else LocalPlayer) then
                    return
                end
                u6.Values[j] = a1[j]
                a1[j] = if not a1:IsA("BillboardGui") then 1 else LocalPlayer
            end)))
        end
        u128[a1] = u6
        table.insert(u6.Connections, (a1.AncestryChanged:Connect(function() -- Line: 107 -- upvalues: inWorld (upval), a1 (val), unwatchDecoration (upval)
            if not inWorld(a1) then
                unwatchDecoration(a1)
            end
        end)))
        if u23 then
            apply(a1, u6)
        end
        return
    end
end

local function watchEffect(a1) -- Line: 113 -- upvalues: u129 (val), refresh (val) -- types: a1: userdata
    if u129[a1] then
        return
    end
    u129[a1] = {
        (a1:GetPropertyChangedSignal("Enabled")):Connect(refresh),
        a1.AncestryChanged:Connect(refresh),
        (a1.Destroying:Connect(function() -- Line: 118 -- upvalues: u129 (upval), a1 (val), refresh (upval)
            local v1 = u129[a1]
            u129[a1] = nil
            if v1 then
                for i, j in v1 do
                    j:Disconnect()
                end
            end
            refresh()
        end)),
    }
    refresh()
end

local function watch(a1) -- Line: 130
    -- upvalues: u131 (ref), watchEffect (val), watchDecoration (val)
    if u131 then
        return
    end
    if a1:IsA("BlurEffect") then
        watchEffect(a1)
        return
    end
    if a1:IsA("BillboardGui") or a1:IsA("Highlight") then
        watchDecoration(a1)
    end
end

local v1 = {Lighting, Workspace, PlayerGui}
local v2 = nil
local v3 = nil
for i, j in v1, v2, v3 do
    table.insert(u130, (j.DescendantAdded:Connect(watch)))
    for k, n in j:GetDescendants() do
        if not u131 then
            if n:IsA("BlurEffect") then
                watchEffect(n)
            elseif n:IsA("BillboardGui") or n:IsA("Highlight") then
                watchDecoration(n)
            end
        end
    end
end
table.insert(u130, ((Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(refresh)))
refresh()
script.Destroying:Connect(function() -- Line: 148 -- upvalues: u131 (ref), u130 (val), u129 (val), u128 (val), unwatchDecoration (val)
    u131 = true
    for i, j in u130 do
        j:Disconnect()
    end
    local v1 = nil
    local v2 = nil
    for k, n in u129, v1, v2 do
        for m, i5 in n do
            i5:Disconnect()
        end
        u129[k] = nil
    end
    local v3 = {}
    for i6 in u128 do
        table.insert(v3, i6)
    end
    for i7, i8 in v3 do
        unwatchDecoration(i8)
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.BossVisualClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.BossVisualClient
-- Decompile time: 14.19 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local u67 = nil
local u68 = nil
local u17 = nil
local u18 = {}

local function refreshBones(a1) -- Line: 12 -- upvalues: u18 (ref) -- types: a1: userdata
    local v1
    local v2 = {}
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("Bone") then
            v2[v.Name] = v
        end
    end
    u18 = {}
    for i2, i3 in ipairs({"Bone.002", "Bone.003", "Bone.004", "Bone.005"}) do
        v1 = v2[i3]
        if v1 then
            table.insert(u18, v1)
        end
    end
end

local function refreshMotion(a1) -- Line: 24 -- upvalues: u17 (ref), u68 (ref) -- types: a1: userdata
    local Attribute = a1:GetAttribute("MotionStart")
    local Attribute_2 = a1:GetAttribute("MotionFinish")
    local Attribute_3 = a1:GetAttribute("MotionStartedAt")
    local Attribute_4 = a1:GetAttribute("MotionDuration")
    local Attribute_5 = a1:GetAttribute("MotionRotation")
    if typeof(Attribute) == "Vector3"
        and typeof(Attribute_2) == "Vector3"
        and typeof(Attribute_3) == "number"
        and typeof(Attribute_4) == "number"
        and typeof(Attribute_5) == "CFrame" then
        u68 = a1:GetAttribute("MotionSerial")
        u17 = {
            State = a1:GetAttribute("BossState") or "Roaming",
            Start = Attribute,
            Finish = Attribute_2,
            StartedAt = Attribute_3,
            Duration = math.max(0.05, Attribute_4),
            Rotation = Attribute_5,
            Curve = tonumber((a1:GetAttribute("MotionCurve"))) or 0,
            Bank = tonumber((a1:GetAttribute("MotionBank"))) or 0,
        }
        return
    end
    u17 = nil
end

Workspace.ChildAdded:Connect(function(a1) -- Line: 51
    -- upvalues: u67 (ref), u68 (ref), refreshBones (val), refreshMotion (val)
    if a1:IsA("Model") and a1:GetAttribute("BossTarget") == true then
        u67 = a1
        u68 = nil
        refreshBones(a1)
        refreshMotion(a1)
        return
    end
end)
Workspace.ChildRemoved:Connect(function(a1) -- Line: 60 -- upvalues: u67 (ref), u68 (ref), u17 (ref), u18 (ref)
    if a1 == u67 then
        u67 = nil
        u68 = nil
        u17 = nil
        u18 = {}
    end
end)
for i, v in ipairs(Workspace:GetChildren()) do
    if v:IsA("Model") and v:GetAttribute("BossTarget") == true then
        u67 = v
        u68 = nil
        refreshBones(v)
        refreshMotion(v)
    end
end
RunService.RenderStepped:Connect(function() -- Line: 70
    -- upvalues: u67 (ref), u68 (ref), refreshMotion (val), u17 (ref), Workspace (val), Players (val), u18 (ref)
    local v1 = u67
    if v1 and v1.Parent then
        local v2, v3, v4, v5
        if (v1:GetAttribute("MotionSerial")) ~= u68 then
            refreshMotion(v1)
        end
        local v6 = u17
        if not v6 then
            return
        end
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local v7 = math.clamp((ServerTimeNow - v6.StartedAt) / v6.Duration, 0, 1)
        local v8 = v6.Start:Lerp(v6.Finish, v7)
        local v9 = v6.Finish - v6.Start
        local v10 = Vector3.new(v9.X, 0, v9.Z)
        if not (0.01 < v10.Magnitude) then
            v4 = Vector3.new(1, 0, 0)
        else
            local Unit = v10.Unit
            v4 = Vector3.new(0, 1, 0):Cross(Unit)
        end
        if v6.Curve ~= 0 then
            v8 = v8 + v4 * ((math.sin(v7 * 3.141592653589793)) * v6.Curve)
            v9 = v9 + v4 * (math.cos(v7 * 3.141592653589793) * 3.141592653589793 * v6.Curve)
        end
        local v11 = math.rad(v6.Bank * (math.sin(v7 * 3.141592653589793)))
        if v6.State == "Death" then
            v2 = v7 * 3.141592653589793
            v8 = v8 + Vector3.new(0, 1, 0) * (math.sin(v2) * 18)
        elseif v6.State == "Intro" then
            v2 = v7 * 3.141592653589793
            v8 = v8 + Vector3.new(0, 1, 0) * math.sin(v2) * 4.5
        elseif v6.State == "Roaming" then
            v2 = v7 * 3.141592653589793 * 4
            v8 = v8 + Vector3.new(0, 1, 0) * math.sin(v2) * 1.15
        elseif v6.State == "Recovering" then
            v2 = v7 * 3.141592653589793 * 4
            v8 = v8 + Vector3.new(0, 1, 0) * math.sin(v2) * 0.7
        elseif v6.State == "Retreating" then
            v2 = v7 * 3.141592653589793 * 2
            v8 = v8 + Vector3.new(0, 1, 0) * math.sin(v2) * 0.75
        elseif v6.State == "Telegraphing" then
            v5 = tonumber((v1:GetAttribute("BossTargetUserId"))) or 0
            local PlayerByUserId = if not (v5 > 0) then nil else Players:GetPlayerByUserId(v5)
            local Character = PlayerByUserId and PlayerByUserId.Character and PlayerByUserId.Character:FindFirstChild("HumanoidRootPart")
            if Character and Character:IsA("BasePart") then
                v9 = Character.Position - v8
            end
        end
        if v9.Magnitude < 0.01 then
            v9 = Vector3.new(0, 0, 1)
        end
        v5 = if v6.State ~= "Charging" then if v6.State ~= "Retreating" then if v6.State ~= "Telegraphing" then 1 else 0.7 else 1.55 else 2.1
        local v12 = {3, 6, 10, 15}
        for i, v in ipairs(u18) do
            v3 = (math.sin(ServerTimeNow * 4.8 * v5 - (i - 1) * 0.5)) * v12[i]
            v.Transform = CFrame.Angles(0, 0, (math.rad(v3)))
        end
        v1:PivotTo((CFrame.lookAt(v8, v8 + v9.Unit, (Vector3.new(0, 1, 0)))) * CFrame.Angles(0, 0, v11) * v6.Rotation)
        return
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.CameraComfortClient
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.CameraComfortClient
-- Decompile time: 8.25 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule", 15)
local CameraModule = PlayerModule and PlayerModule:WaitForChild("CameraModule", 15)
local CameraInput = CameraModule and CameraModule:WaitForChild("CameraInput", 15)
if CameraInput and CameraInput:IsA("ModuleScript") then
    local success, result = pcall(require, CameraInput)
    if success and type(result) == "table" and type(result.getRotation) == "function" then
        local getRotation = result.getRotation
        local zero = Vector2.zero
        local u71 = nil
        local u72 = false
        local u73 = true
        local u74 = {}
        local u81 = "FishCameraComfort_" .. tostring(LocalPlayer.UserId)

        local function reset() -- Line: 37 -- upvalues: zero (ref), u71 (ref)
            zero = Vector2.zero
            u71 = nil
        end

        local function allowed() -- Line: 42
            -- upvalues: Workspace (val), LocalPlayer (val), VRService (val), u72 (ref), u73 (ref)
            local CurrentCamera = Workspace.CurrentCamera
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local v1 = false
            if CurrentCamera ~= nil then
                v1 = false
                if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    v1 = not VRService.VREnabled
                    if v1 then
                        v1 = not u72
                        if v1 then
                            v1 = u73
                            if v1 then
                                v1 = false
                                if Humanoid ~= nil then
                                    v1 = false
                                    if 0 < Humanoid.Health then
                                        v1 = LocalPlayer:GetAttribute("FishDead") ~= true
                                    end
                                end
                            end
                        end
                    end
                end
            end
            return v1
        end

        local function comfortableRotation(a1, a2) -- Line: 52
            -- upvalues: getRotation (val), allowed (val), zero (ref), u71 (ref)
            local v1 = getRotation(a1, a2)
            if not allowed() then
                zero = Vector2.zero
                u71 = nil
                return v1
            end
            if u71 then
                return u71
            end
            local v2 = v1 * 0.7
            if not (a1 <= 0) and not (a1 > 0.1) then
                zero = zero + v2
                local v3 = zero * (1 - math.exp(a1 * -30))
                zero = zero - v3
                if zero.Magnitude < 1e-05 then
                    zero = Vector2.zero
                end
                u71 = v3
                return v3
            end
            zero = Vector2.zero
            u71 = v2
            return v2
        end

        result.getRotation = comfortableRotation
        RunService:BindToRenderStep(u81, Enum.RenderPriority.Camera.Value - 1, function() -- Line: 75 -- upvalues: u71 (ref), allowed (val), result (val), zero (ref)
            u71 = nil
            if not allowed() or not result.getInputEnabled() then
                zero = Vector2.zero
                u71 = nil
            end
        end)
        table.insert(u74, (LocalPlayer.CharacterAdded:Connect(reset)))
        table.insert(u74, ((Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(reset)))
        table.insert(u74, (UserInputService.WindowFocusReleased:Connect(function() -- Line: 81 -- upvalues: u73 (ref), zero (ref), u71 (ref)
            u73 = false
            zero = Vector2.zero
            u71 = nil
        end)))
        table.insert(u74, (UserInputService.WindowFocused:Connect(function() -- Line: 85 -- upvalues: u73 (ref), zero (ref), u71 (ref)
            u73 = true
            zero = Vector2.zero
            u71 = nil
        end)))
        table.insert(u74, (GuiService.MenuOpened:Connect(function() -- Line: 89 -- upvalues: u72 (ref), zero (ref), u71 (ref)
            u72 = true
            zero = Vector2.zero
            u71 = nil
        end)))
        table.insert(u74, (GuiService.MenuClosed:Connect(function() -- Line: 93 -- upvalues: u72 (ref), zero (ref), u71 (ref)
            u72 = false
            zero = Vector2.zero
            u71 = nil
        end)))
        script.Destroying:Connect(function() -- Line: 97
            -- upvalues: RunService (val), u81 (val), result (val), comfortableRotation (val), getRotation (val)
            -- upvalues: u74 (val)
            RunService:UnbindFromRenderStep(u81)
            if result.getRotation == comfortableRotation then
                result.getRotation = getRotation
            end
            for i, j in u74 do
                j:Disconnect()
            end
        end)
        return
    end
    warn("[CameraComfort] Default camera input could not be loaded")
    return
end
warn("[CameraComfort] Default camera input module is unavailable")
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.CoPlayBoostClient
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.CoPlayBoostClient
-- Decompile time: 1.04 ms

local LocalPlayer = game:GetService("Players").LocalPlayer
local Boost = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("CoPlayHUD"):WaitForChild("Boost")
;(LocalPlayer:GetAttributeChangedSignal("CoPlayBoostActive")):Connect(function() -- Line: 6 -- upvalues: Boost (val), LocalPlayer (val)
    Boost.Visible = LocalPlayer:GetAttribute("CoPlayBoostActive") == true
    Boost.Text = "+50%"
end)
Boost.Visible = LocalPlayer:GetAttribute("CoPlayBoostActive") == true
Boost.Text = "+50%"
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.CombatFeedbackClient
-- Took 0.04s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.CombatFeedbackClient
-- Decompile time: 39.75 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FishGame = ReplicatedStorage:WaitForChild("FishGame")
local Config = require(FishGame:WaitForChild("Config"))
local Remotes = FishGame:WaitForChild("Remotes")
local CombatFeedbackFX = Remotes:WaitForChild("CombatFeedbackFX")
local RedFishFX = Remotes:WaitForChild("RedFishFX")
local StateUpdate = Remotes:WaitForChild("StateUpdate")
local FishHealthBillboard = ReplicatedStorage:FindFirstChild("FishHealthBillboard")
local u65 = {}
local u66 = 0

local function healthAdornee(a1) -- Line: 33 -- types: a1: userdata
    if a1:IsA("Model") and a1:GetAttribute("FishKind") == "PirateShip" then
        local Captain = a1:FindFirstChild("Captain", true)
        local Head = Captain and Captain:FindFirstChild("Head")
        if Head and Head:IsA("BasePart") then
            return Head
        end
    end
    if a1:IsA("Model") then
        return a1.PrimaryPart or a1:FindFirstChildWhichIsA("BasePart", true)
    end
    if a1:IsA("BasePart") then
        return a1
    end
    return nil
end

local function makeRecord(a1) -- Line: 47
    -- upvalues: FishHealthBillboard (val), healthAdornee (val), Config (val), PlayerGui (val), u65 (val)
    assert(FishHealthBillboard, "ReplicatedStorage.FishHealthBillboard is missing")
    local v1 = healthAdornee(a1)
    assert(v1 and v1:IsA("BasePart"), "Fish health target has no BasePart")
    local Attribute = a1:GetAttribute("FishKind")
    local v2 = true
    if Attribute ~= "PirateShip" then
        v2 = Attribute == "Submarine"
    end
    local v3 = FishHealthBillboard:Clone()
    v3.Name = "FishHealth_" .. a1.Name
    v3.Adornee = v1
    v3.Enabled = true
    local v4 = if not v2 then 1 else 2
    local v5 = (math.max(0.1, (tonumber(Config.Feedback.FishHealthBillboardScale)) or 1)) * v4
    v3.Size = UDim2.new(
        v3.Size.X.Scale * v5,
        math.floor(v3.Size.X.Offset * v5 + 0.5),
        v3.Size.Y.Scale * v5,
        (math.floor(v3.Size.Y.Offset * v5 + 0.5))
    )
    local v6 = math.max(0, (tonumber(Config.Feedback.FishHealthBillboardClearance)) or 2)
    if Attribute == "PirateShip" then
        v3.StudsOffsetWorldSpace = Vector3.new(0, v1.Size.Y * 0.5 + 4, 0)
    elseif not a1:IsA("Model") then
        v3.StudsOffsetWorldSpace = Vector3.new(0, v1.Size.Y * 0.5 + v6, 0)
    else
        local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
        v3.StudsOffsetWorldSpace = Vector3.new(
            BoundingBox.Position.X - v1.Position.X,
            BoundingBox.Position.Y - v1.Position.Y + BoundingBox_2.Y * 0.5 + v6,
            BoundingBox.Position.Z - v1.Position.Z
        )
    end
    v3.StudsOffset = Vector3.new(0, 0, 0)
    if v2 then
        v3.AlwaysOnTop = true
        v3.MaxDistance = math.max(v3.MaxDistance, 500)
    end
    local BossHealthBar = v3:WaitForChild("BossHealthBar")
    local FishName = BossHealthBar:WaitForChild("FishName")
    local HealthAmount = BossHealthBar:WaitForChild("HealthAmount")
    local FillBar = BossHealthBar:WaitForChild("FillBar")
    FillBar.AnchorPoint = Vector2.new(0, 0.5)
    FillBar.Position = UDim2.fromScale(0, 0.5)
    FillBar.Size = UDim2.fromScale(1, 1)
    v3.Parent = PlayerGui
    local v7 = {
        Serial = 0,
        Billboard = v3,
        Name = FishName,
        Amount = HealthAmount,
        Fill = FillBar,
        UpdatedAt = os.clock(),
    }
    u65[a1] = v7
    return v7
end

local function removeRecord(a1) -- Line: 96 -- upvalues: u65 (val) -- types: a1: userdata
    local v1 = u65[a1]
    if not v1 then
        return
    end
    u65[a1] = nil
    v1.Billboard:Destroy()
end

local function showTarget(a1) -- Line: 103
    -- upvalues: FishHealthBillboard (val), u65 (val), makeRecord (val), u66 (ref), TweenService (val)
    local Target = a1.Target
    if FishHealthBillboard and typeof(Target) == "Instance" and a1.FishKind ~= "Boss" then
        local v1 = u65[Target]
        if a1.Killed == true and not v1 then
            return
        end
        local u15 = v1
        if not u15 then
            u15 = makeRecord(Target)
        end
        u66 = u66 + 1
        u15.Serial = u66
        u15.UpdatedAt = os.clock()
        u15.Name.Text = tostring(a1.DisplayName or Target.Name)
        local v2 = math.max(0, (tonumber(a1.Health)) or 0)
        local v3 = math.max(1, (tonumber(a1.MaxHealth)) or 1)
        u15.Amount.Text = string.format("%d/%d", math.floor(v2 + 0.5), (math.floor(v3 + 0.5)))
        TweenService:Create(
            u15.Fill,
            TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(math.clamp(v2 / v3, 0, 1), 0, 1, 0)}
        ):Play()
        local Serial = u15.Serial
        task.delay(if a1.Killed ~= true then 3 else 0.25, function() -- Line: 125 -- upvalues: u65 (upval), Target (val), u15 (val), Serial (val)
            local v1 = u65[Target]
            if v1 == u15 and u15.Serial == Serial then
                v1 = Target
                local v2 = u65[v1]
                if not v2 then
                    return
                end
                u65[v1] = nil
                v2.Billboard:Destroy()
            end
        end)
        return
    end
end

local ImpactRig = ((FishGame:WaitForChild("Assets")):WaitForChild("WeaponEffects")):FindFirstChild("ImpactRig")
local u83 = 0

local function showImpact(a1) -- Line: 132 -- upvalues: ImpactRig (val), u83 (ref), Workspace (val)
    if ImpactRig and ImpactRig:IsA("BasePart") then
        local new, v1, v2
        local v3 = os.clock()
        if v3 - u83 < 0.035 then
            return
        end
        u83 = v3
        local Position = a1.Position
        if typeof(Position) ~= "Vector3" then
            return
        end
        local u19 = ImpactRig:Clone()
        u19.Name = "FishHitImpactLocal"
        u19.CFrame = CFrame.new(Position)
        u19.Parent = Workspace
        local v4 = (math.clamp(math.sqrt((math.max(1, (tonumber(a1.Damage)) or 15)) / 15), 0.8, 2.5)) * (if a1.Kind ~= "BossHit" then 1 else 1.35)
        local v5 = v4 * (if a1.Killed ~= true then 1 else 1.5)
        for i, v in ipairs(u19:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false
                new = NumberSequence.new
                v1 = {
                    NumberSequenceKeypoint.new(0, v5 * 0.35),
                    NumberSequenceKeypoint.new(0.25, v5 * 0.8),
                    (NumberSequenceKeypoint.new(1, 0)),
                }
                v.Size = new(v1)
                v2 = math.clamp(math.floor(((v:GetAttribute("Burst")) or 6) * 0.45), 2, 8)
                v:Emit(v2)
            elseif v:IsA("Sound") then
                v.Volume = math.min(v.Volume, 0.45)
                v:Play()
            end
        end
        task.delay(1.2, function() -- Line: 161 -- upvalues: u19 (val)
            if u19.Parent then
                u19:Destroy()
            end
        end)
        return
    end
end

local u85 = Vector3.new(0, 0, 0)
local u86 = Vector3.new(0, 0, 0)
local u87 = 0
local u88 = 0
local u89 = 0
local u92 = math.random() * 1000
local u93 = 0
local u94 = 0

local function shake(a1, a2) -- Line: 175 -- upvalues: u87 (ref), u88 (ref), u89 (ref) -- types: a1: number, a2: number
    local v1 = os.clock()
    u87 = math.max(0, a1)
    u88 = v1
    u89 = v1 + math.max(0.05, a2)
end

local function distanceToModelBounds(a1, a2) -- Line: 182 -- types: a1: userdata, a2: vector
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local v1 = BoundingBox:PointToObjectSpace(a2)
    local v2 = BoundingBox_2 * 0.5
    return (a2 - BoundingBox:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))))).Magnitude
end

local function updateTsunamiProximity(a1) -- Line: 194
    -- upvalues: Config (val), Workspace (val), distanceToModelBounds (val), u93 (ref)
    local v1 = math.max(1, Config.Feedback.TsunamiProximityShakeDistance)
    local v2 = (1 / 0)
    local FishDayEvents = Workspace:FindFirstChild("FishDayEvents")
    local Tsunami = FishDayEvents and FishDayEvents:FindFirstChild("Tsunami")
    if Tsunami then
        for i, v in ipairs(Tsunami:GetChildren()) do
            if v:IsA("Model") then
                v2 = math.min(v2, (distanceToModelBounds(v, a1)))
            end
        end
    end
    u93 = Config.Feedback.TsunamiProximityShakeStrength * (1 - (math.clamp(v2 / v1, 0, 1))) ^ 0.7
end

local function bassDrop(a1, a2) -- Line: 210
    -- upvalues: Config (val), SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = a1
    Sound.SoundId = Config.Feedback.BassDropSoundId
    Sound.Volume = a2
    Sound.PlaybackSpeed = 1
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    task.delay(12, function() -- Line: 218 -- upvalues: Sound (val)
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
end

local function feedbackSound(a1, a2, a3) -- Line: 223
    -- upvalues: SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = a1
    Sound.SoundId = a2
    Sound.Volume = a3
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    task.delay(12, function() -- Line: 230 -- upvalues: Sound (val)
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
end

local function nightfallBeep() -- Line: 235 -- upvalues: Config (val), SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = "NightfallBeep"
    Sound.SoundId = Config.Feedback.NightfallBeepSoundId
    Sound.Volume = Config.Feedback.NightfallBeepVolume
    Sound.Looped = true
    Sound.Parent = SoundService
    local u12 = 0
    Sound.DidLoop:Connect(function() -- Line: 243 -- upvalues: u12 (ref), Sound (val)
        u12 = u12 + 1
        if u12 >= 2 then
            Sound:Stop()
            Sound:Destroy()
        end
    end)
    Sound:Play()
    task.delay(20, function() -- Line: 251 -- upvalues: Sound (val)
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
end

RunService:BindToRenderStep("FishCombatCameraImpulse", Enum.RenderPriority.Camera.Value + 50, function(a1) -- Line: 256
    -- upvalues: Workspace (val), u85 (ref), u86 (ref), u87 (ref), u89 (ref), u94 (ref), updateTsunamiProximity (val)
    -- upvalues: u88 (ref), u93 (ref), u92 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if not CurrentCamera then
        return
    end
    if CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        u85 = Vector3.new(0, 0, 0)
        u86 = Vector3.new(0, 0, 0)
        u87 = 0
        u89 = 0
        return
    end
    local v1 = os.clock()
    if u94 <= v1 then
        u94 = v1 + 0.05
        updateTsunamiProximity(CurrentCamera.CFrame.Position)
    end
    local v2 = math.max(0.05, u89 - u88)
    local v3 = math.clamp((v1 - u88) / v2, 0, 1)
    local v4 = math.max(if not (v1 < u89) then 0 else u87 * (1 - v3) ^ 0.6, u93) * 0.4
    local v5 = -a1
    local v6 = 1 - math.exp(v5 * (if not (v4 > 0) then 18 else 20))
    local v7 = v1 * 18 + u92
    local v8 = Vector3.new(math.noise(v7, 0, 0), math.noise(0, v7, 0), 0) * v4 * 0.055
    v5 = Vector3.new(math.noise(v7, 10, 0), math.noise(10, v7, 0), (math.noise(v7, 0, 10))) * v4 * 0.0035
    u85 = u85:Lerp(v8, v6)
    u86 = u86:Lerp(v5, v6)
    if v4 == 0 then
        u87 = u87 * math.exp(-a1 * 14)
    end
    CurrentCamera.CFrame = CurrentCamera.CFrame * ((CFrame.new(u85)) * CFrame.Angles(u86.X, u86.Y, u86.Z))
end)
CombatFeedbackFX.OnClientEvent:Connect(function(a1) -- Line: 285
    -- upvalues: bassDrop (val), Config (val), u87 (ref), u88 (ref), u89 (ref), nightfallBeep (val), feedbackSound (val)
    -- upvalues: LocalPlayer (val), showTarget (val), showImpact (val)
    local v1
    if type(a1) ~= "table" then
        return
    end
    if a1.Kind == "BossRevealImpact" then
        bassDrop("BossRevealBassDrop", Config.Feedback.BossRevealBassDropVolume)
        local BossRevealShakeStrength = Config.Feedback.BossRevealShakeStrength
        local BossRevealShakeDuration = Config.Feedback.BossRevealShakeDuration
        v1 = os.clock()
        u87 = math.max(0, BossRevealShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, BossRevealShakeDuration)
        return
    end
    if a1.Kind == "TutorialSurvivalImpact" then
        bassDrop("TutorialSurvivalBassDrop", Config.Feedback.TutorialSurvivalBassDropVolume)
        local TutorialSurvivalShakeStrength = Config.Feedback.TutorialSurvivalShakeStrength
        local TutorialSurvivalShakeDuration = Config.Feedback.TutorialSurvivalShakeDuration
        v1 = os.clock()
        u87 = math.max(0, TutorialSurvivalShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, TutorialSurvivalShakeDuration)
        return
    end
    if a1.Kind == "NightfallCue" then
        nightfallBeep()
        return
    end
    if a1.Kind == "BossDeathStarted" then
        feedbackSound("BossDeathStartHit", Config.Feedback.BossDeathStartSoundId, Config.Feedback.BossDeathStartSoundVolume)
        return
    end
    if a1.Kind == "TsunamiWarning" then
        bassDrop("TsunamiWarningBassDrop", Config.Feedback.ShoalWarningBassDropVolume)
        local TsunamiWarningShakeStrength = Config.Feedback.TsunamiWarningShakeStrength
        local TsunamiWarningShakeDuration = Config.Feedback.TsunamiWarningShakeDuration
        v1 = os.clock()
        u87 = math.max(0, TsunamiWarningShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, TsunamiWarningShakeDuration)
        return
    end
    if a1.Kind == "TsunamiArrival" then
        local TsunamiArrivalShakeStrength = Config.Feedback.TsunamiArrivalShakeStrength
        local TsunamiArrivalShakeDuration = Config.Feedback.TsunamiArrivalShakeDuration
        v1 = os.clock()
        u87 = math.max(0, TsunamiArrivalShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, TsunamiArrivalShakeDuration)
        return
    end
    if a1.Kind == "TsunamiHit" then
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Direction = a1.Direction
        if HumanoidRootPart
            and HumanoidRootPart:IsA("BasePart")
            and typeof(Direction) == "Vector3"
            and 0.1 < Direction.Magnitude then
            HumanoidRootPart.AssemblyLinearVelocity = Direction.Unit * math.max(0, (tonumber(a1.ForwardSpeed)) or 135) + Vector3.new(0, 1, 0) * math.max(0, (tonumber(a1.UpSpeed)) or 55)
            if Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
            end
        end
        local TsunamiHitShakeStrength = Config.Feedback.TsunamiHitShakeStrength
        local TsunamiHitShakeDuration = Config.Feedback.TsunamiHitShakeDuration
        local v2 = os.clock()
        u87 = math.max(0, TsunamiHitShakeStrength)
        u88 = v2
        u89 = v2 + math.max(0.05, TsunamiHitShakeDuration)
        return
    end
    if a1.Kind == "RiverEncounterSink" then
        feedbackSound(
            "RiverEncounterSinkBass",
            Config.Feedback.BossWaterImpactBassSoundId,
            Config.Feedback.BossWaterImpactBassVolume * 0.75
        )
        feedbackSound(
            "RiverEncounterSinkSplash",
            Config.Feedback.BossWaterImpactSplashSoundId,
            Config.Feedback.BossWaterImpactSplashVolume * 0.8
        )
        local RiverEncounterSinkShakeStrength = Config.Feedback.RiverEncounterSinkShakeStrength
        local RiverEncounterSinkShakeDuration = Config.Feedback.RiverEncounterSinkShakeDuration
        v1 = os.clock()
        u87 = math.max(0, RiverEncounterSinkShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, RiverEncounterSinkShakeDuration)
        return
    end
    if a1.Kind ~= "BossWaterImpact" then
        showTarget(a1)
        if a1.HealthOnly ~= true then
            showImpact(a1)
        end
        return
    end
    feedbackSound("BossWaterImpactBass", Config.Feedback.BossWaterImpactBassSoundId, Config.Feedback.BossWaterImpactBassVolume)
    feedbackSound("BossWaterImpactSplash", Config.Feedback.BossWaterImpactSplashSoundId, Config.Feedback.BossWaterImpactSplashVolume)
    local BossWaterImpactShakeStrength = Config.Feedback.BossWaterImpactShakeStrength
    local BossWaterImpactShakeDuration = Config.Feedback.BossWaterImpactShakeDuration
    v1 = os.clock()
    u87 = math.max(0, BossWaterImpactShakeStrength)
    u88 = v1
    u89 = v1 + math.max(0.05, BossWaterImpactShakeDuration)
end)
RedFishFX.OnClientEvent:Connect(function(a1, a2) -- Line: 355
    -- upvalues: Config (val), u87 (ref), u88 (ref), u89 (ref)
    if a1 == "Bite" then
        local v1 = false
        if a2 ~= nil then
            v1 = a2:GetAttribute("BossTarget") == true
        end
        local v2 = false
        if a2 ~= nil then
            v2 = a2:GetAttribute("FishKind") == "Gator"
        end
        local BossBiteShakeStrength = if not v1 then if not v2 then Config.Feedback.RedFishBiteShakeStrength else Config.Feedback.GatorBiteShakeStrength else Config.Feedback.BossBiteShakeStrength
        local BossBiteShakeDuration = if not v1 then if not v2 then Config.Feedback.RedFishBiteShakeDuration else Config.Feedback.GatorBiteShakeDuration else Config.Feedback.BossBiteShakeDuration
        local v3 = os.clock()
        u87 = math.max(0, BossBiteShakeStrength)
        u88 = v3
        u89 = v3 + math.max(0.05, BossBiteShakeDuration)
    end
end)
local u119 = ""
local u120 = false
local u121 = false
StateUpdate.OnClientEvent:Connect(function(a1) -- Line: 373
    -- upvalues: u120 (ref), bassDrop (val), Config (val), u87 (ref), u88 (ref), u89 (ref), u121 (ref), u119 (ref)
    local v1
    if type(a1) ~= "table" then
        return
    end
    local v2 = tostring(a1.Phase or "")
    local v3 = a1.ShoalWarning == true
    local v4 = a1.ShoalActive == true
    if v3 and not u120 then
        bassDrop("ShoalWarningBassDrop", Config.Feedback.ShoalWarningBassDropVolume)
        local ShoalWarningShakeStrength = Config.Feedback.ShoalWarningShakeStrength
        local ShoalWarningShakeDuration = Config.Feedback.ShoalWarningShakeDuration
        v1 = os.clock()
        u87 = math.max(0, ShoalWarningShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, ShoalWarningShakeDuration)
    end
    if v4 and not u121 then
        local ShoalArrivalShakeStrength = Config.Feedback.ShoalArrivalShakeStrength
        local ShoalArrivalShakeDuration = Config.Feedback.ShoalArrivalShakeDuration
        v1 = os.clock()
        u87 = math.max(0, ShoalArrivalShakeStrength)
        u88 = v1
        u89 = v1 + math.max(0.05, ShoalArrivalShakeDuration)
    end
    u119 = v2
    u120 = v3
    u121 = v4
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.ConsoleNavigationClient
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.ConsoleNavigationClient
-- Decompile time: 25.34 ms

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Parent = script.Parent
local ConsoleModalBack = Parent:FindFirstChild("ConsoleModalBack")
if not ConsoleModalBack or not ConsoleModalBack:IsA("BindableEvent") then
    if ConsoleModalBack then
        ConsoleModalBack:Destroy()
    end
    ConsoleModalBack = Instance.new("BindableEvent")
    ConsoleModalBack.Name = "ConsoleModalBack"
    ConsoleModalBack.Parent = Parent
end
local u46 = {
    LobbyUI = {priority = 10, primary = {"1", "2", "3", "4", "LeaveButton"}, back = {"LeaveButton"}},
    GunShop = {
        priority = 20,
        primary = {"SelectButton", "CashButton", "RobuxButton", "CloseButton"},
        back = {"CloseButton"},
    },
    CommuntityChestUI = {priority = 30, primary = {"ClaimButton", "CloseButton"}, back = {"CloseButton"}},
    NEW_ItemShop = {
        priority = 40,
        primary = {"CashButton", "Buy", "ChancesButton", "Equip", "Add", "CloseButton"},
        back = {"CloseButton"},
    },
    PetOddsUI = {priority = 45, primary = {"CloseButton"}, back = {"CloseButton"}},
    PetInventoryUI = {
        priority = 50,
        primary = {"SelectButton", "CashButton", "RobuxButton", "CloseButton"},
        back = {"CloseButton"},
    },
    AdoptPetUI = {priority = 60, primary = {"ClaimButton", "CloseButton"}, back = {"CloseButton"}},
    WheelSpinUI = {priority = 70, primary = {"Spin", "Buy1", "Buy5", "Close"}, back = {"Close"}},
    Index = {priority = 80, primary = {"FishCard_1", "CloseButton"}, back = {"CloseButton"}},
    Dogs = {priority = 90, primary = {"Group 30 F", "1", "2", "3", "CloseButton"}, back = {"CloseButton"}},
    Drops = {
        priority = 100,
        primary = {"Buy1", "Buy10Robux", "Buy1Robux", "CloseButton"},
        back = {"CloseButton"},
    },
    StarterPack = {priority = 110, primary = {"Buy", "Cancel"}, back = {"Cancel"}},
    RobuxShop = {priority = 120, primary = {"Buy", "CloseButton"}, back = {"CloseButton"}},
    ScaleReward = {priority = 130, primary = {"CashButton"}, back = {}},
    MedalTVUI = {priority = 330, primary = {"ClaimButton", "CloseButton"}, back = {"CloseButton"}},
    UpgradeShop = {
        priority = 200,
        primary = {"SellFishButton", "Purchase", "A_GunUpgrades", "CloseButton"},
        back = {"CloseButton"},
    },
    SkipDayUI = {priority = 300, primary = {"SkipButton", "CloseButton"}, back = {"CloseButton"}},
    TravelingMerchantShop = {priority = 310, primary = {"Purchase", "CloseButton"}, back = {"CloseButton"}},
    PilotShop = {
        priority = 320,
        primary = {"1DayButton", "3DayButton", "ForeverButton", "CloseButton"},
        back = {"CloseButton"},
    },
    DeathUI = {priority = 900, primary = {"RobuxRespawnButton", "ClaimScalesButton"}, back = {}},
    WinUI = {priority = 910, primary = {"ClaimScalesButton"}, back = {}},
    ReturnToLobbyUI = {priority = 920, primary = {"ClaimScalesButton", "CloseButton"}, back = {"CloseButton"}},
    ReturnToLobbyUISolo = {
        priority = 930,
        primary = {"ClaimScalesButton", "ReturnWithoutClaim", "CloseButton"},
        back = {"CloseButton"},
    },
}
local u202 = {checkerboardtexture = true, studtexture = true, fill = true}

local function controllerMode() -- Line: 145 -- upvalues: UserInputService (val), GuiService (val)
    return UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
end

local function isVisible(a1, a2) -- Line: 149
    if a2.Enabled and a1.Visible then
        local Parent = a1.Parent
        local v1 = a2
        while Parent do
            if Parent == v1 then
                break
            end
            if Parent:IsA("GuiObject") and not Parent.Visible then
                return false
            end
            Parent = Parent.Parent
        end
        return Parent == v1
    end
    return false
end

local function isUsable(a1, a2) -- Line: 159 -- upvalues: u202 (val), isVisible (val)
    return a1 and a1:IsA("GuiButton") and not u202[string.lower(a1.Name)] and a1.Active and a1.Selectable and isVisible(a1, a2)
end

local function findButton(a1, a2) -- Line: 168 -- upvalues: u202 (val), isVisible (val)
    if #a2 == 0 then
        return nil
    end
    local v1 = a1
    for i, v in ipairs(a2) do
        for i2, i3 in ipairs(v1:GetDescendants()) do
            if i3:IsA("GuiButton")
                and i3.Name == v
                and i3
                and i3:IsA("GuiButton")
                and not u202[string.lower(i3.Name)]
                and i3.Active
                and i3.Selectable
                and isVisible(i3, v1) then
                return i3
            end
        end
    end
    for i4, j in ipairs(v1:GetDescendants()) do
        if j:IsA("GuiButton")
            and j
            and j:IsA("GuiButton")
            and not u202[string.lower(j.Name)]
            and j.Active
            and j.Selectable
            and isVisible(j, v1) then
            return j
        end
    end
    return nil
end

local function findPreferredButton(a1, a2) -- Line: 191 -- upvalues: u202 (val), isVisible (val)
    local v1 = a1
    for i, v in ipairs(a2) do
        for i2, i3 in ipairs(v1:GetDescendants()) do
            if i3:IsA("GuiButton")
                and i3.Name == v
                and i3
                and i3:IsA("GuiButton")
                and not u202[string.lower(i3.Name)]
                and i3.Active
                and i3.Selectable
                and isVisible(i3, v1) then
                return i3
            end
        end
    end
    return nil
end

local function wireUpgradeShopSelection(a1) -- Line: 206 -- upvalues: u202 (val), isVisible (val)
    if a1.Name ~= "UpgradeShop" then
        return
    end
    local SellFishButton = a1:FindFirstChild("SellFishButton", true)
    local ScrollingFrame = a1:FindFirstChild("ScrollingFrame", true)
    if SellFishButton
        and SellFishButton:IsA("GuiButton")
        and ScrollingFrame
        and ScrollingFrame:IsA("ScrollingFrame") then
        local v1 = nil
        for i, v in ipairs(ScrollingFrame:GetDescendants()) do
            if v:IsA("GuiButton")
                and v.Name == "Purchase"
                and v
                and v:IsA("GuiButton")
                and not u202[string.lower(v.Name)]
                and v.Active
                and v.Selectable
                and isVisible(v, a1) then
                v.NextSelectionUp = SellFishButton
                if not v1
                    or v.AbsolutePosition.Y < v1.AbsolutePosition.Y
                    or v.AbsolutePosition.Y == v1.AbsolutePosition.Y and v.AbsolutePosition.X < v1.AbsolutePosition.X then
                    v1 = v
                end
            end
        end
        if v1 then
            SellFishButton.NextSelectionDown = v1
        end
        return
    end
end

local function findModal() -- Line: 242 -- upvalues: u46 (val), PlayerGui (val), findButton (val)
    local v1, v2
    local v3 = {}
    for k, v in pairs(u46) do
        v1 = PlayerGui:FindFirstChild(k)
        if v1 and v1:IsA("ScreenGui") and v1.Enabled then
            v2 = findButton(v1, v.primary)
            if v2 then
                table.insert(v3, {
                    screen = v1,
                    config = v,
                    button = v2,
                    score = v1.DisplayOrder * 1000 + v.priority,
                })
            end
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 260
        return a1.score < a2.score
    end)
    return v3[#v3]
end

local function selectedBelongsToModal(a1) -- Line: 267 -- upvalues: GuiService (val), isVisible (val)
    local SelectedObject = GuiService.SelectedObject
    return SelectedObject and SelectedObject:IsA("GuiObject") and SelectedObject:IsDescendantOf(a1.screen) and SelectedObject.Selectable and isVisible(SelectedObject, a1.screen)
end

local function selectedBelongsToKnownModal() -- Line: 276 -- upvalues: GuiService (val), u46 (val), PlayerGui (val)
    local v1
    local SelectedObject = GuiService.SelectedObject
    if not SelectedObject then
        return false
    end
    for k in pairs(u46) do
        v1 = PlayerGui:FindFirstChild(k)
        if v1 and SelectedObject:IsDescendantOf(v1) then
            return true
        end
    end
    return false
end

local u221 = {}
local u222 = {}

local function watchScreen(a1) -- Line: 290
    -- upvalues: u221 (val), u222 (val), GuiService (val), wireUpgradeShopSelection (val), UserInputService (val)
    -- upvalues: u202 (val), isVisible (val)
    if u221[a1] then
        return
    end
    u221[a1] = true
    u222[a1] = u222[a1] or 0
    ;(a1:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 295
        -- upvalues: u222 (upval), a1 (val), GuiService (upval), wireUpgradeShopSelection (upval)
        -- upvalues: UserInputService (upval), u202 (upval), isVisible (upval)
        local v1 = u222
        local v2 = a1
        v1[v2] = v1[v2] + 1
        if a1.Enabled then
            if a1.Name == "UpgradeShop" then
                wireUpgradeShopSelection(a1)
                task.spawn(function() -- Line: 307
                    -- upvalues: a1 (upval), UserInputService (upval), GuiService (upval), u202 (upval)
                    -- upvalues: isVisible (upval)
                    local GamepadEnabled, SellFishButton, v1
                    for i = 1, 12 do
                        if a1.Enabled then
                            GamepadEnabled = UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
                            if GamepadEnabled then
                                SellFishButton = a1:FindFirstChild("SellFishButton", true)
                                v1 = a1
                                if not SellFishButton
                                    or not SellFishButton:IsA("GuiButton")
                                    or u202[string.lower(SellFishButton.Name)]
                                    or not SellFishButton.Active
                                    or not SellFishButton.Selectable
                                    or not isVisible(SellFishButton, v1) then
                                    continue
                                end
                                GuiService.SelectedObject = SellFishButton
                                return
                            end
                        end
                        return
                    end
                end)
            end
            return
        end
        local SelectedObject = GuiService.SelectedObject
        if SelectedObject and SelectedObject:IsDescendantOf(a1) then
            GuiService.SelectedObject = nil
        end
    end)
end

for k in pairs(u46) do
    local u275 = PlayerGui:FindFirstChild(k)
    if u275 and u275:IsA("ScreenGui") and not u221[u275] then
        u221[u275] = true
        u222[u275] = u222[u275] or 0
        ;(u275:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 295
            -- upvalues: u222 (val), u275 (val), GuiService (val), wireUpgradeShopSelection (val)
            -- upvalues: UserInputService (val), u202 (val), isVisible (val)
            local v1 = u222
            local v2 = u275
            v1[v2] = v1[v2] + 1
            if u275.Enabled then
                if u275.Name == "UpgradeShop" then
                    wireUpgradeShopSelection(u275)
                    task.spawn(function() -- Line: 307
                        -- upvalues: u275 (upval), UserInputService (upval), GuiService (upval), u202 (upval)
                        -- upvalues: isVisible (upval)
                        local GamepadEnabled, SellFishButton, v1
                        for i = 1, 12 do
                            if u275.Enabled then
                                GamepadEnabled = UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
                                if GamepadEnabled then
                                    SellFishButton = u275:FindFirstChild("SellFishButton", true)
                                    v1 = u275
                                    if not SellFishButton
                                        or not SellFishButton:IsA("GuiButton")
                                        or u202[string.lower(SellFishButton.Name)]
                                        or not SellFishButton.Active
                                        or not SellFishButton.Selectable
                                        or not isVisible(SellFishButton, v1) then
                                        continue
                                    end
                                    GuiService.SelectedObject = SellFishButton
                                    return
                                end
                            end
                            return
                        end
                    end)
                end
                return
            end
            local SelectedObject = GuiService.SelectedObject
            if SelectedObject and SelectedObject:IsDescendantOf(u275) then
                GuiService.SelectedObject = nil
            end
        end)
    end
end
PlayerGui.ChildAdded:Connect(function(a1) -- Line: 333
    -- upvalues: u46 (val), u221 (val), u222 (val), GuiService (val), wireUpgradeShopSelection (val)
    -- upvalues: UserInputService (val), u202 (val), isVisible (val)
    if a1:IsA("ScreenGui") and u46[a1.Name] then
        if u221[a1] then
            return
        end
        u221[a1] = true
        u222[a1] = u222[a1] or 0
        ;(a1:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 295
            -- upvalues: u222 (upval), a1 (val), GuiService (upval), wireUpgradeShopSelection (upval)
            -- upvalues: UserInputService (upval), u202 (upval), isVisible (upval)
            local v1 = u222
            local v2 = a1
            v1[v2] = v1[v2] + 1
            if a1.Enabled then
                if a1.Name == "UpgradeShop" then
                    wireUpgradeShopSelection(a1)
                    task.spawn(function() -- Line: 307
                        -- upvalues: a1 (upval), UserInputService (upval), GuiService (upval), u202 (upval)
                        -- upvalues: isVisible (upval)
                        local GamepadEnabled, SellFishButton, v1
                        for i = 1, 12 do
                            if a1.Enabled then
                                GamepadEnabled = UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
                                if GamepadEnabled then
                                    SellFishButton = a1:FindFirstChild("SellFishButton", true)
                                    v1 = a1
                                    if not SellFishButton
                                        or not SellFishButton:IsA("GuiButton")
                                        or u202[string.lower(SellFishButton.Name)]
                                        or not SellFishButton.Active
                                        or not SellFishButton.Selectable
                                        or not isVisible(SellFishButton, v1) then
                                        continue
                                    end
                                    GuiService.SelectedObject = SellFishButton
                                    return
                                end
                            end
                            return
                        end
                    end)
                end
                return
            end
            local SelectedObject = GuiService.SelectedObject
            if SelectedObject and SelectedObject:IsDescendantOf(a1) then
                GuiService.SelectedObject = nil
            end
        end)
    end
end)

local function refreshSelection(a1, a2, a3) -- Line: 339
    -- upvalues: UserInputService (val), GuiService (val), findModal (val), selectedBelongsToKnownModal (val)
    -- upvalues: wireUpgradeShopSelection (val), findPreferredButton (val), u222 (val), isVisible (val)
    local GamepadEnabled = UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
    if not GamepadEnabled then
        return a1, a2, a3
    end
    local v1 = findModal()
    if not v1 then
        if selectedBelongsToKnownModal() then
            GuiService.SelectedObject = nil
        end
        return nil, nil, nil
    end
    wireUpgradeShopSelection(v1.screen)
    local v2 = findPreferredButton(v1.screen, v1.config.primary)
    local v3 = u222[v1.screen] or 0
    if v1.screen ~= a1 or v3 ~= a3 then
        GuiService.SelectedObject = v2 or v1.button
    else
        local SelectedObject = GuiService.SelectedObject
        if not SelectedObject
            or not SelectedObject:IsA("GuiObject")
            or not SelectedObject:IsDescendantOf(v1.screen)
            or not SelectedObject.Selectable
            or not isVisible(SelectedObject, v1.screen)
            or v2 and v2 ~= a2 then
            GuiService.SelectedObject = v2 or v1.button
        end
    end
    return v1.screen, v2, v3
end

local Value = Enum.ContextActionPriority.High.Value
local ButtonB = Enum.KeyCode.ButtonB
ContextActionService:BindActionAtPriority("ConsoleModalBack", function(a1, a2) -- Line: 364
    -- upvalues: UserInputService (val), GuiService (val), findModal (val), findButton (val), ConsoleModalBack (ref)
    if a2 == Enum.UserInputState.Begin then
        local GamepadEnabled = UserInputService.GamepadEnabled or GuiService:IsTenFootInterface()
        if GamepadEnabled then
            local v1 = findModal()
            if not v1 then
                return Enum.ContextActionResult.Pass
            end
            if not findButton(v1.screen, v1.config.back) then
                return Enum.ContextActionResult.Sink
            end
            local v2 = (tostring(v1.screen.Name)) .. "BackHandlerReady"
            if ConsoleModalBack:GetAttribute(v2) == true then
                ConsoleModalBack:Fire(v1.screen.Name)
                return Enum.ContextActionResult.Sink
            end
            v1.screen.Enabled = false
            local SelectedObject = GuiService.SelectedObject
            if SelectedObject and SelectedObject:IsDescendantOf(v1.screen) then
                GuiService.SelectedObject = nil
            end
            return Enum.ContextActionResult.Sink
        end
    end
    return Enum.ContextActionResult.Pass
end, false, Value, ButtonB)
local u266 = nil
local u267 = nil
local u268 = nil
task.spawn(function() -- Line: 398 -- upvalues: PlayerGui (val), u266 (ref), u267 (ref), u268 (ref), refreshSelection (val)
    local v1, v2, v3
    while PlayerGui.Parent do
        v1, v2, v3 = refreshSelection(u266, u267, u268)
        u266 = v1
        u267 = v2
        u268 = v3
        task.wait(0.1)
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.DeathUIClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.DeathUIClient
-- Decompile time: 17.42 ms

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local DeathUI = PlayerGui:WaitForChild("DeathUI")
local Frame = DeathUI:WaitForChild("Frame")
local DayText = Frame:WaitForChild("DayText")
local FishSlainCounter = Frame:WaitForChild("FishSlainCounter")
local LeaderBoardPosition = Frame:WaitForChild("LeaderBoardPosition")
local RespawnCountdown = Frame:WaitForChild("RespawnCountdown")
local RobuxRespawnButton = Frame:WaitForChild("RobuxRespawnButton")
local TextLabel = RobuxRespawnButton:WaitForChild("TextLabel")
local ClaimScalesButton = Frame:WaitForChild("ClaimScalesButton")

local function currentPackage() -- Line: 24 -- upvalues: ReplicatedStorage (val)
    local FishGame = ReplicatedStorage:WaitForChild("FishGame")
    assert(FishGame:IsA("Folder"), "ReplicatedStorage.FishGame must be a Folder")
    return FishGame
end

local FishGame = ReplicatedStorage:WaitForChild("FishGame")
assert(FishGame:IsA("Folder"), "ReplicatedStorage.FishGame must be a Folder")
local Config = require(FishGame:WaitForChild("Config"))
local Remotes = FishGame:WaitForChild("Remotes")
local DeathState = Remotes:WaitForChild("DeathState")
local RespawnAction = Remotes:WaitForChild("RespawnAction")
DeathUI.Enabled = false
local u112 = 0
local u113 = false
local u114 = false
local u115 = false
local PlayerDeathGrayscale = Lighting:FindFirstChild("PlayerDeathGrayscale")
if PlayerDeathGrayscale and not PlayerDeathGrayscale:IsA("ColorCorrectionEffect") then
    PlayerDeathGrayscale:Destroy()
    PlayerDeathGrayscale = nil
end
local u133 = PlayerDeathGrayscale
if u133 == nil then
    u133 = Instance.new("ColorCorrectionEffect")
    u133.Name = "PlayerDeathGrayscale"
    u133.Enabled = false
    u133.Saturation = 0
    u133.Contrast = 0
    u133.Parent = Lighting
end

local function setDeathGrayscale(a1) -- Line: 57
    -- upvalues: u133 (ref), TweenService (val), u113 (ref)
    local u1 = u133
    u1.Enabled = true
    TweenService:Create(
        u1,
        TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Saturation = if not a1 then 0 else -1, Contrast = if not a1 then 0 else 0.12}
    ):Play()
    if not a1 then
        task.delay(0.24, function() -- Line: 69 -- upvalues: u113 (upval), u1 (val)
            if not u113 and u1.Parent then
                u1.Enabled = false
            end
        end)
    end
end

local function commas(a1) -- Line: 75 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.max(0, (math.floor(a1)))))
    repeat
        v1, v2 = v3:gsub("^(%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function clearViewmodel() -- Line: 84 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    local FishGameViewmodel = CurrentCamera and CurrentCamera:FindFirstChild("FishGameViewmodel")
    if FishGameViewmodel then
        FishGameViewmodel:Destroy()
    end
end

local function closeOtherScreens() -- Line: 90 -- upvalues: PlayerGui (val), LocalPlayer (val)
    local UpgradeShop = PlayerGui:FindFirstChild("UpgradeShop")
    if UpgradeShop and UpgradeShop:IsA("ScreenGui") then
        UpgradeShop.Enabled = false
    end
    LocalPlayer:SetAttribute("FishResearchOpen", false)
end

local function setDeathControls(a1) -- Line: 96
    -- upvalues: RunService (val), u113 (ref), LocalPlayer (val), UserInputService (val)
    RunService:UnbindFromRenderStep("DeathUICursorControl")
    if not a1 then
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        UserInputService.MouseIconEnabled = false
        return
    end
    if u113 then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    end
    RunService:BindToRenderStep("DeathUICursorControl", Enum.RenderPriority.Camera.Value + 20, function() -- Line: 99 -- upvalues: u113 (upval), LocalPlayer (upval), UserInputService (upval)
        if not u113 then
            return
        end
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    end)
end

local function playDeathSound() -- Line: 120 -- upvalues: Config (val), SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = "PlayerDeathLocal"
    Sound.SoundId = Config.Death.SoundId
    Sound.Volume = Config.Death.SoundVolume
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Sound.Ended:Once(function() -- Line: 127 -- upvalues: Sound (val)
        Sound:Destroy()
    end)
    task.delay(10, function() -- Line: 128 -- upvalues: Sound (val)
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
end

local function showDeathImmediately() -- Line: 131
    -- upvalues: u113 (ref), u112 (ref), Workspace (val), Config (val), LocalPlayer (val), PlayerGui (val)
    -- upvalues: RunService (val), UserInputService (val), DayText (val), FishSlainCounter (val)
    -- upvalues: LeaderBoardPosition (val), RespawnCountdown (val), TextLabel (val), DeathUI (val), u133 (ref)
    -- upvalues: TweenService (val), playDeathSound (val)
    if u113 then
        return
    end
    u113 = true
    u112 = (Workspace:GetServerTimeNow()) + Config.Death.RespawnWindow
    LocalPlayer:SetAttribute("FishLocalDead", true)
    local CurrentCamera = Workspace.CurrentCamera
    local FishGameViewmodel = CurrentCamera and CurrentCamera:FindFirstChild("FishGameViewmodel")
    if FishGameViewmodel then
        FishGameViewmodel:Destroy()
    end
    local UpgradeShop = PlayerGui:FindFirstChild("UpgradeShop")
    if UpgradeShop and UpgradeShop:IsA("ScreenGui") then
        UpgradeShop.Enabled = false
    end
    LocalPlayer:SetAttribute("FishResearchOpen", false)
    RunService:UnbindFromRenderStep("DeathUICursorControl")
    if u113 then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    end
    RunService:BindToRenderStep("DeathUICursorControl", Enum.RenderPriority.Camera.Value + 20, function() -- Line: 99 -- upvalues: u113 (upval), LocalPlayer (upval), UserInputService (upval)
        if not u113 then
            return
        end
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    end)
    DayText.Text = "Day " .. tostring((math.max(1, (math.floor((tonumber((Workspace:GetAttribute("FishDay")))) or 1)))))
    FishSlainCounter.Text = "-- Fish slain"
    LeaderBoardPosition.Text = "Leaderboard position: --"
    RespawnCountdown.Text = tostring(Config.Death.RespawnWindow)
    TextLabel.Text = "Respawn"
    DeathUI.Enabled = true
    local v1 = u133
    v1.Enabled = true
    TweenService:Create(v1, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Saturation = -1, Contrast = 0.12}):Play()
    playDeathSound()
end

local function connectCharacter(a1) -- Line: 149
    -- upvalues: u113 (ref), u112 (ref), LocalPlayer (val), DeathUI (val), setDeathGrayscale (val), RunService (val)
    -- upvalues: UserInputService (val), showDeathImmediately (val)
    local v1
    u113 = false
    u112 = 0
    LocalPlayer:SetAttribute("FishLocalDead", false)
    DeathUI.Enabled = false
    setDeathGrayscale(false)
    RunService:UnbindFromRenderStep("DeathUICursorControl")
    LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    UserInputService.MouseIconEnabled = false

    local function silenceDefaultDeathSound(a1) -- Line: 156 -- types: a1: userdata
        if not a1:IsA("Sound") then
            return
        end
        local v1 = string.lower(a1.Name)
        if v1 == "died" or v1 == "death" then
            a1.Volume = 0
        end
    end

    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("Sound") then
            v1 = string.lower(v.Name)
            if v1 == "died" or v1 == "death" then
                v.Volume = 0
            end
        end
    end
    a1.DescendantAdded:Connect(silenceDefaultDeathSound)
    local Humanoid = a1:WaitForChild("Humanoid", 10)
    if Humanoid and Humanoid:IsA("Humanoid") then
        Humanoid.Died:Connect(function() -- Line: 165 -- upvalues: a1 (val), LocalPlayer (upval), Humanoid (val), showDeathImmediately (upval)
            if a1 == LocalPlayer.Character and Humanoid.Health <= 0 then
                showDeathImmediately()
            end
        end)
        Humanoid.HealthChanged:Connect(function(a1_2) -- Line: 171
            -- upvalues: a1 (val), LocalPlayer (upval), Humanoid (val), showDeathImmediately (upval)
            if a1 == LocalPlayer.Character and Humanoid.Health <= 0 then
                showDeathImmediately()
            end
        end)
        if a1 == LocalPlayer.Character and Humanoid.Health <= 0 then
            showDeathImmediately()
        end
    end
end

DeathState.OnClientEvent:Connect(function(a1) -- Line: 178
    -- upvalues: showDeathImmediately (val), u112 (ref), DayText (val), FishSlainCounter (val), commas (val)
    -- upvalues: LeaderBoardPosition (val), TextLabel (val), LocalPlayer (val), u113 (ref), DeathUI (val)
    -- upvalues: setDeathGrayscale (val), RunService (val), UserInputService (val)
    if typeof(a1) ~= "table" then
        return
    end
    if a1.Dead == true then
        showDeathImmediately()
        u112 = tonumber(a1.Deadline) or u112
        DayText.Text = "Day " .. tostring((math.max(1, (math.floor((tonumber(a1.Day)) or 1)))))
        FishSlainCounter.Text = (commas(tonumber(a1.FishSlain) or 0)) .. " Fish slain"
        local v1 = math.floor((tonumber(a1.LeaderboardPosition)) or 0)
        LeaderBoardPosition.Text = if not (v1 > 0) then "Leaderboard position: --" else "Leaderboard position: " .. commas(v1)
        TextLabel.Text = "Respawn"
        return
    end
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if LocalPlayer:GetAttribute("FishDead") == true then
        showDeathImmediately()
        return
    end
    if Humanoid and Humanoid.Health <= 0 then
        showDeathImmediately()
        return
    end
    u113 = false
    u112 = 0
    DeathUI.Enabled = false
    setDeathGrayscale(false)
    RunService:UnbindFromRenderStep("DeathUICursorControl")
    LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    UserInputService.MouseIconEnabled = false
end)
;(LocalPlayer:GetAttributeChangedSignal("FishDead")):Connect(function() -- Line: 205 -- upvalues: LocalPlayer (val), showDeathImmediately (val)
    if LocalPlayer:GetAttribute("FishDead") == true then
        showDeathImmediately()
    end
end)
RobuxRespawnButton.Activated:Connect(function() -- Line: 211 -- upvalues: u113 (ref), u114 (ref), RespawnAction (val)
    if u113 and not u114 then
        u114 = true
        RespawnAction:FireServer("Purchase")
        task.delay(1, function() -- Line: 215 -- upvalues: u114 (upval)
            u114 = false
        end)
        return
    end
end)
ClaimScalesButton.Activated:Connect(function() -- Line: 218 -- upvalues: u113 (ref), u115 (ref), RespawnAction (val)
    if u113 and not u115 then
        u115 = true
        RespawnAction:FireServer("ReturnToLobby")
        task.delay(3, function() -- Line: 222 -- upvalues: u115 (upval)
            u115 = false
        end)
        return
    end
end)
LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 225 -- upvalues: connectCharacter (val)
    task.spawn(connectCharacter, a1)
end)
if LocalPlayer.Character then
    task.spawn(connectCharacter, LocalPlayer.Character)
end
task.spawn(function() -- Line: 228
    -- upvalues: u113 (ref), u112 (ref), Workspace (val), RespawnCountdown (val), UserInputService (val)
    while true do
        task.wait(0.1)
        if u113 then
            RespawnCountdown.Text = tostring((math.max(0, (math.ceil(u112 - (Workspace:GetServerTimeNow()))))))
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            UserInputService.MouseIconEnabled = true
        end
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.DogVisualClient
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.DogVisualClient
-- Decompile time: 8.55 ms

local v1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ActiveFish = Workspace:WaitForChild("ActiveFish")
local DownedFish = Workspace:WaitForChild("DownedFish")
local u23 = {}
local DogSpot = Workspace:WaitForChild("DogSpot")
local DogSpot2 = Workspace:WaitForChild("DogSpot2")
u23[1] = DogSpot
u23[2] = DogSpot2
u23[3] = Workspace:WaitForChild("DogSpot3")
local u134 = {}
local u144 = RaycastParams.new()
u144.FilterType = Enum.RaycastFilterType.Exclude
u144.IgnoreWater = true
u144.RespectCanCollide = true

local function refreshGroundExclusions() -- Line: 20
    -- upvalues: ActiveFish (val), DownedFish (val), u23 (val), u134 (val), Players (val), u144 (val)
    local v1 = {ActiveFish, DownedFish}
    for i, v in ipairs(u23) do
        table.insert(v1, v)
    end
    for k in pairs(u134) do
        table.insert(v1, k)
    end
    for i2, i3 in ipairs(Players:GetPlayers()) do
        if i3.Character then
            table.insert(v1, i3.Character)
        end
    end
    u144.FilterDescendantsInstances = v1
end

local function isDogModel(a1) -- Line: 30 -- types: a1: userdata
    local v1 = a1:IsA("Model")
    if v1 then
        v1 = true
        if a1.Name ~= "Dog" then
            v1 = true
            if a1.Name ~= "Dog2" then
                v1 = a1.Name == "Dog3"
            end
        end
    end
    return v1
end

local function trackDog(a1) -- Line: 34 -- upvalues: u134 (val), refreshGroundExclusions (val) -- types: a1: userdata
    local v1 = a1:IsA("Model")
    if v1 then
        v1 = true
        if a1.Name ~= "Dog" then
            v1 = true
            if a1.Name ~= "Dog2" then
                v1 = a1.Name == "Dog3"
            end
        end
    end
    if v1 and not u134[a1] then
        u134[a1] = true
        refreshGroundExclusions()
        return
    end
end

for i, v in ipairs(Workspace:GetChildren()) do
    v1 = v:IsA("Model")
    if v1 then
        v1 = true
        if v.Name ~= "Dog" then
            v1 = true
            if v.Name ~= "Dog2" then
                v1 = v.Name == "Dog3"
            end
        end
    end
    if v1 and not u134[v] then
        u134[v] = true
        refreshGroundExclusions()
    end
end
Workspace.ChildAdded:Connect(trackDog)
Workspace.ChildRemoved:Connect(function(a1) -- Line: 42 -- upvalues: u134 (val), refreshGroundExclusions (val)
    if a1:IsA("Model") and u134[a1] then
        u134[a1] = nil
        refreshGroundExclusions()
    end
end)

local function watchPlayer(a1) -- Line: 49 -- upvalues: refreshGroundExclusions (val) -- types: a1: userdata
    a1.CharacterAdded:Connect(function() -- Line: 50 -- upvalues: refreshGroundExclusions (upval)
        refreshGroundExclusions()
    end)
    a1.CharacterRemoving:Connect(function() -- Line: 51 -- upvalues: refreshGroundExclusions (upval)
        refreshGroundExclusions()
    end)
end

for i2, i3 in ipairs(Players:GetPlayers()) do
    watchPlayer(i3)
end
Players.PlayerAdded:Connect(function(a1) -- Line: 55 -- upvalues: watchPlayer (val), refreshGroundExclusions (val)
    watchPlayer(a1)
    refreshGroundExclusions()
end)
Players.PlayerRemoving:Connect(function() -- Line: 59 -- upvalues: refreshGroundExclusions (val)
    refreshGroundExclusions()
end)
refreshGroundExclusions()

local function groundedDogPosition(a1, a2) -- Line: 62
    -- upvalues: Workspace (val), u144 (val)
    local v1 = Workspace:Raycast(Vector3.new(a2.X, a2.Y + 100, a2.Z), Vector3.new(0, -300, 0), u144)
    if not v1 then
        return a2
    end
    local Attribute = a1:GetAttribute("DogGroundOffset")
    return (Vector3.new(a2.X, v1.Position.Y + (if typeof(Attribute) ~= "number" then 0 else Attribute), a2.Z))
end

RunService:BindToRenderStep("SmoothDogMotion", Enum.RenderPriority.Camera.Value + 18, function() -- Line: 77 -- upvalues: u134 (val), Workspace (val), groundedDogPosition (val)
    local Attribute, Attribute_2, Attribute_3, Attribute_4, Position, v1, v2, v3
    for k in pairs(u134) do
        if k.Parent and k:GetAttribute("DogState") == "Running" then
            Attribute = k:GetAttribute("DogMotionStart")
            Attribute_2 = k:GetAttribute("DogMotionFinish")
            Attribute_3 = k:GetAttribute("DogMotionStartedAt")
            Attribute_4 = k:GetAttribute("DogMotionDuration")
            if typeof(Attribute) == "CFrame"
                and typeof(Attribute_2) == "CFrame"
                and typeof(Attribute_3) == "number"
                and typeof(Attribute_4) == "number"
                and Attribute_4 > 0 then
                v1 = Attribute:Lerp(Attribute_2, (math.clamp((Workspace:GetServerTimeNow() - Attribute_3) / Attribute_4, 0, 1)))
                v2 = groundedDogPosition
                Position = v1.Position
                v2 = v2(k, Position)
                v3 = (CFrame.new(v2)) * v1.Rotation
                k:PivotTo(v3)
            end
        end
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.EquippedPetFollowerClient
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.EquippedPetFollowerClient
-- Decompile time: 27.02 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local FishGame = ReplicatedStorage:FindFirstChild("FishGame")
local PetAbilities_2 = FishGame and FishGame:FindFirstChild("PetAbilities") or ReplicatedStorage:WaitForChild("PetAbilities")
local u34 = require(PetAbilities_2)
local PetMotion = require((ReplicatedStorage:WaitForChild("PetMotion")))
local u43 = Random.new()
local u44 = {
    BounceHeightStuds = 0.58,
    BounceHz = 2.25,
    SwayStuds = 0.22,
    SwayHz = 1.25,
    LeanDegrees = 7,
    BankDegrees = 5,
    IdleBobStuds = 0.1,
    IdleBobHz = 0.7,
}
local u45 = {}
local Folder = Instance.new("Folder")
Folder.Name = "ClientPetFollowers"
Folder.Parent = Workspace

local function createFootstepSound(a1) -- Line: 44 -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    if not PrimaryPart then
        return
    end
    local Sound = Instance.new("Sound")
    Sound.Name = "EquippedPetFootstep"
    Sound.SoundId = "rbxassetid://15675081158"
    Sound.Volume = 0.2
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.RollOffMinDistance = 4
    Sound.RollOffMaxDistance = 55
    Sound.Parent = PrimaryPart
end

local function playFootstep(a1) -- Line: 57 -- upvalues: u43 (val) -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    local EquippedPetFootstep = PrimaryPart and PrimaryPart:FindFirstChild("EquippedPetFootstep")
    if EquippedPetFootstep and EquippedPetFootstep:IsA("Sound") then
        EquippedPetFootstep.PlaybackSpeed = u43:NextNumber(0.86, 1.14)
        EquippedPetFootstep.TimePosition = 0
        EquippedPetFootstep:Play()
        return
    end
end

local function rootPart(a1) -- Line: 66 -- types: a1: userdata
    local Character = a1.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function findTemplate(a1) -- Line: 72 -- upvalues: ReplicatedStorage (val) -- types: a1: string
    local DynamicLobbyPets, PetSystem, Pets, v1, v2
    for i = 1, 20 do
        PetSystem = ReplicatedStorage:FindFirstChild("PetSystem")
        Pets = PetSystem and PetSystem:FindFirstChild("Pets")
        v1 = Pets and Pets:FindFirstChild(a1, true)
        if v1 and v1:IsA("Model") then
            return v1
        end
        DynamicLobbyPets = ReplicatedStorage:FindFirstChild("DynamicLobbyPets")
        v2 = DynamicLobbyPets and DynamicLobbyPets:FindFirstChild(a1)
        if v2 and v2:IsA("Model") then
            return v2
        end
        if i < 20 then
            task.wait(0.25)
        end
    end
    warn("[EquippedPetFollowerClient] Missing model template for equipped pet " .. a1)
    return nil
end

local function prepareFollower(a1, a2) -- Line: 89
    -- upvalues: u34 (val), PetMotion (val)
    local v1 = math.max((a1:GetExtentsSize()).X, (a1:GetExtentsSize()).Y, (a1:GetExtentsSize()).Z)
    if v1 > 0 then
        local v2 = u34.SizeMultiplier(a2)
        a1:ScaleTo((a1:GetScale()) * (math.min(0.65, 4.2 / v1)) * v2)
    end
    local v3 = a1
    for i, j in a1:GetDescendants() do
        if j:IsA("BaseScript") or j:IsA("BillboardGui") or j:IsA("ProximityPrompt") then
            j:Destroy()
        end
    end
    PetMotion.PrepareModel(v3)
    for k, n in v3:GetDescendants() do
        if n:IsA("BasePart") then
            n.CanCollide = false
            n.CanTouch = false
            n.CanQuery = false
        end
    end
    local BoundingBox, BoundingBox_2 = v3:GetBoundingBox()
    return (math.max(0, (v3:GetPivot()).Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y * 0.5)))
end

local function groundAt(a1, a2, a3, a4) -- Line: 114
    -- upvalues: Folder (val), Workspace (val)
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    local v2 = {a4, Folder}
    if a1.Character then
        table.insert(v2, a1.Character)
    end
    v1.FilterDescendantsInstances = v2
    local v3 = Workspace:Raycast(a2 + Vector3.new(0, 24, 0), Vector3.new(0, -70, 0), v1)
    if v3 then
        return v3.Position + v3.Normal * a3
    end
    return a2
end

local function stopFollower(a1) -- Line: 124 -- types: a1: table
    a1.Serial = a1.Serial + 1
    if a1.Model and a1.Model.Parent then
        a1.Model:Destroy()
    end
    a1.Model = nil
    a1.PetId = nil
end

local function startFollower(a1, a2) -- Line: 131
    -- upvalues: u45 (val), findTemplate (val), prepareFollower (val), groundAt (val), Folder (val), Players (val)
    -- upvalues: PetMotion (val), u44 (val), playFootstep (val)
    local u3 = u45[a1]
    if not u3 then
        return
    end
    u3.Serial = u3.Serial + 1
    if u3.Model and u3.Model.Parent then
        u3.Model:Destroy()
    end
    u3.Model = nil
    u3.PetId = nil
    u3.PetId = a2
    local Serial = u3.Serial
    task.spawn(function() -- Line: 138
        -- upvalues: findTemplate (upval), a2 (val), u45 (upval), a1 (val), u3 (val), Serial (val)
        -- upvalues: prepareFollower (upval), groundAt (upval), Folder (upval), Players (upval), PetMotion (upval)
        -- upvalues: u44 (upval), playFootstep (upval)
        local v1 = findTemplate(a2)
        if v1 and u45[a1] == u3 and u3.Serial == Serial and (a1:GetAttribute("EquippedPet")) == a2 then
            local u18 = v1:Clone()
            u18.Name = string.format("EquippedPet_%d_%s", a1.UserId, a2)
            u18:SetAttribute("PetOwnerUserId", a1.UserId)
            u18:SetAttribute("PetId", a2)
            local u39 = prepareFollower(u18, a2)
            local Character = a1.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local v2 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            if not v2 then
                local Character_2 = a1.Character
                local HumanoidRootPart_2 = Character_2 and Character_2:WaitForChild("HumanoidRootPart", 5)
                v2 = if not HumanoidRootPart_2 then nil else if not HumanoidRootPart_2:IsA("BasePart") then nil else HumanoidRootPart_2
            end
            if v2 and u45[a1] == u3 and u3.Serial == Serial and (a1:GetAttribute("EquippedPet")) == a2 then
                if a1.UserId % 2 ~= 0 then end
                local v3 = v2.CFrame:PointToWorldSpace((Vector3.new(0, 0, 5)))
                u18:PivotTo((CFrame.new((groundAt(a1, v3, u39, u18)))))
                u18.Parent = Folder
                local PrimaryPart = u18.PrimaryPart
                if PrimaryPart then
                    local Sound = Instance.new("Sound")
                    Sound.Name = "EquippedPetFootstep"
                    Sound.SoundId = "rbxassetid://15675081158"
                    Sound.Volume = 0.2
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
                    Sound.RollOffMinDistance = 4
                    Sound.RollOffMaxDistance = 55
                    Sound.Parent = PrimaryPart
                end
                u3.Model = u18
                local FollowTarget = PetMotion.FollowTarget
                local v4 = {
                    BaseSpeed = 9.45,
                    CatchUpSpeedPerStud = 0.35,
                    MaxSpeed = 19.6,
                    Responsiveness = 9,
                    StartDistance = 0.45,
                    StopDistance = 0.22,
                    IdleTurnDelay = 0.18,
                    TeleportDistance = 500,
                    JumpHeightStuds = 5.2,
                    Tuning = u44,
                    ShouldContinue = function() -- Line: 173
                        -- upvalues: u45 (upval), a1 (upval), u3 (upval), u18 (val), Serial (upval), Players (upval)
                        -- upvalues: a2 (upval)
                        local v1 = false
                        if u45[a1] == u3 then
                            v1 = false
                            if u3.Model == u18 then
                                v1 = false
                                if u3.Serial == Serial then
                                    v1 = false
                                    if u18.Parent ~= nil then
                                        v1 = false
                                        if a1.Parent == Players then
                                            v1 = (a1:GetAttribute("EquippedPet")) == a2
                                        end
                                    end
                                end
                            end
                        end
                        return v1
                    end,
                    OnGroundContact = function() -- Line: 199 -- upvalues: playFootstep (upval), u18 (val)
                        playFootstep(u18)
                    end,
                }
                FollowTarget(u18, function() -- Line: 182 -- upvalues: a1 (upval), groundAt (upval), u39 (val), u18 (val)
                    local v1
                    local Character = a1.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if not (if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) then
                        return nil, nil
                    end
                    local v2 = v1.CFrame:PointToWorldSpace((Vector3.new(0, 0, 5)))
                    return (groundAt(a1, v2, u39, u18)), v1.Position
                end, v4)
                if u18.Parent then
                    u18:Destroy()
                end
                if u3.Model == u18 then
                    u3.Model = nil
                end
                return
            end
            u18:Destroy()
            return
        end
    end)
end

local function applyEquippedPet(a1) -- Line: 206
    -- upvalues: u45 (val), u34 (val), findTemplate (val), prepareFollower (val), groundAt (val), Folder (val)
    -- upvalues: Players (val), PetMotion (val), u44 (val), playFootstep (val)
    local v1 = u45[a1]
    if not v1 then
        return
    end
    local Attribute = a1:GetAttribute("EquippedPet")
    if not u34.IsValid(Attribute) then
        v1.Serial = v1.Serial + 1
        if v1.Model and v1.Model.Parent then
            v1.Model:Destroy()
        end
        v1.Model = nil
        v1.PetId = nil
        return
    end
    if v1.PetId == Attribute and v1.Model and v1.Model.Parent then
        return
    end
    local u17 = u45[a1]
    if not u17 then
        return
    end
    u17.Serial = u17.Serial + 1
    if u17.Model and u17.Model.Parent then
        u17.Model:Destroy()
    end
    u17.Model = nil
    u17.PetId = nil
    u17.PetId = Attribute
    local Serial = u17.Serial
    task.spawn(function() -- Line: 138
        -- upvalues: findTemplate (upval), Attribute (val), u45 (upval), a1 (val), u17 (val), Serial (val)
        -- upvalues: prepareFollower (upval), groundAt (upval), Folder (upval), Players (upval), PetMotion (upval)
        -- upvalues: u44 (upval), playFootstep (upval)
        local v1 = findTemplate(Attribute)
        if v1 and u45[a1] == u17 and u17.Serial == Serial and (a1:GetAttribute("EquippedPet")) == Attribute then
            local u18 = v1:Clone()
            u18.Name = string.format("EquippedPet_%d_%s", a1.UserId, Attribute)
            u18:SetAttribute("PetOwnerUserId", a1.UserId)
            u18:SetAttribute("PetId", Attribute)
            local u39 = prepareFollower(u18, Attribute)
            local Character = a1.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local v2 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            if not v2 then
                local Character_2 = a1.Character
                local HumanoidRootPart_2 = Character_2 and Character_2:WaitForChild("HumanoidRootPart", 5)
                v2 = if not HumanoidRootPart_2 then nil else if not HumanoidRootPart_2:IsA("BasePart") then nil else HumanoidRootPart_2
            end
            if v2 and u45[a1] == u17 and u17.Serial == Serial and (a1:GetAttribute("EquippedPet")) == Attribute then
                if a1.UserId % 2 ~= 0 then end
                local v3 = v2.CFrame:PointToWorldSpace((Vector3.new(0, 0, 5)))
                u18:PivotTo((CFrame.new((groundAt(a1, v3, u39, u18)))))
                u18.Parent = Folder
                local PrimaryPart = u18.PrimaryPart
                if PrimaryPart then
                    local Sound = Instance.new("Sound")
                    Sound.Name = "EquippedPetFootstep"
                    Sound.SoundId = "rbxassetid://15675081158"
                    Sound.Volume = 0.2
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
                    Sound.RollOffMinDistance = 4
                    Sound.RollOffMaxDistance = 55
                    Sound.Parent = PrimaryPart
                end
                u17.Model = u18
                local FollowTarget = PetMotion.FollowTarget
                local v4 = {
                    BaseSpeed = 9.45,
                    CatchUpSpeedPerStud = 0.35,
                    MaxSpeed = 19.6,
                    Responsiveness = 9,
                    StartDistance = 0.45,
                    StopDistance = 0.22,
                    IdleTurnDelay = 0.18,
                    TeleportDistance = 500,
                    JumpHeightStuds = 5.2,
                    Tuning = u44,
                    ShouldContinue = function() -- Line: 173
                        -- upvalues: u45 (upval), a1 (upval), u17 (upval), u18 (val), Serial (upval), Players (upval)
                        -- upvalues: Attribute (upval)
                        local v1 = false
                        if u45[a1] == u17 then
                            v1 = false
                            if u17.Model == u18 then
                                v1 = false
                                if u17.Serial == Serial then
                                    v1 = false
                                    if u18.Parent ~= nil then
                                        v1 = false
                                        if a1.Parent == Players then
                                            v1 = (a1:GetAttribute("EquippedPet")) == Attribute
                                        end
                                    end
                                end
                            end
                        end
                        return v1
                    end,
                    OnGroundContact = function() -- Line: 199 -- upvalues: playFootstep (upval), u18 (val)
                        playFootstep(u18)
                    end,
                }
                FollowTarget(u18, function() -- Line: 182 -- upvalues: a1 (upval), groundAt (upval), u39 (val), u18 (val)
                    local v1
                    local Character = a1.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if not (if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) then
                        return nil, nil
                    end
                    local v2 = v1.CFrame:PointToWorldSpace((Vector3.new(0, 0, 5)))
                    return (groundAt(a1, v2, u39, u18)), v1.Position
                end, v4)
                if u18.Parent then
                    u18:Destroy()
                end
                if u17.Model == u18 then
                    u17.Model = nil
                end
                return
            end
            u18:Destroy()
            return
        end
    end)
end

local function trackPlayer(a1) -- Line: 220 -- upvalues: u45 (val), applyEquippedPet (val) -- types: a1: userdata
    if u45[a1] then
        return
    end
    local u3 = {Serial = 0}
    u45[a1] = u3
    u3.AttributeConnection = (a1:GetAttributeChangedSignal("EquippedPet")):Connect(function() -- Line: 230 -- upvalues: applyEquippedPet (upval), a1 (val)
        applyEquippedPet(a1)
    end)
    u3.CharacterConnection = a1.CharacterAdded:Connect(function() -- Line: 233 -- upvalues: u45 (upval), a1 (val), u3 (val), applyEquippedPet (upval)
        task.delay(0.75, function() -- Line: 234 -- upvalues: u45 (upval), a1 (upval), u3 (upval), applyEquippedPet (upval)
            if u45[a1] == u3 then
                applyEquippedPet(a1)
            end
        end)
    end)
    task.defer(applyEquippedPet, a1)
end

Players.PlayerAdded:Connect(trackPlayer)
Players.PlayerRemoving:Connect(function(a1) -- Line: 241 -- upvalues: u45 (val) -- types: a1: userdata
    local v1 = u45[a1]
    if not v1 then
        return
    end
    v1.Serial = v1.Serial + 1
    if v1.Model and v1.Model.Parent then
        v1.Model:Destroy()
    end
    v1.Model = nil
    v1.PetId = nil
    if v1.AttributeConnection then
        v1.AttributeConnection:Disconnect()
    end
    if v1.CharacterConnection then
        v1.CharacterConnection:Disconnect()
    end
    u45[a1] = nil
end)
for i, j in Players:GetPlayers() do
    trackPlayer(j)
end
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.FishGameClient
-- Took 0.29s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.FishGameClient
-- Decompile time: 294.31 ms

local rebuildOrdnance
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local v1 = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local u51 = 0

local function hasVisiblePrompt() -- Line: 17 -- upvalues: u51 (ref)
    return u51 > 0
end

v1.PromptShown:Connect(function() -- Line: 21 -- upvalues: u51 (ref)
    u51 = u51 + 1
end)
v1.PromptHidden:Connect(function() -- Line: 24 -- upvalues: u51 (ref)
    u51 = math.max(0, u51 - 1)
end)
LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

local function v2() -- Line: 29 -- upvalues: ReplicatedStorage (val)
    local FishGame = ReplicatedStorage:WaitForChild("FishGame")
    assert(FishGame:IsA("Folder"), "ReplicatedStorage.FishGame must be a Folder")
    return FishGame
end

local FishGame = ReplicatedStorage:WaitForChild("FishGame")
assert(FishGame:IsA("Folder"), "ReplicatedStorage.FishGame must be a Folder")
local Config = require(FishGame:WaitForChild("Config"))
local ExclusiveWeaponEffects = require(ReplicatedStorage:WaitForChild("ExclusiveWeaponEffects"))

local function v3(a1, a2) -- Line: 37 -- upvalues: SoundService (val) -- types: a1: string, a2: string
    local v1 = SoundService:FindFirstChild(a1)
    if v1 and not v1:IsA("Sound") then
        v1:Destroy()
        v1 = nil
    end
    local v2 = v1
    if not v2 then
        v2 = Instance.new("Sound")
        v2.Name = a1
        v2.Parent = SoundService
    end
    v2.SoundId = a2
    v2.Looped = true
    return v2
end

local u93 = v3("BackgroundMusic", Config.Music.DaySoundId)
local u98 = v3("BossMusic", Config.Music.BossSoundId)
local u103 = v3("VictoryMusic", Config.Victory.MusicSoundId)
local u108 = v3("DayBirdAmbience", Config.Ambience.BirdSoundId)
local u113 = v3("NightAmbience", Config.Ambience.NightSoundId)
local u118 = v3("RiverAmbience", Config.Ambience.RiverSoundId)
u93.Volume = Config.Music.DayVolume
u98.Volume = 0
u103.Volume = 0
u108.Volume = Config.Ambience.BirdVolume
u113.Volume = 0
u118.Volume = 0
if not u93.IsPlaying then
    u93:Play()
end
if u98.IsPlaying then
    u98:Stop()
end
if u103.IsPlaying then
    u103:Stop()
end
if not u108.IsPlaying then
    u108:Play()
end
if not u113.IsPlaying then
    u113:Play()
end
if not u118.IsPlaying then
    u118:Play()
end
local ValidBossArea = Workspace:WaitForChild("ValidBossArea")
local v4 = ValidBossArea:FindFirstChild("RiverAmbience")
if v4 and v4:IsA("Sound") then
    v4:Destroy()
end

local function distanceFromRiverArea(a1) -- Line: 79 -- upvalues: ValidBossArea (val) -- types: a1: vector
    local v1 = ValidBossArea.CFrame:PointToObjectSpace(a1)
    local v2 = ValidBossArea.Size * 0.5
    return (v1 - Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))).Magnitude
end

RunService.Heartbeat:Connect(function(a1) -- Line: 90
    -- upvalues: Workspace (val), distanceFromRiverArea (val), Config (val), u118 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if not CurrentCamera then
        return
    end
    local v1 = distanceFromRiverArea(CurrentCamera.CFrame.Position)
    local RiverFullVolumeDistance = Config.Ambience.RiverFullVolumeDistance
    local v2 = math.max(RiverFullVolumeDistance + 1, Config.Ambience.RiverFadeDistance)
    local v3 = Config.Ambience.RiverVolume * (1 - (math.clamp((v1 - RiverFullVolumeDistance) / (v2 - RiverFullVolumeDistance), 0, 1))) ^ 2
    local v4 = 1 - math.exp(-a1 * 5)
    local v5 = u118
    v5.Volume = v5.Volume + (v3 - u118.Volume) * v4
end)
local u211 = nil
local u212 = nil
local u213 = nil
local u214 = nil
local u215 = nil
local u216 = ""
local u217 = 0

local function tweenMusic(a1, a2, a3, a4) -- Line: 110
    -- upvalues: u212 (ref), u211 (ref), TweenService (val)
    local v1 = if not a4 then u211 else u212
    if v1 then
        v1:Cancel()
    end
    if a2 > 0 and not a1.IsPlaying then
        a1:Play()
    end
    local u37 = TweenService:Create(a1, TweenInfo.new(math.max(0.05, a3), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Volume = a2})
    if not a4 then
        u211 = u37
    else
        u212 = u37
    end
    u37.Completed:Once(function() -- Line: 120 -- upvalues: a4 (val), u212 (upval), u211 (upval), u37 (val), a2 (val), a1 (val)
        if (if not a4 then u211 else u212) ~= u37 then
            return
        end
        if a2 <= 0 and a1.IsPlaying then
            a1:Stop()
        end
    end)
    u37:Play()
end

local function tweenAmbience(a1, a2, a3, a4) -- Line: 128
    -- upvalues: TweenService (val), Config (val)
    if a3 then
        a3:Cancel()
    end
    if not a1.IsPlaying then
        a1:Play()
    end
    local v1 = TweenService:Create(
        a1,
        TweenInfo.new(a4 or Config.Ambience.CrossfadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {Volume = a2}
    )
    v1:Play()
    return v1
end

local function tweenVictoryMusic(a1, a2) -- Line: 140
    -- upvalues: u213 (ref), u103 (val), TweenService (val)
    if u213 then
        u213:Cancel()
    end
    if a1 > 0 and not u103.IsPlaying then
        u103:Play()
    end
    local u31 = TweenService:Create(u103, TweenInfo.new(math.max(0.05, a2), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Volume = a1})
    u213 = u31
    u31.Completed:Once(function() -- Line: 149 -- upvalues: u213 (upval), u31 (val), a1 (val), u103 (upval)
        if u213 ~= u31 then
            return
        end
        if a1 <= 0 and u103.IsPlaying then
            u103:Stop()
        end
    end)
    u31:Play()
end

local function startBossMusic() -- Line: 156 -- upvalues: u98 (val), tweenMusic (val), Config (val)
    u98.Volume = math.min(u98.Volume, 0.02)
    tweenMusic(u98, Config.Music.BossVolume, Config.Music.BossFadeInDuration, true)
end

local function updateMusic(a1) -- Line: 161
    -- upvalues: u216 (ref), u217 (ref), Config (val), u214 (ref), tweenAmbience (val), u108 (val), u215 (ref)
    -- upvalues: u113 (val), tweenVictoryMusic (val), tweenMusic (val), u98 (val), u93 (val), u103 (val)
    local v1 = tostring(a1 and a1.Phase or "Day")
    local v2 = false
    if type(a1 and a1.Boss) == "table" then
        v2 = a1.Boss.Active == true
    end
    local v3 = v1 .. (if not v2 then ":Hidden" else ":Revealed")
    if v3 == u216 then
        return
    end
    u216 = v3
    u217 = u217 + 1
    local v4 = true
    if v1 ~= "Dusk" then
        v4 = true
        if v1 ~= "BossIntro" then
            v4 = true
            if v1 ~= "Boss" then
                v4 = v1 == "BossReward"
            end
        end
    end
    local v5 = v1 == "Victory"
    local v6 = true
    if v1 ~= "Dusk" then
        v6 = false
        if v1 == "BossIntro" then
            v6 = not v2
        end
    end
    local BossWarningFadeDuration = if not v6 then if not v2 then Config.Ambience.CrossfadeDuration else Config.Ambience.BossRevealDuckDuration else Config.Ambience.BossWarningFadeDuration
    u214 = tweenAmbience(u108, if v4 then 0 else if not v5 then Config.Ambience.BirdVolume else 0, u214, BossWarningFadeDuration)
    u215 = tweenAmbience(
        u113,
        if not v5 then if not v6 then if not v4 then 0 else Config.Ambience.BossCombatNightVolume else Config.Ambience.BossWarningNightVolume else 0,
        u215,
        BossWarningFadeDuration
    )
    if v1 == "Day" then
        tweenVictoryMusic(0, 0.25)
        tweenMusic(u98, 0, 0.4, true)
        tweenMusic(u93, Config.Music.DayVolume, Config.Music.DayFadeInDuration, false)
        return
    end
    if v1 == "Dusk" then
        tweenVictoryMusic(0, 0.25)
        tweenMusic(u93, 0, Config.Music.DayFadeOutDuration, false)
        tweenMusic(u98, 0, 0.25, true)
        return
    end
    if v1 == "BossIntro" then
        tweenVictoryMusic(0, 0.25)
        tweenMusic(u93, 0, 0.15, false)
        if not v2 then
            tweenMusic(u98, 0, 0.15, true)
            return
        end
        u98.Volume = math.min(u98.Volume, 0.02)
        tweenMusic(u98, Config.Music.BossVolume, Config.Music.BossFadeInDuration, true)
        return
    end
    if v1 == "Boss" then
        tweenVictoryMusic(0, 0.25)
        tweenMusic(u93, 0, 0.15, false)
        tweenMusic(u98, Config.Music.BossVolume, 0.5, true)
        return
    end
    if v1 == "BossReward" then
        tweenVictoryMusic(0, 0.25)
        tweenMusic(u98, 0, Config.Music.BossFadeOutDuration, true)
        return
    end
    if v1 == "Dawn" then
        tweenVictoryMusic(0, 0.25)
        tweenMusic(u98, 0, 0.5, true)
        tweenMusic(u93, 0, 0.25, false)
        return
    end
    if v1 == "Victory" then
        tweenMusic(u93, 0, Config.Victory.OldMusicFadeOutDuration, false)
        tweenMusic(u98, 0, Config.Victory.OldMusicFadeOutDuration, true)
        u103.Volume = math.min(u103.Volume, 0.02)
        tweenVictoryMusic(Config.Victory.MusicVolume, Config.Victory.MusicFadeInDuration)
    end
end

local Remotes = FishGame:WaitForChild("Remotes")
local WeaponAction = Remotes:WaitForChild("WeaponAction")
Remotes:WaitForChild("UpgradeAction")
local v5 = Remotes:WaitForChild("StateUpdate")
local v6 = Remotes:WaitForChild("FishFX")
local FishPush = Remotes:WaitForChild("FishPush")
local v7 = Remotes:WaitForChild("SparkleFX")
local v8 = Remotes:WaitForChild("SaleFX")
local v9 = Remotes:WaitForChild("WeaponFX")
local v10 = Remotes:WaitForChild("FishSplashFX")
local v11 = Remotes:WaitForChild("RedFishFX")
local v12 = Remotes:WaitForChild("AirstrikeExplosionFX")
local u311 = Random.new()
local u312 = {}

local function stopRedDrone(a1) -- Line: 247 -- upvalues: u312 (val) -- types: a1: userdata
    local v1 = u312[a1]
    if not v1 then
        return
    end
    u312[a1] = nil
    if v1.Tween then
        v1.Tween:Cancel()
    end
    if v1.DestroyingConnection then
        v1.DestroyingConnection:Disconnect()
    end
    if v1.GatorAttackSound then
        v1.GatorAttackSound:Stop()
        v1.GatorAttackSound:Destroy()
    end
    v1.Sound:Stop()
    v1.Sound:Destroy()
end

local function startRedDrone(a1, a2) -- Line: 261
    -- upvalues: stopRedDrone (val), Config (val), u311 (val), SoundService (val), u312 (val), TweenService (val)
    stopRedDrone(a1)
    local Sound = Instance.new("Sound")
    Sound.Name = "RedFishDroneLocal"
    Sound.SoundId = Config.RedFish.DroneSoundId
    Sound.Volume = 0.04
    Sound.PlaybackSpeed = u311:NextNumber(Config.RedFish.DroneSoundPitchMin, Config.RedFish.DroneSoundPitchMax)
    Sound.Looped = true
    Sound.Parent = SoundService
    local v1 = {Sound = Sound}
    u312[a1] = v1
    v1.DestroyingConnection = a1.Destroying:Connect(function() -- Line: 277 -- upvalues: stopRedDrone (upval), a1 (val)
        stopRedDrone(a1)
    end)
    Sound:Play()
    v1.Tween = TweenService:Create(Sound, TweenInfo.new(math.max(0.35, a2 or 0.35), Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Volume = if a1:GetAttribute("FishKind") ~= "Shark" then Config.RedFish.DroneSoundVolume else 1.35,
    })
    v1.Tween:Play()
end

local function fadeRedDrone(a1, a2) -- Line: 289
    -- upvalues: u312 (val), TweenService (val), stopRedDrone (val)
    local u3 = u312[a1]
    if not u3 then
        return
    end
    if u3.Tween then
        u3.Tween:Cancel()
    end
    local v1 = TweenService:Create(u3.Sound, TweenInfo.new(math.max(0.05, a2 or 0.16), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Volume = 0})
    u3.Tween = v1
    v1.Completed:Once(function() -- Line: 299 -- upvalues: u312 (upval), a1 (val), u3 (val), stopRedDrone (upval)
        if u312[a1] == u3 then
            stopRedDrone(a1)
        end
    end)
    v1:Play()
end

v11.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 305
    -- upvalues: Config (val), SoundService (val), Debris (val), startRedDrone (val), u312 (val), fadeRedDrone (val)
    -- upvalues: stopRedDrone (val)
    if a1 == "Bite" then
        local Sound = Instance.new("Sound")
        Sound.Name = "RedFishBiteLocal"
        local BiteSoundId = if not a2 then Config.RedFish.BiteSoundId else if not a2:IsA("Model") then Config.RedFish.BiteSoundId else if a2:GetAttribute("FishKind") ~= "Gator" then Config.RedFish.BiteSoundId else Config.RiverHazards.Gator.BiteSoundId
        Sound.SoundId = BiteSoundId
        Sound.Volume = if not a2 then if not a2 then Config.RedFish.BiteSoundVolume else if not a2:IsA("Model") then Config.RedFish.BiteSoundVolume else if a2:GetAttribute("FishKind") == "Shark" then 1 else if a2:GetAttribute("BossTarget") ~= true then Config.RedFish.BiteSoundVolume else 1 else if not a2:IsA("Model") then if not a2 then Config.RedFish.BiteSoundVolume else if not a2:IsA("Model") then Config.RedFish.BiteSoundVolume else if a2:GetAttribute("FishKind") == "Shark" then 1 else if a2:GetAttribute("BossTarget") ~= true then Config.RedFish.BiteSoundVolume else 1 else if a2:GetAttribute("FishKind") ~= "Gator" then if not a2 then Config.RedFish.BiteSoundVolume else if not a2:IsA("Model") then Config.RedFish.BiteSoundVolume else if a2:GetAttribute("FishKind") == "Shark" then 1 else if a2:GetAttribute("BossTarget") ~= true then Config.RedFish.BiteSoundVolume else 1 else 1.5
        Sound.Parent = SoundService
        SoundService:PlayLocalSound(Sound)
        Debris:AddItem(Sound, 3)
        return
    end
    if a2 and a2:IsA("Model") then
        if a1 ~= "Start" then
            if a1 == "Fade" then
                fadeRedDrone(a2, a3)
                return
            end
            if a1 == "Stop" then
                stopRedDrone(a2)
            end
            return
        end
        local Attribute = a2:GetAttribute("FishKind")
        startRedDrone(a2, a3)
        if Attribute == "Gator" then
            local Sound_2 = Instance.new("Sound")
            Sound_2.Name = "GatorAttackLocal"
            Sound_2.SoundId = Config.RiverHazards.Gator.AttackSoundId
            Sound_2.Volume = 1.8
            Sound_2.Looped = true
            Sound_2.Parent = SoundService
            SoundService:PlayLocalSound(Sound_2)
            local v1 = u312[a2]
            if v1 then
                v1.GatorAttackSound = Sound_2
                return
            end
        end
        return
    end
end)
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v13 = PlayerGui:WaitForChild("FishGameGui")
local v14 = v13:WaitForChild("Crosshair")
local Reticle = v14:WaitForChild("Reticle")
local HitMarker = v14:WaitForChild("HitMarker")
local MultiHitText = v14:FindFirstChild("MultiHitText")
local u375 = nil
if MultiHitText then
    local v15 = MultiHitText:FindFirstChild("TextStroke")
    if v15 and v15:IsA("UIStroke") then
        u375 = v15
    end
end
local Size = if not MultiHitText then UDim2.fromOffset(82, 23) else MultiHitText.Size
local Position = if not MultiHitText then UDim2.new(0.5, 0, 1, 25) else MultiHitText.Position
local v16 = v14:FindFirstChildWhichIsA("UICorner")
local v17 = v14:FindFirstChildWhichIsA("UIStroke")
v14.Size = UDim2.fromOffset(8, 8)
v14.BackgroundColor3 = Color3.new(1, 1, 1)
v14.BackgroundTransparency = 0
if v16 then
    v16.CornerRadius = UDim.new(1, 0)
end
if v17 then
    v17.Color = Color3.fromRGB(20, 20, 20)
    v17.Thickness = 1.5
    v17.Transparency = 0.2
end
Reticle.Visible = false
if MultiHitText then
    MultiHitText.Visible = false
end
local HitConfirm = ((FishGame:WaitForChild("Assets")):WaitForChild("WeaponEffects")):WaitForChild("HitConfirm")
local FishProgress = v13:WaitForChild("FishProgress")
local CashBadge = v13:WaitForChild("CashBadge")
local StoredBadge = v13:WaitForChild("StoredBadge")
local AmmoPanel = v13:WaitForChild("AmmoPanel")
local ReloadRing = v13:WaitForChild("ReloadRing")
local ShootPrompt = v13:WaitForChild("ShootPrompt")
local v18 = v13:WaitForChild("Notification")
local GunHotbar = v13:WaitForChild("GunHotbar")
local GunButtonTemplate = v13:WaitForChild("GunButtonTemplate")
local OrdnanceBar = v13:WaitForChild("OrdnanceBar")
FishProgress.Visible = false
CashBadge.Visible = false
StoredBadge.Visible = false
ShootPrompt.Visible = false
ShootPrompt.Text = ""
GunHotbar.Visible = false
GunButtonTemplate.Visible = false
OrdnanceBar.Visible = false
ReloadRing.Visible = false
v18.Visible = false
UserInputService.MouseIconEnabled = false
local u521 = nil
local u522 = nil
local u523 = "Mosin"
local u524 = ""
local u525 = 0
local u526 = false
local u527 = 0
local u528 = true
local u529 = nil
local u530 = nil
local u531 = {}
local u532 = nil
local u533 = false
local u534 = 0
local u535 = nil
local u536 = nil
local u537 = nil
local u538 = nil
local u539 = nil
local u540 = nil

local function formatNumber(a1) -- Line: 420 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.floor(a1 + 0.5)))
    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function hideCharacter() -- Line: 430 -- upvalues: RunService (val), LocalPlayer (val)
    if RunService:IsStudio() and LocalPlayer:GetAttribute("FishDevThirdPerson") == true then
        return
    end
    local Character = LocalPlayer.Character
    if not Character then
        return
    end
    for i, v in ipairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.LocalTransparencyModifier = 1
        end
    end
end

local function clearViewmodel() -- Line: 439 -- upvalues: u529 (ref), u530 (ref), u531 (ref), u532 (ref)
    if u529 then
        u529:Destroy()
    end
    u529 = nil
    u530 = nil
    u531 = {}
    u532 = nil
end

local function newViewPart(a1, a2, a3) -- Line: 444 -- types: a1: string, a2: userdata, a3: userdata?
    local Part = if not a3 then Instance.new("Part") else a3:Clone()
    Part.Name = a1
    for i, v in ipairs(Part:GetChildren()) do
        v:Destroy()
    end
    Part.Color = a2
    Part.Material = Enum.Material.SmoothPlastic
    Part.Transparency = 0
    Part.LocalTransparencyModifier = 0
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.CastShadow = false
    return Part
end

local function setLimbSegment(a1, a2, a3, a4, a5) -- Line: 454
    -- upvalues: 
    if not a1 then
        return
    end
    local v1 = a3 - a2
    if v1.Magnitude < 0.05 then
        return
    end
    local Unit = v1.Unit
    local RightVector = Unit:Cross(a4.LookVector)
    if RightVector.Magnitude < 0.05 then
        RightVector = a4.RightVector
    end
    local Unit_2 = RightVector.Unit
    local Unit_3 = (Unit_2:Cross(Unit)).Unit
    a1.Size = Vector3.new(a5, v1.Magnitude, a5)
    a1.CFrame = CFrame.fromMatrix((a2 + a3) * 0.5, Unit_2, Unit, Unit_3)
end

local function poseViewmodelLimbs(a1) -- Line: 467 -- upvalues: setLimbSegment (val), u531 (ref) -- types: a1: userdata
    local v1 = a1:PointToWorldSpace((Vector3.new(0.8199999928474426, -1.3200000524520874, -0.25)))
    local v2 = a1:PointToWorldSpace((Vector3.new(-0.8199999928474426, -1.2999999523162842, -0.30000001192092896)))
    local v3 = a1:PointToWorldSpace((Vector3.new(0.6399999856948853, -1.1200000047683716, -1.559999942779541)))
    local v4 = a1:PointToWorldSpace((Vector3.new(0.46000000834465027, -0.9900000095367432, -2.0199999809265137)))
    setLimbSegment(u531.RightArm, v1, v3, a1, 0.5)
    setLimbSegment(u531.LeftArm, v2, v4, a1, 0.5)
    local v5 = v1 + (v1 - v3).Unit * 0.62
    local v6 = v2 + (v2 - v4).Unit * 0.62
    setLimbSegment(u531.RightSleeve, v5, v1:Lerp(v3, 0.61), a1, 0.62)
    setLimbSegment(u531.LeftSleeve, v6, v2:Lerp(v4, 0.61), a1, 0.62)
end

local function softenGunshot(a1) -- Line: 482 -- types: a1: userdata
    local Fire = a1:FindFirstChild("Fire", true)
    if Fire and Fire:IsA("Sound") then
        Fire.Volume = math.min(Fire.Volume, 0.48)
        local GunshotSoftener = Fire:FindFirstChild("GunshotSoftener")
        if not GunshotSoftener then
            GunshotSoftener = Instance.new("EqualizerSoundEffect")
            GunshotSoftener.Name = "GunshotSoftener"
            GunshotSoftener.Parent = Fire
        end
        if GunshotSoftener:IsA("EqualizerSoundEffect") then
            GunshotSoftener.LowGain = 1
            GunshotSoftener.MidGain = -1.5
            GunshotSoftener.HighGain = -4.5
        end
        return
    end
end

local function tuneGunshot(a1, a2) -- Line: 499 -- upvalues: softenGunshot (val) -- types: a1: userdata
    softenGunshot(a1)
    local Fire = a1:FindFirstChild("Fire", true)
    if Fire and Fire:IsA("Sound") then
        Fire:SetAttribute("BasePitch", (tonumber((Fire:GetAttribute("BasePitch"))) or Fire.PlaybackSpeed) * ((tonumber(a2.ShotPitch)) or 1))
        local Volume = tonumber(a2.ShotVolume) or Fire.Volume
        Fire.Volume = Volume
        return
    end
end

local function createViewmodel(a1) -- Line: 508
    -- upvalues: u529 (ref), u530 (ref), u531 (ref), u532 (ref), LocalPlayer (val), Workspace (val), FishGame (val)
    -- upvalues: Config (val), newViewPart (val), tuneGunshot (val), ExclusiveWeaponEffects (val), hideCharacter (val)
    if u529 then
        u529:Destroy()
    end
    u529 = nil
    u530 = nil
    u531 = {}
    u532 = nil
    if LocalPlayer:GetAttribute("FishDead") ~= true and LocalPlayer:GetAttribute("FishLocalDead") ~= true then
        local CurrentCamera = Workspace.CurrentCamera
        local v1 = FishGame.Assets.Guns:FindFirstChild(a1)
        local u179 = Config.Guns[a1]
        if CurrentCamera and v1 and v1:IsA("Model") and u179 then
            local v2, v3, v4, v5
            local Folder = Instance.new("Folder")
            Folder.Name = "FishGameViewmodel"
            Folder.Parent = CurrentCamera
            local u185 = v1:Clone()
            pcall(function() -- Line: 519 -- upvalues: u185 (val), u179 (val)
                u185:ScaleTo(u179.ModelScale)
            end)
            for i, v in ipairs(u185:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Anchored = true
                    v.CanCollide = false
                    v.CanTouch = false
                    v.CanQuery = false
                    v.CastShadow = false
                end
            end
            u185.Parent = Folder
            local Color = Color3.fromRGB(238, 190, 155)
            local Character = LocalPlayer.Character
            local Head = Character and Character:FindFirstChild("Head")
            if Head and Head:IsA("BasePart") then
                Color = Head.Color
            end
            local ViewmodelArms = FishGame.Assets.ViewmodelArms
            for i2, i3 in ipairs({"RightArm", "LeftArm"}) do
                v2 = ViewmodelArms:FindFirstChild(i3)
                v5 = if not v2 then nil else if not v2:IsA("BasePart") then nil else v2
                v3 = newViewPart(i3, Color, v5)
                v3.Parent = Folder
                u531[i3] = v3
            end
            for i4, j in ipairs({"RightSleeve", "LeftSleeve"}) do
                v2 = newViewPart
                v4 = Color3.fromRGB(31, 48, 64)
                v2 = v2(j, v4, nil)
                v2.Parent = Folder
                u531[j] = v2
            end
            local v6 = FishGame.Assets.WeaponEffects.MuzzleRig:Clone()
            v6.Name = "MuzzleRig"
            tuneGunshot(v6, u179)
            ExclusiveWeaponEffects.TintMuzzle(v6, u179.Element)
            v6.Parent = Folder
            u529 = Folder
            u530 = u185
            u532 = v6
            hideCharacter()
            return
        end
        return
    end
end

local function buildOwnedSignature() -- Line: 551 -- upvalues: u522 (ref), Config (val)
    if u522 and u522.OwnedGuns then
        local v1 = {}
        for i, v in ipairs(Config.GunOrder) do
            if u522.OwnedGuns[v] then
                table.insert(v1, v)
            end
        end
        return table.concat(v1, "|")
    end
    return ""
end

local function rebuildHotbar() -- Line: 558
    -- upvalues: GunHotbar (val), buildOwnedSignature (val), u524 (ref), Config (val), u522 (ref)
    -- upvalues: GunButtonTemplate (val), u523 (ref), WeaponAction (val)
    local ToolAmount, ToolIcon, ToolName, ToolNumber, v1
    if not GunHotbar.Visible then
        return
    end
    local v2 = buildOwnedSignature()
    if v2 == u524 then
        return
    end
    u524 = v2
    for i, v in ipairs(GunHotbar:GetChildren()) do
        if v:IsA("GuiButton") then
            v:Destroy()
        end
    end
    for i2, i3 in ipairs(Config.GunOrder) do
        if u522 and u522.OwnedGuns and u522.OwnedGuns[i3] then
            v1 = GunButtonTemplate:Clone()
            v1.Name = i3
            v1.Visible = true
            v1.LayoutOrder = i2
            v1.Size = UDim2.fromOffset(68, 68)
            v1.Parent = GunHotbar
            v1.BackgroundColor3 = Config.Guns[i3].Color
            v1.BackgroundTransparency = if i3 ~= u523 then 0.28 else 0.05
            ToolIcon = v1:FindFirstChild("ToolIcon")
            if ToolIcon and ToolIcon:IsA("ImageLabel") then
                ToolIcon.Visible = false
            end
            ToolName = v1:FindFirstChild("ToolName")
            if ToolName and ToolName:IsA("TextLabel") then
                ToolName.Text = Config.Guns[i3].DisplayName
                ToolName.TextScaled = true
            end
            ToolNumber = v1:FindFirstChild("ToolNumber")
            if ToolNumber and ToolNumber:IsA("TextLabel") then
                ToolNumber.Text = tostring(i2)
            end
            ToolAmount = v1:FindFirstChild("ToolAmount")
            if ToolAmount and ToolAmount:IsA("TextLabel") then
                ToolAmount.Visible = false
            end
            v1.Activated:Connect(function() -- Line: 584 -- upvalues: WeaponAction (upval), i3 (val)
                WeaponAction:FireServer("Equip", i3)
            end)
        end
    end
end

function rebuildOrdnance() -- Line: 589
    -- upvalues: OrdnanceBar (val), Config (val), u522 (ref), Remotes (val), rebuildOrdnance (val)
    local TextButton, v1, v2, v3
    if not OrdnanceBar.Visible then
        return
    end
    for i, v in ipairs(OrdnanceBar:GetChildren()) do
        if v:IsA("GuiButton") then
            v:Destroy()
        end
    end
    for i2, i3 in ipairs(Config.OrdnanceOrder) do
        TextButton = Instance.new("TextButton")
        TextButton.Name = i3
        TextButton.LayoutOrder = i2
        TextButton.Size = UDim2.fromOffset(76, 62)
        TextButton.BackgroundColor3 = Config.Ordnance[i3].Color
        TextButton.BackgroundTransparency = 0.18
        TextButton.BorderSizePixel = 0
        TextButton.Font = Enum.Font.GothamBlack
        TextButton.TextColor3 = Color3.new(1, 1, 1)
        TextButton.TextScaled = true
        v1 = u522 and u522.Ordnance and u522.Ordnance[i3] or 0
        TextButton.Text = string.format("%s\nx%d", string.upper((string.sub(Config.Ordnance[i3].DisplayName, 1, 8))), v1)
        v2 = Instance.new("UICorner", TextButton)
        v2.CornerRadius = UDim.new(0, 12)
        v3 = Instance.new("UIStroke", TextButton)
        v3.Thickness = if not u522 then 2 else if u522.SelectedOrdnance ~= i3 then 2 else 4
        v3.Color = Color3.new(1, 1, 1)
        v3.Transparency = 0.15
        TextButton.Parent = OrdnanceBar
        TextButton.Activated:Connect(function() -- Line: 602 -- upvalues: u522 (upval), i3 (val), Remotes (upval), rebuildOrdnance (upval)
            if u522 then
                u522.SelectedOrdnance = i3
            end
            Remotes.OrdnanceAction:FireServer("Select", i3)
            rebuildOrdnance()
        end)
    end
end

local function updateHUD() -- Line: 610
    -- upvalues: u521 (ref), Config (val), FishProgress (val), formatNumber (val), CashBadge (val), StoredBadge (val)
    -- upvalues: u522 (ref), u523 (ref), createViewmodel (val), u524 (ref), AmmoPanel (val), rebuildHotbar (val)
    -- upvalues: rebuildOrdnance (val)
    local v1
    if u521 then
        local v2 = math.max(1, tonumber(u521.TotalFish) or Config.FishGoal(u521.Difficulty))
        v1 = u521.FishRemaining or v2
        local v3 = 1 - v1 / v2
        local Level = FishProgress:FindFirstChild("Level")
        if Level and Level:IsA("TextLabel") then
            Level.Text = formatNumber(v1)
        end
        local ExpAmount = FishProgress:FindFirstChild("ExpAmount")
        if ExpAmount and ExpAmount:IsA("TextLabel") then
            ExpAmount.Text = string.format("%.1f%% CLEARED", v3 * 100)
        end
        local FillBar = FishProgress:FindFirstChild("FillBar")
        if FillBar and FillBar:IsA("Frame") then
            FillBar.Size = UDim2.new(math.clamp(v3, 0, 1), math.clamp(v3, 0, 1) * -12, 0, 9)
        end
        local Amount = CashBadge:FindFirstChild("Amount")
        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = "$" .. formatNumber(u521.TeamCash or 0)
        end
        local Amount_2 = StoredBadge:FindFirstChild("Amount")
        if Amount_2 and Amount_2:IsA("TextLabel") then
            Amount_2.Text = "IN YARD  " .. formatNumber(u521.StoredFish or 0)
        end
    end
    if u522 then
        local EquippedGun = u522.EquippedGun or u523
        if EquippedGun ~= u523 then
            createViewmodel(EquippedGun)
            u524 = ""
        end
        v1 = Config.Guns[u523]
        local GunName = AmmoPanel:FindFirstChild("GunName")
        if GunName and GunName:IsA("TextLabel") then
            GunName.Text = string.upper(v1.DisplayName)
            GunName.TextColor3 = v1.Color
        end
        local Ammo = AmmoPanel:FindFirstChild("Ammo")
        if Ammo and Ammo:IsA("TextLabel") then
            local v4 = Config.MagazineSize(v1, u521 and u521.Upgrades)
            Ammo.Text = if not u522.Reloading then string.format("%d / %d", u522.Ammo[u523] or 0, v4) else "RELOADING"
        end
        rebuildHotbar()
        rebuildOrdnance()
    end
end

local function animateHitMarker(a1) -- Line: 641
    -- upvalues: u534 (ref), u535 (ref), u536 (ref), u537 (ref), u538 (ref), u539 (ref), u540 (ref), HitMarker (val)
    -- upvalues: u311 (val), Reticle (val), TweenService (val), HitConfirm (val), SoundService (val), Debris (val)
    -- upvalues: MultiHitText (val), u375 (ref), Position (val), Size (val)
    u534 = u534 + 1
    local u3 = u534
    if u535 then
        u535:Cancel()
    end
    if u536 then
        u536:Cancel()
    end
    if u537 then
        u537:Cancel()
    end
    if u538 then
        u538:Cancel()
    end
    if u539 then
        u539:Cancel()
    end
    if u540 then
        u540:Cancel()
    end
    local u43 = math.min(a1, 5)
    local u46 = a1 > 1
    HitMarker.Visible = true
    HitMarker.ImageTransparency = 0
    local v1 = HitMarker
    local v2 = if not u46 then Color3.new(1, 1, 1) else Color3.fromRGB(255, 58, 58)
    v1.ImageColor3 = v2
    HitMarker.Size = UDim2.fromOffset(u43 * 2 + 20, u43 * 2 + 20)
    HitMarker.Rotation = u311:NextNumber(-11, 11)
    Reticle.Size = UDim2.fromScale(1.18, 1.18)
    Reticle.ImageColor3 = Color3.fromRGB(255, 232, 155)
    TweenService:Create(
        Reticle,
        TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.fromScale(1, 1), ImageColor3 = Color3.new(1, 1, 1)}
    ):Play()
    v1 = HitConfirm:Clone()
    v1.PlaybackSpeed = math.min(a1, 5) * 0.025 + 0.97 + u311:NextNumber(-0.035, 0.035)
    v1.Volume = math.min(2.13, u43 * 0.127 + 1.47)
    v1.Parent = SoundService
    v1.TimePosition = 0
    SoundService:PlayLocalSound(v1)
    Debris:AddItem(v1, 3)
    u535 = TweenService:Create(HitMarker, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(u43 * 3 + 58, u43 * 3 + 58),
        Rotation = HitMarker.Rotation * -0.18,
    })
    u535:Play()
    if MultiHitText then
        if not u46 then
            MultiHitText.Visible = false
        else
            MultiHitText.Text = "X" .. (tostring(a1)) .. "!"
            MultiHitText.TextColor3 = Color3.fromRGB(255, 58, 58)
            MultiHitText.TextTransparency = 0
            if u375 then
                u375.Transparency = 0.15
            end
            MultiHitText.Size = UDim2.fromOffset(42, 12)
            MultiHitText.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale, Position.Y.Offset + 7)
            MultiHitText.Rotation = u311:NextNumber(-6, 6)
            MultiHitText.Visible = true
            u538 = TweenService:Create(
                MultiHitText,
                TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Rotation = 0, Size = Size, Position = Position}
            )
            u538:Play()
        end
    end
    task.delay(0.105, function() -- Line: 700
        -- upvalues: u3 (val), u534 (upval), u536 (upval), TweenService (upval), HitMarker (upval), u43 (val)
        if u3 ~= u534 then
            return
        end
        u536 = TweenService:Create(
            HitMarker,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Rotation = 0, Size = UDim2.fromOffset(u43 * 2 + 49, u43 * 2 + 49)}
        )
        u536:Play()
    end)
    task.delay(0.24, function() -- Line: 708
        -- upvalues: u3 (val), u534 (upval), u537 (upval), TweenService (upval), HitMarker (upval), u43 (val)
        -- upvalues: u311 (upval)
        if u3 ~= u534 then
            return
        end
        u537 = TweenService:Create(HitMarker, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1,
            Size = UDim2.fromOffset(u43 * 3 + 74, u43 * 3 + 74),
            Rotation = u311:NextNumber(-4, 4),
        })
        u537:Play()
    end)
    task.delay(0.34, function() -- Line: 717
        -- upvalues: u3 (val), u534 (upval), MultiHitText (upval), u46 (val), u539 (upval), TweenService (upval)
        -- upvalues: Size (upval), Position (upval), u375 (upval), u540 (upval)
        if u3 == u534 and MultiHitText and u46 then
            u539 = TweenService:Create(MultiHitText, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 1,
                Size = UDim2.new(Size.X.Scale * 1.12, Size.X.Offset * 1.12, Size.Y.Scale * 1.12, Size.Y.Offset * 1.12),
                Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale, Position.Y.Offset - 7),
            })
            u539:Play()
            if u375 then
                u540 = TweenService:Create(u375, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1})
                u540:Play()
            end
            u539.Completed:Once(function() -- Line: 747 -- upvalues: u3 (upval), u534 (upval), MultiHitText (upval)
                if u3 == u534 and MultiHitText then
                    MultiHitText.Visible = false
                end
            end)
            return
        end
    end)
end

local function playRigSound(a1, a2) -- Line: 753 -- upvalues: u532 (ref), u311 (val) -- types: a1: string, a2: number?
    if not u532 then
        return
    end
    local v1 = u532:FindFirstChild(a1)
    if v1 and v1:IsA("Sound") then
        local Attribute = v1:GetAttribute("BasePitch") or v1.PlaybackSpeed
        v1.PlaybackSpeed = Attribute
        v1.PlaybackSpeed = v1.PlaybackSpeed * (1 + u311:NextNumber(-(a2 or 0), a2 or 0))
        v1.TimePosition = 0
        v1:Play()
    end
end

local function emitRig(a1) -- Line: 764 -- types: a1: userdata
    local Attribute
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            Attribute = v:GetAttribute("Burst")
            v:Emit(Attribute or 1)
        elseif v:IsA("PointLight") then
            v.Enabled = true
            task.delay(0.045, function() -- Line: 770 -- upvalues: v (val)
                if v.Parent then
                    v.Enabled = false
                end
            end)
        end
    end
end

local function emitMuzzle() -- Line: 775 -- upvalues: u532 (ref), emitRig (val)
    if u532 then
        emitRig(u532)
    end
end

local function emitWaterSplash(a1, a2) -- Line: 779
    -- upvalues: ReplicatedStorage (val), Workspace (val), Config (val), Debris (val)
    local Particles = ReplicatedStorage:FindFirstChild("Particles")
    local WaterSplash = Particles and Particles:FindFirstChild("WaterSplash")
    if WaterSplash and WaterSplash:IsA("ParticleEmitter") then
        local Part = Instance.new("Part")
        Part.Name = "WaterSplashBurst"
        Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        Part.Transparency = 1
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanTouch = false
        Part.CanQuery = false
        Part.CFrame = CFrame.new(a1)
        Part.Parent = Workspace
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = Part
        local v1 = WaterSplash:Clone()
        v1.Enabled = false
        v1.Parent = Attachment
        v1:Emit((math.max(1, (math.floor(a2 or Config.WaterSplashBursts.Shot)))))
        Debris:AddItem(Part, v1.Lifetime.Max + 0.25)
        return
    end
end

local function makeImpact(a1, a2, a3) -- Line: 802
    -- upvalues: emitWaterSplash (val), Config (val), FishGame (val), Workspace (val), Debris (val)
    if a3 then
        emitWaterSplash(a1, Config.WaterSplashBursts.Gunshot)
        return
    end
    local ImpactRig = FishGame.Assets.WeaponEffects:FindFirstChild("ImpactRig")
    if ImpactRig and ImpactRig:IsA("BasePart") then
        local new, v1, v2, v3
        local v4 = ImpactRig:Clone()
        v4.CFrame = CFrame.lookAt(a1 + a2 * 0.04, a1 + a2)
        v4.Parent = Workspace
        local v5 = a3
        for i, v in ipairs(v4:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                if not v5 then
                    new = ColorSequence.new
                    v2 = Color3.fromRGB(205, 185, 145)
                    v.Color = new(v2, Color3.fromRGB(90, 78, 62))
                end
                v1 = 0.45
                if v5 then
                    v1 = 1
                end
                v3 = math.max(2, (math.floor(((v:GetAttribute("Burst")) or 6) * v1)))
                v:Emit(v3)
            end
        end
        Debris:AddItem(v4, 1.2)
        return
    end
end

v5.OnClientEvent:Connect(function(a1, a2) -- Line: 821
    -- upvalues: u522 (ref), u523 (ref), u533 (ref), u521 (ref), updateMusic (val), updateHUD (val), playRigSound (val)
    -- upvalues: Config (val), SoundService (val), Debris (val)
    local v1
    local v2 = u522
    local EquippedGun = a2 and a2.EquippedGun and a2.EquippedGun ~= u523
    local v3 = a2
    if v3 then
        v3 = v2
        if v3 then
            v3 = not EquippedGun
            if v3 then
                v3 = false
                if a2.Reloading == true then
                    v3 = not u533
                end
            end
        end
    end
    u521 = a1
    u522 = a2
    updateMusic(a1)
    updateHUD()
    if EquippedGun then
        playRigSound("Equip", 0.04)
    end
    if v3 then
        local Sound = Instance.new("Sound")
        Sound.Name = "ReloadStartLocal"
        Sound.SoundId = Config.InterfaceSounds.ReloadBulletSoundId
        Sound.Volume = Config.InterfaceSounds.ReloadBulletSoundVolume
        Sound.Parent = SoundService
        SoundService:PlayLocalSound(Sound)
        Debris:AddItem(Sound, 6)
    end
    if not a2 then
        v1 = false
    else
        v1 = true
        if a2.Reloading ~= true then
            v1 = false
        end
    end
    u533 = v1
end)
v9.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 842
    -- upvalues: LocalPlayer (val), Config (val), makeImpact (val), ExclusiveWeaponEffects (val), animateHitMarker (val)
    -- upvalues: FishGame (val), tuneGunshot (val), Players (val), Workspace (val), emitRig (val), u311 (val)
    -- upvalues: Debris (val)
    local v1 = a1 == LocalPlayer.UserId
    local Mosin = Config.Guns[a7] or Config.Guns.Mosin
    if (a8 or 0) == 0 then
        makeImpact(a3, a4, a6)
    end
    ExclusiveWeaponEffects.Impact(Mosin.Element, a3, a4)
    if v1 and 0 < (a8 or 0) then
        animateHitMarker(a8 or 1)
    end
    if not v1 then
        local MuzzleRig = FishGame.Assets.WeaponEffects:FindFirstChild("MuzzleRig")
        if MuzzleRig and MuzzleRig:IsA("BasePart") then
            local v2 = MuzzleRig:Clone()
            tuneGunshot(v2, Mosin)
            ExclusiveWeaponEffects.TintMuzzle(v2, Mosin.Element)
            local PlayerByUserId = Players:GetPlayerByUserId(a1)
            local Character = PlayerByUserId and PlayerByUserId.Character
            local ThirdPersonWeapon = Character and Character:FindFirstChild("ThirdPersonWeapon")
            v2.CFrame = (if not ThirdPersonWeapon then nil else if not ThirdPersonWeapon:IsA("Model") then nil else if ThirdPersonWeapon:GetAttribute("GunId") ~= a7 then nil else ExclusiveWeaponEffects.MuzzleCFrame(ThirdPersonWeapon)) or CFrame.new(a2)
            v2.Parent = Workspace
            emitRig(v2)
            local Fire = v2:FindFirstChild("Fire")
            if Fire and Fire:IsA("Sound") then
                local Attribute = Fire:GetAttribute("BasePitch") or Fire.PlaybackSpeed
                Fire.PlaybackSpeed = Attribute * (1 + u311:NextNumber(-0.07, 0.07))
                Fire:Play()
            end
            Debris:AddItem(v2, 1.5)
        end
    end
end)
v10.OnClientEvent:Connect(function(a1, a2) -- Line: 872 -- upvalues: emitWaterSplash (val) -- types: a1: vector, a2: number?
    emitWaterSplash(a1, a2)
end)
local AirstrikeExplosionEffect = (ReplicatedStorage:WaitForChild("AirstrikeSystem")):WaitForChild("AirstrikeExplosionEffect")
local u729 = {
    Explosion = 100,
    Smoke1 = 150,
    Smoke2 = 150,
    Smoke3 = 150,
    Smoke4 = 50,
    Debris = 1000,
    Debris2 = 1000,
    Shockwave = 5,
}
v12.OnClientEvent:Connect(function(a1) -- Line: 888
    -- upvalues: AirstrikeExplosionEffect (val), Workspace (val), u729 (val), Debris (val)
    local v1
    local Part = Instance.new("Part")
    Part.Name = "AirstrikeExplosionEffectLocal"
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a1)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    for i, v in ipairs(AirstrikeExplosionEffect:GetChildren()) do
        v:Clone().Parent = Part
    end
    Part.Parent = Workspace
    for i2, i3 in ipairs(Part:GetDescendants()) do
        if i3:IsA("ParticleEmitter") then
            i3.Enabled = false
            v1 = u729[i3.Name] or math.max(1, (math.floor(i3.Rate)))
            i3:Emit(v1)
        elseif i3:IsA("Sound") then
            i3:Play()
        end
    end
    Debris:AddItem(Part, (tonumber((AirstrikeExplosionEffect:GetAttribute("Lifetime")))) or 10)
end)
v7.OnClientEvent:Connect(function(a1, a2) -- Line: 914
    -- upvalues: FishGame (val), Workspace (val), TweenService (val), Debris (val)
    local ImpactRig = FishGame.Assets.WeaponEffects:FindFirstChild("ImpactRig")
    if ImpactRig and ImpactRig:IsA("BasePart") then
        local new, v1, v2
        local v3 = ImpactRig:Clone()
        v3.Name = "SparkleBonusImpact"
        v3.CFrame = CFrame.new(a1)
        v3.Parent = Workspace
        for i, v in ipairs(v3:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                new = ColorSequence.new
                v1 = Color3.fromRGB(255, 245, 125)
                v.Color = new(v1, Color3.fromRGB(75, 220, 255))
                v.LightEmission = 1
                v2 = math.max(8, (math.floor(((v:GetAttribute("Burst")) or 6) * 1.8)))
                v:Emit(v2)
            end
        end
        local PointLight = Instance.new("PointLight")
        PointLight.Color = Color3.fromRGB(255, 231, 105)
        PointLight.Brightness = 2.2
        PointLight.Range = 18
        PointLight.Shadows = false
        PointLight.Parent = v3
        TweenService:Create(PointLight, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0, Range = 8}):Play()
        Debris:AddItem(v3, 1.25)
        return
    end
end)

local function aimPayload() -- Line: 929
    -- upvalues: Workspace (val), LocalPlayer (val), Config (val), u523 (ref), u521 (ref)
    local CurrentCamera = Workspace.CurrentCamera
    if not CurrentCamera then
        return nil
    end
    local ViewportSize = CurrentCamera.ViewportSize
    local v1 = CurrentCamera:ViewportPointToRay(ViewportSize.X / 2, ViewportSize.Y / 2)
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    if LocalPlayer.Character then
        v2.FilterDescendantsInstances = {LocalPlayer.Character}
    end
    v2.IgnoreWater = false
    local v3 = Workspace:Raycast(v1.Origin, v1.Direction * Config.MaxRange, v2)
    local Position = if not v3 then v1.Origin + v1.Direction * Config.MaxRange else v3.Position
    local v4 = {}
    local ActiveFish = Workspace:FindFirstChild("ActiveFish")
    if ActiveFish then
        local ExtentsSize, Mosin, Position_2, ShotRadius, v5, v6, v7
        local v8 = {}
        for i, v in ipairs(ActiveFish:GetChildren()) do
            if v:IsA("Model") and v:GetAttribute("FishTarget") == true then
                Position_2 = v:GetPivot().Position
                v5 = (Position_2 - v1.Origin):Dot(v1.Direction.Unit)
                ExtentsSize = v:GetExtentsSize()
                v6 = math.max(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z) * 0.5
                Mosin = Config.Guns[u523] or Config.Guns.Mosin
                ShotRadius = Config.ShotRadius
                v7 = ShotRadius(Mosin, u521 and u521.Upgrades) + v6
                if -v7 <= v5
                    and v5 <= Config.MaxRange + v7
                    and (Position_2 - (v1.Origin + v1.Direction.Unit * math.clamp(v5, 0, Config.MaxRange))).Magnitude <= v7 then
                    table.insert(v8, {Model = v, Distance = math.max(0, v5)})
                end
            end
        end
        table.sort(v8, function(a1, a2) -- Line: 958
            return a1.Distance < a2.Distance
        end)
        for i2 = 1, (math.min(#v8, 16)) do
            table.insert(v4, v8[i2].Model)
        end
    end
    return {
        origin = v1.Origin,
        direction = v1.Direction.Unit,
        target = Position,
        shotTime = Workspace:GetServerTimeNow(),
        candidateFish = v4,
    }
end

local function attemptFire() -- Line: 970
    -- upvalues: LocalPlayer (val), u522 (ref), Config (val), u523 (ref), u521 (ref), u525 (ref), u51 (ref)
    -- upvalues: playRigSound (val), WeaponAction (val), u527 (ref), u532 (ref), emitRig (val), aimPayload (val)
    -- upvalues: u528 (ref), TweenService (val), ShootPrompt (val), updateHUD (val)
    if LocalPlayer:GetAttribute("FishDead") ~= true and LocalPlayer:GetAttribute("FishLocalDead") ~= true then
        if LocalPlayer:GetAttribute("FishVictory") == true then
            return
        end
        if LocalPlayer:GetAttribute("FishResearchOpen") ~= true
            and LocalPlayer:GetAttribute("FishMedalOpen") ~= true then
            if not u522 then
                return
            end
            local v1 = Config.Guns[u523]
            if v1 and not u522.Reloading then
                local v2 = os.clock()
                local Research = u521 and u521.Research or {}
                local v3 = Config.GunFireInterval(v1, u521 and u521.Upgrades, Research)
                if v2 - u525 < v3 then
                    return
                end
                local v4 = u522.Ammo[u523] or 0
                if v4 <= 0 then
                    if u51 > 0 then
                        return
                    end
                    playRigSound("Dry", 0.04)
                    WeaponAction:FireServer("Reload")
                    return
                end
                u525 = v2
                local v5 = u523
                u522.Ammo[v5] = (math.max(0, v4 - 1))
                u527 = math.max(u527, v1.Recoil)
                if u532 then
                    emitRig(u532)
                end
                playRigSound("Fire", 0.07)
                local v6 = aimPayload()
                if v6 then
                    WeaponAction:FireServer("Fire", v6)
                end
                if not u528 then
                    u528 = true
                    TweenService:Create(ShootPrompt, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
                end
                updateHUD()
                return
            end
            return
        end
        return
    end
end

UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 997
    -- upvalues: LocalPlayer (val), u526 (ref), attemptFire (val), u51 (ref), WeaponAction (val), aimPayload (val)
    -- upvalues: Remotes (val), u522 (ref), Config (val)
    if a2 then
        return
    end
    if LocalPlayer:GetAttribute("FishDead") ~= true and LocalPlayer:GetAttribute("FishLocalDead") ~= true then
        if LocalPlayer:GetAttribute("FishVictory") == true then
            return
        end
        if LocalPlayer:GetAttribute("FishResearchOpen") ~= true
            and LocalPlayer:GetAttribute("FishMedalOpen") ~= true then
            local v1
            if a1.UserInputType == Enum.UserInputType.MouseButton1 then
                u526 = true
                attemptFire()
                return
            end
            if a1.KeyCode == Enum.KeyCode.R then
                if u51 > 0 then
                    return
                end
                WeaponAction:FireServer("Reload")
                return
            end
            if a1.KeyCode == Enum.KeyCode.Q then
                v1 = aimPayload()
                if not v1 then
                    return
                end
                Remotes.OrdnanceAction:FireServer("Use", {id = u522 and u522.SelectedOrdnance, target = v1.target})
                return
            end
            v1 = {
                [Enum.KeyCode.One] = 1,
                [Enum.KeyCode.Two] = 2,
                [Enum.KeyCode.Three] = 3,
                [Enum.KeyCode.Four] = 4,
                [Enum.KeyCode.Five] = 5,
                [Enum.KeyCode.Six] = 6,
                [Enum.KeyCode.Seven] = 7,
                [Enum.KeyCode.Eight] = 8,
                [Enum.KeyCode.Nine] = 9,
            }
            local v2 = v1[a1.KeyCode]
            local v3 = v2 and Config.GunOrder[v2]
            if v3 and u522 and u522.OwnedGuns[v3] then
                WeaponAction:FireServer("Equip", v3)
            end
            return
        end
        return
    end
end)
UserInputService.InputEnded:Connect(function(a1) -- Line: 1020 -- upvalues: u526 (ref)
    if a1.UserInputType == Enum.UserInputType.MouseButton1 then
        u526 = false
    end
end)
local v19 = Enum.KeyCode.ButtonR2
ContextActionService:BindAction("FishFire", function(a1, a2) -- Line: 1024 -- upvalues: LocalPlayer (val), u526 (ref), attemptFire (val)
    if LocalPlayer:GetAttribute("FishDead") ~= true
        and LocalPlayer:GetAttribute("FishLocalDead") ~= true
        and LocalPlayer:GetAttribute("FishVictory") ~= true
        and LocalPlayer:GetAttribute("FishMedalOpen") ~= true then
        if a2 == Enum.UserInputState.Begin then
            u526 = true
            attemptFire()
        elseif a2 == Enum.UserInputState.End or a2 == Enum.UserInputState.Cancel then
            u526 = false
        end
        return Enum.ContextActionResult.Sink
    end
    u526 = false
    return Enum.ContextActionResult.Sink
end, true, v19)
ContextActionService:SetTitle("FishFire", "Shoot")
ContextActionService:SetPosition("FishFire", (UDim2.fromScale(0.73, -0.08)))
v19 = Enum.KeyCode.ButtonX
ContextActionService:BindAction("FishReload", function(a1, a2) -- Line: 1043 -- upvalues: u51 (ref), LocalPlayer (val), WeaponAction (val)
    if u51 > 0 then
        return Enum.ContextActionResult.Pass
    end
    if a2 == Enum.UserInputState.Begin
        and LocalPlayer:GetAttribute("FishResearchOpen") ~= true
        and LocalPlayer:GetAttribute("FishVictory") ~= true
        and LocalPlayer:GetAttribute("FishMedalOpen") ~= true then
        WeaponAction:FireServer("Reload")
    end
    return Enum.ContextActionResult.Sink
end, true, v19)
ContextActionService:SetTitle("FishReload", "Reload")
ContextActionService:SetPosition("FishReload", (UDim2.fromScale(0.25, 0.615)))

local function styleTouchAction(a1, a2) -- Line: 1057 -- types: a1: userdata, a2: number
    a1.AnchorPoint = Vector2.new(0.5, 0.5)
    a1.Size = UDim2.fromOffset(a2, a2)
    local ActionTitle = a1:FindFirstChild("ActionTitle", true)
    if ActionTitle and ActionTitle:IsA("TextLabel") then
        ActionTitle.Size = UDim2.fromScale(0.82, 0.82)
        ActionTitle.Position = UDim2.fromScale(0.09, 0.09)
        ActionTitle.TextScaled = true
        ActionTitle.TextWrapped = false
        ActionTitle.TextStrokeTransparency = 0
    end
end

local function layoutTouchActions() -- Line: 1071
    -- upvalues: UserInputService (val), Workspace (val), ContextActionService (val), styleTouchAction (val)
    if not UserInputService.TouchEnabled then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if not CurrentCamera then
        return
    end
    local ViewportSize = CurrentCamera.ViewportSize
    local v1 = math.floor((math.clamp((math.min(ViewportSize.X, ViewportSize.Y)) * 0.18, 62, 78)) + 0.5)
    local v2 = math.floor((math.clamp(v1 * 1.1, 68, 86)) + 0.5)
    local v3 = math.floor((math.clamp(v1 * 0.9, 56, 70)) + 0.5)
    local Button = ContextActionService:GetButton("FishFire")
    local Button_2 = ContextActionService:GetButton("FishReload")
    if Button then
        styleTouchAction(Button, v2)
    end
    if Button_2 then
        styleTouchAction(Button_2, v3)
    end
end

local function refreshTouchActions() -- Line: 1092
    -- upvalues: UserInputService (val), LocalPlayer (val), ContextActionService (val), u526 (ref)
    -- upvalues: layoutTouchActions (val)
    if not UserInputService.TouchEnabled then
        return
    end
    local v1 = false
    if LocalPlayer:GetAttribute("FishDead") ~= true then
        v1 = false
        if LocalPlayer:GetAttribute("FishLocalDead") ~= true then
            v1 = false
            if LocalPlayer:GetAttribute("FishResearchOpen") ~= true then
                v1 = false
                if LocalPlayer:GetAttribute("FishVictory") ~= true then
                    v1 = LocalPlayer:GetAttribute("FishMedalOpen") ~= true
                end
            end
        end
    end
    local Button = ContextActionService:GetButton("FishFire")
    local Button_2 = ContextActionService:GetButton("FishReload")
    if Button then
        Button.Visible = v1
    end
    if Button_2 then
        Button_2.Visible = v1
    end
    if not v1 then
        u526 = false
    end
    layoutTouchActions()
end

if UserInputService.TouchEnabled then
    task.defer(function() -- Line: 1108 -- upvalues: ContextActionService (val), RunService (val), refreshTouchActions (val)
        for i = 1, 12 do
            if ContextActionService:GetButton("FishFire") and ContextActionService:GetButton("FishReload") then
                break
            end
            RunService.Heartbeat:Wait()
        end
        refreshTouchActions()
    end)
    local v20 = Workspace.CurrentCamera
    if v20 then
        (v20:GetPropertyChangedSignal("ViewportSize")):Connect(layoutTouchActions)
    end
    ;(Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 1120 -- upvalues: layoutTouchActions (val)
        task.defer(layoutTouchActions)
    end)
end
;(LocalPlayer:GetAttributeChangedSignal("FishDead")):Connect(refreshTouchActions)
;(LocalPlayer:GetAttributeChangedSignal("FishLocalDead")):Connect(refreshTouchActions)
;(LocalPlayer:GetAttributeChangedSignal("FishResearchOpen")):Connect(refreshTouchActions)
;(LocalPlayer:GetAttributeChangedSignal("FishVictory")):Connect(refreshTouchActions)
;(LocalPlayer:GetAttributeChangedSignal("FishMedalOpen")):Connect(function() -- Line: 1128 -- upvalues: LocalPlayer (val), u526 (ref), refreshTouchActions (val)
    if LocalPlayer:GetAttribute("FishMedalOpen") == true then
        u526 = false
    end
    refreshTouchActions()
end)
local u903 = Workspace
local u904 = {}
local u905 = {}
local u906 = {}

local function rollSpecies(a1) -- Line: 1165 -- types: a1: userdata
    local v1 = a1:NextNumber()
    if v1 < 0.002 then
        return "Whale"
    end
    if v1 < 0.01 then
        return "Shark"
    end
    if v1 < 0.08 then
        return "BigFish"
    end
    return "Fish"
end

local function makeFish(a1, a2) -- Line: 1173 -- upvalues: u904 (val), u903 (ref) -- types: a1: string, a2: boolean
    local v1 = u904[a1]:Clone()
    local v2 = if not a2 then "Yard" .. a1 else "Flying" .. a1
    v1.Name = v2
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanTouch = false
    v1.CanQuery = false
    v1.CastShadow = false
    v1.Transparency = 1
    v1.Parent = u903
    return {active = false, part = v1, species = a1, baseSize = v1.Size}
end

local function buildPool(a1, a2, a3) -- Line: 1182
    -- upvalues: makeFish (val), u311 (val)
    local v1, v2, v3
    if a2 <= 0 then
        return
    end
    local v4 = math.max(1, (math.floor(a2 * 0.07 + 0.5)))
    local v5 = math.max(1, (math.floor(a2 * 0.008 + 0.5)))
    local v6 = math.max(1, (math.floor(a2 * 0.002 + 0.5)))
    for i = 1, a2 - v4 - v5 - v6 do
        table.insert(a1, (makeFish("Fish", a3)))
    end
    for j = 1, v4 do
        table.insert(a1, (makeFish("BigFish", a3)))
    end
    for k = 1, v5 do
        table.insert(a1, (makeFish("Shark", a3)))
    end
    for n = 1, v6 do
        table.insert(a1, (makeFish("Whale", a3)))
    end
    for m = #a1, 2, -1 do
        v1 = u311:NextInteger(1, m)
        v2 = a1[v1]
        v3 = a1[m]
        a1[m] = v2
        a1[v1] = v3
    end
end

buildPool(u905, 0, true)
buildPool(u906, 0, false)

local function claimEntry(a1, a2) -- Line: 1194 -- types: a2: string
    for i, v in ipairs(a1) do
        if not v.active and v.species == a2 then
            return v
        end
    end
    for i2, i3 in ipairs(a1) do
        if not i3.active and i3.species == "Fish" then
            return i3
        end
    end
    return nil
end

local function yardLand(a1, a2, a3) -- Line: 1200
    -- upvalues: u906 (val), claimEntry (val)
    if #u906 == 0 then
        return
    end
    local v1 = claimEntry(u906, a3) or u906[a2:NextInteger(1, #u906)]
    v1.active = true
    v1.part.Size = v1.baseSize
    v1.part.Transparency = 0
    v1.part.CFrame = (CFrame.new(a1)) * CFrame.Angles(a2:NextNumber(-0.25, 0.25), a2:NextNumber(0, 6.283185307179586), a2:NextNumber(-0.4, 0.4))
end

local FishStart = Workspace:WaitForChild("FishStart")
local FishEnd = Workspace:WaitForChild("FishEnd")
local u932 = {}
local u933 = {}
local u934 = 0
local u935 = 0
local u936 = nil
local u937 = nil

local function playPushEffect() -- Line: 1219
    -- upvalues: Workspace (val), u935 (ref), u936 (ref), u937 (ref), TweenService (val)
    local CurrentCamera = Workspace.CurrentCamera
    if not CurrentCamera then
        return
    end
    u935 = u935 + 1
    local u4 = u935
    if not u936 then
        u936 = CurrentCamera.FieldOfView
    end
    local u7 = u936
    if u937 then
        u937:Cancel()
    end
    task.spawn(function() -- Line: 1227
        -- upvalues: u937 (upval), TweenService (upval), CurrentCamera (val), u7 (val), u4 (val), u935 (upval)
        -- upvalues: Workspace (upval), u936 (upval)
        u937 = TweenService:Create(CurrentCamera, TweenInfo.new(0.055, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = u7 + 3.5})
        u937:Play()
        u937.Completed:Wait()
        if u4 == u935 and Workspace.CurrentCamera == CurrentCamera then
            u937 = TweenService:Create(
                CurrentCamera,
                TweenInfo.new(0.065, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {FieldOfView = u7 - 0.8}
            )
            u937:Play()
            u937.Completed:Wait()
            if u4 == u935 and Workspace.CurrentCamera == CurrentCamera then
                u937 = TweenService:Create(CurrentCamera, TweenInfo.new(0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {FieldOfView = u7})
                u937:Play()
                u937.Completed:Wait()
                if u4 == u935 then
                    u936 = nil
                    u937 = nil
                end
                return
            end
            return
        end
    end)
end

local function fishHeight(a1) -- Line: 1240
    return (math.max(0.35, a1.baseSize.Y * 0.25))
end

local function pointOnBeach(a1, a2, a3) -- Line: 1244 -- types: a1: userdata, a2: userdata, a3: number
    return a1.CFrame:PointToWorldSpace((Vector3.new(
        a2:NextNumber(-a1.Size.X * 0.35, a1.Size.X * 0.35),
        a1.Size.Y * 0.5 + a3,
        (a2:NextNumber(-a1.Size.Z * 0.46, a1.Size.Z * 0.46))
    )))
end

local function lanePoint(a1, a2, a3, a4) -- Line: 1248 -- types: a1: userdata, a2: vector, a3: userdata, a4: number
    local v1 = math.clamp(a1.CFrame:PointToObjectSpace(a2).Z + a3:NextNumber(-2, 2), -a1.Size.Z * 0.46, a1.Size.Z * 0.46)
    return a1.CFrame:PointToWorldSpace((Vector3.new(a3:NextNumber(-a1.Size.X * 0.35, a1.Size.X * 0.35), a1.Size.Y * 0.5 + a4, v1)))
end

local function holdingPoint(a1, a2) -- Line: 1254 -- types: a2: vector
    local v1 = math.clamp(a1.yardCF:PointToObjectSpace(a2).Z + a1.random:NextNumber(-2, 2), -a1.yardSize.Z * 0.38, a1.yardSize.Z * 0.38)
    return a1.yardCF:PointToWorldSpace((Vector3.new(
        a1.random:NextNumber(-a1.yardSize.X * 0.38, a1.yardSize.X * 0.38),
        a1.yardSize.Y * 0.5 + math.max(0.35, a1.baseSize.Y * 0.25),
        v1
    )))
end

local function configureMotion(a1, a2, a3, a4, a5) -- Line: 1260 -- types: a4: number, a5: number
    local Magnitude, durations, v1, v2, v3
    a1.points = a2
    a1.heights = a3
    a1.durations = {}
    a1.duration = 0
    local v4 = #a2 - 1
    for i = 1, v4 do
        v2 = a2[i]
        v3 = a2[i + 1]
        Magnitude = (Vector3.new(v3.X - v2.X, 0, v3.Z - v2.Z)).Magnitude
        durations = a1.durations
        v1 = Magnitude / a4
        durations[i] = (math.max(0.16, v1))
        a1.duration = a1.duration + a1.durations[i]
    end
    a1.finish = a2[#a2]
    a1.startTime = os.clock() + a5
    a1.moving = true
    a1.waitingStage = nil
    a1.pushPending = false
end

local function ballisticPosition(a1, a2, a3, a4, a5) -- Line: 1273
    -- upvalues: 
    local v1 = math.clamp(a5 * 8 / (a4 * a4), 4, 22)
    return (a1:Lerp(a2, a3 + (math.sin(a3 * 3.141592653589793 * 2)) * 0.58 / 6.283185307179586)) + Vector3.new(0, v1 * 0.5 * a4 * a4 * a3 * (1 - a3), 0)
end

local function beginPushedHop(a1, a2) -- Line: 1281
    -- upvalues: lanePoint (val), FishStart (val), FishEnd (val), holdingPoint (val), configureMotion (val)
    local Position = a1.part.Position
    a1.landingStage = a2 + 1
    configureMotion(a1, {
        Position,
        if a2 == 1 then lanePoint(FishStart, Position, a1.random, (math.max(0.35, a1.baseSize.Y * 0.25))) else if a2 ~= 2 then holdingPoint(a1, Position) else lanePoint(FishEnd, Position, a1.random, (math.max(0.35, a1.baseSize.Y * 0.25))),
    }, {a1.random:NextNumber(3.2, 4.2)}, 18, 0)
end

v6.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6, a7) -- Line: 1291
    -- upvalues: claimEntry (val), u905 (val), u932 (val), pointOnBeach (val), FishStart (val), configureMotion (val)
    local Unit, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local v12 = Random.new(a3)
    for i = 1, (math.min(a7, 0)) do
        v1 = v12:NextNumber()
        v1 = claimEntry(
            u905,
            if not (v1 < 0.002) then if not (v1 < 0.01) then if not (v1 < 0.08) then "Fish" else "BigFish" else "Shark" else "Whale"
        )
        if not v1 then
            break
        end
        v2 = (v13 + i * 7919) % 2147483647
        v1.random = Random.new(v2)
        v1.id = (tostring(v13)) .. ":" .. tostring(i)
        v1.active = true
        v1.part.Size = v1.baseSize
        v1.part.Transparency = 0
        v1.yardCF = v14
        v1.yardSize = v15
        v1.spin = v1.random:NextNumber(-4, 4)
        v1.landingStage = 1
        u932[v1.id] = v1
        v3 = v16.Y + 0.35
        v4 = math.min(7, (math.sqrt(v17)) * 0.4 + 2.5)
        v5 = Vector3.new(v16.X + v1.random:NextNumber(-v4, v4), v3, v16.Z + (v1.random:NextNumber(-v4, v4)))
        v6 = pointOnBeach(FishStart, v1.random, (math.max(0.35, v1.baseSize.Y * 0.25)))
        v7 = Vector3.new(v6.X - v5.X, 0, v6.Z - v5.Z)
        v8 = Vector3.new(-(if not (0.01 < v7.Magnitude) then Vector3.new(1, 0, 0) else v7.Unit).Z, 0, Unit.X)
        v9 = v1.random:NextNumber(-16, 16)
        v10 = (v5:Lerp(v6, 0.33)) + v8 * (v9 * 0.7)
        v11 = (v5:Lerp(v6, 0.66)) + v8 * v9
        v10 = Vector3.new(v10.X, v3, v10.Z)
        v11 = Vector3.new(v11.X, v3, v11.Z)
        configureMotion(v1, {v5, v10, v11, v6}, {
            v1.random:NextNumber(3.4, 4.2),
            v1.random:NextNumber(3, 3.8),
            (v1.random:NextNumber(2.6, 3.4)),
        }, 24, v1.random:NextNumber(0, (math.min(0.35, v17 * 0.003))))
    end
end)
FishPush.OnClientEvent:Connect(function(a1, a2) -- Line: 1317
    -- upvalues: u932 (val), beginPushedHop (val), LocalPlayer (val), Workspace (val), u935 (ref), u936 (ref)
    -- upvalues: u937 (ref), TweenService (val)
    local v1
    if typeof(a1) ~= "table" then
        return
    end
    local v2 = false
    for i, v in ipairs(a1) do
        if typeof(v) == "table" and typeof(v.Id) == "string" and typeof(v.Stage) == "number" then
            v1 = u932[v.Id]
            if v1 and v1.active and not v1.moving and v1.waitingStage == v.Stage then
                beginPushedHop(v1, v.Stage)
                v2 = true
            end
        end
    end
    if v2 and a2 == LocalPlayer.UserId then
        local CurrentCamera = Workspace.CurrentCamera
        if not CurrentCamera then
            return
        end
        u935 = u935 + 1
        local u26 = u935
        if not u936 then
            u936 = CurrentCamera.FieldOfView
        end
        local u29 = u936
        if u937 then
            u937:Cancel()
        end
        task.spawn(function() -- Line: 1227
            -- upvalues: u937 (upval), TweenService (upval), CurrentCamera (val), u29 (val), u26 (val), u935 (upval)
            -- upvalues: Workspace (upval), u936 (upval)
            u937 = TweenService:Create(
                CurrentCamera,
                TweenInfo.new(0.055, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {FieldOfView = u29 + 3.5}
            )
            u937:Play()
            u937.Completed:Wait()
            if u26 == u935 and Workspace.CurrentCamera == CurrentCamera then
                u937 = TweenService:Create(
                    CurrentCamera,
                    TweenInfo.new(0.065, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                    {FieldOfView = u29 - 0.8}
                )
                u937:Play()
                u937.Completed:Wait()
                if u26 == u935 and Workspace.CurrentCamera == CurrentCamera then
                    u937 = TweenService:Create(
                        CurrentCamera,
                        TweenInfo.new(0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                        {FieldOfView = u29}
                    )
                    u937:Play()
                    u937.Completed:Wait()
                    if u26 == u935 then
                        u936 = nil
                        u937 = nil
                    end
                    return
                end
                return
            end
        end)
    end
end)
local u974 = {}
v8.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 1333
    -- upvalues: u974 (val), u906 (val), Workspace (val), TweenService (val), u311 (val)
    if a1 == "Begin" then
        table.clear(u974)
        for i2, i3 in ipairs(u906) do
            if i3.active then
                table.insert(u974, i3)
            end
        end
        return
    end
    if a1 == "Suction" then
        local FishTruck = Workspace:FindFirstChild("FishTruck")
        local u44 = if not FishTruck then Workspace.TruckSystem.TruckStopToLoad.Position + Vector3.new(0, 3, 0) else if not FishTruck:IsA("Model") then Workspace.TruckSystem.TruckStopToLoad.Position + Vector3.new(0, 3, 0) else FishTruck:GetPivot().Position + Vector3.new(0, 3, 0)
        for i, v in ipairs(u974) do
            if v.active then
                task.delay((i - 1) % 35 * 0.035, function() -- Line: 1342 -- upvalues: v (val), TweenService (upval), u311 (upval), u44 (val)
                    if not v.active then
                        return
                    end
                    local v1 = TweenService:Create(v.part, TweenInfo.new(0.5 + u311:NextNumber(0, 0.35), Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        CFrame = (CFrame.new(u44 + Vector3.new(u311:NextNumber(-2, 2), u311:NextNumber(-1, 2), (u311:NextNumber(-2, 2))))) * CFrame.Angles(0, u311:NextNumber(0, 6.28), 0),
                        Size = v.part.Size * 0.25,
                    })
                    v1:Play()
                    v1.Completed:Wait()
                    v.part.Transparency = 1
                    v.active = false
                end)
            end
        end
    end
end)
RunService:BindToRenderStep("FishGameVisuals", Enum.RenderPriority.Camera.Value + 60, function(a1) -- Line: 1352
    -- upvalues: Workspace (val), u530 (ref), u522 (ref), Config (val), u523 (ref), ReloadRing (val), u527 (ref)
    -- upvalues: LocalPlayer (val), poseViewmodelLimbs (val), u532 (ref), ExclusiveWeaponEffects (val)
    -- upvalues: hideCharacter (val), PlayerGui (val), UserInputService (val), u526 (ref), attemptFire (val), u905 (val)
    -- upvalues: u932 (val), yardLand (val), u933 (ref), u934 (ref), FishPush (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera and u530 and u522 then
        v11 = Config.Guns[u523]
        local v15 = 0
        if u522.Reloading and u522.ReloadDuration and 0 < u522.ReloadDuration then
            v15 = math.clamp(((Workspace:GetServerTimeNow()) - u522.ReloadStartedAt) / u522.ReloadDuration, 0, 1)
        end
        local v16 = 0
        if v15 > 0 then
            if v15 < 0.14 then
                v12 = v15 / 0.14
                v16 = v12 * v12 * (3 - v12 * 2)
            elseif not (v15 < 0.82) then
                v12 = (v15 - 0.82) / 0.18
                v16 = 1 - v12 * v12 * (3 - v12 * 2)
            else
                v16 = 1
            end
        end
        ReloadRing.Visible = false
        u527 = u527 * math.exp(-a1 * 12)
        local Magnitude = 0
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Magnitude = Humanoid.MoveDirection.Magnitude
        end
        v13 = os.clock()
        v14 = CFrame.new(math.sin(v13 * 8) * 0.018 * Magnitude, math.abs((math.cos(v13 * 8))) * 0.018 * Magnitude, 0)
        v1 = (CFrame.new(0, 0, u527 * 0.08)) * CFrame.Angles(math.rad(u527 * 5), 0, 0)
        v2 = CFrame.new(0, v16 * -2.65, 0)
        u530:PivotTo(CurrentCamera.CFrame * v11.ViewOffset * v14 * v1 * v2 * v11.ModelRotation)
        poseViewmodelLimbs(CurrentCamera.CFrame * v14 * v1 * v2)
        if u532 then
            v3 = u532
            v4 = ExclusiveWeaponEffects.MuzzleCFrame(u530)
            if not v4 then
                local CFrame_2 = CurrentCamera.CFrame
                local MuzzleOffset = v11.MuzzleOffset or CFrame.new(0.62, -0.25, -2.9)
                v4 = CFrame_2 * MuzzleOffset * v14 * v1 * v2
            end
            v3.CFrame = v4
        end
        hideCharacter()
        local UpgradeShop = PlayerGui:FindFirstChild("UpgradeShop")
        local Index = PlayerGui:FindFirstChild("Index")
        v5 = true
        if LocalPlayer:GetAttribute("FishResearchOpen") ~= true then
            v5 = true
            if LocalPlayer:GetAttribute("FishReturnToLobbyOpen") ~= true then
                v5 = true
                if LocalPlayer:GetAttribute("FishMedalOpen") ~= true then
                    if not UpgradeShop then
                        v5 = Index and Index.Enabled == true
                    else
                        v5 = true
                        if UpgradeShop.Enabled ~= true then
                            v5 = Index and Index.Enabled == true
                        end
                    end
                end
            end
        end
        if not v5
            and LocalPlayer:GetAttribute("FishLocalDead") ~= true
            and LocalPlayer:GetAttribute("FishDevThirdPerson") ~= true then
            local UpgradeShop_2 = PlayerGui:FindFirstChild("UpgradeShop")
            local Index_2 = PlayerGui:FindFirstChild("Index")
            if not UpgradeShop_2 or UpgradeShop_2.Enabled ~= true then
                if not Index_2 or Index_2.Enabled ~= true then
                    UserInputService.MouseIconEnabled = false
                end
            end
        end
        if u526 and v11.Automatic then
            attemptFire()
        end
    end
    v11 = os.clock()
    for i, v in ipairs(u905) do
        if v.active and v.moving then
            v13 = v11 - v.startTime
            if v13 < 0 then
                v.part.Transparency = 1
            elseif not (v.duration <= v13) then
                v14 = v13
                v1 = 1
                while v1 < #v.durations do
                    if not (v.durations[v1] <= v14) then
                        break
                    end
                    v14 = v14 - v.durations[v1]
                    v1 = v1 + 1
                end
                v2 = v.durations[v1]
                v3 = math.clamp(v14 / v2, 0, 1)
                v4 = v.points[v1]
                v5 = v.points[v1 + 1]
                v6 = v.heights[v1]
                v8 = math.clamp(v6 * 8 / (v2 * v2), 4, 22)
                v7 = (v4:Lerp(v5, v3 + (math.sin(v3 * 3.141592653589793 * 2)) * 0.58 / 6.283185307179586)) + Vector3.new(0, v8 * 0.5 * v2 * v2 * v3 * (1 - v3), 0)
                v8 = math.min(1, v3 + 0.01)
                v10 = math.clamp(v6 * 8 / (v2 * v2), 4, 22)
                v9 = (v4:Lerp(v5, v8 + (math.sin(v8 * 3.141592653589793 * 2)) * 0.58 / 6.283185307179586)) + Vector3.new(0, v10 * 0.5 * v2 * v2 * v8 * (1 - v8), 0)
                v.part.Transparency = 0
                v.part.CFrame = (CFrame.lookAt(v7, v9)) * CFrame.Angles(0, 1.5707963267948966, v.spin * (v13 / v.duration))
            else
                v.part.Transparency = 0
                v.moving = false
                v.part.CFrame = (CFrame.new(v.finish)) * CFrame.Angles(v.random:NextNumber(-0.2, 0.2), v.random:NextNumber(0, 6.283185307179586), v.random:NextNumber(-0.35, 0.35))
                if not (4 <= v.landingStage) then
                    v.waitingStage = v.landingStage
                    v.pushPending = false
                else
                    v.part.Transparency = 1
                    v.active = false
                    u932[v.id] = nil
                    yardLand(v.finish, v.random, v.species)
                end
            end
        end
    end
    local Character_2 = LocalPlayer.Character
    local HumanoidRootPart = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        for i2, i3 in ipairs(u905) do
            if i3.active and not i3.moving and i3.waitingStage then
                if i3.pushPending and 0.8 < v11 - (i3.pushPendingAt or 0) then
                    i3.pushPending = false
                end
                v1 = i3.part.Position - HumanoidRootPart.Position
                if not i3.pushPending and (math.abs(v1.Y)) < 6 and Vector3.new(v1.X, 0, v1.Z).Magnitude <= 4.8 then
                    i3.pushPending = true
                    i3.pushPendingAt = v11
                    table.insert(u933, {Id = i3.id, Stage = i3.waitingStage})
                end
            end
        end
    end
    v12 = #u933
    if v12 > 0 and u934 <= v11 then
        v12 = math.min(32, #u933)
        local v17 = {}
        local v18 = {}
        for i4, j in ipairs(u933) do
            if not (i4 <= v12) then
                table.insert(v18, j)
            else
                table.insert(v17, j)
            end
        end
        u933 = v18
        u934 = v11 + 0.1
        FishPush:FireServer(v17)
    end
end)
local v21 = Workspace:WaitForChild("ActiveFish")
local v22 = Workspace:WaitForChild("DownedFish")
local u1038 = {}
local u1039 = {}

local function fishTailBones(a1) -- Line: 1473 -- upvalues: u1039 (val) -- types: a1: userdata
    local v1
    local v2 = u1039[a1]
    if v2 then
        return v2
    end
    local v3 = {}
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("Bone") then
            v3[v.Name] = v
        end
    end
    local v4 = {}
    for i2, i3 in ipairs({"Bone.002", "Bone.003", "Bone.004", "Bone.005"}) do
        v1 = v3[i3]
        if v1 then
            table.insert(v4, v1)
        end
    end
    u1039[a1] = v4
    return v4
end

local function animateFishRig(a1, a2, a3) -- Line: 1489
    -- upvalues: fishTailBones (val)
    local v1
    local Attribute = a1:GetAttribute("FishKind")
    if Attribute ~= "Fish" and Attribute ~= "GoldenFish" then
        return
    end
    local v2 = fishTailBones(a1)
    local v3 = true
    if a2 ~= "Swimming" then
        v3 = true
        if a2 ~= "Attacking" then
            v3 = a2 == "Retreating"
        end
    end
    if not v3 then
        for i2, i3 in ipairs(v2) do
            i3.Transform = CFrame.identity
        end
        return
    end
    local v4 = tonumber((a1:GetAttribute("SwimPhase"))) or 0
    local v5 = if a2 ~= "Attacking" then if Attribute ~= "GoldenFish" then 1 else 1.3 else 1.45
    local v6 = a3 * 7.5 * v5 + v4
    local v7 = {2.5, 4.5, 7.5, 11}
    for i, v in ipairs(v2) do
        v1 = (math.sin(v6 - (i - 1) * 0.42)) * v7[i]
        v.Transform = CFrame.Angles(0, 0, (math.rad(v1)))
    end
end

local function trackLaneFish(a1, a2) -- Line: 1508
    -- upvalues: Workspace (val), u1038 (val), Config (val)
    if not a1:IsA("Model") then
        return
    end
    local ServerTimeNow = Workspace:GetServerTimeNow()
    if a2 == "Swimming" then
        local Attribute = a1:GetAttribute("MotionStart")
        local Attribute_2 = a1:GetAttribute("MotionFinish")
        local Attribute_3 = a1:GetAttribute("MotionRotation")
        if typeof(Attribute) == "Vector3"
            and typeof(Attribute_2) == "Vector3"
            and typeof(Attribute_3) == "CFrame" then
            local v1 = Attribute_2 - Attribute
            local Unit = if not (0.01 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit
            u1038[a1] = {
                BlendDuration = 0.35,
                State = a2,
                Serial = a1:GetAttribute("MotionSerial"),
                Start = Attribute,
                Finish = Attribute_2,
                Direction = Unit,
                Right = Vector3.new(0, 1, 0):Cross(Unit).Unit,
                StartedAt = tonumber((a1:GetAttribute("MotionStartedAt"))) or ServerTimeNow,
                Duration = math.max(0.05, (tonumber((a1:GetAttribute("MotionDuration")))) or 0.05),
                Rotation = Attribute_3,
                Phase = tonumber((a1:GetAttribute("SwimPhase"))) or 0,
                Cycles = tonumber((a1:GetAttribute("SwimCycles"))) or 2.8,
                Sway = tonumber((a1:GetAttribute("SwimSway"))) or 0,
                Bob = tonumber((a1:GetAttribute("SwimBob"))) or 0,
                SpeedVariation = tonumber((a1:GetAttribute("SwimSpeedVariation"))) or 0,
                SpeedCycles = math.max(1, (tonumber((a1:GetAttribute("SwimSpeedCycles")))) or 2),
                JumpStartAlpha = a1:GetAttribute("JumpStartAlpha"),
                JumpDuration = math.max(0.05, (tonumber((a1:GetAttribute("JumpDuration")))) or 1),
                JumpHeight = tonumber((a1:GetAttribute("JumpHeight"))) or 0,
                SubmergeDepth = math.max(0, (tonumber((a1:GetAttribute("SubmergeDepth")))) or 0),
                SubmergeCycles = math.max(1, (tonumber((a1:GetAttribute("SubmergeCycles")))) or 1),
                SubmergeLateralDistance = math.max(0, (tonumber((a1:GetAttribute("SubmergeLateralDistance")))) or 0),
                SubmergeLateralCycles = math.max(0, (tonumber((a1:GetAttribute("SubmergeLateralCycles")))) or 0),
                SubmergeLateralPhase = tonumber((a1:GetAttribute("SubmergeLateralPhase"))) or 0,
                PreserveAuthoredMotion = a1:GetAttribute("PreserveAuthoredMotion") == true,
                BlendFrom = if a1:GetAttribute("FishKind") ~= "Gator" then nil else a1:GetPivot(),
                BlendStartedAt = ServerTimeNow,
            }
            return
        end
        return
    end
    if a2 == "GatorAlerting" then
        local Attribute_19 = a1:GetAttribute("MotionStart")
        local Attribute_20 = a1:GetAttribute("MotionRotation")
        if typeof(Attribute_19) == "Vector3" and typeof(Attribute_20) == "CFrame" then
            u1038[a1] = {
                State = a2,
                Serial = a1:GetAttribute("MotionSerial"),
                Position = Attribute_19,
                Rotation = Attribute_20,
                StartedAt = tonumber((a1:GetAttribute("MotionStartedAt"))) or ServerTimeNow,
                Duration = math.max(0.05, (tonumber((a1:GetAttribute("MotionDuration")))) or 0.05),
                StartPivot = a1:GetPivot(),
            }
            return
        end
        return
    end
    if a2 ~= "Attacking" and a2 ~= "Retreating" then
        if a2 == "Physics" then
            u1038[a1] = nil
            return
        end
        local Attribute_23 = a1:GetAttribute("LaunchPosition")
        local Attribute_24 = a1:GetAttribute("LandingPosition")
        local Attribute_25 = a1:GetAttribute("MotionRotation")
        if typeof(Attribute_23) == "Vector3"
            and typeof(Attribute_24) == "Vector3"
            and typeof(Attribute_25) == "CFrame" then
            local v2 = {
                State = a2,
                Serial = a1:GetAttribute("MotionSerial"),
                Launch = Attribute_23,
                Landing = Attribute_24,
                StartedAt = tonumber((a1:GetAttribute("MotionStartedAt"))) or ServerTimeNow,
                Duration = math.max(0.05, tonumber((a1:GetAttribute("MotionDuration"))) or Config.FishLane.LaunchDuration),
                Rotation = Attribute_25,
            }
            local LaunchHeight = tonumber((a1:GetAttribute("LaunchHeight"))) or Config.FishLane.LaunchHeight
            v2.Height = LaunchHeight
            v2.SettleDuration = math.max(0.05, (tonumber((a1:GetAttribute("SettleDuration")))) or 0.42)
            v2.Surface = a1:GetAttribute("LandingSurface") or "Water"
            u1038[a1] = v2
            return
        end
        return
    end
    local Attribute_30 = a1:GetAttribute("MotionStart")
    local Attribute_31 = a1:GetAttribute("MotionFinish")
    local Attribute_32 = a1:GetAttribute("MotionRotation")
    if typeof(Attribute_30) == "Vector3"
        and typeof(Attribute_31) == "Vector3"
        and typeof(Attribute_32) == "CFrame" then
        u1038[a1] = {
            State = a2,
            Serial = a1:GetAttribute("MotionSerial"),
            Start = Attribute_30,
            Finish = Attribute_31,
            StartedAt = tonumber((a1:GetAttribute("MotionStartedAt"))) or ServerTimeNow,
            Duration = math.max(0.05, (tonumber((a1:GetAttribute("MotionDuration")))) or 0.05),
            Rotation = Attribute_32,
        }
        return
    end
end

for i, v in ipairs(v21:GetChildren()) do
    trackLaneFish(v, v:GetAttribute("MotionState") or "Swimming")
end
for i2, i3 in ipairs(v22:GetChildren()) do
    trackLaneFish(i3, "Downed")
end
v21.ChildAdded:Connect(function(a1) -- Line: 1598 -- upvalues: trackLaneFish (val)
    trackLaneFish(a1, a1:GetAttribute("MotionState") or "Swimming")
end)
v22.ChildAdded:Connect(function(a1) -- Line: 1599 -- upvalues: trackLaneFish (val)
    trackLaneFish(a1, "Downed")
end)
v21.ChildRemoved:Connect(function(a1) -- Line: 1600 -- upvalues: u1038 (val), u1039 (val)
    if a1:IsA("Model") then
        u1038[a1] = nil
        u1039[a1] = nil
    end
end)
v22.ChildRemoved:Connect(function(a1) -- Line: 1606 -- upvalues: u1038 (val), u1039 (val)
    if a1:IsA("Model") then
        u1038[a1] = nil
        u1039[a1] = nil
    end
end)
RunService:BindToRenderStep("SmoothLaneFish", Enum.RenderPriority.Camera.Value + 20, function() -- Line: 1613
    -- upvalues: Workspace (val), u1038 (val), u1039 (val), trackLaneFish (val), animateFishRig (val)
    local Attribute, Attribute_2, Attribute_3, Direction, Direction_2, Position, Right, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23
    local ServerTimeNow = Workspace:GetServerTimeNow()
    for k2, i in pairs(u1038) do
        if k2.Parent then
            Attribute = k2:GetAttribute("MotionState") or i.State
            Attribute_2 = k2:GetAttribute("MotionSerial")
            if i.State ~= Attribute or i.Serial ~= Attribute_2 then
                trackLaneFish(k2, Attribute)
                i = u1038[k2]
            end
            if i then
                if k2.Parent then
                    animateFishRig(k2, i.State, ServerTimeNow)
                end
                if not k2.Parent then
                    if not k2.Parent then
                        if not k2.Parent then
                            if k2.Parent then
                                v20 = math.max(0, ServerTimeNow - i.StartedAt)
                                if v20 <= i.Duration then
                                    v21 = math.clamp(v20 / i.Duration, 0, 1)
                                    v22 = v21 * v21 * (3 - v21 * 2)
                                    v1 = i.Launch:Lerp(i.Landing, v21)
                                    v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                                    v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                                    v1 = v22 * 7.853981633974483
                                    v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                                    v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                                    k2:PivotTo(v5)
                                elseif i.Surface ~= "Land" then
                                    if not (v20 <= i.Duration + i.SettleDuration) then
                                        v21 = v20 - i.Duration - i.SettleDuration
                                        v22 = math.sin(v21 * 2.1) * 0.055
                                        v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                        v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                        k2:PivotTo(v3)
                                    else
                                        v21 = (v20 - i.Duration) / i.SettleDuration
                                        v22 = 1 - v21
                                        v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                        v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                        v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                        k2:PivotTo(v4)
                                    end
                                end
                            end
                        elseif i.State == "Attacking" or i.State == "Retreating" then
                            v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                            v22 = i.Finish - i.Start
                            v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                            k2:PivotTo(v2)
                        elseif k2.Parent then
                            v20 = math.max(0, ServerTimeNow - i.StartedAt)
                            if v20 <= i.Duration then
                                v21 = math.clamp(v20 / i.Duration, 0, 1)
                                v22 = v21 * v21 * (3 - v21 * 2)
                                v1 = i.Launch:Lerp(i.Landing, v21)
                                v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                                v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                                v1 = v22 * 7.853981633974483
                                v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                                v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                                k2:PivotTo(v5)
                            elseif i.Surface ~= "Land" then
                                if not (v20 <= i.Duration + i.SettleDuration) then
                                    v21 = v20 - i.Duration - i.SettleDuration
                                    v22 = math.sin(v21 * 2.1) * 0.055
                                    v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                    v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                    k2:PivotTo(v3)
                                else
                                    v21 = (v20 - i.Duration) / i.SettleDuration
                                    v22 = 1 - v21
                                    v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                    v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                    v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                    k2:PivotTo(v4)
                                end
                            end
                        end
                    elseif i.State == "GatorAlerting" then
                        Position = i.Position
                        Attribute_3 = k2:GetAttribute("MotionFacing")
                        if typeof(Attribute_3) == "Vector3" then
                            v22 = Attribute_3 - Position
                            if 0.01 < v22.Magnitude then
                                v23 = (CFrame.lookAt(Position, Position + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                                v1 = math.clamp((ServerTimeNow - i.StartedAt) / math.min(0.4, i.Duration), 0, 1)
                                v5 = i.StartPivot:Lerp(v23, v1 * v1 * (3 - v1 * 2))
                                k2:PivotTo(v5)
                            end
                        end
                    elseif not k2.Parent then
                        if k2.Parent then
                            v20 = math.max(0, ServerTimeNow - i.StartedAt)
                            if v20 <= i.Duration then
                                v21 = math.clamp(v20 / i.Duration, 0, 1)
                                v22 = v21 * v21 * (3 - v21 * 2)
                                v1 = i.Launch:Lerp(i.Landing, v21)
                                v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                                v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                                v1 = v22 * 7.853981633974483
                                v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                                v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                                k2:PivotTo(v5)
                            elseif i.Surface ~= "Land" then
                                if not (v20 <= i.Duration + i.SettleDuration) then
                                    v21 = v20 - i.Duration - i.SettleDuration
                                    v22 = math.sin(v21 * 2.1) * 0.055
                                    v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                    v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                    k2:PivotTo(v3)
                                else
                                    v21 = (v20 - i.Duration) / i.SettleDuration
                                    v22 = 1 - v21
                                    v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                    v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                    v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                    k2:PivotTo(v4)
                                end
                            end
                        end
                    elseif i.State == "Attacking" or i.State == "Retreating" then
                        v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                        v22 = i.Finish - i.Start
                        v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                        k2:PivotTo(v2)
                    elseif k2.Parent then
                        v20 = math.max(0, ServerTimeNow - i.StartedAt)
                        if v20 <= i.Duration then
                            v21 = math.clamp(v20 / i.Duration, 0, 1)
                            v22 = v21 * v21 * (3 - v21 * 2)
                            v1 = i.Launch:Lerp(i.Landing, v21)
                            v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                            v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                            v1 = v22 * 7.853981633974483
                            v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                            v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                            k2:PivotTo(v5)
                        elseif i.Surface ~= "Land" then
                            if not (v20 <= i.Duration + i.SettleDuration) then
                                v21 = v20 - i.Duration - i.SettleDuration
                                v22 = math.sin(v21 * 2.1) * 0.055
                                v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                k2:PivotTo(v3)
                            else
                                v21 = (v20 - i.Duration) / i.SettleDuration
                                v22 = 1 - v21
                                v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                k2:PivotTo(v4)
                            end
                        end
                    end
                elseif i.State == "Swimming" then
                    v20 = math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)
                    v21 = math.clamp(
                        v20 + (math.sin(v20 * 3.141592653589793 * 2 * i.SpeedCycles)) * i.SpeedVariation / (6.283185307179586 * i.SpeedCycles),
                        0,
                        1
                    )
                    v22 = v21 * 3.141592653589793 * 2 * i.Cycles + i.Phase
                    v23 = math.clamp(v20 / 0.08, 0, 1)
                    v1 = math.clamp((v20 - 0.9) / 0.1, 0, 1)
                    v2 = v23 * v23 * (3 - v23 * 2)
                    v3 = v1 * v1 * (3 - v1 * 2)
                    v4 = if not i.PreserveAuthoredMotion then (1 - v2) * -0.42 - v3 * 0.68 else 0
                    if 0 < i.SubmergeDepth then
                        v5 = math.clamp(math.abs((math.sin(v20 * 3.141592653589793 * i.SubmergeCycles))) / 0.32, 0, 1)
                        v4 = v4 - i.SubmergeDepth * (v5 * v5 * (3 - v5 * 2))
                    end
                    v5 = 0
                    v6 = nil
                    if typeof(i.JumpStartAlpha) == "number" and 0 <= i.JumpStartAlpha then
                        v7 = i.StartedAt + i.Duration * i.JumpStartAlpha
                        v8 = (ServerTimeNow - (v7 - 0.18)) / 0.18
                        if v8 >= 0 and v8 < 1 then
                            v4 = v4 - math.sin(v8 * 3.141592653589793) * 0.22
                        end
                        v9 = (ServerTimeNow - v7) / i.JumpDuration
                        if v9 >= 0 and v9 <= 1 then
                            v6 = v9
                            v5 = math.sin(v9 * 3.141592653589793) ^ 0.82 * i.JumpHeight
                        end
                    end
                    v7 = v20 * 3.141592653589793 * 2 * i.SubmergeLateralCycles + i.SubmergeLateralPhase
                    v8 = (math.sin(v7)) * i.SubmergeLateralDistance
                    v9 = if i.PreserveAuthoredMotion then 0 else if k2:GetAttribute("FishKind") ~= "Submarine" then (math.sin(v22)) * i.Sway else v8
                    v11 = (i.Start:Lerp(i.Finish, v21)) + i.Right * v9
                    v16 = math.sin(v22 * 2)
                    v10 = v11 + Vector3.new(0, 1, 0) * (v16 * i.Bob + v4 + v5)
                    v11 = math.max(1, (i.Finish - i.Start).Magnitude)
                    v12 = (math.cos(v7)) * i.SubmergeLateralDistance * 3.141592653589793 * 2 * i.SubmergeLateralCycles / v11
                    if not i.PreserveAuthoredMotion then
                        Direction_2 = i.Direction
                        Right = i.Right
                        v13 = Direction_2 + Right * (if k2:GetAttribute("FishKind") ~= "Submarine" then math.cos(v22) * 0.09 else v12)
                        v18 = v22 * 2
                        Direction = v13 + Vector3.new(0, 1, 0) * (math.cos(v18) * 0.018)
                    else
                        Direction = i.Direction
                    end
                    if v6 then
                        v17 = v6 * 3.141592653589793
                        Direction = Direction + Vector3.new(0, 1, 0) * (math.cos(v17) * 0.5)
                    end
                    v13 = if not v6 then 0 else (math.sin(v6 * 3.141592653589793 * 4)) * math.sin(v6 * 3.141592653589793) * 4
                    v14 = if not i.PreserveAuthoredMotion then math.rad((math.sin(v22 * 2)) * 4.5 + v13) else 0
                    v15 = (CFrame.lookAt(v10, v10 + Direction.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation * CFrame.Angles(v14, 0, 0)
                    if not i.BlendFrom then
                        k2:PivotTo(v15)
                    else
                        v16 = math.clamp((ServerTimeNow - i.BlendStartedAt) / i.BlendDuration, 0, 1)
                        v19 = i.BlendFrom:Lerp(v15, v16 * v16 * (3 - v16 * 2))
                        k2:PivotTo(v19)
                        if v16 >= 1 then
                            i.BlendFrom = nil
                        end
                    end
                elseif not k2.Parent then
                    if not k2.Parent then
                        if k2.Parent then
                            v20 = math.max(0, ServerTimeNow - i.StartedAt)
                            if v20 <= i.Duration then
                                v21 = math.clamp(v20 / i.Duration, 0, 1)
                                v22 = v21 * v21 * (3 - v21 * 2)
                                v1 = i.Launch:Lerp(i.Landing, v21)
                                v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                                v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                                v1 = v22 * 7.853981633974483
                                v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                                v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                                k2:PivotTo(v5)
                            elseif i.Surface ~= "Land" then
                                if not (v20 <= i.Duration + i.SettleDuration) then
                                    v21 = v20 - i.Duration - i.SettleDuration
                                    v22 = math.sin(v21 * 2.1) * 0.055
                                    v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                    v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                    k2:PivotTo(v3)
                                else
                                    v21 = (v20 - i.Duration) / i.SettleDuration
                                    v22 = 1 - v21
                                    v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                    v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                    v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                    k2:PivotTo(v4)
                                end
                            end
                        end
                    elseif i.State == "Attacking" or i.State == "Retreating" then
                        v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                        v22 = i.Finish - i.Start
                        v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                        k2:PivotTo(v2)
                    elseif k2.Parent then
                        v20 = math.max(0, ServerTimeNow - i.StartedAt)
                        if v20 <= i.Duration then
                            v21 = math.clamp(v20 / i.Duration, 0, 1)
                            v22 = v21 * v21 * (3 - v21 * 2)
                            v1 = i.Launch:Lerp(i.Landing, v21)
                            v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                            v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                            v1 = v22 * 7.853981633974483
                            v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                            v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                            k2:PivotTo(v5)
                        elseif i.Surface ~= "Land" then
                            if not (v20 <= i.Duration + i.SettleDuration) then
                                v21 = v20 - i.Duration - i.SettleDuration
                                v22 = math.sin(v21 * 2.1) * 0.055
                                v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                k2:PivotTo(v3)
                            else
                                v21 = (v20 - i.Duration) / i.SettleDuration
                                v22 = 1 - v21
                                v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                k2:PivotTo(v4)
                            end
                        end
                    end
                elseif i.State == "GatorAlerting" then
                    Position = i.Position
                    Attribute_3 = k2:GetAttribute("MotionFacing")
                    if typeof(Attribute_3) == "Vector3" then
                        v22 = Attribute_3 - Position
                        if 0.01 < v22.Magnitude then
                            v23 = (CFrame.lookAt(Position, Position + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                            v1 = math.clamp((ServerTimeNow - i.StartedAt) / math.min(0.4, i.Duration), 0, 1)
                            v5 = i.StartPivot:Lerp(v23, v1 * v1 * (3 - v1 * 2))
                            k2:PivotTo(v5)
                        end
                    end
                elseif not k2.Parent then
                    if k2.Parent then
                        v20 = math.max(0, ServerTimeNow - i.StartedAt)
                        if v20 <= i.Duration then
                            v21 = math.clamp(v20 / i.Duration, 0, 1)
                            v22 = v21 * v21 * (3 - v21 * 2)
                            v1 = i.Launch:Lerp(i.Landing, v21)
                            v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                            v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                            v1 = v22 * 7.853981633974483
                            v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                            v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                            k2:PivotTo(v5)
                        elseif i.Surface ~= "Land" then
                            if not (v20 <= i.Duration + i.SettleDuration) then
                                v21 = v20 - i.Duration - i.SettleDuration
                                v22 = math.sin(v21 * 2.1) * 0.055
                                v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                k2:PivotTo(v3)
                            else
                                v21 = (v20 - i.Duration) / i.SettleDuration
                                v22 = 1 - v21
                                v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                k2:PivotTo(v4)
                            end
                        end
                    end
                elseif i.State == "Attacking" or i.State == "Retreating" then
                    v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                    v22 = i.Finish - i.Start
                    v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                    k2:PivotTo(v2)
                elseif k2.Parent then
                    v20 = math.max(0, ServerTimeNow - i.StartedAt)
                    if v20 <= i.Duration then
                        v21 = math.clamp(v20 / i.Duration, 0, 1)
                        v22 = v21 * v21 * (3 - v21 * 2)
                        v1 = i.Launch:Lerp(i.Landing, v21)
                        v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                        v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                        v1 = v22 * 7.853981633974483
                        v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                        v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                        k2:PivotTo(v5)
                    elseif i.Surface ~= "Land" then
                        if not (v20 <= i.Duration + i.SettleDuration) then
                            v21 = v20 - i.Duration - i.SettleDuration
                            v22 = math.sin(v21 * 2.1) * 0.055
                            v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                            v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                            k2:PivotTo(v3)
                        else
                            v21 = (v20 - i.Duration) / i.SettleDuration
                            v22 = 1 - v21
                            v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                            v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                            v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                            k2:PivotTo(v4)
                        end
                    end
                end
            end
        else
            u1038[k2] = nil
            u1039[k2] = nil
            if k2.Parent then
                animateFishRig(k2, i.State, ServerTimeNow)
            end
            if not k2.Parent then
                if not k2.Parent then
                    if not k2.Parent then
                        if k2.Parent then
                            v20 = math.max(0, ServerTimeNow - i.StartedAt)
                            if v20 <= i.Duration then
                                v21 = math.clamp(v20 / i.Duration, 0, 1)
                                v22 = v21 * v21 * (3 - v21 * 2)
                                v1 = i.Launch:Lerp(i.Landing, v21)
                                v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                                v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                                v1 = v22 * 7.853981633974483
                                v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                                v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                                k2:PivotTo(v5)
                            elseif i.Surface ~= "Land" then
                                if not (v20 <= i.Duration + i.SettleDuration) then
                                    v21 = v20 - i.Duration - i.SettleDuration
                                    v22 = math.sin(v21 * 2.1) * 0.055
                                    v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                    v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                    k2:PivotTo(v3)
                                else
                                    v21 = (v20 - i.Duration) / i.SettleDuration
                                    v22 = 1 - v21
                                    v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                    v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                    v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                    k2:PivotTo(v4)
                                end
                            end
                        end
                    elseif i.State == "Attacking" or i.State == "Retreating" then
                        v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                        v22 = i.Finish - i.Start
                        v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                        k2:PivotTo(v2)
                    elseif k2.Parent then
                        v20 = math.max(0, ServerTimeNow - i.StartedAt)
                        if v20 <= i.Duration then
                            v21 = math.clamp(v20 / i.Duration, 0, 1)
                            v22 = v21 * v21 * (3 - v21 * 2)
                            v1 = i.Launch:Lerp(i.Landing, v21)
                            v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                            v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                            v1 = v22 * 7.853981633974483
                            v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                            v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                            k2:PivotTo(v5)
                        elseif i.Surface ~= "Land" then
                            if not (v20 <= i.Duration + i.SettleDuration) then
                                v21 = v20 - i.Duration - i.SettleDuration
                                v22 = math.sin(v21 * 2.1) * 0.055
                                v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                k2:PivotTo(v3)
                            else
                                v21 = (v20 - i.Duration) / i.SettleDuration
                                v22 = 1 - v21
                                v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                k2:PivotTo(v4)
                            end
                        end
                    end
                elseif i.State == "GatorAlerting" then
                    Position = i.Position
                    Attribute_3 = k2:GetAttribute("MotionFacing")
                    if typeof(Attribute_3) == "Vector3" then
                        v22 = Attribute_3 - Position
                        if 0.01 < v22.Magnitude then
                            v23 = (CFrame.lookAt(Position, Position + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                            v1 = math.clamp((ServerTimeNow - i.StartedAt) / math.min(0.4, i.Duration), 0, 1)
                            v5 = i.StartPivot:Lerp(v23, v1 * v1 * (3 - v1 * 2))
                            k2:PivotTo(v5)
                        end
                    end
                elseif not k2.Parent then
                    if k2.Parent then
                        v20 = math.max(0, ServerTimeNow - i.StartedAt)
                        if v20 <= i.Duration then
                            v21 = math.clamp(v20 / i.Duration, 0, 1)
                            v22 = v21 * v21 * (3 - v21 * 2)
                            v1 = i.Launch:Lerp(i.Landing, v21)
                            v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                            v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                            v1 = v22 * 7.853981633974483
                            v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                            v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                            k2:PivotTo(v5)
                        elseif i.Surface ~= "Land" then
                            if not (v20 <= i.Duration + i.SettleDuration) then
                                v21 = v20 - i.Duration - i.SettleDuration
                                v22 = math.sin(v21 * 2.1) * 0.055
                                v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                k2:PivotTo(v3)
                            else
                                v21 = (v20 - i.Duration) / i.SettleDuration
                                v22 = 1 - v21
                                v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                k2:PivotTo(v4)
                            end
                        end
                    end
                elseif i.State == "Attacking" or i.State == "Retreating" then
                    v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                    v22 = i.Finish - i.Start
                    v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                    k2:PivotTo(v2)
                elseif k2.Parent then
                    v20 = math.max(0, ServerTimeNow - i.StartedAt)
                    if v20 <= i.Duration then
                        v21 = math.clamp(v20 / i.Duration, 0, 1)
                        v22 = v21 * v21 * (3 - v21 * 2)
                        v1 = i.Launch:Lerp(i.Landing, v21)
                        v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                        v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                        v1 = v22 * 7.853981633974483
                        v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                        v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                        k2:PivotTo(v5)
                    elseif i.Surface ~= "Land" then
                        if not (v20 <= i.Duration + i.SettleDuration) then
                            v21 = v20 - i.Duration - i.SettleDuration
                            v22 = math.sin(v21 * 2.1) * 0.055
                            v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                            v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                            k2:PivotTo(v3)
                        else
                            v21 = (v20 - i.Duration) / i.SettleDuration
                            v22 = 1 - v21
                            v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                            v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                            v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                            k2:PivotTo(v4)
                        end
                    end
                end
            elseif i.State == "Swimming" then
                v20 = math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)
                v21 = math.clamp(
                    v20 + (math.sin(v20 * 3.141592653589793 * 2 * i.SpeedCycles)) * i.SpeedVariation / (6.283185307179586 * i.SpeedCycles),
                    0,
                    1
                )
                v22 = v21 * 3.141592653589793 * 2 * i.Cycles + i.Phase
                v23 = math.clamp(v20 / 0.08, 0, 1)
                v1 = math.clamp((v20 - 0.9) / 0.1, 0, 1)
                v2 = v23 * v23 * (3 - v23 * 2)
                v3 = v1 * v1 * (3 - v1 * 2)
                v4 = if not i.PreserveAuthoredMotion then (1 - v2) * -0.42 - v3 * 0.68 else 0
                if 0 < i.SubmergeDepth then
                    v5 = math.clamp(math.abs((math.sin(v20 * 3.141592653589793 * i.SubmergeCycles))) / 0.32, 0, 1)
                    v4 = v4 - i.SubmergeDepth * (v5 * v5 * (3 - v5 * 2))
                end
                v5 = 0
                v6 = nil
                if typeof(i.JumpStartAlpha) == "number" and 0 <= i.JumpStartAlpha then
                    v7 = i.StartedAt + i.Duration * i.JumpStartAlpha
                    v8 = (ServerTimeNow - (v7 - 0.18)) / 0.18
                    if v8 >= 0 and v8 < 1 then
                        v4 = v4 - math.sin(v8 * 3.141592653589793) * 0.22
                    end
                    v9 = (ServerTimeNow - v7) / i.JumpDuration
                    if v9 >= 0 and v9 <= 1 then
                        v6 = v9
                        v5 = math.sin(v9 * 3.141592653589793) ^ 0.82 * i.JumpHeight
                    end
                end
                v7 = v20 * 3.141592653589793 * 2 * i.SubmergeLateralCycles + i.SubmergeLateralPhase
                v8 = (math.sin(v7)) * i.SubmergeLateralDistance
                v9 = if i.PreserveAuthoredMotion then 0 else if k2:GetAttribute("FishKind") ~= "Submarine" then (math.sin(v22)) * i.Sway else v8
                v11 = (i.Start:Lerp(i.Finish, v21)) + i.Right * v9
                v16 = math.sin(v22 * 2)
                v10 = v11 + Vector3.new(0, 1, 0) * (v16 * i.Bob + v4 + v5)
                v11 = math.max(1, (i.Finish - i.Start).Magnitude)
                v12 = (math.cos(v7)) * i.SubmergeLateralDistance * 3.141592653589793 * 2 * i.SubmergeLateralCycles / v11
                if not i.PreserveAuthoredMotion then
                    Direction_2 = i.Direction
                    Right = i.Right
                    v13 = Direction_2 + Right * (if k2:GetAttribute("FishKind") ~= "Submarine" then math.cos(v22) * 0.09 else v12)
                    v18 = v22 * 2
                    Direction = v13 + Vector3.new(0, 1, 0) * (math.cos(v18) * 0.018)
                else
                    Direction = i.Direction
                end
                if v6 then
                    v17 = v6 * 3.141592653589793
                    Direction = Direction + Vector3.new(0, 1, 0) * (math.cos(v17) * 0.5)
                end
                v13 = if not v6 then 0 else (math.sin(v6 * 3.141592653589793 * 4)) * math.sin(v6 * 3.141592653589793) * 4
                v14 = if not i.PreserveAuthoredMotion then math.rad((math.sin(v22 * 2)) * 4.5 + v13) else 0
                v15 = (CFrame.lookAt(v10, v10 + Direction.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation * CFrame.Angles(v14, 0, 0)
                if not i.BlendFrom then
                    k2:PivotTo(v15)
                else
                    v16 = math.clamp((ServerTimeNow - i.BlendStartedAt) / i.BlendDuration, 0, 1)
                    v19 = i.BlendFrom:Lerp(v15, v16 * v16 * (3 - v16 * 2))
                    k2:PivotTo(v19)
                    if v16 >= 1 then
                        i.BlendFrom = nil
                    end
                end
            elseif not k2.Parent then
                if not k2.Parent then
                    if k2.Parent then
                        v20 = math.max(0, ServerTimeNow - i.StartedAt)
                        if v20 <= i.Duration then
                            v21 = math.clamp(v20 / i.Duration, 0, 1)
                            v22 = v21 * v21 * (3 - v21 * 2)
                            v1 = i.Launch:Lerp(i.Landing, v21)
                            v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                            v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                            v1 = v22 * 7.853981633974483
                            v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                            v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                            k2:PivotTo(v5)
                        elseif i.Surface ~= "Land" then
                            if not (v20 <= i.Duration + i.SettleDuration) then
                                v21 = v20 - i.Duration - i.SettleDuration
                                v22 = math.sin(v21 * 2.1) * 0.055
                                v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                                v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                                k2:PivotTo(v3)
                            else
                                v21 = (v20 - i.Duration) / i.SettleDuration
                                v22 = 1 - v21
                                v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                                v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                                v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                                k2:PivotTo(v4)
                            end
                        end
                    end
                elseif i.State == "Attacking" or i.State == "Retreating" then
                    v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                    v22 = i.Finish - i.Start
                    v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                    k2:PivotTo(v2)
                elseif k2.Parent then
                    v20 = math.max(0, ServerTimeNow - i.StartedAt)
                    if v20 <= i.Duration then
                        v21 = math.clamp(v20 / i.Duration, 0, 1)
                        v22 = v21 * v21 * (3 - v21 * 2)
                        v1 = i.Launch:Lerp(i.Landing, v21)
                        v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                        v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                        v1 = v22 * 7.853981633974483
                        v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                        v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                        k2:PivotTo(v5)
                    elseif i.Surface ~= "Land" then
                        if not (v20 <= i.Duration + i.SettleDuration) then
                            v21 = v20 - i.Duration - i.SettleDuration
                            v22 = math.sin(v21 * 2.1) * 0.055
                            v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                            v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                            k2:PivotTo(v3)
                        else
                            v21 = (v20 - i.Duration) / i.SettleDuration
                            v22 = 1 - v21
                            v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                            v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                            v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                            k2:PivotTo(v4)
                        end
                    end
                end
            elseif i.State == "GatorAlerting" then
                Position = i.Position
                Attribute_3 = k2:GetAttribute("MotionFacing")
                if typeof(Attribute_3) == "Vector3" then
                    v22 = Attribute_3 - Position
                    if 0.01 < v22.Magnitude then
                        v23 = (CFrame.lookAt(Position, Position + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                        v1 = math.clamp((ServerTimeNow - i.StartedAt) / math.min(0.4, i.Duration), 0, 1)
                        v5 = i.StartPivot:Lerp(v23, v1 * v1 * (3 - v1 * 2))
                        k2:PivotTo(v5)
                    end
                end
            elseif not k2.Parent then
                if k2.Parent then
                    v20 = math.max(0, ServerTimeNow - i.StartedAt)
                    if v20 <= i.Duration then
                        v21 = math.clamp(v20 / i.Duration, 0, 1)
                        v22 = v21 * v21 * (3 - v21 * 2)
                        v1 = i.Launch:Lerp(i.Landing, v21)
                        v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                        v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                        v1 = v22 * 7.853981633974483
                        v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                        v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                        k2:PivotTo(v5)
                    elseif i.Surface ~= "Land" then
                        if not (v20 <= i.Duration + i.SettleDuration) then
                            v21 = v20 - i.Duration - i.SettleDuration
                            v22 = math.sin(v21 * 2.1) * 0.055
                            v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                            v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                            k2:PivotTo(v3)
                        else
                            v21 = (v20 - i.Duration) / i.SettleDuration
                            v22 = 1 - v21
                            v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                            v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                            v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                            k2:PivotTo(v4)
                        end
                    end
                end
            elseif i.State == "Attacking" or i.State == "Retreating" then
                v21 = i.Start:Lerp(i.Finish, (math.clamp((ServerTimeNow - i.StartedAt) / i.Duration, 0, 1)))
                v22 = i.Finish - i.Start
                v2 = if not (0.01 < v22.Magnitude) then (CFrame.new(v21)) * i.Rotation else (CFrame.lookAt(v21, v21 + v22.Unit, (Vector3.new(0, 1, 0)))) * i.Rotation
                k2:PivotTo(v2)
            elseif k2.Parent then
                v20 = math.max(0, ServerTimeNow - i.StartedAt)
                if v20 <= i.Duration then
                    v21 = math.clamp(v20 / i.Duration, 0, 1)
                    v22 = v21 * v21 * (3 - v21 * 2)
                    v1 = i.Launch:Lerp(i.Landing, v21)
                    v5 = math.sin(v21 * 3.141592653589793) ^ 0.82
                    v23 = v1 + Vector3.new(0, 1, 0) * (v5 * i.Height)
                    v1 = v22 * 7.853981633974483
                    v2 = (math.sin(v21 * 3.141592653589793)) * -0.3141592653589793
                    v5 = (CFrame.new(v23)) * i.Rotation * (CFrame.Angles(v1, 0, v2))
                    k2:PivotTo(v5)
                elseif i.Surface ~= "Land" then
                    if not (v20 <= i.Duration + i.SettleDuration) then
                        v21 = v20 - i.Duration - i.SettleDuration
                        v22 = math.sin(v21 * 2.1) * 0.055
                        v23 = math.rad((math.sin(v21 * 1.35)) * 1.8 + 90)
                        v3 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (v22 + 0.12))) * i.Rotation * (CFrame.Angles(v23, 0, 0))
                        k2:PivotTo(v3)
                    else
                        v21 = (v20 - i.Duration) / i.SettleDuration
                        v22 = 1 - v21
                        v23 = math.sin(v21 * 3.141592653589793 * 3) * 0.28 * v22
                        v1 = math.rad(90 + (math.sin(v21 * 3.141592653589793 * 2)) * 9 * v22)
                        v4 = (CFrame.new(i.Landing + Vector3.new(0, 1, 0) * (0.12 + v23))) * i.Rotation * (CFrame.Angles(v1, 0, 0))
                        k2:PivotTo(v4)
                    end
                end
            end
        end
    end
end)

local function connectWeaponCharacter(a1) -- Line: 1747
    -- upvalues: LocalPlayer (val), u526 (ref), u529 (ref), u530 (ref), u531 (ref), u532 (ref), hideCharacter (val)
    -- upvalues: createViewmodel (val), u523 (ref), WeaponAction (val)
    LocalPlayer:SetAttribute("FishLocalDead", false)
    local Humanoid = a1:WaitForChild("Humanoid", 10)
    if Humanoid and Humanoid:IsA("Humanoid") then
        Humanoid.Died:Connect(function() -- Line: 1751
            -- upvalues: LocalPlayer (upval), u526 (upval), u529 (upval), u530 (upval), u531 (upval), u532 (upval)
            LocalPlayer:SetAttribute("FishLocalDead", true)
            u526 = false
            if u529 then
                u529:Destroy()
            end
            u529 = nil
            u530 = nil
            u531 = {}
            u532 = nil
        end)
    end
    task.wait(0.3)
    if a1 == LocalPlayer.Character and LocalPlayer:GetAttribute("FishDead") ~= true then
        hideCharacter()
        createViewmodel(u523)
        WeaponAction:FireServer("RequestState")
        return
    end
end

LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 1764 -- upvalues: connectWeaponCharacter (val)
    task.spawn(connectWeaponCharacter, a1)
end)
task.defer(function() -- Line: 1765 -- upvalues: hideCharacter (val), createViewmodel (val), u523 (ref), WeaponAction (val)
    hideCharacter()
    createViewmodel(u523)
    WeaponAction:FireServer("RequestState")
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.FishHUDClient
-- Took 0.09s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.FishHUDClient
-- Decompile time: 91.87 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FishHUD = PlayerGui:WaitForChild("FishHUD")
local SkipDayUI = PlayerGui:WaitForChild("SkipDayUI")
FishHUD.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
SkipDayUI.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
SkipDayUI.Enabled = false
SkipDayUI.ResetOnSpawn = false
local BossHealthBar_2 = FishHUD:FindFirstChild("BossHealthBar")
if BossHealthBar_2 and BossHealthBar_2:IsA("GuiObject") then
    BossHealthBar_2.Visible = false
end
local ShoalNotification_2 = FishHUD:FindFirstChild("ShoalNotification")
if ShoalNotification_2 and ShoalNotification_2:IsA("GuiObject") then
    ShoalNotification_2.Visible = false
end
local NormalNotification_2 = FishHUD:FindFirstChild("NormalNotification")
if NormalNotification_2 and NormalNotification_2:IsA("GuiObject") then
    NormalNotification_2.Visible = false
end

local function currentPackage() -- Line: 35 -- upvalues: ReplicatedStorage (val)
    local FishGame = ReplicatedStorage:WaitForChild("FishGame")
    assert(FishGame:IsA("Folder"), "ReplicatedStorage.FishGame must be a Folder")
    return FishGame
end

local FishGame = ReplicatedStorage:WaitForChild("FishGame")
assert(FishGame:IsA("Folder"), "ReplicatedStorage.FishGame must be a Folder")
local Config = require(FishGame:WaitForChild("Config"))
local Remotes = FishGame:WaitForChild("Remotes")
local StateUpdate = Remotes:WaitForChild("StateUpdate")
local HUDNotification = Remotes:WaitForChild("HUDNotification")
local SkipDayAction = Remotes:WaitForChild("SkipDayAction")
local Resources = FishHUD:FindFirstChild("Resources")
local Cash = if not Resources then nil else Resources:FindFirstChild("Cash")
local Amount = if not Cash then nil else Cash:FindFirstChild("Amount")
local LevelBar = FishHUD:FindFirstChild("LevelBar")
if LevelBar and LevelBar:IsA("GuiObject") then
    LevelBar.Visible = false
end
local Frame = FishHUD:WaitForChild("Frame")
local DayCounter = Frame:WaitForChild("DayCounter")
local TimeLeftInDay = Frame:WaitForChild("TimeLeftInDay")
Frame.Visible = LocalPlayer:GetAttribute("FishResearchOpen") ~= true
;(LocalPlayer:GetAttributeChangedSignal("FishResearchOpen")):Connect(function() -- Line: 56 -- upvalues: Frame (val), LocalPlayer (val)
    Frame.Visible = LocalPlayer:GetAttribute("FishResearchOpen") ~= true
end)
local BossHealthBar = FishHUD:WaitForChild("BossHealthBar")
local FillBar = BossHealthBar:WaitForChild("FillBar")
local BossName = BossHealthBar:WaitForChild("BossName")
local HealthAmount = BossHealthBar:WaitForChild("HealthAmount")
local ShoalNotification = FishHUD:WaitForChild("ShoalNotification")
local NormalNotification = FishHUD:WaitForChild("NormalNotification")
ShoalNotification.Text = "SOMETHING IS COMING..."
local u212 = UDim2.fromScale(1, 1)
local Size = ShoalNotification.Size
local Size_2 = NormalNotification.Size
local Position = NormalNotification.Position
local UIStroke = NormalNotification:FindFirstChildWhichIsA("UIStroke")
local Transparency = if not UIStroke then 0 else UIStroke.Transparency
local u222 = 1
local u223 = 0
local u224 = "Day"
local u225 = 0
local u226 = -1
local u227 = ""
local u228 = nil
local u229 = false
local u230 = ""
local u231 = {}
local u232 = {}
local u233 = false
local u234 = ""
local u235 = 0
local u236 = 0
local u237 = false
local Frame_2 = SkipDayUI:WaitForChild("Frame")
local DayCounter_2 = Frame_2:WaitForChild("DayCounter")
local SkipButton = Frame_2:WaitForChild("SkipButton")
local CloseButton = Frame_2:WaitForChild("CloseButton")
local glow = SkipButton:FindFirstChild("glow")
local Size_3 = Frame_2.Size
local Position_2 = Frame_2.Position
local Rotation = Frame_2.Rotation
local ImageTransparency = if not glow then 0 else glow.ImageTransparency
local u271 = 0
local u272 = 0
local u273 = 0
local u274 = false
local u275 = 0
local u276 = nil
BossHealthBar.Visible = false
FillBar.AnchorPoint = Vector2.new(0, 0.5)
FillBar.Position = UDim2.fromScale(0, 0.5)
FillBar.Size = u212
FillBar.ClipsDescendants = true
ShoalNotification.Visible = false
ShoalNotification.TextTransparency = 1
NormalNotification.RichText = true
NormalNotification.Visible = false
NormalNotification.TextTransparency = 1
local u304 = NormalNotification:Clone()
u304.Name = "ReturnWaitNotification"
u304.RichText = false
u304.Text = ""
u304.TextColor3 = Color3.new(1, 1, 1)
u304.TextWrapped = true
u304.AnchorPoint = Vector2.new(0.5, 0.5)
u304.Position = UDim2.fromScale(0.5, 0.15)
u304.Size = UDim2.fromScale(0.84, 0.06)
u304.ZIndex = 10
u304.BackgroundTransparency = 1
u304.Visible = false
u304.TextTransparency = 1
local UIStroke_2 = u304:FindFirstChildWhichIsA("UIStroke")
if UIStroke_2 then
    UIStroke_2.Color = Color3.new(0, 0, 0)
    UIStroke_2.Transparency = 0
end
u304.Parent = FishHUD
local u344 = 0
local u345 = nil

local function showReturnWait(a1) -- Line: 142 -- upvalues: u344 (ref), u345 (ref), u304 (val), TweenService (val)
    local Text_2
    if (if type(a1.Text) ~= "string" then "" else a1.Text) == "" then
        return
    end
    u344 = u344 + 1
    local u9 = u344
    if u345 then
        u345:Cancel()
    end
    u304.Text = Text_2
    u304.TextTransparency = 1
    u304.Visible = true
    u345 = TweenService:Create(u304, TweenInfo.new(0.18), {TextTransparency = 0})
    u345:Play()
    task.delay(2.7, function() -- Line: 155 -- upvalues: u9 (val), u344 (upval), u304 (upval), u345 (upval), TweenService (upval)
        if u9 == u344 and u304.Parent then
            u345 = TweenService:Create(u304, TweenInfo.new(0.2), {TextTransparency = 1})
            u345:Play()
            u345.Completed:Once(function() -- Line: 161 -- upvalues: u9 (upval), u344 (upval), u304 (upval)
                if u9 == u344 then
                    u304.Visible = false
                end
            end)
            return
        end
    end)
end

local function commas(a1) -- Line: 167 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.floor(a1 + 0.5)))
    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function scaledUDim2(a1, a2) -- Line: 176 -- types: a1: userdata, a2: number
    return UDim2.new(a1.X.Scale * a2, a1.X.Offset * a2, a1.Y.Scale * a2, a1.Y.Offset * a2)
end

local function offsetUDim2(a1, a2) -- Line: 185 -- types: a1: userdata, a2: number
    return UDim2.new(a1.X.Scale, a1.X.Offset, a1.Y.Scale + a2, a1.Y.Offset)
end

local function skipHiddenPosition() -- Line: 189 -- upvalues: Position_2 (val)
    return UDim2.new(Position_2.X.Scale - 0.18, Position_2.X.Offset, Position_2.Y.Scale, Position_2.Y.Offset)
end

local function playSkipOpenSound() -- Line: 198 -- upvalues: Config (val), SoundService (val), Debris (val)
    local Sound = Instance.new("Sound")
    Sound.Name = "SkipDayOpen"
    Sound.SoundId = Config.InterfaceSounds.OpenCloseSoundId
    Sound.Volume = Config.InterfaceSounds.OpenCloseSoundVolume * 0.55
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 6)
end

local function hideSkipPrompt(a1) -- Line: 208
    -- upvalues: u274 (ref), u275 (ref), u276 (ref), Frame_2 (val), Size_3 (val), Position_2 (val), Rotation (val)
    -- upvalues: SkipDayUI (val), TweenService (val)
    if not u274 then
        return
    end
    u274 = false
    u275 = u275 + 1
    local u5 = u275
    if u276 then
        u276:Cancel()
    end
    if not a1 then
        Frame_2.Size = Size_3
        Frame_2.Position = Position_2
        Frame_2.Rotation = Rotation
        SkipDayUI.Enabled = false
        return
    end
    local v1 = TweenService
    local v2 = Frame_2
    local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    local v4 = {}
    local v5 = Size_3
    v4.Size = UDim2.new(v5.X.Scale * 0.78, v5.X.Offset * 0.78, v5.Y.Scale * 0.78, v5.Y.Offset * 0.78)
    v4.Position = UDim2.new(Position_2.X.Scale - 0.18, Position_2.X.Offset, Position_2.Y.Scale, Position_2.Y.Offset)
    v4.Rotation = Rotation - 4
    u276 = v1:Create(v2, v3, v4)
    u276:Play()
    u276.Completed:Once(function() -- Line: 234
        -- upvalues: u5 (val), u275 (upval), u274 (upval), SkipDayUI (upval), Frame_2 (upval), Size_3 (upval)
        -- upvalues: Position_2 (upval), Rotation (upval)
        if u5 == u275 and not u274 then
            SkipDayUI.Enabled = false
            Frame_2.Size = Size_3
            Frame_2.Position = Position_2
            Frame_2.Rotation = Rotation
            return
        end
    end)
end

local function showSkipPrompt() -- Line: 243
    -- upvalues: u274 (ref), u275 (ref), u276 (ref), DayCounter_2 (val), u222 (ref), Frame_2 (val), Size_3 (val)
    -- upvalues: Position_2 (val), Rotation (val), glow (val), SkipDayUI (val), Config (val), SoundService (val)
    -- upvalues: Debris (val), TweenService (val), ImageTransparency (val)
    if u274 then
        return
    end
    u274 = true
    u275 = u275 + 1
    if u276 then
        u276:Cancel()
    end
    DayCounter_2.Text = "Skip Day " .. tostring(u222)
    local v1 = Size_3
    Frame_2.Size = UDim2.new(v1.X.Scale * 0.72, v1.X.Offset * 0.72, v1.Y.Scale * 0.72, v1.Y.Offset * 0.72)
    Frame_2.Position = UDim2.new(Position_2.X.Scale - 0.18, Position_2.X.Offset, Position_2.Y.Scale, Position_2.Y.Offset)
    Frame_2.Rotation = Rotation - 5
    if glow then
        glow.ImageTransparency = 1
    end
    SkipDayUI.Enabled = true
    local Sound = Instance.new("Sound")
    Sound.Name = "SkipDayOpen"
    Sound.SoundId = Config.InterfaceSounds.OpenCloseSoundId
    Sound.Volume = Config.InterfaceSounds.OpenCloseSoundVolume * 0.55
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 6)
    u276 = TweenService:Create(
        Frame_2,
        TweenInfo.new(0.46, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = Size_3, Position = Position_2, Rotation = Rotation}
    )
    u276:Play()
    if glow then
        TweenService:Create(
            glow,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageTransparency = ImageTransparency}
        ):Play()
    end
end

local function canShowSkipPrompt() -- Line: 276
    -- upvalues: u222 (ref), u224 (ref), u271 (ref), Workspace (val), u272 (ref), u273 (ref), LocalPlayer (val)
    local v1 = false
    if u222 > 0 then
        v1 = false
        if u224 == "Day" then
            v1 = false
            if u271 > 0 then
                v1 = false
                local ServerTimeNow = Workspace:GetServerTimeNow()
                if u271 <= ServerTimeNow then
                    v1 = false
                    if u272 ~= u222 then
                        v1 = false
                        if u273 ~= u222 then
                            v1 = false
                            if LocalPlayer:GetAttribute("FishDead") ~= true then
                                v1 = LocalPlayer:GetAttribute("FishLocalDead") ~= true
                            end
                        end
                    end
                end
            end
        end
    end
    return v1
end

local function refreshSkipPrompt() -- Line: 287
    -- upvalues: canShowSkipPrompt (val), showSkipPrompt (val), hideSkipPrompt (val)
    if canShowSkipPrompt() then
        showSkipPrompt()
        return
    end
    hideSkipPrompt(true)
end

CloseButton.Activated:Connect(function() -- Line: 302 -- upvalues: u222 (ref), u272 (ref), hideSkipPrompt (val)
    if u222 <= 0 then
        return
    end
    u272 = u222
    hideSkipPrompt(true)
end)
SkipButton.Activated:Connect(function() -- Line: 295
    -- upvalues: u274 (ref), canShowSkipPrompt (val), u273 (ref), u222 (ref), hideSkipPrompt (val), SkipDayAction (val)
    if u274 and canShowSkipPrompt() then
        u273 = u222
        hideSkipPrompt(true)
        SkipDayAction:FireServer("Skip", u222)
        return
    end
end)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 310
    -- upvalues: u274 (ref), canShowSkipPrompt (val), u273 (ref), u222 (ref), hideSkipPrompt (val), SkipDayAction (val)
    if not a2 and a1.KeyCode == Enum.KeyCode.G then
        if u274 then
            if not canShowSkipPrompt() then
                return
            end
            u273 = u222
            hideSkipPrompt(true)
            SkipDayAction:FireServer("Skip", u222)
        end
        return
    end
end)
;(LocalPlayer:GetAttributeChangedSignal("FishDead")):Connect(refreshSkipPrompt)
;(LocalPlayer:GetAttributeChangedSignal("FishLocalDead")):Connect(refreshSkipPrompt)

local function escapeRichText(a1) -- Line: 318
    return (string.gsub(string.gsub(string.gsub(string.gsub(tostring(a1 or ""), "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;"))
end

local function colorHex(a1) -- Line: 327 -- types: a1: UDim2
    return string.format("#%02X%02X%02X", math.floor(a1.R * 255 + 0.5), math.floor(a1.G * 255 + 0.5), (math.floor(a1.B * 255 + 0.5)))
end

local function accented(a1, a2) -- Line: 336 -- upvalues: escapeRichText (val) -- types: a2: UDim2
    return string.format(
        "<font color=\"%s\">%s</font>",
        string.format("#%02X%02X%02X", math.floor(a2.R * 255 + 0.5), math.floor(a2.G * 255 + 0.5), (math.floor(a2.B * 255 + 0.5))),
        (escapeRichText(a1))
    )
end

local u488 = nil

local function tutorialObjectiveText(a1, a2) -- Line: 342
    -- upvalues: Config (val), escapeRichText (val), accented (val)
    local HighlightColor = Config.Tutorial.HighlightColor
    if a1 == "ShootFish" then
        return "Shoot the " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(HighlightColor.R * 255 + 0.5),
            math.floor(HighlightColor.G * 255 + 0.5),
            (math.floor(HighlightColor.B * 255 + 0.5))
        ), (escapeRichText("fish")))
    end
    if a1 == "DogGetsFish" then
        return (string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(HighlightColor.R * 255 + 0.5),
            math.floor(HighlightColor.G * 255 + 0.5),
            (math.floor(HighlightColor.B * 255 + 0.5))
        ), (escapeRichText(a2)))) .. " gets the fish"
    end
    if a1 == "TakeFish" then
        return "Take the fish from " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(HighlightColor.R * 255 + 0.5),
            math.floor(HighlightColor.G * 255 + 0.5),
            (math.floor(HighlightColor.B * 255 + 0.5))
        ), (escapeRichText(a2)))
    end
    if a1 == "OpenCooler" then
        return "Open your " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(HighlightColor.R * 255 + 0.5),
            math.floor(HighlightColor.G * 255 + 0.5),
            (math.floor(HighlightColor.B * 255 + 0.5))
        ), (escapeRichText("cooler")))
    end
    if a1 == "GrabFishYourself" then
        return "You can also " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(HighlightColor.R * 255 + 0.5),
            math.floor(HighlightColor.G * 255 + 0.5),
            (math.floor(HighlightColor.B * 255 + 0.5))
        ), (escapeRichText("grab fish yourself")))
    end
    if a1 == "EnterWater" then
        return "Walk into the " .. (string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(HighlightColor.R * 255 + 0.5),
            math.floor(HighlightColor.G * 255 + 0.5),
            (math.floor(HighlightColor.B * 255 + 0.5))
        ), (escapeRichText("water")))) .. " to grab fish"
    end
    if a1 == "FishIncoming" then
        return accented("Survive the fish!", Config.Tutorial.FishIncomingColor)
    end
    if a1 == "Finished" then
        return "Waiting for teammates..."
    end
    return nil
end

local function playNotificationSound(a1, a2) -- Line: 364
    -- upvalues: Config (val), SoundService (val), Debris (val)
    local Sound = Instance.new("Sound")
    Sound.Name = "NormalNotificationSound"
    Sound.SoundId = a1 or Config.Notifications.SoundId
    Sound.Volume = a2 or Config.Notifications.SoundVolume
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 8)
end

local function playFishGrabSound() -- Line: 374 -- upvalues: Config (val), SoundService (val), Debris (val)
    local PickupFishSoundId = Config.InterfaceSounds.PickupFishSoundId
    local PickupFishSoundVolume = Config.InterfaceSounds.PickupFishSoundVolume
    local Sound = Instance.new("Sound")
    Sound.Name = "NormalNotificationSound"
    Sound.SoundId = PickupFishSoundId or Config.Notifications.SoundId
    Sound.Volume = PickupFishSoundVolume or Config.Notifications.SoundVolume
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 8)
end

local function presentTutorialObjective(a1, a2) -- Line: 381
    -- upvalues: u234 (ref), u235 (ref), tutorialObjectiveText (val), NormalNotification (val), u488 (ref)
    -- upvalues: TweenService (val), Size_2 (val), Position (val), UIStroke (val), Config (val), SoundService (val)
    -- upvalues: Debris (val), Transparency (val)
    local v1
    if u234 == a1 then
        return
    end
    u234 = a1
    u235 = u235 + 1
    local u5 = u235
    local v2 = tutorialObjectiveText(a1, a2)
    if not v2 then
        if not NormalNotification.Visible then
            task.defer(u488)
            return
        end
        local v3 = TweenService
        v1 = NormalNotification
        local v4 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local v5 = {TextTransparency = 1}
        local v6 = Size_2
        v5.Size = UDim2.new(v6.X.Scale * 0.9, v6.X.Offset * 0.9, v6.Y.Scale * 0.9, v6.Y.Offset * 0.9)
        v3 = v3:Create(v1, v4, v5)
        v3:Play()
        v3.Completed:Once(function() -- Line: 398
            -- upvalues: u5 (val), u235 (upval), u234 (upval), NormalNotification (upval), Size_2 (upval)
            -- upvalues: Position (upval), u488 (upval)
            if u5 == u235 and u234 == "" then
                NormalNotification.Visible = false
                NormalNotification.Size = Size_2
                NormalNotification.Position = Position
                NormalNotification.Rotation = 0
                task.defer(u488)
                return
            end
        end)
        return
    end
    NormalNotification.Text = v2
    v1 = Size_2
    NormalNotification.Size = UDim2.new(v1.X.Scale * 0.72, v1.X.Offset * 0.72, v1.Y.Scale * 0.72, v1.Y.Offset * 0.72)
    v1 = Position
    NormalNotification.Position = UDim2.new(v1.X.Scale, v1.X.Offset, v1.Y.Scale + 0.018, v1.Y.Offset)
    NormalNotification.Rotation = math.random(-2, 2)
    NormalNotification.TextTransparency = 1
    NormalNotification.Visible = true
    if UIStroke then
        UIStroke.Transparency = 1
    end
    if a1 ~= "FishIncoming" then
        local PickupFishSoundId = Config.InterfaceSounds.PickupFishSoundId
        local PickupFishSoundVolume = Config.InterfaceSounds.PickupFishSoundVolume
        local Sound = Instance.new("Sound")
        Sound.Name = "NormalNotificationSound"
        Sound.SoundId = PickupFishSoundId or Config.Notifications.SoundId
        Sound.Volume = PickupFishSoundVolume or Config.Notifications.SoundVolume
        Sound.Parent = SoundService
        SoundService:PlayLocalSound(Sound)
        Debris:AddItem(Sound, 8)
    end
    TweenService:Create(
        NormalNotification,
        TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Rotation = 0, TextTransparency = 0, Size = Size_2, Position = Position}
    ):Play()
    if UIStroke then
        TweenService:Create(UIStroke, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = Transparency}):Play()
    end
end

local function notificationText(a1) -- Line: 436 -- upvalues: Config (val), escapeRichText (val), commas (val)
    local v1, v2, v3, v4, v5, v6
    if type(a1) ~= "table" then
        return nil, 0
    end
    if a1.Kind == "Discovery" then
        local GoldColor = if a1.FishKind ~= "GoldenFish" then Config.Notifications.DiscoveryColor else Config.Notifications.GoldColor
        v5 = a1.Name or "Fish"
        return "You discovered: " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(GoldColor.R * 255 + 0.5),
            math.floor(GoldColor.G * 255 + 0.5),
            (math.floor(GoldColor.B * 255 + 0.5))
        ), (escapeRichText(v5))), 2.5
    end
    if a1.Kind == "BossReward" then
        v5 = "$" .. commas((math.max(0, (tonumber(a1.Reward)) or 0)))
        local MoneyColor = Config.Notifications.MoneyColor
        v4 = string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(MoneyColor.R * 255 + 0.5),
            math.floor(MoneyColor.G * 255 + 0.5),
            (math.floor(MoneyColor.B * 255 + 0.5))
        ), (escapeRichText(v5)))
        v6 = a1.BossName or "the boss"
        local BossColor = Config.Notifications.BossColor
        return "You earned " .. v4 .. " for killing " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(BossColor.R * 255 + 0.5),
            math.floor(BossColor.G * 255 + 0.5),
            (math.floor(BossColor.B * 255 + 0.5))
        ), (escapeRichText(v6))) .. "!", 3.25
    end
    if a1.Kind == "GoldenSpawn" then
        local GoldColor_2 = Config.Notifications.GoldColor
        return "A " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(GoldColor_2.R * 255 + 0.5),
            math.floor(GoldColor_2.G * 255 + 0.5),
            (math.floor(GoldColor_2.B * 255 + 0.5))
        ), (escapeRichText("Gold Fish"))) .. " has appeared!", 3
    end
    if a1.Kind == "GoldReward" then
        v5 = "$" .. commas((math.max(0, (tonumber(a1.Reward)) or 0)))
        local MoneyColor_2 = Config.Notifications.MoneyColor
        v4 = string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(MoneyColor_2.R * 255 + 0.5),
            math.floor(MoneyColor_2.G * 255 + 0.5),
            (math.floor(MoneyColor_2.B * 255 + 0.5))
        ), (escapeRichText(v5)))
        local GoldColor_3 = Config.Notifications.GoldColor
        return "You earned " .. v4 .. " for catching " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(GoldColor_3.R * 255 + 0.5),
            math.floor(GoldColor_3.G * 255 + 0.5),
            (math.floor(GoldColor_3.B * 255 + 0.5))
        ), (escapeRichText("Gold Fish"))) .. "!", 3.25
    end
    if a1.Kind == "DaySkipped" then
        v3 = a1.PlayerName or "A player"
        local DiscoveryColor = Config.Notifications.DiscoveryColor
        return string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(DiscoveryColor.R * 255 + 0.5),
            math.floor(DiscoveryColor.G * 255 + 0.5),
            (math.floor(DiscoveryColor.B * 255 + 0.5))
        ), (escapeRichText(v3))) .. " skipped the day!", 2.75
    end
    if a1.Kind == "DayEconomy" then
        v2 = string.format("Fish spawn increased: %.2f fish/sec", (math.max(0, (tonumber(a1.SpawnRate)) or 0)))
        local Species = a1.Species
        if type(Species) == "table" then
            v6 = tostring(Species.Name or "Fish")
            local DiscoveryColor_2 = Config.Notifications.DiscoveryColor
            v2 = v2 .. "\nNew species: " .. (string.format("<font color=\"%s\">%s</font>", string.format(
                "#%02X%02X%02X",
                math.floor(DiscoveryColor_2.R * 255 + 0.5),
                math.floor(DiscoveryColor_2.G * 255 + 0.5),
                (math.floor(DiscoveryColor_2.B * 255 + 0.5))
            ), (escapeRichText(v6)))) .. string.format(
                "  •  %d HP  •  $%d",
                math.floor((tonumber(Species.Health)) or 0),
                (math.floor((tonumber(Species.Value)) or 0))
            )
        end
        return v2, 4
    end
    if a1.Kind == "TsunamiWarning" then
        local FishIncomingColor = Config.Tutorial.FishIncomingColor
        return (string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(FishIncomingColor.R * 255 + 0.5),
            math.floor(FishIncomingColor.G * 255 + 0.5),
            (math.floor(FishIncomingColor.B * 255 + 0.5))
        ), (escapeRichText("TSUNAMI INCOMING!")))), (math.max(2.5, (tonumber(a1.Duration)) or 4))
    end
    if a1.Kind == "RiverEncounter" then
        v2 = (tostring(a1.Name or "Something hostile")) .. " incoming!"
        local FishIncomingColor_2 = Config.Tutorial.FishIncomingColor
        return string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(FishIncomingColor_2.R * 255 + 0.5),
            math.floor(FishIncomingColor_2.G * 255 + 0.5),
            (math.floor(FishIncomingColor_2.B * 255 + 0.5))
        ), (escapeRichText(v2))), 3.25
    end
    if a1.Kind == "RiverEncounterReward" then
        v1 = math.max(0, (math.floor((tonumber(a1.Reward)) or 0)))
        v4 = tostring(a1.Name or "River encounter")
        local DiscoveryColor_3 = Config.Notifications.DiscoveryColor
        v3 = string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(DiscoveryColor_3.R * 255 + 0.5),
            math.floor(DiscoveryColor_3.G * 255 + 0.5),
            (math.floor(DiscoveryColor_3.B * 255 + 0.5))
        ), (escapeRichText(v4)))
        local v7 = "$" .. commas(v1)
        local MoneyColor_3 = Config.Notifications.MoneyColor
        return v3 .. " defeated! Team earned " .. string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(MoneyColor_3.R * 255 + 0.5),
            math.floor(MoneyColor_3.G * 255 + 0.5),
            (math.floor(MoneyColor_3.B * 255 + 0.5))
        ), (escapeRichText(v7))), 3.5
    end
    if a1.Kind == "BalloonPilotLanding" then
        local DiscoveryColor_4 = Config.Notifications.DiscoveryColor
        return string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(DiscoveryColor_4.R * 255 + 0.5),
            math.floor(DiscoveryColor_4.G * 255 + 0.5),
            (math.floor(DiscoveryColor_4.B * 255 + 0.5))
        ), (escapeRichText("BALLOON PILOT LANDING!"))) .. " Hire him before nightfall.", 3.5
    end
    if a1.Kind == "TravelingMerchantArrival" then
        local DiscoveryColor_5 = Config.Notifications.DiscoveryColor
        return string.format("<font color=\"%s\">%s</font>", string.format(
            "#%02X%02X%02X",
            math.floor(DiscoveryColor_5.R * 255 + 0.5),
            math.floor(DiscoveryColor_5.G * 255 + 0.5),
            (math.floor(DiscoveryColor_5.B * 255 + 0.5))
        ), (escapeRichText("Traveling Merchant has arrived!"))), 3.5
    end
    if a1.Kind ~= "TeamUpgrade" then
        if a1.Kind == "Dodge" then
            return "Dodged", 0.65
        end
        if a1.Kind == "UpgradeReminder" then
            return "Buy some upgrades Twin", 2.5
        end
        return nil, 0
    end
    v1 = math.max(0, (math.floor((tonumber(a1.FromLevel)) or 0)))
    v4 = math.floor(tonumber(a1.ToLevel) or v1 + 1)
    v2 = math.max(v1 + 1, v4)
    v5 = a1.PlayerName or "A teammate"
    local DiscoveryColor_6 = Config.Notifications.DiscoveryColor
    v4 = string.format("<font color=\"%s\">%s</font>", string.format(
        "#%02X%02X%02X",
        math.floor(DiscoveryColor_6.R * 255 + 0.5),
        math.floor(DiscoveryColor_6.G * 255 + 0.5),
        (math.floor(DiscoveryColor_6.B * 255 + 0.5))
    ), (escapeRichText(v5)))
    v6 = a1.UpgradeName or "an upgrade"
    local MoneyColor_4 = Config.Notifications.MoneyColor
    return v4 .. " upgraded " .. (string.format("<font color=\"%s\">%s</font>", string.format(
        "#%02X%02X%02X",
        math.floor(MoneyColor_4.R * 255 + 0.5),
        math.floor(MoneyColor_4.G * 255 + 0.5),
        (math.floor(MoneyColor_4.B * 255 + 0.5))
    ), (escapeRichText(v6)))) .. string.format(": %d → %d", v1, v2), 1.25
end

function u488() -- Line: 502
    -- upvalues: u234 (ref), u233 (ref), u231 (val), u232 (val), notificationText (val), u488 (ref)
    -- upvalues: NormalNotification (val), Size_2 (val), Position (val), UIStroke (val), Config (val)
    -- upvalues: SoundService (val), Debris (val), TweenService (val), Transparency (val)
    if u234 == "" and not u233 then
        local v1
        local v2 = if not (#u231 > 0) then table.remove(u232, 1) else table.remove(u231, 1)
        if not v2 then
            return
        end
        local v3, v4 = notificationText(v2)
        if not v3 then
            task.defer(u488)
            return
        end
        u233 = true
        NormalNotification.Text = v3
        local v5 = Size_2
        NormalNotification.Size = UDim2.new(v5.X.Scale * 0.78, v5.X.Offset * 0.78, v5.Y.Scale * 0.78, v5.Y.Offset * 0.78)
        v5 = Position
        NormalNotification.Position = UDim2.new(v5.X.Scale, v5.X.Offset, v5.Y.Scale + 0.018, v5.Y.Offset)
        NormalNotification.Rotation = math.random(-2, 2)
        NormalNotification.TextTransparency = 1
        NormalNotification.Visible = true
        if UIStroke then
            UIStroke.Transparency = 1
        end
        local v6 = v2.Kind == "TeamUpgrade"
        if v2.Kind == "TsunamiWarning" then
            local WarningSoundId = Config.Shoals.WarningSoundId
            local WarningSoundVolume = Config.Shoals.WarningSoundVolume
            local Sound = Instance.new("Sound")
            Sound.Name = "NormalNotificationSound"
            Sound.SoundId = WarningSoundId or Config.Notifications.SoundId
            Sound.Volume = WarningSoundVolume or Config.Notifications.SoundVolume
            Sound.Parent = SoundService
            SoundService:PlayLocalSound(Sound)
            Debris:AddItem(Sound, 8)
        elseif v2.Kind == "BossReward" or v2.Kind == "GoldReward" then
            local BossRewardSoundId = Config.Feedback.BossRewardSoundId
            local BossRewardSoundVolume = Config.Feedback.BossRewardSoundVolume
            local Sound_4 = Instance.new("Sound")
            Sound_4.Name = "NormalNotificationSound"
            Sound_4.SoundId = BossRewardSoundId or Config.Notifications.SoundId
            Sound_4.Volume = BossRewardSoundVolume or Config.Notifications.SoundVolume
            Sound_4.Parent = SoundService
            SoundService:PlayLocalSound(Sound_4)
            Debris:AddItem(Sound_4, 8)
        elseif not v6 then
            local PickupFishSoundId = Config.InterfaceSounds.PickupFishSoundId
            local PickupFishSoundVolume = Config.InterfaceSounds.PickupFishSoundVolume
            local Sound_3 = Instance.new("Sound")
            Sound_3.Name = "NormalNotificationSound"
            Sound_3.SoundId = PickupFishSoundId or Config.Notifications.SoundId
            Sound_3.Volume = PickupFishSoundVolume or Config.Notifications.SoundVolume
            Sound_3.Parent = SoundService
            SoundService:PlayLocalSound(Sound_3)
            Debris:AddItem(Sound_3, 8)
        else
            local SoundId_2 = Config.Notifications.SoundId
            v5 = Config.Notifications.SoundVolume * 0.6
            local Sound_2 = Instance.new("Sound")
            Sound_2.Name = "NormalNotificationSound"
            Sound_2.SoundId = SoundId_2 or Config.Notifications.SoundId
            Sound_2.Volume = v5 or Config.Notifications.SoundVolume
            Sound_2.Parent = SoundService
            SoundService:PlayLocalSound(Sound_2)
            Debris:AddItem(Sound_2, 8)
        end
        local v7 = if not v6 then 0.38 else 0.16
        v5 = TweenService
        local v8 = NormalNotification
        local v9 = TweenInfo.new(v7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local v10 = {Rotation = 0, TextTransparency = 0}
        local v11 = Size_2
        v10.Size = UDim2.new(v11.X.Scale * 1.04, v11.X.Offset * 1.04, v11.Y.Scale * 1.04, v11.Y.Offset * 1.04)
        v10.Position = Position
        v5 = v5:Create(v8, v9, v10)
        v5:Play()
        if UIStroke then
            TweenService:Create(
                UIStroke,
                TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Transparency = Transparency}
            ):Play()
        end
        v5.Completed:Wait()
        TweenService:Create(NormalNotification, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Size_2}):Play()
        if not v6 then
            task.wait(v4)
        else
            v1 = 0
            while v1 < v4 do
                v8 = math.min(0.05, v4 - v1)
                task.wait(v8)
                v1 = v1 + v8
                if v1 >= 0.5 and (#u231 > 0 or #u232 > 0) then
                    break
                end
            end
        end
        v1 = if not v6 then 0.3 else 0.14
        v8 = TweenService
        v10 = NormalNotification
        local v12 = TweenInfo.new(v1, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        v11 = {TextTransparency = 1}
        local v13 = Size_2
        v11.Size = UDim2.new(v13.X.Scale * 0.9, v13.X.Offset * 0.9, v13.Y.Scale * 0.9, v13.Y.Offset * 0.9)
        v13 = Position
        v11.Position = UDim2.new(v13.X.Scale, v13.X.Offset, v13.Y.Scale + -0.015, v13.Y.Offset)
        v8 = v8:Create(v10, v12, v11)
        v8:Play()
        if UIStroke then
            TweenService:Create(UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
        end
        v8.Completed:Wait()
        NormalNotification.Visible = false
        NormalNotification.Size = Size_2
        NormalNotification.Position = Position
        NormalNotification.Rotation = 0
        u233 = false
        task.defer(u488)
        return
    end
end

local function queueNormalNotification(a1) -- Line: 600
    -- upvalues: showReturnWait (val), Config (val), SoundService (val), Debris (val), u232 (val), u231 (val)
    -- upvalues: u488 (ref)
    if type(a1) ~= "table" then
        return
    end
    if a1.Kind == "ReturnWait" then
        showReturnWait(a1)
        return
    end
    if a1.Kind == "GoldenSpawn" then
        local SpawnSoundId = Config.GoldenFish.SpawnSoundId
        local SpawnSoundVolume = Config.GoldenFish.SpawnSoundVolume
        local Sound = Instance.new("Sound")
        Sound.Name = "NormalNotificationSound"
        Sound.SoundId = SpawnSoundId or Config.Notifications.SoundId
        Sound.Volume = SpawnSoundVolume or Config.Notifications.SoundVolume
        Sound.Parent = SoundService
        SoundService:PlayLocalSound(Sound)
        Debris:AddItem(Sound, 8)
    elseif a1.Kind == "BossReward" then
        local BossRewardSoundId = Config.Feedback.BossRewardSoundId
        local BossRewardSoundVolume = Config.Feedback.BossRewardSoundVolume
        local Sound_2 = Instance.new("Sound")
        Sound_2.Name = "NormalNotificationSound"
        Sound_2.SoundId = BossRewardSoundId or Config.Notifications.SoundId
        Sound_2.Volume = BossRewardSoundVolume or Config.Notifications.SoundVolume
        Sound_2.Parent = SoundService
        SoundService:PlayLocalSound(Sound_2)
        Debris:AddItem(Sound_2, 8)
    end
    if a1.Kind ~= "TeamUpgrade" then
        table.insert(u231, a1)
    else
        table.insert(u232, a1)
    end
    u488()
end

local function update(a1) -- Line: 619
    -- upvalues: Amount (val), commas (val), LevelBar (val), u222 (ref), u273 (ref), u223 (ref), u271 (ref), u224 (ref)
    -- upvalues: u225 (ref), presentTutorialObjective (val), u236 (ref), Config (val), LocalPlayer (val), FishHUD (val)
    -- upvalues: DayCounter (val), u226 (ref), u227 (ref), SoundService (val), Debris (val), ShoalNotification (val)
    -- upvalues: Size (val), TweenService (val), u229 (ref), u230 (ref), BossName (val), HealthAmount (val), u228 (ref)
    -- upvalues: FillBar (val), u212 (val), BossHealthBar (val)
    local v1
    local v2 = math.max(tonumber(a1.TeamCash) or 0, 0)
    if Amount then
        Amount.Text = "$" .. commas(v2)
    end
    if LevelBar and LevelBar:IsA("GuiObject") then
        LevelBar.Visible = false
    end
    local v3 = u222
    u222 = math.max(1, (math.floor((tonumber(a1.Day)) or 1)))
    if u222 ~= v3 then
        u273 = 0
    end
    u223 = tonumber(a1.DayEndsAt) or 0
    u271 = tonumber(a1.SkipDayAvailableAt) or 0
    u224 = tostring(a1.Phase or "Day")
    u225 = tonumber(a1.PhaseEndsAt) or 0
    presentTutorialObjective(
        if a1.TutorialActive ~= true then "" else tostring(a1.TutorialStage or ""),
        (tostring(a1.TutorialDogName or "Waffles"))
    )
    u236 = 0
    if type(a1.Upgrades) == "table" then
        for k, v in pairs(a1.Upgrades) do
            u236 = u236 + math.max(0, (math.floor((tonumber(v)) or 0)))
        end
    end
    if u222 ~= 2 or u224 ~= "Day" or Config.Tutorial.DayTwoUpgradeReminderMaximumLevels < u236 then
        LocalPlayer:SetAttribute("FishUpgradeReminderActive", false)
    end
    FishHUD:SetAttribute("DisplayedPhase", u224)
    FishHUD:SetAttribute("DisplayedDayEndsAt", u223)
    DayCounter.Text = "Day " .. tostring(u222)
    u226 = -1
    local Boss_2 = if type(a1.Boss) ~= "table" then nil else a1.Boss
    local v4 = false
    if Boss_2 ~= nil then
        v4 = Boss_2.Active == true
    end
    local v5 = if tostring(a1.DayEventWarning or "") ~= "Tsunami" then if a1.ShoalWarning ~= true then "" else "Shoal" else "Tsunami"
    if v5 ~= u227 then
        u227 = v5
        if v5 == "" then
            v1 = TweenService:Create(
                ShoalNotification,
                TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 1}
            )
            v1:Play()
            v1.Completed:Once(function() -- Line: 690 -- upvalues: u227 (upval), ShoalNotification (upval)
                if u227 == "" then
                    ShoalNotification.Visible = false
                end
            end)
        else
            if v5 == "Shoal" or v5 == "Tsunami" then
                local Sound = Instance.new("Sound")
                Sound.Name = v5 .. "Warning"
                Sound.SoundId = Config.Shoals.WarningSoundId
                Sound.Volume = Config.Shoals.WarningSoundVolume
                Sound.Parent = SoundService
                SoundService:PlayLocalSound(Sound)
                Debris:AddItem(Sound, 10)
            end
            ShoalNotification.Text = if v5 ~= "Tsunami" then "THE SHOAL IS COMING..." else "TSUNAMI INCOMING!"
            ShoalNotification.Visible = true
            ShoalNotification.TextTransparency = 1
            ShoalNotification.Size = UDim2.new(Size.X.Scale * 0.9, Size.X.Offset * 0.9, Size.Y.Scale * 0.9, Size.Y.Offset * 0.9)
            TweenService:Create(
                ShoalNotification,
                TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {TextTransparency = 0, Size = Size}
            ):Play()
        end
    end
    if not v4 or not Boss_2 then
        if u228 then
            u228:Cancel()
            u228 = nil
        end
        FillBar.Size = u212
        u230 = ""
    else
        v1 = math.max(0, (tonumber(Boss_2.Health)) or 0)
        local v6 = math.max(1, (tonumber(Boss_2.MaxHealth)) or 1)
        local v7 = math.clamp(v1 / v6, 0, 1)
        local v8 = tostring(Boss_2.Name or "BOSS")
        local v9 = not u229 or v8 ~= u230
        u230 = v8
        BossName.Text = v8
        HealthAmount.Text = (commas(v1)) .. " / " .. commas(v6)
        local v10 = UDim2.new(v7, 0, 1, 0)
        if u228 then
            u228:Cancel()
        end
        if not v9 then
            u228 = TweenService:Create(FillBar, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = v10})
            u228:Play()
        else
            FillBar.Size = v10
        end
    end
    u229 = v4
    BossHealthBar.Visible = v4 and u224 == "Boss"
end

local function refreshUpgradeReminder() -- Line: 729
    -- upvalues: u237 (ref), u222 (ref), u224 (ref), u223 (ref), Config (val), Workspace (val), u236 (ref)
    -- upvalues: LocalPlayer (val), queueNormalNotification (val)
    if not u237 and u222 == 2 and u224 == "Day" then
        local v1 = u223 - Config.DayDurationForDay(u222)
        if (Workspace:GetServerTimeNow()) < v1 + Config.Tutorial.DayTwoUpgradeReminderDelay then
            return
        end
        u237 = true
        if u236 <= Config.Tutorial.DayTwoUpgradeReminderMaximumLevels
            and LocalPlayer:GetAttribute("FishResearchOpen") ~= true then
            LocalPlayer:SetAttribute("FishUpgradeReminderActive", true)
            queueNormalNotification({Kind = "UpgradeReminder"})
        end
        return
    end
end

local function updateDayTimer() -- Line: 743
    -- upvalues: LocalPlayer (val), u224 (ref), TimeLeftInDay (val), u223 (ref), u225 (ref), Workspace (val)
    -- upvalues: FishHUD (val), u226 (ref)
    if LocalPlayer:GetAttribute("OnboardingV2Active") == true and u224 == "Day" then
        TimeLeftInDay.Text = "PRACTICE"
        return
    end
    if u224 ~= "Day" then
        local v1 = if u224 == "Dusk" then "NIGHT" else if u224 == "BossIntro" then "NIGHT" else if u224 ~= "Boss" then if u224 ~= "BossReward" then if u224 ~= "Dawn" then u224 else "DAWN" else "CLEAR" else "NIGHT"
        if TimeLeftInDay.Text ~= v1 then
            TimeLeftInDay.Text = v1
        end
        return
    end
    local v2 = math.max(0, (math.ceil((if u224 ~= "Day" then u225 else u223) - (Workspace:GetServerTimeNow()))))
    FishHUD:SetAttribute("DisplayedTimerSeconds", v2)
    if v2 == u226 then
        return
    end
    u226 = v2
    TimeLeftInDay.Text = string.format("%02d:%02d", math.floor(v2 / 60), v2 % 60)
end

FishHUD.Enabled = true
LocalPlayer:SetAttribute("FishUpgradeReminderActive", false)
;(LocalPlayer:GetAttributeChangedSignal("FishResearchOpen")):Connect(function() -- Line: 766 -- upvalues: LocalPlayer (val)
    if LocalPlayer:GetAttribute("FishResearchOpen") == true then
        LocalPlayer:SetAttribute("FishUpgradeReminderActive", false)
    end
end)
HUDNotification.OnClientEvent:Connect(queueNormalNotification)
StateUpdate.OnClientEvent:Connect(function(a1) -- Line: 772
    -- upvalues: update (val), updateDayTimer (val), canShowSkipPrompt (val), showSkipPrompt (val), hideSkipPrompt (val)
    if type(a1) == "table" then
        update(a1)
        updateDayTimer()
        if canShowSkipPrompt() then
            showSkipPrompt()
            return
        end
        hideSkipPrompt(true)
    end
end)
task.spawn(function() -- Line: 779
    -- upvalues: updateDayTimer (val), canShowSkipPrompt (val), showSkipPrompt (val), hideSkipPrompt (val)
    -- upvalues: refreshUpgradeReminder (val)
    while task.wait(0.1) do
        updateDayTimer()
        if not canShowSkipPrompt() then
            hideSkipPrompt(true)
        else
            showSkipPrompt()
        end
        refreshUpgradeReminder()
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.HazardEffectsClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.HazardEffectsClient
-- Decompile time: 15.29 ms

local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local FishGame = ReplicatedStorage:WaitForChild("FishGame")
local HazardFX = FishGame:WaitForChild("Remotes"):WaitForChild("HazardFX")
local Hazards = (FishGame:WaitForChild("Assets")):WaitForChild("Hazards")
local u56 = 0
local u57 = {"rbxassetid://660418993", "rbxassetid://660419217", "rbxassetid://660419412"}
local u61 = {
    Explosion = 100,
    Smoke1 = 70,
    Smoke2 = 70,
    Sparks5 = 150,
    Sparks2 = 250,
    Sparks3 = 250,
    Sparks4 = 250,
}

local function playWaterSplash(a1, a2) -- Line: 33
    -- upvalues: Hazards (val), Workspace (val), Debris (val)
    local WaterSplashParticles = Hazards:FindFirstChild("WaterSplashParticles")
    if WaterSplashParticles and WaterSplashParticles:IsA("Attachment") then
        local v1
        local Part = Instance.new("Part")
        Part.Name = "SustainedWaterSplashLocal"
        Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        Part.Transparency = 1
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanTouch = false
        Part.CanQuery = false
        Part.CFrame = CFrame.new(a1)
        Part.Parent = Workspace
        local u27 = WaterSplashParticles:Clone()
        u27.Parent = Part
        local v2 = 0
        local v3 = math.clamp(a2, 0.1, 5)
        for i, v in ipairs(u27:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true
                v1 = math.max(60, (math.floor(v.Rate * v3)))
                v:Emit(v1)
                v2 = math.max(v2, v.Lifetime.Max)
            end
        end
        task.delay(v3, function() -- Line: 57 -- upvalues: u27 (val)
            if not u27.Parent then
                return
            end
            for i, v in ipairs(u27:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end)
        Debris:AddItem(Part, v3 + v2 + 0.25)
        return
    end
end

local function playFlashbangBurst(a1) -- Line: 66
    -- upvalues: Hazards (val), Workspace (val), u61 (val), Debris (val)
    local Flashbang = Hazards:FindFirstChild("Flashbang")
    local Handle = Flashbang and Flashbang:FindFirstChild("Handle")
    if Handle and Handle:IsA("BasePart") then
        local v1
        local v2 = Handle:Clone()
        v2.Name = "FlashbangBurstLocal"
        for i, v in ipairs(v2:GetDescendants()) do
            if v:IsA("LuaSourceContainer") or v:IsA("JointInstance") then
                v:Destroy()
            end
        end
        v2.Transparency = 1
        v2.Anchored = true
        v2.CanCollide = false
        v2.CanTouch = false
        v2.CanQuery = false
        v2.CFrame = CFrame.new(a1)
        v2.Parent = Workspace
        local PointLight = Instance.new("PointLight")
        PointLight.Brightness = 8
        PointLight.Range = 100
        PointLight.Color = Color3.new(1, 1, 1)
        PointLight.Parent = v2
        for i2, i3 in ipairs(v2:GetDescendants()) do
            if i3:IsA("ParticleEmitter") then
                i3.Enabled = false
                v1 = u61[i3.Name]
                i3:Emit(v1 or 20)
            elseif i3:IsA("Trail") then
                i3.Enabled = false
            elseif i3:IsA("Sound") then
                if i3.Name == "Explode" or i3.Name == "Dist" then
                    i3.TimePosition = 0
                    i3:Play()
                end
            end
        end
        task.delay(0.08, function() -- Line: 104 -- upvalues: PointLight (val)
            if PointLight.Parent then
                PointLight.Enabled = false
            end
        end)
        Debris:AddItem(v2, 6)
        return
    end
end

local function blindPlayer(a1, a2) -- Line: 110
    -- upvalues: u56 (ref), LocalPlayer (val), Lighting (val), u57 (val), SoundService (val), Debris (val)
    -- upvalues: TweenService (val)
    u56 = u56 + 1
    local u4 = u56
    local v1 = math.clamp(a1, 0.15, 5)
    local v2 = math.clamp(a2 / 5, 0.08, 1)
    local FlashbangBlind = LocalPlayer.PlayerGui:FindFirstChild("FlashbangBlind")
    if FlashbangBlind then
        FlashbangBlind:Destroy()
    end
    local FlashbangBlindCorrection = Lighting:FindFirstChild("FlashbangBlindCorrection")
    if FlashbangBlindCorrection then
        FlashbangBlindCorrection:Destroy()
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FlashbangBlind"
    ScreenGui.DisplayOrder = 10000
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    local Frame = Instance.new("Frame")
    Frame.Name = "Whiteout"
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame.BackgroundTransparency = 1 - v2 * 0.97
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    ScreenGui.Parent = LocalPlayer.PlayerGui
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Name = "FlashbangBlindCorrection"
    ColorCorrectionEffect.Brightness = v2
    ColorCorrectionEffect.Contrast = v2 * 0.35
    ColorCorrectionEffect.Saturation = -v2
    ColorCorrectionEffect.Parent = Lighting
    local Sound = Instance.new("Sound")
    Sound.Name = "FlashbangRinging"
    Sound.SoundId = u57[math.random(1, #u57)]
    Sound.Volume = 0.2
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, v1 + 2)
    TweenService:Create(Frame, TweenInfo.new(v1, Enum.EasingStyle.Linear), {BackgroundTransparency = 1}):Play()
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v1, Enum.EasingStyle.Linear), {Brightness = 0, Contrast = 0, Saturation = 0}):Play()
    TweenService:Create(Sound, TweenInfo.new(v1, Enum.EasingStyle.Linear), {Volume = 0}):Play()
    task.delay(v1 + 0.05, function() -- Line: 159 -- upvalues: u4 (val), u56 (upval), ScreenGui (val), ColorCorrectionEffect (val)
        if u4 ~= u56 then
            return
        end
        if ScreenGui.Parent then
            ScreenGui:Destroy()
        end
        if ColorCorrectionEffect.Parent then
            ColorCorrectionEffect:Destroy()
        end
    end)
end

local function inkPlayer(a1, a2) -- Line: 166
    -- upvalues: LocalPlayer (val), Workspace (val), SoundService (val), Debris (val)
    local v1 = math.clamp(a1, 1, 8)
    LocalPlayer:SetAttribute("LastOctopusInkDuration", v1)
    LocalPlayer:SetAttribute("OctopusInkUntil", (Workspace:GetServerTimeNow()) + v1)
    local Sound = Instance.new("Sound")
    Sound.Name = "OctopusInkSound"
    Sound.SoundId = a2
    Sound.Volume = 0.8
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 6)
end

HazardFX.OnClientEvent:Connect(function(a1) -- Line: 181
    -- upvalues: LocalPlayer (val), playFlashbangBurst (val), blindPlayer (val), playWaterSplash (val), inkPlayer (val)
    local v1
    if type(a1) ~= "table" then
        return
    end
    LocalPlayer:SetAttribute("LastHazardFXKind", (tostring(a1.Kind or "")))
    if a1.Kind == "FlashbangBurst" and typeof(a1.Position) == "Vector3" then
        playFlashbangBurst(a1.Position)
        return
    end
    if a1.Kind == "FlashbangBlind" then
        LocalPlayer:SetAttribute("LastFlashbangDuration", (tonumber(a1.Duration)) or 0)
        v1 = blindPlayer
        local Brightness = a1.Brightness
        v1(tonumber(a1.Duration) or 0, tonumber(Brightness) or 0)
        return
    end
    if a1.Kind == "WaterSplash" and typeof(a1.Position) == "Vector3" then
        playWaterSplash(a1.Position, tonumber(a1.Duration) or 2)
        return
    end
    if a1.Kind == "Ink" then
        v1 = inkPlayer
        local SoundId = a1.SoundId
        v1(tonumber(a1.Duration) or 4, (tostring(SoundId or "")))
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.FishSurvivalClient
-- Took 0.09s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.FishSurvivalClient
-- Decompile time: 90.07 ms

local FlavorText, Purchase, Robux, SeedText, TextLabel_2, v1
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v2 = (function() -- Line: 15 -- upvalues: ReplicatedStorage (val)
    while true do
        for i, v in ipairs(ReplicatedStorage:GetChildren()) do
            if v.Name == "FishGame"
                and v:IsA("Folder")
                and v:FindFirstChild("Config")
                and v:FindFirstChild("RunState")
                and v:FindFirstChild("Remotes")
                and v:FindFirstChild("Assets") then
                return v
            end
        end
        ReplicatedStorage.ChildAdded:Wait()
    end
    return v
end)()
local Config = require(v2:WaitForChild("Config"))
local Remotes = v2:WaitForChild("Remotes")
local UpgradeAction = Remotes:WaitForChild("UpgradeAction")
local StateUpdate = Remotes:WaitForChild("StateUpdate")
local WeaponAction = Remotes:WaitForChild("WeaponAction")
local InterfaceFX = Remotes:WaitForChild("InterfaceFX")
local UpgradeShop = PlayerGui:WaitForChild("UpgradeShop")
local Index = PlayerGui:WaitForChild("Index")
local IndexButton = UpgradeShop:WaitForChild("IndexButton")
local CloseButton = (Index:WaitForChild("index"):WaitForChild("X")):WaitForChild("CloseButton")
UpgradeShop.Enabled = false
Index.Enabled = false
LocalPlayer:SetAttribute("FishResearchOpen", false)
local u868 = "Gun"
local u875 = {}
local u882 = {}
local u721 = nil
local u893 = 0
local u897 = 0
local u904 = {}
local u912 = nil
local u920 = nil
local Custom = Enum.CameraType.Custom
local CameraMode = LocalPlayer.CameraMode
local MouseIconEnabled = UserInputService.MouseIconEnabled
local u952 = 0
local u960 = 70
local u968 = 0
local u976 = false
local u984 = false
local CoolerShopBlur = Lighting:FindFirstChild("CoolerShopBlur")
if not CoolerShopBlur or not CoolerShopBlur:IsA("BlurEffect") then
    CoolerShopBlur = Instance.new("BlurEffect")
    CoolerShopBlur.Name = "CoolerShopBlur"
    CoolerShopBlur.Size = 0
    CoolerShopBlur.Enabled = false
    CoolerShopBlur.Parent = Lighting
end

local function playInterfaceSound(a1, a2, a3) -- Line: 72 -- upvalues: SoundService (val), Debris (val)
    local Sound = Instance.new("Sound")
    Sound.Name = a1
    Sound.SoundId = a2
    Sound.Volume = a3
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 6)
end

local function commas(a1) -- Line: 82
    local v1, v2
    local v3 = tostring((math.floor(a1 or 0)))
    repeat
        v1, v2 = v3:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function durationText(a1) -- Line: 91
    local v1 = math.max(0, (math.floor(a1 + 0.5)))
    return string.format("%d:%02d", math.floor(v1 / 60), v1 % 60)
end

local function normalized(a1) -- Line: 96
    return string.lower(a1):gsub("[^%w]", "")
end

local function setButtonText(a1, a2) -- Line: 100
    local TextLabel = a1:FindFirstChild("TextLabel")
    if TextLabel and TextLabel:IsA("TextLabel") then
        TextLabel.Text = a2
        return
    end
    a1.Text = a2
end

local v3 = {
    theyfoundusbro = "FishChain",
    valuablefish = "FishValue",
    rarefish = "FishRarity",
    toomuchammo = "Magazine",
    morereloading = "Reload",
    biggerbullets = "Damage",
    goodboy = "DogAutoDeposit",
    fastboy = "DogSpeed",
    fatboy = "DogCarry",
    buynextturret = "TurretCount",
    turretdamage = "TurretDamage",
    turretfirespeed = "TurretFireSpeed",
    buildbetterdock = "BetterDock",
    buildbetterbridge = "BetterDock",
    buyredturret = "RedTurretCount",
    callinairstrike = "Airstrike",
    airstrikerechargespeed = "AirstrikeCooldown",
}
local v4 = {
    Magazine = "Magazine",
    Reload = "Reload",
    Damage = "Damage",
    DogAutoDeposit = "DogAutoDeposit",
    DogSpeed = "DogSpeed",
    DogCarry = "DogCarry",
    FishChain = "FishChain",
    FishValue = "FishValue",
    FishRarity = "FishRarity",
    BuyTurret = "TurretCount",
    TurretDamage = "TurretDamage",
    TurretFireSpeed = "TurretFireSpeed",
    BuyBetterBridge = "BetterDock",
    BuyRedTurret = "RedTurretCount",
    BuyAnotherDog = "AdditionalDogs",
    BuyAirStrike = "Airstrike",
    BuyAirStrikeRechargeSpeed = "AirstrikeCooldown",
}
local v5 = {
    Magazine = "Increases ammo in each clip.",
    Reload = "Reload and shoot faster.",
    Damage = "Increases bullet damage.",
    DogAutoDeposit = "Your dog puts retrieved fish straight into the cooler. Good boy.",
    DogSpeed = "Makes your dog retrieve fish faster.",
    DogCarry = "Lets your dog carry more fish at once.",
    TurretDamage = "Auto Turret damage",
    TurretFireSpeed = "Auto Turret fire rate",
}
local Frame = UpgradeShop:WaitForChild("Frame")
local A_Header = Frame:WaitForChild("A_Header")
local SellAndMoney = Frame:WaitForChild("SellAndMoney")
local Amount = (SellAndMoney:WaitForChild("Cash")):WaitForChild("Amount")
local SellFishButton = SellAndMoney:WaitForChild("SellFishButton")
local TextLabel = SellFishButton:WaitForChild("TextLabel")
local Size = SellFishButton.Size
local Rotation = SellFishButton.Rotation
local TutorialSellArrow = SellAndMoney:WaitForChild("TutorialSellArrow")
local Position = TutorialSellArrow.Position
local u1069 = 0
local u1075 = 0
local u1081 = ""
local ScrollingFrame = Frame:FindFirstChild("ScrollingFrame", true)
assert(ScrollingFrame, "UpgradeShop.Frame.Body.ScrollingFrame is missing")

local function scaledSize(a1, a2) -- Line: 174
    return UDim2.new(a1.X.Scale * a2, a1.X.Offset * a2, a1.Y.Scale * a2, a1.Y.Offset * a2)
end

local function pulseSellButton(a1) -- Line: 183
    -- upvalues: u1069 (ref), SellFishButton (val), Size (val), Rotation (val), TweenService (val)
    u1069 = u1069 + 1
    local u3 = u1069
    if a1 then
        task.spawn(function() -- Line: 191
            -- upvalues: u3 (val), u1069 (upval), TweenService (upval), SellFishButton (upval), Size (upval)
            -- upvalues: Rotation (upval)
            local v1, v2, v3, v4, v5, v6
            while u3 == u1069 do
                v1 = TweenService
                v3 = SellFishButton
                v4 = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                v5 = {}
                v6 = Size
                v5.Size = UDim2.new(v6.X.Scale * 1.09, v6.X.Offset * 1.09, v6.Y.Scale * 1.09, v6.Y.Offset * 1.09)
                v5.Rotation = Rotation - 1.5
                v1 = v1:Create(v3, v4, v5)
                v1:Play()
                v1.Completed:Wait()
                if u3 ~= u1069 then
                    break
                end
                v2 = TweenService:Create(
                    SellFishButton,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                    {Size = Size, Rotation = Rotation + 1.5}
                )
                v2:Play()
                v2.Completed:Wait()
            end
            if u3 == u1069 then
                SellFishButton.Size = Size
                SellFishButton.Rotation = Rotation
            end
        end)
        return
    end
    SellFishButton.Size = Size
    SellFishButton.Rotation = Rotation
end

local function offsetX(a1, a2) -- Line: 216
    return UDim2.new(a1.X.Scale, a1.X.Offset + a2, a1.Y.Scale, a1.Y.Offset)
end

local function setSellTutorialArrow(a1) -- Line: 225
    -- upvalues: u1075 (ref), TutorialSellArrow (val), Position (val), TweenService (val)
    u1075 = u1075 + 1
    local u3 = u1075
    if not a1 then
        TutorialSellArrow.Visible = false
        TutorialSellArrow.Position = Position
        return
    end
    TutorialSellArrow.Visible = true
    task.spawn(function() -- Line: 235
        -- upvalues: u3 (val), u1075 (upval), TweenService (upval), TutorialSellArrow (upval), Position (upval)
        local v1, v2, v3, v4, v5, v6
        while u3 == u1075 do
            v1 = TweenService
            v3 = TutorialSellArrow
            v4 = TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v5 = {}
            v6 = Position
            v5.Position = UDim2.new(v6.X.Scale, v6.X.Offset + -8, v6.Y.Scale, v6.Y.Offset)
            v1 = v1:Create(v3, v4, v5)
            v1:Play()
            v1.Completed:Wait()
            if u3 ~= u1075 then
                break
            end
            v2 = TweenService:Create(
                TutorialSellArrow,
                TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Position = Position}
            )
            v2:Play()
            v2.Completed:Wait()
        end
        if u3 == u1075 then
            TutorialSellArrow.Position = Position
        end
    end)
end

for i, v in ipairs(ScrollingFrame:GetDescendants()) do
    if v:IsA("Frame") then
        SeedText = v:FindFirstChild("SeedText")
        Purchase = v:FindFirstChild("Purchase")
        if SeedText and SeedText:IsA("TextLabel") and Purchase and Purchase:IsA("GuiButton") then
            local u648 = v4[v.Name]
            if not u648 then
                u648 = v3[string.lower(SeedText.Text):gsub("[^%w]", "")]
            end
            if u648 and Config.Upgrades[u648] then
                u875[u648] = v
                v:SetAttribute("UpgradeId", u648)
                Purchase.Activated:Connect(function() -- Line: 271 -- upvalues: UpgradeAction (val), u648 (val)
                    if UpgradeAction then
                        UpgradeAction:FireServer("Upgrade", u648)
                    end
                end)
                Robux = v:FindFirstChild("Robux")
                if Robux and Robux:IsA("GuiButton") then
                    u882[u648] = Robux
                    Robux.Visible = true
                    v1 = "R$ " .. tostring((Config.UpgradeRobuxPrice((u721 and u721.Upgrades and u721.Upgrades[u648] or 0) + 1)))
                    TextLabel_2 = Robux:FindFirstChild("TextLabel")
                    if not TextLabel_2 or not TextLabel_2:IsA("TextLabel") then
                        Robux.Text = v1
                    else
                        TextLabel_2.Text = v1
                    end
                    Robux.Activated:Connect(function() -- Line: 283 -- upvalues: u897 (ref), Config (val), u648 (val), u721 (ref), UpgradeAction (val)
                        if os.clock() < u897 then
                            return
                        end
                        local v1 = Config.Upgrades[u648]
                        local v2 = u721 and u721.Upgrades and u721.Upgrades[u648] or 0
                        if v1 and not Config.IsUpgradeMaxed(u648, v2) then
                            u897 = os.clock() + 1
                            UpgradeAction:FireServer("RobuxUpgrade", u648)
                            return
                        end
                    end)
                end
                FlavorText = v:FindFirstChild("FlavorText")
                v1 = v5[u648]
                if FlavorText and FlavorText:IsA("TextLabel") and v1 then
                    FlavorText.Text = v1
                end
            end
        end
    end
end
local Buttons = (A_Header:WaitForChild("CategorySwitchButtons")):WaitForChild("Buttons")
local u234 = {}
u234.Fish = A_Header:WaitForChild("LockFishUpgrades")
u234.Turret = A_Header:WaitForChild("LockTurretUpgrades")
u234.Building = A_Header:WaitForChild("LockBuildingUpgrades")
for k, i2 in pairs({
    Gun = "A_GunUpgrades",
    Dog = "B_DogUpgrades",
    Fish = "C_FishUpgrades",
    Turret = "D_TurretUpgrades",
    Building = "E_BuildingUpgrades",
}) do
    u904[k] = (Buttons:WaitForChild(i2))
end

local function categoryUnlocked(a1, a2) -- Line: 319 -- upvalues: Config (val)
    local v1 = if not a2 then 1 else math.max(1, (math.floor((tonumber(a2.Day)) or 1)))
    return (Config.CategoryUnlockDays[a1] or 1) <= v1
end

local function showCategory(a1) -- Line: 324 -- upvalues: Config (val), u721 (ref), u868 (ref), u875 (val), u904 (val)
    local v1 = Config.UpgradeCategories[a1]
    if v1 then
        local v2 = u721
        local v3 = if not v2 then 1 else math.max(1, (math.floor((tonumber(v2.Day)) or 1)))
        if (Config.CategoryUnlockDays[a1] or 1) <= v3 then
            local Glow, Upgrades, v4, v5
            u868 = a1
            for i, v in ipairs(Config.UpgradeOrder) do
                if u875[v] then
                    v4 = u875[v]
                    v4.Visible = false
                end
            end
            local v6 = a1
            for i2, i3 in ipairs(v1) do
                v4 = u875[i3]
                if v4 then
                    v4.LayoutOrder = i2
                    v5 = true
                    if v6 == "Building" and u721 then
                        Upgrades = u721.Upgrades
                        if i3 == "BetterDock" then
                            v5 = (Upgrades.BetterDock or 0) < 1
                        end
                        if i3 == "RedTurretCount" then
                            v5 = 1 <= (Upgrades.BetterDock or 0)
                        end
                        if i3 == "Airstrike" then
                            v5 = (Upgrades.Airstrike or 0) < 1
                        end
                        if i3 == "AirstrikeCooldown" then
                            v5 = 1 <= (Upgrades.Airstrike or 0)
                        end
                    end
                    v4.Visible = v5
                end
            end
            for k, j in pairs(u904) do
                Glow = j:FindFirstChild("Glow")
                if Glow and Glow:IsA("ImageLabel") then
                    Glow.ImageTransparency = if k ~= v6 then 0.75 else 0.05
                end
            end
            return
        end
    end
end

for k2, j in pairs(u904) do
    j.Activated:Connect(function() -- Line: 357 -- upvalues: showCategory (val), k2 (val)
        showCategory(k2)
    end)
end

local function setUpgradeShopOpen(a1) -- Line: 360
    -- upvalues: UpgradeShop (val), u976 (ref), u968 (ref), Config (val), SoundService (val), Debris (val)
    -- upvalues: LocalPlayer (val), u952 (ref), CoolerShopBlur (ref), TweenService (val), showCategory (val), u868 (ref)
    -- upvalues: UpgradeAction (val), Workspace (val), u912 (ref), u920 (ref), Custom (ref), u960 (ref)
    -- upvalues: CameraMode (ref), MouseIconEnabled (ref), UserInputService (val), RunService (val), Index (val)
    if UpgradeShop.Enabled == a1 and u976 == a1 then
        return
    end
    u968 = u968 + 1
    local u6 = u968
    u976 = a1
    UpgradeShop.Enabled = a1
    local OpenCloseSoundId = Config.InterfaceSounds.OpenCloseSoundId
    local OpenCloseSoundVolume = Config.InterfaceSounds.OpenCloseSoundVolume
    local Sound = Instance.new("Sound")
    Sound.Name = if not a1 then "UpgradeShopClose" else "UpgradeShopOpen"
    Sound.SoundId = OpenCloseSoundId
    Sound.Volume = OpenCloseSoundVolume
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Debris:AddItem(Sound, 6)
    LocalPlayer:SetAttribute("FishResearchOpen", a1)
    if not a1 then
        UpgradeAction:FireServer("TutorialShopClosed")
        RunService:UnbindFromRenderStep("UpgradeShopCameraLock")
        RunService:UnbindFromRenderStep("UpgradeShopCursorLock")
        local CurrentCamera_2 = Workspace.CurrentCamera
        TweenService:Create(CoolerShopBlur, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = 0}):Play()
        if CurrentCamera_2 then
            CurrentCamera_2.CameraType = Custom
            TweenService:Create(
                CurrentCamera_2,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {FieldOfView = u960}
            ):Play()
        end
        task.delay(0.2, function() -- Line: 436 -- upvalues: u6 (val), u968 (upval), UpgradeShop (upval), CoolerShopBlur (upval)
            if u6 == u968 and not UpgradeShop.Enabled then
                CoolerShopBlur.Enabled = false
            end
        end)
        UserInputService.MouseIconEnabled = MouseIconEnabled
        LocalPlayer.CameraMode = CameraMode
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        u912 = nil
        u920 = nil
        return
    end
    u952 = os.clock()
    CoolerShopBlur.Enabled = true
    CoolerShopBlur.Size = 0
    TweenService:Create(CoolerShopBlur, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = 17}):Play()
    showCategory(u868)
    UpgradeAction:FireServer("TutorialShopOpened")
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        u912 = CurrentCamera.CFrame
        u920 = CurrentCamera.Focus
        Custom = CurrentCamera.CameraType
        u960 = CurrentCamera.FieldOfView
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        TweenService:Create(
            CurrentCamera,
            TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {FieldOfView = math.min(90, u960 + 9)}
        ):Play()
    end
    CameraMode = LocalPlayer.CameraMode
    MouseIconEnabled = UserInputService.MouseIconEnabled
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseIconEnabled = true
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    RunService:UnbindFromRenderStep("UpgradeShopCameraLock")
    RunService:BindToRenderStep("UpgradeShopCameraLock", Enum.RenderPriority.Camera.Value + 10, function() -- Line: 398
        -- upvalues: UpgradeShop (upval), Workspace (upval), u912 (upval), u920 (upval), UserInputService (upval)
        if not UpgradeShop.Enabled then
            return
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera and u912 then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.CFrame = u912
            if u920 then
                CurrentCamera.Focus = u920
            end
        end
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end)
    task.defer(function() -- Line: 410 -- upvalues: UpgradeShop (upval), Index (upval), UserInputService (upval)
        if UpgradeShop.Enabled and not Index.Enabled then
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)
    task.delay(0.25, function() -- Line: 416 -- upvalues: UpgradeShop (upval), Index (upval), UserInputService (upval)
        if UpgradeShop.Enabled and not Index.Enabled then
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)
end

local function restoreShopCursor() -- Line: 447
    -- upvalues: UpgradeShop (val), Index (val), LocalPlayer (val), UserInputService (val), RunService (val)
    if UpgradeShop.Enabled and not Index.Enabled then
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        RunService:BindToRenderStep("UpgradeShopCursorLock", Enum.RenderPriority.Camera.Value + 30, function() -- Line: 452
            -- upvalues: UpgradeShop (upval), Index (upval), RunService (upval), LocalPlayer (upval)
            -- upvalues: UserInputService (upval)
            if UpgradeShop.Enabled and not Index.Enabled then
                LocalPlayer.CameraMode = Enum.CameraMode.Classic
                UserInputService.MouseIconEnabled = true
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                return
            end
            RunService:UnbindFromRenderStep("UpgradeShopCursorLock")
        end)
        return
    end
end

IndexButton.Activated:Connect(function() -- Line: 477
    -- upvalues: UpgradeShop (val), u984 (ref), setUpgradeShopOpen (val), Index (val), UserInputService (val)
    if not UpgradeShop.Enabled then
        return
    end
    u984 = true
    setUpgradeShopOpen(false)
    Index.Enabled = true
    UserInputService.MouseIconEnabled = true
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end)
CloseButton.Activated:Connect(function() -- Line: 463 -- upvalues: Index (val), u984 (ref), setUpgradeShopOpen (val), restoreShopCursor (val)
    if not Index.Enabled then
        return
    end
    Index.Enabled = false
    if u984 then
        u984 = false
        setUpgradeShopOpen(true)
        restoreShopCursor()
        task.defer(restoreShopCursor)
        task.delay(0.25, restoreShopCursor)
    end
end)
;(Index:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 488 -- upvalues: Index (val), u984 (ref), setUpgradeShopOpen (val), restoreShopCursor (val)
    if not Index.Enabled and u984 then
        u984 = false
        setUpgradeShopOpen(true)
        restoreShopCursor()
        task.defer(restoreShopCursor)
        task.delay(0.25, restoreShopCursor)
    end
end)
;(UpgradeShop:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 498 -- upvalues: UpgradeShop (val), u976 (ref), setUpgradeShopOpen (val)
    if not UpgradeShop.Enabled and u976 then
        setUpgradeShopOpen(false)
    end
end)
;(A_Header:WaitForChild("CloseButton")).Activated:Connect(function() -- Line: 502 -- upvalues: setUpgradeShopOpen (val)
    setUpgradeShopOpen(false)
end)
local ConsoleModalBack = (LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("ConsoleModalBack")
if ConsoleModalBack:IsA("BindableEvent") then
    ConsoleModalBack:SetAttribute("UpgradeShopBackHandlerReady", false)
    ConsoleModalBack.Event:Connect(function(a1) -- Line: 509 -- upvalues: UpgradeShop (val), setUpgradeShopOpen (val)
        if a1 == UpgradeShop.Name and UpgradeShop.Enabled then
            setUpgradeShopOpen(false)
            return
        end
    end)
    ConsoleModalBack:SetAttribute("UpgradeShopBackHandlerReady", true)
end
local FishCooler = Workspace:WaitForChild("FishCooler")
local u375 = false
local u376 = 0
if not u375 then
    local ProximityPrompt = FishCooler:FindFirstChildWhichIsA("ProximityPrompt", true)
    if ProximityPrompt then
        ProximityPrompt.Triggered:Connect(function(a1) -- Line: 526 -- upvalues: LocalPlayer (val), u376 (ref), setUpgradeShopOpen (val)
            if a1 and a1 ~= LocalPlayer then
                return
            end
            if os.clock() < u376 then
                return
            end
            setUpgradeShopOpen(true)
        end)
    end
end
FishCooler.DescendantAdded:Connect(function() -- Line: 521
    -- upvalues: u375 (ref), FishCooler (val), LocalPlayer (val), u376 (ref), setUpgradeShopOpen (val)
    if u375 then
        return
    end
    local ProximityPrompt = FishCooler:FindFirstChildWhichIsA("ProximityPrompt", true)
    if not ProximityPrompt then
        return
    end
    u375 = true
    ProximityPrompt.Triggered:Connect(function(a1) -- Line: 526 -- upvalues: LocalPlayer (upval), u376 (upval), setUpgradeShopOpen (upval)
        if a1 and a1 ~= LocalPlayer then
            return
        end
        if os.clock() < u376 then
            return
        end
        setUpgradeShopOpen(true)
    end)
end)

local function effectText(a1, a2, a3, a4) -- Line: 535 -- upvalues: Config (val), durationText (val)
    if a1 ~= "FishChain" and a1 ~= "FishRarity" then
        local v1
        if a1 == "FishValue" then
            v1 = table.clone(a3.Upgrades)
            v1.FishValue = a2
            return "$" .. tostring((Config.FishCashValue(Config.FishLane.Types[1].Value, v1)))
        end
        if a1 == "DogAutoDeposit" then
            if a2 > 0 then
                return "ON"
            end
            return "OFF"
        end
        if a1 == "DogSpeed" then
            v1 = table.clone(a3.Upgrades)
            v1.DogSpeed = a2
            return (tostring((math.floor((Config.DogSpeed(v1)) + 0.5))))
        end
        if a1 == "DogCarry" then
            v1 = table.clone(a3.Upgrades)
            v1.DogCarry = a2
            return (tostring((Config.DogCapacity(v1))))
        end
        if a1 == "TurretCount" then
            return (tostring(a2)) .. " / " .. tostring(Config.Turrets.NormalCount)
        end
        if a1 == "TurretDamage" then
            v1 = table.clone(a3.Upgrades)
            v1.TurretDamage = a2
            return (tostring((Config.TurretDamage(v1))))
        end
        if a1 == "TurretFireSpeed" then
            v1 = table.clone(a3.Upgrades)
            v1.TurretFireSpeed = a2
            return string.format("%.1fs", Config.TurretFireInterval(v1))
        end
        if a1 ~= "BetterDock" and a1 ~= "Airstrike" then
            if a1 == "RedTurretCount" then
                return (tostring(a2)) .. " / " .. tostring(Config.Turrets.RedCount)
            end
            if a1 == "AdditionalDogs" then
                return (tostring(1 + a2)) .. " / 3"
            end
            if a1 == "AirstrikeCooldown" then
                v1 = table.clone(a3.Upgrades)
                v1.AirstrikeCooldown = a2
                return durationText(Config.AirstrikeCooldown(v1))
            end
            local Mosin = Config.Guns[a4 and a4.EquippedGun or "Mosin"] or Config.Guns.Mosin
            local v2 = table.clone(a3.Upgrades)
            v2[a1] = a2
            if a1 == "Magazine" then
                return (tostring((Config.MagazineSize(Mosin, v2))))
            end
            if a1 == "Damage" then
                return (tostring((Config.GunDamage(Mosin, v2))))
            end
            if a1 == "Reload" then
                return string.format("%.2fs", Config.ReloadTime(Mosin, v2))
            end
            return (tostring(a2))
        end
        if a2 > 0 then
            return "OWNED"
        end
        return "LOCKED"
    end
    return (tostring(a2 * 10)) .. "%"
end

local function renderUpgradeCards(a1, a2) -- Line: 583
    -- upvalues: Config (val), u875 (val), effectText (val), commas (val), u882 (val)
    local AmountText, CurrentValue, NextValue, Purchase, TextLabel, TextLabel_2, Values, v1, v2, v3, v4, v5, v6
    local v7, v8 = a1, a2
    for i, v in ipairs(Config.UpgradeOrder) do
        v4 = u875[v]
        v5 = Config.Upgrades[v]
        v6 = v7.Upgrades[v] or 0
        if v4 and v5 then
            AmountText = v4:FindFirstChild("AmountText")
            if AmountText and AmountText:IsA("TextLabel") then
                AmountText.Text = if v == "DogAutoDeposit" then if not (v6 >= 1) then "BUY ONCE" else "OWNED" else if v == "BetterDock" then if not (v6 >= 1) then "BUY ONCE" else "OWNED" else if v ~= "Airstrike" then "Level " .. tostring(v6) else if not (v6 >= 1) then "BUY ONCE" else "OWNED"
            end
            Values = v4:FindFirstChild("Values")
            CurrentValue = Values and Values:FindFirstChild("CurrentValue")
            NextValue = Values and Values:FindFirstChild("NextValue")
            if CurrentValue and CurrentValue:IsA("TextLabel") then
                CurrentValue.Text = effectText(v, v6, v7, v8)
            end
            if NextValue and NextValue:IsA("TextLabel") then
                NextValue.Text = if not Config.IsUpgradeMaxed(v, v6) then effectText(v, v6 + 1, v7, v8) else "MAX"
            end
            Purchase = v4:FindFirstChild("Purchase")
            if Purchase and Purchase:IsA("GuiButton") then
                v1 = Config.IsUpgradeMaxed(v, v6)
                v2 = if not v1 then "$" .. commas(v7.UpgradeCosts[v]) else "Reached Max"
                TextLabel = Purchase:FindFirstChild("TextLabel")
                if not TextLabel or not TextLabel:IsA("TextLabel") then
                    Purchase.Text = v2
                else
                    TextLabel.Text = v2
                end
                Purchase.Active = not v1
                Purchase.Selectable = not v1
                Purchase.AutoButtonColor = not v1
            end
            v1 = u882[v]
            if v1 then
                v2 = Config.IsUpgradeMaxed(v, v6)
                v3 = if not v2 then "R$ " .. tostring((Config.UpgradeRobuxPrice(v6 + 1))) else "Reached Max"
                TextLabel_2 = v1:FindFirstChild("TextLabel")
                if not TextLabel_2 or not TextLabel_2:IsA("TextLabel") then
                    v1.Text = v3
                else
                    TextLabel_2.Text = v3
                end
                v1.Active = not v2
                v1.Selectable = not v2
            end
        end
    end
end

local function renderCategoryLocks(a1) -- Line: 627
    -- upvalues: u234 (val), Config (val), u904 (val), u868 (ref), showCategory (val)
    local v1, v2
    local v3 = a1
    for k, v in pairs(u234) do
        v2 = if not v3 then 1 else math.max(1, (math.floor((tonumber(v3.Day)) or 1)))
        v1 = (Config.CategoryUnlockDays[k] or 1) <= v2
        if v:IsA("GuiObject") then
            v.Visible = not v1
        end
        v2 = u904[k]
        v2.Active = v1
        v2.Selectable = v1
        v2.AutoButtonColor = v1
    end
    local v4 = u868
    local v5 = if not v3 then 1 else math.max(1, (math.floor((tonumber(v3.Day)) or 1)))
    if not ((Config.CategoryUnlockDays[v4] or 1) <= v5) then
        u868 = "Gun"
    end
    showCategory(u868)
end

local function renderSellAndMoney(a1) -- Line: 640
    -- upvalues: u893 (ref), Amount (val), commas (val), TextLabel (val), SellFishButton (val)
    local v1 = math.max(0, (math.floor((tonumber(a1.StoredFish)) or 0)))
    u893 = v1
    Amount.Text = "$" .. commas(a1.TeamCash)
    TextLabel.Text = "Sell " .. (commas(v1)) .. " Fish"
    SellFishButton.Active = true
    SellFishButton.Selectable = true
end

SellFishButton.Activated:Connect(function() -- Line: 652 -- upvalues: u893 (ref), UpgradeAction (val)
    if u893 <= 0 then
        return
    end
    UpgradeAction:FireServer("SellFish")
end)
StateUpdate.OnClientEvent:Connect(function(a1, a2) -- Line: 657
    -- upvalues: u721 (ref), u1081 (ref), u1069 (ref), SellFishButton (val), Size (val), Rotation (val)
    -- upvalues: TweenService (val), u1075 (ref), TutorialSellArrow (val), Position (val), UpgradeShop (val)
    -- upvalues: UpgradeAction (val), renderUpgradeCards (val), u893 (ref), Amount (val), commas (val), TextLabel (val)
    -- upvalues: renderCategoryLocks (val)
    if type(a1) == "table" and type(a1.Upgrades) == "table" and type(a1.UpgradeCosts) == "table" then
        local v1
        u721 = a1
        local v2 = if a1.TutorialActive ~= true then "" else tostring(a1.TutorialStage or "")
        if v2 ~= u1081 then
            u1081 = v2
            v1 = v2 == "SellFish"
            u1069 = u1069 + 1
            local u23 = u1069
            if v1 then
                task.spawn(function() -- Line: 191
                    -- upvalues: u23 (val), u1069 (upval), TweenService (upval), SellFishButton (upval), Size (upval)
                    -- upvalues: Rotation (upval)
                    local v1, v2, v3, v4, v5, v6
                    while u23 == u1069 do
                        v1 = TweenService
                        v3 = SellFishButton
                        v4 = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                        v5 = {}
                        v6 = Size
                        v5.Size = UDim2.new(v6.X.Scale * 1.09, v6.X.Offset * 1.09, v6.Y.Scale * 1.09, v6.Y.Offset * 1.09)
                        v5.Rotation = Rotation - 1.5
                        v1 = v1:Create(v3, v4, v5)
                        v1:Play()
                        v1.Completed:Wait()
                        if u23 ~= u1069 then
                            break
                        end
                        v2 = TweenService:Create(
                            SellFishButton,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                            {Size = Size, Rotation = Rotation + 1.5}
                        )
                        v2:Play()
                        v2.Completed:Wait()
                    end
                    if u23 == u1069 then
                        SellFishButton.Size = Size
                        SellFishButton.Rotation = Rotation
                    end
                end)
            else
                SellFishButton.Size = Size
                SellFishButton.Rotation = Rotation
            end
            v1 = v2 == "SellFish"
            u1075 = u1075 + 1
            local u38 = u1075
            if v1 then
                TutorialSellArrow.Visible = true
                task.spawn(function() -- Line: 235
                    -- upvalues: u38 (val), u1075 (upval), TweenService (upval), TutorialSellArrow (upval)
                    -- upvalues: Position (upval)
                    local v1, v2, v3, v4, v5, v6
                    while u38 == u1075 do
                        v1 = TweenService
                        v3 = TutorialSellArrow
                        v4 = TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        v5 = {}
                        v6 = Position
                        v5.Position = UDim2.new(v6.X.Scale, v6.X.Offset + -8, v6.Y.Scale, v6.Y.Offset)
                        v1 = v1:Create(v3, v4, v5)
                        v1:Play()
                        v1.Completed:Wait()
                        if u38 ~= u1075 then
                            break
                        end
                        v2 = TweenService:Create(
                            TutorialSellArrow,
                            TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                            {Position = Position}
                        )
                        v2:Play()
                        v2.Completed:Wait()
                    end
                    if u38 == u1075 then
                        TutorialSellArrow.Position = Position
                    end
                end)
            else
                TutorialSellArrow.Visible = false
                TutorialSellArrow.Position = Position
            end
            if v2 == "OpenCooler" and UpgradeShop.Enabled then
                UpgradeAction:FireServer("TutorialShopOpened")
            end
        end
        renderUpgradeCards(a1, a2)
        v1 = math.max(0, (math.floor((tonumber(a1.StoredFish)) or 0)))
        u893 = v1
        Amount.Text = "$" .. commas(a1.TeamCash)
        TextLabel.Text = "Sell " .. (commas(v1)) .. " Fish"
        SellFishButton.Active = true
        SellFishButton.Selectable = true
        renderCategoryLocks(a1)
    end
end)
InterfaceFX.OnClientEvent:Connect(function(a1) -- Line: 675 -- upvalues: Config (val), SoundService (val), Debris (val)
    if a1 == "Buy" then
        local BuySoundId = Config.InterfaceSounds.BuySoundId
        local BuySoundVolume = Config.InterfaceSounds.BuySoundVolume
        local Sound = Instance.new("Sound")
        Sound.Name = "UpgradePurchased"
        Sound.SoundId = BuySoundId
        Sound.Volume = BuySoundVolume
        Sound.Parent = SoundService
        SoundService:PlayLocalSound(Sound)
        Debris:AddItem(Sound, 6)
        return
    end
    if a1 == "PickupFish" then
        local PickupFishSoundId = Config.InterfaceSounds.PickupFishSoundId
        local PickupFishSoundVolume = Config.InterfaceSounds.PickupFishSoundVolume
        local Sound_2 = Instance.new("Sound")
        Sound_2.Name = "PickupFish"
        Sound_2.SoundId = PickupFishSoundId
        Sound_2.Volume = PickupFishSoundVolume
        Sound_2.Parent = SoundService
        SoundService:PlayLocalSound(Sound_2)
        Debris:AddItem(Sound_2, 6)
        return
    end
    if a1 == "SellFish" then
        local SellFishSoundId = Config.InterfaceSounds.SellFishSoundId
        local SellFishSoundVolume = Config.InterfaceSounds.SellFishSoundVolume
        local Sound_3 = Instance.new("Sound")
        Sound_3.Name = "SellFish"
        Sound_3.SoundId = SellFishSoundId
        Sound_3.Volume = SellFishSoundVolume
        Sound_3.Parent = SoundService
        SoundService:PlayLocalSound(Sound_3)
        Debris:AddItem(Sound_3, 6)
    end
end)
WeaponAction:FireServer("RequestState")
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 699
    -- upvalues: Index (val), u984 (ref), setUpgradeShopOpen (val), restoreShopCursor (val), UpgradeShop (val)
    -- upvalues: u952 (ref), u376 (ref)
    if a1.KeyCode == Enum.KeyCode.Escape and Index.Enabled then
        if not Index.Enabled then
            return
        end
        Index.Enabled = false
        if u984 then
            u984 = false
            setUpgradeShopOpen(true)
            restoreShopCursor()
            task.defer(restoreShopCursor)
            task.delay(0.25, restoreShopCursor)
        end
        return
    end
    if a1.KeyCode == Enum.KeyCode.E and UpgradeShop.Enabled then
        if os.clock() - u952 < 0.25 then
            return
        end
        u376 = os.clock() + 0.35
        setUpgradeShopOpen(false)
        return
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.IndexClient
-- Took 0.04s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.IndexClient
-- Decompile time: 42.48 ms

local v1, v2
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Index = PlayerGui:WaitForChild("Index")
local index = Index:WaitForChild("index")
local FishIndexConfig = require((ReplicatedStorage:WaitForChild("FishGame")):WaitForChild("FishIndexConfig"))
local StateUpdate = ((ReplicatedStorage:WaitForChild("FishGame")):WaitForChild("Remotes")):WaitForChild("StateUpdate")
local FishCardScroll = index:WaitForChild("FishCardScroll")
local v3 = (index:WaitForChild("Group 28")):WaitForChild("Group 19")
local CloseButton = (index:WaitForChild("X")):WaitForChild("CloseButton")
local u102 = index:FindFirstChild("Fish :")
if not u102 then
    u102 = index:FindFirstChild("Seals :")
end
local Position = index.Position
local u559 = false
local u565 = 70
local OpenScale = index:FindFirstChild("OpenScale")
local u121 = if not OpenScale then nil else if not OpenScale:IsA("UIScale") then nil else OpenScale
if not u121 then
    u121 = Instance.new("UIScale")
    u121.Name = "OpenScale"
    u121.Parent = index
end
local IndexBlur = Lighting:FindFirstChild("IndexBlur")
if not IndexBlur or not IndexBlur:IsA("BlurEffect") then
    if IndexBlur then
        IndexBlur:Destroy()
    end
    IndexBlur = Instance.new("BlurEffect")
    IndexBlur.Name = "IndexBlur"
    IndexBlur.Size = 0
    IndexBlur.Enabled = false
    IndexBlur.Parent = Lighting
end
local Sound = Instance.new("Sound")
Sound.Name = "IndexOpenClose"
Sound.SoundId = "rbxassetid://127877437691780"
Sound.Volume = 0.5
Sound.Parent = SoundService

local function playIndexSound() -- Line: 49 -- upvalues: Sound (val)
    Sound.TimePosition = 0
    Sound.PlaybackSpeed = math.random(96, 104) / 100
    Sound:Play()
end

local FishAssets = ((ReplicatedStorage:WaitForChild("FishGame")):WaitForChild("Assets")):WaitForChild("FishAssets")
local SelectedFishViewport = index:FindFirstChild("SelectedFishViewport")
if not SelectedFishViewport then
    SelectedFishViewport = index:FindFirstChild("ViewportFrame")
end

local function ensureFishViewport(a1) -- Line: 58 -- types: a1: userdata
    local FishViewportWorld = a1:FindFirstChild("FishViewportWorld")
    if not FishViewportWorld or not FishViewportWorld:IsA("WorldModel") then
        FishViewportWorld = Instance.new("WorldModel")
        FishViewportWorld.Name = "FishViewportWorld"
        FishViewportWorld.Parent = a1
    end
    local FishViewportCamera = a1:FindFirstChild("FishViewportCamera")
    if not FishViewportCamera or not FishViewportCamera:IsA("Camera") then
        FishViewportCamera = Instance.new("Camera")
        FishViewportCamera.Name = "FishViewportCamera"
        FishViewportCamera.Parent = a1
    end
    FishViewportCamera.FieldOfView = 35
    a1.CurrentCamera = FishViewportCamera
    a1.BackgroundTransparency = 1
    a1.Ambient = Color3.fromRGB(190, 190, 190)
    a1.LightColor = Color3.fromRGB(255, 255, 255)
    a1.LightDirection = Vector3.new(-1, -1, -1)
    return FishViewportWorld, FishViewportCamera
end

local function fishTemplateFor(a1) -- Line: 80 -- upvalues: FishAssets (val)
    local v1
    if not (if a1.Kind == "Boss" then FishAssets:FindFirstChild("Sharks") else if a1.Kind ~= "Shark" then if a1.Kind ~= "Whale" then FishAssets:FindFirstChild("Fish") else FishAssets else FishAssets:FindFirstChild("Sharks")) then
        return nil
    end
    local v2 = v1:FindFirstChild(a1.Template or a1.Id)
    if not v2 and a1.Kind == "Whale" then
        v2 = FishAssets:FindFirstChild("Whale")
    end
    if v2 and v2:IsA("Model") then
        return v2
    end
    return nil
end

local function renderFishViewport(a1, a2, a3) -- Line: 98
    -- upvalues: ensureFishViewport (val), fishTemplateFor (val)
    if a1 and a2 then
        local BoundingBox_3
        local v1, v2 = ensureFishViewport(a1)
        for i, v in ipairs(v1:GetChildren()) do
            v:Destroy()
        end
        local v3 = fishTemplateFor(a2)
        if not v3 then
            return
        end
        local v4 = v3:Clone()
        v4.Name = "FishPreview"
        v4:SetAttribute("IndexPreviewKind", a2.Kind)
        local v5 = a3 ~= true
        local v6 = a2
        for i2, i3 in ipairs(v4:GetDescendants()) do
            if i3:IsA("BaseScript")
                or i3:IsA("BillboardGui")
                or i3:IsA("ProximityPrompt")
                or i3:IsA("Sound")
                or i3:IsA("ClickDetector") then
                i3:Destroy()
            elseif not v5 then
                if i3:IsA("BasePart") then
                    i3.Anchored = true
                    i3.CanCollide = false
                    i3.CanTouch = false
                    i3.CanQuery = false
                    if v5 then
                        i3.Color = Color3.fromRGB(5, 5, 5)
                        i3.Material = Enum.Material.SmoothPlastic
                        i3.Reflectance = 0
                        if i3:IsA("MeshPart") then
                            i3.TextureID = ""
                        end
                    end
                end
            elseif i3:IsA("Decal") or i3:IsA("Texture") or i3:IsA("SurfaceAppearance") then
                i3:Destroy()
            elseif i3:IsA("BasePart") then
                i3.Anchored = true
                i3.CanCollide = false
                i3.CanTouch = false
                i3.CanQuery = false
                if v5 then
                    i3.Color = Color3.fromRGB(5, 5, 5)
                    i3.Material = Enum.Material.SmoothPlastic
                    i3.Reflectance = 0
                    if i3:IsA("MeshPart") then
                        i3.TextureID = ""
                    end
                end
            end
        end
        v4.Parent = v1
        local v7 = (v4:GetPivot()):ToObjectSpace((v4:GetBoundingBox()))
        v4:PivotTo((if v6.Kind ~= "Boss" then CFrame.Angles(0, 3.141592653589793, 0) else CFrame.identity) * (v7:Inverse()))
        if v6.Category == "Giant" then
            v4:ScaleTo(1.25)
        end
        _, BoundingBox_3 = v4:GetBoundingBox()
        local v8 = math.max(BoundingBox_3.X, BoundingBox_3.Y, BoundingBox_3.Z)
        local v9 = if v6.Kind ~= "Boss" then 1.35 else 0.9
        local v10 = math.max(3, v8 / ((math.tan((math.rad(v2.FieldOfView * 0.5)))) * 2) * v9)
        local v11 = Vector3.new(0, BoundingBox_3.Y * 0.05, 0)
        v2.CFrame = CFrame.lookAt(v11 + (if v6.Kind ~= "Boss" then Vector3.new(0, 0, v10) else Vector3.new(-v10 * 0.8, 0, v10 * 0.6)), v11)
        return
    end
end

local function fishName(a1) -- Line: 164
    return (tostring(a1.DisplayName or a1.Id or "Fish"))
end

local u598 = {}
for i, v in ipairs(FishIndexConfig.All()) do
    table.insert(u598, v)
end
local u222 = {
    Normal = 1,
    Giant = 2,
    Gold = 3,
    Special = 4,
    Boss = 5,
}
local u223 = {
    Common = 1,
    Uncommon = 2,
    Rare = 3,
    Epic = 4,
    Legendary = 5,
    Mythic = 6,
    Boss = 7,
}
table.sort(u598, function(a1, a2) -- Line: 189 -- upvalues: u222 (val), u223 (val)
    local v1 = u222[a1.Category] or 99
    local v2 = u222[a2.Category] or 99
    if v1 ~= v2 then
        return v1 < v2
    end
    local v3 = u223[a1.Rarity] or 99
    local v4 = u223[a2.Rarity] or 99
    if v3 ~= v4 then
        return v3 < v4
    end
    local v5 = tonumber(a1.MinDay) or 1
    local v6 = tonumber(a2.MinDay) or 1
    if v5 ~= v6 then
        return v5 < v6
    end
    local v7 = tostring(a1.DisplayName or a1.Id or "Fish")
    local DisplayName_2 = a2.DisplayName or a2.Id or "Fish"
    return v7 < tostring(DisplayName_2)
end)
local v4 = {}
for i2, i3 in ipairs(FishCardScroll:GetChildren()) do
    if i3:IsA("ImageButton") then
        table.insert(v4, i3)
    end
end
table.sort(v4, function(a1, a2) -- Line: 215
    if a1.LayoutOrder ~= a2.LayoutOrder then
        return a1.LayoutOrder < a2.LayoutOrder
    end
    if a1.Position.Y.Offset ~= a2.Position.Y.Offset then
        return a1.Position.Y.Offset < a2.Position.Y.Offset
    end
    return a1.Name < a2.Name
end)
local u294 = v4[1]
assert(u294, "Index requires at least one authored fish card template")
local u255 = {}
local v5 = #u598
for j = 1, v5 do
    v1 = v4[j]
    if not v1 then
        v1 = u294:Clone()
        v1.Name = "FishCard_" .. tostring(j)
        v1.Parent = FishCardScroll
    end
    v1.LayoutOrder = j
    v1.Visible = true
    table.insert(u255, v1)
end
local v6 = #u598 + 1
v5 = #v4
for k = v6, v5 do
    v4[k].Visible = false
end
local UIListLayout = FishCardScroll:FindFirstChildWhichIsA("UIListLayout")
;(function() -- Line: 254 -- upvalues: UIListLayout (val), u255 (val), FishCardScroll (val), u294 (val)
    if UIListLayout and #u255 ~= 0 then
        local Offset = FishCardScroll.CanvasSize.Y.Offset
        if Offset <= 0 then
            return
        end
        local Padding = UIListLayout.Padding
        local v1 = math.max(
            0,
            (math.min(
                u294.Size.Y.Scale,
                (Offset - (math.max(0, #u255 - 1)) * (Padding.Scale * Offset + Padding.Offset) - 48) / (#u255 * Offset)
            ))
        )
        for i, v in ipairs(u255) do
            v.Size = UDim2.new(v.Size.X.Scale, v.Size.X.Offset, v1, v.Size.Y.Offset)
        end
        return
    end
end)()
local u329 = {}
local u330 = 1

local function fishId(a1) -- Line: 276
    return (tostring(a1.DiscoveryKey or a1.Id or a1.DisplayName or "Fish"))
end

local function fishRarity(a1) -- Line: 280
    if a1.Rarity then
        return (tostring(a1.Rarity))
    end
    local v1 = tonumber(a1.Weight) or 0
    if v1 <= 2 then
        return "Legendary"
    end
    if v1 <= 10 then
        return "Epic"
    end
    if v1 <= 24 then
        return "Rare"
    end
    return "Common"
end

local function isDiscovered(a1) -- Line: 296 -- upvalues: u329 (ref)
    local v1
    local v2 = string.lower((tostring(a1.DiscoveryKey or a1.Id or a1.DisplayName or "Fish")))
    for k, v in pairs(u329) do
        if v == true then
            v1 = string.lower((tostring(k)))
            if v1 ~= v2 and not string.match(v1, ":" .. v2 .. "$") then
                continue
            end
            return true
        end
    end
    return false
end

local function addStroke(a1) -- Line: 309
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(25, 40, 50)
    UIStroke.Thickness = 2
    UIStroke.Transparency = 0.15
    UIStroke.Parent = a1
end

local function addCardLabel(a1, a2, a3, a4, a5) -- Line: 317
    local v1 = a1:FindFirstChild(a2)
    if not v1 then
        v1 = Instance.new("TextLabel")
        v1.Name = a2
        v1.BackgroundTransparency = 1
        v1.TextWrapped = true
        v1.TextScaled = true
        v1.Font = Enum.Font.FredokaOne
        v1.ZIndex = 20
        v1.Parent = a1
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(25, 40, 50)
        UIStroke.Thickness = 2
        UIStroke.Transparency = 0.15
        UIStroke.Parent = v1
    end
    v1.Position = a3
    v1.Size = a4
    v1.TextColor3 = a5
    v1.Visible = true
    return v1
end

local u336 = {}
for i4, n in ipairs(u255) do
    n.Active = true
    v2 = {name = n:WaitForChild("FishName"), status = n:WaitForChild("Status")}
    u336[i4] = v2
    renderFishViewport(n:FindFirstChild("ViewportFrame"), u598[i4], false)
end
local u353 = v3:FindFirstChild("???")
local Common = v3:FindFirstChild("Common")
local tt = v3:FindFirstChild("tt")
local u365 = v3:FindFirstChild("10 HP")
local bt = v3:FindFirstChild("bt")

local function updateDetail(a1) -- Line: 354
    -- upvalues: u598 (val), isDiscovered (val), u353 (val), Common (val), tt (val), u365 (val), bt (val)
    -- upvalues: renderFishViewport (val), SelectedFishViewport (val)
    local v1, v2, v3
    local v4 = u598[a1]
    if not v4 then
        return
    end
    local v5 = isDiscovered(v4)
    if not v5 then
        v1 = "???"
    else
        local DisplayName = v4.DisplayName or v4.Id or "Fish"
        v1 = tostring(DisplayName) or "???"
    end
    if not v4.Rarity then
        v3 = tonumber(v4.Weight) or 0
        v2 = if not (v3 <= 2) then if not (v3 <= 10) then if not (v3 <= 24) then "Common" else "Rare" else "Epic" else "Legendary"
    else
        v2 = tostring(v4.Rarity)
    end
    v3 = v5 and string.format("%s HP", (tostring(v4.Health or "?"))) or "???"
    local v6 = v5 and string.format("$%s", (tostring(v4.Value or "?"))) or "???"
    local v7 = if not v5 then "???" else if v4.Category == "Boss" then "Boss" else if v4.Kind ~= "Boss" then string.format("Day %s", (tostring(v4.MinDay or 1))) else "Boss"
    if u353 then
        u353.Text = v1
    end
    if Common then
        Common.Text = v2
    end
    if tt then
        tt.Text = v3
    end
    if u365 then
        u365.Text = v6
    end
    if bt then
        bt.Text = v7
    end
    if Common then
        local v8 = v5 and Color3.fromRGB(205, 205, 205) or Color3.fromRGB(255, 255, 255)
        Common.TextColor3 = v8
    end
    renderFishViewport(SelectedFishViewport, v4, v5)
end

local function updateCards() -- Line: 379
    -- upvalues: u598 (val), isDiscovered (val), u102 (val), u336 (val), renderFishViewport (val), u255 (val)
    -- upvalues: u330 (ref), updateDetail (val)
    local DisplayName, name, status_2, upper, v1, v2, v3
    local v4 = 0
    for i, v in ipairs(u598) do
        if isDiscovered(v) then
            v4 = v4 + 1
        end
    end
    if u102 then
        u102.Text = string.format("Fish : %d / %d", v4, #u598)
    end
    for i2, i3 in ipairs(u336) do
        v1 = u598[i2]
        if not v1 then
            i3.name.Text = "???"
            i3.status.Text = "LOCKED"
            i3.status.TextColor3 = Color3.fromRGB(205, 220, 230)
        else
            v2 = isDiscovered(v1)
            renderFishViewport(u255[i2]:FindFirstChild("ViewportFrame"), v1, v2)
            name = i3.name
            if not v2 then
                v3 = "???"
            else
                upper = string.upper
                DisplayName = v1.DisplayName or v1.Id or "Fish"
                v3 = upper((tostring(DisplayName))) or "???"
            end
            name.Text = v3
            v3 = if not v2 then "LOCKED" else "FOUND"
            i3.status.Text = v3
            status_2 = i3.status
            v3 = v2 and Color3.fromRGB(150, 255, 110) or Color3.fromRGB(205, 220, 230)
            status_2.TextColor3 = v3
        end
    end
    local v5 = u330
    if #u598 < v5 then
        u330 = 1
    end
    if #u598 > 0 then
        updateDetail(u330)
    end
end

local function setOpen(a1) -- Line: 414
    -- upvalues: PlayerGui (val), u559 (ref), updateCards (val), Workspace (val), u565 (ref), Index (val), index (val)
    -- upvalues: Position (val), u121 (ref), IndexBlur (ref), UserInputService (val), Sound (val), TweenService (val)
    if not a1 then
        if not u559 and not Index.Enabled then
            return
        end
        u559 = false
        Sound.TimePosition = 0
        Sound.PlaybackSpeed = math.random(96, 104) / 100
        Sound:Play()
        TweenService:Create(
            index,
            TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = Position + UDim2.fromOffset(0, 18)}
        ):Play()
        TweenService:Create(u121, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.84}):Play()
        TweenService:Create(IndexBlur, TweenInfo.new(0.18), {Size = 0}):Play()
        local CurrentCamera_2 = Workspace.CurrentCamera
        if CurrentCamera_2 then
            TweenService:Create(CurrentCamera_2, TweenInfo.new(0.22), {FieldOfView = u565}):Play()
        end
        task.delay(0.18, function() -- Line: 464
            -- upvalues: u559 (upval), Index (upval), IndexBlur (upval), index (upval), Position (upval), u121 (upval)
            if u559 then
                return
            end
            Index.Enabled = false
            IndexBlur.Enabled = false
            index.Position = Position
            u121.Scale = 1
        end)
        return
    end
    local MedalTVUI = PlayerGui:FindFirstChild("MedalTVUI")
    if MedalTVUI and MedalTVUI:IsA("ScreenGui") then
        MedalTVUI.Enabled = false
    end
    if u559 then
        updateCards()
        return
    end
    u559 = true
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        u565 = CurrentCamera.FieldOfView
    end
    Index.Enabled = true
    index.Visible = true
    index.Position = Position + UDim2.fromOffset(0, 22)
    u121.Scale = 0.78
    IndexBlur.Enabled = true
    IndexBlur.Size = 0
    UserInputService.MouseIconEnabled = true
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    Sound.TimePosition = 0
    Sound.PlaybackSpeed = math.random(96, 104) / 100
    Sound:Play()
    TweenService:Create(index, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = Position}):Play()
    TweenService:Create(u121, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    TweenService:Create(IndexBlur, TweenInfo.new(0.22), {Size = 12}):Play()
    if CurrentCamera then
        TweenService:Create(CurrentCamera, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {FieldOfView = u565 + 6}):Play()
    end
    updateCards()
end

;(Index:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 473 -- upvalues: Index (val), u559 (ref), setOpen (val)
    if Index.Enabled ~= u559 then
        setOpen(Index.Enabled)
    end
end)
for i5, m in ipairs(u255) do
    m.Activated:Connect(function() -- Line: 481 -- upvalues: u330 (ref), i5 (val), updateCards (val)
        u330 = i5
        updateCards()
    end)
end
CloseButton.Activated:Connect(function() -- Line: 487 -- upvalues: setOpen (val)
    setOpen(false)
end)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 491 -- upvalues: Index (val), setOpen (val)
    if not a2 and a1.KeyCode == Enum.KeyCode.Escape and Index.Enabled then
        setOpen(false)
    end
end)
StateUpdate.OnClientEvent:Connect(function(a1, a2) -- Line: 497 -- upvalues: u329 (ref), Index (val), updateCards (val)
    if typeof(a2) ~= "table" then
        return
    end
    u329 = a2.DiscoveredFish or {}
    if Index.Enabled then
        updateCards()
    end
end)
;(Index:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 505
    -- upvalues: RunService (val), LocalPlayer (val), Index (val), UserInputService (val), updateCards (val)
    RunService:UnbindFromRenderStep("FishIndexCursorLock")
    LocalPlayer:SetAttribute("FishResearchOpen", Index.Enabled)
    if Index.Enabled then
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        RunService:BindToRenderStep("FishIndexCursorLock", Enum.RenderPriority.Camera.Value + 20, function() -- Line: 511 -- upvalues: Index (upval), UserInputService (upval)
            if not Index.Enabled then
                return
            end
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end)
        updateCards()
    end
end)
Index.Enabled = false
updateCards()
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.MedalClient
-- Took 0.04s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.MedalClient
-- Decompile time: 49.10 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local MedalTVUI = PlayerGui:WaitForChild("MedalTVUI")
MedalTVUI.Enabled = false
MedalTVUI.ResetOnSpawn = false
local Frame = MedalTVUI:WaitForChild("Frame")
local CloseButton = Frame:WaitForChild("CloseButton")
local ClaimButton = Frame:WaitForChild("ClaimButton")
local TextLabel = ClaimButton:WaitForChild("TextLabel")
local EggReward = Frame:WaitForChild("EggReward")
local SpinReward = Frame:WaitForChild("SpinReward")
local MedalRewardsRemotes = ReplicatedStorage:WaitForChild("MedalRewardsRemotes")
local Request = MedalRewardsRemotes:WaitForChild("Request")
local Response = MedalRewardsRemotes:WaitForChild("Response")
if MedalRewardsRemotes:GetAttribute("NpcInPlace") == false then
    return
end
local u101 = nil
local u102 = nil
local ConsoleModalBack = (LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("ConsoleModalBack")
local OpenScale = Frame:FindFirstChild("OpenScale")
if not OpenScale then
    OpenScale = Instance.new("UIScale")
    OpenScale.Name = "OpenScale"
    OpenScale.Parent = Frame
end
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "MedalBlur"
BlurEffect.Size = 0
BlurEffect.Enabled = false
BlurEffect.Parent = Lighting
local Sound = Instance.new("Sound")
Sound.Name = "MedalOpenClose"
Sound.SoundId = "rbxassetid://127877437691780"
Sound.Volume = 0.55
Sound.Parent = SoundService
local Sound_2 = Instance.new("Sound")
Sound_2.Name = "MedalReward"
Sound_2.SoundId = "rbxassetid://133292918309565"
Sound_2.Volume = 0.72
Sound_2.Parent = SoundService
local Position = Frame.Position
local u142 = false
local u143 = false
local u144 = "Ready"
local u145 = 0
local u146 = nil
local u147 = 0
local u148 = (-1 / 0)
local u149 = 0
local u150 = {}
local u151 = 0
local CameraMode = LocalPlayer.CameraMode
local Custom = Enum.CameraType.Custom
local MouseBehavior = UserInputService.MouseBehavior
local MouseIconEnabled = UserInputService.MouseIconEnabled
local u158 = nil
local u159 = nil
local u164 = "MedalCamera_" .. tostring(LocalPlayer.UserId)
local u165 = false

local function beginModalInput() -- Line: 77
    -- upvalues: u165 (ref), CameraMode (ref), LocalPlayer (val), MouseBehavior (ref), UserInputService (val)
    -- upvalues: MouseIconEnabled (ref), Workspace (val), Custom (ref), u158 (ref), u159 (ref), RunService (val)
    -- upvalues: u164 (val), u142 (ref)
    u165 = true
    CameraMode = LocalPlayer.CameraMode
    MouseBehavior = UserInputService.MouseBehavior
    MouseIconEnabled = UserInputService.MouseIconEnabled
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        Custom = CurrentCamera.CameraType
        u158 = CurrentCamera.CFrame
        u159 = CurrentCamera.Focus
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
    end
    LocalPlayer:SetAttribute("FishMedalOpen", true)
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
    RunService:BindToRenderStep(u164, Enum.RenderPriority.Camera.Value + 10, function() -- Line: 93
        -- upvalues: u142 (upval), Workspace (upval), u158 (upval), u159 (upval), UserInputService (upval)
        if not u142 then
            return
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera and u158 then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.CFrame = u158
            if u159 then
                CurrentCamera.Focus = u159
            end
        end
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    end)
end

local function endModalInput() -- Line: 106
    -- upvalues: u165 (ref), RunService (val), u164 (val), Workspace (val), Custom (ref), LocalPlayer (val)
    -- upvalues: CameraMode (ref), UserInputService (val), MouseBehavior (ref), MouseIconEnabled (ref), u158 (ref)
    -- upvalues: u159 (ref), GuiService (val), MedalTVUI (val)
    if not u165 then
        return
    end
    u165 = false
    RunService:UnbindFromRenderStep(u164)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CameraType = Custom
    end
    LocalPlayer.CameraMode = CameraMode
    UserInputService.MouseBehavior = MouseBehavior
    UserInputService.MouseIconEnabled = MouseIconEnabled
    LocalPlayer:SetAttribute("FishMedalOpen", false)
    u158 = nil
    u159 = nil
    local SelectedObject = GuiService.SelectedObject
    if SelectedObject and SelectedObject:IsDescendantOf(MedalTVUI) then
        GuiService.SelectedObject = nil
    end
end

local u172 = {
    Ready = "CLAIM",
    Disabled = "COMING SOON",
    NotConfigured = "COMING SOON",
    QuestUnavailable = "UNAVAILABLE",
    Unlinked = "LINK ROBLOX",
    Incomplete = "POST A CLIP",
    Granted = "CLAIMED!",
    Claimed = "CLAIMED",
    ClaimedElsewhere = "ALREADY CLAIMED",
    Pending = "RETRY CLAIM",
    Busy = "TRY AGAIN",
    ProfileLoading = "LOADING...",
    Unavailable = "TRY AGAIN",
    Interrupted = "TRY AGAIN",
    Teleporting = "STARTING ROUND",
    AccountReserved = "ALREADY CLAIMED",
    AccountChanged = "CHECK ACCOUNT",
    NeedsReview = "CONTACT SUPPORT",
    InvalidRequest = "TRY AGAIN",
    TooFar = "MOVE CLOSER",
}
local u173 = {
    Disabled = true,
    NotConfigured = true,
    QuestUnavailable = true,
    Granted = true,
    Claimed = true,
    ClaimedElsewhere = true,
    AccountReserved = true,
    Teleporting = true,
    NeedsReview = true,
}
local u174 = {
    "UpgradeShop",
    "TravelingMerchantShop",
    "PilotShop",
    "ResearchGui",
    "Index",
    "ReturnToLobbyUI",
    "ReturnToLobbyUISolo",
    "DeathUI",
    "WinUI",
    "ToolInventory",
}

local function anotherMenuOpen() -- Line: 141 -- upvalues: u174 (val), PlayerGui (val)
    local Parent, v1, v2
    for i, v in ipairs(u174) do
        v2 = PlayerGui:FindFirstChild(v)
        if v2 and v2:IsA("ScreenGui") and v2.Enabled then
            for i2, i3 in ipairs(v2:GetDescendants()) do
                if i3:IsA("GuiButton") and i3.Visible and i3.Active and i3.Selectable then
                    v1 = string.lower(i3.Name)
                    if v1 ~= "studtexture" and v1 ~= "checkerboardtexture" and v1 ~= "fill" then
                        Parent = i3.Parent
                        while Parent do
                            if Parent == v2 then
                                break
                            end
                            if Parent:IsA("GuiObject") and not Parent.Visible then
                                break
                            end
                            Parent = Parent.Parent
                        end
                        if Parent == v2 then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

local function updateButton() -- Line: 161
    -- upvalues: TextLabel (val), u143 (ref), u172 (val), u144 (ref), u142 (ref), u173 (val), u147 (ref)
    -- upvalues: ClaimButton (val)
    TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
    local v1 = u142
    if v1 then
        v1 = not u143
        if v1 then
            v1 = not u173[u144]
            if v1 then
                local v2 = os.clock()
                v1 = u147 <= v2
            end
        end
    end
    ClaimButton.Active = v1
    ClaimButton.Selectable = v1
    ClaimButton.AutoButtonColor = v1
end

local function sendRequest(a1) -- Line: 169
    -- upvalues: u142 (ref), u143 (ref), MedalRewardsRemotes (val), u144 (ref), TextLabel (val), u172 (val), u173 (val)
    -- upvalues: u147 (ref), ClaimButton (val), u145 (ref), u146 (ref), Request (val)
    if u142 and not u143 then
        local v1
        if MedalRewardsRemotes:GetAttribute("Available") ~= true then
            u144 = "Disabled"
            TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
            local v2 = u142
            if v2 then
                v2 = not u143
                if v2 then
                    v2 = not u173[u144]
                    if v2 then
                        v1 = os.clock()
                        v2 = u147 <= v1
                    end
                end
            end
            ClaimButton.Active = v2
            ClaimButton.Selectable = v2
            ClaimButton.AutoButtonColor = v2
            return
        end
        u145 = u145 + 1
        local u36 = u145
        u143 = true
        TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
        v1 = u142
        if v1 then
            v1 = not u143
            if v1 then
                v1 = not u173[u144]
                if v1 then
                    local v3 = os.clock()
                    v1 = u147 <= v3
                end
            end
        end
        ClaimButton.Active = v1
        ClaimButton.Selectable = v1
        ClaimButton.AutoButtonColor = v1
        task.delay(math.max(0, u147 - (os.clock())), function() -- Line: 180
            -- upvalues: u142 (upval), u36 (val), u145 (upval), u146 (upval), u147 (upval), MedalRewardsRemotes (upval)
            -- upvalues: Request (upval), a1 (val), u143 (upval), u144 (upval), TextLabel (upval), u172 (upval)
            -- upvalues: u173 (upval), ClaimButton (upval)
            if u142 and u36 == u145 then
                u146 = tostring(u36)
                u147 = os.clock() + (MedalRewardsRemotes:GetAttribute("RequestCooldownSeconds") or 3) + 0.25
                Request:FireServer(a1, u146)
                task.delay(20, function() -- Line: 185
                    -- upvalues: u142 (upval), u36 (upval), u145 (upval), u143 (upval), u146 (upval), u144 (upval)
                    -- upvalues: TextLabel (upval), u172 (upval), u173 (upval), u147 (upval), ClaimButton (upval)
                    if u142 and u36 == u145 and u143 then
                        u146 = nil
                        u143 = false
                        u144 = "Unavailable"
                        TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
                        local v1 = u142
                        if v1 then
                            v1 = not u143
                            if v1 then
                                v1 = not u173[u144]
                                if v1 then
                                    local v2 = os.clock()
                                    v1 = u147 <= v2
                                end
                            end
                        end
                        ClaimButton.Active = v1
                        ClaimButton.Selectable = v1
                        ClaimButton.AutoButtonColor = v1
                        return
                    end
                end)
                return
            end
        end)
        return
    end
end

local function setOpen(a1, a2) -- Line: 195
    -- upvalues: u142 (ref), anotherMenuOpen (val), LocalPlayer (val), u101 (ref), Workspace (val), u102 (ref)
    -- upvalues: u149 (ref), u150 (val), Sound (val), beginModalInput (val), MedalTVUI (val), Frame (val)
    -- upvalues: Position (val), OpenScale (ref), BlurEffect (val), TweenService (val), sendRequest (val)
    -- upvalues: UserInputService (val), GuiService (val), CloseButton (val), endModalInput (val), u148 (ref)
    -- upvalues: u145 (ref), u146 (ref), u143 (ref), TextLabel (val), u172 (val), u144 (ref), u173 (val), u147 (ref)
    -- upvalues: ClaimButton (val)
    local u46, v1, v2
    if a1 == u142 and not a2 then
        return
    end
    if not a1 then
        u142 = a1
        u149 = u149 + 1
        u46 = u149
        for i5, k in ipairs(u150) do
            k:Cancel()
        end
        table.clear(u150)
        if u102 and u102.Parent then
            u102.Enabled = not a1
        end
        Sound:Play()
        if a1 then
            beginModalInput()
            MedalTVUI.Enabled = true
            Frame.Visible = true
            Frame.Position = Position + UDim2.fromOffset(0, 20)
            OpenScale.Scale = 0.78
            BlurEffect.Enabled = true
            table.insert(u150, (TweenService:Create(Frame, TweenInfo.new(0.28, Enum.EasingStyle.Back), {Position = Position})))
            table.insert(u150, (TweenService:Create(OpenScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Scale = 1})))
            table.insert(u150, (TweenService:Create(BlurEffect, TweenInfo.new(0.24), {Size = 14})))
            sendRequest("Status")
            if UserInputService.GamepadEnabled or GuiService:IsTenFootInterface() then
                GuiService.SelectedObject = CloseButton
            end
            for i7, m in ipairs(u150) do
                m:Play()
            end
            return
        end
        endModalInput()
        u148 = os.clock()
        u145 = u145 + 1
        u146 = nil
        u143 = false
        TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
        v1 = u142
        if v1 then
            v1 = not u143
            if v1 then
                v1 = not u173[u144]
                if v1 then
                    v2 = os.clock()
                    v1 = u147 <= v2
                end
            end
        end
        ClaimButton.Active = v1
        ClaimButton.Selectable = v1
        ClaimButton.AutoButtonColor = v1
        if a2 then
            MedalTVUI.Enabled = false
            BlurEffect.Enabled = false
            BlurEffect.Size = 0
            Frame.Position = Position
            OpenScale.Scale = 1
            return
        end
        table.insert(u150, (TweenService:Create(Frame, TweenInfo.new(0.18), {Position = Position + UDim2.fromOffset(0, 14)})))
        table.insert(u150, (TweenService:Create(OpenScale, TweenInfo.new(0.18), {Scale = 0.9})))
        table.insert(u150, (TweenService:Create(BlurEffect, TweenInfo.new(0.2), {Size = 0})))
        task.delay(0.2, function() -- Line: 242
            -- upvalues: u149 (upval), u46 (val), u142 (upval), MedalTVUI (upval), BlurEffect (upval), Frame (upval)
            -- upvalues: Position (upval)
            if u149 == u46 and not u142 then
                MedalTVUI.Enabled = false
                BlurEffect.Enabled = false
                Frame.Position = Position
                return
            end
        end)
        for i6, n in ipairs(u150) do
            n:Play()
        end
        return
    end
    if not anotherMenuOpen()
        and LocalPlayer:GetAttribute("FishResearchOpen") ~= true
        and LocalPlayer:GetAttribute("FishReturnToLobbyOpen") ~= true
        and LocalPlayer:GetAttribute("FishDead") ~= true
        and LocalPlayer:GetAttribute("FishLocalDead") ~= true
        and LocalPlayer:GetAttribute("FishVictory") ~= true
        and LocalPlayer:GetAttribute("TestDataResetting") ~= true
        and u101 then
        v2 = Workspace
        if u101:IsDescendantOf(v2) and u102 then
            u142 = a1
            u149 = u149 + 1
            u46 = u149
            for i, v in ipairs(u150) do
                v:Cancel()
            end
            table.clear(u150)
            if u102 and u102.Parent then
                u102.Enabled = not a1
            end
            Sound:Play()
            if a1 then
                beginModalInput()
                MedalTVUI.Enabled = true
                Frame.Visible = true
                Frame.Position = Position + UDim2.fromOffset(0, 20)
                OpenScale.Scale = 0.78
                BlurEffect.Enabled = true
                table.insert(u150, (TweenService:Create(Frame, TweenInfo.new(0.28, Enum.EasingStyle.Back), {Position = Position})))
                table.insert(u150, (TweenService:Create(OpenScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Scale = 1})))
                table.insert(u150, (TweenService:Create(BlurEffect, TweenInfo.new(0.24), {Size = 14})))
                sendRequest("Status")
                if UserInputService.GamepadEnabled or GuiService:IsTenFootInterface() then
                    GuiService.SelectedObject = CloseButton
                end
                for i4, j in ipairs(u150) do
                    j:Play()
                end
                return
            end
            endModalInput()
            u148 = os.clock()
            u145 = u145 + 1
            u146 = nil
            u143 = false
            TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
            v1 = u142
            if v1 then
                v1 = not u143
                if v1 then
                    v1 = not u173[u144]
                    if v1 then
                        v2 = os.clock()
                        v1 = u147 <= v2
                    end
                end
            end
            ClaimButton.Active = v1
            ClaimButton.Selectable = v1
            ClaimButton.AutoButtonColor = v1
            if a2 then
                MedalTVUI.Enabled = false
                BlurEffect.Enabled = false
                BlurEffect.Size = 0
                Frame.Position = Position
                OpenScale.Scale = 1
                return
            end
            table.insert(u150, (TweenService:Create(Frame, TweenInfo.new(0.18), {Position = Position + UDim2.fromOffset(0, 14)})))
            table.insert(u150, (TweenService:Create(OpenScale, TweenInfo.new(0.18), {Scale = 0.9})))
            table.insert(u150, (TweenService:Create(BlurEffect, TweenInfo.new(0.2), {Size = 0})))
            task.delay(0.2, function() -- Line: 242
                -- upvalues: u149 (upval), u46 (val), u142 (upval), MedalTVUI (upval), BlurEffect (upval), Frame (upval)
                -- upvalues: Position (upval)
                if u149 == u46 and not u142 then
                    MedalTVUI.Enabled = false
                    BlurEffect.Enabled = false
                    Frame.Position = Position
                    return
                end
            end)
            for i2, i3 in ipairs(u150) do
                i3:Play()
            end
            return
        end
    end
end

Response.OnClientEvent:Connect(function(a1) -- Line: 252
    -- upvalues: u144 (ref), u143 (ref), TextLabel (val), u172 (val), u142 (ref), u173 (val), u147 (ref)
    -- upvalues: ClaimButton (val), u146 (ref), u145 (ref), Sound_2 (val)
    if type(a1) == "table" and typeof(a1.Code) == "string" then
        local v1, v2
        if a1.RequestId ~= nil then
            if u142 and a1.RequestId == u146 then
                u146 = nil
                u143 = false
                u144 = a1.Code
                if a1.BalancesPending then
                    u144 = "Pending"
                end
                TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
                v1 = u142
                if v1 then
                    v1 = not u143
                    if v1 then
                        v1 = not u173[u144]
                        if v1 then
                            v2 = os.clock()
                            v1 = u147 <= v2
                        end
                    end
                end
                ClaimButton.Active = v1
                ClaimButton.Selectable = v1
                ClaimButton.AutoButtonColor = v1
                local u70 = u145
                task.delay(math.max(0, u147 - (os.clock())), function() -- Line: 269
                    -- upvalues: u142 (upval), u70 (val), u145 (upval), TextLabel (upval), u143 (upval), u172 (upval)
                    -- upvalues: u144 (upval), u173 (upval), u147 (upval), ClaimButton (upval)
                    if u142 and u70 == u145 then
                        TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
                        local v1 = u142
                        if v1 then
                            v1 = not u143
                            if v1 then
                                v1 = not u173[u144]
                                if v1 then
                                    local v2 = os.clock()
                                    v1 = u147 <= v2
                                end
                            end
                        end
                        ClaimButton.Active = v1
                        ClaimButton.Selectable = v1
                        ClaimButton.AutoButtonColor = v1
                    end
                end)
                if a1.Code == "Granted" then
                    Sound_2:Play()
                end
                return
            end
            return
        end
        if a1.Code == "Granted" or a1.Code == "Claimed" then
            u144 = "Claimed"
            if not u143 then
                TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
                v1 = u142
                if v1 then
                    v1 = not u143
                    if v1 then
                        v1 = not u173[u144]
                        if v1 then
                            v2 = os.clock()
                            v1 = u147 <= v2
                        end
                    end
                end
                ClaimButton.Active = v1
                ClaimButton.Selectable = v1
                ClaimButton.AutoButtonColor = v1
            end
        end
        return
    end
end)
ProximityPromptService.PromptTriggered:Connect(function(a1, a2) -- Line: 275
    -- upvalues: LocalPlayer (val), u148 (ref), Workspace (val), u102 (ref), u101 (ref), setOpen (val)
    if a2 == LocalPlayer then
        local v1 = os.clock() - u148
        if not (v1 <= 0.3) then
            v1 = Workspace:FindFirstChild("NPC[MEDAL]")
            local HumanoidRootPart = v1 and v1:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") and a1.Parent == HumanoidRootPart then
                u102 = a1
                u101 = HumanoidRootPart
                setOpen(true)
            end
            return
        end
    end
end)
ClaimButton.Activated:Connect(function() -- Line: 285 -- upvalues: ClaimButton (val), sendRequest (val)
    if ClaimButton.Active then
        sendRequest("Claim")
    end
end)
CloseButton.Activated:Connect(function() -- Line: 288 -- upvalues: setOpen (val)
    setOpen(false)
end)
ConsoleModalBack.Event:Connect(function(a1) -- Line: 289 -- upvalues: setOpen (val) -- types: a1: string
    if a1 == "MedalTVUI" then
        setOpen(false)
    end
end)
ConsoleModalBack:SetAttribute("MedalTVUIBackHandlerReady", true)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 293 -- upvalues: u142 (ref), setOpen (val) -- types: a1: userdata, a2: boolean
    if not a2 and u142 then
        if a1.KeyCode == Enum.KeyCode.Escape or a1.KeyCode == Enum.KeyCode.E then
            setOpen(false)
        end
        return
    end
end)
;(MedalTVUI:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 297 -- upvalues: MedalTVUI (val), u142 (ref), setOpen (val)
    if not MedalTVUI.Enabled and u142 then
        setOpen(false, true)
    end
end)
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 300 -- upvalues: setOpen (val)
    setOpen(false, true)
end)
for i, v in ipairs({"FishDead", "FishLocalDead", "FishVictory", "TestDataResetting"}) do
    (LocalPlayer:GetAttributeChangedSignal(v)):Connect(function() -- Line: 302 -- upvalues: u142 (ref), LocalPlayer (val), v (val), setOpen (val)
        if u142 and LocalPlayer:GetAttribute(v) == true then
            setOpen(false, true)
        end
    end)
end

local function watchMenu(a1) -- Line: 306
    -- upvalues: u174 (val), u142 (ref), anotherMenuOpen (val), setOpen (val)
    if a1:IsA("ScreenGui") and table.find(u174, a1.Name) then
        (a1:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 308 -- upvalues: u142 (upval), anotherMenuOpen (upval), setOpen (upval)
            if u142 and anotherMenuOpen() then
                setOpen(false, true)
            end
        end)
    end
end

for i2, i3 in ipairs(PlayerGui:GetChildren()) do
    watchMenu(i3)
end
PlayerGui.ChildAdded:Connect(watchMenu)
script.Destroying:Connect(function() -- Line: 315 -- upvalues: setOpen (val), ConsoleModalBack (val), BlurEffect (val), Sound (val), Sound_2 (val)
    setOpen(false, true)
    ConsoleModalBack:SetAttribute("MedalTVUIBackHandlerReady", false)
    BlurEffect:Destroy()
    Sound:Destroy()
    Sound_2:Destroy()
end)
RunService.Heartbeat:Connect(function() -- Line: 322
    -- upvalues: u142 (ref), u151 (ref), LocalPlayer (val), u101 (ref), Workspace (val), u102 (ref)
    -- upvalues: anotherMenuOpen (val), setOpen (val)
    if u142 and not (os.clock() < u151) then
        u151 = os.clock() + 0.15
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart or not u101 or not u101:IsDescendantOf(Workspace) or not u102 then
            setOpen(false, true)
        else
            local Magnitude = (HumanoidRootPart.Position - u101.Position).Magnitude
            if u102.MaxActivationDistance + 5 < Magnitude or anotherMenuOpen() then
                setOpen(false, true)
            end
        end
        return
    end
end)
MedalTVUI.ResetOnSpawn = false
MedalTVUI.Enabled = false
CloseButton.Active = true
CloseButton.Selectable = true
CloseButton.NextSelectionDown = ClaimButton
ClaimButton.NextSelectionUp = CloseButton
EggReward.Text = "+ " .. tostring((MedalRewardsRemotes:GetAttribute("RewardScales")) or 500)
SpinReward.Text = "+ " .. tostring((MedalRewardsRemotes:GetAttribute("RewardBonusSpins")) or 5)
TextLabel.Text = if not u143 then u172[u144] or "TRY AGAIN" else "CHECKING..."
local v1 = u142 and not u143 and not u173[u144] and u147 <= os.clock()
ClaimButton.Active = v1
ClaimButton.Selectable = v1
ClaimButton.AutoButtonColor = v1
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.WeaponCratePresentationClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.WeaponCratePresentationClient
-- Decompile time: 16.14 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local FishGame = ReplicatedStorage:WaitForChild("FishGame")
local Config = require(FishGame:WaitForChild("Config"))
local CrateFX = FishGame.Remotes:WaitForChild("CrateFX")
local Guns = FishGame.Assets:WaitForChild("Guns")
local CrateSounds = FishGame.Assets:WaitForChild("CrateSounds")
local WeaponCrate = Workspace:WaitForChild("WeaponCrate")
local Base = WeaponCrate:WaitForChild("Base")
local Lid = WeaponCrate:WaitForChild("Lid")
local CFrame_2 = Lid.CFrame
local u79 = CFrame_2 * CFrame.new(0, 1.35, -1.15) * CFrame.Angles(-1.0122909661567112, 0, 0)
local _LocalWeaponCrateFX = Workspace:FindFirstChild("_LocalWeaponCrateFX")
if not _LocalWeaponCrateFX then
    _LocalWeaponCrateFX = Instance.new("Folder")
end
_LocalWeaponCrateFX.Name = "_LocalWeaponCrateFX"
_LocalWeaponCrateFX.Parent = Workspace
local u90 = nil
local u91 = nil
local u92 = nil
local u93 = 0
local u94 = 0
local u95 = nil

local function playSound(a1, a2) -- Line: 30
    -- upvalues: CrateSounds (val), Base (val), Debris (val)
    local v1 = CrateSounds:FindFirstChild(a1)
    if v1 and v1:IsA("Sound") then
        local v2 = v1:Clone()
        v2.PlaybackSpeed = a2 or 1
        v2.Parent = Base
        v2:Play()
        Debris:AddItem(v2, (math.max(2, v2.TimeLength + 1)))
        return
    end
end

local function tweenLid(a1, a2, a3, a4) -- Line: 37
    -- upvalues: u95 (ref), TweenService (val), Lid (val)
    if u95 then
        u95:Cancel()
    end
    u95 = TweenService:Create(Lid, TweenInfo.new(a2, a3, a4), {CFrame = a1})
    u95:Play()
end

local function clearDisplay() -- Line: 43 -- upvalues: u90 (ref), u91 (ref), u92 (ref)
    if u90 then
        u90:Destroy()
    end
    u90 = nil
    u91 = nil
    u92 = nil
end

local function displayPivot() -- Line: 48 -- upvalues: Base (val), u93 (ref)
    return Base.CFrame * CFrame.new(0, math.sin((os.clock()) * 3.4) * 0.22 + 6.15, 0) * CFrame.Angles(0, u93, 0.13962634015954636)
end

local function spawnDisplay(a1) -- Line: 52
    -- upvalues: u90 (ref), u91 (ref), u92 (ref), Guns (val), _LocalWeaponCrateFX (val), displayPivot (val)
    -- upvalues: Config (val), u93 (ref)
    if u90 then
        u90:Destroy()
    end
    u90 = nil
    u91 = nil
    u92 = nil
    local v1 = Guns:FindFirstChild(a1)
    if v1 and v1:IsA("Model") then
        local u21 = v1:Clone()
        u21.Name = "CrateDisplay_" .. a1
        for i, v in ipairs(u21:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Anchored = true
                v.CanCollide = false
                v.CanTouch = false
                v.CanQuery = false
                v.CastShadow = false
            elseif v:IsA("BaseScript") then
                v:Destroy()
            end
        end
        u21.Parent = _LocalWeaponCrateFX
        local ExtentsSize = u21:GetExtentsSize()
        local u48 = math.max(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z)
        if u48 > 0.01 then
            pcall(function() -- Line: 65 -- upvalues: u21 (val), u48 (val)
                u21:ScaleTo((u21:GetScale()) * (4.8 / u48))
            end)
        end
        u21:PivotTo((displayPivot()))
        local BasePart = u21:FindFirstChildWhichIsA("BasePart", true)
        if BasePart then
            local PointLight = Instance.new("PointLight")
            PointLight.Name = "WeaponRevealLight"
            PointLight.Color = Config.Guns[a1].Color
            PointLight.Brightness = 1.4
            PointLight.Range = 13
            PointLight.Shadows = false
            PointLight.Parent = BasePart
            u92 = PointLight
        end
        u90 = u21
        u91 = a1
        u93 = 0
        return u21
    end
    return nil
end

local function revealRing(a1) -- Line: 76
    -- upvalues: Base (val), _LocalWeaponCrateFX (val), TweenService (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = "WeaponRevealRing"
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(0.11999999731779099, 1.5, 1.5)
    Part.Material = Enum.Material.Neon
    Part.Color = a1
    Part.Transparency = 0.08
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.CastShadow = false
    Part.CFrame = Base.CFrame * CFrame.new(0, 5.35, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Parent = _LocalWeaponCrateFX
    TweenService:Create(
        Part,
        TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = Vector3.new(0.11999999731779099, 9, 9), Transparency = 1}
    ):Play()
    Debris:AddItem(Part, 0.5)
end

local u109 = {"Shotgun", "Tommy", "Rifle", "LMG", "Rocket", "Minigun"}
local u116 = {0.055, 0.06, 0.065, 0.075, 0.085, 0.1, 0.12, 0.15, 0.19, 0.23}

local function startRoll() -- Line: 88
    -- upvalues: u94 (ref), u90 (ref), u91 (ref), u92 (ref), tweenLid (val), CFrame_2 (val), playSound (val), u79 (val)
    -- upvalues: u116 (val), u109 (val), spawnDisplay (val)
    u94 = u94 + 1
    local u2 = u94
    if u90 then
        u90:Destroy()
    end
    u90 = nil
    u91 = nil
    u92 = nil
    tweenLid(CFrame_2, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    task.delay(0.1, function() -- Line: 93 -- upvalues: u2 (val), u94 (upval), playSound (upval), tweenLid (upval), u79 (upval)
        if u2 ~= u94 then
            return
        end
        playSound("Open")
        tweenLid(u79, 0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end)
    task.spawn(function() -- Line: 98
        -- upvalues: u116 (upval), u2 (val), u94 (upval), u109 (upval), spawnDisplay (upval), playSound (upval)
        local v1
        task.wait(0.14)
        for i, v in ipairs(u116) do
            if u2 ~= u94 then
                return
            end
            v1 = u109[(i - 1) % #u109 + 1]
            spawnDisplay(v1)
            playSound("Tick", 0.9 + i * 0.035)
            task.wait(v)
        end
    end)
end

local function revealWeapon(a1) -- Line: 110
    -- upvalues: u94 (ref), spawnDisplay (val), playSound (val), revealRing (val), Config (val), u92 (ref)
    -- upvalues: TweenService (val)
    u94 = u94 + 1
    local u5 = spawnDisplay(a1)
    if not u5 then
        return
    end
    playSound("Reveal")
    revealRing(Config.Guns[a1].Color)
    if u92 then
        u92.Brightness = 5
        u92.Range = 20
        TweenService:Create(u92, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 1.4, Range = 13}):Play()
    end
    local Scale = u5:GetScale()
    pcall(function() -- Line: 121 -- upvalues: u5 (val), Scale (val)
        u5:ScaleTo(Scale * 0.72)
    end)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = 0.72
    local u52 = (NumberValue:GetPropertyChangedSignal("Value")):Connect(function() -- Line: 123 -- upvalues: u5 (val), Scale (val), NumberValue (val)
        if u5.Parent then
            pcall(function() -- Line: 124 -- upvalues: u5 (upval), Scale (upval), NumberValue (upval)
                u5:ScaleTo(Scale * NumberValue.Value)
            end)
        end
    end)
    local v1 = TweenService:Create(NumberValue, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Value = 1})
    v1:Play()
    v1.Completed:Connect(function() -- Line: 127 -- upvalues: u52 (val), NumberValue (val)
        u52:Disconnect()
        NumberValue:Destroy()
    end)
end

local function collectWeapon(a1, a2) -- Line: 130
    -- upvalues: u94 (ref), u90 (ref), u91 (ref), u92 (ref), playSound (val), tweenLid (val), CFrame_2 (val)
    -- upvalues: Players (val), Base (val), TweenService (val)
    u94 = u94 + 1
    local u4 = u90
    u90 = nil
    u91 = nil
    u92 = nil
    playSound("Collect")
    tweenLid(CFrame_2, 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    task.delay(0.18, function() -- Line: 136 -- upvalues: playSound (upval)
        playSound("Close")
    end)
    if not u4 then
        return
    end
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    local Character = PlayerByUserId and PlayerByUserId.Character and PlayerByUserId.Character:FindFirstChild("HumanoidRootPart")
    local Pivot = u4:GetPivot()
    local v1 = if not Character then Base.Position + Vector3.new(0, 2, 0) else if not Character:IsA("BasePart") then Base.Position + Vector3.new(0, 2, 0) else Character.Position + Vector3.new(0, 1.2000000476837158, 0)
    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = Pivot
    local u63 = (CFrameValue:GetPropertyChangedSignal("Value")):Connect(function() -- Line: 143 -- upvalues: u4 (val), CFrameValue (val)
        if u4.Parent then
            u4:PivotTo(CFrameValue.Value)
        end
    end)
    local v2 = TweenService:Create(
        CFrameValue,
        TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Value = (CFrame.new(v1)) * Pivot.Rotation}
    )
    v2:Play()
    task.delay(0.18, function() -- Line: 146 -- upvalues: u4 (val), TweenService (upval)
        local v1, v2
        if not u4.Parent then
            return
        end
        for i, v in ipairs(u4:GetDescendants()) do
            if v:IsA("BasePart") then
                v1 = TweenService
                v2 = TweenInfo.new(0.15)
                v1:Create(v, v2, {Transparency = 1}):Play()
            end
        end
    end)
    v2.Completed:Connect(function() -- Line: 150 -- upvalues: u63 (val), CFrameValue (val), u4 (val)
        u63:Disconnect()
        CFrameValue:Destroy()
        u4:Destroy()
    end)
end

RunService.RenderStepped:Connect(function(a1) -- Line: 153 -- upvalues: u90 (ref), u93 (ref), displayPivot (val)
    if u90 and u90.Parent then
        u93 = (u93 + a1 * 0.6632251157578453) % 6.283185307179586
        u90:PivotTo((displayPivot()))
    end
end)
CrateFX.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 160
    -- upvalues: startRoll (val), revealWeapon (val), collectWeapon (val), u94 (ref), u90 (ref), u91 (ref), u92 (ref)
    -- upvalues: tweenLid (val), CFrame_2 (val), playSound (val)
    if a1 == "WeaponRoll" then
        startRoll()
        return
    end
    if a1 == "WeaponResult" and typeof(a3) == "string" then
        revealWeapon(a3)
        return
    end
    if a1 == "WeaponClaimed" and typeof(a2) == "number" and typeof(a3) == "string" then
        collectWeapon(a2, a3)
        return
    end
    if a1 == "WeaponCancelled" then
        u94 = u94 + 1
        if u90 then
            u90:Destroy()
        end
        u90 = nil
        u91 = nil
        u92 = nil
        tweenLid(CFrame_2, 0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        playSound("Close")
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.WinUIClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.WinUIClient
-- Decompile time: 16.52 ms

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local WinUI = PlayerGui:WaitForChild("WinUI")
local Frame = WinUI:WaitForChild("Frame")
local Body = Frame:WaitForChild("Body")
local DayText = Body:WaitForChild("DayText")
local FishSlainCounter = Body:WaitForChild("FishSlainCounter")
local LeaderBoardPosition = Body:WaitForChild("LeaderBoardPosition")
local ScalesEarned = Body:WaitForChild("ScalesEarned")
local ClaimScalesButton = Frame:WaitForChild("SellAndMoney"):WaitForChild("ClaimScalesButton")
local TextLabel = ClaimScalesButton:WaitForChild("TextLabel")
local FishGame = ReplicatedStorage:WaitForChild("FishGame")
local Config = require(FishGame:WaitForChild("Config"))
local Remotes = FishGame:WaitForChild("Remotes")
local VictoryState = Remotes:WaitForChild("VictoryState")
local RespawnAction = Remotes:WaitForChild("RespawnAction")
local u107 = false
local u108 = false
local u109 = nil
local u110 = nil
WinUI.Enabled = false
local VictoryBlur = Lighting:FindFirstChild("VictoryBlur")
if not VictoryBlur or not VictoryBlur:IsA("BlurEffect") then
    if VictoryBlur then
        VictoryBlur:Destroy()
    end
    VictoryBlur = Instance.new("BlurEffect")
    VictoryBlur.Name = "VictoryBlur"
    VictoryBlur.Size = 0
    VictoryBlur.Enabled = false
    VictoryBlur.Parent = Lighting
end

local function commas(a1) -- Line: 49 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.max(0, (math.floor(a1)))))
    repeat
        v1, v2 = v3:gsub("^(%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function closeGameScreens() -- Line: 58 -- upvalues: PlayerGui (val)
    local v1
    for i, v in ipairs({
        "FishHUD",
        "FishGameGui",
        "UpgradeShop",
        "DeathUI",
        "SkipDayUI",
        "TravelingMerchantShop",
        "PilotShop",
    }) do
        v1 = PlayerGui:FindFirstChild(v)
        if v1 and v1:IsA("ScreenGui") then
            v1.Enabled = false
        end
    end
end

local function clearViewmodel() -- Line: 74 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    local FishGameViewmodel = CurrentCamera and CurrentCamera:FindFirstChild("FishGameViewmodel")
    if FishGameViewmodel then
        FishGameViewmodel:Destroy()
    end
end

local function unlockCursor() -- Line: 80
    -- upvalues: u107 (ref), Workspace (val), u109 (ref), u110 (ref), LocalPlayer (val), UserInputService (val)
    if not u107 then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera and u109 then
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.CFrame = u109
        if u110 then
            CurrentCamera.Focus = u110
        end
    end
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
end

local function beginModalInput() -- Line: 93
    -- upvalues: Workspace (val), u109 (ref), u110 (ref), LocalPlayer (val), RunService (val), unlockCursor (val)
    -- upvalues: u107 (ref), UserInputService (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        u109 = CurrentCamera.CFrame
        u110 = CurrentCamera.Focus
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
    end
    LocalPlayer:SetAttribute("FishResearchOpen", true)
    RunService:UnbindFromRenderStep("WinUICursorControl")
    RunService:BindToRenderStep("WinUICursorControl", Enum.RenderPriority.Camera.Value + 20, unlockCursor)
    if not u107 then
        return
    end
    local CurrentCamera_2 = Workspace.CurrentCamera
    if CurrentCamera_2 and u109 then
        CurrentCamera_2.CameraType = Enum.CameraType.Scriptable
        CurrentCamera_2.CFrame = u109
        if u110 then
            CurrentCamera_2.Focus = u110
        end
    end
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
end

local function playWinSound() -- Line: 110 -- upvalues: Config (val), SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = "VictoryWinSound"
    Sound.SoundId = Config.Victory.WinSoundId
    Sound.Volume = Config.Victory.WinSoundVolume
    Sound.Parent = SoundService
    SoundService:PlayLocalSound(Sound)
    Sound.Ended:Once(function() -- Line: 117 -- upvalues: Sound (val)
        Sound:Destroy()
    end)
    task.delay(15, function() -- Line: 118 -- upvalues: Sound (val)
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
end

VictoryState.OnClientEvent:Connect(function(a1) -- Line: 121
    -- upvalues: u107 (ref), LocalPlayer (val), closeGameScreens (val), Workspace (val), SoundService (val)
    -- upvalues: Lighting (val), beginModalInput (val), VictoryBlur (ref), TweenService (val), u109 (ref), u110 (ref)
    -- upvalues: UserInputService (val), DayText (val), commas (val), FishSlainCounter (val), LeaderBoardPosition (val)
    -- upvalues: ScalesEarned (val), TextLabel (val), u108 (ref), WinUI (val), playWinSound (val)
    if typeof(a1) == "table" and a1.Active == true then
        local v1 = not u107
        u107 = true
        LocalPlayer:SetAttribute("FishLocalVictory", true)
        closeGameScreens()
        local CurrentCamera = Workspace.CurrentCamera
        local FishGameViewmodel = CurrentCamera and CurrentCamera:FindFirstChild("FishGameViewmodel")
        if FishGameViewmodel then
            FishGameViewmodel:Destroy()
        end
        local PlayerDeathLocal = SoundService:FindFirstChild("PlayerDeathLocal")
        if PlayerDeathLocal and PlayerDeathLocal:IsA("Sound") then
            PlayerDeathLocal:Destroy()
        end
        local PlayerDeathGrayscale = Lighting:FindFirstChild("PlayerDeathGrayscale")
        if PlayerDeathGrayscale and PlayerDeathGrayscale:IsA("ColorCorrectionEffect") then
            PlayerDeathGrayscale.Saturation = 0
            PlayerDeathGrayscale.Contrast = 0
            PlayerDeathGrayscale.Enabled = false
        end
        if v1 then
            beginModalInput()
            VictoryBlur.Enabled = true
            VictoryBlur.Size = 0
            TweenService:Create(VictoryBlur, TweenInfo.new(0.22), {Size = 12}):Play()
        elseif u107 then
            local CurrentCamera_2 = Workspace.CurrentCamera
            if CurrentCamera_2 and u109 then
                CurrentCamera_2.CameraType = Enum.CameraType.Scriptable
                CurrentCamera_2.CFrame = u109
                if u110 then
                    CurrentCamera_2.Focus = u110
                end
            end
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            UserInputService.MouseIconEnabled = true
        end
        DayText.Text = "Day " .. commas(tonumber(a1.Day) or 1)
        FishSlainCounter.Text = (commas(tonumber(a1.FishSlain) or 0)) .. " Fish slain"
        local v2 = math.max(0, (math.floor((tonumber(a1.LeaderboardPosition)) or 0)))
        LeaderBoardPosition.Text = if not (v2 > 0) then "Leaderboard position: --" else "Leaderboard position: " .. commas(v2)
        ScalesEarned.Text = (commas(tonumber(a1.ScalesEarned) or 0)) .. " Scales earned"
        TextLabel.Text = if not u108 then "Claim" else "Claiming..."
        WinUI.Enabled = true
        if v1 then
            playWinSound()
        end
        return
    end
end)
ClaimScalesButton.Activated:Connect(function() -- Line: 159 -- upvalues: u107 (ref), u108 (ref), TextLabel (val), RespawnAction (val)
    if u107 and not u108 then
        u108 = true
        TextLabel.Text = "Claiming..."
        RespawnAction:FireServer("VictoryReturnToLobby")
        task.delay(4, function() -- Line: 164 -- upvalues: u107 (upval), u108 (upval), TextLabel (upval)
            if u107 then
                u108 = false
                TextLabel.Text = "Claim"
            end
        end)
        return
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.WadingSoundsClient
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.WadingSoundsClient
-- Decompile time: 10.80 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local u20 = {"rbxassetid://9120609652", "rbxassetid://9120609785", "rbxassetid://9120609739"}
local LocalPlayer = Players.LocalPlayer
local ValidBossArea = Workspace:WaitForChild("ValidBossArea")
local u30 = Random.new()
local u31 = nil
local u32 = nil
local u33 = 2.75
local u34 = 0
local u35 = {}
local u36 = {}

local function chooseSoundIndex() -- Line: 30 -- upvalues: u20 (val), u30 (val), u34 (ref)
    if #u20 <= 1 then
        return 1
    end
    local v1 = u30:NextInteger(1, #u20 - 1)
    if u34 <= v1 then
        v1 = v1 + 1
    end
    u34 = v1
    return v1
end

local function playWadingSound(a1) -- Line: 38
    -- upvalues: u20 (val), u30 (val), u34 (ref), u35 (val)
    local v1
    local Sound = Instance.new("Sound")
    Sound.Name = "LocalWadingStep"
    local v2 = #u20
    if not (v2 <= 1) then
        v2 = u30:NextInteger(1, #u20 - 1)
        if u34 <= v2 then
            v2 = v2 + 1
        end
        u34 = v2
        v1 = v2
    else
        v1 = 1
    end
    Sound.SoundId = u20[v1]
    Sound.Volume = u30:NextNumber(0.55, 0.68)
    Sound.PlaybackSpeed = u30:NextNumber(0.86, 1.14)
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.RollOffMinDistance = 5
    Sound.RollOffMaxDistance = 45
    Sound.Parent = a1
    u35[Sound] = true
    Sound.Ended:Once(function() -- Line: 49 -- upvalues: u35 (upval), Sound (val)
        u35[Sound] = nil
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
    task.delay(6, function() -- Line: 53 -- upvalues: u35 (upval), Sound (val)
        u35[Sound] = nil
        if Sound.Parent then
            Sound:Destroy()
        end
    end)
    Sound:Play()
end

local function fadeSound(a1) -- Line: 60 -- upvalues: u36 (val), u35 (val), TweenService (val) -- types: a1: userdata
    if not u36[a1] and a1.Parent then
        u35[a1] = nil
        u36[a1] = true
        local v1 = TweenService:Create(a1, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {Volume = 0})
        v1.Completed:Once(function() -- Line: 69 -- upvalues: u36 (upval), a1 (val)
            u36[a1] = nil
            if a1.Parent then
                a1:Stop()
                a1:Destroy()
            end
        end)
        v1:Play()
        return
    end
end

local function fadeActiveSounds(a1) -- Line: 79 -- upvalues: u35 (val), fadeSound (val) -- types: a1: userdata?
    local v1 = {}
    for k in pairs(u35) do
        table.insert(v1, k)
    end
    if a1 then
        for i, v in ipairs(a1:GetChildren()) do
            if v:IsA("Sound") and v.Name == "LocalWadingStep" and not u35[v] then
                table.insert(v1, v)
            end
        end
    end
    for i2, i3 in ipairs(v1) do
        fadeSound(i3)
    end
end

local function characterIsInWadingArea(a1, a2) -- Line: 94
    -- upvalues: ValidBossArea (val)
    local v1 = ValidBossArea.CFrame:PointToObjectSpace(a1.Position)
    local v2 = ValidBossArea.Size * 0.5
    local v3 = math.max(0, v2.X - 0.75)
    local v4 = math.max(0, v2.Z - 0.75)
    if not (v3 < math.abs(v1.X)) and not (v4 < math.abs(v1.Z)) then
        local v5 = ValidBossArea.CFrame:PointToObjectSpace(a1.Position - Vector3.new(0, 1, 0) * (a2.HipHeight + a1.Size.Y * 0.5))
        local v6 = math.min(v5.Y, v1.Y)
        local v7 = math.max(v5.Y, v1.Y)
        local v8 = false
        if v6 <= v2.Y then
            v8 = -v2.Y <= v7
        end
        return v8
    end
    return false
end

local function canMakeWadingSteps(a1) -- Line: 108 -- upvalues: LocalPlayer (val) -- types: a1: userdata
    if not (a1.Health <= 0) and LocalPlayer:GetAttribute("FishDead") ~= true then
        if not (a1.MoveDirection.Magnitude <= 0.05) and a1.FloorMaterial ~= Enum.Material.Air then
            local State = a1:GetState()
            local v1 = false
            if State ~= Enum.HumanoidStateType.Dead then
                v1 = false
                if State ~= Enum.HumanoidStateType.Freefall then
                    v1 = false
                    if State ~= Enum.HumanoidStateType.Jumping then
                        v1 = State ~= Enum.HumanoidStateType.Seated
                    end
                end
            end
            return v1
        end
        return false
    end
    return false
end

RunService.Heartbeat:Connect(function(a1) -- Line: 118
    -- upvalues: LocalPlayer (val), fadeActiveSounds (val), u31 (ref), u32 (ref), u33 (ref)
    -- upvalues: characterIsInWadingArea (val), canMakeWadingSteps (val), playWadingSound (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") and Humanoid then
        if HumanoidRootPart ~= u31 then
            fadeActiveSounds(u31)
            fadeActiveSounds(HumanoidRootPart)
            u31 = HumanoidRootPart
            u32 = HumanoidRootPart.Position
            u33 = 2.75
            return
        end
        local Position = u32 or HumanoidRootPart.Position
        u32 = HumanoidRootPart.Position
        local v1 = HumanoidRootPart.Position - Position
        local Magnitude = (Vector3.new(v1.X, 0, v1.Z)).Magnitude
        if characterIsInWadingArea(HumanoidRootPart, Humanoid) and canMakeWadingSteps(Humanoid) then
            u33 = u33 + math.min(Magnitude, 2.5)
            if not (u33 >= 5.5) then
                return
            end
            u33 = u33 % 5.5
            playWadingSound(HumanoidRootPart)
            return
        end
        fadeActiveSounds(HumanoidRootPart)
        u33 = math.min(u33, 2.75)
        return
    end
    fadeActiveSounds(u31)
    u31 = nil
    u32 = nil
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.TurretAnimationClient
-- Took 0.07s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.TurretAnimationClient
-- Decompile time: 79.74 ms

local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local u20 = {}
local u21 = {}

local function barrelAxis(a1) -- Line: 18 -- types: a1: userdata
    local RightVector, v1
    local v2 = 0
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") then
            v2 = math.max(v2, v.Size.X, v.Size.Y, v.Size.Z)
        end
    end
    local v3 = nil
    local v4 = Vector3.new(0, 0, 0)
    for i2, i3 in ipairs(a1:GetDescendants()) do
        if i3:IsA("BasePart") then
            v1 = math.max(i3.Size.X, i3.Size.Y, i3.Size.Z)
            if v2 * 0.75 <= v1 then
                RightVector = if v1 ~= i3.Size.X then if v1 ~= i3.Size.Y then i3.CFrame.LookVector else i3.CFrame.UpVector else i3.CFrame.RightVector
                if v3 and (RightVector:Dot(v3)) < 0 then
                    RightVector = -RightVector
                end
                v4 = v4 + RightVector * v1
            end
        end
    end
    if 0.001 < v4.Magnitude then
        return v4.Unit
    end
    return a1:GetPivot().LookVector
end

local function makeTracer(a1, a2) -- Line: 45
    -- upvalues: Workspace (val), Debris (val)
    if (a2 - a1).Magnitude < 0.2 then
        return
    end
    local Part = Instance.new("Part")
    Part.Name = "TurretTracerStart"
    Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.CFrame = CFrame.new(a1)
    Part.Parent = Workspace
    local v1 = Part:Clone()
    v1.Name = "TurretTracerEnd"
    v1.CFrame = CFrame.new(a2)
    v1.Parent = Workspace
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Parent = v1
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.FaceCamera = true
    Beam.Width0 = 0.075
    Beam.Width1 = 0.025
    Beam.Color = ColorSequence.new(Color3.new(1, 1, 1))
    Beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.05), (NumberSequenceKeypoint.new(1, 0.35))})
    Beam.LightEmission = 1
    Beam.Brightness = 5
    Beam.Parent = Part
    task.delay(0.055, function() -- Line: 79 -- upvalues: Beam (val)
        if Beam.Parent then
            Beam.Enabled = false
        end
    end)
    Debris:AddItem(Part, 0.11)
    Debris:AddItem(v1, 0.11)
end

local function emitShotTracer(a1) -- Line: 86 -- upvalues: makeTracer (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute("TurretShotPosition")
    if typeof(Attribute) ~= "Vector3" then
        return
    end
    local Gun = a1:FindFirstChild("Gun", true)
    if Gun and Gun:IsA("Model") then
        local v1, v2
        local Position = Gun:GetBoundingBox().Position
        local v3 = Attribute - Position
        if v3.Magnitude < 0.2 then
            return
        end
        local v4 = Position
        local v5 = (-1 / 0)
        for i, v in ipairs(Gun:GetDescendants()) do
            if v:IsA("BasePart") then
                for i2, i3 in ipairs({-1, 1}) do
                    for i4, j in ipairs({-1, 1}) do
                        for i5, k in ipairs({-1, 1}) do
                            v1 = v.CFrame:PointToWorldSpace((Vector3.new(v.Size.X * i3 * 0.5, v.Size.Y * j * 0.5, v.Size.Z * k * 0.5)))
                            v2 = (v1 - Position):Dot(v3.Unit)
                            if v5 < v2 then
                                v4 = v1
                            end
                        end
                    end
                end
            end
        end
        makeTracer(v4, Attribute)
        return
    end
end

local function isOperational(a1) -- Line: 121 -- types: a1: userdata
    local v1 = false
    if a1.Parent ~= nil then
        v1 = false
        if a1:GetAttribute("TurretActive") == true then
            v1 = a1:GetAttribute("WorldUpgradeMoving") ~= true
        end
    end
    return v1
end

local function bindTurret(a1) -- Line: 127 -- upvalues: u20 (val), barrelAxis (val) -- types: a1: userdata
    if not u20[a1] then
        local v1 = false
        if a1.Parent ~= nil then
            v1 = false
            if a1:GetAttribute("TurretActive") == true then
                v1 = a1:GetAttribute("WorldUpgradeMoving") ~= true
            end
        end
        if v1 then
            task.spawn(function() -- Line: 129 -- upvalues: a1 (val), u20 (upval), barrelAxis (upval)
                local head = a1:WaitForChild("head", 10)
                local TurretTarget = a1:WaitForChild("TurretTarget", 10)
                if head and head:IsA("Model") and TurretTarget and TurretTarget:IsA("ObjectValue") then
                    local BoundingBox_3, BoundingBox_4, Pivot_2, v1, v2
                    local Gun = head:FindFirstChild("Gun")
                    local BoundingBox, BoundingBox_2 = head:GetBoundingBox()
                    for i = 1, 50 do
                        if 0.5 < BoundingBox_2.Magnitude then
                            break
                        end
                        task.wait(0.1)
                        BoundingBox_3, BoundingBox_4 = head:GetBoundingBox()
                        BoundingBox = BoundingBox_3
                    end
                    local v3 = false
                    local Pivot = a1:GetPivot()
                    for j = 1, 120 do
                        task.wait(0.1)
                        v2 = a1
                        v1 = false
                        if v2.Parent ~= nil then
                            v1 = false
                            if v2:GetAttribute("TurretActive") == true then
                                v1 = v2:GetAttribute("WorldUpgradeMoving") ~= true
                            end
                        end
                        if not v1 then
                            return
                        end
                        Pivot_2 = a1:GetPivot()
                        if not ((Pivot_2.Position - Pivot.Position).Magnitude < 0.01) then
                            v3 = false
                        else
                            if v3 then
                                break
                            end
                            v3 = true
                        end
                    end
                    if v3 then
                        local v4 = a1
                        local v5 = false
                        if v4.Parent ~= nil then
                            v5 = false
                            if v4:GetAttribute("TurretActive") == true then
                                v5 = v4:GetAttribute("WorldUpgradeMoving") ~= true
                            end
                        end
                        if v5 and not u20[a1] then
                            local v6, v7, v8, v9
                            v5 = nil
                            v4 = nil
                            for i2, v in ipairs(a1:GetDescendants()) do
                                if v:IsA("BasePart") and not v:IsDescendantOf(head) then
                                    v6 = v.Size * 0.5
                                    v7 = v.Position - v6
                                    v8 = v.Position + v6
                                    v5 = if not v5 then v7 else Vector3.new(math.min(v5.X, v7.X), math.min(v5.Y, v7.Y), (math.min(v5.Z, v7.Z)))
                                    v4 = if not v4 then v8 else Vector3.new(math.max(v4.X, v8.X), math.max(v4.Y, v8.Y), (math.max(v4.Z, v8.Z)))
                                end
                            end
                            local BoundingBox_5 = a1:GetBoundingBox()
                            local Position = if not v5 then BoundingBox_5.Position else if not v4 then BoundingBox_5.Position else (v5 + v4) * 0.5
                            v2 = if not Gun then nil else if not Gun:IsA("Model") then nil else Gun
                            local BoundingBox_6 = if not v2 then nil else v2:GetBoundingBox()
                            local v10 = Vector3.new(Position.X, BoundingBox.Position.Y, Position.Z)
                            v6 = Vector3.new((if not BoundingBox_6 then Vector3.new(0, 0, 0) else BoundingBox_6.Position - v10).X, 0, v6.Z)
                            if v6.Magnitude <= 0.001 then
                                v6 = BoundingBox.RightVector * -1
                                v6 = Vector3.new(v6.X, 0, v6.Z)
                            end
                            local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, 1) else v6.Unit
                            v7 = {}
                            v8 = {}
                            for i3, k in ipairs(head:GetDescendants()) do
                                if k:IsA("BasePart") then
                                    v9 = {Part = k, Rest = k.CFrame}
                                    if not v2 or not k:IsDescendantOf(v2) then
                                        table.insert(v7, v9)
                                    else
                                        table.insert(v8, v9)
                                    end
                                end
                            end
                            u20[a1] = {
                                Yaw = 0,
                                Pitch = 0,
                                SpinAngle = 0,
                                SpinSpeed = 0,
                                Head = head,
                                Gun = v2,
                                TargetValue = TurretTarget,
                                HeadParts = v7,
                                GunParts = v8,
                                Forward0 = Unit,
                                RotationPoint = v10,
                                GunCentre0 = if not BoundingBox_6 then nil else BoundingBox_6.Position,
                                GunAxis0 = if not v2 then nil else barrelAxis(v2),
                                Origin0 = a1:GetPivot().Position,
                            }
                            return
                        end
                    end
                    return
                end
            end)
            return
        end
    end
end

local function refreshTurret(a1) -- Line: 229 -- upvalues: u20 (val), barrelAxis (val) -- types: a1: userdata
    local v1 = false
    if a1.Parent ~= nil then
        v1 = false
        if a1:GetAttribute("TurretActive") == true then
            v1 = a1:GetAttribute("WorldUpgradeMoving") ~= true
        end
    end
    if not v1 then
        u20[a1] = nil
        return
    end
    if u20[a1] then
        return
    end
    v1 = false
    if a1.Parent ~= nil then
        v1 = false
        if a1:GetAttribute("TurretActive") == true then
            v1 = a1:GetAttribute("WorldUpgradeMoving") ~= true
        end
    end
    if not v1 then
        return
    end
    task.spawn(function() -- Line: 129 -- upvalues: a1 (val), u20 (upval), barrelAxis (upval)
        local head = a1:WaitForChild("head", 10)
        local TurretTarget = a1:WaitForChild("TurretTarget", 10)
        if head and head:IsA("Model") and TurretTarget and TurretTarget:IsA("ObjectValue") then
            local BoundingBox_3, BoundingBox_4, Pivot_2, v1, v2
            local Gun = head:FindFirstChild("Gun")
            local BoundingBox, BoundingBox_2 = head:GetBoundingBox()
            for i = 1, 50 do
                if 0.5 < BoundingBox_2.Magnitude then
                    break
                end
                task.wait(0.1)
                BoundingBox_3, BoundingBox_4 = head:GetBoundingBox()
                BoundingBox = BoundingBox_3
            end
            local v3 = false
            local Pivot = a1:GetPivot()
            for j = 1, 120 do
                task.wait(0.1)
                v2 = a1
                v1 = false
                if v2.Parent ~= nil then
                    v1 = false
                    if v2:GetAttribute("TurretActive") == true then
                        v1 = v2:GetAttribute("WorldUpgradeMoving") ~= true
                    end
                end
                if not v1 then
                    return
                end
                Pivot_2 = a1:GetPivot()
                if not ((Pivot_2.Position - Pivot.Position).Magnitude < 0.01) then
                    v3 = false
                else
                    if v3 then
                        break
                    end
                    v3 = true
                end
            end
            if v3 then
                local v4 = a1
                local v5 = false
                if v4.Parent ~= nil then
                    v5 = false
                    if v4:GetAttribute("TurretActive") == true then
                        v5 = v4:GetAttribute("WorldUpgradeMoving") ~= true
                    end
                end
                if v5 and not u20[a1] then
                    local v6, v7, v8, v9
                    v5 = nil
                    v4 = nil
                    for i2, v in ipairs(a1:GetDescendants()) do
                        if v:IsA("BasePart") and not v:IsDescendantOf(head) then
                            v6 = v.Size * 0.5
                            v7 = v.Position - v6
                            v8 = v.Position + v6
                            v5 = if not v5 then v7 else Vector3.new(math.min(v5.X, v7.X), math.min(v5.Y, v7.Y), (math.min(v5.Z, v7.Z)))
                            v4 = if not v4 then v8 else Vector3.new(math.max(v4.X, v8.X), math.max(v4.Y, v8.Y), (math.max(v4.Z, v8.Z)))
                        end
                    end
                    local BoundingBox_5 = a1:GetBoundingBox()
                    local Position = if not v5 then BoundingBox_5.Position else if not v4 then BoundingBox_5.Position else (v5 + v4) * 0.5
                    v2 = if not Gun then nil else if not Gun:IsA("Model") then nil else Gun
                    local BoundingBox_6 = if not v2 then nil else v2:GetBoundingBox()
                    local v10 = Vector3.new(Position.X, BoundingBox.Position.Y, Position.Z)
                    v6 = Vector3.new((if not BoundingBox_6 then Vector3.new(0, 0, 0) else BoundingBox_6.Position - v10).X, 0, v6.Z)
                    if v6.Magnitude <= 0.001 then
                        v6 = BoundingBox.RightVector * -1
                        v6 = Vector3.new(v6.X, 0, v6.Z)
                    end
                    local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, 1) else v6.Unit
                    v7 = {}
                    v8 = {}
                    for i3, k in ipairs(head:GetDescendants()) do
                        if k:IsA("BasePart") then
                            v9 = {Part = k, Rest = k.CFrame}
                            if not v2 or not k:IsDescendantOf(v2) then
                                table.insert(v7, v9)
                            else
                                table.insert(v8, v9)
                            end
                        end
                    end
                    u20[a1] = {
                        Yaw = 0,
                        Pitch = 0,
                        SpinAngle = 0,
                        SpinSpeed = 0,
                        Head = head,
                        Gun = v2,
                        TargetValue = TurretTarget,
                        HeadParts = v7,
                        GunParts = v8,
                        Forward0 = Unit,
                        RotationPoint = v10,
                        GunCentre0 = if not BoundingBox_6 then nil else BoundingBox_6.Position,
                        GunAxis0 = if not v2 then nil else barrelAxis(v2),
                        Origin0 = a1:GetPivot().Position,
                    }
                    return
                end
            end
            return
        end
    end)
end

local function watchTurret(a1) -- Line: 237
    -- upvalues: u21 (val), u20 (val), barrelAxis (val), emitShotTracer (val)
    if a1:IsA("Model") and not u21[a1] then
        u21[a1] = {
            (a1:GetAttributeChangedSignal("TurretActive")):Connect(function() -- Line: 240 -- upvalues: a1 (val), u20 (upval), barrelAxis (upval)
                local u0 = a1
                local v1 = false
                if u0.Parent ~= nil then
                    v1 = false
                    if u0:GetAttribute("TurretActive") == true then
                        v1 = u0:GetAttribute("WorldUpgradeMoving") ~= true
                    end
                end
                if not v1 then
                    u20[u0] = nil
                    return
                end
                if u20[u0] then
                    return
                end
                v1 = false
                if u0.Parent ~= nil then
                    v1 = false
                    if u0:GetAttribute("TurretActive") == true then
                        v1 = u0:GetAttribute("WorldUpgradeMoving") ~= true
                    end
                end
                if not v1 then
                    return
                end
                task.spawn(function() -- Line: 129 -- upvalues: u0 (val), u20 (upval), barrelAxis (upval)
                    local head = u0:WaitForChild("head", 10)
                    local TurretTarget = u0:WaitForChild("TurretTarget", 10)
                    if head and head:IsA("Model") and TurretTarget and TurretTarget:IsA("ObjectValue") then
                        local BoundingBox_3, BoundingBox_4, Pivot_2, v1, v2
                        local Gun = head:FindFirstChild("Gun")
                        local BoundingBox, BoundingBox_2 = head:GetBoundingBox()
                        for i = 1, 50 do
                            if 0.5 < BoundingBox_2.Magnitude then
                                break
                            end
                            task.wait(0.1)
                            BoundingBox_3, BoundingBox_4 = head:GetBoundingBox()
                            BoundingBox = BoundingBox_3
                        end
                        local v3 = false
                        local Pivot = u0:GetPivot()
                        for j = 1, 120 do
                            task.wait(0.1)
                            v2 = u0
                            v1 = false
                            if v2.Parent ~= nil then
                                v1 = false
                                if v2:GetAttribute("TurretActive") == true then
                                    v1 = v2:GetAttribute("WorldUpgradeMoving") ~= true
                                end
                            end
                            if not v1 then
                                return
                            end
                            Pivot_2 = u0:GetPivot()
                            if not ((Pivot_2.Position - Pivot.Position).Magnitude < 0.01) then
                                v3 = false
                            else
                                if v3 then
                                    break
                                end
                                v3 = true
                            end
                        end
                        if v3 then
                            local v4 = u0
                            local v5 = false
                            if v4.Parent ~= nil then
                                v5 = false
                                if v4:GetAttribute("TurretActive") == true then
                                    v5 = v4:GetAttribute("WorldUpgradeMoving") ~= true
                                end
                            end
                            if v5 and not u20[u0] then
                                local v6, v7, v8, v9
                                v5 = nil
                                v4 = nil
                                for i2, v in ipairs(u0:GetDescendants()) do
                                    if v:IsA("BasePart") and not v:IsDescendantOf(head) then
                                        v6 = v.Size * 0.5
                                        v7 = v.Position - v6
                                        v8 = v.Position + v6
                                        v5 = if not v5 then v7 else Vector3.new(math.min(v5.X, v7.X), math.min(v5.Y, v7.Y), (math.min(v5.Z, v7.Z)))
                                        v4 = if not v4 then v8 else Vector3.new(math.max(v4.X, v8.X), math.max(v4.Y, v8.Y), (math.max(v4.Z, v8.Z)))
                                    end
                                end
                                local BoundingBox_5 = u0:GetBoundingBox()
                                local Position = if not v5 then BoundingBox_5.Position else if not v4 then BoundingBox_5.Position else (v5 + v4) * 0.5
                                v2 = if not Gun then nil else if not Gun:IsA("Model") then nil else Gun
                                local BoundingBox_6 = if not v2 then nil else v2:GetBoundingBox()
                                local v10 = Vector3.new(Position.X, BoundingBox.Position.Y, Position.Z)
                                v6 = Vector3.new((if not BoundingBox_6 then Vector3.new(0, 0, 0) else BoundingBox_6.Position - v10).X, 0, v6.Z)
                                if v6.Magnitude <= 0.001 then
                                    v6 = BoundingBox.RightVector * -1
                                    v6 = Vector3.new(v6.X, 0, v6.Z)
                                end
                                local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, 1) else v6.Unit
                                v7 = {}
                                v8 = {}
                                for i3, k in ipairs(head:GetDescendants()) do
                                    if k:IsA("BasePart") then
                                        v9 = {Part = k, Rest = k.CFrame}
                                        if not v2 or not k:IsDescendantOf(v2) then
                                            table.insert(v7, v9)
                                        else
                                            table.insert(v8, v9)
                                        end
                                    end
                                end
                                u20[u0] = {
                                    Yaw = 0,
                                    Pitch = 0,
                                    SpinAngle = 0,
                                    SpinSpeed = 0,
                                    Head = head,
                                    Gun = v2,
                                    TargetValue = TurretTarget,
                                    HeadParts = v7,
                                    GunParts = v8,
                                    Forward0 = Unit,
                                    RotationPoint = v10,
                                    GunCentre0 = if not BoundingBox_6 then nil else BoundingBox_6.Position,
                                    GunAxis0 = if not v2 then nil else barrelAxis(v2),
                                    Origin0 = u0:GetPivot().Position,
                                }
                                return
                            end
                        end
                        return
                    end
                end)
            end),
            (a1:GetAttributeChangedSignal("WorldUpgradeMoving")):Connect(function() -- Line: 241 -- upvalues: a1 (val), u20 (upval), barrelAxis (upval)
                local u0 = a1
                local v1 = false
                if u0.Parent ~= nil then
                    v1 = false
                    if u0:GetAttribute("TurretActive") == true then
                        v1 = u0:GetAttribute("WorldUpgradeMoving") ~= true
                    end
                end
                if not v1 then
                    u20[u0] = nil
                    return
                end
                if u20[u0] then
                    return
                end
                v1 = false
                if u0.Parent ~= nil then
                    v1 = false
                    if u0:GetAttribute("TurretActive") == true then
                        v1 = u0:GetAttribute("WorldUpgradeMoving") ~= true
                    end
                end
                if not v1 then
                    return
                end
                task.spawn(function() -- Line: 129 -- upvalues: u0 (val), u20 (upval), barrelAxis (upval)
                    local head = u0:WaitForChild("head", 10)
                    local TurretTarget = u0:WaitForChild("TurretTarget", 10)
                    if head and head:IsA("Model") and TurretTarget and TurretTarget:IsA("ObjectValue") then
                        local BoundingBox_3, BoundingBox_4, Pivot_2, v1, v2
                        local Gun = head:FindFirstChild("Gun")
                        local BoundingBox, BoundingBox_2 = head:GetBoundingBox()
                        for i = 1, 50 do
                            if 0.5 < BoundingBox_2.Magnitude then
                                break
                            end
                            task.wait(0.1)
                            BoundingBox_3, BoundingBox_4 = head:GetBoundingBox()
                            BoundingBox = BoundingBox_3
                        end
                        local v3 = false
                        local Pivot = u0:GetPivot()
                        for j = 1, 120 do
                            task.wait(0.1)
                            v2 = u0
                            v1 = false
                            if v2.Parent ~= nil then
                                v1 = false
                                if v2:GetAttribute("TurretActive") == true then
                                    v1 = v2:GetAttribute("WorldUpgradeMoving") ~= true
                                end
                            end
                            if not v1 then
                                return
                            end
                            Pivot_2 = u0:GetPivot()
                            if not ((Pivot_2.Position - Pivot.Position).Magnitude < 0.01) then
                                v3 = false
                            else
                                if v3 then
                                    break
                                end
                                v3 = true
                            end
                        end
                        if v3 then
                            local v4 = u0
                            local v5 = false
                            if v4.Parent ~= nil then
                                v5 = false
                                if v4:GetAttribute("TurretActive") == true then
                                    v5 = v4:GetAttribute("WorldUpgradeMoving") ~= true
                                end
                            end
                            if v5 and not u20[u0] then
                                local v6, v7, v8, v9
                                v5 = nil
                                v4 = nil
                                for i2, v in ipairs(u0:GetDescendants()) do
                                    if v:IsA("BasePart") and not v:IsDescendantOf(head) then
                                        v6 = v.Size * 0.5
                                        v7 = v.Position - v6
                                        v8 = v.Position + v6
                                        v5 = if not v5 then v7 else Vector3.new(math.min(v5.X, v7.X), math.min(v5.Y, v7.Y), (math.min(v5.Z, v7.Z)))
                                        v4 = if not v4 then v8 else Vector3.new(math.max(v4.X, v8.X), math.max(v4.Y, v8.Y), (math.max(v4.Z, v8.Z)))
                                    end
                                end
                                local BoundingBox_5 = u0:GetBoundingBox()
                                local Position = if not v5 then BoundingBox_5.Position else if not v4 then BoundingBox_5.Position else (v5 + v4) * 0.5
                                v2 = if not Gun then nil else if not Gun:IsA("Model") then nil else Gun
                                local BoundingBox_6 = if not v2 then nil else v2:GetBoundingBox()
                                local v10 = Vector3.new(Position.X, BoundingBox.Position.Y, Position.Z)
                                v6 = Vector3.new((if not BoundingBox_6 then Vector3.new(0, 0, 0) else BoundingBox_6.Position - v10).X, 0, v6.Z)
                                if v6.Magnitude <= 0.001 then
                                    v6 = BoundingBox.RightVector * -1
                                    v6 = Vector3.new(v6.X, 0, v6.Z)
                                end
                                local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, 1) else v6.Unit
                                v7 = {}
                                v8 = {}
                                for i3, k in ipairs(head:GetDescendants()) do
                                    if k:IsA("BasePart") then
                                        v9 = {Part = k, Rest = k.CFrame}
                                        if not v2 or not k:IsDescendantOf(v2) then
                                            table.insert(v7, v9)
                                        else
                                            table.insert(v8, v9)
                                        end
                                    end
                                end
                                u20[u0] = {
                                    Yaw = 0,
                                    Pitch = 0,
                                    SpinAngle = 0,
                                    SpinSpeed = 0,
                                    Head = head,
                                    Gun = v2,
                                    TargetValue = TurretTarget,
                                    HeadParts = v7,
                                    GunParts = v8,
                                    Forward0 = Unit,
                                    RotationPoint = v10,
                                    GunCentre0 = if not BoundingBox_6 then nil else BoundingBox_6.Position,
                                    GunAxis0 = if not v2 then nil else barrelAxis(v2),
                                    Origin0 = u0:GetPivot().Position,
                                }
                                return
                            end
                        end
                        return
                    end
                end)
            end),
            ((a1:GetAttributeChangedSignal("TurretLastShotAt")):Connect(function() -- Line: 242 -- upvalues: emitShotTracer (upval), a1 (val)
                emitShotTracer(a1)
            end)),
        }
        local v1 = false
        if a1.Parent ~= nil then
            v1 = false
            if a1:GetAttribute("TurretActive") == true then
                v1 = a1:GetAttribute("WorldUpgradeMoving") ~= true
            end
        end
        if not v1 then
            u20[a1] = nil
            return
        end
        if u20[a1] then
            return
        end
        v1 = false
        if a1.Parent ~= nil then
            v1 = false
            if a1:GetAttribute("TurretActive") == true then
                v1 = a1:GetAttribute("WorldUpgradeMoving") ~= true
            end
        end
        if not v1 then
            return
        end
        task.spawn(function() -- Line: 129 -- upvalues: a1 (val), u20 (upval), barrelAxis (upval)
            local head = a1:WaitForChild("head", 10)
            local TurretTarget = a1:WaitForChild("TurretTarget", 10)
            if head and head:IsA("Model") and TurretTarget and TurretTarget:IsA("ObjectValue") then
                local BoundingBox_3, BoundingBox_4, Pivot_2, v1, v2
                local Gun = head:FindFirstChild("Gun")
                local BoundingBox, BoundingBox_2 = head:GetBoundingBox()
                for i = 1, 50 do
                    if 0.5 < BoundingBox_2.Magnitude then
                        break
                    end
                    task.wait(0.1)
                    BoundingBox_3, BoundingBox_4 = head:GetBoundingBox()
                    BoundingBox = BoundingBox_3
                end
                local v3 = false
                local Pivot = a1:GetPivot()
                for j = 1, 120 do
                    task.wait(0.1)
                    v2 = a1
                    v1 = false
                    if v2.Parent ~= nil then
                        v1 = false
                        if v2:GetAttribute("TurretActive") == true then
                            v1 = v2:GetAttribute("WorldUpgradeMoving") ~= true
                        end
                    end
                    if not v1 then
                        return
                    end
                    Pivot_2 = a1:GetPivot()
                    if not ((Pivot_2.Position - Pivot.Position).Magnitude < 0.01) then
                        v3 = false
                    else
                        if v3 then
                            break
                        end
                        v3 = true
                    end
                end
                if v3 then
                    local v4 = a1
                    local v5 = false
                    if v4.Parent ~= nil then
                        v5 = false
                        if v4:GetAttribute("TurretActive") == true then
                            v5 = v4:GetAttribute("WorldUpgradeMoving") ~= true
                        end
                    end
                    if v5 and not u20[a1] then
                        local v6, v7, v8, v9
                        v5 = nil
                        v4 = nil
                        for i2, v in ipairs(a1:GetDescendants()) do
                            if v:IsA("BasePart") and not v:IsDescendantOf(head) then
                                v6 = v.Size * 0.5
                                v7 = v.Position - v6
                                v8 = v.Position + v6
                                v5 = if not v5 then v7 else Vector3.new(math.min(v5.X, v7.X), math.min(v5.Y, v7.Y), (math.min(v5.Z, v7.Z)))
                                v4 = if not v4 then v8 else Vector3.new(math.max(v4.X, v8.X), math.max(v4.Y, v8.Y), (math.max(v4.Z, v8.Z)))
                            end
                        end
                        local BoundingBox_5 = a1:GetBoundingBox()
                        local Position = if not v5 then BoundingBox_5.Position else if not v4 then BoundingBox_5.Position else (v5 + v4) * 0.5
                        v2 = if not Gun then nil else if not Gun:IsA("Model") then nil else Gun
                        local BoundingBox_6 = if not v2 then nil else v2:GetBoundingBox()
                        local v10 = Vector3.new(Position.X, BoundingBox.Position.Y, Position.Z)
                        v6 = Vector3.new((if not BoundingBox_6 then Vector3.new(0, 0, 0) else BoundingBox_6.Position - v10).X, 0, v6.Z)
                        if v6.Magnitude <= 0.001 then
                            v6 = BoundingBox.RightVector * -1
                            v6 = Vector3.new(v6.X, 0, v6.Z)
                        end
                        local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, 1) else v6.Unit
                        v7 = {}
                        v8 = {}
                        for i3, k in ipairs(head:GetDescendants()) do
                            if k:IsA("BasePart") then
                                v9 = {Part = k, Rest = k.CFrame}
                                if not v2 or not k:IsDescendantOf(v2) then
                                    table.insert(v7, v9)
                                else
                                    table.insert(v8, v9)
                                end
                            end
                        end
                        u20[a1] = {
                            Yaw = 0,
                            Pitch = 0,
                            SpinAngle = 0,
                            SpinSpeed = 0,
                            Head = head,
                            Gun = v2,
                            TargetValue = TurretTarget,
                            HeadParts = v7,
                            GunParts = v8,
                            Forward0 = Unit,
                            RotationPoint = v10,
                            GunCentre0 = if not BoundingBox_6 then nil else BoundingBox_6.Position,
                            GunAxis0 = if not v2 then nil else barrelAxis(v2),
                            Origin0 = a1:GetPivot().Position,
                        }
                        return
                    end
                end
                return
            end
        end)
        return
    end
end

;(CollectionService:GetInstanceAddedSignal("FishTurret")):Connect(watchTurret)
;(CollectionService:GetInstanceRemovedSignal("FishTurret")):Connect(function(a1) -- Line: 248 -- upvalues: u20 (val), u21 (val)
    if not a1:IsA("Model") then
        return
    end
    u20[a1] = nil
    local v1 = u21[a1]
    if v1 then
        for i, v in ipairs(v1) do
            v:Disconnect()
        end
        u21[a1] = nil
    end
end)
for i, v in ipairs(CollectionService:GetTagged("FishTurret")) do
    watchTurret(v)
end
task.spawn(function() -- Line: 259 -- upvalues: u20 (val), barrelAxis (val)
    local v1
    while true do
        task.wait(1)
        for k, v in pairs(u20) do
            v1 = false
            if k.Parent ~= nil then
                v1 = false
                if k:GetAttribute("TurretActive") == true then
                    v1 = k:GetAttribute("WorldUpgradeMoving") ~= true
                end
            end
            if not v1 then
                u20[k] = nil
            elseif 1 < (k:GetPivot().Position - v.Origin0).Magnitude then
                u20[k] = nil
                if not u20[k] then
                    v1 = false
                    if k.Parent ~= nil then
                        v1 = false
                        if k:GetAttribute("TurretActive") == true then
                            v1 = k:GetAttribute("WorldUpgradeMoving") ~= true
                        end
                    end
                    if v1 then
                        task.spawn(function() -- Line: 129 -- upvalues: k (val), u20 (upval), barrelAxis (upval)
                            local head = k:WaitForChild("head", 10)
                            local TurretTarget = k:WaitForChild("TurretTarget", 10)
                            if head and head:IsA("Model") and TurretTarget and TurretTarget:IsA("ObjectValue") then
                                local BoundingBox_3, BoundingBox_4, Pivot_2, v1, v2
                                local Gun = head:FindFirstChild("Gun")
                                local BoundingBox, BoundingBox_2 = head:GetBoundingBox()
                                for i = 1, 50 do
                                    if 0.5 < BoundingBox_2.Magnitude then
                                        break
                                    end
                                    task.wait(0.1)
                                    BoundingBox_3, BoundingBox_4 = head:GetBoundingBox()
                                    BoundingBox = BoundingBox_3
                                end
                                local v3 = false
                                local Pivot = k:GetPivot()
                                for j = 1, 120 do
                                    task.wait(0.1)
                                    v2 = k
                                    v1 = false
                                    if v2.Parent ~= nil then
                                        v1 = false
                                        if v2:GetAttribute("TurretActive") == true then
                                            v1 = v2:GetAttribute("WorldUpgradeMoving") ~= true
                                        end
                                    end
                                    if not v1 then
                                        return
                                    end
                                    Pivot_2 = k:GetPivot()
                                    if not ((Pivot_2.Position - Pivot.Position).Magnitude < 0.01) then
                                        v3 = false
                                    else
                                        if v3 then
                                            break
                                        end
                                        v3 = true
                                    end
                                end
                                if v3 then
                                    local v4 = k
                                    local v5 = false
                                    if v4.Parent ~= nil then
                                        v5 = false
                                        if v4:GetAttribute("TurretActive") == true then
                                            v5 = v4:GetAttribute("WorldUpgradeMoving") ~= true
                                        end
                                    end
                                    if v5 and not u20[k] then
                                        local v6, v7, v8, v9
                                        v5 = nil
                                        v4 = nil
                                        for i2, v in ipairs(k:GetDescendants()) do
                                            if v:IsA("BasePart") and not v:IsDescendantOf(head) then
                                                v6 = v.Size * 0.5
                                                v7 = v.Position - v6
                                                v8 = v.Position + v6
                                                v5 = if not v5 then v7 else Vector3.new(math.min(v5.X, v7.X), math.min(v5.Y, v7.Y), (math.min(v5.Z, v7.Z)))
                                                v4 = if not v4 then v8 else Vector3.new(math.max(v4.X, v8.X), math.max(v4.Y, v8.Y), (math.max(v4.Z, v8.Z)))
                                            end
                                        end
                                        local BoundingBox_5 = k:GetBoundingBox()
                                        local Position = if not v5 then BoundingBox_5.Position else if not v4 then BoundingBox_5.Position else (v5 + v4) * 0.5
                                        v2 = if not Gun then nil else if not Gun:IsA("Model") then nil else Gun
                                        local BoundingBox_6 = if not v2 then nil else v2:GetBoundingBox()
                                        local v10 = Vector3.new(Position.X, BoundingBox.Position.Y, Position.Z)
                                        v6 = Vector3.new(
                                            (if not BoundingBox_6 then Vector3.new(0, 0, 0) else BoundingBox_6.Position - v10).X,
                                            0,
                                            v6.Z
                                        )
                                        if v6.Magnitude <= 0.001 then
                                            v6 = BoundingBox.RightVector * -1
                                            v6 = Vector3.new(v6.X, 0, v6.Z)
                                        end
                                        local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(0, 0, 1) else v6.Unit
                                        v7 = {}
                                        v8 = {}
                                        for i3, k2 in ipairs(head:GetDescendants()) do
                                            if k2:IsA("BasePart") then
                                                v9 = {Part = k2, Rest = k2.CFrame}
                                                if not v2 or not k2:IsDescendantOf(v2) then
                                                    table.insert(v7, v9)
                                                else
                                                    table.insert(v8, v9)
                                                end
                                            end
                                        end
                                        u20[k] = {
                                            Yaw = 0,
                                            Pitch = 0,
                                            SpinAngle = 0,
                                            SpinSpeed = 0,
                                            Head = head,
                                            Gun = v2,
                                            TargetValue = TurretTarget,
                                            HeadParts = v7,
                                            GunParts = v8,
                                            Forward0 = Unit,
                                            RotationPoint = v10,
                                            GunCentre0 = if not BoundingBox_6 then nil else BoundingBox_6.Position,
                                            GunAxis0 = if not v2 then nil else barrelAxis(v2),
                                            Origin0 = k:GetPivot().Position,
                                        }
                                        return
                                    end
                                end
                                return
                            end
                        end)
                    end
                end
            end
        end
    end
end)

local function shortestAngle(a1) -- Line: 273 -- types: a1: number
    return (a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
end

RunService.RenderStepped:Connect(function(a1) -- Line: 277 -- upvalues: u20 (val)
    local RotationPoint, SpinSpeed, Unit, Value, Yaw, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local v13 = 1 - math.exp(-a1 * 12)
    for k, v in pairs(u20) do
        v11 = false
        if k.Parent ~= nil then
            v11 = false
            if k:GetAttribute("TurretActive") == true then
                v11 = k:GetAttribute("WorldUpgradeMoving") ~= true
            end
        end
        if not v11 then
            u20[k] = nil
        elseif v.Head.Parent ~= nil then
            Value = v.TargetValue.Value
            v12 = false
            Yaw = v.Yaw
            v1 = 0
            if Value and Value.Parent and Value:IsA("Model") then
                v2 = Value:GetPivot().Position - v.RotationPoint
                v3 = Vector3.new(v2.X, 0, v2.Z)
                if 0.25 < v3.Magnitude then
                    Unit = v3.Unit
                    Yaw = math.atan2((v.Forward0:Cross(Unit)).Y, (v.Forward0:Dot(Unit)))
                    v1 = math.clamp(math.atan2(v2.Y, (Vector3.new(v2.X, 0, v2.Z)).Magnitude), -0.6, 0.6)
                    v12 = true
                end
            end
            v.Yaw = v.Yaw + ((Yaw - v.Yaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v13
            v.Pitch = v.Pitch + (v1 - v.Pitch) * v13
            SpinSpeed = v.SpinSpeed
            v5 = (if not v12 then 0 else 14) - v.SpinSpeed
            v7 = v14 * 3
            v.SpinSpeed = SpinSpeed + v5 * math.min(v7, 1)
            v.SpinAngle = (v.SpinAngle + v.SpinSpeed * v14) % 6.283185307179586
            RotationPoint = v.RotationPoint
            v4 = CFrame.Angles(0, v.Yaw, 0)
            v6 = v4:VectorToWorldSpace(v.Forward0):Cross((Vector3.new(0, 1, 0)))
            v7 = if not (0.001 < v6.Magnitude) then CFrame.new(RotationPoint) * v4 * CFrame.new(-RotationPoint) else (CFrame.new(RotationPoint)) * CFrame.fromAxisAngle(v6.Unit, v.Pitch) * v4 * CFrame.new(-RotationPoint)
            for i, i2 in ipairs(v.HeadParts) do
                if i2.Part.Parent then
                    i2.Part.CFrame = v7 * i2.Rest
                end
            end
            if v.Gun and v.Gun.Parent and v.GunCentre0 and v.GunAxis0 then
                v8 = v7 * v.GunCentre0
                v9 = v7.Rotation * v.GunAxis0
                v10 = (CFrame.new(v8)) * CFrame.fromAxisAngle(v9, v.SpinAngle) * CFrame.new(-v8)
                for i3, j in ipairs(v.GunParts) do
                    if j.Part.Parent then
                        j.Part.CFrame = v10 * v7 * j.Rest
                    end
                end
            end
        else
            u20[k] = nil
        end
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.TravelingMerchantClient
-- Took 0.03s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.TravelingMerchantClient
-- Decompile time: 33.00 ms

local Robux
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FishGame = ReplicatedStorage:WaitForChild("FishGame")
local Config = require(FishGame:WaitForChild("Config"))
local Remotes = FishGame:WaitForChild("Remotes")
local TravelingMerchantAction = Remotes:WaitForChild("TravelingMerchantAction")
local StateUpdate = Remotes:WaitForChild("StateUpdate")
local TravelingMerchantShop = PlayerGui:WaitForChild("TravelingMerchantShop")
local Frame = TravelingMerchantShop:WaitForChild("Frame")
local CloseButton = Frame:WaitForChild("A_Header"):WaitForChild("CloseButton")
local ScrollingFrame = (Frame:WaitForChild("Body")):WaitForChild("ScrollingFrame")
local Amount = ((Frame:WaitForChild("SellAndMoney")):WaitForChild("Cash")):WaitForChild("Amount")
local u108 = {}
u108.Health = ScrollingFrame:WaitForChild("HealthUpgrade")
u108.Dodge = ScrollingFrame:WaitForChild("DodgeUpgrade")
local RegenUpgrade = ScrollingFrame:FindFirstChild("RegenUpgrade")
if RegenUpgrade and RegenUpgrade:IsA("GuiObject") then
    RegenUpgrade.Visible = false
end
local SeedTemplate = ScrollingFrame:FindFirstChild("SeedTemplate")
if SeedTemplate and SeedTemplate:IsA("GuiObject") then
    SeedTemplate.Visible = false
end
TravelingMerchantShop.Enabled = false
local TravelingMerchantBlur = Lighting:FindFirstChild("TravelingMerchantBlur")
if not TravelingMerchantBlur or not TravelingMerchantBlur:IsA("BlurEffect") then
    if TravelingMerchantBlur then
        TravelingMerchantBlur:Destroy()
    end
    TravelingMerchantBlur = Instance.new("BlurEffect")
    TravelingMerchantBlur.Name = "TravelingMerchantBlur"
    TravelingMerchantBlur.Size = 0
    TravelingMerchantBlur.Enabled = false
    TravelingMerchantBlur.Parent = Lighting
end
local OpenScale = Frame:FindFirstChild("OpenScale")
if not OpenScale or not OpenScale:IsA("UIScale") then
    if OpenScale then
        OpenScale:Destroy()
    end
    OpenScale = Instance.new("UIScale")
    OpenScale.Name = "OpenScale"
    OpenScale.Parent = Frame
end

local function makeSound(a1, a2, a3) -- Line: 57
    -- upvalues: SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.Name = a1
    Sound.SoundId = a2
    Sound.Volume = a3
    Sound.Parent = SoundService
    return Sound
end

local OpenCloseSoundId = Config.InterfaceSounds.OpenCloseSoundId
local u208 = Instance.new("Sound")
u208.Name = "TravelingMerchantOpen"
u208.SoundId = OpenCloseSoundId
u208.Volume = 0.55
u208.Parent = SoundService
local OpenCloseSoundId_2 = Config.InterfaceSounds.OpenCloseSoundId
local u216 = Instance.new("Sound")
u216.Name = "TravelingMerchantClose"
u216.SoundId = OpenCloseSoundId_2
u216.Volume = 0.55
u216.Parent = SoundService
local BuySoundId = Config.InterfaceSounds.BuySoundId
local u224 = Instance.new("Sound")
u224.Name = "TravelingMerchantBuy"
u224.SoundId = BuySoundId
u224.Volume = 0.72
u224.Parent = SoundService
local Position = Frame.Position
local u229 = 70
local u230 = false
local u231 = false
local u232 = false
local u233 = false
local CameraMode = LocalPlayer.CameraMode
local Custom = Enum.CameraType.Custom
local MouseBehavior = UserInputService.MouseBehavior
local MouseIconEnabled = UserInputService.MouseIconEnabled
local u254 = nil
local u255 = nil
local u260 = "TravelingMerchantCamera_" .. tostring(LocalPlayer.UserId)

local function beginModalInput(a1) -- Line: 83
    -- upvalues: PlayerGui (val), CameraMode (ref), LocalPlayer (val), MouseBehavior (ref), UserInputService (val)
    -- upvalues: MouseIconEnabled (ref), Custom (ref), u254 (ref), u255 (ref), RunService (val), u260 (val), u230 (ref)
    -- upvalues: Workspace (val)
    local MedalTVUI = PlayerGui:FindFirstChild("MedalTVUI")
    if MedalTVUI and MedalTVUI:IsA("ScreenGui") then
        MedalTVUI.Enabled = false
    end
    CameraMode = LocalPlayer.CameraMode
    MouseBehavior = UserInputService.MouseBehavior
    MouseIconEnabled = UserInputService.MouseIconEnabled
    if a1 then
        Custom = a1.CameraType
        u254 = a1.CFrame
        u255 = a1.Focus
        a1.CameraType = Enum.CameraType.Scriptable
    end
    LocalPlayer:SetAttribute("FishResearchOpen", true)
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseIconEnabled = true
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    RunService:UnbindFromRenderStep(u260)
    RunService:BindToRenderStep(u260, Enum.RenderPriority.Camera.Value + 10, function() -- Line: 100
        -- upvalues: u230 (upval), Workspace (upval), u254 (upval), u255 (upval), UserInputService (upval)
        if not u230 then
            return
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera and u254 then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.CFrame = u254
            if u255 then
                CurrentCamera.Focus = u255
            end
        end
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end)
end

local function endModalInput() -- Line: 113
    -- upvalues: RunService (val), u260 (val), Workspace (val), Custom (ref), LocalPlayer (val), CameraMode (ref)
    -- upvalues: UserInputService (val), MouseIconEnabled (ref), MouseBehavior (ref), u254 (ref), u255 (ref)
    RunService:UnbindFromRenderStep(u260)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CameraType = Custom
    end
    LocalPlayer.CameraMode = CameraMode
    UserInputService.MouseIconEnabled = MouseIconEnabled
    UserInputService.MouseBehavior = MouseBehavior
    LocalPlayer:SetAttribute("FishResearchOpen", false)
    u254 = nil
    u255 = nil
end

local function commas(a1) -- Line: 125 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.max(0, (math.floor(a1)))))
    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function purchaseButton(a1) -- Line: 134 -- types: a1: userdata
    return (a1:WaitForChild("Purchase"))
end

local function purchaseLabel(a1) -- Line: 138 -- types: a1: userdata
    local TextLabel = (a1:WaitForChild("Purchase")):FindFirstChild("TextLabel")
    if TextLabel and TextLabel:IsA("TextLabel") then
        return TextLabel
    end
    return nil
end

local function formatValue(a1, a2) -- Line: 143 -- types: a1: string, a2: number
    if a1 == "Health" then
        return (tostring((math.floor(a2 + 0.5)))) .. " HP"
    end
    return (tostring((math.floor(a2 * 100 + 0.5)))) .. "%"
end

local function applyState(a1) -- Line: 150 -- upvalues: Amount (val), commas (val), u108 (val)
    local AmountText, CurrentValue, NextValue, Purchase, TextLabel, Values, v1, v2, v3, v4, v5, v6
    if type(a1) ~= "table" then
        return
    end
    Amount.Text = "$" .. commas(tonumber(a1.Cash) or 0)
    if type(a1.Entries) ~= "table" then
        return
    end
    for k, v in pairs(u108) do
        v3 = a1.Entries[k]
        if type(v3) == "table" then
            v4 = math.max(0, (math.floor((tonumber(v3.Level)) or 0)))
            v5 = math.max(1, (math.floor((tonumber(v3.MaxLevel)) or 1)))
            v6 = v5 <= v4
            AmountText = v:FindFirstChild("AmountText")
            Values = v:FindFirstChild("Values")
            CurrentValue = Values and Values:FindFirstChild("CurrentValue")
            NextValue = Values and Values:FindFirstChild("NextValue")
            if AmountText and AmountText:IsA("TextLabel") then
                AmountText.Text = string.format("LEVEL %d / %d", v4, v5)
            end
            if CurrentValue and CurrentValue:IsA("TextLabel") then
                v2 = tonumber(v3.CurrentValue) or 0
                v1 = if k ~= "Health" then (tostring((math.floor(v2 * 100 + 0.5)))) .. "%" else (tostring((math.floor(v2 + 0.5)))) .. " HP"
                CurrentValue.Text = v1
            end
            if NextValue and NextValue:IsA("TextLabel") then
                if not v6 then
                    v2 = tonumber(v3.NextValue) or 0
                    v1 = if k ~= "Health" then (tostring((math.floor(v2 * 100 + 0.5)))) .. "%" else (tostring((math.floor(v2 + 0.5)))) .. " HP"
                else
                    v1 = "MAX"
                end
                NextValue.Text = v1
            end
            Purchase = v:WaitForChild("Purchase")
            Purchase.Active = not v6
            Purchase.AutoButtonColor = not v6
            TextLabel = (v:WaitForChild("Purchase")):FindFirstChild("TextLabel")
            v2 = if not TextLabel then nil else if not TextLabel:IsA("TextLabel") then nil else TextLabel
            if v2 then
                v2.Text = if not v6 then "$" .. commas(tonumber(v3.Cost) or 0) else "MAX"
            end
        end
    end
end

local function invoke(a1, a2) -- Line: 182 -- upvalues: TravelingMerchantAction (val) -- types: a1: string, a2: string?
    local success, result = pcall(function() -- Line: 183 -- upvalues: TravelingMerchantAction (upval), a1 (val), a2 (val)
        return TravelingMerchantAction:InvokeServer(a1, a2)
    end)
    if success then
        return result
    end
    return nil
end

local function closeUI(a1) -- Line: 189
    -- upvalues: u232 (ref), u230 (ref), TravelingMerchantShop (val), u231 (ref), invoke (val), RunService (val)
    -- upvalues: u260 (val), Workspace (val), Custom (ref), LocalPlayer (val), CameraMode (ref), UserInputService (val)
    -- upvalues: MouseIconEnabled (ref), MouseBehavior (ref), u254 (ref), u255 (ref), u216 (val), TweenService (val)
    -- upvalues: OpenScale (ref), Frame (val), Position (val), TravelingMerchantBlur (ref), u229 (ref), GuiService (val)
    if a1 then
        u232 = true
    end
    if not u230 then
        TravelingMerchantShop.Enabled = false
        return
    end
    u230 = false
    u231 = false
    task.spawn(invoke, "Close")
    RunService:UnbindFromRenderStep(u260)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CameraType = Custom
    end
    LocalPlayer.CameraMode = CameraMode
    UserInputService.MouseIconEnabled = MouseIconEnabled
    UserInputService.MouseBehavior = MouseBehavior
    LocalPlayer:SetAttribute("FishResearchOpen", false)
    u254 = nil
    u255 = nil
    u216:Play()
    local CurrentCamera_2 = Workspace.CurrentCamera
    TweenService:Create(OpenScale, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.84}):Play()
    TweenService:Create(
        Frame,
        TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = Position + UDim2.fromOffset(0, 18)}
    ):Play()
    TweenService:Create(TravelingMerchantBlur, TweenInfo.new(0.18), {Size = 0}):Play()
    if CurrentCamera_2 then
        TweenService:Create(CurrentCamera_2, TweenInfo.new(0.22), {FieldOfView = u229}):Play()
    end
    task.delay(0.18, function() -- Line: 204
        -- upvalues: u230 (upval), TravelingMerchantShop (upval), TravelingMerchantBlur (upval), Frame (upval)
        -- upvalues: Position (upval), OpenScale (upval), GuiService (upval)
        if u230 then
            return
        end
        TravelingMerchantShop.Enabled = false
        TravelingMerchantBlur.Enabled = false
        Frame.Position = Position
        OpenScale.Scale = 1
        GuiService.SelectedObject = nil
    end)
end

local function openUI() -- Line: 214
    -- upvalues: u230 (ref), Workspace (val), u229 (ref), beginModalInput (val), TravelingMerchantShop (val)
    -- upvalues: Frame (val), Position (val), OpenScale (ref), TravelingMerchantBlur (ref), u208 (val)
    -- upvalues: TweenService (val), GuiService (val), u108 (val), TravelingMerchantAction (val), applyState (val)
    if u230 then
        return
    end
    u230 = true
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        u229 = CurrentCamera.FieldOfView
    end
    beginModalInput(CurrentCamera)
    TravelingMerchantShop.Enabled = true
    Frame.Visible = true
    Frame.Position = Position + UDim2.fromOffset(0, 22)
    OpenScale.Scale = 0.78
    TravelingMerchantBlur.Enabled = true
    TravelingMerchantBlur.Size = 0
    u208:Play()
    TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = Position}):Play()
    TweenService:Create(OpenScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    TweenService:Create(TravelingMerchantBlur, TweenInfo.new(0.22), {Size = 12}):Play()
    if CurrentCamera then
        TweenService:Create(CurrentCamera, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {FieldOfView = u229 + 6}):Play()
    end
    if GuiService:IsTenFootInterface() then
        GuiService.SelectedObject = u108.Health:WaitForChild("Purchase")
    end
    task.spawn(function() -- Line: 232 -- upvalues: TravelingMerchantAction (upval), u230 (upval), applyState (upval)
        local u1 = "Open"
        local u2 = nil
        local success, result = pcall(function() -- Line: 183 -- upvalues: TravelingMerchantAction (upval), u1 (val), u2 (val)
            return TravelingMerchantAction:InvokeServer(u1, u2)
        end)
        local v1 = if not success then nil else result
        if u230 then
            applyState(v1)
        end
    end)
end

local function buy(a1) -- Line: 238
    -- upvalues: u231 (ref), u230 (ref), u108 (val), TweenService (val), TravelingMerchantAction (val), applyState (val)
    -- upvalues: u224 (val)
    if not u231 and u230 then
        local v1
        local v2 = u108[a1]
        if not v2 then
            return
        end
        local Purchase = v2:WaitForChild("Purchase")
        if not Purchase.Active then
            return
        end
        u231 = true
        local Size = Purchase.Size
        TweenService:Create(Purchase, TweenInfo.new(0.07, Enum.EasingStyle.Quad), {Size = Size - UDim2.fromOffset(5, 3)}):Play()
        task.delay(0.08, function() -- Line: 249 -- upvalues: Purchase (val), TweenService (upval), Size (val)
            if Purchase.Parent then
                TweenService:Create(Purchase, TweenInfo.new(0.14, Enum.EasingStyle.Back), {Size = Size}):Play()
            end
        end)
        local u35 = "Buy"
        local success, result = pcall(function() -- Line: 183 -- upvalues: TravelingMerchantAction (upval), u35 (val), a1 (val)
            return TravelingMerchantAction:InvokeServer(u35, a1)
        end)
        u231 = false
        if type(if not success then nil else result) ~= "table" then
            return
        end
        applyState(v1.State)
        if v1.Success == true then
            u224:Play()
        end
        return
    end
end

for k, v in pairs(u108) do
    (v:WaitForChild("Purchase")).Activated:Connect(function() -- Line: 262 -- upvalues: buy (val), k (val)
        buy(k)
    end)
    Robux = v:FindFirstChild("Robux")
    if Robux and Robux:IsA("GuiObject") then
        Robux.Visible = false
    end
end
CloseButton.Activated:Connect(function() -- Line: 266 -- upvalues: closeUI (val)
    closeUI(true)
end)
;(TravelingMerchantShop:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 267 -- upvalues: TravelingMerchantShop (val), u230 (ref), closeUI (val)
    if not TravelingMerchantShop.Enabled and u230 then
        closeUI(true)
    end
end)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 270 -- upvalues: u230 (ref), closeUI (val)
    if not a2 and u230 then
        if a1.KeyCode == Enum.KeyCode.Escape or a1.KeyCode == Enum.KeyCode.E then
            closeUI(true)
        end
    end
end)
StateUpdate.OnClientEvent:Connect(function(a1) -- Line: 276 -- upvalues: u230 (ref), Amount (val), commas (val)
    if u230 and type(a1) == "table" and a1.TeamCash ~= nil then
        Amount.Text = "$" .. commas(tonumber(a1.TeamCash) or 0)
    end
end)

local function rootPart() -- Line: 282 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function zoneTouch() -- Line: 288 -- upvalues: Workspace (val)
    local FishWorldEvents = Workspace:FindFirstChild("FishWorldEvents")
    local TravelingMerchant = FishWorldEvents and FishWorldEvents:FindFirstChild("TravelingMerchant")
    local Touch = TravelingMerchant and TravelingMerchant:FindFirstChild("Touch", true)
    if Touch and Touch:IsA("BasePart") then
        return Touch
    end
    return nil
end

local function insideZone() -- Line: 295 -- upvalues: LocalPlayer (val), Workspace (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v1 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    local FishWorldEvents = Workspace:FindFirstChild("FishWorldEvents")
    local TravelingMerchant = FishWorldEvents and FishWorldEvents:FindFirstChild("TravelingMerchant")
    local Touch = TravelingMerchant and TravelingMerchant:FindFirstChild("Touch", true)
    local v2 = if not Touch then nil else if not Touch:IsA("BasePart") then nil else Touch
    if v1 and v2 then
        local v3 = v2.CFrame:PointToObjectSpace(v1.Position)
        local v4 = v2.Size * 0.5
        local v5 = false
        if (math.abs(v3.X)) <= v4.X then
            v5 = false
            if (math.abs(v3.Z)) <= v4.Z then
                v5 = (math.abs(v3.Y)) <= math.max(v4.Y + 6, 7)
            end
        end
        return v5
    end
    return false
end

local u395 = 0
RunService.Heartbeat:Connect(function(a1) -- Line: 307
    -- upvalues: u395 (ref), insideZone (val), u233 (ref), u232 (ref), openUI (val), closeUI (val), u230 (ref)
    -- upvalues: Workspace (val)
    local FishWorldEvents, Touch, TravelingMerchant
    u395 = u395 + a1
    if u395 < 0.1 then
        return
    end
    u395 = 0
    local v1 = insideZone()
    if v1 and not u233 and not u232 then
        openUI()
    end
    if v1 then
        if u230 then
            FishWorldEvents = Workspace:FindFirstChild("FishWorldEvents")
            TravelingMerchant = FishWorldEvents and FishWorldEvents:FindFirstChild("TravelingMerchant")
            Touch = TravelingMerchant and TravelingMerchant:FindFirstChild("Touch", true)
            if not (if not Touch then nil else if not Touch:IsA("BasePart") then nil else Touch) then
                closeUI(false)
            end
        end
    elseif u233 then
        u232 = false
        closeUI(false)
    elseif u230 then
        FishWorldEvents = Workspace:FindFirstChild("FishWorldEvents")
        TravelingMerchant = FishWorldEvents and FishWorldEvents:FindFirstChild("TravelingMerchant")
        Touch = TravelingMerchant and TravelingMerchant:FindFirstChild("Touch", true)
        if not (if not Touch then nil else if not Touch:IsA("BasePart") then nil else Touch) then
            closeUI(false)
        end
    end
    u233 = v1
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.SkyboxRotater
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.SkyboxRotater
-- Decompile time: 0.96 ms

local Lighting = game:GetService("Lighting")
;(game:GetService("RunService")).Heartbeat:Connect(function(a1) -- Line: 10 -- upvalues: Lighting (val) -- types: a1: number
    local Sky = Lighting:FindFirstChildOfClass("Sky")
    if not Sky then
        return
    end
    Sky.SkyboxOrientation = Sky.SkyboxOrientation + Vector3.new(0, a1 * 0.5, 0)
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.ScaleCounterClient
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.ScaleCounterClient
-- Decompile time: 2.62 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScaleCounter = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScaleCounter")
local Amount = ScaleCounter:WaitForChild("ScaleCounter"):WaitForChild("Cash"):WaitForChild("Amount")
local StateUpdate = ((ReplicatedStorage:WaitForChild("FishGame")):WaitForChild("Remotes")):WaitForChild("StateUpdate")

local function commas(a1) -- Line: 16 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.max(0, (math.floor(a1)))))
    repeat
        v1, v2 = v3:gsub("^(%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function refresh(a1) -- Line: 25 -- upvalues: Amount (val), commas (val), ScaleCounter (val) -- types: a1: number?
    local v1 = math.max(0, (math.floor((tonumber(a1)) or 0)))
    Amount.Text = commas(v1)
    ScaleCounter.Enabled = v1 > 0
end

ScaleCounter.Enabled = false
StateUpdate.OnClientEvent:Connect(function(a1, a2) -- Line: 32 -- upvalues: Amount (val), commas (val), ScaleCounter (val)
    if type(a2) ~= "table" then
        return
    end
    local v1 = math.max(0, (math.floor((tonumber((tonumber(a2.ProjectedScaleReward)))) or 0)))
    Amount.Text = commas(v1)
    ScaleCounter.Enabled = v1 > 0
end)
