-- Load required libraries
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Initialize main window
local Window = OrionLib:MakeWindow({
    Name = "Midnight Hub",
    HidePremium = false,
    SaveConfig = true,
    IntroEnabled = false,
    ConfigFolder = "MidnightHubConfig"
})

-- Initialize settings if they don't exist
if not _G.Settings then
    _G.Settings = {
        Main = {
            ["Auto Farm Level"] = false,
            ["Fast Auto Farm Level"] = false,
            -- Keep other settings as in original
        },
        Configs = {
            ["Fast Attack"] = true,
            ["Fast Attack Type"] = "Fast",
            ["Auto Haki"] = true,
            ["Select Weapon"] = "",
        }
    }
end

-- Create main farming tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Add toggle for auto farm
MainTab:AddToggle({
    Name = "Auto Farm Level",
    Default = _G.Settings.Main["Auto Farm Level"],
    Callback = function(Value)
        _G.AutoFarmLevelReal = Value
        _G.Settings.Main["Auto Farm Level"] = Value
        SaveSettings()
    end
})

-- Add toggle for fast attack
MainTab:AddToggle({
    Name = "Fast Attack",
    Default = _G.Settings.Configs["Fast Attack"],
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
        SaveSettings()
    end
})

-- Add weapon selection dropdown
local WeaponList = {"Melee", "Sword", "Fruit"}
MainTab:AddDropdown({
    Name = "Select Weapon",
    Default = "Melee",
    Options = WeaponList,
    Callback = function(Value)
        _G.Settings.Configs["Select Weapon"] = Value
        SaveSettings()
    end
})

-- Initialize the library
OrionLib:Init()

-- Save settings function
function SaveSettings()
    if not isfolder("MidnightHub") then
        makefolder("MidnightHub")
    end
    writefile("MidnightHub/settings.json", game:GetService("HttpService"):JSONEncode(_G.Settings))
end

-- Load settings function
function LoadSettings()
    if isfile("MidnightHub/settings.json") then
        local decoded = game:GetService("HttpService"):JSONDecode(readfile("MidnightHub/settings.json"))
        for i, v in pairs(decoded) do
            _G.Settings[i] = v
        end
    end
end

-- Load settings on script start
LoadSettings()
