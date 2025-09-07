-- Star Hub Menu - Massive Green Halo + Overpower Magnet
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Settings
local settings = {
    magnet = true,
    overpowerMagnet = false,
    autoCatch = true,
    angle = true,
    freezeTech = false,
    freezeTime = 2,
    esp = true,
    path = true,
    range = 20,
    catchLeft = true,
    catchRight = true,
    superKick=false,
    speedBoost=false,
    autoScore=false,
    instantPass=false,
    autoBlock=false,
    fastRespawn=false,
    greenHalo=true
}

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StarHub_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.5, -150, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "★ Star Hub ★"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

-- Scrolling frame
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1,0,1,-30)
scrollingFrame.Position = UDim2.new(0,0,0,30)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
scrollingFrame.Parent = frame

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.FillDirection = Enum.FillDirection.Vertical
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Padding = UDim.new(0,5)
scrollLayout.Parent = scrollingFrame

-- Categories
local categories = {"Catching","Visuals","Sliders","Automatics"}
local categoryFrames = {}

local categoryScripts = {
    Catching = {"Magnet","Overpower Magnet","Auto Catch","Angle Enhancer","Freeze Tech","Catch Left Hand","Catch Right Hand"},
    Visuals = {"Ball ESP","Ball Path","Massive Green Halo"},
    Sliders = {"Magnet Range","Freeze Time"},
    Automatics = {"Super Kick","Speed Boost","Auto Score","Instant Pass","Auto Block","Fast Respawn"}
}

-- Helpers
local function createToggleButton(parent,name,callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = name..": OFF"
    btn.Parent = parent
    local active=false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = name..": "..(active and "ON" or "OFF")
        callback(active)
    end)
end

local function createSlider(parent,name,min,max,default,callback)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,-10,0,30)
    box.BackgroundColor3 = Color3.fromRGB(60,60,60)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Text = name..": "..default
    box.ClearTextOnFocus = true
    box.Parent = parent
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text:match("%d+"))
        if val then
            val = math.clamp(val,min,max)
            box.Text=name..": "..val
            callback(val)
        else
            box.Text=name..": "..default
        end
    end)
end

-- Create categories
for _,catName in ipairs(categories) do
    local catBtn = Instance.new("TextButton")
    catBtn.Size = UDim2.new(1,-20,0,30)
    catBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    catBtn.TextColor3 = Color3.new(1,1,1)
    catBtn.Font = Enum.Font.GothamBold
    catBtn.TextSize = 16
    catBtn.Text = catName.." ▼"
    catBtn.Parent = scrollingFrame

    local catFrame = Instance.new("Frame")
    catFrame.Size = UDim2.new(1,-20,0,0)
    catFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    catFrame.BorderSizePixel = 0
    catFrame.ClipsDescendants = true
    catFrame.Parent = scrollingFrame

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,5)
    layout.Parent = catFrame

    categoryFrames[catName] = {button=catBtn,frame=catFrame,open=false}

    catBtn.MouseButton1Click:Connect(function()
        for name,cat in pairs(categoryFrames) do
            if name==catName then
                cat.open = not cat.open
                cat.button.Text = name..(cat.open and " ▲" or " ▼")
                local count = #categoryScripts[name]
                cat.frame.Size = UDim2.new(1,-20,0,cat.open and count*35 + 10 or 0)
            else
                cat.open=false
                cat.button.Text=name.." ▼"
                cat.frame.Size=UDim2.new(1,-20,0,0)
            end
        end
        scrollingFrame.CanvasSize = UDim2.new(0,0,0,scrollLayout.AbsoluteContentSize.Y)
    end)

    for _,scriptName in ipairs(categoryScripts[catName]) do
        if catName=="Sliders" then
            if scriptName=="Magnet Range" then
                createSlider(catFrame,scriptName,5,80,settings.range,function(val) settings.range=val end)
            elseif scriptName=="Freeze Time" then
                createSlider(catFrame,scriptName,1,5,settings.freezeTime,function(val) settings.freezeTime=val end)
            end
        else
            createToggleButton(catFrame,scriptName,function(active)
                if catName=="Catching" then
                    if scriptName=="Magnet" then settings.magnet=active
                    elseif scriptName=="Overpower Magnet" then settings.overpowerMagnet=active
                    elseif scriptName=="Auto Catch" then settings.autoCatch=active
                    elseif scriptName=="Angle Enhancer" then settings.angle=active
                    elseif scriptName=="Freeze Tech" then settings.freezeTech=active
                    elseif scriptName=="Catch Left Hand" then settings.catchLeft=active
                    elseif scriptName=="Catch Right Hand" then settings.catchRight=active
                    end
                elseif catName=="Visuals" then
                    if scriptName=="Ball ESP" then settings.esp=active
                    elseif scriptName=="Ball Path" then settings.path=active
                    elseif scriptName=="Massive Green Halo" then settings.greenHalo=active
                    end
                elseif catName=="Automatics" then
                    if scriptName=="Super Kick" then settings.superKick=active
                    elseif scriptName=="Speed Boost" then settings.speedBoost=active
                    elseif scriptName=="Auto Score" then settings.autoScore=active
                    elseif scriptName=="Instant Pass" then settings.instantPass=active
                    elseif scriptName=="Auto Block" then settings.autoBlock=active
                    elseif scriptName=="Fast Respawn" then settings.fastRespawn=active
                    end
                end
            end)
        end
    end
end

-- Catching & Magnet / Overpower Magnet
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local ball = workspace:FindFirstChild("Football")
    if not ball then return end
    local root = char.HumanoidRootPart
    local dist = (ball.Position - root.Position).Magnitude

    -- Normal Magnet
    if settings.magnet and dist <= settings.range then
        root.CFrame = CFrame.new(ball.Position)
    end

    -- Overpower Magnet (crazy magnet)
    if settings.overpowerMagnet then
        local allBalls = workspace:GetChildren()
        for _,b in pairs(allBalls) do
            if b:IsA("BasePart") and b.Name=="Football" then
                b.Position = b.Position:Lerp(root.Position,0.2) -- crazy fast attraction
            end
        end
    end

    -- Auto Catch + Freeze Tech
    if settings.autoCatch and dist <= settings.range then
        for _,handName in pairs({"CatchLeft","CatchRight"}) do
            if (handName=="CatchLeft" and settings.catchLeft) or (handName=="CatchRight" and settings.catchRight) then
                local hand = char:FindFirstChild(handName)
                if hand then
                    pcall(function()
                        firetouchinterest(ball,hand,0)
                        firetouchinterest(ball,hand,1)
                    end)
                end
            end
        end
        if settings.freezeTech and not root.Anchored then
            root.Anchored=true
            task.delay(settings.freezeTime,function()
                if root then root.Anchored=false end
            end)
        end
    end
end)

-- Visuals: Ball ESP, Path, Massive Green Halo
local beam = Instance.new("Beam")
local att0 = Instance.new("Attachment")
local att1 = Instance.new("Attachment")
beam.Attachment0 = att0
beam.Attachment1 = att1
beam.Color = ColorSequence.new(Color3.fromRGB(0,255,255))
beam.Width0 = 0.2
beam.Width1 = 0.2
beam.FaceCamera=true
beam.LightEmission=1
beam.Parent = workspace
att0.Parent = workspace
att1.Parent = workspace

local halo = nil

RunService.RenderStepped:Connect(function()
    local char = player.Character
    local ball = workspace:FindFirstChild("Football")
    if ball and settings.esp then
        if not ball:FindFirstChild("Highlight") then
            local h=Instance.new("Highlight",ball)
            h.FillColor=Color3.fromRGB(255,255,0)
            h.OutlineColor=Color3.fromRGB(255,0,0)
            h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        end
    end
    if ball and char and char:FindFirstChild("HumanoidRootPart") then
        -- Ball path
        if settings.path then
            att0.WorldPosition=ball.Position
            att1.WorldPosition=char.HumanoidRootPart.Position
            beam.Transparency=NumberSequence.new(0)
        else
            beam.Transparency=NumberSequence.new(1)
        end

        -- Massive Green Halo visual
        if settings.greenHalo then
            if not halo then
                halo = Instance.new("Part")
                halo.Name = "MassiveGreenHalo"
                halo.Anchored = true
                halo.CanCollide = false
                halo.Material = Enum.Material.Neon
                halo.Color = Color3.fromRGB(0,255,0)
                halo.Shape = Enum.PartType.Ball
                halo.Size = Vector3.new(20,20,20) -- MASSIVE halo
                halo.Parent = workspace
            end
            halo.CFrame = CFrame.new(ball.Position)
            halo.Transparency = 0.6
        elseif halo then
            halo.Transparency = 1
        end
    end
end)

-- GUI toggle
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.B then
        frame.Visible = not frame.Visible
    end
end)

-- Top-right toggle button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,100,0,30)
toggleBtn.Position = UDim2.new(1,-110,0,10)
toggleBtn.Text = "Toggle Menu"
toggleBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 14
toggleBtn.Parent = screenGui
toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

print("Star Hub Loaded - Massive Halo + Overpower Magnet")
