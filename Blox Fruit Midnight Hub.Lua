local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- Create GUI
local GUI = Mercury:Create{
    Name = "Blox Fruits",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

-- Main Farm Tab
local FarmTab = GUI:Tab{
    Name = "Main Farm",
    Icon = "rbxassetid://4483345998"
}

FarmTab:Toggle{
    Name = "Auto Farm Level",
    StartingState = false,
    Description = "Automatically farms levels",
    Callback = function(Value)
        _G.AutoFarmLevelReal = Value
        Auto_Farm_Level = Value
        if Value == false then
            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end
}

-- Extra Farm Tab
local ExtraTab = GUI:Tab{
    Name = "Extra Farm",
    Icon = "rbxassetid://4483345998"
}

ExtraTab:Toggle{
    Name = "Auto Farm Boss",
    StartingState = false,
    Description = "Automatically farms bosses",
    Callback = function(Value)
        _G.Settings.Boss["Auto All Boss"] = Value
    end
}

ExtraTab:Toggle{
    Name = "Auto Farm Fruit Mastery",
    StartingState = false,
    Description = "Automatically farms fruit mastery",
    Callback = function(Value)
        _G.Settings.Mastery["Auto Farm Fruit Mastery"] = Value
    end
}

ExtraTab:Toggle{
    Name = "Auto Farm Gun Mastery",
    StartingState = false,
    Description = "Automatically farms gun mastery",
    Callback = function(Value)
        _G.Settings.Mastery["Auto Farm Gun Mastery"] = Value
    end
}

-- World Tab
local WorldTab = GUI:Tab{
    Name = "World",
    Icon = "rbxassetid://4483345998"
}

WorldTab:Toggle{
    Name = "Auto New World",
    StartingState = false,
    Description = "Automatically moves to new world",
    Callback = function(Value)
        _G.Settings.Main["Auto New World"] = Value
    end
}

WorldTab:Toggle{
    Name = "Auto Third Sea",
    StartingState = false,
    Description = "Automatically moves to third sea",
    Callback = function(Value)
        _G.Settings.Main["Auto Third Sea"] = Value
    end
}

-- Fighting Styles Tab
local StylesTab = GUI:Tab{
    Name = "Fighting Styles",
    Icon = "rbxassetid://4483345998"
}

StylesTab:Toggle{
    Name = "Auto Superhuman",
    StartingState = false,
    Description = "Automatically gets superhuman",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Superhuman"] = Value
    end
}

StylesTab:Toggle{
    Name = "Auto Electric Claw",
    StartingState = false,
    Description = "Automatically gets electric claw",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Electric Claw"] = Value
    end
}

StylesTab:Toggle{
    Name = "Auto Death Step",
    StartingState = false,
    Description = "Automatically gets death step",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Death Step"] = Value
    end
}

StylesTab:Toggle{
    Name = "Auto Dragon Talon",
    StartingState = false,
    Description = "Automatically gets dragon talon",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Dragon Talon"] = Value
    end
}

StylesTab:Toggle{
    Name = "Auto God Human",
    StartingState = false,
    Description = "Automatically gets god human",
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto God Human"] = Value
    end
}

-- Stats Tab
local StatsTab = GUI:Tab{
    Name = "Stats",
    Icon = "rbxassetid://4483345998"
}

StatsTab:Toggle{
    Name = "Auto Stats",
    StartingState = false,
    Description = "Automatically upgrades stats",
    Callback = function(Value)
        _G.Settings.Stat["Enabled Auto Stats"] = Value
    end
}

StatsTab:Dropdown{
    Name = "Select Stats",
    StartingText = "Select Stat",
    Description = "Choose which stat to upgrade",
    Items = {"Melee", "Defense", "Sword", "Gun", "Devil Fruit"},
    Callback = function(Value)
        _G.Settings.Stat["Select Stats"] = Value
    end
}

StatsTab:Slider{
    Name = "Points Per Stats",
    Default = 3,
    Min = 1,
    Max = 9,
    Description = "Points to allocate per upgrade",
    Callback = function(Value)
        _G.Settings.Stat["Point Select"] = Value
    end
}

-- Settings Tab
local SettingsTab = GUI:Tab{
    Name = "Settings",
    Icon = "rbxassetid://4483345998"
}

SettingsTab:Dropdown{
    Name = "Select Weapon",
    StartingText = "Select Weapon",
    Description = "Choose your weapon type",
    Items = {"Melee", "Sword", "Fruit"},
    Callback = function(Value)
        SelectWeapon = Value
    end
}

SettingsTab:Toggle{
    Name = "Fast Attack",
    StartingState = true,
    Description = "Enables fast attack",
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
    end
}

SettingsTab:Dropdown{
    Name = "Fast Attack Type",
    StartingText = "Select Attack Speed",
    Description = "Choose attack speed",
    Items = {"Fast", "Normal", "Slow"},
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack Type"] = Value
    end
}

SettingsTab:Toggle{
    Name = "Auto Haki",
    StartingState = true,
    Description = "Automatically uses Haki",
    Callback = function(Value)
        _G.Settings.Configs["Auto Haki"] = Value
    end
}

SettingsTab:Slider{
    Name = "Distance Auto Farm",
    Default = 20,
    Min = 1,
    Max = 50,
    Description = "Set auto farm distance",
    Callback = function(Value)
        _G.Settings.Configs["Distance Auto Farm"] = Value
    end
}

SettingsTab:Toggle{
    Name = "Bypass TP",
    StartingState = false,
    Description = "Bypasses teleport restrictions",
    Callback = function(Value)
        _G.Settings.Configs["Bypass TP"] = Value
    end
}

SettingsTab:Toggle{
    Name = "Auto Rejoin",
    StartingState = true,
    Description = "Automatically rejoins game",
    Callback = function(Value)
        _G.Settings.Misc["Auto Rejoin"] = Value
    end
}

-- Initialize settings if they don't exist
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

-- Notification to confirm script loaded
GUI:Notification{
    Title = "Script Loaded",
    Text = "Blox Fruits script is now running!",
    Duration = 3,
    Callback = function() end
}
