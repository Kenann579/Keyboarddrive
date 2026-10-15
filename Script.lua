-- Simple KeyCode + Mobile Buttons
-- Only detects the keys, nothing else

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ===== KEY STATES =====
local Keys = {
	[Enum.KeyCode.Z] = false,
	[Enum.KeyCode.C] = false,
	[Enum.KeyCode.X] = false,
	[Enum.KeyCode.Q] = false,
	[Enum.KeyCode.E] = false,
	[Enum.KeyCode.W] = false,
	[Enum.KeyCode.A] = false,
	[Enum.KeyCode.S] = false,
	[Enum.KeyCode.D] = false,
}

_G.Keys = Keys  -- Access from other scripts: _G.Keys[Enum.KeyCode.Z]

-- ========== MOBILE GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyCodeButtons"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local function createButton(name, text, size, position)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = size
	btn.Position = position
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.BackgroundTransparency = 0.35
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.AutoButtonColor = false
	btn.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = btn

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Thickness = 1.5
	stroke.Transparency = 0.6
	stroke.Parent = btn

	return btn
end

-- Left middle
local btnA = createButton("A", "A", UDim2.new(0, 70, 0, 70), UDim2.new(0, 30, 0.55, 0))
local btnD = createButton("D", "D", UDim2.new(0, 70, 0, 70), UDim2.new(0, 115, 0.55, 0))

-- Right middle
local btnW = createButton("W", "W", UDim2.new(0, 70, 0, 70), UDim2.new(1, -185, 0.42, 0))
local btnS = createButton("S", "S", UDim2.new(0, 70, 0, 70), UDim2.new(1, -185, 0.55, 0))

-- Top Left
local btnZ = createButton("Z", "Z", UDim2.new(0, 55, 0, 55), UDim2.new(0, 20, 0, 20))
local btnC = createButton("C", "C", UDim2.new(0, 55, 0, 55), UDim2.new(0, 85, 0, 20))
local btnX = createButton("X", "X", UDim2.new(0, 55, 0, 55), UDim2.new(0, 150, 0, 20))

-- Right middle (higher)
local btnQ = createButton("Q", "Q", UDim2.new(0, 55, 0, 55), UDim2.new(1, -130, 0.32, 0))
local btnE = createButton("E", "E", UDim2.new(0, 55, 0, 55), UDim2.new(1, -65, 0.32, 0))

-- Show only on mobile
local function updateVisibility()
	local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	screenGui.Enabled = isMobile
end
updateVisibility()
UserInputService.LastInputTypeChanged:Connect(updateVisibility)

-- ========== BUTTON VISUAL ==========
local function setButtonVisual(btn, active)
	if active then
		btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		btn.BackgroundTransparency = 0.15
	else
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		btn.BackgroundTransparency = 0.35
	end
end

local function bindButton(btn, keyCode)
	btn.MouseButton1Down:Connect(function()
		Keys[keyCode] = true
		setButtonVisual(btn, true)
	end)
	btn.MouseButton1Up:Connect(function()
		Keys[keyCode] = false
		setButtonVisual(btn, false)
	end)
	btn.MouseLeave:Connect(function()
		Keys[keyCode] = false
		setButtonVisual(btn, false)
	end)
end

bindButton(btnW, Enum.KeyCode.W)
bindButton(btnS, Enum.KeyCode.S)
bindButton(btnA, Enum.KeyCode.A)
bindButton(btnD, Enum.KeyCode.D)
bindButton(btnZ, Enum.KeyCode.Z)
bindButton(btnC, Enum.KeyCode.C)
bindButton(btnX, Enum.KeyCode.X)
bindButton(btnQ, Enum.KeyCode.Q)
bindButton(btnE, Enum.KeyCode.E)

-- ========== KEYBOARD ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if Keys[input.KeyCode] \~= nil then
		Keys[input.KeyCode] = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if Keys[input.KeyCode] \~= nil then
		Keys[input.KeyCode] = false
	end
end)
