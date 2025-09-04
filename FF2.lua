--[[
    Star Hub Menu (Football Fusion 2 Edition)
    Features:
    - Toggle Menu (B key + top-right button)
    - Categories: Catching (Page 1 & 2), Visuals, Contributors, About
    - Magnet Catch with Adjustable Range
    - FireTouchInterest Auto Catch (50ms spam)
    - Angle Enhancer Toggle
    - Freeze Tech (Toggle + adjustable seconds)
    - Ball ESP, Path Visualizer, Glow, Aura
    - Blue Round around your character
    - Rainbow contributor text
    - Blood dark red + black theme
    - Draggable GUI top-left corner
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local guiToggled = true
local settingsKey = "FF2_Settings"
local settings = {
    magnet = true,
    autoCatch = true,
    angle = true,
    freezeTech = false,
    freezeTime = 2,
    esp = true,
    path = true,
    glowTrail = true,
    ballAura = true,
    ballShadow = true,
    range = 20,
    blueRound = false,
    catchBoost = false,
    stickyHands = false,
    superMagnet = false
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

-- Wavy background
RunService.RenderStepped:Connect(function()
    local wave = math.sin(tick()*2)*0.2 + 0.8
    mainFrame.BackgroundColor3 = Color3.new(0.2+0.3*wave,0,0)
end)

-- Category Buttons
local catFrame = Instance.new("Frame", mainFrame)
catFrame.Size = UDim2.new(1,0,0,35)
catFrame.Position = UDim2.new(0,0,0,0)
catFrame.BackgroundTransparency = 1

local categories = {"Catching","Visuals","Contributors","About"}
local catContent = {}
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-10,1,-45)
contentFrame.Position = UDim2.new(0,5,0,40)
contentFrame.BackgroundTransparency = 1
local yOffset = 10

local function rainbowText(label)
    task.spawn(function()
        while label and label.Parent do
            for i=1,360,5 do
                label.TextColor3 = Color3.fromHSV(i/360,1,1)
                task.wait(0.05)
            end
        end
    end)
end

local function clearContent()
    for _,v in pairs(contentFrame:GetChildren()) do v:Destroy() end
end

-- Utility functions
local function createToggle(parent, name, default, callback)
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
        callback(default)
        saveSettings()
    end)
    yOffset = yOffset + 35
end

local function createSliderBox(parent, name, initialValue, minVal, maxVal, callback)
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
        if val then val = math.clamp(val,minVal,maxVal); box.Text = name..": "..val; callback(val); saveSettings()
        else box.Text = name..": "..tostring(initialValue) end
    end)
    yOffset = yOffset + 35
end

-- Catching Pages
local catchingPage = 1
local function loadCatchingPage(page)
    clearContent()
    yOffset = 50

    local prevBtn = Instance.new("TextButton", contentFrame)
    prevBtn.Size = UDim2.new(0.45,0,0,30)
    prevBtn.Position = UDim2.new(0,5,0,5)
    prevBtn.Text = "< Page 1"
    prevBtn.BackgroundColor3 = Color3.fromRGB(40,0,0)
    prevBtn.TextColor3 = Color3.new(1,1,1)
    prevBtn.Font = Enum.Font.GothamBold
    prevBtn.TextSize = 16
    prevBtn.MouseButton1Click:Connect(function()
        catchingPage = 1
        loadCatchingPage(catchingPage)
    end)

    local nextBtn = Instance.new("TextButton", contentFrame)
    nextBtn.Size = UDim2.new(0.45,0,0,30)
    nextBtn.Position = UDim2.new(1,-5,0,5)
    nextBtn.AnchorPoint = Vector2.new(1,0)
    nextBtn.Text = "Page 2 >"
    nextBtn.BackgroundColor3 = Color3.fromRGB(40,0,0)
    nextBtn.TextColor3 = Color3.new(1,1,1)
    nextBtn.Font = Enum.Font.GothamBold
    nextBtn.TextSize = 16
    nextBtn.MouseButton1Click:Connect(function()
        catchingPage = 2
        loadCatchingPage(catchingPage)
    end)

    if page == 1 then
        createToggle(contentFrame,"Magnet",settings.magnet,function(state) settings.magnet=state end)
        createToggle(contentFrame,"Auto Catch",settings.autoCatch,function(state) settings.autoCatch=state end)
        createToggle(contentFrame,"Angle Enhancer",settings.angle,function(state) settings.angle=state end)
        createToggle(contentFrame,"Freeze Tech",settings.freezeTech,function(state) settings.freezeTech=state end)
        createSliderBox(contentFrame,"Magnet Range",settings.range,5,80,function(val) settings.range=val end)
    elseif page == 2 then
        createSliderBox(contentFrame,"Freeze Time (s)",settings.freezeTime,1,5,function(val) settings.freezeTime=val end)
        createToggle(contentFrame,"Catch Boost",settings.catchBoost,function(state) settings.catchBoost=state end)
        createToggle(contentFrame,"Sticky Hands",settings.stickyHands,function(state) settings.stickyHands=state end)
        createToggle(contentFrame,"Super Magnet",settings.superMagnet,function(state) settings.superMagnet=state end)
    end
end

-- Visuals
catContent["Visuals"] = function()
    clearContent()
    yOffset = 10
    local function createVisualToggle(name,settingKey)
        local default = settings[settingKey]
        local button = Instance.new("TextButton", contentFrame)
        button.Size = UDim2.new(1,-10,0,30)
        button.Position = UDim2.new(0,5,0,yOffset)
        button.Text = name..": "..(default and "ON" or "OFF")
        button.BackgroundColor3 = Color3.fromRGB(20,0,0)
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

    createVisualToggle("Ball ESP","esp")
    createVisualToggle("Glow Trail","glowTrail")
    createVisualToggle("Path Visualizer","path")
    createVisualToggle("Ball Aura","ballAura")
    createVisualToggle("Ball Shadow","ballShadow")
    createVisualToggle("Blue Round","blueRound")
end

-- Contributors
catContent["Contributors"] = function()
    clearContent()
    yOffset = 10
    local title = Instance.new("TextLabel", contentFrame)
    title.Size = UDim2.new(1,0,0,60)
    title.Position = UDim2.new(0,0,0,yOffset)
    title.Text = "STAR HUB"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 40
    title.BackgroundTransparency = 1
    rainbowText(title)
    yOffset = yOffset + 70

    local owner = Instance.new("TextLabel", contentFrame)
    owner.Size = UDim2.new(1,0,0,50)
    owner.Position = UDim2.new(0,0,0,yOffset)
    owner.Text = "Owner: Kurupt"
    owner.Font = Enum.Font.GothamBold
    owner.TextSize = 30
    owner.BackgroundTransparency = 1
    rainbowText(owner)
end

-- About
catContent["About"] = function()
    clearContent()
    yOffset = 10
    local about = Instance.new("TextLabel", contentFrame)
    about.Size = UDim2.new(1,0,0,100)
    about.Position = UDim2.new(0,0,0,yOffset)
    about.TextWrapped = true
    about.Text = "Welcome to Star Hub, best FF2 script. We provide top features for Magnet, Auto Catch, ESP, Freeze Tech, and more. Use responsibly."
    about.Font = Enum.Font.GothamBold
    about.TextSize = 18
    about.BackgroundTransparency = 1
    rainbowText(about)
end

-- Create category buttons
local buttonX = 0
for i,catName in pairs(categories) do
    local btn = Instance.new("TextButton", catFrame)
    btn.Size = UDim2.new(0,90,1,0)
    btn.Position = UDim2.new(0,buttonX,0,0)
    btn.Text = catName
    btn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        if catName=="Catching" then loadCatchingPage(1)
        else catContent[catName]() end
    end)
    buttonX = buttonX + 95
end

-- Initialize default category
loadCatchingPage(1)

-- GUI Toggle Key (B)
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.B then
        guiToggled = not guiToggled
        mainFrame.Visible = guiToggled
    end
end)

-- Toggle Menu Button top-right
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

-- Magnet + Auto Catch + Freeze Tech
task.spawn(function()
    while true do
        task.wait(0.05)
        local char = player.Character
        local ball = workspace:FindFirstChild("Football")
        if not (char and ball and char:FindFirstChild("HumanoidRootPart")) then continue end
        local dist = (ball.Position - char.HumanoidRootPart.Position).Magnitude

        if settings.autoCatch and dist <= settings.range then
            for _,handName in {"CatchLeft","CatchRight"} do
                local hand = char:FindFirstChild(handName)
                if hand then
                    pcall(function()
                        firetouchinterest(ball,hand,0)
                        firetouchinterest(ball,hand,1)
                    end)
                end
            end
        end

        if settings.freezeTech and dist <= settings.range and char.HumanoidRootPart.Anchored==false then
            char.HumanoidRootPart.Anchored = true
            task.delay(settings.freezeTime,function()
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.Anchored = false
                end
            end)
        end
    end
end)

-- Visuals: Ball ESP, Path, Glow, Aura, Blue Round
local ballTrail=nil
local ballAura=nil
local ballShadow=nil
local ballPathLine=nil
local blueRound=nil

RunService.RenderStepped:Connect(function()
    local ball = workspace:FindFirstChild("Football")
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Ball ESP
    if settings.esp and ball and not ball:FindFirstChild("Highlight") then
        local h=Instance.new("Highlight",ball)
        h.FillColor=Color3.fromRGB(255,0,0)
        h.OutlineColor=Color3.fromRGB(255,255,0)
        h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    end

    -- Glow Trail
    if settings.glowTrail and ball then
        if not ballTrail then
            ballTrail = Instance.new("Trail",ball)
            local att0 = Instance.new("Attachment",ball)
            local att1 = Instance.new("Attachment",ball)
            ballTrail.Attachment0=att0
            ballTrail.Attachment1=att1
            ballTrail.Lifetime=0.3
            ballTrail.Color=ColorSequence.new(Color3.fromRGB(255,0,0))
            ballTrail.LightEmission=1
        end
    elseif ballTrail and not settings.glowTrail then ballTrail:Destroy(); ballTrail=nil end

    -- Ball Aura
    if settings.ballAura and ball then
        if not ballAura then
            ballAura=Instance.new("PointLight",ball)
            ballAura.Color=Color3.fromRGB(255,0,0)
            ballAura.Range=10
            ballAura.Brightness=2
        end
    elseif ballAura and not settings.ballAura then ballAura:Destroy(); ballAura=nil end

    -- Ball Shadow
    if settings.ballShadow and ball then
        if not ballShadow then
            ballShadow=Instance.new("Part",workspace)
            ballShadow.Size=Vector3.new(3,0.1,3)
            ballShadow.Anchored=true
            ballShadow.CanCollide=false
            ballShadow.Material=Enum.Material.Neon
            ballShadow.Color=Color3.fromRGB(50,0,0)
        end
        ballShadow.Position=ball.Position-Vector3.new(0,ball.Size.Y/2,0)
    elseif ballShadow and not settings.ballShadow then ballShadow:Destroy(); ballShadow=nil end

    -- Path Visualizer
    if settings.path and ball then
        if not ballPathLine then
            ballPathLine=Instance.new("Part",workspace)
            ballPathLine.Name="BallPathLine"
            ballPathLine.Anchored=true
            ballPathLine.CanCollide=false
            ballPathLine.Size=Vector3.new(0.2,0.2,1)
            ballPathLine.Material=Enum.Material.Neon
            ballPathLine.Color=Color3.fromRGB(0,255,255)
        end
        local startPos=ball.Position
        local endPos=hrp.Position
        local dist=(endPos-startPos).Magnitude
        ballPathLine.Size=Vector3.new(0.2,0.2,dist)
        ballPathLine.CFrame=CFrame.new(startPos,endPos)*CFrame.new(0,0,-dist/2)
    elseif ballPathLine and not settings.path then ballPathLine:Destroy(); ballPathLine=nil end

    -- Blue Round around your character
    if settings.blueRound and hrp then
        if not blueRound then
            blueRound = Instance.new("Part",workspace)
            blueRound.Shape = Enum.PartType.Ball
            blueRound.Anchored = true
            blueRound.CanCollide = false
            blueRound.Material = Enum.Material.Neon
            blueRound.Color = Color3.fromRGB(0,0,255)
            blueRound.Transparency = 0.5
        end
        blueRound.Size = Vector3.new(6,6,6)
        blueRound.CFrame = hrp.CFrame
    elseif blueRound then
        blueRound:Destroy()
        blueRound=nil
    end
end)

print("Star Hub Menu Loaded - Football Fusion 2 Edition (ESP Fixed, Blue Round, Page2)")
