local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "Blox Fruits Auto Farm", 
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BloxFruitsConfig"
})

-- Main farming tab
local FarmTab = Window:MakeTab({
    Name = "Main Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Additional farming tab
local ExtraFarmTab = Window:MakeTab({
    Name = "Extra Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- World specific tab
local WorldTab = Window:MakeTab({
    Name = "World",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Settings tab
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Fighting Styles tab
local StylesTab = Window:MakeTab({
    Name = "Fighting Styles",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Stats tab
local StatsTab = Window:MakeTab({
    Name = "Stats",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main farming toggle
FarmTab:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevelReal = Value
        Auto_Farm_Level = Value
        if Value == false then
            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end    
})

-- Extra Farm Features
ExtraFarmTab:AddToggle({
    Name = "Auto Farm Boss",
    Default = false,
    Callback = function(Value)
        _G.Settings.Boss["Auto All Boss"] = Value
    end    
})

ExtraFarmTab:AddToggle({
    Name = "Auto Farm Fruit Mastery",
    Default = false,
    Callback = function(Value)
        _G.Settings.Mastery["Auto Farm Fruit Mastery"] = Value
    end    
})

ExtraFarmTab:AddToggle({
    Name = "Auto Farm Gun Mastery",
    Default = false,
    Callback = function(Value)
        _G.Settings.Mastery["Auto Farm Gun Mastery"] = Value
    end    
})

-- World Features
WorldTab:AddToggle({
    Name = "Auto New World",
    Default = false,
    Callback = function(Value)
        _G.Settings.Main["Auto New World"] = Value
    end    
})

WorldTab:AddToggle({
    Name = "Auto Third Sea",
    Default = false,
    Callback = function(Value)
        _G.Settings.Main["Auto Third Sea"] = Value
    end    
})

-- Fighting Styles
StylesTab:AddToggle({
    Name = "Auto Superhuman",
    Default = false,
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Superhuman"] = Value
    end    
})

StylesTab:AddToggle({
    Name = "Auto Electric Claw",
    Default = false,
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Electric Claw"] = Value
    end    
})

StylesTab:AddToggle({
    Name = "Auto Death Step",
    Default = false,
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Death Step"] = Value
    end    
})

StylesTab:AddToggle({
    Name = "Auto Dragon Talon",
    Default = false,
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto Dragon Talon"] = Value
    end    
})

StylesTab:AddToggle({
    Name = "Auto God Human",
    Default = false,
    Callback = function(Value)
        _G.Settings.FightingStyle["Auto God Human"] = Value
    end    
})

-- Stats Features
StatsTab:AddToggle({
    Name = "Auto Stats",
    Default = false,
    Callback = function(Value)
        _G.Settings.Stat["Enabled Auto Stats"] = Value
    end    
})

StatsTab:AddDropdown({
    Name = "Select Stats",
    Default = "Melee",
    Options = {"Melee", "Defense", "Sword", "Gun", "Devil Fruit"},
    Callback = function(Value)
        _G.Settings.Stat["Select Stats"] = Value
    end    
})

StatsTab:AddSlider({
    Name = "Points Per Stats",
    Min = 1,
    Max = 9,
    Default = 3,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    Callback = function(Value)
        _G.Settings.Stat["Point Select"] = Value
    end    
})

-- Settings
SettingsTab:AddDropdown({
    Name = "Select Weapon",
    Default = "Melee",
    Options = {"Melee", "Sword", "Fruit"},
    Callback = function(Value)
        SelectWeapon = Value
    end    
})

SettingsTab:AddToggle({
    Name = "Fast Attack",
    Default = true,
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
    end    
})

SettingsTab:AddDropdown({
    Name = "Fast Attack Type",
    Default = "Fast",
    Options = {"Fast", "Normal", "Slow"},
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack Type"] = Value
    end    
})

SettingsTab:AddToggle({
    Name = "Auto Haki",
    Default = true,
    Callback = function(Value)
        _G.Settings.Configs["Auto Haki"] = Value
    end    
})

SettingsTab:AddSlider({
    Name = "Distance Auto Farm",
    Min = 1,
    Max = 50,
    Default = 20,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    Callback = function(Value)
        _G.Settings.Configs["Distance Auto Farm"] = Value
    end    
})

-- Misc Settings
SettingsTab:AddToggle({
    Name = "Bypass TP",
    Default = false,
    Callback = function(Value)
        _G.Settings.Configs["Bypass TP"] = Value
    end    
})

SettingsTab:AddToggle({
    Name = "Auto Rejoin",
    Default = true,
    Callback = function(Value)
        _G.Settings.Misc["Auto Rejoin"] = Value
    end    
})

-- [Keep all original functions and logic below this point]
local function QuestCheck()
    -- [Original QuestCheck function code remains the same]
end

local function Bypass(Point)
    -- [Original Bypass function code remains the same]
end

local function toTarget(...)
    -- [Original toTarget function code remains the same]
end

local function InMyNetWork(object)
    -- [Original InMyNetWork function code remains the same]
end

-- Keep all the original spawning functions
spawn(function()
    while true do wait()
        if setscriptable then
            setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
        end
        if sethiddenproperty then
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
        end
    end
end)

-- Main farming loop
spawn(function()
    while task.wait() do
        if _G.AutoFarmLevelReal then
            pcall(function()
                -- [Original farming logic remains the same]
            end)
        end
    end
end)

-- Auto Stats
spawn(function()
    while wait() do
        if _G.Settings.Stat["Enabled Auto Stats"] then
            if game:GetService("Players").LocalPlayer.Data.Points.Value >= _G.Settings.Stat["Point Select"] then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.Settings.Stat["Select Stats"], _G.Settings.Stat["Point Select"])
            end
        end
    end
end)

-- Auto Haki
spawn(function()
    while wait() do
        if _G.Settings.Configs["Auto Haki"] then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- Auto Rejoin
spawn(function()
    while wait() do
        if _G.Settings.Misc["Auto Rejoin"] then
            game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                end
            end)
        end
    end
end)

-- Initialize
OrionLib:Init()
