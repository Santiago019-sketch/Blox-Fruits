local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Blox Fruits Auto Farm",
    LoadingTitle = "Loading Script...",
    LoadingSubtitle = "by Anonymous",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxFruitsConfig",
        FileName = "BloxFruits"
    }
})

-- Main farming tab
local FarmTab = Window:CreateTab("Main Farm", 4483345998)

-- Additional farming tab
local ExtraFarmTab = Window:CreateTab("Extra Farm", 4483345998)

-- World specific tab
local WorldTab = Window:CreateTab("World", 4483345998)

-- Settings tab
local SettingsTab = Window:CreateTab("Settings", 4483345998)

-- Fighting Styles tab
local StylesTab = Window:CreateTab("Fighting Styles", 4483345998)

-- Stats tab
local StatsTab = Window:CreateTab("Stats", 4483345998)

-- Main farming toggle
FarmTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmLevel",
    Callback = function(Value)
        _G.AutoFarmLevelReal = Value
        Auto_Farm_Level = Value
        if Value == false then
            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end
})

-- Extra Farm Features
ExtraFarmTab:CreateToggle({
    Name = "Auto Farm Boss",
    CurrentValue = false,
    Flag = "AutoFarmBoss",
    Callback = function(Value)
        _G.Settings.Boss["Auto All Boss"] = Value
    end
})

ExtraFarmTab:CreateToggle({
    Name = "Auto Farm Fruit Mastery",
    CurrentValue = false,
    Flag = "AutoFruitMastery",
    Callback = function(Value)
        _G.Settings.Mastery["Auto Farm Fruit Mastery"] = Value
    end
})

ExtraFarmTab:CreateToggle({
    Name = "Auto Farm Gun Mastery",
    CurrentValue = false,
    Flag = "AutoGunMastery",
    Callback = function(Value)
        _G.Settings.Mastery["Auto Farm Gun Mastery"] = Value
    end
})

-- World Features
WorldTab:CreateToggle({
    Name = "Auto New World",
    CurrentValue = false,
    Flag = "AutoNewWorld",
    Callback = function(Value)
        _G.Settings.Main["Auto New World"] = Value
    end
})

WorldTab:CreateToggle({
    Name = "Auto Third Sea",
    CurrentValue = false,
    Flag = "AutoThirdSea",
    Callback = function(Value)
        _G.Settings.Main["Auto Third Sea"] = Value
    end
})

-- Fighting Styles
StylesTab:CreateToggle({
    Name = "Auto Superhuman",
    CurrentValue = false,
    Flag = "AutoSuperhuman",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Superhuman"] = Value
    end
})

StylesTab:CreateToggle({
    Name = "Auto Electric Claw",
    CurrentValue = false,
    Flag = "AutoElectricClaw",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Electric Claw"] = Value
    end
})

StylesTab:CreateToggle({
    Name = "Auto Death Step",
    CurrentValue = false,
    Flag = "AutoDeathStep",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Death Step"] = Value
    end
})

StylesTab:CreateToggle({
    Name = "Auto Dragon Talon",
    CurrentValue = false,
    Flag = "AutoDragonTalon",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Dragon Talon"] = Value
    end
})

StylesTab:CreateToggle({
    Name = "Auto God Human",
    CurrentValue = false,
    Flag = "AutoGodHuman",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto God Human"] = Value
    end
})

-- Stats Features
StatsTab:CreateToggle({
    Name = "Auto Stats",
    CurrentValue = false,
    Flag = "AutoStats",
    Callback = function(Value)
        _G.Settings.Stat["Enabled Auto Stats"] = Value
    end
})

StatsTab:CreateDropdown({
    Name = "Select Stats",
    Options = {"Melee", "Defense", "Sword", "Gun", "Devil Fruit"},
    CurrentOption = "Melee",
    Flag = "SelectedStats",
    Callback = function(Value)
        _G.Settings.Stat["Select Stats"] = Value
    end
})

StatsTab:CreateSlider({
    Name = "Points Per Stats",
    Range = {1, 9},
    Increment = 1,
    CurrentValue = 3,
    Flag = "PointsPerStat",
    Callback = function(Value)
        _G.Settings.Stat["Point Select"] = Value
    end
})

-- Settings
SettingsTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Fruit"},
    CurrentOption = "Melee",
    Flag = "SelectedWeapon",
    Callback = function(Value)
        SelectWeapon = Value
    end
})

SettingsTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = true,
    Flag = "FastAttack",
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
    end
})

SettingsTab:CreateDropdown({
    Name = "Fast Attack Type",
    Options = {"Fast", "Normal", "Slow"},
    CurrentOption = "Fast",
    Flag = "FastAttackType",
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack Type"] = Value
    end
})

SettingsTab:CreateToggle({
    Name = "Auto Haki",
    CurrentValue = true,
    Flag = "AutoHaki",
    Callback = function(Value)
        _G.Settings.Configs["Auto Haki"] = Value
    end
})

SettingsTab:CreateSlider({
    Name = "Distance Auto Farm",
    Range = {1, 50},
    Increment = 1,
    CurrentValue = 20,
    Flag = "AutoFarmDistance",
    Callback = function(Value)
        _G.Settings.Configs["Distance Auto Farm"] = Value
    end
})

-- Misc Settings
SettingsTab:CreateToggle({
    Name = "Bypass TP",
    CurrentValue = false,
    Flag = "BypassTP",
    Callback = function(Value)
        _G.Settings.Configs["Bypass TP"] = Value
    end
})

SettingsTab:CreateToggle({
    Name = "Auto Rejoin",
    CurrentValue = true,
    Flag = "AutoRejoin",
    Callback = function(Value)
        _G.Settings.Misc["Auto Rejoin"] = Value
    end
})
