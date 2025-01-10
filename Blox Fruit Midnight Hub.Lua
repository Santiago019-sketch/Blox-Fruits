-- Load Core Libraries
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()

-- Initialize Settings
_G.Settings = {
    Main = {
        ["Auto Farm Level"] = false,
        ["Fast Auto Farm Level"] = false,
        ["Auto New World"] = false,
        ["Auto Third Sea"] = false
    },
    Configs = {
        ["Fast Attack"] = true,
        ["Fast Attack Type"] = "Fast",
        ["Select Weapon"] = "",
        ["Auto Haki"] = true,
        ["Distance Auto Farm"] = 20,
        ["Bypass TP"] = true
    }
}

-- Create Main Window
local Window = OrionLib:MakeWindow({
    Name = "🌟 Midnight Hub | Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MidnightHubConfig",
    IntroEnabled = true,
    IntroText = "Midnight Hub"
})

-- Utility Functions
local function toTarget(targetCFrame)
    local Distance = (targetCFrame.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
    local Speed = Distance < 1000 and 315 or 300
    
    local tween = game:service"TweenService":Create(
        game.Players.LocalPlayer.Character["HumanoidRootPart"],
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = targetCFrame}
    )
    tween:Play()
    return tween
end

local function AttackFunction()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        for i = 1, 1 do
            local bladehit = getAllBladeHits(60)
            if #bladehit > 0 then
                local attack = {
                    ["Disabled"] = true,
                    ["Force"] = 1,
                }
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(CurrentWeapon()))
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
            end
        end
    end
end

function getAllBladeHits(Sizes)
    local Hits = {}
    local Client = game.Players.LocalPlayer
    local Enemies = game:GetService("Workspace").Enemies:GetChildren()
    for i=1,#Enemies do 
        local v = Enemies[i]
        local Human = v:FindFirstChildOfClass("Humanoid")
        if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
            table.insert(Hits,Human.RootPart)
        end
    end
    return Hits
end

-- Auto Farm Functions
function CheckQuest()
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    if MyLevel >= 1 and MyLevel <= 9 then
        if tostring(game.Players.LocalPlayer.Team) == "Marines" then
            return {
                ["Monster"] = "Trainee [Lv. 5]",
                ["Quest Name"] = "MarineQuest",
                ["Quest Level"] = 1,
                ["Quest CFrame"] = CFrame.new(-2709.67944, 24.5206585, 2104.24585)
            }
        else
            return {
                ["Monster"] = "Bandit [Lv. 5]",
                ["Quest Name"] = "BanditQuest1",
                ["Quest Level"] = 1,
                ["Quest CFrame"] = CFrame.new(1059.99731, 16.9222069, 1549.28162)
            }
        end
    end
    -- Add more level ranges as needed
end

-- Create Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Create Settings Tab
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main Farm Section
local FarmSection = MainTab:AddSection({
    Name = "Auto Farm"
})

FarmSection:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevelReal = Value
        _G.Settings.Main["Auto Farm Level"] = Value
        if Value == false then
            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end    
})

-- Settings Section
local SettingsSection = SettingsTab:AddSection({
    Name = "Combat Settings"
})

SettingsSection:AddToggle({
    Name = "Fast Attack",
    Default = true,
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
    end    
})

SettingsSection:AddDropdown({
    Name = "Attack Type",
    Default = "Fast",
    Options = {"Fast", "Normal", "Slow"},
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack Type"] = Value
    end    
})

-- Weapon Selection
local Weapons = {"Melee", "Sword", "Fruit"}
SettingsSection:AddDropdown({
    Name = "Select Weapon",
    Default = "Melee",
    Options = Weapons,
    Callback = function(Value)
        _G.Settings.Configs["Select Weapon"] = Value
    end    
})

-- Auto Farm Loop
spawn(function()
    while wait() do
        if _G.AutoFarmLevelReal then
            pcall(function()
                local QuestData = CheckQuest()
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    toTarget(QuestData["Quest CFrame"])
                    if (QuestData["Quest CFrame"].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestData["Quest Name"], QuestData["Quest Level"])
                    end
                else
                    if game:GetService("Workspace").Enemies:FindFirstChild(QuestData["Monster"]) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == QuestData["Monster"] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat wait()
                                    toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    if _G.Settings.Configs["Fast Attack"] then
                                        AttackFunction()
                                    end
                                until not _G.AutoFarmLevelReal or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    else
                        toTarget(CFrame.new(10,50,10))
                    end
                end
            end)
        end
    end
end)

-- Fast Attack Implementation
spawn(function()
    while wait(0.1) do
        if _G.Settings.Configs["Fast Attack"] then
            pcall(function()
                local ac = CombatFrameworkR.activeController
                if ac and ac.equipped then
                    AttackFunction()
                    if _G.Settings.Configs["Fast Attack Type"] == "Normal" then
                        if tick() - cooldownfastattack > 0.9 then wait(0.1) cooldownfastattack = tick() end
                    elseif _G.Settings.Configs["Fast Attack Type"] == "Fast" then
                        if tick() - cooldownfastattack > 1.5 then wait(0.01) cooldownfastattack = tick() end
                    elseif _G.Settings.Configs["Fast Attack Type"] == "Slow" then
                        if tick() - cooldownfastattack > 0.3 then wait(0.7) cooldownfastattack = tick() end
                    end
                end
            end)
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

-- Initialize UI
OrionLib:Init()

-- Welcome Notification
OrionLib:MakeNotification({
    Name = "Midnight Hub",
    Content = "Script loaded successfully!",
    Image = "rbxassetid://4483345998",
    Time = 5
})
