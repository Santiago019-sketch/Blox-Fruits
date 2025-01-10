local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits Auto Farm", "Ocean")

-- Main farming tab
local FarmTab = Window:NewTab("Main Farm")
local FarmSection = FarmTab:NewSection("Farming")

-- Additional farming tab
local ExtraFarmTab = Window:NewTab("Extra Farm")
local ExtraFarmSection = ExtraFarmTab:NewSection("Extra Features")

-- World specific tab
local WorldTab = Window:NewTab("World")
local WorldSection = WorldTab:NewSection("World Features")

-- Settings tab
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Settings")

-- Fighting Styles tab
local StylesTab = Window:NewTab("Fighting Styles")
local StylesSection = StylesTab:NewSection("Fighting Styles")

-- Stats tab
local StatsTab = Window:NewTab("Stats")
local StatsSection = StatsTab:NewSection("Stats")

-- Main farming toggle
FarmSection:NewToggle("Auto Farm Level", "Toggles auto farming", function(Value)
    _G.AutoFarmLevelReal = Value
    Auto_Farm_Level = Value
    if Value == false then
        toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
    end
end)

-- Extra Farm Features
ExtraFarmSection:NewToggle("Auto Farm Boss", "Toggles boss farming", function(Value)
    _G.Settings.Boss["Auto All Boss"] = Value
end)

ExtraFarmSection:NewToggle("Auto Farm Fruit Mastery", "Toggles fruit mastery farming", function(Value)
    _G.Settings.Mastery["Auto Farm Fruit Mastery"] = Value
end)

ExtraFarmSection:NewToggle("Auto Farm Gun Mastery", "Toggles gun mastery farming", function(Value)
    _G.Settings.Mastery["Auto Farm Gun Mastery"] = Value
end)

-- World Features
WorldSection:NewToggle("Auto New World", "Automatically moves to new world", function(Value)
    _G.Settings.Main["Auto New World"] = Value
end)

WorldSection:NewToggle("Auto Third Sea", "Automatically moves to third sea", function(Value)
    _G.Settings.Main["Auto Third Sea"] = Value
end)

-- Fighting Styles
StylesSection:NewToggle("Auto Superhuman", "Toggles auto superhuman", function(Value)
    _G.Settings.FightingStyle["Auto Superhuman"] = Value
end)

StylesSection:NewToggle("Auto Electric Claw", "Toggles auto electric claw", function(Value)
    _G.Settings.FightingStyle["Auto Electric Claw"] = Value
end)

StylesSection:NewToggle("Auto Death Step", "Toggles auto death step", function(Value)
    _G.Settings.FightingStyle["Auto Death Step"] = Value
end)

StylesSection:NewToggle("Auto Dragon Talon", "Toggles auto dragon talon", function(Value)
    _G.Settings.FightingStyle["Auto Dragon Talon"] = Value
end)

StylesSection:NewToggle("Auto God Human", "Toggles auto god human", function(Value)
    _G.Settings.FightingStyle["Auto God Human"] = Value
end)

-- Stats Features
StatsSection:NewToggle("Auto Stats", "Toggles auto stats", function(Value)
    _G.Settings.Stat["Enabled Auto Stats"] = Value
end)

StatsSection:NewDropdown("Select Stats", "Select which stat to auto upgrade", {"Melee", "Defense", "Sword", "Gun", "Devil Fruit"}, function(Value)
    _G.Settings.Stat["Select Stats"] = Value
end)

StatsSection:NewSlider("Points Per Stats", "Select points per stat upgrade", 9, 1, function(Value)
    _G.Settings.Stat["Point Select"] = Value
end)

-- Settings
SettingsSection:NewDropdown("Select Weapon", "Select your weapon type", {"Melee", "Sword", "Fruit"}, function(Value)
    SelectWeapon = Value
end)

SettingsSection:NewToggle("Fast Attack", "Toggles fast attack", function(Value)
    _G.Settings.Configs["Fast Attack"] = Value
end)

SettingsSection:NewDropdown("Fast Attack Type", "Select fast attack speed", {"Fast", "Normal", "Slow"}, function(Value)
    _G.Settings.Configs["Fast Attack Type"] = Value
end)

SettingsSection:NewToggle("Auto Haki", "Toggles auto haki", function(Value)
    _G.Settings.Configs["Auto Haki"] = Value
end)

SettingsSection:NewSlider("Distance Auto Farm", "Adjust auto farm distance", 50, 1, function(Value)
    _G.Settings.Configs["Distance Auto Farm"] = Value
end)

-- Misc Settings
local MiscSection = SettingsTab:NewSection("Misc")

MiscSection:NewToggle("Bypass TP", "Toggles teleport bypass", function(Value)
    _G.Settings.Configs["Bypass TP"] = Value
end)

MiscSection:NewToggle("Auto Rejoin", "Toggles auto rejoin", function(Value)
    _G.Settings.Misc["Auto Rejoin"] = Value
end)

-- Keybind to toggle UI
SettingsSection:NewKeybind("Toggle UI", "Toggles the UI visibility", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

-- Initialize Settings if they don't exist
if not _G.Settings then
    _G.Settings = {
        Boss = {["Auto All Boss"] = false},
        Mastery = {
            ["Auto Farm Fruit Mastery"] = false,
            ["Auto Farm Gun Mastery"] = false
        },
        Main = {
            ["Auto New World"] = false,
            ["Auto Third Sea"] = false
        },
        FightingStyle = {
            ["Auto Superhuman"] = false,
            ["Auto Electric Claw"] = false,
            ["Auto Death Step"] = false,
            ["Auto Dragon Talon"] = false,
            ["Auto God Human"] = false
        },
        Stat = {
            ["Enabled Auto Stats"] = false,
            ["Select Stats"] = "Melee",
            ["Point Select"] = 3
        },
        Configs = {
            ["Fast Attack"] = true,
            ["Fast Attack Type"] = "Fast",
            ["Auto Haki"] = true,
            ["Distance Auto Farm"] = 20,
            ["Bypass TP"] = false
        },
        Misc = {
            ["Auto Rejoin"] = true
        }
    }
end
