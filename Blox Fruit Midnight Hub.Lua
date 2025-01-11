local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Initialize main window
local Window = OrionLib:MakeWindow({
    Name = "Midnight Hub | Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MidnightHubConfig"
})

-- Global Settings
_G.Settings = {
    Main = {
        ["Auto Farm Level"] = false,
        ["Fast Auto Farm"] = false,
        ["Auto New World"] = false,
    },
    Configs = {
        ["Auto Haki"] = true,
        ["Fast Attack"] = true,
        ["Fast Attack Type"] = "Normal",
        ["Select Weapon"] = "",
        ["Distance Auto Farm"] = 20,
    },
    Visual = {
        ["Show Hitbox"] = false,
        ["No Fog"] = false,
        ["FPS Boost"] = false,
    }
}

-- Combat Framework Setup
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()

-- Helper Functions
function GetCurrentLevel()
    return game.Players.LocalPlayer.Data.Level.Value
end

function GetQuestLevel()
    local Lv = GetCurrentLevel()
    local Quest = {}
    
    if Lv >= 1 and Lv <= 9 then
        Quest.Name = "BanditQuest1"
        Quest.Level = 1
        Quest.Mob = "Bandit [Lv. 5]"
        Quest.Count = 1
        Quest.SpawnPoint = CFrame.new(1060.0065917969, 16.424287796021, 1547.9396972656)
    elseif Lv >= 10 and Lv <= 14 then
        Quest.Name = "JungleQuest"
        Quest.Level = 1
        Quest.Mob = "Monkey [Lv. 14]"
        Quest.Count = 2
        Quest.SpawnPoint = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end
    -- Add more quest levels as needed
    
    return Quest
end

function CheckQuest()
    local Quest = GetQuestLevel()
    
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", Quest.Name, Quest.Level)
    end
end

function GetMob()
    local Quest = GetQuestLevel()
    local Target
    
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == Quest.Mob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            Target = v
            break
        end
    end
    
    if Target then
        return Target
    end
    
    -- If no target found, check spawn points
    return Quest.SpawnPoint
end

-- Attack Functions
function FastAttack()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        for i = 1, 1 do
            local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                ac.blades[1].Size,
                ac.timeToNextAttack,
                ac.blades[1].Orientation,
                CFrame.new(0, 0, 0)
            )
            local cac = {}
            local hash = {}
            for k, v in pairs(bladehit) do
                if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                    table.insert(cac, v.Parent.HumanoidRootPart)
                    hash[v.Parent] = true
                end
            end
            bladehit = cac
            if #bladehit > 0 then
                ac:attack()
            end
        end
    end
end

-- Main Farm Function
function StartFarm()
    if _G.Settings.Main["Auto Farm Level"] then
        CheckQuest()
        local Target = GetMob()
        
        if Target then
            if Target:IsA("Model") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
                    Target.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Configs["Distance Auto Farm"], 0)
                
                if _G.Settings.Configs["Auto Haki"] then
                    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                    end
                end
                
                if _G.Settings.Configs["Fast Attack"] then
                    FastAttack()
                end
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
                    Target * CFrame.new(0, _G.Settings.Configs["Distance Auto Farm"], 0)
            end
        end
    end
end

-- Create Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main Section
local MainSection = MainTab:AddSection({
    Name = "Main Farm"
})

MainSection:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Flag = "AutoFarm",
    Save = true,
    Callback = function(Value)
        _G.Settings.Main["Auto Farm Level"] = Value
        SaveSettings()
    end    
})

MainSection:AddToggle({
    Name = "Fast Attack",
    Default = true,
    Flag = "FastAttack",
    Save = true,
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
        SaveSettings()
    end    
})

MainSection:AddToggle({
    Name = "Auto Haki",
    Default = true,
    Flag = "AutoHaki",
    Save = true,
    Callback = function(Value)
        _G.Settings.Configs["Auto Haki"] = Value
        SaveSettings()
    end    
})

MainSection:AddSlider({
    Name = "Farm Distance",
    Min = 10,
    Max = 50,
    Default = 20,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Distance",
    Flag = "FarmDistance",
    Save = true,
    Callback = function(Value)
        _G.Settings.Configs["Distance Auto Farm"] = Value
        SaveSettings()
    end    
})

-- Main Farm Loop
spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Main["Auto Farm Level"] then
                StartFarm()
            end
        end)
    end
end)

-- Save/Load Settings Functions
function SaveSettings()
    local HttpService = game:GetService("HttpService")
    if not isfolder("MidnightHub") then
        makefolder("MidnightHub")
    end
    writefile("MidnightHub/settings.json", HttpService:JSONEncode(_G.Settings))
end

function LoadSettings()
    local HttpService = game:GetService("HttpService")
    if isfile("MidnightHub/settings.json") then
        _G.Settings = HttpService:JSONDecode(readfile("MidnightHub/settings.json"))
    end
end

LoadSettings()
OrionLib:Init()
