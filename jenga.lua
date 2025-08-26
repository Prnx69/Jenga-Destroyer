print("Loading ui...")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

print("Loading services...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

print("Loading player...")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local lp = Players.LocalPlayer
local noclipActive = false
local steppedConn
local cam = workspace.CurrentCamera
local savedCamCFrame

print("Loading script functions...")

local function enableNoclip()
    if noclipActive then return end
    noclipActive = true

    steppedConn = RunService.Stepped:Connect(function()
        local character = Workspace:FindFirstChild(player.Name)
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function disableNoclip()
    if not noclipActive then return end
    noclipActive = false

    if steppedConn then
        steppedConn:Disconnect()
        steppedConn = nil
    end

    local character = Workspace:FindFirstChild(player.Name)
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local function getHumanoid()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local function setJumpHeight(height)
    local hum = getHumanoid()
    hum.UseJumpPower = false
    hum.JumpHeight = height
end

local function setSpeed(speed)
    local hum = getHumanoid()
    hum.WalkSpeed = speed
end

print("Starting ui...")

local Window = Rayfield:CreateWindow({
   Name = "Jenga Destroyer",
   Icon = 0,
   LoadingTitle = "Jenga Destroyer",
   LoadingSubtitle = "by prnxz69",
   ShowText = "Rayfield",
   Theme = "Default",
   ToggleUIKeybind = "N"
})

print("Success!")

local MainTab = Window:CreateTab("Main")
local MainSection = MainTab:CreateSection("Main Functions")

MainTab:CreateButton({
Name = "Win the game (Only in Tower's team)",
    Callback = function()
local savedCamType = cam.CameraType
local savedCamCFrame = cam.CFrame

local initialCamPosition = cam.CFrame.Position

local lookDownTarget = player.Character.HumanoidRootPart.Position
cam.CameraType = Enum.CameraType.Scriptable
cam.CFrame = CFrame.lookAt(initialCamPosition, lookDownTarget)

enableNoclip()
player.Character.HumanoidRootPart.CFrame = CFrame.new(-65, 98, -18)
task.wait(0.5)
disableNoclip()

player.Character.HumanoidRootPart.CFrame = CFrame.new(-68, 228, -18)

cam.CameraType = savedCamType
cam.CFrame = CFrame.lookAt(cam.CFrame.Position, player.Character.HumanoidRootPart.Position)

Rayfield:Notify({
    Title = "Success!",
    Content = "Телепорт завершён, камера восстановлена.",
    Duration = 2.5,
    Image = "info",
})

end

})

MainTab:CreateButton({
    Name = "Remove Kill Barrier",
    Callback = function()
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            for _, obj in ipairs(mapFolder:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name == "KillBrick" then
                    obj:Destroy()
                end
            end
        end
        Rayfield:Notify({
            Title = "Success!",
            Content = "Success!",
            Duration = 2.5,
            Image = "info",
        })
    end
})

local PlayerTab = Window:CreateTab("Player")
local PlayerSection = PlayerTab:CreateSection("Player Misc")

PlayerTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(state)
        if state then
            enableNoclip()
        else
            disableNoclip()
        end
   end
})

PlayerTab:CreateSlider({
    Name = "Set Walkspeed",
    Range = {2, 100},
    Increment = 2,
    CurrentValue = 16,
    Callback = function(speed)
        setSpeed(speed)
    end
})

PlayerTab:CreateSlider({
    Name = "Set JumpPower",
    Range = {2, 30},
    Increment = 2,
    CurrentValue = 6,
    Callback = function(value)
        setJumpHeight(value)
    end
})

local TeleportsTab = Window:CreateTab("Teleports")
local TeleportsSection = TeleportsTab:CreateSection("Teleports On The Map")

local Button = TeleportsTab:CreateButton({
   Name = "Teleport To Tower",
   Callback = function()
   
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-68, 228, -18)
   
    end
})

local Button = TeleportsTab:CreateButton({
   Name = "Teleport To Destroyer",
   Callback = function()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(266, 100, 27)

   end
})

local Button = TeleportsTab:CreateButton({
   Name = "Teleport To Safe Zone",
   Callback = function()

local platform = workspace:FindFirstChild("SafePlatform")

if not platform then
    platform = Instance.new("Part")
    platform.Name = "SafePlatform" -- имя платформы
    platform.Size = Vector3.new(30, 2, 30)
    platform.CFrame = CFrame.new(-31, 202, -135)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Parent = workspace
end

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
hrp.CFrame = platform.CFrame + Vector3.new(0, 4, 0)

    end
})

local ScriptsTab = Window:CreateTab("Scripts")
local ScriptsSection = ScriptsTab:CreateSection("Default Scripts")

local Button = ScriptsTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

local Button = ScriptsTab:CreateButton({
   Name = "System Broken",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()
   end,
})

local Button = ScriptsTab:CreateButton({
   Name = "Emotes",
   Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Free-emote/refs/heads/main/Delta%20mad%20stuffs"))()
   end,
})

local CreditsTab = Window:CreateTab("Credits")

local Paragraph = CreditsTab:CreateParagraph({Title = "Credits:", Content = "Coder: prnxz69"})
