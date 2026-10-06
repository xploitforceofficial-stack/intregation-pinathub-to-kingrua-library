# test_anewgame_execution.py
import re

with open("anewgame_pinathub.lua", "r", encoding="utf-8") as f:
    code = f.read()

# Verify adapter block exists
assert "Window.CreateTab = Window.AddTab" in code, "Adapter Window.CreateTab missing"
assert "wrapTab" in code, "wrapTab missing"
assert "wrapSection" in code, "wrapSection missing"
assert "SubNavObj" in code or "origSubNav" in code, "SubNav adapter missing"

# Check all 12 tabs are created
expected_tabs = [
    "TabTrain", "TabCombat", "TabStage", "TabDungeon",
    "TabBoss", "TabForge", "TabClass", "TabEconomy",
    "TabMove", "TabESP", "TabGfx", "TabSettings"
]

for tab in expected_tabs:
    assert f"local {tab} = Window and Window:CreateTab" in code, f"Tab {tab} missing!"

print("All 12 tabs found!")

# Check all subnavs are present
expected_subnavs = [
    "NavTrain_Auto", "NavTrain_Zones", "NavTrain_Rebirth",
    "NavCombat_Farm", "NavCombat_Filter", "NavCombat_Skills",
    "NavStage_Farm", "NavStage_Ore", "NavStage_Super", "NavStage_Sell",
    "NavDungeon_Auto", "NavDungeon_Actions",
    "NavBoss_Auto", "NavBoss_Rewards", "NavBoss_Balls",
    "NavForge_Weapon", "NavForge_Armor", "NavForge_Enchant",
    "NavClass_Roll", "NavClass_Upgrades", "NavClass_Potions",
    "NavEco_Gifts", "NavEco_Codes",
    "NavMove_Mods", "NavMove_TP",
    "NavESP_Enemy", "NavESP_Objects",
    "NavGfx_Graphs", "NavGfx_Opt",
    "NavSet_Profiles", "NavSet_Misc"
]

for nav in expected_subnavs:
    assert re.search(rf"{nav}\s*=", code), f"Subnav {nav} assignment missing!"
    assert f"if {nav} then" in code, f"Subnav check 'if {nav} then' missing!"

print(f"All {len(expected_subnavs)} subnav containers found and properly checked!")

# Check initial tab selection
assert "Window:SelectTab(1)" in code, "Window:SelectTab(1) missing!"
print("Window:SelectTab(1) present!")

print("ALL STATIC STRUCTURAL CHECKS PASSED!")
