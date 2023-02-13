while not game:IsLoaded() do
    wait()
end

local fallDamageEnabled = false
local Noclipping = nil
RunService = game:GetService("RunService")

    local function NoclipLoop()
            for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    child.CanCollide = false
                end
            end
            task.wait()
    end
    local oreNames = {"Prairie", "PrairieCave", "VolcanoQuarry", "Desert"}
local oreIndex = 1

local function teleportToOre()
    local oreFolder = game:GetService("Workspace").Ores:FindFirstChild(oreNames[oreIndex])
    if oreFolder then
        local orePart = oreFolder:GetChildren()[1]:FindFirstChild("Part")
        if orePart then
            local player = game:GetService("Players").LocalPlayer
            local teleportCFrame = orePart.CFrame
            player.Character:SetPrimaryPartCFrame(teleportCFrame + Vector3.new(0, 0, 4), orePart.Position)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, orePart.Position)
        end
    end
end

local chestFolder = game:GetService("Workspace").Chests

local function collectChest()
    for i,v in pairs(game:GetService("Workspace").Chests:GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
            fireproximityprompt(v, 0)
        end
    end
end

local function teleportToRandomChest()
    local randomIndex = math.random(1, #chestFolder:GetChildren())
    local randomChest = chestFolder:GetChildren()[randomIndex]
    
    local rootPart = randomChest:FindFirstChild("Root")
    if rootPart then
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = rootPart.CFrame * CFrame.new(50, 17, 0)
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(rootPart.Position)
        task.wait(4)
        if game.Players.LocalPlayer.Character.Humanoid.Health == 100 then
            task.wait(10)
            collectChest()
        else
            collectChest()
        end
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Hunter Hub", 5013109572)

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
}

local page = venyx:addPage("Main", 5012544693)
local section1 = page:addSection("Chest Farm")

section1:addToggle("Auto Chest Farm", false, function(value)
    while true do
        if value == true then
            teleportToRandomChest()
            task.wait(1.5)
        else
            break
        end
    end
end)

section1:addToggle("Auto Ore", false, function(boolean)
    getgenv().AutoOre = boolean
    while AutoOre do
        teleportToOre()
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Old Pickaxe").Slash:FireServer({[1] = 1})
            task.wait()
    end
end)

local FloatLoop = nil

section1:addToggle("Float", false, function(value)
    if value then
        FloatLoop = RunService.Heartbeat:Connect(function()
            local Float = Instance.new('Part', game.Workspace)
            Float.Name = 'hutner'
            Float.Transparency = 1
            Float.Size = Vector3.new(2,0.2,1.5)
            Float.Anchored = true
            local FloatValue = -3.1
            Float.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,FloatValue,0)
        end)
    else
        if FloatLoop then
            FloatLoop:Disconnect()
        end
    end
end)

section1:addButton("No-Clip", function(value)
    Noclipping = RunService.Stepped:Connect(NoclipLoop)
end)

section1:addButton("Teleport To Ore", function()
    teleportToOre()
end)

for theme, color in pairs(themes) do
    venyx:setTheme(theme, color)
    end
venyx:SelectPage(venyx.pages[1], true)
