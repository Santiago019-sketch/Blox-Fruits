local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Initialize main window
local Window = OrionLib:MakeWindow({
    Name = "Midnight Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MidnightHubConfig"
})

-- Initialize Combat Framework
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

function GetQuest()
    local Lv = GetCurrentLevel()
    local questName, questTitle, questLv, questMob, questCount
    -- Add quest data based on level here
    if Lv >= 1 and Lv <= 9 then
        questName = "BanditQuest1"
        questTitle = "Bandit"
        questLv = 1
        questMob = "Bandit"
        questCount = 1
    elseif Lv >= 10 and Lv <= 14 then
        questName = "JungleQuest"
        questTitle = "Monkey"
        questLv = 10
        questMob = "Monkey"
        questCount = 2
    end
    -- Add more quest levels as needed
    
    return {
        Name = questName,
        Title = questTitle,
        LevelReq = questLv,
        Mob = questMob,
        Count = questCount
    }
end

function CheckQuest()
    local Lv = GetCurrentLevel()
    local questData = GetQuest()
    
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", questData.Name, questData.LevelReq)
    end
end

-- Teleport Function
function Teleport(pos)
    if typeof(pos) == "CFrame" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    elseif typeof(pos) == "Vector3" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Get Mob Function
function GetMob()
    local questData = GetQuest()
    local target
    
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == questData.Mob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            target = v
            break
        end
    end
    
    return target
end

-- Main Farm Function
function StartFarm()
    if _G.Settings.Main["Auto Farm Level"] then
        CheckQuest()
        local mob = GetMob()
        
        if mob then
            PosMon = mob.HumanoidRootPart.CFrame
            Teleport(mob.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Configs["Distance Auto Farm"], 0))
            
            if _G.Settings.Configs["Auto Haki"] then
                if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end
            
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
        end
    end
end

-- Create Tabs
local Tab1 = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998"})

-- Main Farm Section
local FarmSection = Tab1:AddSection({Name = "Farming"})

FarmSection:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.Settings.Main["Auto Farm Level"] = Value
        SaveSettings()
    end
})

-- Settings
_G.Settings = {
    Main = {
        ["Auto Farm Level"] = false,
        ["Distance Auto Farm"] = 20,
    },
    Configs = {
        ["Auto Haki"] = true,
        ["Distance Auto Farm"] = 20,
    }
}

-- Start Farm Loop
spawn(function()
    while wait() do
        if _G.Settings.Main["Auto Farm Level"] then
            pcall(function()
                StartFarm()
            end)
        end
    end
end)

-- Save/Load Settings
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
