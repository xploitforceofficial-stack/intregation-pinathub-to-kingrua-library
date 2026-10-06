import os

code_parts = []

code_parts.append('''
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

    UI_Controls.AutoAdvanceStage = SecFarm:AddToggle({
        Name     = "Auto Advance to Next Stage (No Walk)",
        Default  = true,
        Flag     = "AutoAdvanceStage",
        Callback = function(val)
            PH.AutoAdvanceStage = val
            PH.AutoProgressStage = val
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
    for i = 0, 27 do table.insert(StageList, "Stage_" .. i) end

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
        Name     = "Auto Advance to Next Stage (No Walk)",
        Default  = false,
        Flag     = "AutoProgressStage",
        Callback = function(val)
            PH.AutoProgressStage = val
            PH.AutoAdvanceStage = val
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
        Name     = "Auto Collect Dropped Ores (Ruby, Silver, etc.)",
        Default  = false,
        Flag     = "AutoCollectOre",
        Callback = function(val)
            PH.AutoCollectOre = val
        end
    })

    UI_Controls.AutoOreMagnet = SecOre:AddToggle({
        Name     = "Auto Ore Magnet (Pull Drops To Player)",
        Default  = true,
        Flag     = "AutoOreMagnet",
        Callback = function(val)
            PH.AutoOreMagnet = val
        end
    })

    UI_Controls.AutoClaimAllOre = SecOre:AddToggle({
        Name     = "Auto Claim All Ores (Server Level)",
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
        Name     = "Claim & Collect All Ores Now",
        Callback = function()
            if ClaimedAllOreRE then
                ClaimedAllOreRE:FireServer()
            end
            for _, desc in ipairs(Workspace:GetDescendants()) do
                if desc:IsA("ProximityPrompt") then
                    pcall(function()
                        if fireproximityprompt then
                            fireproximityprompt(desc, 0)
                        end
                    end)
                end
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
''')

with open("scratch/expanded_part2.lua", "w", encoding="utf-8") as f:
    f.write("".join(code_parts))
print("Part 2 ready")
