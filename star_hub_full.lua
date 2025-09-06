--<< Services >>--
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--<< Variables >>--
local Handshake = ReplicatedStorage.Remotes.CharacterSoundEvent
local Hooks = {}
local HandshakeInts = {}

for i, v in getgc() do
    if typeof(v) == "function" and islclosure(v) then
        if (#getprotos(v) == 1) and table.find(getconstants(getproto(v, 1)), 4000001) then
            hookfunction(v, function() end)
        end
    end
end

Hooks.__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}

    if not checkcaller() and (self == Handshake) and (Method == "fireServer") and (string.find(Args[1], "AC")) then
        if (#HandshakeInts == 0) then
            HandshakeInts = {table.unpack(Args[2], 2, 18)}
        else
            for i, v in HandshakeInts do
                Args[2][i + 1] = v
            end
        end
    end

    return Hooks.__namecall(self, ...)
end)

warn("")

if not LPH_OBFUSCATED then
    getfenv().LPH_NO_VIRTUALIZE = function(f) return f end
    getfenv().LPH_JIT_MAX = function(f) return f end
end

task.wait(0.3)

bypass = false


	bypass = true


local utility = {}
local UIS = game:GetService("UserInputService");
local RS = game:GetService("RunService");
local TS = game:GetService("TweenService");
local mouse = game:GetService('Players').LocalPlayer:GetMouse()

local Library = {}
local mainKeybind = "LeftControl"
local canDrag = true

function utility:ToRGB(color)  
	return color.R*255,color.G*255,color.B*255
end

local function CreateDrag(gui)
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		TS:Create(gui, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play();
	end

	local lastEnd = 0
	local lastMoved = 0
	local con
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not canDrag then return end
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

		end
	end)

	UIS.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)


	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
			lastMoved = os.clock()
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

local tweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local tweenInfo2 = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
function Library:tween(object, goal, callback)
	local tween = TS:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function Library:tween2(object, goal, callback)
	local tween = TS:Create(object, tweenInfo2, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

local ScreenGui = Instance.new('ScreenGui', gethui())

function Library:CreateWindow(options)
	local GUI = {
		CurrentTab = nil
	}
	

	local Main = Instance.new('Frame', ScreenGui)
	local Title = Instance.new('TextLabel', Main)
	local Divider = Instance.new('Frame', Main)
	local TabBar = Instance.new('ScrollingFrame', Main)
	local TabLayout = Instance.new('UIListLayout', TabBar)
	local TabBarPad = Instance.new('UIPadding', TabBar)
	local MainCorner = Instance.new('UICorner', Main)
	local MainGradient = Instance.new('UIGradient', Main)
	local Divider2 = Instance.new('Frame', Main)
	
	
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Position = UDim2.new(0.271, 0, 0.2845, 0)
Main.Size = UDim2.new(0, 710, 0, 405)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.ZIndex = 100

Title.Name = "Title"
Title.Position = UDim2.new(0.0254, 0, 0, 0)
Title.Size = UDim2.new(0, 143, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.Text = options.Title
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.Gotham
Title.TextSize = 23
Title.ZIndex = 101
Title.TextXAlignment = Enum.TextXAlignment.Left

Divider.Name = "Divider"
Divider.Position = UDim2.new(0, 0, 0.121, 0)
Divider.Size = UDim2.new(0, 710, 0, 1)
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Divider.BorderSizePixel = 0
Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
Divider.ZIndex = 102

TabBar.Name = "TabBar"
TabBar.Position = UDim2.new(0, 0, 0.1235, 0)
TabBar.Size = UDim2.new(0, 161, 0, 355)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TabBar.BackgroundTransparency = 1
TabBar.BorderSizePixel = 0
TabBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
TabBar.ZIndex = 103
TabBar.ScrollingEnabled = false
TabBar.ScrollBarThickness = 0
TabBar.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)

TabLayout.Name = "TabLayout"
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

TabBarPad.Name = "TabBarPad"
TabBarPad.PaddingTop = UDim.new(0, 5)

Divider2.Name = "Divider2"
Divider2.Position = UDim2.new(0.2246, 0, 0.121, 0)
Divider2.Size = UDim2.new(0, 1, 0, 356)
Divider2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Divider2.BackgroundTransparency = 0.5
Divider2.BorderSizePixel = 0
Divider2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Divider2.ZIndex = 102

MainCorner.CornerRadius = UDim.new(0, 20)

MainGradient.Name = "MainGradient"
MainGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 10)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 45))
})


local MC = Instance.new('ScreenGui', gethui())
local MobileCard = Instance.new('ImageButton', MC)
local CardGradient = Instance.new('UIGradient', MobileCard)
local CardText = Instance.new('TextLabel', MobileCard)
local CardCorner = Instance.new('UICorner', MobileCard)

MC.Name = "MC"
MC.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MobileCard.Name = "MobileCard"
MobileCard.Position = UDim2.new(0.5, -20, 0, 10)
MobileCard.Size = UDim2.new(0, 40, 0, 40)
MobileCard.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MobileCard.BorderSizePixel = 0
MobileCard.BorderColor3 = Color3.fromRGB(0, 0, 0)
MobileCard.AutoButtonColor = false

CardGradient.Name = "CardGradient"
CardGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 10)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
}
CardGradient.Rotation = -84

CardText.Name = "CardText"
CardText.Size = UDim2.new(0, 40, 0, 40)
CardText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CardText.BackgroundTransparency = 1
CardText.BorderSizePixel = 0
CardText.BorderColor3 = Color3.fromRGB(0, 0, 0)
CardText.Text = "C"
CardText.TextColor3 = Color3.fromRGB(255, 255, 255) -- white for contrast
CardText.Font = Enum.Font.Gotham
CardText.TextSize = 23
CardText.ZIndex = 105



	MobileCard.MouseButton1Click:Connect(function()
		ScreenGui.Enabled = not ScreenGui.Enabled
	end)
	
	CreateDrag(MobileCard)
	CreateDrag(Main)

	function Library:Toggle()
		ScreenGui.Enabled = not ScreenGui.Enabled
	end

	UIS.InputBegan:Connect(function(key, gp)
		if gp then return end;

		if key.KeyCode == Enum.KeyCode[mainKeybind] then
			Library:Toggle()
		end
	end)

	function GUI:NewTab(options)
		
		local tab = {
			Active = false
		}
		
local Canvas = Instance.new('ScrollingFrame', Main)
local UIListLayout = Instance.new('UIListLayout', Canvas)
local UIPadding = Instance.new('UIPadding', Canvas)
local SelectedTab = Instance.new('Frame', TabBar)
local Highlight = Instance.new('Frame', SelectedTab)
local STCorner = Instance.new('UICorner', SelectedTab)
local Tab = Instance.new('TextButton', SelectedTab)

SelectedTab.Name = "SelectedTab"  
	SelectedTab.Position = UDim2.new(88.03,0,0.6006,0)  
	SelectedTab.Size = UDim2.new(0,118,0,34)  
	SelectedTab.BackgroundColor3 = Color3.new(0,0,0)  
	SelectedTab.BackgroundTransparency = 1  
	SelectedTab.BorderSizePixel = 0  
	SelectedTab.BorderColor3 = Color3.new(0,0,0)  
	SelectedTab.ZIndex = 100  
	Highlight.Name = "Highlight"
Highlight.Position = UDim2.new(0.0508, 0, 0.2353, 0)
Highlight.Size = UDim2.new(0, 2, 0, 18)
Highlight.BackgroundColor3 = Color3.fromRGB(137, 207, 240)
Highlight.BorderSizePixel = 0
Highlight.Transparency = 1
Highlight.BorderColor3 = Color3.new(0, 0, 0)
		Highlight.ZIndex = 101
		STCorner.CornerRadius = UDim.new(0,6)
	Tab.Name = "Tab"  
	Tab.Position = UDim2.new(0.0678,0,0,0)  
	Tab.Size = UDim2.new(0,109,0,34)  
	Tab.BackgroundColor3 = Color3.new(1,1,1)  
	Tab.BackgroundTransparency = 1  
	Tab.BorderSizePixel = 0  
	Tab.BorderColor3 = Color3.new(0,0,0)  
	Tab.Text = options.Name  
	Tab.TextColor3 = Color3.new(0.5529,0.5529,0.5529)  
	Tab.Font = Enum.Font.Gotham  
	Tab.TextSize = 14  
	Tab.ZIndex = 105  
	Tab.AutoButtonColor = false		  
	Canvas.Name = "Canvas"  
	Canvas.Position = UDim2.new(0.2268,0,0.1235,0)  
	Canvas.Size = UDim2.new(0,549,0,355)  
	Canvas.BackgroundColor3 = Color3.new(1,1,1)  
	Canvas.BackgroundTransparency = 1  
	Canvas.BorderSizePixel = 0  
	Canvas.BorderColor3 = Color3.new(0,0,0)  
	Canvas.ZIndex = 107  
	Canvas.Visible = false  
	Canvas.AutomaticCanvasSize = Enum.AutomaticSize.Y;  
	Canvas.ScrollBarThickness = 0  
	Canvas.ScrollBarImageColor3 = Color3.new(0,0,0)  
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center  
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder  
	UIListLayout.Padding = UDim.new(0,5)  
	UIPadding.PaddingTop = UDim.new(0,10)



	function tab:Activate()
			if not tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end
				tab.Active = true
				Library:tween(Tab, {TextColor3 = Color3.new(1,1,1)})
				Library:tween(SelectedTab, {BackgroundTransparency = 0.5})
				Library:tween(Highlight, {BackgroundTransparency = 0})
				Canvas.Visible = true
				GUI.CurrentTab = tab
			end
		end

		function tab:Deactivate()
			if tab.Active then
				tab.Active = false
				Library:tween(Tab, {TextColor3 =Color3.new(0.5529,0.5529,0.5529)})
				Library:tween(SelectedTab, {BackgroundTransparency = 1})
				Library:tween(Highlight, {BackgroundTransparency = 1})
				Canvas.Visible = false
			end
		end

		Tab.MouseButton1Click:Connect(function()
			tab:Activate()
		end)

		if GUI.CurrentTab == nil then
			tab.Activate()	
		end
		
		
		function tab:NewToggle(options)
			
			local toggle = {
				State = false
			}
			
			local Toggle = Instance.new('ImageButton', Canvas)
			local ToggleTitle = Instance.new('TextLabel', Toggle)
			local CheckBox = Instance.new('Frame', Toggle)
			local CheckBoxCorner = Instance.new('UICorner', CheckBox)
			local CheckMark = Instance.new('ImageButton', CheckBox)
			local ToggleCorner = Instance.new('UICorner', Toggle)
			


			Toggle.Name = "Toggle"
			Toggle.Position = UDim2.new(0.2606,0,0.5185,0)
			Toggle.Size = UDim2.new(0,499,0,42)
			Toggle.BackgroundColor3 = Color3.new(0,0,0)
			Toggle.BackgroundTransparency = 0.5
			Toggle.BorderSizePixel = 0
			Toggle.BorderColor3 = Color3.new(0,0,0)
			Toggle.ZIndex = 108
			Toggle.AutoButtonColor = false		
			ToggleTitle.Name = "ToggleTitle"
			ToggleTitle.Position = UDim2.new(0.0321,0,0,0)
			ToggleTitle.Size = UDim2.new(0,363,0,34)
			ToggleTitle.BackgroundColor3 = Color3.new(1,1,1)
			ToggleTitle.BackgroundTransparency = 1
			ToggleTitle.BorderSizePixel = 0
			ToggleTitle.BorderColor3 = Color3.new(0,0,0)
			ToggleTitle.Text = options.Name
			ToggleTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			ToggleTitle.Font = Enum.Font.Gotham
			ToggleTitle.TextSize = 14
			ToggleTitle.ZIndex = 109
			ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
			CheckBox.Name = "CheckBox"
			CheckBox.Position = UDim2.new(0.9359,0,0.1471,0)
			CheckBox.Size = UDim2.new(0,24,0,24)
			CheckBox.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			CheckBox.BorderSizePixel = 0
			CheckBox.BorderColor3 = Color3.new(0,0,0)
			CheckBox.ZIndex = 107
			CheckBoxCorner.CornerRadius = UDim.new(0,5)
			CheckMark.Name = "CheckMark"
			CheckMark.Position = UDim2.new(0.0464,0,0.0417,0)
			CheckMark.Size = UDim2.new(0,22,0,22)
			CheckMark.BackgroundColor3 = Color3.new(0,0,0)
			CheckMark.BackgroundTransparency = 1
			CheckMark.BorderSizePixel = 0
			CheckMark.BorderColor3 = Color3.new(0,0,0)
			CheckMark.Image = "rbxassetid://6031094667"
			CheckMark.Visible = true
			CheckMark.AutoButtonColor = false
			CheckMark.ZIndex = 107
			ToggleCorner.CornerRadius = UDim.new(0,6)
			
			toggle.State = options.default

			options.callback(toggle.State)

			if toggle.State then
				Library:tween(CheckMark, {ImageTransparency = 0})
			else
				Library:tween(CheckMark, {ImageTransparency = 1})
			end

			function toggle:Toggle(boolean)
				if boolean == nil then
					toggle.State = not toggle.State
				else
					toggle.State = boolean
				end

				if toggle.State then
					print("a")
					Library:tween(CheckMark, {ImageTransparency = 0})
				else
					Library:tween(CheckMark, {ImageTransparency = 1})
				end

				options.callback(toggle.State)
			end

			Toggle.MouseButton1Down:Connect(function()
				toggle:Toggle()
			end)
			
			return toggle
		end
		
		function tab:NewSlider(options)
			local slider = {
				hover = false,
				MouseDown = false,
				connections = {}
			}
			
			local Slider = Instance.new('ImageButton', Canvas)
			local SliderTitle = Instance.new('TextLabel', Slider)
			local SliderBack = Instance.new('Frame', Slider)
			local SliderBackCorner = Instance.new('UICorner', SliderBack)
			local SliderMain = Instance.new('Frame', SliderBack)
			local SliderMainCorner = Instance.new('UICorner', SliderMain)
			local SliderCorner = Instance.new('UICorner', Slider)
			local SliderAmt = Instance.new('TextBox', Slider)
			

			Slider.Name = "Slider"
			Slider.Position = UDim2.new(0.2606,0,0.5185,0)
			Slider.Size = UDim2.new(0,499,0,34)
			Slider.BackgroundColor3 = Color3.new(0,0,0)
			Slider.BackgroundTransparency = 0.5
			Slider.BorderSizePixel = 0
			Slider.BorderColor3 = Color3.new(0,0,0)
			Slider.ZIndex = 108
			Slider.AutoButtonColor = false
			SliderTitle.Name = "SliderTitle"
			SliderTitle.Position = UDim2.new(0.0321,0,0,0)
			SliderTitle.Size = UDim2.new(0,211,0,34)
			SliderTitle.BackgroundColor3 = Color3.new(1,1,1)
			SliderTitle.BackgroundTransparency = 1
			SliderTitle.BorderSizePixel = 0
			SliderTitle.BorderColor3 = Color3.new(0,0,0)
			SliderTitle.Text = options.Name
			SliderTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			SliderTitle.Font = Enum.Font.Gotham
			SliderTitle.TextSize = 14
			SliderTitle.ZIndex = 109
			SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
			SliderBack.Name = "SliderBack"
			SliderBack.Position = UDim2.new(0.5251,0,0.4118,0)
			SliderBack.Size = UDim2.new(0,229,0,6)
			SliderBack.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			SliderBack.BorderSizePixel = 0
			SliderBack.BorderColor3 = Color3.new(0,0,0)
			SliderBack.ZIndex = 109
			SliderBackCorner.CornerRadius = UDim.new(0,5)
			SliderMain.Name = "SliderMain"
			SliderMain.Position = UDim2.new(-0,0,0,0)
			SliderMain.Size = UDim2.new(0,118,0,6)
			SliderMain.BackgroundColor3 = Color3.new(1,1,1)
			SliderMain.BorderSizePixel = 0
			SliderMain.BorderColor3 = Color3.new(0,0,0)
			SliderMain.ZIndex = 109
			SliderMainCorner.CornerRadius = UDim.new(0,5)
			SliderCorner.CornerRadius = UDim.new(0,6)
			SliderAmt.Name = "SliderAmt"
			SliderAmt.Position = UDim2.new(0.4569,0,0,0)
			SliderAmt.Size = UDim2.new(0,34,0,34)
			SliderAmt.BackgroundColor3 = Color3.new(1,1,1)
			SliderAmt.BackgroundTransparency = 1
			SliderAmt.BorderSizePixel = 0
			SliderAmt.BorderColor3 = Color3.new(0,0,0)
			SliderAmt.Text = "33"
			SliderAmt.TextColor3 = Color3.new(0.851,0.851,0.851)
			SliderAmt.Font = Enum.Font.Gotham
			SliderAmt.TextSize = 11
			SliderAmt.ZIndex = 109
			

			function slider:SetValue(v)
				if v == nil then
					local percentage = math.clamp((mouse.X - SliderBack.AbsolutePosition.X) / (SliderBack.AbsoluteSize.X), 0, 1)
					local value = ((options.max - options.min) * percentage) + options.min
					if value % 1 == 0 then
						SliderAmt.Text = string.format("%.0f", value)
					else
						SliderAmt.Text = string.format("%.2f", value)
					end
					SliderMain.Size = UDim2.fromScale(percentage, 1)
				else
					if v % 1 == 0 then
						SliderAmt.Text = string.format("%.0f", v)
					else
						SliderAmt.Text = tostring(v)
					end
					SliderMain.Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
				end
				options.callback(slider:GetValue())
			end


			function slider:GetValue()
				return tonumber(SliderAmt.Text)
			end

			slider:SetValue(options.default)

			SliderAmt.FocusLost:Connect(function()
				local toNum
				pcall(function()
					toNum = tonumber(SliderAmt.Text)
				end)
				if toNum then
					toNum = math.clamp(toNum, options.min, options.max)
					slider:SetValue(toNum)
				else
					SliderAmt.Text = "only number :<"
				end
			end)

			local Connection;
			table.insert(slider.connections, UIS.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					pcall(function()
						Connection:Disconnect();
						Connection = nil;
					end)
				end
			end))

			--LPH_NO_VIRTUALIZE(function()
			table.insert(slider.connections, Slider.MouseButton1Down:Connect(function()
				if(Connection) then
					Connection:Disconnect();
				end;

				Connection = RS.Heartbeat:Connect(function()
					--options.callback()

						slider:SetValue()

				end)
			end))
			--end)()

			return slider
		end
		
		function tab:NewDropDown(options)
			local dropdown = {}
			
			local Dropdown = Instance.new('Frame', Canvas)
			local DropdownTitle = Instance.new('TextLabel', Dropdown)
			local DropdownSelected = Instance.new('Frame', Dropdown)
			local SelectedOptionCorner = Instance.new('UICorner', DropdownSelected)
			local SelectedText = Instance.new('TextButton', DropdownSelected)
			local DropdownCorner = Instance.new('UICorner', Dropdown)
			
			Dropdown.Name = "Dropdown"
			Dropdown.Position = UDim2.new(0.2606,0,0.5185,0)
			Dropdown.Size = UDim2.new(0,499,0,34)
			Dropdown.BackgroundColor3 = Color3.new(0,0,0)
			Dropdown.BackgroundTransparency = 0.5
			Dropdown.BorderSizePixel = 0
			Dropdown.BorderColor3 = Color3.new(0,0,0)
			Dropdown.ZIndex = 108
			DropdownTitle.Name = "DropdownTitle"
			DropdownTitle.Position = UDim2.new(0.0321,0,0,0)
			DropdownTitle.Size = UDim2.new(0,312,0,34)
			DropdownTitle.BackgroundColor3 = Color3.new(1,1,1)
			DropdownTitle.BackgroundTransparency = 1
			DropdownTitle.BorderSizePixel = 0
			DropdownTitle.BorderColor3 = Color3.new(0,0,0)
			DropdownTitle.Text = options.Name
			DropdownTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			DropdownTitle.Font = Enum.Font.Gotham
			DropdownTitle.TextSize = 14
			DropdownTitle.ZIndex = 109
			DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
			DropdownSelected.Name = "DropdownSelected"
			DropdownSelected.Position = UDim2.new(0.6794,0,0.1471,0)
			DropdownSelected.Size = UDim2.new(0,152,0,24)
			DropdownSelected.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			DropdownSelected.BorderSizePixel = 0
			DropdownSelected.BorderColor3 = Color3.new(0,0,0)
			DropdownSelected.ZIndex = 109
			SelectedOptionCorner.CornerRadius = UDim.new(0,5)
			SelectedText.Name = "SelectedText"
			SelectedText.Position = UDim2.new(0.0321,0,0,0)
			SelectedText.Size = UDim2.new(0,147,0,24)
			SelectedText.BackgroundColor3 = Color3.new(1,1,1)
			SelectedText.BackgroundTransparency = 1
			SelectedText.BorderSizePixel = 0
			SelectedText.BorderColor3 = Color3.new(0,0,0)
			SelectedText.AutoButtonColor = false
			SelectedText.Text = options.default
			SelectedText.TextColor3 = Color3.new(0.851,0.851,0.851)
			SelectedText.Font = Enum.Font.Gotham
			SelectedText.TextSize = 13
			SelectedText.ZIndex = 109
			DropdownCorner.CornerRadius = UDim.new(0,6)
			

			local DropDownOptions = Instance.new('Frame', Main)
			local Frame = Instance.new('Frame', DropDownOptions)
			local UIListLayout = Instance.new('UIListLayout', Frame)

			--Properties

			DropDownOptions.Name = "DropDownOptions"
			DropDownOptions.Position = UDim2.new(1.0211,0,0.1358,0)
			DropDownOptions.Size = UDim2.new(0,100,0,49)
			DropDownOptions.BackgroundColor3 = Color3.new(0,0,0)
			DropDownOptions.BackgroundTransparency = 0.25
			DropDownOptions.BorderSizePixel = 0
			DropDownOptions.BorderColor3 = Color3.new(0,0,0)
			DropDownOptions.Visible = false
			DropDownOptions.AutomaticSize = Enum.AutomaticSize.XY
			DropDownOptions.ZIndex = 110
			Frame.Size = UDim2.new(0,100,0,49)
			Frame.BackgroundColor3 = Color3.new(1,1,1)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.BorderColor3 = Color3.new(0,0,0)
			Frame.AutomaticSize = Enum.AutomaticSize.XY
			Frame.ZIndex = 110
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			for i, v in pairs(options.options) do
				local Option = Instance.new('TextButton', Frame)
				local Highlight = Instance.new('Frame', Option)
				Option.Name = "Option"
				Option.Position = UDim2.new(0.02,0,0,0)
				Option.Size = UDim2.new(0,98,0,27)
				Option.BackgroundColor3 = Color3.new(1,1,1)
				Option.BackgroundTransparency = 1
				Option.BorderSizePixel = 0
				Option.Text = v
				Option.BorderColor3 = Color3.new(0,0,0)
				Option.TextColor3 = Color3.new(0.8627,0.8627,0.8627)
				Option.Font = Enum.Font.SourceSans
				Option.TextSize = 14
				Option.ZIndex = 111
				Highlight.Name = "Highlight"
				Highlight.Position = UDim2.new(-0.0306,0,0,0)
				Highlight.Size = UDim2.new(0,2,0,27)
				Highlight.BackgroundColor3 = Color3.new(1,1,1)
				Highlight.BorderSizePixel = 0
				Highlight.BorderColor3 = Color3.new(0,0,0)
				Highlight.AutomaticSize = Enum.AutomaticSize.Y
				Highlight.ZIndex = 111
				
				Option.MouseButton1Down:Connect(function()
					SelectedText.Text = v
					DropDownOptions.Visible = false
					options.callback(v)
				end)
			end
			
			SelectedText.MouseButton1Down:Connect(function()
				DropDownOptions.Visible = not DropDownOptions.Visible
			end)
			
			options.callback(options.default)
			
			return dropdown
		end
		
		function tab:NewButton(options)
			local button = {}
			
			local Button = Instance.new('Frame', Canvas)
			local ButtonTitle = Instance.new('TextButton', Button)
			local ButtonCorner = Instance.new('UICorner', Button)

			--Properties

			Button.Name = "Button"
			Button.Position = UDim2.new(0.3338,0,0.6099,0)
			Button.Size = UDim2.new(0,499,0,34)
			Button.BackgroundColor3 = Color3.new(0,0,0)
			Button.BackgroundTransparency = 0.5
			Button.BorderSizePixel = 0
			Button.BorderColor3 = Color3.new(0,0,0)
			Button.ZIndex = 108
			ButtonTitle.Name = "ButtonTitle"
			ButtonTitle.Size = UDim2.new(0,498,0,34)
			ButtonTitle.BackgroundColor3 = Color3.new(1,1,1)
			ButtonTitle.AutoButtonColor = false
			ButtonTitle.BackgroundTransparency = 1
			ButtonTitle.BorderSizePixel = 0
			ButtonTitle.BorderColor3 = Color3.new(0,0,0)
			ButtonTitle.Text = options.Name
			ButtonTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			ButtonTitle.Font = Enum.Font.Gotham
			ButtonTitle.TextSize = 14
			ButtonTitle.ZIndex = 109
			ButtonCorner.CornerRadius = UDim.new(0,6)
			
			ButtonTitle.MouseButton1Down:Connect(function()
				Library:tween(Button, {BackgroundColor3 = Color3.new(0.756863, 0.756863, 0.756863)})
			end)
			
			ButtonTitle.MouseButton1Up:Connect(function()
				Library:tween(Button, {BackgroundColor3 = Color3.fromRGB(0, 0, 0)})
			end)
			
			ButtonTitle.MouseButton1Click:Connect(function()
				options.callback()
			end)
			
			return button
		end
		
		return tab
	end
	
	return GUI
end


local lib = Library:CreateWindow({Title = "Star Hub"})


local Tab1 = lib:NewTab({Name ="Mag"})
local Tab2 = lib:NewTab({Name ="Qb aimbot"})
local Tab3 = lib:NewTab({Name ="Physical"})
local Tab4 = lib:NewTab({Name ="Player"})
local Tab5 = lib:NewTab({Name ="Visuals"})
local Tab6 = lib:NewTab({Name ="Automatic"})
local Tab7 = lib:NewTab({Name ="Settings"})

Tab1:NewToggle({
	Name = "Magnets",
	default = false,
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.magnetEnabled = v
	end
})

local slider = Tab1:NewSlider({
	Name = "Magnet Range",
	min = 0,
	max = 25,
	default = 13,
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.magnetRange = v
	end
})

Tab1:NewDropDown({
	Name = "Magnet Type",
	options = { "Regular", "League", "Legit", "Rage", "Custom" },
	default = "Regular",
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.currentMode = v
		local presets = { Blatant = 25, Regular = 13, Legit = 10, League = 6 }
		if presets[v] and slider then
			slider:SetValue(presets[v])
		end
	end
})

Tab1:NewToggle({
	Name = "Magnet Hitbox",
	default = false,
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.hitboxEnabled = v
	end
})

Tab1:NewDropDown({
	Name = "Hitbox Type",
	options = { "Forcefield", "Sphere", "Box" },
	default = "Forcefield",
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.hitboxType = v
	end
})

Tab1:NewToggle({
	Name = "Rainbow Hitbox",
	default = false,
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.rainbowHitboxEnabled = v
	end
})

Tab1:NewSlider({
	Name = "Rainbow Speed",
	min = 0.5,
	max = 1,
	default = 0.5,
	increment = 0.1,
	callback = function(v)
		getgenv().g = getgenv().g or {}
		g.rainbowSpeed = v
	end
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local hitboxes_void = {}
local velocity_void = {}
local lastPositions_void = {}

local modeRanges_void = {
	Regular = 13,
	League = 6,
	Legit = 10,
	Rage = 25,
	Custom = 0
}

getgenv().g = getgenv().g or {}
g.rainbowHue_void = 0

local function getRange_void()
	if g.currentMode == "Custom" then
		return g.magnetRange or 0
	end
	local value = modeRanges_void[g.currentMode]
	if value then
		return value
	end
	return 13
end

local function findFootballs_void()
	local balls = {}
	local children = Workspace:GetChildren()
	for i = 1, #children do
		local obj = children[i]
		if obj:IsA("BasePart") and obj.Name == "Football" and not obj.Anchored then
			balls[#balls + 1] = obj
		end
	end
	return balls
end

local function getNearestPart_void(ref, parts)
	local closest = nil
	local dist = math.huge
	for i = 1, #parts do
		local p = parts[i]
		if p and p.Position then
			local d = (ref.Position - p.Position).Magnitude
			if d < dist then
				dist = d
				closest = p
			end
		end
	end
	return closest
end

local function updateRainbowColor_void()
	g.rainbowHue_void = (g.rainbowHue_void + (g.rainbowSpeed / 255)) % 1
	return Color3.fromHSV(g.rainbowHue_void, 1, 1)
end

local function createOrUpdateHitbox_void(ball)
	local size = getRange_void()
	local hitbox = hitboxes_void[ball]

	if not hitbox or not hitbox.Parent then
		hitbox = Instance.new("Part")
		hitbox.Anchored = true
		hitbox.CanCollide = false
		hitbox.Name = "Hitbox"
		hitbox.Parent = ball.Parent or Workspace
		hitboxes_void[ball] = hitbox
	end

	hitbox.Size = Vector3.new(size, size, size)
	hitbox.CFrame = ball.CFrame

	local children = hitbox:GetChildren()
	for i = #children, 1, -1 do
		local v = children[i]
		if v:IsA("SelectionBox") or v:IsA("SelectionSphere") then
			v:Destroy()
		end
	end

	if g.rainbowHitboxEnabled then
		hitbox.Shape = Enum.PartType.Ball
		hitbox.Material = Enum.Material.ForceField
		hitbox.Color = updateRainbowColor_void()
		hitbox.Transparency = 0.3
	elseif g.hitboxType == "Forcefield" then
		hitbox.Shape = Enum.PartType.Ball
		hitbox.Material = Enum.Material.ForceField
		hitbox.Color = Color3.fromRGB(50, 205, 50)
		hitbox.Transparency = 0.3
	elseif g.hitboxType == "Sphere" then
		hitbox.Shape = Enum.PartType.Ball
		hitbox.Material = Enum.Material.SmoothPlastic
		hitbox.Color = Color3.fromRGB(255, 105, 180) 
hitbox.Transparency = 0.4
		local outline = Instance.new("SelectionSphere")
		outline.Adornee = hitbox
		outline.SurfaceColor3 = Color3.fromRGB(137, 207, 240)
outline.SurfaceTransparency = 0.3
		outline.Parent = hitbox
	elseif g.hitboxType == "Box" then
		hitbox.Shape = Enum.PartType.Block
		hitbox.Material = Enum.Material.SmoothPlastic
		hitbox.Color = Color3.fromRGB(120, 120, 120)
		hitbox.Transparency = 0.65
		local outline = Instance.new("SelectionBox")
		outline.Adornee = hitbox
		outline.LineThickness = 0.05
		outline.Color3 = Color3.fromRGB(120, 120, 120)
		outline.Transparency = 0.6
		outline.Parent = hitbox
	end
end

local function clearHitbox_void(ball)
	if hitboxes_void[ball] then
		hitboxes_void[ball]:Destroy()
		hitboxes_void[ball] = nil
	end
end

Workspace.ChildRemoved:Connect(function(obj)
	if hitboxes_void[obj] then
		clearHitbox_void(obj)
		velocity_void[obj] = nil
		lastPositions_void[obj] = nil
	end
end)

RunService.Heartbeat:Connect(function(dt)
	if not g then return end

	local balls = findFootballs_void()
	local range = getRange_void()

	local leftCatch = char:FindFirstChild("LeftCatch") or char:FindFirstChild("LeftHand") or char:FindFirstChild("Left Arm")
	local rightCatch = char:FindFirstChild("RightCatch") or char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")

	for i = 1, #balls do
		local ball = balls[i]

		local lastPos = lastPositions_void[ball] or ball.Position
		local vel = (ball.Position - lastPos) / dt
		velocity_void[ball] = vel
		lastPositions_void[ball] = ball.Position

		if g.hitboxEnabled or g.rainbowHitboxEnabled then
			createOrUpdateHitbox_void(ball)
		else
			clearHitbox_void(ball)
		end

		if g.magnetEnabled and leftCatch and rightCatch then
			local pingTime = g.ping or 0.1
			local predictedPos = ball.Position + (velocity_void[ball] or Vector3.new(0,0,0)) * pingTime
			local nearestCatch = getNearestPart_void(ball, {leftCatch, rightCatch})

			if nearestCatch then
				local dist = (nearestCatch.Position - predictedPos).Magnitude
				if dist <= range then
					firetouchinterest(leftCatch, ball, 0)
					firetouchinterest(leftCatch, ball, 1)
					firetouchinterest(rightCatch, ball, 0)
					firetouchinterest(rightCatch, ball, 1)
				end
			end
		end
	end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local PullVectorOn = false
local PullVectorSpeed = 2
local PullVectorRadius = 35
local pullVectoredBalls = {}

local function findClosestBall()
	local closest = nil
	local shortest = math.huge
	for _, obj in next, Workspace:GetChildren() do
		if obj:IsA("BasePart") and obj.Name == "Football" and not obj.Anchored then
			local dist = (obj.Position - Player.Character.HumanoidRootPart.Position).Magnitude
			if dist < shortest then
				shortest = dist
				closest = obj
			end
		end
	end
	return closest
end

task.spawn(function()
	while true do
		task.wait()
		if not PullVectorOn then continue end

		local ball = findClosestBall()
		if not ball or pullVectoredBalls[ball] then continue end
		if not ball:FindFirstChildWhichIsA("Trail") then continue end

		local char = Player.Character
		if not char then continue end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then continue end

		local dist = (root.Position - ball.Position).Magnitude
		if dist > PullVectorRadius then continue end

		local dir = (ball.Position - root.Position).Unit
		root.AssemblyLinearVelocity = dir * PullVectorSpeed * 25
	end
end)

Tab1:NewToggle({
	Name = "Pull Vector",
	default = false,
	callback = function(v)
		PullVectorOn = v
	end
})

Tab1:NewSlider({
	Name = "Pull Speed",
	min = 1,
	max = 5,
	default = 2,
	decimals = 0.1,
	callback = function(v)
		PullVectorSpeed = v
	end
})

Tab1:NewSlider({
	Name = "Pull Radius",
	min = 10,
	max = 50,
	default = 35,
	decimals = 1,
	callback = function(v)
		PullVectorRadius = v
	end
})

local plr = game:GetService("Players").LocalPlayer
local voidChar = plr.Character or plr.CharacterAdded:Wait()

plr.CharacterAdded:Connect(function(c)
	voidChar = c
end)

getgenv().voidArmSize = 2
getgenv().voidArmOn = false

game:GetService("RunService").Heartbeat:Connect(function()
	if getgenv().voidArmOn and voidChar then
		local l = voidChar:FindFirstChild("Left Arm")
		local r = voidChar:FindFirstChild("Right Arm")
		if l and r then
			l.Size = Vector3.new(1, getgenv().voidArmSize, 1)
			r.Size = Vector3.new(1, getgenv().voidArmSize, 1)
		end
	elseif voidChar then
		local l = voidChar:FindFirstChild("Left Arm")
		local r = voidChar:FindFirstChild("Right Arm")
		if l and r then
			l.Size = Vector3.new(1, 2, 1)
			r.Size = Vector3.new(1, 2, 1)
		end
	end
end)

Tab1:NewToggle({
	Name = "Arm Size",
	default = false,
	callback = function(v)
		getgenv().voidArmOn = v
	end
})

Tab1:NewSlider({
	Name = "Arm Length",
	min = 2,
	max = 20,
	default = 4,
	decimals = 0.1,
	callback = function(v)
		getgenv().voidArmSize = v
	end
})

-- Variables
getgenv().enabled = false
getgenv().leadDistanceVariable = 0
getgenv().heightDistanceVariable = 0
getgenv().dimeLead = 11
getgenv().MagLead = 12.5
getgenv().bulletLead = 4
getgenv().autoAngle = false
getgenv().beamMode = false


Tab2:NewToggle({
	Name = "QB Aimbot",
	default = false,
	callback = function(v)
		getgenv().enabled = v
	end
})

Tab2:NewToggle({
	Name = "Auto Angle",
	default = false,
	callback = function(v)
		getgenv().autoAngle = v
	end
})

Tab2:NewToggle({
	Name = "Auto Throw",
	default = false,
	callback = function(v)
		getgenv().autoThrow = v
	end
})

Tab2:NewToggle({
	Name = "Beam Mode",
	default = false,
	callback = function(v)
		getgenv().beamMode = v
	end
})


Tab2:NewSlider({
	Name = "Lead Distance",
	min = 0,
	max = 20,
	default = getgenv().leadDistanceVariable,
	decimals = 0.1,
	callback = function(v)
		getgenv().leadDistanceVariable = v
	end
})

Tab2:NewSlider({
	Name = "Height Distance",
	min = 0,
	max = 20,
	default = getgenv().heightDistanceVariable,
	decimals = 0.1,
	callback = function(v)
		getgenv().heightDistanceVariable = v
	end
})

local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local player = players.LocalPlayer
local gui = game:GetObjects("rbxassetid://132405936708251")[1]

local locked = false
local target = nil
local highlight = Instance.new("Highlight")
highlight.FillColor = Color3.fromRGB(82, 206, 255)
highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment") 
a0.Parent = workspace.Terrain 
a1.Parent = workspace.Terrain
local beam = Instance.new("Beam", workspace.Terrain)
beam.Attachment0 = a0
beam.Attachment1 = a1
beam.Segments = 500
beam.Width0 = 5
beam.Width1 = 5
beam.Transparency = NumberSequence.new(0)
beam.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), 
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
beam.Texture = "http://www.roblox.com/asset/?id=5309397920"


local data = {
	Angle = 40,
	Power = 0,
	Direction = Vector3.new(0, 0, 0)
}

local passTypeLeads = {
	["Dime"] = dimeLead,
    ["Mag"] = MagLead,
    ["Bullet"] = bulletLead
}

local passTypeSwitch = {
	["Dime"] = "Bullet",
	["Bullet"] = "Mag",
    ["Mag"] = "Dime"
}

local passType = "Dime"

local ANGLE_WARNING_THRESHOLD = 35 
local ANGLE_DANGER_THRESHOLD = 50

local function findTarget()
	local cc = workspace.CurrentCamera
	local playerDist = math.huge
	local playerTarget = nil

	for _, obj in ipairs(workspace:GetChildren()) do
		if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
			local humanoid = obj:FindFirstChild("Humanoid")
			local characterPlayer = players:GetPlayerFromCharacter(obj)

			if humanoid.Health > 0 and obj ~= player.Character and characterPlayer and characterPlayer.Team == player.Team then
				local hrp = obj:FindFirstChild("HumanoidRootPart")
				local screenpoint, onscreen = cc:WorldToViewportPoint(hrp.Position)
				local check = (Vector2.new(userInputService:GetMouseLocation().X, userInputService:GetMouseLocation().Y) - Vector2.new(screenpoint.X, screenpoint.Y)).Magnitude
				
				if check < playerDist then
					playerTarget = obj
					playerDist = check
				end
			end
		end
	end

	local npcDist = math.huge
	local npcTarget = nil

	for _, bot in ipairs(workspace:GetChildren()) do
		if bot.Name == "npcwr" then
			local stationA = bot:FindFirstChild("a")
			local stationB = bot:FindFirstChild("b")
			
			if stationA and stationB then
				local bot1 = stationA:FindFirstChild("bot 1")
				local bot3 = stationB:FindFirstChild("bot 3")
				local bots = {bot1, bot3}
				
				for _, currentBot in ipairs(bots) do
					if currentBot and currentBot:FindFirstChild("HumanoidRootPart") then
						local screenpoint, onscreen = cc:WorldToViewportPoint(currentBot.HumanoidRootPart.Position)
						local check = (Vector2.new(userInputService:GetMouseLocation().X, userInputService:GetMouseLocation().Y) - Vector2.new(screenpoint.X, screenpoint.Y)).Magnitude
						
						if check < npcDist then
							npcTarget = currentBot
							npcDist = check
						end
					end
				end
			end
		end
	end

	if playerDist < npcDist then
		return playerTarget
	else
		return npcTarget
	end
end

local TweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local player = players.LocalPlayer
local mouse = player:GetMouse()


local function calculateLaunchAngle(velocity, horizontalDistance)
    if autoAngle or beamMode or passType == "Bullet" then
        local horizontalComponent = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
        local verticalComponent = velocity.Y

        if horizontalComponent == 0 then
            return 90
        end

        local angleRadians = math.atan(verticalComponent / horizontalComponent)
        local angleDegrees = math.deg(angleRadians)

        return math.max(0, angleDegrees)
    elseif enabled then
        return 45
    else
        return 0
    end
end


local function getAngleWarning(angle)
    if angle >= ANGLE_DANGER_THRESHOLD then
        return Color3.fromRGB(255, 0, 0), "DANGER: High Arc!"
    elseif angle >= ANGLE_WARNING_THRESHOLD then
        return Color3.fromRGB(255, 165, 0), "WARNING: Steep Arc"
    else
        return Color3.fromRGB(0, 255, 0), "Safe Arc"
    end
end

function beamProjectile(g, v0, x0, t1) -- this is beamrods i didnt make this fyi
	local c = 0.5*0.5*0.5;
	local p3 = 0.5*g*t1*t1 + v0*t1 + x0;
	local p2 = p3 - (g*t1*t1 + v0*t1)/3;
	local p1 = (c*g*t1*t1 + 0.5*v0*t1 + x0 - c*(x0+p3))/(3*c) - p2;

	local curve0 = (p1 - x0).magnitude;
	local curve1 = (p2 - p3).magnitude;

	local b = (x0 - p3).unit;
	local r1 = (p1 - x0).unit;
	local u1 = r1:Cross(b).unit;
	local r2 = (p2 - p3).unit;
	local u2 = r2:Cross(b).unit;
	b = u1:Cross(r1).unit;

	local cf1 = CFrame.new(
		x0.x, x0.y, x0.z,
		r1.x, u1.x, b.x,
		r1.y, u1.y, b.y,
		r1.z, u1.z, b.z
	)

	local cf2 = CFrame.new(
		p3.x, p3.y, p3.z,
		r2.x, u2.x, b.x,
		r2.y, u2.y, b.y,
		r2.z, u2.z, b.z
	)

	return curve0, -curve1, cf1, cf2;
end

local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method, args = getnamecallmethod(), {...}
    if args[1] == "Clicked" and enabled then
        return __namecall(self, "Clicked", player.Character.Head.Position, player.Character.Head.Position + data.Direction * 10000, (game.PlaceId == 8206123457 and data.Power) or args[4], data.Power)
    end
    return __namecall(self, ...)
end)

gui.Parent = gethui()

userInputService.InputBegan:Connect(function(input, gp)
    if not gp and player.PlayerGui:FindFirstChild("BallGui") then
        if input.KeyCode == Enum.KeyCode.Q then
            locked = not locked
        elseif input.KeyCode == Enum.KeyCode.Z then
            passType = passTypeSwitch[passType]
        end
    end
end)

local cards = gui:WaitForChild("Mobile")
local targetCard = cards:WaitForChild("Lock")
local modeCard = cards:WaitForChild("Switch")

local targetButton = Instance.new("ImageButton")
targetButton.Name = "TargetButton"
targetButton.Size = targetCard.Size
targetButton.Position = targetCard.Position
targetButton.BackgroundTransparency = 1
targetButton.ImageTransparency = 1
targetButton.ZIndex = targetCard.ZIndex + 1
targetButton.Parent = targetCard.Parent

local modeButton = Instance.new("ImageButton")
modeButton.Name = "ModeButton"
modeButton.Size = modeCard.Size
modeButton.Position = modeCard.Position
modeButton.BackgroundTransparency = 1
modeButton.ImageTransparency = 1
modeButton.ZIndex = modeCard.ZIndex + 1
modeButton.Parent = modeCard.Parent

targetButton.MouseButton1Click:Connect(function()
    if player.PlayerGui:FindFirstChild("BallGui") then
        locked = not locked
    end
end)

modeButton.MouseButton1Click:Connect(function()
    if player.PlayerGui:FindFirstChild("BallGui") then
        passType = passTypeSwitch[passType]
    end
end)

local lastAngleValue = 15

local function calculateFixedAngleVelocity(startPos, targetPos, g, angleDegrees)
    local rad = math.rad(angleDegrees)
    local dxz = Vector3.new(targetPos.X - startPos.X, 0, targetPos.Z - startPos.Z).Magnitude
    local dy = targetPos.Y - startPos.Y

    local cosAngle = math.cos(rad)
    local sinAngle = math.sin(rad)

    local numerator = g.Magnitude * dxz * dxz
    local denominator = 1.7 * cosAngle * cosAngle * (dxz * math.tan(rad) - dy)

    if denominator <= 0 then
        return nil
    end

    local v0mag = math.sqrt(numerator / denominator)
    local horizontalDir = (Vector3.new(targetPos.X, startPos.Y, targetPos.Z) - startPos).Unit
    local velocity = horizontalDir * (v0mag * cosAngle) + Vector3.new(0, v0mag * sinAngle, 0)

    return velocity
end

while true do
    task.wait()

    local ballGui = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("BallGui")
    if not ballGui then
        gui.Enabled = false
        continue
    end

    gui.Enabled = true

    if not locked then
        target = findTarget()
    end

    if target and enabled and player.Character and player.Character:FindFirstChild("Head") and target:FindFirstChild("HumanoidRootPart") then
        target = locked and target or findTarget()

        highlight.OutlineColor = locked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(82, 206, 255)
        highlight.FillColor = locked and Color3.fromRGB(82, 206, 255) or Color3.fromRGB(0, 255, 0)
        highlight.Parent = target

        local vel, direction, power, t, launchAngle, warningText = (function()
            local g = Vector3.new(0, -28, 0)
            local leadDistance = passTypeLeads[passType] + leadDistanceVariable
            local moveDirection = (function(target)
                return players:GetPlayerFromCharacter(target) and target.Humanoid.MoveDirection 
                or (target.Humanoid.WalkToPoint - target.Head.Position).Unit
            end)(target)

            local targetPosition = target.HumanoidRootPart.Position + Vector3.new(0, heightDistanceVaraible, 0) + (moveDirection * leadDistance)
            local horizontalDistance = (player.Character.Head.Position - targetPosition).Magnitude

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local isJumping = humanoid and (
                humanoid:GetState() == Enum.HumanoidStateType.Jumping 
                or humanoid:GetState() == Enum.HumanoidStateType.Freefall
            )

            local desiredHeight
            local angleValue

                if passType == "Bullet" then
                    local angleText = gui.Cards.Angle.Angle.Text
                    angleValue = tonumber(angleText and angleText:match("([%d%.]+)")) or lastAngleValue

                    if isJumping then
                        angleValue = math.clamp(angleValue, 11, 45)
                    end

                    lastAngleValue = angleValue

                    if angleValue and angleValue >= 1121 then
                        if angleValue >= 32131 then
                            desiredHeight = ((horizontalDistance ^ 2) * 0.0002) + ((horizontalDistance * 0.0002) / 2) + ((horizontalDistance / 10)) + 1.5
                        else
                            desiredHeight = ((horizontalDistance ^ 2) * 0.00015) + ((horizontalDistance * 0.00015) / 2) + ((horizontalDistance / 10)) + 1
                        end
                    else
                        if angleValue >= 32131 then
                            desiredHeight = ((horizontalDistance ^ 2) * 0.00015) + ((horizontalDistance * 0.00015) / 3) + ((horizontalDistance / 13)) - 0.25
                        else
                            desiredHeight = ((horizontalDistance ^ 2) * 0.0001) + ((horizontalDistance * 0.0001) / 3) + ((horizontalDistance / 13)) - 0.75
                        end
                    end

                elseif beamMode and passType ~= "Bullet" then
                    local angleText = gui.Cards.Angle.Angle.Text
                    angleValue = tonumber(angleText and angleText:match("([%d%.]+)")) or 45

                    if angleValue >= 29.5 then
                        desiredHeight = ((horizontalDistance ^ 2) * 0.00055) + ((horizontalDistance * 0.00055) / 2) + ((horizontalDistance / 10)) + 4
                    elseif angleValue >= 25 then
                        desiredHeight = ((horizontalDistance ^ 2) * 0.0004) + ((horizontalDistance * 0.0004) / 2) + ((horizontalDistance / 10)) + 3.25
                    else
                        desiredHeight = ((horizontalDistance ^ 2) * 0.0003) + ((horizontalDistance * 0.0003) / 2) + ((horizontalDistance / 10)) + 2
                    end

                elseif autoAngle and passType ~= "Bullet" then
                    desiredHeight = ((horizontalDistance ^ 2) * 0.0013) + ((horizontalDistance * 0.0013) / 2) + ((horizontalDistance / 10) + 1) + 2

                elseif enabled and passType ~= "Bullet" then
                    angleValue = 45
                    desiredHeight = ((horizontalDistance ^ 2) * 0.00015) + ((horizontalDistance * 0.00015) / 2) + ((horizontalDistance / 10)) + 1
                end

            t = (function()
                local xMeters = desiredHeight * 4
                local a, b, c = 0.5 * g.Y, targetPosition.Y - player.Character.Head.Position.Y, xMeters - player.Character.Head.Position.Y
                local discriminant = b * b - 4 * a * c
                return discriminant >= 0 and math.max((-b + math.sqrt(discriminant)) / (2 * a), (-b - math.sqrt(discriminant)) / (2 * a)) or 0.5
            end)()

            local to = target.HumanoidRootPart.Position + (moveDirection * 20 * t) + (moveDirection * leadDistance)
            local v0

            if not autoAngle and not beamMode and enabled and passType ~= "Bullet" then
                v0 = calculateFixedAngleVelocity(player.Character.Head.Position, to, g, 45)
                if not v0 then
                    v0 = (to - player.Character.Head.Position - 0.5 * g * t * t) / t
                end
            else
                v0 = (to - player.Character.Head.Position - 0.5 * g * t * t) / t
            end

            local launchAngleFinal
            if not autoAngle and not beamMode and enabled and passType ~= "Bullet" then
                launchAngleFinal = 45
            else
                launchAngleFinal = calculateLaunchAngle(v0, horizontalDistance)
            end

            local warningColor, warningText = getAngleWarning(launchAngleFinal)

            return v0, 
                   ((player.Character.Head.Position + v0) - player.Character.Head.Position).Unit, 
                   beamMode and math.clamp(math.round(v0.Y / ((player.Character.Head.Position + v0) - player.Character.Head.Position).Unit.Y), 70, 95) 
                   or math.clamp(math.round(v0.Y / ((player.Character.Head.Position + v0) - player.Character.Head.Position).Unit.Y), 
                   passType == "Bullet" and 80 or 0, 95), 
                   t,
                   launchAngleFinal,
                   warningText
        end)()

        local curve0, curve1, cf1, cf2 = beamProjectile(Vector3.new(0, -28, 0), power * direction, player.Character.Head.Position + (direction * 5), t)
        beam.CurveSize0 = curve0
        beam.CurveSize1 = curve1
        a0.CFrame = a0.Parent.CFrame:inverse() * cf1
        a1.CFrame = a1.Parent.CFrame:inverse() * cf2

        data.Direction = direction
        data.Power = power
        data.Angle = launchAngle

        gui.Cards.Power.Power.Text = power
        gui.Cards.Mode.Mode.Text = passType
        gui.Cards.Target.Target.Text = target.Name
        gui.Cards.Airtime.Airtime.Text = string.format("%.2f s", t)
        gui.Cards.Angle.Angle.Text = launchAngle and string.format("%.1fÂ°", launchAngle) or "N/A"
    else
        highlight.Parent = nil
        gui.Enabled = false
    end
end


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local AntiJam = false
local Heartbeat
local CharCons = {}

Tab3:NewToggle({
	Name = "Anti Jam",
	default = false,
	callback = function(v)
		AntiJam = v

		if not v then
			if Heartbeat then
				Heartbeat:Disconnect()
				Heartbeat = nil
			end

			for i = 1, #CharCons do
				CharCons[i]:Disconnect()
			end
			CharCons = {}
			return
		end

		local function noCollide(char)
			local kids = char:GetChildren()
			for i = 1, #kids do
				local p = kids[i]
				if typeof(p) == "Instance" and p:IsA("BasePart") then
					p.CanCollide = false
				end
			end
		end

		local function setup(p)
			local con = p.CharacterAdded:Connect(function(char)
				local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 5)
				if hrp then noCollide(char) end
			end)
			CharCons[#CharCons + 1] = con
		end

		local plrs = Players:GetPlayers()
		for i = 1, #plrs do
			local p = plrs[i]
			if p ~= LocalPlayer then
				if p.Character then
					noCollide(p.Character)
				end
				setup(p)
			end
		end

		Heartbeat = RunService.Heartbeat:Connect(function()
			local others = Players:GetPlayers()
			for i = 1, #others do
				local p = others[i]
				if p ~= LocalPlayer and p.Character then
					noCollide(p.Character)
				end
			end
		end)
	end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local voidCharacter = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function(char)
	voidCharacter = char
end)

getgenv().voidAntiBlock = false

local function remove()
	local torso = voidCharacter and voidCharacter:FindFirstChild("Torso")
	if torso then
		local m = torso:FindFirstChild("FFmover")
		if m then
			m:Destroy()
		end
	end
end

task.spawn(function()
	while true do
		task.wait(0.1)
		if getgenv().voidAntiBlock then
			pcall(remove)
		end
	end
end)

Tab3:NewToggle({
	Name = "Anti Block",
	default = false,
	callback = function(v)
		getgenv().voidAntiBlock = v
	end
})

local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")

local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local wsToggle = false
local wsSpeed = 20

p.CharacterAdded:Connect(function(c)
	char = c
	hum = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
end)

Tab4:NewToggle({
	Name = "WalkSpeed",
	default = false,
	callback = function(v)
		wsToggle = v
		if not v then
			hum.WalkSpeed = 16
		else
			hum.WalkSpeed = wsSpeed
		end
	end
})

Tab4:NewSlider({
	Name = "WalkSpeed Amount",
	min = 20,
	max = 23,
	default = 20,
	decimals = 0.1,
	callback = function(v)
		wsSpeed = v
		if wsToggle then
			hum.WalkSpeed = v
		end
	end
})

rs.Heartbeat:Connect(function()
	if wsToggle and hum and hrp then
		local mv = hum.MoveDirection
		if mv.Magnitude > 0 then
			local vx = mv.X * wsSpeed
			local vz = mv.Z * wsSpeed
			hrp.Velocity = Vector3.new(vx, hrp.Velocity.Y, vz)
		end
	end
end)

Tab4:NewToggle({
	Name = "Cframe",
	default = false,
	callback = function(v)
		getgenv().cframeSpeedEnabled = v
		if not v then
			run = false
			if th then
				task.cancel(th)
				th = nil
			end
		elseif not th then
			run = true
			th = task.spawn(function()
				while run and getgenv().cframeSpeedEnabled do
					task.wait()
					local c = p.Character
					local h = c and c:FindFirstChild("Humanoid")
					local hrp = c and c:FindFirstChild("HumanoidRootPart")
					if not h or not hrp then continue end
					local dir = h.MoveDirection
					if dir.Magnitude > 0 then
						local spd = getgenv().cframeSpeed
						if getgenv().walkType == "Velocity Speed" then
							hrp.Velocity = dir * (spd * 10)
						elseif getgenv().walkType == "CFrame Speed" then
							hrp.CFrame += dir * (spd / 58.5)
						end
					end
				end
			end)
		end
	end
})

Tab4:NewSlider({
	Name = "Cframe slider",
	min = 1,
	max = 20,
	default = 1,
	increment = 0.1,
	callback = function(v)
		getgenv().cframeSpeed = v
	end
})

Tab4:NewDropDown({
	Name = "Speed Type",
	options = { "CFrame Speed", "Velocity Speed" },
	default = "CFrame Speed",
	callback = function(v)
		getgenv().walkType = v
	end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Character, Humanoid, RootPart
local JumpEnabled, JumpPower, SavedPower = false, 0, 0

local function OnCharacterLoad()
	Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	RootPart = Character:WaitForChild("HumanoidRootPart")

	Humanoid.StateChanged:Connect(function(_, state)
		if state == Enum.HumanoidStateType.Jumping and JumpEnabled then
			task.delay(0.02, function()
				if RootPart and JumpEnabled then
					-- Apply smooth upward force without clipping into ceilings
					RootPart.Velocity = Vector3.new(RootPart.Velocity.X, JumpPower, RootPart.Velocity.Z)
				end
			end)
		end
	end)
end

OnCharacterLoad()
LocalPlayer.CharacterAdded:Connect(OnCharacterLoad)

Tab4:NewToggle({
	Name = "Enable JumpPower",
	default = false,
	callback = function(state)
		JumpEnabled = state
		if not state then
			SavedPower = JumpPower
			JumpPower = 0
		else
			JumpPower = SavedPower
		end
	end
})

Tab4:NewSlider({
	Name = "JumpPower Value",
	min = 50,
	max = 70,
	default = 50,
	decimals = 0.1,
	callback = function(value)
		if JumpEnabled then
			JumpPower = value
			SavedPower = value
		end
	end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

getgenv().ToggleSettings = getgenv().ToggleSettings or {}
getgenv().ToggleSettings.AngleEnhancer = false
getgenv().ToggleSettings.AngleJumpPower = 50
getgenv().VoidCreator = "Void aka Staff"

local function applyJumpBoost(character)
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")

	humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Jumping and getgenv().ToggleSettings.AngleEnhancer then
			task.wait(0.05)
			local velocity = rootPart.AssemblyLinearVelocity
			local jumpPower = getgenv().AngleBoosting and getgenv().ToggleSettings.AngleJumpPower or (getgenv().ToggleSettings.AngleJumpPower - 10)
			rootPart.AssemblyLinearVelocity = Vector3.new(velocity.X, jumpPower, velocity.Z)
		end
	end)
end

local function activateBoost()
	if not getgenv().AngleBoosting then
		getgenv().AngleBoosting = true
		local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		applyJumpBoost(character)

		task.delay(0.25, function()
			getgenv().AngleBoosting = false
		end)
	end
end

local function isShiftPressed()
	return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
end

for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(applyJumpBoost)
	if player.Character then
		applyJumpBoost(player.Character)
	end
end

RunService.RenderStepped:Connect(function()
	if getgenv().ToggleSettings.AngleEnhancer and isShiftPressed() then
		activateBoost()
	end
end)

Tab4:NewToggle({
	Name = "Angle Enhancer",
	default = false,
	callback = function(v)
		getgenv().ToggleSettings.AngleEnhancer = v
	end
})

Tab4:NewSlider({
	Name = "Custom Angle Range",
	min = 50,
	max = 70,
	default = 50,
	callback = function(v)
		getgenv().ToggleSettings.AngleJumpPower = v
	end
})

local p = game:GetService("Players").LocalPlayer

local function VoidJumpCooldownBypass(c)
	local h = c:WaitForChild("Humanoid")
	task.spawn(function()
		while c and c.Parent and h and getgenv().Void_NoJumpCooldown do
			task.wait()
			h:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		end
	end)
end

if p.Character then
	VoidJumpCooldownBypass(p.Character)
end

p.CharacterAdded:Connect(function(c)
	if getgenv().Void_NoJumpCooldown then
		VoidJumpCooldownBypass(c)
	end
end)

Tab4:NewToggle({
	Name = "No Jump Cooldown",
	default = false,
	callback = function(v)
		getgenv().Void_NoJumpCooldown = v
		if v and p.Character then
			VoidJumpCooldownBypass(p.Character)
		end
	end
})

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

getgenv().VoidQuickTP = false
getgenv().VoidTPDistance = 0
getgenv().VoidShowMobileTP = false

local screenGui, textButton

local function VoidTeleportForward()
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:FindFirstChild("HumanoidRootPart")
	if root then
		local dir = root.CFrame.LookVector
		local pos = root.Position + dir * getgenv().VoidTPDistance
		root.CFrame = CFrame.new(pos, pos + dir)
	end
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.F and getgenv().VoidQuickTP then
		VoidTeleportForward()
	end
end)

local function createMobileTPButton()
	if screenGui then screenGui:Destroy() end
	screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	screenGui.Name = "VoidMobileTPGui"
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	textButton = Instance.new("TextButton", screenGui)
	textButton.Size = UDim2.new(0, 70, 0, 70)
	textButton.Position = UDim2.new(0.5, -35, 1, -100)
	textButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	textButton.Text = "TP"
	textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton.Font = Enum.Font.GothamBold
	textButton.TextSize = 22

	local corner = Instance.new("UICorner", textButton)
	corner.CornerRadius = UDim.new(0.5, 0)

	textButton.MouseButton1Click:Connect(function()
		if getgenv().VoidQuickTP then
			VoidTeleportForward()
		end
	end)
end

local function removeMobileTPButton()
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
end

Tab4:NewToggle({
	Name = "Quick TP (Press F)",
	default = false,
	callback = function(v)
		getgenv().VoidQuickTP = v
	end
})

Tab4:NewSlider({
	Name = "TP Distance",
	min = 0,
	max = 5,
	default = 0,
	callback = function(v)
		getgenv().VoidTPDistance = v
	end
})

Tab4:NewToggle({
	Name = "Show Button (Mobile)",
	default = false,
	callback = function(v)
		getgenv().VoidShowMobileTP = v
		if v then
			createMobileTPButton()
		else
			removeMobileTPButton()
		end
	end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

getgenv().tackleReachEnabled = getgenv().tackleReachEnabled or false
getgenv().tackleReachRange = getgenv().tackleReachRange or 15
getgenv().tackleReachConnection = getgenv().tackleReachConnection or nil
getgenv().showTackleHitbox = getgenv().showTackleHitbox or false

local function fireTouchInterest(part1, part2, toggle)
    firetouchinterest(part1, part2, toggle)
end

local function activateTackleReach()
    if getgenv().tackleReachConnection then
        getgenv().tackleReachConnection:Disconnect()
    end

    getgenv().tackleReachConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().tackleReachEnabled then return end

        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for i = 1, #Players:GetPlayers() do
            local plr = Players:GetPlayers()[i]
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local target = plr.Character.HumanoidRootPart
                local dist = (hrp.Position - target.Position).Magnitude
                if dist <= getgenv().tackleReachRange then
                    for j = 1, #plr.Character:GetChildren() do
                        local p = plr.Character:GetChildren()[j]
                        if p:IsA("BasePart") and char:FindFirstChild(p.Name) then
                            fireTouchInterest(char[p.Name], p, 0)
                            fireTouchInterest(char[p.Name], p, 1)
                        end
                    end
                end
            end
        end
    end)
end

Tab4:NewToggle({
    Name = "Tackle Reach",
    default = false,
    callback = function(v)
        getgenv().tackleReachEnabled = v
        if v then
            activateTackleReach()
        else
            if getgenv().tackleReachConnection then
                getgenv().tackleReachConnection:Disconnect()
                getgenv().tackleReachConnection = nil
            end
        end
    end
})

Tab4:NewSlider({
    Name = "Custom Reach",
    min = 0,
    max = 25,
    default = getgenv().tackleReachRange,
    callback = function(v)
        getgenv().tackleReachRange = v
    end
})

Tab4:NewToggle({
    Name = "Show Hitbox",
    default = false,
    callback = function(v)
        getgenv().showTackleHitbox = v
    end
})

Tab5:NewToggle({
	Name = "Jump predictions",
	default = false,
	callback = function(v)
	if v then
        local player = game:GetService("Players").LocalPlayer

		local function handleBall(ball)
			if ball.Name == "Football" and ball:IsA("BasePart") then
				local v0 = ball.Velocity
				local x0 = ball.Position
				local dt = 1/30
				local grav = Vector3.new(0, -28, 0)
				local points = {
					[1] = x0
				}
				local function check(p, v0)
					local raycastParams = RaycastParams.new()
					raycastParams.RespectCanCollide = true
					local ray = workspace:Raycast(p, Vector3.new(0, -1000, 0), raycastParams)
					local ray2 = workspace:Raycast(p, Vector3.new(0, -7.2 * 2, 0), raycastParams)
					return ray and not ray2
				end
				while true do
					if not check(points[#points], v0) then
						if v0.Y < 0 then
							break
						end
					end
					local currentPoint = points[#points]
					v0 += grav * dt
					points[#points + 1] = currentPoint + (v0 * dt)
				end
				local optimal = points[#points]
				local part = Instance.new("Part")
				part.Anchored = true
				part.CanCollide = false
				part.Position = Vector3.new(optimal.X, player.Character.HumanoidRootPart.Position.Y + 1.5, optimal.Z)
				part.Parent = workspace
				part.Material = Enum.Material.Neon
				part.Size = Vector3.new(1.5, 1.5, 1.5)
				repeat task.wait() until ball.Parent ~= workspace
				part:Destroy()
			end
		end
--slant
		local function handleChildAdded(ball)
			task.wait()
			handleBall(ball)
		end
		eventConnection = workspace.ChildAdded:Connect(handleChildAdded)
	else
		if eventConnection then
			eventConnection:Disconnect()
			eventConnection = nil
		end
	end
end})

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Grapher = getgenv().Grapher or {}
getgenv().Grapher = Grapher

if not Grapher.Init then
    Grapher.Init = true
    Grapher.Width = 0.6
    Grapher.CastStep = 3 / 60
    Grapher.Gravity = 28
    Grapher.VisualizerEnabled = false
    Grapher.LastUpdate = 0

    local template = Instance.new("Part")
    template.Anchored = true
    template.CanCollide = false
    template.Transparency = 1
    template.Name = "BeamHolderTemplate"
    Grapher.Template = template

    function Grapher:GetFolder()
        local f = workspace:FindFirstChild("CorePackages")
        if not f then
            f = Instance.new("Folder", workspace)
            f.Name = "CorePackages"
        end
        return f
    end

    function Grapher:GetDynamicColor()
        local t = tick() * 2
        local lerpVal = (math.sin(t) + 1) / 2
        local babyBlue = Color3.fromRGB(137, 207, 240)
        local babyPurple = Color3.fromRGB(180, 167, 214)
        return babyBlue:Lerp(babyPurple, lerpVal)
    end

    function Grapher:Segment(p0, p1)
        local part = self.Template:Clone()
        part.Parent = self:GetFolder()

        local a0 = Instance.new("Attachment", part)
        a0.WorldPosition = p0
        local a1 = Instance.new("Attachment", part)
        a1.WorldPosition = p1

        local beam = Instance.new("Beam")
        beam.Attachment0 = a0
        beam.Attachment1 = a1
        beam.Color = ColorSequence.new(self:GetDynamicColor())
        beam.Transparency = NumberSequence.new(0.1)
        beam.Width0 = self.Width
        beam.Width1 = self.Width
        beam.FaceCamera = true
        beam.LightEmission = 1
        beam.TextureSpeed = 1
        beam.Parent = part

        part.Material = Enum.Material.Neon
        part.Color = beam.Color.Keypoints[1].Value

        game:GetService("Debris"):AddItem(part, 4)
    end

    function Grapher:Trajectory(origin, velocity)
        local points, elapsed = {}, 0
        while elapsed < 5 do
            elapsed += self.CastStep
            local pos = origin + velocity * elapsed - Vector3.new(0, 0.5 * self.Gravity * elapsed^2, 0)
            table.insert(points, pos)
        end
        for i = 1, #points - 1 do
            self:Segment(points[i], points[i + 1])
        end
    end

    function Grapher:Run(position, velocity)
        local now = tick()
        if now - self.LastUpdate < 0.15 then return end
        self.LastUpdate = now
        self:Trajectory(position, velocity)
    end

    Workspace.ChildAdded:Connect(function(child)
        if child:IsA("BasePart") and child.Name == "Football" then
            local c
            c = child:GetPropertyChangedSignal("Velocity"):Connect(function()
                if Grapher.VisualizerEnabled then
                    Grapher:Run(child.Position, child.Velocity)
                end
                c:Disconnect()
            end)
        end
    end)
end

Tab5:NewToggle({
    Name = "Ball Path",
    default = false,
    callback = function(v)
        getgenv().Grapher.VisualizerEnabled = v
    end
})				