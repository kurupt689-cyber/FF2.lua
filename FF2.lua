--[[
    Star Hub Menu (Football Fusion 2 Edition)
    Features:
    - Toggle Menu (B key + button top right)
    - Categories: Catching, Visuals, Contributors, About
    - Auto Catch, Magnet, Freeze Tech, Ball ESP, Ball Follower, Path Visualizer, Glow Trail
    - Rainbow contributor/credit text
    - Wavy red + black theme
    - Draggable GUI top-left corner
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local guiToggled = true

-- Settings
local settingsKey = "FF2_Settings"
local settings = {
    magnet = true,
    autoCatch = true,
    angle = true,
    freezeTech = false,
    freezeTime = 2,
    esp = true,
    path = true,
    follower = true,
    glowTrail = true,
    range = 20
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

-- Main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StarHub_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Name = "MainMenu"

-- Wavy red background
RunService.RenderStepped:Connect(function(step)
    local wave = math.sin(tick()*2)*0.3 + 0.7
    mainFrame.BackgroundColor3 = Color3.new(0.5+0.3*wave,0,0)
end)

-- Category Buttons Frame
local catFrame = Instance.new("Frame", mainFrame)
catFrame.Size = UDim2.new(1, 0, 0, 40)
catFrame.Position = UDim2.new(0,0,0,0)
catFrame.BackgroundTransparency = 1

local categories = {"Catching","Visuals","Contributors","About"}
local catContent = {}
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -10, 1, -50)
contentFrame.Position = UDim2.new(0,5,0,45)
contentFrame.BackgroundTransparency = 1
local yOffset = 10

-- Rainbow Text helper
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

-- Clear content helper
local function clearContent()
    for _,v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
end

-- Catching Category
catContent["Catching"] = function()
    yOffset = 10
    local function createToggle(name, default, callback)
        local button = Instance.new("TextButton", contentFrame)
        button.Size = UDim2.new(1, -10, 0, 30)
        button.Position = UDim2.new(0, 5, 0, yOffset)
        button.Text = name .. ": " .. (default and "ON" or "OFF")
        button.BackgroundColor3 = Color3.fromRGB(25,0,0)
        button.TextColor3 = Color3.new(1,1,1)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.MouseButton1Click:Connect(function()
            default = not default
            button.Text = name .. ": " .. (default and "ON" or "OFF")
            callback(default)
            saveSettings()
        end)
        yOffset = yOffset + 35
    end

    local function createSliderBox(name, initialValue, minVal, maxVal, callback)
        local box = Instance.new("TextBox", contentFrame)
        box.Position = UDim2.new(0, 5, 0, yOffset)
        box.Size = UDim2.new(1, -10, 0, 30)
        box.Text = name .. ": " .. tostring(initialValue)
        box.BackgroundColor3 = Color3.fromRGB(15,0,0)
        box.TextColor3 = Color3.new(1,1,1)
        box.ClearTextOnFocus = true
        box.Font = Enum.Font.Gotham
        box.TextSize = 14
        box.FocusLost:Connect(function()
            local val = tonumber(box.Text:match("%d+"))
            if val then
                val = math.clamp(val, minVal, maxVal)
                box.Text = name .. ": " .. val
                callback(val)
                saveSettings()
            else
                box.Text = name .. ": " .. tostring(initialValue)
            end
        end)
        yOffset = yOffset + 35
        return box
    end

    createToggle("Magnet", settings.magnet, function(state) settings.magnet = state end)
    createToggle("Auto Catch", settings.autoCatch, function(state) settings.autoCatch = state end)
    createToggle("Angle Enhancer", settings.angle, function(state) settings.angle = state end)
    createToggle("Freeze Tech", settings.freezeTech, function(state) settings.freezeTech = state end)
    createSliderBox("Magnet Range", settings.range, 5, 80, function(val) settings.range = val end)
    createSliderBox("Freeze Time (s)", settings.freezeTime, 1, 5, function(val) settings.freezeTime = val end)
end

-- Visuals Category
catContent["Visuals"] = function()
    yOffset = 10
    local function createToggle(name, default, callback)
        local button = Instance.new("TextButton", contentFrame)
        button.Size = UDim2.new(1, -10, 0, 30)
        button.Position = UDim2.new(0, 5, 0, yOffset)
        button.Text = name .. ": " .. (default and "ON" or "OFF")
        button.BackgroundColor3 = Color3.fromRGB(20,0,0)
        button.TextColor3 = Color3.new(1,1,1)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.MouseButton1Click:Connect(function()
            default = not default
            button.Text = name .. ": " .. (default and "ON" or "OFF")
            if callback then callback(default) end
        end)
        yOffset = yOffset + 35
    end

    createToggle("Ball ESP", settings.esp)
    createToggle("Ball Follower", settings.follower)
    createToggle("Path Visualizer", settings.path)
    createToggle("Glow Trail", settings.glowTrail)
end

-- Contributors
catContent["Contributors"] = function()
    yOffset = 10
    local title = Instance.new("TextLabel", contentFrame)
    title.Size = UDim2.new(1,0,0,40)
    title.Position = UDim2.new(0,0,0,yOffset)
    title.Text = "STAR HUB"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.BackgroundTransparency = 1
    rainbowText(title)
    yOffset = yOffset + 50

    local owner = Instance.new("TextLabel", contentFrame)
    owner.Size = UDim2.new(1,0,0,30)
    owner.Position = UDim2.new(0,0,0,yOffset)
    owner.Text = "Owner: Kurupt"
    owner.Font = Enum.Font.Gotham
    owner.TextSize = 16
    owner.BackgroundTransparency = 1
    rainbowText(owner)
end

-- About
catContent["About"] = function()
    yOffset = 10
    local about = Instance.new("TextLabel", contentFrame)
    about.Size = UDim2.new(1,0,0,60)
    about.Position = UDim2.new(0,0,0,yOffset)
    about.TextWrapped = true
    about.Text = "Welcome to Star Hub, newest and best FF2 script. We are a Roblox FF2 script making community. We provide scripts for yall to use. Remember at the time I, Kurupt, am the only dev. Cut some slack."
    about.Font = Enum.Font.Gotham
    about.TextSize = 14
    about.BackgroundTransparency = 1
    rainbowText(about)
    yOffset = yOffset + 70

    local warning = Instance.new("TextLabel", contentFrame)
    warning.Size = UDim2.new(1,0,0,30)
    warning.Position = UDim2.new(0,0,0,yOffset)
    warning.Text = "We are not responsible if you get banned"
    warning.Font = Enum.Font.GothamBold
    warning.TextSize = 14
    warning.TextColor3 = Color3.fromRGB(139,0,0)
    warning.BackgroundTransparency = 1
end

-- Create category buttons
local buttonX = 0
for i,catName in pairs(categories) do
    local btn = Instance.new("TextButton", catFrame)
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, buttonX, 0, 0)
    btn.Text = catName
    btn.BackgroundColor3 = Color3.fromRGB(50,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        clearContent()
        catContent[catName]()
    end)
    buttonX = buttonX + 125
end

-- Initialize default category
catContent["Catching"]()

-- GUI Toggle Key (B)
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.B then
        guiToggled = not guiToggled
        mainFrame.Visible = guiToggled
    end
end)

-- Toggle Menu Button top-right (black)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleMenuButton"
toggleBtn.Text = "Star Hub"
toggleBtn.Size = UDim2.new(0, 120, 0, 35)
toggleBtn.Position = UDim2.new(1, -130, 0, 10)
toggleBtn.AnchorPoint = Vector2.new(0, 0)
toggleBtn.Parent = screenGui
toggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleBtn.BackgroundTransparency = 0
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.MouseButton1Click:Connect(function()
    guiToggled = not guiToggled
    mainFrame.Visible = guiToggled
end)

-- Auto Catch + Freeze Tech
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
                task.delay(settings.freezeTime, function()
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Anchored = false
                    end
                end)
            end
        end
    end
end)

-- Ball ESP / Follower / Path / Glow
local ballFollower = nil
local ballTrail = nil

RunService.RenderStepped:Connect(function()
    local ball = workspace:FindFirstChild("Football")
    if not ball then return end

    -- Ball ESP
    if settings.esp and not ball:FindFirstChild("Highlight") then
        local h = Instance.new("Highlight", ball)
        h.FillColor = Color3.fromRGB(0,255,255)
        h.OutlineColor = Color3.fromRGB(0,0,255)
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    end

    -- Ball Follower
    if settings.follower then
        if not ballFollower then
            ballFollower = Instance.new("Part", workspace)
            ballFollower.Size = Vector3.new(2,0.2,2)
            ballFollower.Anchored = true
            ballFollower.CanCollide = false
            ballFollower.Material = Enum.Material.Neon
            ballFollower.Color = Color3.fromRGB(0,255,255)
        end
        ballFollower.Position = ball.Position + Vector3.new(0,3,0)
    elseif ballFollower then
        ballFollower:Destroy()
        ballFollower = nil
    end

    -- Glow Trail
    if settings.glowTrail then
        if not ballTrail then
            ballTrail = Instance.new("Trail", ball)
            ballTrail.Attachment0 = Instance.new("Attachment", ball)
            ballTrail.Attachment1 = Instance.new("Attachment", ball)
            ballTrail.Lifetime = 0.3
            ballTrail.Color = ColorSequence.new(Color3.fromRGB(0,255,255))
            ballTrail.LightEmission = 1
        end
    elseif ballTrail then
        ballTrail:Destroy()
        ballTrail = nil
    end

    -- Path Visualizer
    if settings.path then
        if not ball:FindFirstChild("PathLine") then
            local pathPart = Instance.new("Part", workspace)
            pathPart.Name = "PathLine"
            pathPart.Anchored = true
            pathPart.CanCollide = false
            pathPart.Size = Vector3.new(0.2,0.2,5)
            pathPart.Material = Enum.Material.Neon
            pathPart.Color = Color3.fromRGB(0,255,255)
        end
        local path = ball:FindFirstChild("PathLine")
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local startPos = ball.Position
            local endPos = char.HumanoidRootPart.Position
            local dist = (endPos - startPos).Magnitude
            path.Size = Vector3.new(0.2,0.2,dist)
            path.CFrame = CFrame.new(startPos,endPos) * CFrame.new(0,0,-dist/2)
            path.Transparency = 0
        end
    end
end)

print("Star Hub Menu Loaded - Football Fusion 2 Edition")
