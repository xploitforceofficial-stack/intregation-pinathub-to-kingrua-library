import os

code_parts = []

code_parts.append('''
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
    Icon = "backpack",
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
    Icon = "trophy",
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
    Icon = "coins",
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
''')

with open("scratch/expanded_part3.lua", "w", encoding="utf-8") as f:
    f.write("".join(code_parts))
print("Part 3 ready")
