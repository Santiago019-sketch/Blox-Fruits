-- Load required dependencies
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

-- Create main tabs
local Tab1 = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998"})
local Tab2 = Window:MakeTab({Name = "Player/Stats", Icon = "rbxassetid://4483345998"})
local Tab3 = Window:MakeTab({Name = "Teleport/Dungeon", Icon = "rbxassetid://4483345998"})
local Tab4 = Window:MakeTab({Name = "Shop", Icon = "rbxassetid://4483345998"})
local Tab5 = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483345998"})

-- Initialize settings
_G.Settings = {
    Main = {
        ["Auto Farm Level"] = false,
        ["Fast Auto Farm Level"] = false,
        ["Distance Mob Aura"] = 1000,
        ["Mob Aura"] = false,
        ["Auto New World"] = false,
        ["Auto Saber"] = false,
        ["Auto Pole"] = false,
        ["Auto Buy Ability"] = false,
        -- Add all other Main settings from original
    },
    FightingStyle = {
        ["Auto God Human"] = false,
        ["Auto Superhuman"] = false,
        ["Auto Electric Claw"] = false,
        ["Auto Death Step"] = false,
        ["Auto Fully Death Step"] = false,
        ["Auto SharkMan Karate"] = false,
        ["Auto Fully SharkMan Karate"] = false,
        ["Auto Dragon Talon"] = false,
    },
    Boss = {
        ["Auto All Boss"] = false,
        ["Auto Boss Select"] = false,
        ["Select Boss"] = {},
        ["Auto Quest"] = false,
    },
    Mastery = {
        ["Select Multi Sword"] = {},
        ["Farm Mastery SwordList"] = false,
        ["Auto Farm Fruit Mastery"] = false,
        ["Auto Farm Gun Mastery"] = false,
        ["Mob Health (%)"] = 15,
    },
    Configs = {
        ["Double Quest"] = false,
        ["Bypass TP"] = false,
        ["Select Team"] = {"Pirate"},
        ["Fast Attack"] = true,
        ["Fast Attack Type"] = {"Fast"},
        ["Select Weapon"] = {},
        ["Auto Haki"] = true,
        ["Distance Auto Farm"] = 20,
        ["Camera Shaker"] = false,
        ["Skill Z"] = true,
        ["Skill X"] = true,
        ["Skill C"] = true,
        ["Skill V"] = true,
        ["Show Hitbox"] = false,
        ["Bring Mob"] = true,
        ["Disabled Damage"] = false,
    }
}

-- Main Farm Section
local FarmSection = Tab1:AddSection({Name = "Farming"})

FarmSection:AddToggle({
    Name = "Auto Farm Level",
    Default = _G.Settings.Main["Auto Farm Level"],
    Callback = function(Value)
        _G.Settings.Main["Auto Farm Level"] = Value
        _G.AutoFarmLevelReal = Value
        SaveSettings()
    end
})

FarmSection:AddToggle({
    Name = "Fast Auto Farm",
    Default = _G.Settings.Main["Fast Auto Farm Level"],
    Callback = function(Value)
        _G.Settings.Main["Fast Auto Farm Level"] = Value
        SaveSettings()
    end
})

-- Combat Section
local CombatSection = Tab1:AddSection({Name = "Combat"})

CombatSection:AddToggle({
    Name = "Fast Attack",
    Default = _G.Settings.Configs["Fast Attack"],
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack"] = Value
        SaveSettings()
    end
})

CombatSection:AddDropdown({
    Name = "Fast Attack Type",
    Default = "Fast",
    Options = {"Fast", "Normal", "Slow"},
    Callback = function(Value)
        _G.Settings.Configs["Fast Attack Type"] = Value
        SaveSettings()
    end
})

-- Weapon Selection
local WeaponSection = Tab1:AddSection({Name = "Weapons"})

WeaponSection:AddDropdown({
    Name = "Select Weapon",
    Default = "Melee",
    Options = {"Melee", "Sword", "Fruit"},
    Callback = function(Value)
        SelectWeapon = Value
        _G.Settings.Configs["Select Weapon"] = Value
        SaveSettings()
    end
})

-- Auto Haki
local HakiSection = Tab1:AddSection({Name = "Haki"})

HakiSection:AddToggle({
    Name = "Auto Haki",
    Default = _G.Settings.Configs["Auto Haki"],
    Callback = function(Value)
        _G.Settings.Configs["Auto Haki"] = Value
        SaveSettings()
    end
})

-- Add your existing helper functions
function AttackFunction()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        for indexincrement = 1, 1 do
            local bladehit = getAllBladeHits(60)
            if #bladehit > 0 then
                local AcAttack8 = debug.getupvalue(ac.attack, 5)
                local AcAttack9 = debug.getupvalue(ac.attack, 6)
                local AcAttack7 = debug.getupvalue(ac.attack, 4)
                local AcAttack10 = debug.getupvalue(ac.attack, 7)
                local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
                local NumberAc13 = AcAttack7 * 798405
                NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
                AcAttack8 = math.floor(NumberAc12 / AcAttack9)
                AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
                AcAttack10 = AcAttack10 + 1
                debug.setupvalue(ac.attack, 5, AcAttack8)
                debug.setupvalue(ac.attack, 6, AcAttack9)
                debug.setupvalue(ac.attack, 4, AcAttack7)
                debug.setupvalue(ac.attack, 7, AcAttack10)
                for k, v in pairs(ac.animator.anims.basic) do
                    v:Play(0.01,0.01,0.01)
                end                 
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
                    game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
                end
            end
        end
    end
end

-- Keep your existing spawns and functions
spawn(function()
    while task.wait() do
        if _G.Settings.Configs["Fast Attack"] then
            AttackFunction()
        end
    end
end)

spawn(function()
    while wait() do
        if _G.Settings.Configs["Auto Haki"] then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- Add your auto farm functionality
spawn(function()
    while task.wait() do
        if _G.AutoFarmLevelReal and BringMobFarm then
            pcall(function()
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 400 then
                        if InMyNetWork(v.HumanoidRootPart) then
                            v.HumanoidRootPart.CFrame = PosMon
                            v.Humanoid.JumpPower = 0
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            v.Humanoid:ChangeState(11)
                            v.Humanoid:ChangeState(14)
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                        end
                    end
                end
            end)
        end
    end
end)

-- Initialize the library
OrionLib:Init()

-- Add saving/loading of settings
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
