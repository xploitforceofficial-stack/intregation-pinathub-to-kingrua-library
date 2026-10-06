
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

-- ── Initial Tab Focus ────────────────────────────────────────────────────────────────
if Window and Window.SelectTab then
    pcall(function()
        Window:SelectTab(1)
    end)
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

local __ok, __err = pcall(__PinatHub_AnimeBlade_Init__)
if not __ok then
    warn("[PinatHub Fatal Error]:", __err)
    if rconsoleprint then
        pcall(rconsoleprint, "@@RED@@
[PinatHub Fatal Error]: " .. tostring(__err) .. "
")
    end
    if PinatHubAdapter and PinatHubAdapter.Notify then
        pcall(function()
            PinatHubAdapter:Notify({
                Title = "PinatHub Error",
                Content = tostring(__err):sub(1, 120),
                Type = "Danger",
                Duration = 8
            })
        end)
    end
end
