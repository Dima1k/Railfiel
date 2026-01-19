-- SERVICES
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- WINDOW
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.8, 0, 0.55, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- LAYOUT
local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
Instance.new("UIPadding", frame).PaddingTop = UDim.new(0, 20)

-- BUTTON CREATOR
local function createButton(text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0.15, 0)
	btn.Text = text
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Parent = frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)
	return btn
end

-- ================= SPEED =================
local speedButton = createButton("Швидкість: OFF")
local speedEnabled = false
local SPEED_ON = 30
local SPEED_OFF = 16

local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()

player.CharacterAdded:Connect(function()
	task.wait(0.2)
	humanoid = getHumanoid()
	if speedEnabled then
		humanoid.WalkSpeed = SPEED_ON
	end
end)

speedButton.Activated:Connect(function()
	speedEnabled = not speedEnabled
	if speedEnabled then
		humanoid.WalkSpeed = SPEED_ON
		speedButton.Text = "Швидкість: ON"
	else
		humanoid.WalkSpeed = SPEED_OFF
		speedButton.Text = "Швидкість: OFF"
	end
end)

-- ================= ESP ГРАВЦІ =================
local espPlayersButton = createButton("ESP Гравці: OFF")
local espPlayersEnabled = false
local playerHighlights = {}

local function addPlayerESP(plr)
	if plr == player then return end
	if playerHighlights[plr] then playerHighlights[plr]:Destroy() end
	local char = plr.Character
	if char then
		local h = Instance.new("Highlight")
		h.FillColor = Color3.fromRGB(0, 120, 255)
		h.OutlineColor = Color3.fromRGB(255, 255, 255)
		h.FillTransparency = 0.5
		h.Adornee = char
		h.Parent = char
		playerHighlights[plr] = h
	end
end

local function removePlayerESP()
	for _, h in pairs(playerHighlights) do
		if h then h:Destroy() end
	end
	playerHighlights = {}
end

espPlayersButton.Activated:Connect(function()
	espPlayersEnabled = not espPlayersEnabled
	if espPlayersEnabled then
		espPlayersButton.Text = "ESP Гравці: ON"
		for _, plr in pairs(Players:GetPlayers()) do
			addPlayerESP(plr)
		end
	else
		espPlayersButton.Text = "ESP Гравці: OFF"
		removePlayerESP()
	end
end)

-- Авто-оновлення для нових гравців
Players.PlayerAdded:Connect(function(plr)
	if espPlayersEnabled then
		addPlayerESP(plr)
	end
end)

-- ================= ESP Rake =================
local espRakeButton = createButton("ESP Rake: OFF")
local espRakeEnabled = false
local rakeHighlights = {}

local function addRakeESP(model)
	if rakeHighlights[model] then return end
	local h = Instance.new("Highlight")
	h.FillColor = Color3.fromRGB(255, 0, 0)
	h.OutlineColor = Color3.fromRGB(255, 255, 255)
	h.FillTransparency = 0.4
	h.Adornee = model
	h.Parent = model
	rakeHighlights[model] = h
end

local function removeRakeESP()
	for _, h in pairs(rakeHighlights) do
		if h then h:Destroy() end
	end
	rakeHighlights = {}
end

local function scanRake()
	for _, obj in pairs(Workspace:GetChildren()) do
		if obj:IsA("Model") and obj.Name == "Rake" then
			addRakeESP(obj)
		end
	end
end

espRakeButton.Activated:Connect(function()
	espRakeEnabled = not espRakeEnabled
	if espRakeEnabled then
		espRakeButton.Text = "ESP Rake: ON"
		scanRake()
	else
		espRakeButton.Text = "ESP Rake: OFF"
		removeRakeESP()
	end
end)

-- Авто-оновлення при додаванні нового Rake
Workspace.ChildAdded:Connect(function(child)
	if espRakeEnabled and child:IsA("Model") and child.Name == "Rake" then
		addRakeESP(child)
	end
end)

-- ================= ESP SCRAP =================
local espScrapButton = createButton("ESP Scrap: OFF")
local espScrapEnabled = false
local scrapHighlights = {}
local scrapNames = {"scrap1","scrap2","scrap3","scrap4","scrap5"}

local function addScrapESP(model)
	if scrapHighlights[model] then return end
	local h = Instance.new("Highlight")
	h.FillColor = Color3.fromRGB(255, 255, 0) -- жовтий
	h.OutlineColor = Color3.fromRGB(255,255,255)
	h.FillTransparency = 0.4
	h.Adornee = model
	h.Parent = model
	scrapHighlights[model] = h
end

local function removeScrapESP()
	for _, h in pairs(scrapHighlights) do
		if h then h:Destroy() end
	end
	scrapHighlights = {}
end

local function scanScrap()
	for _, obj in pairs(Workspace:GetChildren()) do
		if obj:IsA("Model") and table.find(scrapNames,obj.Name) then
			addScrapESP(obj)
		end
	end
end

espScrapButton.Activated:Connect(function()
	espScrapEnabled = not espScrapEnabled
	if espScrapEnabled then
		espScrapButton.Text = "ESP Scrap: ON"
		scanScrap()
	else
		espScrapButton.Text = "ESP Scrap: OFF"
		removeScrapESP()
	end
end)

-- Авто-оновлення для Scrap1-5
Workspace.ChildAdded:Connect(function(child)
	if espScrapEnabled and child:IsA("Model") and table.find(scrapNames, child.Name) then
		addScrapESP(child)
	end
end)

-- ================= CLOSE BUTTON =================
local closeButton = createButton("Закрити")
closeButton.Activated:Connect(function()
	frame.Visible = false
end)
