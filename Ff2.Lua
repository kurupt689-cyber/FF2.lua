-- Load Rayfield UI
loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Gravity = Workspace.Gravity

-- Magnet & Movement Variables
local MagPower, MagsEnabled, CatchChance = 25, true, 100
local InfiniteJumpEnabled, NoClipEnabled, CustomJumpPower = false, false, 50
local LongArmsEnabled = false
local originalArms = {}

-- Extend/Reset Arms
local function ExtendArms()
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    for _, side in pairs({"Right Arm","Left Arm"}) do
        local arm = c:FindFirstChild(side)
        if arm and not originalArms[side] then
            originalArms[side] = arm.Size
            arm.Size = Vector3.new(arm.Size.X,5,arm.Size.Z)
            arm.Massless, arm.CanCollide = true, false
            local weld = arm:FindFirstChildOfClass("Motor6D")
            if weld then weld.C0 = weld.C0 * CFrame.new(0,-2,0) end
        end
    end
end

local function ResetArms()
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    for _, side in pairs({"Right Arm","Left Arm"}) do
        local arm, origSize = c:FindFirstChild(side), originalArms[side]
        if arm and origSize then
            arm.Size = origSize
            local weld = arm:FindFirstChildOfClass("Motor6D")
            if weld then weld.C0 = weld.C0 * CFrame.new(0,2,0) end
        end
    end
end

-- Touch function
local function Touch(part)
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local CatchRight = c:FindFirstChild("CatchRight")
    if CatchRight then
        firetouchinterest(CatchRight, part, 0)
        firetouchinterest(CatchRight, part, 1)
    end
end

-- Heartbeat: Magnet + Movement
RunService.Heartbeat:Connect(function()
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = c:FindFirstChild("Humanoid")
    local CatchRight = c:FindFirstChild("CatchRight")

    if MagsEnabled and CatchRight then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("ball") then
                if (CatchRight.Position - v.Position).Magnitude <= MagPower and math.random(100) <= CatchChance then
                    Touch(v)
                end
            end
        end
    end

    if NoClipEnabled and c then
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
        end
    end

    if hum then hum.JumpPower = CustomJumpPower end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = c:FindFirstChild("Humanoid")
    if InfiniteJumpEnabled and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Star Hub",
    LoadingTitle = "Star Hub",
    LoadingSubtitle = "Professional FF2 Hub",
    ConfigurationSaving = {Enabled = false},
    Discord = {Enabled = false},
    KeySystem = false
})

-- Tabs
local MainTab = Window:CreateTab("🏈 Legit Magnet", 4483362458)
local MovementTab = Window:CreateTab("🌀 Movement", 4483362458)
local VisualsTab = Window:CreateTab("👀 Visuals", 4483362458)

-- MainTab Controls
MainTab:CreateToggle({Name="Enable Legit Mags",CurrentValue=MagsEnabled,Callback=function(v) MagsEnabled=v end})
MainTab:CreateSlider({Name="Mag Power (Studs)",Range={5,30},Increment=1,Suffix="Studs",CurrentValue=MagPower,Callback=function(v) MagPower=v end})
MainTab:CreateSlider({Name="Catch Chance %",Range={80,100},Increment=5,Suffix="%",CurrentValue=CatchChance,Callback=function(v) CatchChance=v end})

-- MovementTab Controls
MovementTab:CreateToggle({Name="Infinite Jump",CurrentValue=InfiniteJumpEnabled,Callback=function(v) InfiniteJumpEnabled=v end})
MovementTab:CreateToggle({Name="NoClip (Anti-Wall)",CurrentValue=NoClipEnabled,Callback=function(v) NoClipEnabled=v end})
MovementTab:CreateSlider({Name="Jump Power",Range={10,150},Increment=5,Suffix="JP",CurrentValue=CustomJumpPower,Callback=function(v) CustomJumpPower=v end})
MovementTab:CreateToggle({Name="🦍 Long Arms (R6 Real Hitbox)",CurrentValue=LongArmsEnabled,Callback=function(v) LongArmsEnabled=v if v then ExtendArms() else ResetArms() end end})

-- Visuals Variables
local Visuals={
    GreenEggSphere=false,
    BlueCatchBox=false,
    BallLandingPredictor=false,
    ESPBall=false,
    BoxOutline=false,
    TargetMarker=false,
    NameTags=false
}

-- Visuals Tab
VisualsTab:CreateToggle({Name="Green Egg Sphere",CurrentValue=false,Callback=function(v) Visuals.GreenEggSphere=v end})
VisualsTab:CreateToggle({Name="Blue Catch Box",CurrentValue=false,Callback=function(v) Visuals.BlueCatchBox=v end})
VisualsTab:CreateToggle({Name="Ball Landing Predictor",CurrentValue=false,Callback=function(v) Visuals.BallLandingPredictor=v end})
VisualsTab:CreateToggle({Name="ESP Ball",CurrentValue=false,Callback=function(v) Visuals.ESPBall=v end})
VisualsTab:CreateToggle({Name="Box Outline",CurrentValue=false,Callback=function(v) Visuals.BoxOutline=v end})
VisualsTab:CreateToggle({Name="Target Marker",CurrentValue=false,Callback=function(v) Visuals.TargetMarker=v end})
VisualsTab:CreateToggle({Name="Name Tags",CurrentValue=false,Callback=function(v) Visuals.NameTags=v end})

-- Helper Functions
local function ClearVisuals(ball)
    for _, v in pairs(ball:GetChildren()) do
        if v.Name == "StarHubVisual" then
            v:Destroy()
        end
    end
end

local function CreateSphere(ball,color,radius)
    local sphere=Instance.new("Part")
    sphere.Shape=Enum.PartType.Ball
    sphere.Anchored=true
    sphere.CanCollide=false
    sphere.Transparency=0.4
    sphere.Color=color
    sphere.Size=Vector3.new(radius,radius,radius)
    sphere.CFrame=ball.CFrame
    sphere.Name="StarHubVisual"
    sphere.Parent=ball
    return sphere
end

local function CreateBox(ball,color,size)
    local box=Instance.new("Part")
    box.Size=size
    box.Anchored=true
    box.CanCollide=false
    box.Transparency=0.4
    box.Color=color
    box.CFrame=ball.CFrame
    box.Name="StarHubVisual"
    box.Parent=ball
    return box
end

-- Ball Landing Predictor as green line
local function CreateBallLanding(ball)
    local startPos = ball.Position
    local velocity = ball.AssemblyLinearVelocity
    local stepTime = 0.05
    local maxSteps = 200
    local finalPos = startPos

    for i = 1, maxSteps do
        finalPos = finalPos + velocity * stepTime
        velocity = velocity + Vector3.new(0, -Workspace.Gravity * stepTime, 0)
        local rayOrigin = finalPos
        local rayDirection = Vector3.new(0, -5, 0)
        local raycastResult = Workspace:Raycast(rayOrigin, rayDirection)
        if raycastResult then
            -- Create green line from ball to predicted landing
            local distance = (raycastResult.Position - startPos).Magnitude
            local line = Instance.new("Part")
            line.Size = Vector3.new(0.2, distance, 0.2)
            line.Anchored = true
            line.CanCollide = false
            line.Color = Color3.fromRGB(0,255,0)
            line.CFrame = CFrame.new(startPos, raycastResult.Position) * CFrame.new(0, -distance/2, 0)
            line.Name = "StarHubVisual"
            line.Parent = Workspace
            break
        end
    end
end

local function CreateESPBall(ball)
    local espPart = ball:FindFirstChild("StarHubVisual")
    if not espPart then
        local marker = Instance.new("Part")
        marker.Size = Vector3.new(2,2,2)
        marker.Anchored = true
        marker.CanCollide = false
        marker.Transparency = 0.3
        marker.Color = Color3.fromRGB(255,0,0)
        marker.CFrame = ball.CFrame
        marker.Name = "StarHubVisual"
        marker.Parent = ball
    end
end

local function CreateBoxOutline(ball)
    local outline = Instance.new("BoxHandleAdornment")
    outline.Adornee = ball
    outline.Size = ball.Size
    outline.Color3 = Color3.fromRGB(255,255,255)
    outline.AlwaysOnTop = true
    outline.ZIndex = 10
    outline.Transparency = 0.5
    outline.Name = "StarHubVisual"
    outline.Parent = ball
end

local function CreateTargetMarker(ball)
    local marker = Instance.new("Part")
    marker.Size = Vector3.new(2,2,2)
    marker.Anchored = true
    marker.CanCollide = false
    marker.Transparency = 0.3
    marker.Color = Color3.fromRGB(255,0,255)
    marker.CFrame = ball.CFrame + Vector3.new(0,5,0)
    marker.Name = "StarHubVisual"
    marker.Parent = ball
end

local function CreateNameTag(ball)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0,100,0,50)
    billboard.Adornee = ball
    local label = Instance.new("TextLabel")
    label.Text = ball.Name
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1,0,1,0)
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Parent = billboard
    billboard.Name = "StarHubVisual"
    billboard.Parent = ball
end

-- RenderStepped for Visuals
RunService.RenderStepped:Connect(function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name == "StarHubVisual" and not v:IsDescendantOf(LocalPlayer.Character) then
            v:Destroy()
        end
    end

    for _, ball in pairs(Workspace:GetDescendants()) do
        if ball:IsA("BasePart") and ball.Name:lower():find("ball") then
            ClearVisuals(ball)
            if Visuals.GreenEggSphere then CreateSphere(ball,Color3.fromRGB(0,255,0),5) end
            if Visuals.BlueCatchBox then CreateBox(ball,Color3.fromRGB(0,0,255),Vector3.new(10,10,10)) end
            if Visuals.BallLandingPredictor then CreateBallLanding(ball) end
            if Visuals.ESPBall then CreateESPBall(ball) end
            if Visuals.BoxOutline then CreateBoxOutline(ball) end
            if Visuals.TargetMarker then CreateTargetMarker(ball) end
            if Visuals.NameTags then CreateNameTag(ball) end
        end
    end
end)
