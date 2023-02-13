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
            task.wait(2)
        else
            collectChest()
            task.wait(2)
        end
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Nigger Hub", 5013109572)


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

section1:addToggle("No Fall Damage", false, function(value)
    fallDamageEnabled = value
    while fallDamageEnabled do
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        task.wait()
    end
end)

section1:addToggle("Auto Chest Farm", false, function(value)
    while true do
        if value == true then
            teleportToRandomChest()
        else
            break
        end
    end
end)

section1:addToggle("Float", false, function(value)
    while value do
        pcall(function()
local Float = Instance.new('Part', game.Workspace)
Float.Name = 'nigger'
Float.Transparency = 1
Float.Size = Vector3.new(2,0.2,1.5)
Float.Anchored = true
local FloatValue = -3.1
Float.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,FloatValue,0)
task.wait()
end)
end
end)

section1:addButton("No-Clip", function(value)
    Noclipping = RunService.Stepped:Connect(NoclipLoop)
end)

for theme, color in pairs(themes) do
    venyx:setTheme(theme, color)
end

venyx:SelectPage(venyx.pages[1], true)