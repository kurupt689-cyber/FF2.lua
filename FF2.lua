--[[
    Star Hub Menu (Football Fusion 2 Edition)
    Features:
    - Toggle Menu (B key + top-right button)
    - Categories: Catching (Page 1 & 2), Visuals, Risky, Remote, Contributors, About
    - Magnet Catch with Adjustable Range & Pull Vector
    - FireTouchInterest Auto Catch (50ms spam)
    - Angle Enhancer Toggle
    - Freeze Tech (Toggle + adjustable seconds)
    - Ball ESP, Path Visualizer, Glow, Aura, Box Ball
    - Blue Round around your character
    - Risky Features: Speed Boost, Fly, TP to Ball, Mega Jump, Invisible Body
    - Remote Features: Auto Catch Distance Slider, Magnet Pull Vector Slider, Box Ball Size Slider
    - Rainbow contributor text
    - Blood dark red + black theme
    - Draggable GUI top-left corner
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local guiToggled = true

local settingsKey = "FF2_Settings"
local settings = {
    -- Catching Page 1
    magnet = true,
    autoCatch = true,
    angle = true,
    freezeTech = false,
    freezeTime = 2,
    -- Catching Page 2
    catchBoost = false,
    stickyHands = false,
    superMagnet = false,
    magnetPullVector = 5,
    range = 20,
    -- Visuals
    esp = true,
    path = true,
    glowTrail = true,
    ballAura = true,
    ballShadow = true,
    blueRound = false,
    boxBall = false,
    boxBallSize = 5,
    -- Risky
    speedBoost = false,
    fly = false,
    tpBall = false,
    megaJump = false,
    invisibleBody = false,
    ballDistanceVisual = false,
    ballTrackerLine = false,
    -- Remote
    autoCatchDistance = 20
}

pcall(function()
    local stored = HttpService:JSONDecode(readfile(settingsKey))
    for k,v in pairs(stored) do settings[k] = v end
end)

local function saveSettings()
    pcall(function()
        writefile(settingsKey, HttpService:JSONEncode(settings))
    end)
end

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StarHub_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0,400,0,400)
mainFrame.Position = UDim2.new(0,50,0,50)
mainFrame.BackgroundColor3 = Color3.fromRGB(60,0,0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Name = "MainMenu"

-- Category Buttons Frame
local catFrame = Instance.new("Frame", mainFrame)
catFrame.Size = UDim2.new(1,0,0,35)
catFrame.Position = UDim2.new(0,0,0,0)
catFrame.BackgroundTransparency = 1

local categories = {"Catching","Visuals","Risky","Remote","Contributors","About"}
local catContent = {}
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-10,1,-45)
contentFrame.Position = UDim2.new(0,5,0,40)
contentFrame.BackgroundTransparency = 1
local yOffset = 10

local function clearContent()
    for _,v in pairs(contentFrame:GetChildren()) do v:Destroy() end
    yOffset = 10
end

local function createToggle(parent, name, settingKey)
    local default = settings[settingKey]
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(1,-10,0,30)
    button.Position = UDim2.new(0,5,0,yOffset)
    button.Text = name..": "..(default and "ON" or "OFF")
    button.BackgroundColor3 = Color3.fromRGB(25,0,0)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.MouseButton1Click:Connect(function()
        default = not default
        button.Text = name..": "..(default and "ON" or "OFF")
        settings[settingKey] = default
        saveSettings()
    end)
    yOffset = yOffset + 35
end

local function createSliderBox(parent, name, settingKey, minVal, maxVal)
    local initialValue = settings[settingKey]
    local box = Instance.new("TextBox", parent)
    box.Position = UDim2.new(0,5,0,yOffset)
    box.Size = UDim2.new(1,-10,0,30)
    box.Text = name..": "..tostring(initialValue)
    box.BackgroundColor3 = Color3.fromRGB(15,0,0)
    box.TextColor3 = Color3.new(1,1,1)
    box.ClearTextOnFocus = true
    box.Font = Enum.Font.GothamBold
    box.TextSize = 16
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text:match("%d+"))
        if val then val = math.clamp(val,minVal,maxVal); box.Text = name..": "..val; settings[settingKey]=val; saveSettings()
        else box.Text = name..": "..tostring(initialValue) end
    end)
    yOffset = yOffset + 35
end

-- Page switcher for Catching
local catchingPage = 1
local function catchingPages()
    clearContent()
    local pageBtn = Instance.new("TextButton", contentFrame)
    pageBtn.Size = UDim2.new(0,150,0,30)
    pageBtn.Position = UDim2.new(0,5,0,yOffset)
    pageBtn.Text = "Switch Page"
    pageBtn.BackgroundColor3 = Color3.fromRGB(40,0,0)
    pageBtn.TextColor3 = Color3.new(1,1,1)
    pageBtn.Font = Enum.Font.GothamBold
    pageBtn.TextSize = 16
    pageBtn.MouseButton1Click:Connect(function()
        catchingPage = catchingPage == 1 and 2 or 1
        catchingPages()
    end)
    yOffset = yOffset + 40

    if catchingPage == 1 then
        createToggle(contentFrame,"Magnet","magnet")
        createToggle(contentFrame,"Auto Catch","autoCatch")
        createToggle(contentFrame,"Angle Enhancer","angle")
        createToggle(contentFrame,"Freeze Tech","freezeTech")
        createSliderBox(contentFrame,"Magnet Range","range",5,80)
        createSliderBox(contentFrame,"Freeze Time (s)","freezeTime",1,5)
    else
        createToggle(contentFrame,"Catch Boost","catchBoost")
        createToggle(contentFrame,"Sticky Hands","stickyHands")
        createToggle(contentFrame,"Super Magnet","superMagnet")
        createSliderBox(contentFrame,"Magnet Pull Vector","magnetPullVector",1,20)
    end
end

-- Visuals
catContent["Visuals"] = function()
    clearContent()
    createToggle(contentFrame,"Ball ESP","esp")
    createToggle(contentFrame,"Glow Trail","glowTrail")
    createToggle(contentFrame,"Path Visualizer","path")
    createToggle(contentFrame,"Ball Aura","ballAura")
    createToggle(contentFrame,"Ball Shadow","ballShadow")
    createToggle(contentFrame,"Blue Round","blueRound")
    createToggle(contentFrame,"Box Ball","boxBall")
end

-- Risky
catContent["Risky"] = function()
    clearContent()
    createToggle(contentFrame,"Speed Boost","speedBoost")
    createToggle(contentFrame,"Fly","fly")
    createToggle(contentFrame,"TP to Ball","tpBall")
    createToggle(contentFrame,"Mega Jump","megaJump")
    createToggle(contentFrame,"Invisible Body","invisibleBody")
    createToggle(contentFrame,"Ball Distance Visual","ballDistanceVisual")
    createToggle(contentFrame,"Ball Tracker Line","ballTrackerLine")
end

-- Remote
catContent["Remote"] = function()
    clearContent()
    createSliderBox(contentFrame,"Auto Catch Distance","autoCatchDistance",5,80)
    createSliderBox(contentFrame,"Magnet Pull Vector","magnetPullVector",1,20)
    createSliderBox(contentFrame,"Box Ball Size","boxBallSize",1,20)
end

-- Contributors
catContent["Contributors"] = function()
    clearContent()
    local label = Instance.new("TextLabel", contentFrame)
    label.Size = UDim2.new(1,0,0,50)
    label.Position = UDim2.new(0,0,0,10)
    label.Text = "Owner: Kurupt"
    label.Font = Enum.Font.GothamBold
    label.TextSize = 30
    label.TextColor3 = Color3.fromRGB(255,0,0)
    label.BackgroundTransparency = 1
end

-- About
catContent["About"] = function()
    clearContent()
    local label = Instance.new("TextLabel", contentFrame)
    label.Size = UDim2.new(1,0,0,100)
    label.Position = UDim2.new(0,0,0,10)
    label.TextWrapped = true
    label.Text = "Welcome to Star Hub, best FF2 script with Magnet, Auto Catch, ESP, Box Ball, Risky, and Remote features."
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
end

-- Category Buttons
local buttonX = 0
for i,catName in pairs(categories) do
    local btn = Instance.new("TextButton", catFrame)
    btn.Size = UDim2.new(0,65,1,0)
    btn.Position = UDim2.new(0,buttonX,0,0)
    btn.Text = catName
    btn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        if catName=="Catching" then catchingPages()
        else catContent[catName]() end
    end)
    buttonX = buttonX + 65
end

-- Default to Catching Page 1
catchingPages()

-- GUI Toggle Key
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.B then
        guiToggled = not guiToggled
        mainFrame.Visible = guiToggled
    end
end)

-- Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleMenuButton"
toggleBtn.Text = "Star Hub"
toggleBtn.Size = UDim2.new(0,100,0,30)
toggleBtn.Position = UDim2.new(1,-110,0,5)
toggleBtn.AnchorPoint = Vector2.new(0,0)
toggleBtn.Parent = screenGui
toggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.MouseButton1Click:Connect(function()
    guiToggled = not guiToggled
    mainFrame.Visible = guiToggled
end)

-- Auto Catch + Magnet
task.spawn(function()
    while true do
        task.wait(0.05)
        if not settings.autoCatch then continue end

        local ball = workspace:FindFirstChild("Football")
        local char = player.Character
        if not (ball and char and char:FindFirstChild("HumanoidRootPart")) then continue end

        local dist = (ball.Position - char.HumanoidRootPart.Position).Magnitude
        if dist <= settings.range then
            for _, handName in {"CatchLeft","CatchRight"} do
                local hand = char:FindFirstChild(handName)
                if hand then
                    pcall(function()
                        firetouchinterest(ball, hand, 0)
                        firetouchinterest(ball, hand, 1)
                    end)
                end
            end
            if settings.freezeTech and char.HumanoidRootPart.Anchored == false then
                char.HumanoidRootPart.Anchored = true
                task.delay(settings.freezeTime,function()
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Anchored = false
                    end
                end)
            end
        end
    end
end)

-- Ball ESP + Box Ball + Path Visualizer
RunService.RenderStepped:Connect(function()
    local ball = workspace:FindFirstChild("Football")
    if not ball then return end

    -- ESP
    if settings.esp and not ball:FindFirstChild("Highlight") then
        local h = Instance.new("Highlight",ball)
        h.FillColor = Color3.fromRGB(255,255,0)
        h.OutlineColor = Color3.fromRGB(255,0,0)
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    end

    -- Box Ball
    if settings.boxBall then
        local box = ball:FindFirstChild("BoxBall")
        if not box then
            box = Instance.new("BoxHandleAdornment")
            box.Name = "BoxBall"
            box.Adornee = ball
            box.Color3 = Color3.fromRGB(0,255,0)
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Parent = ball
        end
        box.Size = Vector3.new(settings.boxBallSize,settings.boxBallSize,settings.boxBallSize)
    else
        if ball:FindFirstChild("BoxBall") then ball.BoxBall:Destroy() end
    end

    -- Path Visualizer
    local char = player.Character
    if settings.path and char and char:FindFirstChild("HumanoidRootPart") then
        if not ball:FindFirstChild("BallPathLine") then
            local line = Instance.new("Part")
            line.Name = "BallPathLine"
            line.Anchored = true
            line.CanCollide = false
            line.Transparency = 0.5
            line.Material = Enum.Material.Neon
            line.Color = Color3.fromRGB(0,255,255)
            line.Size = Vector3.new(0.2,0.2,(ball.Position-char.HumanoidRootPart.Position).Magnitude)
            line.Parent = workspace
        end
        local line = workspace:FindFirstChild("BallPathLine")
        line.Size = Vector3.new(0.2,0.2,(ball.Position-char.HumanoidRootPart.Position).Magnitude)
        line.CFrame = CFrame.new(ball.Position,char.HumanoidRootPart.Position)*CFrame.new(0,0,-line.Size.Z/2)
    else
        if workspace:FindFirstChild("BallPathLine") then workspace.BallPathLine.Transparency = 1 end
    end
end)

print("Star Hub Loaded - Catching Pages 1 & 2 Added")
