-- Load the library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()

-- Create the main window
local venyx = library.new("Blox Fruits", 5013109572)

-- Create pages
local farm = venyx:addPage("Main Farm", 5012544693)
local extras = venyx:addPage("Extra Farm", 5012544693)
local world = venyx:addPage("World", 5012544693)
local styles = venyx:addPage("Fighting Styles", 5012544693)
local stats = venyx:addPage("Stats", 5012544693)
local settings = venyx:addPage("Settings", 5012544693)

-- Main Farm Section
local farmSection = farm:addSection("Farming")
farmSection:addToggle("Auto Farm Level", nil, function(value)
    _G.AutoFarmLevelReal = value
    Auto_Farm_Level = value
    if value == false then
        toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
    end
end)

-- Extra Farm Section
local extrasSection = extras:addSection("Extra Features")
extrasSection:addToggle("Auto Farm Boss", nil, function(value)
    _G.Settings.Boss["Auto All Boss"] = value
end)

extrasSection:addToggle("Auto Farm Fruit Mastery", nil, function(value)
    _G.Settings.Mastery["Auto Farm Fruit Mastery"] = value
end)

extrasSection:addToggle("Auto Farm Gun Mastery", nil, function(value)
    _G.Settings.Mastery["Auto Farm Gun Mastery"] = value
end)

-- World Section
local worldSection = world:addSection("World Features")
worldSection:addToggle("Auto New World", nil, function(value)
    _G.Settings.Main["Auto New World"] = value
end)

worldSection:addToggle("Auto Third Sea", nil, function(value)
    _G.Settings.Main["Auto Third Sea"] = value
end)

-- Fighting Styles Section
local stylesSection = styles:addSection("Fighting Styles")
stylesSection:addToggle("Auto Superhuman", nil, function(value)
    _G.Settings.FightingStyle["Auto Superhuman"] = value
end)

stylesSection:addToggle("Auto Electric Claw", nil, function(value)
    _G.Settings.FightingStyle["Auto Electric Claw"] = value
end)

stylesSection:addToggle("Auto Death Step", nil, function(value)
    _G.Settings.FightingStyle["Auto Death Step"] = value
end)

stylesSection:addToggle("Auto Dragon Talon", nil, function(value)
    _G.Settings.FightingStyle["Auto Dragon Talon"] = value
end)

stylesSection:addToggle("Auto God Human", nil, function(value)
    _G.Settings.FightingStyle["Auto God Human"] = value
end)

-- Stats Section
local statsSection = stats:addSection("Stats")
statsSection:addToggle("Auto Stats", nil, function(value)
    _G.Settings.Stat["Enabled Auto Stats"] = value
end)

statsSection:addDropdown("Select Stats", {"Melee", "Defense", "Sword", "Gun", "Devil Fruit"}, function(value)
    _G.Settings.Stat["Select Stats"] = value
end)

statsSection:addSlider("Points Per Stats", 1, 1, 9, function(value)
    _G.Settings.Stat["Point Select"] = value
end)

-- Settings Section
local settingsSection = settings:addSection("Settings")
settingsSection:addDropdown("Select Weapon", {"Melee", "Sword", "Fruit"}, function(value)
    SelectWeapon = value
end)

settingsSection:addToggle("Fast Attack", true, function(value)
    _G.Settings.Configs["Fast Attack"] = value
end)

settingsSection:addDropdown("Fast Attack Type", {"Fast", "Normal", "Slow"}, function(value)
    _G.Settings.Configs["Fast Attack Type"] = value
end)

settingsSection:addToggle("Auto Haki", true, function(value)
    _G.Settings.Configs["Auto Haki"] = value
end)

settingsSection:addSlider("Distance Auto Farm", 1, 1, 50, function(value)
    _G.Settings.Configs["Distance Auto Farm"] = value
end)

local miscSection = settings:addSection("Misc")
miscSection:addToggle("Bypass TP", nil, function(value)
    _G.Settings.Configs["Bypass TP"] = value
end)

miscSection:addToggle("Auto Rejoin", true, function(value)
    _G.Settings.Misc["Auto Rejoin"] = value
end)

-- Initialize Settings
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

-- Theme customization
local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
}

-- Load theme
for theme, color in pairs(themes) do
    venyx:setTheme(theme, color)
end

-- Show UI
venyx:SelectPage(venyx.pages[1], true)

-- Toggle key
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        venyx:toggle()
    end
end)
