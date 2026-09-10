-- -----------------------------------------------------------------------------
-- PINATHUB UI LIBRARY — OFFICIAL EDITION
-- Official PinatHub Neon Identity & Glassmorphism Theme System
-- Discord: https://discord.gg/ysHZCYFaX7
-- Komunitas Utama WhatsApp (XploitForce): https://chat.whatsapp.com/CjbAhfWTAKx1mU3O6KEJgp
-- YouTube Channel: https://www.youtube.com/@viunzee1
-- Topbar & Menu Overlay Enabled
-- Custom Elements & TweenService Animations
-- -----------------------------------------------------------------------------

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- -----------------------------------------------------------------------------
-- 1. BRANDING & ASSETS
-- -----------------------------------------------------------------------------
local PINATHUB_LOGO = "rbxassetid://118264723961739"

local TabIcons = {
	-- PinatHub Drain Water Specific Tabs
	["Auto Farm"] = "rbxassetid://10723344432",   -- Droplet
	["Farm"] = "rbxassetid://10723344432",        -- Droplet
	["Upgrades"] = "rbxassetid://10709768939",    -- Arrow Up
	["Upgrade"] = "rbxassetid://10709768939",     -- Arrow Up
	["Fish & Pets"] = "rbxassetid://10709761530", -- Anchor (Marine / Aquatic / Fish)
	["Fish"] = "rbxassetid://10709761530",        -- Anchor
	["Pets"] = "rbxassetid://10709769841",        -- Backpack / Pet Pack
	["Auto Sell"] = "rbxassetid://10723343958",   -- Dollar Sign
	["Sell"] = "rbxassetid://10723343958",        -- Dollar Sign
	["Advanced"] = "rbxassetid://10747383470",    -- Wrench / Tools
	["Live Stats"] = "rbxassetid://10709770317",  -- Bar Chart 2
	["Stats"] = "rbxassetid://10709770317",       -- Bar Chart 2
	["Community"] = "rbxassetid://10747373426",   -- Users

	-- Standard Lucide Icons by String Name
	["droplet"] = "rbxassetid://10723344432",
	["fish"] = "rbxassetid://10709761530",
	["anchor"] = "rbxassetid://10709761530",
	["backpack"] = "rbxassetid://10709769841",
	["arrow-up"] = "rbxassetid://10709768939",
	["dollar-sign"] = "rbxassetid://10723343958",
	["coins"] = "rbxassetid://10709811110",
	["settings"] = "rbxassetid://10734950309",
	["sliders"] = "rbxassetid://10734963400",
	["bar-chart"] = "rbxassetid://10709773755",
	["bar-chart-2"] = "rbxassetid://10709770317",
	["chart-bar"] = "rbxassetid://10709770317",
	["users"] = "rbxassetid://10747373426",
	["user"] = "rbxassetid://10747373176",
	["crosshair"] = "rbxassetid://10709818534",
	["target"] = "rbxassetid://10734977012",
	["skull"] = "rbxassetid://10734962068",
	["eye"] = "rbxassetid://10723346959",
	["swords"] = "rbxassetid://10734975692",
	["sword"] = "rbxassetid://10734975486",
	["backpack"] = "rbxassetid://10709769841",
	["shield"] = "rbxassetid://10734951847",
	["wrench"] = "rbxassetid://10747383470",
	["cpu"] = "rbxassetid://10709813383",
	["activity"] = "rbxassetid://10709752035",
	["heart"] = "rbxassetid://10723406885",
	["home"] = "rbxassetid://10723407389",
	["search"] = "rbxassetid://10734943674",
	["bell"] = "rbxassetid://10709775704",
	["flame"] = "rbxassetid://10723376114",
	["database"] = "rbxassetid://10709818996",
	["discord"] = "rbxassetid://10734950553",
	["message-circle"] = "rbxassetid://10734888000",
	["video"] = "rbxassetid://10747374938",
	["youtube"] = "rbxassetid://10747374938",
	["globe"] = "rbxassetid://10723404337",
	["clipboard-check"] = "rbxassetid://10709783474",
	["zap"] = "rbxassetid://7733920644",
	["lightning"] = "rbxassetid://7733920644",
	["automation"] = "rbxassetid://7733920644",
	["bolt"] = "rbxassetid://7733920644",
	["sparkles"] = "rbxassetid://10734973351",
	["star"] = "rbxassetid://10734973351",
	["box"] = "rbxassetid://10734954201",
	["package"] = "rbxassetid://10734954201",
	["compass"] = "rbxassetid://7733924216",
	["teleport"] = "rbxassetid://7733992789",
	["map-pin"] = "rbxassetid://7733992789",
	["map"] = "rbxassetid://7733964719",
	["navigation"] = "rbxassetid://7734020989",
	["locate"] = "rbxassetid://7733964719",
	["waypoint"] = "rbxassetid://7733992789",
	["gem"] = "rbxassetid://10723387847",
	["diamond"] = "rbxassetid://10723387847",
	["trophy"] = "rbxassetid://10747372167",
	["cart"] = "rbxassetid://10734954483",
	["shopping-cart"] = "rbxassetid://10734954483",
	["lock"] = "rbxassetid://10734920623",
	["unlock"] = "rbxassetid://10734920832",
	["terminal"] = "rbxassetid://10709787610",
	["code"] = "rbxassetid://10709787610",
	["folder"] = "rbxassetid://10723387563",
	["refresh"] = "rbxassetid://10734940608",
	["play"] = "rbxassetid://10734923549",
	["check"] = "rbxassetid://10709782497",
	["info"] = "rbxassetid://10723415903",
	["alert"] = "rbxassetid://10709752906",


	-- General Navigation & UI Icons
	Main = "rbxassetid://10723407389",
	Info = "rbxassetid://10723406988",            -- Help / Info circle
	Survivor = "rbxassetid://10734975692",        -- Swords
	Killer = "rbxassetid://10734962068",          -- Skull
	Automation = "rbxassetid://7733920644",      -- Zap / Bolt
	["Automation"] = "rbxassetid://7733920644",
	ESP = "rbxassetid://10723346959",             -- Eye
	Visuals = "rbxassetid://10723346959",         -- Eye
	Teleport = "rbxassetid://7733992789",         -- Official Roblox Creator Store Map-Pin
	["Teleport"] = "rbxassetid://7733992789",
	["Emote & Skin"] = "rbxassetid://10747373176",-- User
	Emote = "rbxassetid://10747373176",           -- User
	Aimbot = "rbxassetid://10709818534",          -- Crosshair (FIXED, NOT BLANK)
	Settings = "rbxassetid://10734950309",        -- Gear
	Configuration = "rbxassetid://10734963400",   -- Sliders
	Config = "rbxassetid://10734963400",          -- Sliders
	Player = "rbxassetid://10747373176",          -- User
	Misc = "rbxassetid://10747383470",            -- Wrench
	Credits = "rbxassetid://10723406988",         -- Help / Info
	Search = "rbxassetid://10734943674",          -- Search (FIXED)
	Minimize = "rbxassetid://10734896206",
	Maximize = "rbxassetid://10734914561",
	Close = "rbxassetid://10747384394",
	ChevronRight = "rbxassetid://10709791437",
	ChevronDown = "rbxassetid://10709790948",
	Discord = "rbxassetid://10734950553",
	Cursor = "rbxassetid://10709818534"
}

-- Shared Icon Resolver for Tabs, Buttons, and UI Components
local function ResolveIcon(iconInput, fallbackTitle)
	if type(iconInput) == "string" then
		local trimmed = string.match(iconInput, "^%s*(.-)%s*$") or iconInput
		if string.sub(trimmed, 1, 13) == "rbxassetid://" or string.sub(trimmed, 1, 10) == "rbxasset://" or string.sub(trimmed, 1, 4) == "http" then
			return trimmed
		end
		if TabIcons[trimmed] then
			return TabIcons[trimmed]
		end
		local lowerName = string.lower(trimmed)
		if TabIcons[lowerName] then
			return TabIcons[lowerName]
		end
	end
	if fallbackTitle then
		if TabIcons[fallbackTitle] then
			return TabIcons[fallbackTitle]
		end
		local lowerTitle = string.lower(fallbackTitle)
		if TabIcons[lowerTitle] then
			return TabIcons[lowerTitle]
		end
	end
	return "rbxassetid://10723407389" -- Default Lucide Home Icon
end

-- Detect Executor Name dynamically
local function DetectExecutor()
	if identifyexecutor then
		local name, ver = identifyexecutor()
		if name then
			return tostring(name) .. (ver and (" " .. tostring(ver)) or "")
		end
	end
	if syn then return "Synapse X" end
	if KRNL_LOADED then return "Krnl" end
	if fluxus then return "Fluxus" end
	if shadow_loaded then return "Shadow" end
	if delta then return "Delta" end
	if getexecutorname then return tostring(getexecutorname()) end
	return "Vortex"
end

-- -----------------------------------------------------------------------------
-- 2. COLOR PALETTE: PinatHub DARK OBSIDIAN & AMETHYST PURPLE
-- -----------------------------------------------------------------------------
local Theme = {
	Background = Color3.fromRGB(15, 14, 20),
	Header = Color3.fromRGB(20, 18, 28),
	Sidebar = Color3.fromRGB(17, 16, 24),
	Surface = Color3.fromRGB(25, 23, 35),
	SurfaceHover = Color3.fromRGB(34, 31, 48),
	SurfaceActive = Color3.fromRGB(46, 41, 66),

	Text = Color3.fromRGB(245, 245, 250),
	TextSecondary = Color3.fromRGB(170, 168, 185),
	TextMuted = Color3.fromRGB(115, 112, 130),

	Accent = Color3.fromRGB(168, 85, 247),       -- Vibrant Amethyst Purple
	AccentGlow = Color3.fromRGB(192, 132, 252),   -- Lighter Purple Glow
	NeonWhite = Color3.fromRGB(245, 247, 255),
	NeonGray = Color3.fromRGB(195, 202, 214),

	Success = Color3.fromRGB(74, 222, 128),       -- Vivid Green
	Warning = Color3.fromRGB(251, 191, 36),       -- Amber
	Danger = Color3.fromRGB(248, 113, 113),       -- Crimson Red

	Border = Color3.fromRGB(58, 52, 80),
	BorderSoft = Color3.fromRGB(38, 35, 52),
	BorderAccent = Color3.fromRGB(120, 75, 200),
}

-- Easing tokens for ultra-smooth responsiveness
local TweenInfoFast = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfoSmooth = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TweenInfoSpring = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- -----------------------------------------------------------------------------
-- 3. LIBRARY CORE & UTILITIES
-- -----------------------------------------------------------------------------
local Library = {
	Theme = Theme,
	Logo = PINATHUB_LOGO,
	CurrentWindow = nil,
	NotificationHolder = nil,
	_ControlSetters = {},
	-- Global registry of all expanded paragraph frames for click-outside-to-close
	_ActiveParaFrames = {}
}

function Library:TweenInstance(instance, time, prop, value, easingStyle, easingDir)
	local tweenInfo = TweenInfo.new(
		time or 0.2,
		easingStyle or Enum.EasingStyle.Quad,
		easingDir or Enum.EasingDirection.Out
	)
	local tween = TweenService:Create(instance, tweenInfo, { [prop] = value })
	tween:Play()
	return tween
end

function Library:MakeConfig(defaults, userConfig)
	local result = {}
	for k, v in pairs(defaults) do
		result[k] = v
	end
	if type(userConfig) == "table" then
		for k, v in pairs(userConfig) do
			result[k] = v
		end
	end
	return result
end

function Library:MakeDraggable(dragBar, mainObject)
	local dragging = false
	local dragStart = nil
	local startPos = nil

	dragBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainObject.Position

			local endedConn
			endedConn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					endedConn:Disconnect()
				end
			end)
		end
	end)

	dragBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragging and dragStart and startPos then
				local delta = input.Position - dragStart
				mainObject.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end
	end)
end

function Library:UpdateScrolling(scrollFrame, uiLayout)
	local function update()
		scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiLayout.AbsoluteContentSize.Y + 16)
	end
	uiLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
	task.defer(update)
end

-- -----------------------------------------------------------------------------
-- 4. MODERN TOAST NOTIFICATION SYSTEM (Top-Right, Slide-In)
-- -----------------------------------------------------------------------------
function Library:Notify(config)
	local cfg = self:MakeConfig({
		Title = "PinatHub",
		Content = "",
		Duration = 3.5,
		Type = "Info",
		Icon = nil
	}, config or {})

	if not self.NotificationHolder then return end

	-- Type → accent color + icon mapping
	local typeColor = Theme.Accent
	local typeIcon  = TabIcons.Info or PINATHUB_LOGO
	if cfg.Type == "Success" then
		typeColor = Theme.Success
		typeIcon  = TabIcons.check or TabIcons["check"] or PINATHUB_LOGO
	elseif cfg.Type == "Warning" then
		typeColor = Theme.Warning
		typeIcon  = TabIcons.alert or TabIcons["alert"] or PINATHUB_LOGO
	elseif cfg.Type == "Danger" or cfg.Type == "Error" then
		typeColor = Theme.Danger
		typeIcon  = TabIcons["skull"] or PINATHUB_LOGO
	elseif cfg.Type == "Info" then
		typeColor = Theme.AccentGlow
		typeIcon  = TabIcons.info or TabIcons["info"] or PINATHUB_LOGO
	end
	if cfg.Icon then typeIcon = ResolveIcon(cfg.Icon) or typeIcon end

	-- ── Toast Card ──────────────────────────────────────────────────────────
	local Toast = Instance.new("Frame")
	Toast.Name = "Toast_" .. cfg.Title
	Toast.Parent = self.NotificationHolder
	Toast.BackgroundColor3 = Theme.Header
	Toast.BackgroundTransparency = 0.08
	Toast.BorderSizePixel = 0
	Toast.Size = UDim2.new(1, 0, 0, 0)  -- grows in via tween
	Toast.ClipsDescendants = false
	-- Start off-screen to the right for slide-in
	Toast.Position = UDim2.new(1.1, 0, 0, 0)

	local ToastCorner = Instance.new("UICorner")
	ToastCorner.CornerRadius = UDim.new(0, 10)
	ToastCorner.Parent = Toast

	-- Outer glow stroke matching type color
	local ToastStroke = Instance.new("UIStroke")
	ToastStroke.Color = typeColor
	ToastStroke.Thickness = 1.2
	ToastStroke.Transparency = 0.55
	ToastStroke.Parent = Toast

	-- Left accent bar
	local LeftBar = Instance.new("Frame")
	LeftBar.Name = "AccentBar"
	LeftBar.Parent = Toast
	LeftBar.BackgroundColor3 = typeColor
	LeftBar.BorderSizePixel = 0
	LeftBar.Position = UDim2.new(0, 0, 0, 8)
	LeftBar.Size = UDim2.new(0, 3, 1, -16)
	LeftBar.ZIndex = 3

	local BarCorner = Instance.new("UICorner")
	BarCorner.CornerRadius = UDim.new(1, 0)
	BarCorner.Parent = LeftBar

	-- Type icon badge
	local IconCircle = Instance.new("Frame")
	IconCircle.Name = "IconBadge"
	IconCircle.Parent = Toast
	IconCircle.AnchorPoint = Vector2.new(0, 0.5)
	IconCircle.Position = UDim2.new(0, 14, 0, 0)  -- Y set after height known
	IconCircle.Size = UDim2.new(0, 28, 0, 28)
	IconCircle.BackgroundColor3 = typeColor
	IconCircle.BackgroundTransparency = 0.75
	IconCircle.BorderSizePixel = 0
	IconCircle.ZIndex = 3

	local IcCorner = Instance.new("UICorner")
	IcCorner.CornerRadius = UDim.new(1, 0)
	IcCorner.Parent = IconCircle

	local IconImg = Instance.new("ImageLabel")
	IconImg.Name = "Icon"
	IconImg.Parent = IconCircle
	IconImg.AnchorPoint = Vector2.new(0.5, 0.5)
	IconImg.Position = UDim2.fromScale(0.5, 0.5)
	IconImg.Size = UDim2.new(0, 16, 0, 16)
	IconImg.BackgroundTransparency = 1
	IconImg.Image = typeIcon
	IconImg.ImageColor3 = typeColor
	IconImg.ScaleType = Enum.ScaleType.Fit
	IconImg.ZIndex = 4

	-- Title
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Toast
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 50, 0, 10)
	Title.Size = UDim2.new(1, -58, 0, 16)
	Title.Font = Enum.Font.GothamBold
	Title.Text = cfg.Title
	Title.TextColor3 = Theme.NeonWhite
	Title.TextSize = 12
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextTruncate = Enum.TextTruncate.AtEnd
	Title.ZIndex = 3

	-- Content
	local Desc = Instance.new("TextLabel")
	Desc.Name = "Desc"
	Desc.Parent = Toast
	Desc.BackgroundTransparency = 1
	Desc.Position = UDim2.new(0, 50, 0, 27)
	Desc.Size = UDim2.new(1, -58, 0, 60)  -- temp tall; resized below
	Desc.Font = Enum.Font.Gotham
	Desc.Text = cfg.Content
	Desc.TextColor3 = Theme.TextSecondary
	Desc.TextSize = 10.5
	Desc.TextWrapped = true
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.TextYAlignment = Enum.TextYAlignment.Top
	Desc.RichText = true
	Desc.ZIndex = 3

	-- Progress bar (shrinks left-to-right as duration passes)
	local ProgTrack = Instance.new("Frame")
	ProgTrack.Name = "ProgTrack"
	ProgTrack.Parent = Toast
	ProgTrack.AnchorPoint = Vector2.new(0, 1)
	ProgTrack.Position = UDim2.new(0, 8, 1, -6)
	ProgTrack.Size = UDim2.new(1, -16, 0, 2)
	ProgTrack.BackgroundColor3 = Theme.SurfaceActive
	ProgTrack.BackgroundTransparency = 0.4
	ProgTrack.BorderSizePixel = 0
	ProgTrack.ZIndex = 3

	local PTCorner = Instance.new("UICorner")
	PTCorner.CornerRadius = UDim.new(1, 0)
	PTCorner.Parent = ProgTrack

	local ProgFill = Instance.new("Frame")
	ProgFill.Name = "Fill"
	ProgFill.Parent = ProgTrack
	ProgFill.Size = UDim2.fromScale(1, 1)
	ProgFill.BackgroundColor3 = typeColor
	ProgFill.BackgroundTransparency = 0.1
	ProgFill.BorderSizePixel = 0
	ProgFill.ZIndex = 4

	local PFCorner = Instance.new("UICorner")
	PFCorner.CornerRadius = UDim.new(1, 0)
	PFCorner.Parent = ProgFill

	-- Dismiss button (X)
	local DismissBtn = Instance.new("ImageButton")
	DismissBtn.Name = "Dismiss"
	DismissBtn.Parent = Toast
	DismissBtn.AnchorPoint = Vector2.new(1, 0)
	DismissBtn.Position = UDim2.new(1, -8, 0, 8)
	DismissBtn.Size = UDim2.new(0, 14, 0, 14)
	DismissBtn.BackgroundTransparency = 1
	DismissBtn.Image = "rbxassetid://10747384394"
	DismissBtn.ImageColor3 = Theme.TextMuted
	DismissBtn.ScaleType = Enum.ScaleType.Fit
	DismissBtn.AutoButtonColor = false
	DismissBtn.ZIndex = 5

	DismissBtn.MouseEnter:Connect(function()
		TweenService:Create(DismissBtn, TweenInfoFast, { ImageColor3 = Theme.Danger }):Play()
	end)
	DismissBtn.MouseLeave:Connect(function()
		TweenService:Create(DismissBtn, TweenInfoFast, { ImageColor3 = Theme.TextMuted }):Play()
	end)

	-- ── Compute height & animate in ─────────────────────────────────────────
	local function ComputeAndAnimate()
		Desc.Size = UDim2.new(1, -58, 0, 1000)
		task.wait()  -- allow TextBounds to update
		local textH = math.max(Desc.TextBounds.Y, 14)
		Desc.Size = UDim2.new(1, -58, 0, textH)

		local cardH = textH + 44  -- 10 top + 16 title + 1 gap + textH + 8 prog + 9 bottom
		cardH = math.max(cardH, 62)

		IconCircle.Position = UDim2.new(0, 14, 0, cardH / 2)

		-- Expand height
		Toast.Size = UDim2.new(1, 0, 0, 0)
		local growTween = TweenService:Create(Toast, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 0, cardH)
		})
		growTween:Play()

		-- Slide in from right
		growTween.Completed:Connect(function()
			TweenService:Create(Toast, TweenInfoSmooth, {
				Position = UDim2.new(0, 0, 0, 0)
			}):Play()
			TweenService:Create(ToastStroke, TweenInfoSmooth, { Transparency = 0.35 }):Play()
		end)

		-- Progress drain
		TweenService:Create(ProgFill,
			TweenInfo.new(cfg.Duration, Enum.EasingStyle.Linear),
			{ Size = UDim2.fromScale(0, 1) }
		):Play()

		-- Auto-dismiss
		local dismissed = false
		local function Dismiss()
			if dismissed then return end
			dismissed = true
			local exitTween = TweenService:Create(Toast, TweenInfoSmooth, {
				Position = UDim2.new(1.1, 0, 0, 0),
				BackgroundTransparency = 0.6
			})
			TweenService:Create(ToastStroke, TweenInfoFast, { Transparency = 1 }):Play()
			exitTween:Play()
			exitTween.Completed:Connect(function()
				TweenService:Create(Toast, TweenInfoFast, { Size = UDim2.new(1, 0, 0, 0) }):Play()
				task.wait(0.2)
				if Toast and Toast.Parent then Toast:Destroy() end
			end)
		end

		DismissBtn.MouseButton1Click:Connect(Dismiss)
		task.delay(cfg.Duration, Dismiss)
	end

	task.spawn(ComputeAndAnimate)
end

-- -----------------------------------------------------------------------------
-- 5. WINDOW CREATION (PinatHub COMPACT DIMENSIONS & MODERN STYLING)
-- -----------------------------------------------------------------------------
function Library:NewWindow(ConfigWindow)
	local Config = self:MakeConfig({
		Title = "Pinathub",
		Description = "PinatHub Community",
		Size = UDim2.fromOffset(630, 390), -- Compact PinatHub landscape proportions
		Logo = PINATHUB_LOGO,
		NeonGapLines = true
	}, ConfigWindow or {})

	-- Auto-cleanup any old instances
	local function SafeCleanup(parent, name)
		if parent and parent:FindFirstChild(name) then
			pcall(function() parent[name]:Destroy() end)
		end
	end

	pcall(function()
		local pg = LocalPlayer:FindFirstChild("PlayerGui")
		SafeCleanup(pg, "PinathubGui")
		SafeCleanup(pg, "PinatHubUI_Premium")
		SafeCleanup(pg, "PinatHubLogo")
	end)

	-- Resolve top-level parent container (gethui / CoreGui / PlayerGui)
	local targetParent = LocalPlayer:WaitForChild("PlayerGui")
	pcall(function()
		if gethui then
			targetParent = gethui()
		elseif syn and syn.protect_gui then
			local cg = game:GetService("CoreGui")
			syn.protect_gui(ScreenGui)
			targetParent = cg
		elseif game:GetService("CoreGui") then
			local cg = game:GetService("CoreGui")
			local s = pcall(function()
				local t = Instance.new("Folder", cg)
				t:Destroy()
			end)
			if s then targetParent = cg end
		end
	end)

	-- 1. ScreenGui with full overlay capabilities (Menembus Roblox topbar menu)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "PinathubGui"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.IgnoreGuiInset = true  -- Menembus Roblox Topbar/MUI Menu
	ScreenGui.DisplayOrder = 999999  -- Render di atas menu dan UI default Roblox
	ScreenGui.Parent = targetParent

	-- Toast Notification Container — Top-Right, not flush to edge
	local NotificationHolder = Instance.new("Frame")
	NotificationHolder.Name = "NotificationHolder"
	NotificationHolder.Parent = ScreenGui
	NotificationHolder.AnchorPoint = Vector2.new(1, 0)
	NotificationHolder.Position = UDim2.new(1, -18, 0, 18)  -- top-right, 18px inset
	NotificationHolder.Size = UDim2.new(0, 292, 1, -36)     -- tall enough for stacked toasts
	NotificationHolder.BackgroundTransparency = 1
	NotificationHolder.ClipsDescendants = false
	NotificationHolder.ZIndex = 200

	local NotifLayout = Instance.new("UIListLayout")
	NotifLayout.Parent = NotificationHolder
	NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Top  -- stack downward from top-right
	NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	NotifLayout.Padding = UDim.new(0, 7)

	self.NotificationHolder = NotificationHolder

	-- 2. DropShadow & Scaling Wrapper for MainWindow
	local DropShadowHolder = Instance.new("Frame")
	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = ScreenGui
	DropShadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadowHolder.BackgroundTransparency = 1
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Position = UDim2.fromScale(0.5, 0.5)
	DropShadowHolder.Size = Config.Size or UDim2.fromOffset(630, 390)
	DropShadowHolder.ZIndex = 10

	local UIScale = Instance.new("UIScale")
	UIScale.Scale = 1
	UIScale.Parent = DropShadowHolder

	-- Multi-layer ambient drop shadow for modern glass elevation
	local DropShadow = Instance.new("ImageLabel")
	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.fromScale(0.5, 0.5)
	DropShadow.Size = UDim2.new(1, 44, 1, 44)
	DropShadow.ZIndex = 1
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.35
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	-- 3. MainWindow with Frosted Glass Surface
	local MainWindow = Instance.new("Frame")
	MainWindow.Name = "MainWindow"
	MainWindow.Parent = DropShadowHolder
	MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
	MainWindow.Position = UDim2.fromScale(0.5, 0.5)
	MainWindow.Size = UDim2.fromScale(1, 1)
	MainWindow.BackgroundColor3 = Theme.Background
	MainWindow.BackgroundTransparency = 0.08
	MainWindow.BorderSizePixel = 0
	MainWindow.ClipsDescendants = true
	MainWindow.ZIndex = 2

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 12)
	MainCorner.Parent = MainWindow

	-- Deep Amethyst Gradient Background
	local backgroundGradient = Instance.new("UIGradient")
	backgroundGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 36)),
		ColorSequenceKeypoint.new(0.4, Color3.fromRGB(15, 14, 20)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 9, 14)),
	})
	backgroundGradient.Rotation = 135
	backgroundGradient.Parent = MainWindow

	-- Glass Reflection Sheen
	local glassSheen = Instance.new("Frame")
	glassSheen.Name = "GlassSheen"
	glassSheen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	glassSheen.BorderSizePixel = 0
	glassSheen.Size = UDim2.fromScale(1, 1)
	glassSheen.ZIndex = 2
	glassSheen.Parent = MainWindow

	local sheenGrad = Instance.new("UIGradient")
	sheenGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.35, Theme.AccentGlow),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	sheenGrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.95),
		NumberSequenceKeypoint.new(0.4, 0.98),
		NumberSequenceKeypoint.new(1, 1.0)
	})
	sheenGrad.Rotation = 120
	sheenGrad.Parent = glassSheen

	-- Neon Edge Stroke (Amethyst Glow Rim with Continuous Moving Purple Neon Trace)
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Name = "Stroke"
	MainStroke.Color = Color3.fromRGB(255, 255, 255)
	MainStroke.Thickness = 1.2
	MainStroke.Transparency = 0
	MainStroke.Parent = MainWindow

	-- Moving Neon Purple Linear Border Trace (Corner to corner smoothly)
	local StrokeGradient = Instance.new("UIGradient")
	StrokeGradient.Name = "MovingNeonTrace"
	StrokeGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 55)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(40, 30, 55)),
		ColorSequenceKeypoint.new(0.47, Color3.fromRGB(168, 85, 247)), -- Neon Purple
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(235, 210, 255)), -- Subtle Bright Sparkle
		ColorSequenceKeypoint.new(0.53, Color3.fromRGB(168, 85, 247)), -- Neon Purple
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(40, 30, 55)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 30, 55)),
	})
	StrokeGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.75),
		NumberSequenceKeypoint.new(0.35, 0.75),
		NumberSequenceKeypoint.new(0.47, 0.15),
		NumberSequenceKeypoint.new(0.50, 0.0),
		NumberSequenceKeypoint.new(0.53, 0.15),
		NumberSequenceKeypoint.new(0.65, 0.75),
		NumberSequenceKeypoint.new(1, 0.75),
	})
	StrokeGradient.Rotation = 0
	StrokeGradient.Parent = MainStroke

	local borderNeonConn
	borderNeonConn = RunService.RenderStepped:Connect(function(dt)
		if MainWindow and MainWindow.Parent and StrokeGradient and StrokeGradient.Parent then
			StrokeGradient.Rotation = (StrokeGradient.Rotation + dt * 60) % 360
		else
			if borderNeonConn then borderNeonConn:Disconnect() end
		end
	end)

	-- PinatHub Watermark Background Logo (Subtle & Dimmed)
	local WindowBackgroundLogo = Instance.new("ImageLabel")
	WindowBackgroundLogo.Name = "WindowBackgroundLogo"
	WindowBackgroundLogo.Parent = MainWindow
	WindowBackgroundLogo.AnchorPoint = Vector2.new(0.5, 0.5)
	WindowBackgroundLogo.Position = UDim2.fromScale(0.5, 0.5)
	WindowBackgroundLogo.Size = UDim2.new(0.62, 0, 0.62, 0)
	WindowBackgroundLogo.BackgroundTransparency = 1
	WindowBackgroundLogo.Image = PINATHUB_LOGO
	WindowBackgroundLogo.ImageColor3 = Theme.AccentGlow
	WindowBackgroundLogo.ImageTransparency = 0.93 -- Dimmed subtle lighting
	WindowBackgroundLogo.ScaleType = Enum.ScaleType.Fit
	WindowBackgroundLogo.ZIndex = 2

	-- 4. Floating Launcher Button (PinatHub User Spec: 50x50, white bg, green stroke, draggable)
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local MainGui = Instance.new("ScreenGui")
	MainGui.Name = "MainGui"
	MainGui.ResetOnSpawn = false
	MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function() MainGui.Parent = game:GetService("CoreGui") end)
	if not MainGui.Parent then
		MainGui.Parent = PlayerGui
	end

	-- Buat ImageButton untuk toggle (buka/tutup) dengan 1 icon permanen
	local ToggleButton = Instance.new("ImageButton")
	ToggleButton.Name = "ToggleButton"
	ToggleButton.Parent = MainGui
	ToggleButton.Size = UDim2.new(0, 50, 0, 50)
	ToggleButton.Position = UDim2.new(0.5, -25, 0.5, -25)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleButton.BackgroundTransparency = 0
	ToggleButton.BorderSizePixel = 0
	ToggleButton.Image = PINATHUB_LOGO  -- Icon permanen PinatHub
	ToggleButton.ScaleType = Enum.ScaleType.Fit
	ToggleButton.ZIndex = 50

	-- Tambahkan corner biar icon berbentuk bulat
	local Corner = Instance.new("UICorner")
	Corner.Parent = ToggleButton
	Corner.CornerRadius = UDim.new(1, 0)

	-- Stroke outline putih
	local Stroke = Instance.new("UIStroke")
	Stroke.Parent = ToggleButton
	Stroke.Thickness = 2
	Stroke.Color = Color3.fromRGB(255, 255, 255)

	-- Variable untuk tracking status window
	local WindowOpen = true
	local isMaximized = false
	local originalSize = DropShadowHolder.Size

	-- Fungsi toggle (icon tetap sama)
	local function OpenWindow()
		WindowOpen = true
		DropShadowHolder.Visible = true
		UIScale.Scale = 0.92
		MainWindow.BackgroundTransparency = 0.5
		DropShadow.ImageTransparency = 1

		TweenService:Create(UIScale, TweenInfoSpring, { Scale = 1 }):Play()
		TweenService:Create(MainWindow, TweenInfoSmooth, { BackgroundTransparency = 0.08 }):Play()
		TweenService:Create(DropShadow, TweenInfoSmooth, { ImageTransparency = 0.35 }):Play()
	end

	local function CloseWindow()
		WindowOpen = false
		local closeTween = TweenService:Create(UIScale, TweenInfoFast, { Scale = 0.92 })
		TweenService:Create(MainWindow, TweenInfoFast, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(DropShadow, TweenInfoFast, { ImageTransparency = 1 }):Play()
		closeTween:Play()
		closeTween.Completed:Connect(function()
			if not WindowOpen then
				DropShadowHolder.Visible = false
			end
		end)
	end

	ToggleButton.MouseButton1Click:Connect(function()
		WindowOpen = not WindowOpen
		if WindowOpen then
			OpenWindow()
		else
			CloseWindow()
		end
	end)

	-- Hover effects on ToggleButton
	ToggleButton.MouseEnter:Connect(function()
		TweenService:Create(ToggleButton, TweenInfoSpring, { Size = UDim2.new(0, 56, 0, 56) }):Play()
	end)
	ToggleButton.MouseLeave:Connect(function()
		TweenService:Create(ToggleButton, TweenInfoSpring, { Size = UDim2.new(0, 50, 0, 50) }):Play()
	end)

	-- Untuk membuat tombol ini draggable (bisa digeser)
	local Dragging = false
	local DragStart = nil
	local StartPos = nil

	ToggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPos = ToggleButton.Position
		end
	end)

	ToggleButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local Delta = input.Position - DragStart
			ToggleButton.Position = UDim2.new(
				StartPos.X.Scale,
				StartPos.X.Offset + Delta.X,
				StartPos.Y.Scale,
				StartPos.Y.Offset + Delta.Y
			)
		end
	end)

	local function ToggleMaximize()
		isMaximized = not isMaximized
		local targetSize = isMaximized and UDim2.fromOffset(800, 500) or originalSize
		TweenService:Create(DropShadowHolder, TweenInfoSpring, { Size = targetSize }):Play()
	end

	-- 6. Header (PinatHub Style: Logo + Title + Separator + Subtitle | Pills & Actions)
	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Parent = MainWindow
	Header.BackgroundColor3 = Theme.Header
	Header.BackgroundTransparency = 0.3
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 46)
	Header.ZIndex = 5

	local HeaderDivider = Instance.new("Frame")
	HeaderDivider.Name = "Divider"
	HeaderDivider.Parent = Header
	HeaderDivider.BackgroundColor3 = Theme.BorderSoft
	HeaderDivider.BorderSizePixel = 0
	HeaderDivider.Position = UDim2.new(0, 0, 1, -1)
	HeaderDivider.Size = UDim2.new(1, 0, 0, 1)

	self:MakeDraggable(Header, DropShadowHolder)

	-- Left Title Container
	local LeftHeaderContainer = Instance.new("Frame")
	LeftHeaderContainer.Name = "LeftTitle"
	LeftHeaderContainer.Parent = Header
	LeftHeaderContainer.BackgroundTransparency = 1
	LeftHeaderContainer.Position = UDim2.new(0, 14, 0, 0)
	LeftHeaderContainer.Size = UDim2.new(0, 320, 1, 0)

	local LeftLayout = Instance.new("UIListLayout")
	LeftLayout.Parent = LeftHeaderContainer
	LeftLayout.FillDirection = Enum.FillDirection.Horizontal
	LeftLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
	LeftLayout.Padding = UDim.new(0, 8)

	-- Logo Pinathub
	local BrandLogo = Instance.new("ImageLabel")
	BrandLogo.Name = "BrandLogo"
	BrandLogo.Parent = LeftHeaderContainer
	BrandLogo.Size = UDim2.new(0, 22, 0, 22)
	BrandLogo.BackgroundTransparency = 1
	BrandLogo.Image = PINATHUB_LOGO
	BrandLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
	BrandLogo.ScaleType = Enum.ScaleType.Fit
	BrandLogo.LayoutOrder = 1

	-- Title "Pinathub | Drain Water" (Clean, No Subtitle)
	local BrandName = Instance.new("TextLabel")
	BrandName.Name = "BrandName"
	BrandName.Parent = LeftHeaderContainer
	BrandName.BackgroundTransparency = 1
	BrandName.Size = UDim2.new(0, 0, 1, 0)
	BrandName.AutomaticSize = Enum.AutomaticSize.X
	BrandName.Font = Enum.Font.GothamBold
	BrandName.Text = Config.Title
	BrandName.TextColor3 = Theme.Text
	BrandName.TextSize = 13
	BrandName.TextXAlignment = Enum.TextXAlignment.Left
	BrandName.LayoutOrder = 2

	-- Right Header Container (Badges + Minimize & Close Buttons)
	local RightHeaderContainer = Instance.new("Frame")
	RightHeaderContainer.Name = "RightBadges"
	RightHeaderContainer.Parent = Header
	RightHeaderContainer.AnchorPoint = Vector2.new(1, 0.5)
	RightHeaderContainer.Position = UDim2.new(1, -10, 0.5, 0)
	RightHeaderContainer.Size = UDim2.new(0, 310, 0, 28)
	RightHeaderContainer.BackgroundTransparency = 1

	local RightLayout = Instance.new("UIListLayout")
	RightLayout.Parent = RightHeaderContainer
	RightLayout.FillDirection = Enum.FillDirection.Horizontal
	RightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	RightLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
	RightLayout.Padding = UDim.new(0, 6)

	-- Helper for Pill Badges
	local function CreatePillBadge(text, order)
		local pill = Instance.new("Frame")
		pill.Name = "PillBadge_" .. order
		pill.Parent = RightHeaderContainer
		pill.BackgroundColor3 = Theme.SurfaceActive
		pill.BackgroundTransparency = 0.4
		pill.BorderSizePixel = 0
		pill.Size = UDim2.new(0, 0, 0, 22)
		pill.AutomaticSize = Enum.AutomaticSize.X
		pill.LayoutOrder = order

		local pCorner = Instance.new("UICorner")
		pCorner.CornerRadius = UDim.new(1, 0)
		pCorner.Parent = pill

		local pStroke = Instance.new("UIStroke")
		pStroke.Color = Theme.BorderSoft
		pStroke.Thickness = 1
		pStroke.Parent = pill

		local pPadding = Instance.new("UIPadding")
		pPadding.Parent = pill
		pPadding.PaddingLeft = UDim.new(0, 10)
		pPadding.PaddingRight = UDim.new(0, 10)

		local pText = Instance.new("TextLabel")
		pText.Parent = pill
		pText.BackgroundTransparency = 1
		pText.Size = UDim2.new(0, 0, 1, 0)
		pText.AutomaticSize = Enum.AutomaticSize.X
		pText.Font = Enum.Font.GothamBold
		pText.Text = text
		pText.TextColor3 = Theme.TextSecondary
		pText.TextSize = 10
		pText.TextXAlignment = Enum.TextXAlignment.Center

		return pill, pText
	end

	-- Executor Badge Only
	local currentExecutor = DetectExecutor()
	local execPill, execText = CreatePillBadge("Executor: " .. currentExecutor, 1)
	execText.RichText = true
	execText.Text = "<font color='#4ade80'>●</font> " .. currentExecutor

	local onCloseCallbacks = {}
	local function FullShutdownWindow()
		for _, cb in ipairs(onCloseCallbacks) do
			pcall(cb)
		end
		local closeTween = TweenService:Create(UIScale, TweenInfoFast, { Scale = 0.8 })
		TweenService:Create(MainWindow, TweenInfoFast, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(DropShadow, TweenInfoFast, { ImageTransparency = 1 }):Play()
		closeTween:Play()
		closeTween.Completed:Connect(function()
			pcall(function()
				if MainGui then MainGui:Destroy() end
				if ScreenGui then ScreenGui:Destroy() end
			end)
		end)
	end

	-- Window Control Buttons (Minimize & True Close Icon)
	local MinimizeBtn = Instance.new("TextButton")
	MinimizeBtn.Name = "Btn_Minimize"
	MinimizeBtn.Parent = RightHeaderContainer
	MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
	MinimizeBtn.BackgroundColor3 = Theme.Surface
	MinimizeBtn.BackgroundTransparency = 1
	MinimizeBtn.BorderSizePixel = 0
	MinimizeBtn.Font = Enum.Font.GothamBold
	MinimizeBtn.Text = "—"
	MinimizeBtn.TextColor3 = Theme.TextSecondary
	MinimizeBtn.TextSize = 13
	MinimizeBtn.AutoButtonColor = false
	MinimizeBtn.LayoutOrder = 2

	local MinCorner = Instance.new("UICorner")
	MinCorner.CornerRadius = UDim.new(0, 5)
	MinCorner.Parent = MinimizeBtn

	MinimizeBtn.MouseEnter:Connect(function()
		TweenService:Create(MinimizeBtn, TweenInfoFast, { BackgroundTransparency = 0.3, BackgroundColor3 = Theme.SurfaceHover }):Play()
		MinimizeBtn.TextColor3 = Theme.Text
	end)
	MinimizeBtn.MouseLeave:Connect(function()
		TweenService:Create(MinimizeBtn, TweenInfoFast, { BackgroundTransparency = 1 }):Play()
		MinimizeBtn.TextColor3 = Theme.TextSecondary
	end)
	MinimizeBtn.MouseButton1Click:Connect(CloseWindow)

	-- Proper Close Icon Button with Lucide Close Asset
	local CloseBtn = Instance.new("ImageButton")
	CloseBtn.Name = "Btn_Close"
	CloseBtn.Parent = RightHeaderContainer
	CloseBtn.Size = UDim2.new(0, 24, 0, 24)
	CloseBtn.BackgroundColor3 = Theme.Surface
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.BorderSizePixel = 0
	CloseBtn.Image = "rbxassetid://10747384394" -- Genuine Lucide X Close Icon
	CloseBtn.ImageColor3 = Theme.TextSecondary
	CloseBtn.ScaleType = Enum.ScaleType.Fit
	CloseBtn.AutoButtonColor = false
	CloseBtn.LayoutOrder = 3

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 5)
	CloseCorner.Parent = CloseBtn

	local ClosePadding = Instance.new("UIPadding")
	ClosePadding.Parent = CloseBtn
	ClosePadding.PaddingTop = UDim.new(0, 5)
	ClosePadding.PaddingBottom = UDim.new(0, 5)
	ClosePadding.PaddingLeft = UDim.new(0, 5)
	ClosePadding.PaddingRight = UDim.new(0, 5)

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(CloseBtn, TweenInfoFast, { BackgroundTransparency = 0, BackgroundColor3 = Theme.Danger }):Play()
		TweenService:Create(CloseBtn, TweenInfoFast, { ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(CloseBtn, TweenInfoFast, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(CloseBtn, TweenInfoFast, { ImageColor3 = Theme.TextSecondary }):Play()
	end)
	CloseBtn.MouseButton1Click:Connect(FullShutdownWindow)

	-- 7. Sidebar Setup (PinatHub Width: 155px)
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = MainWindow
	Sidebar.BackgroundColor3 = Theme.Sidebar
	Sidebar.BackgroundTransparency = 0.25
	Sidebar.BorderSizePixel = 0
	Sidebar.Position = UDim2.new(0, 0, 0, 46)
	Sidebar.Size = UDim2.new(0, 155, 1, -46)
	Sidebar.ZIndex = 4

	local SidebarDivider = Instance.new("Frame")
	SidebarDivider.Name = "Divider"
	SidebarDivider.Parent = Sidebar
	SidebarDivider.BackgroundColor3 = Theme.BorderSoft
	SidebarDivider.BorderSizePixel = 0
	SidebarDivider.Position = UDim2.new(1, -1, 0, 0)
	SidebarDivider.Size = UDim2.new(0, 1, 1, 0)

	-- Search Box in Sidebar (PinatHub Pill Style)
	local SearchFrame = Instance.new("Frame")
	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = Sidebar
	SearchFrame.BackgroundColor3 = Theme.Surface
	SearchFrame.BackgroundTransparency = 0.45
	SearchFrame.BorderSizePixel = 0
	SearchFrame.Position = UDim2.new(0, 10, 0, 10)
	SearchFrame.Size = UDim2.new(1, -20, 0, 28)

	local SearchCorner = Instance.new("UICorner")
	SearchCorner.CornerRadius = UDim.new(0, 7)
	SearchCorner.Parent = SearchFrame

	local SearchStroke = Instance.new("UIStroke")
	SearchStroke.Color = Theme.BorderSoft
	SearchStroke.Thickness = 1
	SearchStroke.Parent = SearchFrame

	local SearchIcon = Instance.new("ImageLabel")
	SearchIcon.Name = "Icon"
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
	SearchIcon.Position = UDim2.new(0, 8, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 13, 0, 13)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Image = TabIcons.Search
	SearchIcon.ImageColor3 = Theme.TextMuted
	SearchIcon.ScaleType = Enum.ScaleType.Fit

	local SearchBox = Instance.new("TextBox")
	SearchBox.Name = "SearchBox"
	SearchBox.Parent = SearchFrame
	SearchBox.BackgroundTransparency = 1
	SearchBox.Position = UDim2.new(0, 26, 0, 0)
	SearchBox.Size = UDim2.new(1, -30, 1, 0)
	SearchBox.Font = Enum.Font.Gotham
	SearchBox.PlaceholderColor3 = Theme.TextMuted
	SearchBox.PlaceholderText = "Search..."
	SearchBox.Text = ""
	SearchBox.TextColor3 = Theme.Text
	SearchBox.TextSize = 11
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left
	SearchBox.ClearTextOnFocus = false

	SearchBox.Focused:Connect(function()
		TweenService:Create(SearchStroke, TweenInfoFast, { Color = Theme.Accent, Transparency = 0.2 }):Play()
		TweenService:Create(SearchIcon, TweenInfoFast, { ImageColor3 = Theme.AccentGlow }):Play()
	end)
	SearchBox.FocusLost:Connect(function()
		TweenService:Create(SearchStroke, TweenInfoFast, { Color = Theme.BorderSoft, Transparency = 0 }):Play()
		TweenService:Create(SearchIcon, TweenInfoFast, { ImageColor3 = Theme.TextMuted }):Play()
	end)

	-- Tab List (ScrollingFrame)
	local TabList = Instance.new("ScrollingFrame")
	TabList.Name = "TabList"
	TabList.Parent = Sidebar
	TabList.BackgroundTransparency = 1
	TabList.BorderSizePixel = 0
	TabList.Position = UDim2.new(0, 0, 0, 46)
	TabList.Size = UDim2.new(1, 0, 1, -90) -- Leaves 44px for Profile footer at bottom
	TabList.ScrollBarThickness = 2
	TabList.ScrollBarImageColor3 = Theme.Border
	TabList.CanvasSize = UDim2.new(0, 0, 0, 0)

	local TabPadding = Instance.new("UIPadding")
	TabPadding.Parent = TabList
	TabPadding.PaddingTop = UDim.new(0, 4)
	TabPadding.PaddingBottom = UDim.new(0, 6)
	TabPadding.PaddingLeft = UDim.new(0, 8)
	TabPadding.PaddingRight = UDim.new(0, 8)

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.Parent = TabList
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding = UDim.new(0, 3)

	self:UpdateScrolling(TabList, TabListLayout)

	-- Bottom User Profile (PinatHub Feature: Avatar Headshot + "Welcome, <username>")
	local ProfileFooter = Instance.new("Frame")
	ProfileFooter.Name = "ProfileFooter"
	ProfileFooter.Parent = Sidebar
	ProfileFooter.AnchorPoint = Vector2.new(0, 1)
	ProfileFooter.Position = UDim2.new(0, 0, 1, 0)
	ProfileFooter.Size = UDim2.new(1, 0, 0, 44)
	ProfileFooter.BackgroundColor3 = Theme.Sidebar
	ProfileFooter.BackgroundTransparency = 0.1
	ProfileFooter.BorderSizePixel = 0

	local ProfileDivider = Instance.new("Frame")
	ProfileDivider.Name = "Divider"
	ProfileDivider.Parent = ProfileFooter
	ProfileDivider.BackgroundColor3 = Theme.BorderSoft
	ProfileDivider.BorderSizePixel = 0
	ProfileDivider.Position = UDim2.new(0, 10, 0, 0)
	ProfileDivider.Size = UDim2.new(1, -20, 0, 1)

	local AvatarImage = Instance.new("ImageLabel")
	AvatarImage.Name = "Avatar"
	AvatarImage.Parent = ProfileFooter
	AvatarImage.AnchorPoint = Vector2.new(0, 0.5)
	AvatarImage.Position = UDim2.new(0, 10, 0.5, 0)
	AvatarImage.Size = UDim2.new(0, 26, 0, 26)
	AvatarImage.BackgroundColor3 = Theme.Surface
	AvatarImage.BorderSizePixel = 0
	pcall(function()
		AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=48&h=48"
	end)

	local AvatarCorner = Instance.new("UICorner")
	AvatarCorner.CornerRadius = UDim.new(1, 0)
	AvatarCorner.Parent = AvatarImage

	local AvatarStroke = Instance.new("UIStroke")
	AvatarStroke.Color = Theme.BorderSoft
	AvatarStroke.Thickness = 1
	AvatarStroke.Parent = AvatarImage

	local WelcomeText = Instance.new("TextLabel")
	WelcomeText.Name = "Welcome"
	WelcomeText.Parent = ProfileFooter
	WelcomeText.BackgroundTransparency = 1
	WelcomeText.Position = UDim2.new(0, 42, 0, 0)
	WelcomeText.Size = UDim2.new(1, -48, 1, 0)
	WelcomeText.Font = Enum.Font.GothamBold
	local displayName = LocalPlayer and (LocalPlayer.DisplayName or LocalPlayer.Name) or "Player"
	WelcomeText.Text = "Welcome, " .. displayName
	WelcomeText.TextColor3 = Theme.TextSecondary
	WelcomeText.TextSize = 11
	WelcomeText.TextTruncate = Enum.TextTruncate.AtEnd
	WelcomeText.TextXAlignment = Enum.TextXAlignment.Left

	-- 8. Content Area
	local Content = Instance.new("Frame")
	Content.Name = "Content"
	Content.Parent = MainWindow
	Content.BackgroundTransparency = 1
	Content.BorderSizePixel = 0
	Content.Position = UDim2.new(0, 155, 0, 46)
	Content.Size = UDim2.new(1, -155, 1, -46)
	Content.ZIndex = 4

	local PageContainer = Instance.new("Frame")
	PageContainer.Name = "PageContainer"
	PageContainer.Parent = Content
	PageContainer.BackgroundTransparency = 1
	PageContainer.Position = UDim2.new(0, 0, 0, 0)
	PageContainer.Size = UDim2.fromScale(1, 1)
	PageContainer.ClipsDescendants = true

	local UIPageLayout = Instance.new("UIPageLayout")
	UIPageLayout.Parent = PageContainer
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quart
	UIPageLayout.EasingDirection = Enum.EasingDirection.Out
	UIPageLayout.TweenTime = 0.22

	-- Fullscreen invisible backdrop for instant click-outside-to-close anywhere on UI
	local PopoutBackdrop = Instance.new("TextButton")
	PopoutBackdrop.Name = "PopoutBackdrop"
	PopoutBackdrop.Parent = MainWindow
	PopoutBackdrop.BackgroundTransparency = 1
	PopoutBackdrop.Position = UDim2.new(0, 0, 0, 0)
	PopoutBackdrop.Size = UDim2.fromScale(1, 1)
	PopoutBackdrop.ZIndex = 28
	PopoutBackdrop.Visible = false
	PopoutBackdrop.Text = ""
	PopoutBackdrop.AutoButtonColor = false

	-- 9. Right Popout Drawer for Dropdown (PinatHub Slim 140px Style)
	local PopoutDrawer = Instance.new("Frame")
	PopoutDrawer.Name = "PopoutDrawer"
	PopoutDrawer.Parent = MainWindow
	PopoutDrawer.AnchorPoint = Vector2.new(1, 0)
	PopoutDrawer.Position = UDim2.new(1, 0, 0, 46)
	PopoutDrawer.Size = UDim2.new(0, 140, 1, -46)
	PopoutDrawer.BackgroundColor3 = Theme.Header
	PopoutDrawer.BackgroundTransparency = 0.05
	PopoutDrawer.BorderSizePixel = 0
	PopoutDrawer.Visible = false
	PopoutDrawer.ZIndex = 30

	local PopoutStroke = Instance.new("UIStroke")
	PopoutStroke.Color = Theme.Accent
	PopoutStroke.Thickness = 1.2
	PopoutStroke.Parent = PopoutDrawer

	local function ClosePopout()
		PopoutDrawer.Visible = false
		PopoutBackdrop.Visible = false
	end
	PopoutBackdrop.MouseButton1Click:Connect(ClosePopout)

	-- Popout Header with Title & Close 'X' Button
	local PopoutHeader = Instance.new("Frame")
	PopoutHeader.Name = "PopoutHeader"
	PopoutHeader.Parent = PopoutDrawer
	PopoutHeader.BackgroundTransparency = 1
	PopoutHeader.Position = UDim2.new(0, 6, 0, 6)
	PopoutHeader.Size = UDim2.new(1, -12, 0, 20)

	local PopoutTitle = Instance.new("TextLabel")
	PopoutTitle.Name = "Title"
	PopoutTitle.Parent = PopoutHeader
	PopoutTitle.BackgroundTransparency = 1
	PopoutTitle.Position = UDim2.new(0, 2, 0, 0)
	PopoutTitle.Size = UDim2.new(1, -24, 1, 0)
	PopoutTitle.Font = Enum.Font.GothamBold
	PopoutTitle.Text = "Options"
	PopoutTitle.TextColor3 = Theme.AccentGlow
	PopoutTitle.TextSize = 10
	PopoutTitle.TextXAlignment = Enum.TextXAlignment.Left

	local PopoutCloseBtn = Instance.new("ImageButton")
	PopoutCloseBtn.Name = "Btn_PopoutClose"
	PopoutCloseBtn.Parent = PopoutHeader
	PopoutCloseBtn.AnchorPoint = Vector2.new(1, 0.5)
	PopoutCloseBtn.Position = UDim2.new(1, 0, 0.5, 0)
	PopoutCloseBtn.Size = UDim2.new(0, 16, 0, 16)
	PopoutCloseBtn.BackgroundColor3 = Theme.Surface
	PopoutCloseBtn.BackgroundTransparency = 0.5
	PopoutCloseBtn.BorderSizePixel = 0
	PopoutCloseBtn.Image = "rbxassetid://10747384394" -- Genuine Lucide X
	PopoutCloseBtn.ImageColor3 = Theme.TextSecondary
	PopoutCloseBtn.ScaleType = Enum.ScaleType.Fit
	PopoutCloseBtn.AutoButtonColor = false

	local PCB_Corner = Instance.new("UICorner")
	PCB_Corner.CornerRadius = UDim.new(0, 4)
	PCB_Corner.Parent = PopoutCloseBtn

	PopoutCloseBtn.MouseEnter:Connect(function()
		TweenService:Create(PopoutCloseBtn, TweenInfoFast, { BackgroundTransparency = 0, BackgroundColor3 = Theme.Danger }):Play()
		TweenService:Create(PopoutCloseBtn, TweenInfoFast, { ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()
	end)
	PopoutCloseBtn.MouseLeave:Connect(function()
		TweenService:Create(PopoutCloseBtn, TweenInfoFast, { BackgroundTransparency = 0.5, BackgroundColor3 = Theme.Surface }):Play()
		TweenService:Create(PopoutCloseBtn, TweenInfoFast, { ImageColor3 = Theme.TextSecondary }):Play()
	end)
	PopoutCloseBtn.MouseButton1Click:Connect(ClosePopout)

	local PopoutSearchFrame = Instance.new("Frame")
	PopoutSearchFrame.Name = "Search"
	PopoutSearchFrame.Parent = PopoutDrawer
	PopoutSearchFrame.Position = UDim2.new(0, 6, 0, 30)
	PopoutSearchFrame.Size = UDim2.new(1, -12, 0, 22)
	PopoutSearchFrame.BackgroundColor3 = Theme.Surface
	PopoutSearchFrame.BorderSizePixel = 0

	local PopoutSCorner = Instance.new("UICorner")
	PopoutSCorner.CornerRadius = UDim.new(0, 5)
	PopoutSCorner.Parent = PopoutSearchFrame

	local PopoutSBox = Instance.new("TextBox")
	PopoutSBox.Parent = PopoutSearchFrame
	PopoutSBox.BackgroundTransparency = 1
	PopoutSBox.Position = UDim2.new(0, 6, 0, 0)
	PopoutSBox.Size = UDim2.new(1, -12, 1, 0)
	PopoutSBox.Font = Enum.Font.Gotham
	PopoutSBox.PlaceholderColor3 = Theme.TextMuted
	PopoutSBox.PlaceholderText = "Search..."
	PopoutSBox.Text = ""
	PopoutSBox.TextColor3 = Theme.Text
	PopoutSBox.TextSize = 10
	PopoutSBox.TextXAlignment = Enum.TextXAlignment.Left

	local PopoutScroll = Instance.new("ScrollingFrame")
	PopoutScroll.Name = "Options"
	PopoutScroll.Parent = PopoutDrawer
	PopoutScroll.BackgroundTransparency = 1
	PopoutScroll.Position = UDim2.new(0, 6, 0, 56)
	PopoutScroll.Size = UDim2.new(1, -12, 1, -62)
	PopoutScroll.ScrollBarThickness = 2
	PopoutScroll.ScrollBarImageColor3 = Theme.Border
	PopoutScroll.BorderSizePixel = 0

	local PopoutLayout = Instance.new("UIListLayout")
	PopoutLayout.Parent = PopoutScroll
	PopoutLayout.SortOrder = Enum.SortOrder.LayoutOrder
	PopoutLayout.Padding = UDim.new(0, 2)

	self:UpdateScrolling(PopoutScroll, PopoutLayout)

	-- Close Popout Drawer when user clicks anywhere on screen outside of it
	UserInputService.InputBegan:Connect(function(input)
		if not PopoutDrawer.Visible then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local mPos = input.Position
			local dPos = PopoutDrawer.AbsolutePosition
			local dSize = PopoutDrawer.AbsoluteSize
			local inside = (mPos.X >= dPos.X and mPos.X <= (dPos.X + dSize.X)) and (mPos.Y >= dPos.Y and mPos.Y <= (dPos.Y + dSize.Y))
			if not inside then
				task.defer(ClosePopout)
			end
		end
	end)

	-- Collapse all open paragraph panels when user clicks outside any of them
	-- (multi-select: they individually stay open until click-outside or X)
	UserInputService.InputBegan:Connect(function(input)
		if #Library._ActiveParaFrames == 0 then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local mPos = input.Position
		local toCollapse = {}
		for _, frame in ipairs(Library._ActiveParaFrames) do
			if frame and frame.Parent then
				local fPos = frame.AbsolutePosition
				local fSize = frame.AbsoluteSize
				local inside = (mPos.X >= fPos.X and mPos.X <= (fPos.X + fSize.X))
					and (mPos.Y >= fPos.Y and mPos.Y <= (fPos.Y + fSize.Y))
				if not inside then
					table.insert(toCollapse, frame)
				end
			end
		end
		if #toCollapse > 0 then
			task.defer(function()
				for _, frame in ipairs(toCollapse) do
					-- Find the HeaderBtn child and simulate collapse via UIStroke + size tween
					local COLLAPSED_H = 26
					local stroke = frame:FindFirstChildOfClass("UIStroke")
					local chevron = frame:FindFirstChild("Chevron")
					local title = frame:FindFirstChild("Title")
					local divider = frame:FindFirstChild("Divider")
					if divider then divider.Visible = false end
					TweenService:Create(frame, TweenInfoSmooth, { Size = UDim2.new(1, 0, 0, COLLAPSED_H) }):Play()
					if stroke then TweenService:Create(stroke, TweenInfoFast, { Color = Theme.BorderSoft, Transparency = 0.45 }):Play() end
					if chevron then TweenService:Create(chevron, TweenInfoFast, { Rotation = 0, ImageColor3 = Theme.TextMuted }):Play() end
					if title then TweenService:Create(title, TweenInfoFast, { TextColor3 = Theme.NeonWhite }):Play() end
					-- Remove from active list
					for i, v in ipairs(Library._ActiveParaFrames) do
						if v == frame then table.remove(Library._ActiveParaFrames, i) break end
					end
				end
			end)
		end
	end)

	-- 10. Tab System & Tab Creation Implementation
	local TabCount = 0
	local TabsCollection = {}
	local ActiveTabIndex = 1

	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		local query = string.lower(SearchBox.Text):match("^%s*(.-)%s*$")
		for _, tabData in ipairs(TabsCollection) do
			if tabData.Sections then
				for _, sec in ipairs(tabData.Sections) do
					local secMatch = (query == "") or (string.find(string.lower(sec.Title), query) ~= nil)
					local anyChildMatch = false
					for _, elem in ipairs(sec.Elements) do
						local match = (query == "") or (string.find(string.lower(elem.Title), query) ~= nil)
						elem.Frame.Visible = match
						if match then anyChildMatch = true end
					end
					sec.Frame.Visible = (query == "") or secMatch or anyChildMatch
				end
			end
		end
	end)

	local Window = {}

	function Window:SetToggleKey(keyCode)
		if typeof(keyCode) == "EnumItem" then
			Config.ToggleKey = keyCode
		end
	end

	function Window:ToggleTransparency(disabled)
		MainWindow.BackgroundTransparency = disabled and 0 or 0.08
		glassSheen.Visible = not disabled
	end

	function Window:OnClose(cb)
		if type(cb) == "function" then
			table.insert(onCloseCallbacks, cb)
		end
	end

	function Window:Destroy()
		FullShutdownWindow()
	end

	function Window:FullShutdown()
		FullShutdownWindow()
	end

	function Window:Open()
		OpenWindow()
	end

	function Window:Close()
		CloseWindow()
	end

	-- Hotkey Listener for Toggle Key
	Config.ToggleKey = Config.ToggleKey or Enum.KeyCode.RightShift
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Config.ToggleKey then
			if isWindowOpen then
				CloseWindow()
			else
				OpenWindow()
			end
		end
	end)

	-- TAB CREATION (Window:T / Window:Tab / Window:NewTab)
	-- Supports both table style ({Title, Icon, Desc}) and positional args (title, icon, desc)
	function Window:T(tabTitle, tabIcon, tabDesc)
		local currentOrder = TabCount
		TabCount = TabCount + 1

		local title, icon, descText
		if type(tabTitle) == "table" then
			title = tostring(tabTitle.Title or tabTitle.Name or ("Tab " .. TabCount))
			icon = tabTitle.Icon
			descText = tabTitle.Desc or tabTitle.Description or title
		else
			title = tostring(tabTitle or ("Tab " .. TabCount))
			icon = tabIcon
			descText = tabDesc or title
		end
		icon = ResolveIcon(icon, title)
		descText = descText or title

		-- Tab Button in Sidebar (PinatHub: Left Accent Indicator Bar on Active)
		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = "TabBtn_" .. title
		TabBtn.Parent = TabList
		TabBtn.BackgroundColor3 = Theme.SurfaceHover
		TabBtn.BackgroundTransparency = 1
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(1, 0, 0, 32)
		TabBtn.AutoButtonColor = false
		TabBtn.LayoutOrder = currentOrder
		TabBtn.Text = ""

		local TabBtnCorner = Instance.new("UICorner")
		TabBtnCorner.CornerRadius = UDim.new(0, 6)
		TabBtnCorner.Parent = TabBtn

		-- PinatHub Left Accent Indicator Bar
		local ActiveIndicator = Instance.new("Frame")
		ActiveIndicator.Name = "ActiveIndicator"
		ActiveIndicator.Parent = TabBtn
		ActiveIndicator.AnchorPoint = Vector2.new(0, 0.5)
		ActiveIndicator.Position = UDim2.new(0, 2, 0.5, 0)
		ActiveIndicator.Size = UDim2.new(0, 3, 0.62, 0)
		ActiveIndicator.BackgroundColor3 = Theme.Accent
		ActiveIndicator.BorderSizePixel = 0
		ActiveIndicator.Visible = false

		local IndCorner = Instance.new("UICorner")
		IndCorner.CornerRadius = UDim.new(1, 0)
		IndCorner.Parent = ActiveIndicator

		local IconImage = Instance.new("ImageLabel")
		IconImage.Name = "Icon"
		IconImage.Parent = TabBtn
		IconImage.AnchorPoint = Vector2.new(0, 0.5)
		IconImage.Position = UDim2.new(0, 10, 0.5, 0)
		IconImage.Size = UDim2.new(0, 15, 0, 15)
		IconImage.BackgroundTransparency = 1
		IconImage.Image = icon
		IconImage.ImageColor3 = Theme.TextMuted
		IconImage.ScaleType = Enum.ScaleType.Fit

		local TabLabel = Instance.new("TextLabel")
		TabLabel.Name = "Label"
		TabLabel.Parent = TabBtn
		TabLabel.BackgroundTransparency = 1
		TabLabel.Position = UDim2.new(0, 32, 0, 0)
		TabLabel.Size = UDim2.new(1, -36, 1, 0)
		TabLabel.Font = Enum.Font.Gotham
		TabLabel.Text = title
		TabLabel.TextColor3 = Theme.TextSecondary
		TabLabel.TextSize = 12
		TabLabel.TextXAlignment = Enum.TextXAlignment.Left

		local Page = Instance.new("ScrollingFrame")
		Page.Name = "Page_" .. title
		Page.Parent = PageContainer
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.Size = UDim2.fromScale(1, 1)
		Page.ScrollBarThickness = 2
		Page.ScrollBarImageColor3 = Theme.Border
		Page.LayoutOrder = currentOrder

		local PagePadding = Instance.new("UIPadding")
		PagePadding.Parent = Page
		PagePadding.PaddingTop = UDim.new(0, 10)
		PagePadding.PaddingBottom = UDim.new(0, 16)
		PagePadding.PaddingLeft = UDim.new(0, 14)
		PagePadding.PaddingRight = UDim.new(0, 14)

		local PageListLayout = Instance.new("UIListLayout")
		PageListLayout.Parent = Page
		PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageListLayout.Padding = UDim.new(0, 8)

		local sectionOrder = 0
		local sectionGapLines = {}
		local sectionNeonConn

		local function AddSectionGapLine()
			if Config.NeonGapLines == false then return end
			local gapLine = Instance.new("Frame")
			gapLine.Name = "SectionNeonGapLine"
			gapLine.BackgroundTransparency = 1
			gapLine.BorderSizePixel = 0
			gapLine.Size = UDim2.new(1, -18, 0, 3)
			gapLine.Position = UDim2.new(0, 9, 0, 0)
			gapLine.LayoutOrder = sectionOrder * 2 - 1
			gapLine.ZIndex = 3
			gapLine.Parent = Page

			local gapGradient = Instance.new("UIGradient")
			gapGradient.Name = "MovingNeonTrace"
			gapGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
				ColorSequenceKeypoint.new(0.16, Color3.fromRGB(168, 85, 247)),
				ColorSequenceKeypoint.new(0.22, Color3.fromRGB(205, 125, 255)),
				ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 245, 255)),
				ColorSequenceKeypoint.new(0.28, Color3.fromRGB(205, 125, 255)),
				ColorSequenceKeypoint.new(0.34, Color3.fromRGB(168, 85, 247)),
				ColorSequenceKeypoint.new(0.47, Color3.fromRGB(168, 85, 247)),
				ColorSequenceKeypoint.new(0.53, Color3.fromRGB(205, 125, 255)),
				ColorSequenceKeypoint.new(0.56, Color3.fromRGB(255, 245, 255)),
				ColorSequenceKeypoint.new(0.59, Color3.fromRGB(205, 125, 255)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(168, 85, 247)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 85, 247)),
			})
			gapGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.16, 1),
				NumberSequenceKeypoint.new(0.22, 0.35),
				NumberSequenceKeypoint.new(0.25, 0),
				NumberSequenceKeypoint.new(0.28, 0.35),
				NumberSequenceKeypoint.new(0.34, 1),
				NumberSequenceKeypoint.new(0.47, 1),
				NumberSequenceKeypoint.new(0.53, 0.35),
				NumberSequenceKeypoint.new(0.56, 0),
				NumberSequenceKeypoint.new(0.59, 0.35),
				NumberSequenceKeypoint.new(0.66, 1),
				NumberSequenceKeypoint.new(1, 1),
			})
			gapGradient.Parent = gapLine
			table.insert(sectionGapLines, gapGradient)
		end

		Page.ChildAdded:Connect(function(child)
			if not child:IsA("GuiObject") or child.Name == "SectionNeonGapLine" then return end
			sectionOrder += 1
			child.LayoutOrder = sectionOrder * 2
			if sectionOrder > 1 and Config.NeonGapLines ~= false then
				AddSectionGapLine()
			end
		end)

		sectionNeonConn = RunService.RenderStepped:Connect(function(dt)
			if not Page.Parent then
				sectionNeonConn:Disconnect()
				return
			end
			for index = #sectionGapLines, 1, -1 do
				local gradient = sectionGapLines[index]
				if gradient.Parent then
					local sweep = (os.clock() * 1.05) % 2 - 1
					gradient.Offset = Vector2.new(sweep, 0)
				else
					table.remove(sectionGapLines, index)
				end
			end
		end)

		Library:UpdateScrolling(Page, PageListLayout)

		local tabData = {
			Title = title,
			Description = descText,
			Button = TabBtn,
			Page = Page,
			Order = currentOrder,
			Sections = {}
		}
		table.insert(TabsCollection, tabData)

		local function SelectThisTab()
			ActiveTabIndex = currentOrder + 1
			UIPageLayout:JumpToIndex(currentOrder)
			if PopoutDrawer then
				PopoutDrawer.Visible = false
			end

			for _, t in ipairs(TabsCollection) do
				local isActive = (t.Order == currentOrder)
				t.Button.ActiveIndicator.Visible = isActive
				if isActive then
					TweenService:Create(t.Button, TweenInfoFast, { BackgroundTransparency = 0.25 }):Play()
					TweenService:Create(t.Button.Icon, TweenInfoFast, { ImageColor3 = Theme.NeonWhite }):Play()
					t.Button.Label.Font = Enum.Font.GothamBold
					TweenService:Create(t.Button.Label, TweenInfoFast, { TextColor3 = Theme.Text }):Play()
				else
					TweenService:Create(t.Button, TweenInfoFast, { BackgroundTransparency = 1 }):Play()
					TweenService:Create(t.Button.Icon, TweenInfoFast, { ImageColor3 = Theme.TextMuted }):Play()
					t.Button.Label.Font = Enum.Font.Gotham
					TweenService:Create(t.Button.Label, TweenInfoFast, { TextColor3 = Theme.TextSecondary }):Play()
				end
			end
		end
		tabData.SelectFn = SelectThisTab

		TabBtn.MouseEnter:Connect(function()
			if ActiveTabIndex ~= (currentOrder + 1) then
				TweenService:Create(TabBtn, TweenInfoFast, { BackgroundTransparency = 0.55 }):Play()
				TweenService:Create(IconImage, TweenInfoFast, { ImageColor3 = Theme.NeonGray }):Play()
			end
		end)

		TabBtn.MouseLeave:Connect(function()
			if ActiveTabIndex ~= (currentOrder + 1) then
				TweenService:Create(TabBtn, TweenInfoFast, { BackgroundTransparency = 1 }):Play()
				TweenService:Create(IconImage, TweenInfoFast, { ImageColor3 = Theme.TextMuted }):Play()
			end
		end)

		TabBtn.MouseButton1Click:Connect(SelectThisTab)

		if currentOrder == 0 then
			task.defer(SelectThisTab)
		end

		-- -----------------------------------------------------------------------------
		-- 11. SECTION CREATION (PinatHub Style: Accent Title + Right Chevron)
		-- -----------------------------------------------------------------------------
		local TabObj = {}

		function TabObj:AddSection(sectionNameOrConfig)
			local secTitle = "Section"
			if type(sectionNameOrConfig) == "table" then
				secTitle = sectionNameOrConfig.Title or sectionNameOrConfig.Name or secTitle
			else
				secTitle = tostring(sectionNameOrConfig or "Section")
			end

			local SectionCard = Instance.new("Frame")
			SectionCard.Name = "Section_" .. secTitle
			SectionCard.Parent = Page
			SectionCard.BackgroundColor3 = Theme.Surface
			SectionCard.BackgroundTransparency = 0.4
			SectionCard.BorderSizePixel = 0
			SectionCard.Size = UDim2.new(1, 0, 0, 36)
			SectionCard.ClipsDescendants = true

			local SecCorner = Instance.new("UICorner")
			SecCorner.CornerRadius = UDim.new(0, 8)
			SecCorner.Parent = SectionCard

			local SecStroke = Instance.new("UIStroke")
			SecStroke.Color = Theme.BorderSoft
			SecStroke.Thickness = 1
			SecStroke.Parent = SectionCard

			-- Section Header (PinatHub: Bold Purple Title + Right Chevron Down "v")
			local SecHeader = Instance.new("TextButton")
			SecHeader.Name = "Header"
			SecHeader.Parent = SectionCard
			SecHeader.BackgroundTransparency = 1
			SecHeader.Size = UDim2.new(1, 0, 0, 34)
			SecHeader.AutoButtonColor = false
			SecHeader.Text = ""

			local SecTitleLabel = Instance.new("TextLabel")
			SecTitleLabel.Name = "Title"
			SecTitleLabel.Parent = SecHeader
			SecTitleLabel.BackgroundTransparency = 1
			SecTitleLabel.Position = UDim2.new(0, 12, 0, 0)
			SecTitleLabel.Size = UDim2.new(1, -40, 1, 0)
			SecTitleLabel.Font = Enum.Font.GothamBold
			SecTitleLabel.Text = secTitle
			SecTitleLabel.TextColor3 = Theme.AccentGlow -- PinatHub Purple Accent Title
			SecTitleLabel.TextSize = 13
			SecTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

			-- Chevron Arrow "v"
			local Chevron = Instance.new("ImageLabel")
			Chevron.Name = "Chevron"
			Chevron.Parent = SecHeader
			Chevron.AnchorPoint = Vector2.new(1, 0.5)
			Chevron.Position = UDim2.new(1, -12, 0.5, 0)
			Chevron.Size = UDim2.new(0, 14, 0, 14)
			Chevron.BackgroundTransparency = 1
			Chevron.Image = TabIcons.ChevronRight
			Chevron.Rotation = 90
			Chevron.ImageColor3 = Theme.TextSecondary
			Chevron.ScaleType = Enum.ScaleType.Fit

			local ControlsContainer = Instance.new("Frame")
			ControlsContainer.Name = "Controls"
			ControlsContainer.Parent = SectionCard
			ControlsContainer.BackgroundTransparency = 1
			ControlsContainer.Position = UDim2.new(0, 0, 0, 36)
			ControlsContainer.Size = UDim2.new(1, 0, 0, 0)

			local ControlsPadding = Instance.new("UIPadding")
			ControlsPadding.Parent = ControlsContainer
			ControlsPadding.PaddingTop = UDim.new(0, 2)
			ControlsPadding.PaddingBottom = UDim.new(0, 8)
			ControlsPadding.PaddingLeft = UDim.new(0, 8)
			ControlsPadding.PaddingRight = UDim.new(0, 8)

			local ControlsLayout = Instance.new("UIListLayout")
			ControlsLayout.Parent = ControlsContainer
			ControlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ControlsLayout.Padding = UDim.new(0, 4)

			local isCollapsed = false
			local function UpdateSectionSize()
				if not isCollapsed then
					SectionCard.Size = UDim2.new(1, 0, 0, ControlsLayout.AbsoluteContentSize.Y + 44)
				end
			end
			ControlsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)

			-- Collapsible toggle
			SecHeader.MouseButton1Click:Connect(function()
				isCollapsed = not isCollapsed
				if isCollapsed then
					TweenService:Create(Chevron, TweenInfoFast, { Rotation = 0 }):Play()
					TweenService:Create(SectionCard, TweenInfoFast, { Size = UDim2.new(1, 0, 0, 34) }):Play()
				else
					TweenService:Create(Chevron, TweenInfoFast, { Rotation = 90 }):Play()
					TweenService:Create(SectionCard, TweenInfoFast, { Size = UDim2.new(1, 0, 0, ControlsLayout.AbsoluteContentSize.Y + 44) }):Play()
				end
			end)

			local secData = {
				Title = secTitle,
				Frame = SectionCard,
				Elements = {}
			}
			table.insert(tabData.Sections, secData)

			-- -----------------------------------------------------------------------------
			-- 12. SECTION CONTROLS (PinatHub MODERN DESIGN)
			-- -----------------------------------------------------------------------------
			local SecObj = {}

			-- 12.1 TOGGLE SWITCH (PinatHub Style: Optional Inline Keybind [None] + Elastic Switch)
			function SecObj:AddToggle(toggleConfig)
				local cfg = Library:MakeConfig({
					Title = "Toggle",
					Description = "",
					Default = false,
					Keybind = nil, -- Optional KeyCode or nil
					HasKeybind = false,
					Callback = function() end
				}, toggleConfig or {})

				if cfg.Desc and cfg.Description == "" then cfg.Description = cfg.Desc end
				if cfg.Value ~= nil and toggleConfig.Default == nil then cfg.Default = cfg.Value end
				local hasBind = (cfg.Keybind ~= nil) or cfg.HasKeybind or (cfg.Bind ~= nil)

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Toggle_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, (cfg.Description ~= "") and 44 or 36)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, (cfg.Description ~= "") and 5 or 0)
				TitleLabel.Size = UDim2.new(1, -125, (cfg.Description ~= "") and 0 or 1, (cfg.Description ~= "") and 16 or 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				if cfg.Description ~= "" then
					local DescLabel = Instance.new("TextLabel")
					DescLabel.Name = "Desc"
					DescLabel.Parent = ItemFrame
					DescLabel.BackgroundTransparency = 1
					DescLabel.Position = UDim2.new(0, 10, 0, 22)
					DescLabel.Size = UDim2.new(1, -125, 0, 16)
					DescLabel.Font = Enum.Font.Gotham
					DescLabel.Text = cfg.Description
					DescLabel.TextColor3 = Theme.TextMuted
					DescLabel.TextSize = 10
					DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				end

				-- Right Controls (Keybind badge + Switch)
				local RightControls = Instance.new("Frame")
				RightControls.Name = "RightControls"
				RightControls.Parent = ItemFrame
				RightControls.AnchorPoint = Vector2.new(1, 0.5)
				RightControls.Position = UDim2.new(1, -10, 0.5, 0)
				RightControls.Size = UDim2.new(0, 110, 0, 24)
				RightControls.BackgroundTransparency = 1

				local RCLayout = Instance.new("UIListLayout")
				RCLayout.Parent = RightControls
				RCLayout.FillDirection = Enum.FillDirection.Horizontal
				RCLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				RCLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				RCLayout.SortOrder = Enum.SortOrder.LayoutOrder
				RCLayout.Padding = UDim.new(0, 8)

				-- Keybind Pill [None] (PinatHub Screenshot 1)
				local currentBind = cfg.Keybind or cfg.Bind
				local KeybindBtn = nil

				if hasBind or currentBind then
					KeybindBtn = Instance.new("TextButton")
					KeybindBtn.Name = "Keybind"
					KeybindBtn.Parent = RightControls
					KeybindBtn.Size = UDim2.new(0, 48, 0, 20)
					KeybindBtn.BackgroundColor3 = Theme.SurfaceActive
					KeybindBtn.BackgroundTransparency = 0.5
					KeybindBtn.BorderSizePixel = 0
					KeybindBtn.Font = Enum.Font.GothamBold
					KeybindBtn.Text = currentBind and ("[" .. currentBind.Name .. "]") or "[None]"
					KeybindBtn.TextColor3 = Theme.TextMuted
					KeybindBtn.TextSize = 10
					KeybindBtn.LayoutOrder = 1

					local KCorner = Instance.new("UICorner")
					KCorner.CornerRadius = UDim.new(0, 4)
					KCorner.Parent = KeybindBtn

					local KStroke = Instance.new("UIStroke")
					KStroke.Color = Theme.BorderSoft
					KStroke.Thickness = 1
					KStroke.Parent = KeybindBtn

					local listening = false
					KeybindBtn.MouseButton1Click:Connect(function()
						if listening then return end
						listening = true
						KeybindBtn.Text = "[...]"
						KeybindBtn.TextColor3 = Theme.AccentGlow

						local conn
						conn = UserInputService.InputBegan:Connect(function(inp)
							if inp.UserInputType == Enum.UserInputType.Keyboard then
								listening = false
								if inp.KeyCode == Enum.KeyCode.Backspace or inp.KeyCode == Enum.KeyCode.Escape then
									currentBind = nil
									KeybindBtn.Text = "[None]"
									KeybindBtn.TextColor3 = Theme.TextMuted
								else
									currentBind = inp.KeyCode
									KeybindBtn.Text = "[" .. inp.KeyCode.Name .. "]"
									KeybindBtn.TextColor3 = Theme.TextSecondary
								end
								conn:Disconnect()
							end
						end)
					end)
				end

				-- Sliding Switch Track
				local SwitchTrack = Instance.new("TextButton")
				SwitchTrack.Name = "SwitchTrack"
				SwitchTrack.Parent = RightControls
				SwitchTrack.Size = UDim2.new(0, 38, 0, 20)
				SwitchTrack.BackgroundColor3 = Theme.SurfaceActive
				SwitchTrack.BorderSizePixel = 0
				SwitchTrack.Text = ""
				SwitchTrack.AutoButtonColor = false
				SwitchTrack.LayoutOrder = 2

				local TrackCorner = Instance.new("UICorner")
				TrackCorner.CornerRadius = UDim.new(1, 0)
				TrackCorner.Parent = SwitchTrack

				local TrackStroke = Instance.new("UIStroke")
				TrackStroke.Color = Theme.BorderSoft
				TrackStroke.Thickness = 1
				TrackStroke.Parent = SwitchTrack

				local SwitchKnob = Instance.new("Frame")
				SwitchKnob.Name = "Knob"
				SwitchKnob.Parent = SwitchTrack
				SwitchKnob.AnchorPoint = Vector2.new(0, 0.5)
				SwitchKnob.Position = UDim2.new(0, 2, 0.5, 0)
				SwitchKnob.Size = UDim2.new(0, 16, 0, 16)
				SwitchKnob.BackgroundColor3 = Theme.TextMuted
				SwitchKnob.BorderSizePixel = 0

				local KnobCorner = Instance.new("UICorner")
				KnobCorner.CornerRadius = UDim.new(1, 0)
				KnobCorner.Parent = SwitchKnob

				local ToggleState = { Value = cfg.Default }

				local function AnimateToggle(state)
					if state then
						TweenService:Create(SwitchTrack, TweenInfoFast, { BackgroundColor3 = Theme.Accent }):Play()
						TweenService:Create(TrackStroke, TweenInfoFast, { Color = Theme.AccentGlow }):Play()
						TweenService:Create(SwitchKnob, TweenInfoSpring, {
							Position = UDim2.new(1, -18, 0.5, 0),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						}):Play()
					else
						TweenService:Create(SwitchTrack, TweenInfoFast, { BackgroundColor3 = Theme.SurfaceActive }):Play()
						TweenService:Create(TrackStroke, TweenInfoFast, { Color = Theme.BorderSoft }):Play()
						TweenService:Create(SwitchKnob, TweenInfoSpring, {
							Position = UDim2.new(0, 2, 0.5, 0),
							BackgroundColor3 = Theme.TextMuted
						}):Play()
					end
				end

				function ToggleState:Set(newValue)
					self.Value = not not newValue
					AnimateToggle(self.Value)
					pcall(cfg.Callback, self.Value)
				end

				SwitchTrack.MouseButton1Click:Connect(function()
					ToggleState:Set(not ToggleState.Value)
				end)

				-- Listen for hotkey
				UserInputService.InputBegan:Connect(function(input, gpe)
					if not gpe and currentBind and input.KeyCode == currentBind then
						ToggleState:Set(not ToggleState.Value)
					end
				end)

				if cfg.Default then AnimateToggle(true) end
				Library._ControlSetters[cfg.Title] = function(value)
					ToggleState:Set(value)
				end
				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return ToggleState
			end

			-- 12.2 ACTION BUTTON (PinatHub Style: Clean Row with optional Right Icon)
			function SecObj:AddButton(btnConfig)
				local cfg = Library:MakeConfig({
					Title = "Button",
					Description = "",
					Icon = nil,
					Callback = function() end
				}, btnConfig or {})

				if cfg.Desc and cfg.Description == "" then cfg.Description = cfg.Desc end

				local BtnFrame = Instance.new("TextButton")
				BtnFrame.Name = "Button_" .. cfg.Title
				BtnFrame.Parent = ControlsContainer
				BtnFrame.BackgroundColor3 = Theme.SurfaceHover
				BtnFrame.BackgroundTransparency = 0.55
				BtnFrame.BorderSizePixel = 0
				BtnFrame.Size = UDim2.new(1, 0, 0, (cfg.Description ~= "") and 44 or 34)
				BtnFrame.AutoButtonColor = false
				BtnFrame.Text = ""

				local BtnCorner = Instance.new("UICorner")
				BtnCorner.CornerRadius = UDim.new(0, 7)
				BtnCorner.Parent = BtnFrame

				local BtnStroke = Instance.new("UIStroke")
				BtnStroke.Color = Theme.BorderSoft
				BtnStroke.Thickness = 1
				BtnStroke.Transparency = 0.4
				BtnStroke.Parent = BtnFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = BtnFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, (cfg.Description ~= "") and 5 or 0)
				TitleLabel.Size = UDim2.new(1, -40, (cfg.Description ~= "") and 0 or 1, (cfg.Description ~= "") and 16 or 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				if cfg.Description ~= "" then
					local DescLabel = Instance.new("TextLabel")
					DescLabel.Name = "Desc"
					DescLabel.Parent = BtnFrame
					DescLabel.BackgroundTransparency = 1
					DescLabel.Position = UDim2.new(0, 10, 0, 22)
					DescLabel.Size = UDim2.new(1, -40, 0, 16)
					DescLabel.Font = Enum.Font.Gotham
					DescLabel.Text = cfg.Description
					DescLabel.TextColor3 = Theme.TextMuted
					DescLabel.TextSize = 10
					DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				end

				local ActionIcon = Instance.new("ImageLabel")
				ActionIcon.Name = "ActionIcon"
				ActionIcon.Parent = BtnFrame
				ActionIcon.AnchorPoint = Vector2.new(1, 0.5)
				ActionIcon.Position = UDim2.new(1, -10, 0.5, 0)
				ActionIcon.Size = UDim2.new(0, 15, 0, 15)
				ActionIcon.BackgroundTransparency = 1
				local btnIcon = TabIcons.Cursor
				if cfg.Icon and cfg.Icon ~= "" then
					btnIcon = ResolveIcon(cfg.Icon) or TabIcons.Cursor
				end
				ActionIcon.Image = btnIcon
				ActionIcon.ImageColor3 = Theme.TextSecondary
				ActionIcon.ScaleType = Enum.ScaleType.Fit

				BtnFrame.MouseEnter:Connect(function()
					TweenService:Create(BtnFrame, TweenInfoFast, { BackgroundTransparency = 0.25 }):Play()
					TweenService:Create(BtnStroke, TweenInfoFast, { Color = Theme.AccentGlow }):Play()
					TweenService:Create(ActionIcon, TweenInfoFast, { ImageColor3 = Theme.AccentGlow }):Play()
				end)

				BtnFrame.MouseLeave:Connect(function()
					TweenService:Create(BtnFrame, TweenInfoFast, { BackgroundTransparency = 0.55 }):Play()
					TweenService:Create(BtnStroke, TweenInfoFast, { Color = Theme.BorderSoft }):Play()
					TweenService:Create(ActionIcon, TweenInfoFast, { ImageColor3 = Theme.TextSecondary }):Play()
				end)

				BtnFrame.MouseButton1Click:Connect(function()
					local pulse = TweenService:Create(BtnFrame, TweenInfoFast, { BackgroundColor3 = Theme.SurfaceActive })
					pulse:Play()
					pulse.Completed:Connect(function()
						TweenService:Create(BtnFrame, TweenInfoFast, { BackgroundColor3 = Theme.SurfaceHover }):Play()
					end)
					pcall(cfg.Callback)
				end)

				table.insert(secData.Elements, { Title = cfg.Title, Frame = BtnFrame })
				return BtnFrame
			end

			-- 12.3 RICH PARAGRAPH — Multi-select collapsible cards
			-- Each paragraph starts collapsed (header-only). Clicking the header toggles expand/collapse
			-- independently (multi-select: multiple can be open at once). Clicking anywhere outside
			-- all open paragraph panels collapses them all. The X button hides the card entirely.
			function SecObj:AddParagraph(paraConfig)
				local cfg = Library:MakeConfig({
					Title = "Information",
					Content = "",
					DefaultOpen = false
				}, paraConfig or {})

				if cfg.Desc and cfg.Content == "" then cfg.Content = cfg.Desc end
				if cfg.Description and cfg.Content == "" then cfg.Content = cfg.Description end

				-- Heights
				local COLLAPSED_H = 26
				local _isExpanded = cfg.DefaultOpen and true or false
				local _computedExpandedH = COLLAPSED_H -- updated by ResizePara

				-- Outer frame (clips children for smooth slide)
				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Para_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.6
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, COLLAPSED_H)
				ItemFrame.ClipsDescendants = true

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.45
				ItemStroke.Parent = ItemFrame

				-- ── Header row (clickable to toggle) ──────────────────────────────────
				local HeaderBtn = Instance.new("TextButton")
				HeaderBtn.Name = "ParaHeader"
				HeaderBtn.Parent = ItemFrame
				HeaderBtn.BackgroundTransparency = 1
				HeaderBtn.Position = UDim2.new(0, 0, 0, 0)
				HeaderBtn.Size = UDim2.new(1, 0, 0, COLLAPSED_H)
				HeaderBtn.Text = ""
				HeaderBtn.AutoButtonColor = false
				HeaderBtn.ZIndex = 3

				-- Chevron icon (right-pointing when collapsed, down when expanded)
				local ChevronIcon = Instance.new("ImageLabel")
				ChevronIcon.Name = "Chevron"
				ChevronIcon.Parent = ItemFrame
				ChevronIcon.AnchorPoint = Vector2.new(0, 0.5)
				ChevronIcon.Position = UDim2.new(0, 8, 0, COLLAPSED_H / 2)
				ChevronIcon.Size = UDim2.new(0, 10, 0, 10)
				ChevronIcon.BackgroundTransparency = 1
				ChevronIcon.Image = TabIcons.ChevronRight -- right = collapsed
				ChevronIcon.ImageColor3 = Theme.TextMuted
				ChevronIcon.ScaleType = Enum.ScaleType.Fit
				ChevronIcon.ZIndex = 2

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 22, 0, 0)
				TitleLabel.Size = UDim2.new(1, -52, 0, COLLAPSED_H)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.NeonWhite
				TitleLabel.TextSize = 11
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
				TitleLabel.RichText = true
				TitleLabel.ZIndex = 2

				-- X close button (hides the card entirely)
				local ParaCloseBtn = Instance.new("ImageButton")
				ParaCloseBtn.Name = "Btn_ClosePara"
				ParaCloseBtn.Parent = ItemFrame
				ParaCloseBtn.AnchorPoint = Vector2.new(1, 0.5)
				ParaCloseBtn.Position = UDim2.new(1, -7, 0, COLLAPSED_H / 2)
				ParaCloseBtn.Size = UDim2.new(0, 13, 0, 13)
				ParaCloseBtn.BackgroundTransparency = 1
				ParaCloseBtn.Image = "rbxassetid://10747384394"
				ParaCloseBtn.ImageColor3 = Theme.TextMuted
				ParaCloseBtn.ScaleType = Enum.ScaleType.Fit
				ParaCloseBtn.AutoButtonColor = false
				ParaCloseBtn.ZIndex = 4

				ParaCloseBtn.MouseEnter:Connect(function()
					TweenService:Create(ParaCloseBtn, TweenInfoFast, { ImageColor3 = Theme.Danger }):Play()
				end)
				ParaCloseBtn.MouseLeave:Connect(function()
					TweenService:Create(ParaCloseBtn, TweenInfoFast, { ImageColor3 = Theme.TextMuted }):Play()
				end)

				-- ── Content label ─────────────────────────────────────────────────────
				local ContentLabel = Instance.new("TextLabel")
				ContentLabel.Name = "Content"
				ContentLabel.Parent = ItemFrame
				ContentLabel.BackgroundTransparency = 1
				ContentLabel.Position = UDim2.new(0, 10, 0, COLLAPSED_H + 2)
				ContentLabel.Size = UDim2.new(1, -20, 0, 18)
				ContentLabel.Font = Enum.Font.Gotham
				ContentLabel.Text = cfg.Content
				ContentLabel.TextColor3 = Theme.TextSecondary
				ContentLabel.TextSize = 10
				ContentLabel.TextWrapped = true
				ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
				ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
				ContentLabel.RichText = true
				ContentLabel.ZIndex = 2

				-- Divider line between header and content
				local ParaDivider = Instance.new("Frame")
				ParaDivider.Name = "Divider"
				ParaDivider.Parent = ItemFrame
				ParaDivider.BackgroundColor3 = Theme.BorderSoft
				ParaDivider.BorderSizePixel = 0
				ParaDivider.Position = UDim2.new(0, 8, 0, COLLAPSED_H - 1)
				ParaDivider.Size = UDim2.new(1, -16, 0, 1)
				ParaDivider.BackgroundTransparency = 0.6
				ParaDivider.Visible = false
				ParaDivider.ZIndex = 2

				-- ── Resize helper ─────────────────────────────────────────────────────
				local function ResizePara()
					ContentLabel.Size = UDim2.new(1, -20, 0, 1000)
					local textH = ContentLabel.TextBounds.Y
					textH = math.max(textH, 14)
					ContentLabel.Size = UDim2.new(1, -20, 0, textH)
					_computedExpandedH = COLLAPSED_H + 6 + textH + 8
					if _isExpanded then
						ItemFrame.Size = UDim2.new(1, 0, 0, _computedExpandedH)
					end
				end

				-- ── Expand / Collapse logic ───────────────────────────────────────────
				local function ExpandPara()
					_isExpanded = true
					ParaDivider.Visible = true
					TweenService:Create(ItemFrame, TweenInfoSmooth, { Size = UDim2.new(1, 0, 0, _computedExpandedH) }):Play()
					TweenService:Create(ItemStroke, TweenInfoFast, { Color = Theme.BorderAccent, Transparency = 0.2 }):Play()
					TweenService:Create(ChevronIcon, TweenInfoFast, { Rotation = 90, ImageColor3 = Theme.AccentGlow }):Play()
					TweenService:Create(TitleLabel, TweenInfoFast, { TextColor3 = Theme.AccentGlow }):Play()
					-- Register in global active list
					local found = false
					for _, v in ipairs(Library._ActiveParaFrames) do
						if v == ItemFrame then found = true break end
					end
					if not found then
						table.insert(Library._ActiveParaFrames, ItemFrame)
					end
				end

				local function CollapsePara()
					_isExpanded = false
					ParaDivider.Visible = false
					TweenService:Create(ItemFrame, TweenInfoSmooth, { Size = UDim2.new(1, 0, 0, COLLAPSED_H) }):Play()
					TweenService:Create(ItemStroke, TweenInfoFast, { Color = Theme.BorderSoft, Transparency = 0.45 }):Play()
					TweenService:Create(ChevronIcon, TweenInfoFast, { Rotation = 0, ImageColor3 = Theme.TextMuted }):Play()
					TweenService:Create(TitleLabel, TweenInfoFast, { TextColor3 = Theme.NeonWhite }):Play()
					-- Unregister from global active list
					for i, v in ipairs(Library._ActiveParaFrames) do
						if v == ItemFrame then table.remove(Library._ActiveParaFrames, i) break end
					end
				end

				-- Header click: toggle this paragraph (multi-select: others stay open)
				HeaderBtn.MouseButton1Click:Connect(function()
					if _isExpanded then
						CollapsePara()
					else
						ExpandPara()
					end
				end)

				-- X button: hide the card entirely (does not track in active list after this)
				ParaCloseBtn.MouseButton1Click:Connect(function()
					CollapsePara()
					local t = TweenService:Create(ItemFrame, TweenInfoFast, { BackgroundTransparency = 1 })
					t:Play()
					t.Completed:Connect(function()
						ItemFrame.Visible = false
						ItemFrame.BackgroundTransparency = 0.6
					end)
				end)

				-- Hover glow on header
				HeaderBtn.MouseEnter:Connect(function()
					if not _isExpanded then
						TweenService:Create(ItemFrame, TweenInfoFast, { BackgroundTransparency = 0.5 }):Play()
					end
				end)
				HeaderBtn.MouseLeave:Connect(function()
					if not _isExpanded then
						TweenService:Create(ItemFrame, TweenInfoFast, { BackgroundTransparency = 0.6 }):Play()
					end
				end)

				ContentLabel:GetPropertyChangedSignal("TextBounds"):Connect(ResizePara)
				task.defer(function()
					ResizePara()
					if cfg.DefaultOpen then
						ExpandPara()
					end
				end)

				-- ── ParaObj API ───────────────────────────────────────────────────────
				local ParaObj = {}
				ParaObj.Frame = ItemFrame
				function ParaObj:SetTitle(newTitle)
					TitleLabel.Text = tostring(newTitle)
				end
				function ParaObj:SetDesc(newDesc)
					ContentLabel.Text = tostring(newDesc)
					ResizePara()
				end
				function ParaObj:SetContent(newDesc)
					ContentLabel.Text = tostring(newDesc)
					ResizePara()
				end
				function ParaObj:Set(arg1, arg2)
					if arg2 ~= nil then
						TitleLabel.Text = tostring(arg1)
						ContentLabel.Text = tostring(arg2)
					else
						ContentLabel.Text = tostring(arg1)
					end
					ResizePara()
				end
				function ParaObj:Expand()
					ItemFrame.Visible = true
					ExpandPara()
				end
				function ParaObj:Collapse()
					CollapsePara()
				end
				function ParaObj:Open()
					ItemFrame.Visible = true
					ExpandPara()
				end
				function ParaObj:Close()
					ItemFrame.Visible = false
				end
				function ParaObj:Toggle()
					if _isExpanded then CollapsePara() else ExpandPara() end
				end

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return ParaObj
			end

			-- 12.4 REAL-TIME DATA GRAPH (Animated Bar Chart Telemetry)
			function SecObj:AddGraph(graphConfig)
				local cfg = Library:MakeConfig({
					Title = "Data Graph",
					BarCount = 14,
					MaxValue = 100,
					Height = 110,
					BarColor = Theme.Accent,
					BarGlow = Theme.AccentGlow,
					Unit = "/s"
				}, graphConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Graph_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.5
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, cfg.Height)
				ItemFrame.ClipsDescendants = true

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 8)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.5
				ItemStroke.Parent = ItemFrame

				-- Header Info
				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 12, 0, 8)
				TitleLabel.Size = UDim2.new(0.6, 0, 0, 16)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = string.upper(cfg.Title)
				TitleLabel.TextColor3 = Theme.TextSecondary
				TitleLabel.TextSize = 10
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local ValueLabel = Instance.new("TextLabel")
				ValueLabel.Name = "Value"
				ValueLabel.Parent = ItemFrame
				ValueLabel.AnchorPoint = Vector2.new(1, 0)
				ValueLabel.Position = UDim2.new(1, -12, 0, 8)
				ValueLabel.Size = UDim2.new(0.35, 0, 0, 16)
				ValueLabel.BackgroundTransparency = 1
				ValueLabel.Font = Enum.Font.GothamBold
				ValueLabel.Text = "0" .. cfg.Unit
				ValueLabel.TextColor3 = Theme.AccentGlow
				ValueLabel.TextSize = 11
				ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

				-- Bars Container
				local ChartFrame = Instance.new("Frame")
				ChartFrame.Name = "Bars"
				ChartFrame.Parent = ItemFrame
				ChartFrame.Position = UDim2.new(0, 12, 0, 30)
				ChartFrame.Size = UDim2.new(1, -24, 0, cfg.Height - 38)
				ChartFrame.BackgroundTransparency = 1

				local ChartLayout = Instance.new("UIListLayout")
				ChartLayout.Parent = ChartFrame
				ChartLayout.FillDirection = Enum.FillDirection.Horizontal
				ChartLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ChartLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
				ChartLayout.Padding = UDim.new(0, 5)

				local history = {}
				local barFills = {}
				for i = 1, cfg.BarCount do
					table.insert(history, 0)

					local track = Instance.new("Frame")
					track.Name = "Track_" .. i
					track.Parent = ChartFrame
					track.BackgroundColor3 = Theme.SurfaceActive
					track.BackgroundTransparency = 0.4
					track.BorderSizePixel = 0
					track.Size = UDim2.new(0, 18, 1, 0)

					local trCorner = Instance.new("UICorner")
					trCorner.CornerRadius = UDim.new(0, 4)
					trCorner.Parent = track

					local fill = Instance.new("Frame")
					fill.Name = "Fill"
					fill.Parent = track
					fill.AnchorPoint = Vector2.new(0, 1)
					fill.Position = UDim2.new(0, 0, 1, 0)
					fill.Size = UDim2.new(1, 0, 0.08, 0)
					fill.BackgroundColor3 = cfg.BarColor
					fill.BorderSizePixel = 0

					local fCorner = Instance.new("UICorner")
					fCorner.CornerRadius = UDim.new(0, 4)
					fCorner.Parent = fill

					local barGrad = Instance.new("UIGradient")
					barGrad.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, cfg.BarGlow),
						ColorSequenceKeypoint.new(1, cfg.BarColor)
					})
					barGrad.Rotation = 90
					barGrad.Parent = fill

					table.insert(barFills, fill)
				end

				local GraphObj = {
					MaxValue = cfg.MaxValue,
					Unit = cfg.Unit
				}

				function GraphObj:Push(val)
					val = tonumber(val) or 0
					table.remove(history, 1)
					table.insert(history, val)
					ValueLabel.Text = tostring(math.floor(val)) .. self.Unit

					for i, fill in ipairs(barFills) do
						local hVal = history[i] or 0
						local ratio = math.clamp(hVal / math.max(self.MaxValue, 1), 0.08, 1)
						TweenService:Create(fill, TweenInfoFast, { Size = UDim2.new(1, 0, ratio, 0) }):Play()
					end
				end

				function GraphObj:SetRate(val)
					self:Push(val)
				end

				function GraphObj:SetMax(newMax)
					self.MaxValue = tonumber(newMax) or 100
				end

				function GraphObj:SetTitle(newTitle)
					TitleLabel.Text = string.upper(tostring(newTitle))
				end

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return GraphObj
			end

			-- Sub-Toggle (indented secondary toggle)
			function SecObj:AddSubToggle(toggleConfig)
				local cfg = Library:MakeConfig({
					Title = "Sub Toggle",
					Default = false,
					Callback = function() end
				}, toggleConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "SubToggle_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.8
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 32)
				ItemFrame.ClipsDescendants = true

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 6)
				ItemCorner.Parent = ItemFrame

				-- Indent bar
				local IndentLine = Instance.new("Frame")
				IndentLine.Name = "Indent"
				IndentLine.Parent = ItemFrame
				IndentLine.Position = UDim2.new(0, 10, 0.25, 0)
				IndentLine.Size = UDim2.new(0, 2, 0.5, 0)
				IndentLine.BackgroundColor3 = Theme.BorderSoft
				IndentLine.BorderSizePixel = 0

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 20, 0, 0)
				TitleLabel.Size = UDim2.new(1, -70, 1, 0)
				TitleLabel.Font = Enum.Font.Gotham
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.TextSecondary
				TitleLabel.TextSize = 11
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local SwitchTrack = Instance.new("TextButton")
				SwitchTrack.Name = "Switch"
				SwitchTrack.Parent = ItemFrame
				SwitchTrack.AnchorPoint = Vector2.new(1, 0.5)
				SwitchTrack.Position = UDim2.new(1, -10, 0.5, 0)
				SwitchTrack.Size = UDim2.new(0, 32, 0, 18)
				SwitchTrack.BackgroundColor3 = Theme.SurfaceActive
				SwitchTrack.BorderSizePixel = 0
				SwitchTrack.AutoButtonColor = false
				SwitchTrack.Text = ""

				local SwCorner = Instance.new("UICorner")
				SwCorner.CornerRadius = UDim.new(1, 0)
				SwCorner.Parent = SwitchTrack

				local SwThumb = Instance.new("Frame")
				SwThumb.Name = "Thumb"
				SwThumb.Parent = SwitchTrack
				SwThumb.AnchorPoint = Vector2.new(0, 0.5)
				SwThumb.Position = UDim2.new(0, 2, 0.5, 0)
				SwThumb.Size = UDim2.new(0, 14, 0, 14)
				SwThumb.BackgroundColor3 = Theme.TextMuted
				SwThumb.BorderSizePixel = 0

				local ThumbCorner = Instance.new("UICorner")
				ThumbCorner.CornerRadius = UDim.new(1, 0)
				ThumbCorner.Parent = SwThumb

				local state = cfg.Default or false

				local function UpdateSwitch(instant)
					local ti = instant and TweenInfo.new(0) or TweenInfoFast
					if state then
						TweenService:Create(SwitchTrack, ti, { BackgroundColor3 = Theme.Accent }):Play()
						TweenService:Create(SwThumb, ti, { Position = UDim2.new(1, -16, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
						TweenService:Create(TitleLabel, ti, { TextColor3 = Theme.Text }):Play()
					else
						TweenService:Create(SwitchTrack, ti, { BackgroundColor3 = Theme.SurfaceActive }):Play()
						TweenService:Create(SwThumb, ti, { Position = UDim2.new(0, 2, 0.5, 0), BackgroundColor3 = Theme.TextMuted }):Play()
						TweenService:Create(TitleLabel, ti, { TextColor3 = Theme.TextSecondary }):Play()
					end
				end
				UpdateSwitch(true)

				SwitchTrack.MouseButton1Click:Connect(function()
					state = not state
					UpdateSwitch(false)
					pcall(cfg.Callback, state)
				end)

				local SubObj = {}
				function SubObj:Set(v)
					state = not not v
					UpdateSwitch(false)
					pcall(cfg.Callback, state)
				end
				function SubObj:Get()
					return state
				end
				Library._ControlSetters[cfg.Title] = function(value)
					SubObj:Set(value)
				end

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return SubObj
			end

			-- Combined Toggle + Slider in single row
			function SecObj:AddToggleSlider(tsConfig)
				local cfg = Library:MakeConfig({
					Title = "Toggle & Slider",
					DefaultToggle = false,
					Min = 1,
					Max = 100,
					DefaultSlider = 16,
					Suffix = "",
					Callback = function() end
				}, tsConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "TS_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.65
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 48)
				ItemFrame.ClipsDescendants = true

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 8)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.5
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 12, 0, 6)
				TitleLabel.Size = UDim2.new(1, -90, 0, 16)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local tsDecimals = (function()
					local function countDec(val)
						if not val then return 0 end
						local s = tostring(val)
						local dot = s:find("%.")
						return dot and (#s - dot) or 0
					end
					if type(cfg.Decimals) == "number" and cfg.Decimals >= 0 then return math.min(math.floor(cfg.Decimals), 6) end
					local incDec = countDec(cfg.Increment)
					if incDec > 0 then return math.min(incDec, 6) end
					local minDec = countDec(cfg.Min)
					local defDec = countDec(cfg.DefaultSlider)
					local maxDec = math.max(minDec, defDec)
					if maxDec > 0 then return math.min(maxDec, 6) end
					return 0
				end)()

				local function FormatTSValue(val)
					val = tonumber(val) or 0
					if tsDecimals > 0 then
						return string.format("%." .. tsDecimals .. "f", val)
					else
						return tostring(math.floor(val + 0.5))
					end
				end

				local ValLabel = Instance.new("TextLabel")
				ValLabel.Name = "Value"
				ValLabel.Parent = ItemFrame
				ValLabel.AnchorPoint = Vector2.new(1, 0)
				ValLabel.Position = UDim2.new(1, -52, 0, 6)
				ValLabel.Size = UDim2.new(0, 50, 0, 16)
				ValLabel.BackgroundTransparency = 1
				ValLabel.Font = Enum.Font.Gotham
				ValLabel.Text = FormatTSValue(cfg.DefaultSlider or cfg.Min) .. cfg.Suffix
				ValLabel.TextColor3 = Theme.TextSecondary
				ValLabel.TextSize = 11
				ValLabel.TextXAlignment = Enum.TextXAlignment.Right

				-- Toggle switch
				local Switch = Instance.new("TextButton")
				Switch.Name = "Switch"
				Switch.Parent = ItemFrame
				Switch.AnchorPoint = Vector2.new(1, 0)
				Switch.Position = UDim2.new(1, -10, 0, 6)
				Switch.Size = UDim2.new(0, 34, 0, 16)
				Switch.BackgroundColor3 = Theme.SurfaceActive
				Switch.BorderSizePixel = 0
				Switch.AutoButtonColor = false
				Switch.Text = ""

				local SwCorner = Instance.new("UICorner")
				SwCorner.CornerRadius = UDim.new(1, 0)
				SwCorner.Parent = Switch

				local SwThumb = Instance.new("Frame")
				SwThumb.Name = "Thumb"
				SwThumb.Parent = Switch
				SwThumb.AnchorPoint = Vector2.new(0, 0.5)
				SwThumb.Position = UDim2.new(0, 2, 0.5, 0)
				SwThumb.Size = UDim2.new(0, 12, 0, 12)
				SwThumb.BackgroundColor3 = Theme.TextMuted
				SwThumb.BorderSizePixel = 0

				local ThCorner = Instance.new("UICorner")
				ThCorner.CornerRadius = UDim.new(1, 0)
				ThCorner.Parent = SwThumb

				-- Slider track
				local Track = Instance.new("Frame")
				Track.Name = "Track"
				Track.Parent = ItemFrame
				Track.Position = UDim2.new(0, 12, 0, 32)
				Track.Size = UDim2.new(1, -24, 0, 4)
				Track.BackgroundColor3 = Theme.SurfaceActive
				Track.BorderSizePixel = 0

				local TrkCorner = Instance.new("UICorner")
				TrkCorner.CornerRadius = UDim.new(1, 0)
				TrkCorner.Parent = Track

				local Fill = Instance.new("Frame")
				Fill.Name = "Fill"
				Fill.Parent = Track
				Fill.Size = UDim2.new(0.5, 0, 1, 0)
				Fill.BackgroundColor3 = Theme.Accent
				Fill.BorderSizePixel = 0

				local FillCorner = Instance.new("UICorner")
				FillCorner.CornerRadius = UDim.new(1, 0)
				FillCorner.Parent = Fill

				local tState = cfg.DefaultToggle or false
				local sVal = cfg.DefaultSlider or cfg.Min

				local function UpdateT(instant)
					local ti = instant and TweenInfo.new(0) or TweenInfoFast
					if tState then
						TweenService:Create(Switch, ti, { BackgroundColor3 = Theme.Accent }):Play()
						TweenService:Create(SwThumb, ti, { Position = UDim2.new(1, -14, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
					else
						TweenService:Create(Switch, ti, { BackgroundColor3 = Theme.SurfaceActive }):Play()
						TweenService:Create(SwThumb, ti, { Position = UDim2.new(0, 2, 0.5, 0), BackgroundColor3 = Theme.TextMuted }):Play()
					end
				end

				local function UpdateS(val)
					val = tonumber(val) or cfg.Min
					if cfg.Increment and cfg.Increment > 0 then
						local steps = math.floor((val - cfg.Min) / cfg.Increment + 0.5)
						val = cfg.Min + (steps * cfg.Increment)
						if tsDecimals > 0 then
							local mult = 10 ^ tsDecimals
							local rounded = math.floor(val * mult + 0.5) / mult
							val = tonumber(string.format("%." .. tsDecimals .. "f", rounded)) or rounded
						else
							val = math.floor(val + 0.5)
						end
					end
					sVal = math.clamp(val, cfg.Min, cfg.Max)
					local pct = (sVal - cfg.Min) / math.max(cfg.Max - cfg.Min, 1)
					Fill.Size = UDim2.new(pct, 0, 1, 0)
					ValLabel.Text = FormatTSValue(sVal) .. cfg.Suffix
				end

				UpdateT(true)
				UpdateS(sVal)

				Switch.MouseButton1Click:Connect(function()
					tState = not tState
					UpdateT(false)
					pcall(cfg.Callback, tState, sVal)
				end)

				local sDragging = false
				Track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sDragging = true
						local pct = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
						UpdateS(cfg.Min + pct * (cfg.Max - cfg.Min))
						pcall(cfg.Callback, tState, sVal)
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sDragging = false
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if sDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						local pct = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
						UpdateS(cfg.Min + pct * (cfg.Max - cfg.Min))
						pcall(cfg.Callback, tState, sVal)
					end
				end)

				local TSObj = {}
				function TSObj:SetToggle(v)
					tState = not not v
					UpdateT(false)
					pcall(cfg.Callback, tState, sVal)
				end
				function TSObj:SetSlider(v)
					UpdateS(v)
					pcall(cfg.Callback, tState, sVal)
				end
				function TSObj:Get()
					return tState, sVal
				end
				Library._ControlSetters[cfg.Title] = function(value)
					TSObj:SetToggle(value)
				end

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return TSObj
			end



			-- 12.4 DISCORD / COMMUNITY CARD (PinatHub Screenshot 3: Discord card with stats & COPY LINK)
			function SecObj:AddDiscordCard(discordConfig)
				local cfg = Library:MakeConfig({
					Title = "PinatHub Official Community",
					Members = "30522",
					Online = "2309",
					Invite = "https://discord.gg/ysHZCYFaX7",
					Callback = function() end
				}, discordConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "DiscordCard"
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.6
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 86)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 8)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				-- Logo on left
				local Logo = Instance.new("ImageLabel")
				Logo.Name = "Logo"
				Logo.Parent = ItemFrame
				Logo.Position = UDim2.new(0, 12, 0, 12)
				Logo.Size = UDim2.new(0, 28, 0, 28)
				Logo.BackgroundTransparency = 1
				Logo.Image = PINATHUB_LOGO
				Logo.ImageColor3 = Theme.AccentGlow
				Logo.ScaleType = Enum.ScaleType.Fit

				-- Title
				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 48, 0, 10)
				TitleLabel.Size = UDim2.new(1, -56, 0, 16)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				-- Members & Online text
				local SubtitleLabel = Instance.new("TextLabel")
				SubtitleLabel.Name = "Subtitle"
				SubtitleLabel.Parent = ItemFrame
				SubtitleLabel.BackgroundTransparency = 1
				SubtitleLabel.Position = UDim2.new(0, 48, 0, 26)
				SubtitleLabel.Size = UDim2.new(1, -56, 0, 14)
				SubtitleLabel.Font = Enum.Font.Gotham
				SubtitleLabel.RichText = true
				SubtitleLabel.Text = string.format("Members: %s • <font color='#4ade80'>Online: %s</font>", cfg.Members, cfg.Online)
				SubtitleLabel.TextColor3 = Theme.TextMuted
				SubtitleLabel.TextSize = 10
				SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				-- "COPY LINK" Button (Screenshot 3)
				local CopyBtn = Instance.new("TextButton")
				CopyBtn.Name = "CopyBtn"
				CopyBtn.Parent = ItemFrame
				CopyBtn.Position = UDim2.new(0, 12, 0, 48)
				CopyBtn.Size = UDim2.new(1, -24, 0, 26)
				CopyBtn.BackgroundColor3 = Theme.SurfaceActive
				CopyBtn.BackgroundTransparency = 0.3
				CopyBtn.BorderSizePixel = 0
				CopyBtn.Font = Enum.Font.GothamBold
				CopyBtn.Text = "COPY LINK"
				CopyBtn.TextColor3 = Theme.TextSecondary
				CopyBtn.TextSize = 10

				local CBCorner = Instance.new("UICorner")
				CBCorner.CornerRadius = UDim.new(0, 5)
				CBCorner.Parent = CopyBtn

				local CBStroke = Instance.new("UIStroke")
				CBStroke.Color = Theme.BorderSoft
				CBStroke.Thickness = 1
				CBStroke.Parent = CopyBtn

				CopyBtn.MouseEnter:Connect(function()
					TweenService:Create(CopyBtn, TweenInfoFast, { BackgroundTransparency = 0, TextColor3 = Theme.Text }):Play()
				end)
				CopyBtn.MouseLeave:Connect(function()
					TweenService:Create(CopyBtn, TweenInfoFast, { BackgroundTransparency = 0.3, TextColor3 = Theme.TextSecondary }):Play()
				end)

				CopyBtn.MouseButton1Click:Connect(function()
					if setclipboard then
						setclipboard(cfg.Invite)
					end
					Library:Notify({
						Title = "Invite Copied",
						Content = "Link copied to your clipboard!",
						Type = "Success",
						Duration = 2.5
					})
					pcall(cfg.Callback, cfg.Invite)
				end)

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return ItemFrame
			end

			-- 12.5 SLIDER (Modern Slider Row)
			function SecObj:AddSlider(sliderConfig)
				local cfg = Library:MakeConfig({
					Title = "Slider",
					Description = "",
					Min = 0,
					Max = 100,
					Increment = 1,
					Default = 50,
					Callback = function() end
				}, sliderConfig or {})

				if cfg.Desc and cfg.Description == "" then cfg.Description = cfg.Desc end

				local function GetDecimals(inc, dec, minVal, defVal)
					if type(dec) == "number" and dec >= 0 then return math.min(math.floor(dec), 6) end
					local function countDec(val)
						if not val then return 0 end
						local s = tostring(val)
						local dot = s:find("%.")
						return dot and (#s - dot) or 0
					end
					local incDec = countDec(inc)
					if incDec > 0 then return math.min(incDec, 6) end
					local minDec = countDec(minVal)
					local defDec = countDec(defVal)
					local maxDec = math.max(minDec, defDec)
					if maxDec > 0 then return math.min(maxDec, 6) end
					return 0
				end

				local decimals = GetDecimals(cfg.Increment, cfg.Decimals or cfg.Precision or cfg.Rounding, cfg.Min, cfg.Default)

				local function Round(num, inc, dec)
					local incVal = tonumber(inc)
					num = tonumber(num) or 0
					if not incVal or incVal <= 0 then incVal = 1 end
					local steps = math.floor((num - cfg.Min) / incVal + 0.5)
					local raw = cfg.Min + (steps * incVal)
					local d = (type(dec) == "number") and dec or decimals
					if d > 0 then
						local mult = 10 ^ d
						local rounded = math.floor(raw * mult + 0.5) / mult
						return tonumber(string.format("%." .. d .. "f", rounded)) or rounded
					else
						return math.floor(raw + 0.5)
					end
				end

				local function FormatValue(val, inc, dec)
					val = tonumber(val) or 0
					local d = (type(dec) == "number") and dec or decimals
					if d > 0 then
						return string.format("%." .. d .. "f", val)
					else
						return tostring(math.floor(val + 0.5))
					end
				end

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Slider_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 48)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, 6)
				TitleLabel.Size = UDim2.new(1, -70, 0, 16)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local ValueInput = Instance.new("TextBox")
				ValueInput.Name = "Value"
				ValueInput.Parent = ItemFrame
				ValueInput.AnchorPoint = Vector2.new(1, 0)
				ValueInput.Position = UDim2.new(1, -10, 0, 6)
				ValueInput.Size = UDim2.new(0, 50, 0, 16)
				ValueInput.BackgroundTransparency = 1
				ValueInput.Font = Enum.Font.GothamBold
				ValueInput.Text = FormatValue(cfg.Default, cfg.Increment, decimals)
				ValueInput.TextColor3 = Theme.AccentGlow
				ValueInput.TextSize = 11
				ValueInput.TextXAlignment = Enum.TextXAlignment.Right

				local SliderRail = Instance.new("Frame")
				SliderRail.Name = "Rail"
				SliderRail.Parent = ItemFrame
				SliderRail.Position = UDim2.new(0, 10, 0, 30)
				SliderRail.Size = UDim2.new(1, -20, 0, 6)
				SliderRail.BackgroundColor3 = Theme.SurfaceActive
				SliderRail.BorderSizePixel = 0

				local RailCorner = Instance.new("UICorner")
				RailCorner.CornerRadius = UDim.new(1, 0)
				RailCorner.Parent = SliderRail

				local RailFill = Instance.new("Frame")
				RailFill.Name = "Fill"
				RailFill.Parent = SliderRail
				RailFill.BackgroundColor3 = Theme.Accent
				RailFill.BorderSizePixel = 0
				RailFill.Size = UDim2.fromScale(0, 1)

				local FillCorner = Instance.new("UICorner")
				FillCorner.CornerRadius = UDim.new(1, 0)
				FillCorner.Parent = RailFill

				local Thumb = Instance.new("Frame")
				Thumb.Name = "Thumb"
				Thumb.Parent = SliderRail
				Thumb.AnchorPoint = Vector2.new(0.5, 0.5)
				Thumb.Position = UDim2.new(0, 0, 0.5, 0)
				Thumb.Size = UDim2.new(0, 12, 0, 12)
				Thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Thumb.BorderSizePixel = 0

				local ThumbCorner = Instance.new("UICorner")
				ThumbCorner.CornerRadius = UDim.new(1, 0)
				ThumbCorner.Parent = Thumb

				local SliderState = { Value = cfg.Default }
				local dragging = false

				function SliderState:Set(value)
					value = math.clamp(Round(value, cfg.Increment, decimals), cfg.Min, cfg.Max)
					self.Value = value
					ValueInput.Text = FormatValue(value, cfg.Increment, decimals)
					local scale = (value - cfg.Min) / math.max(cfg.Max - cfg.Min, 0.0001)
					TweenService:Create(RailFill, TweenInfoFast, { Size = UDim2.fromScale(scale, 1) }):Play()
					TweenService:Create(Thumb, TweenInfoFast, { Position = UDim2.new(scale, 0, 0.5, 0) }):Play()
					pcall(cfg.Callback, value)
				end

				SliderRail.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						local scale = math.clamp((input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
						SliderState:Set(cfg.Min + ((cfg.Max - cfg.Min) * scale))
					end
				end)

				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						local scale = math.clamp((input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
						SliderState:Set(cfg.Min + ((cfg.Max - cfg.Min) * scale))
					end
				end)

				ValueInput.FocusLost:Connect(function()
					local val = tonumber(ValueInput.Text)
					if val then SliderState:Set(val) else ValueInput.Text = FormatValue(SliderState.Value, cfg.Increment, decimals) end
				end)

				SliderState:Set(cfg.Default)
				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return SliderState
			end

			-- 12.6 DROPDOWN (PinatHub Screenshot 1 & 2: Pill Row that triggers Popout Drawer on right)
			function SecObj:AddDropdown(dropdownConfig)
				local cfg = Library:MakeConfig({
					Title = "Dropdown",
					Description = "",
					Values = {},
					Default = nil,
					Multi = false,
					Callback = function() end
				}, dropdownConfig or {})

				if cfg.Desc and cfg.Description == "" then cfg.Description = cfg.Desc end
				if cfg.Value ~= nil and dropdownConfig.Default == nil then cfg.Default = cfg.Value end

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Dropdown_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 36)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, 0)
				TitleLabel.Size = UDim2.new(1, -125, 1, 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				-- Dropdown Pill (Screenshot 1: "Default v")
				local DropPill = Instance.new("TextButton")
				DropPill.Name = "Pill"
				DropPill.Parent = ItemFrame
				DropPill.AnchorPoint = Vector2.new(1, 0.5)
				DropPill.Position = UDim2.new(1, -10, 0.5, 0)
				DropPill.Size = UDim2.new(0, 105, 0, 22)
				DropPill.BackgroundColor3 = Theme.SurfaceActive
				DropPill.BorderSizePixel = 0
				DropPill.AutoButtonColor = false
				DropPill.Text = ""

				local PillCorner = Instance.new("UICorner")
				PillCorner.CornerRadius = UDim.new(0, 5)
				PillCorner.Parent = DropPill

				local PillStroke = Instance.new("UIStroke")
				PillStroke.Color = Theme.BorderSoft
				PillStroke.Thickness = 1
				PillStroke.Parent = DropPill

				local PillText = Instance.new("TextLabel")
				PillText.Name = "Label"
				PillText.Parent = DropPill
				PillText.BackgroundTransparency = 1
				PillText.Position = UDim2.new(0, 8, 0, 0)
				PillText.Size = UDim2.new(1, -24, 1, 0)
				PillText.Font = Enum.Font.Gotham
				PillText.Text = "Select..."
				PillText.TextColor3 = Theme.TextSecondary
				PillText.TextSize = 10
				PillText.TextTruncate = Enum.TextTruncate.AtEnd
				PillText.TextXAlignment = Enum.TextXAlignment.Left

				local Arrow = Instance.new("ImageLabel")
				Arrow.Name = "Arrow"
				Arrow.Parent = DropPill
				Arrow.AnchorPoint = Vector2.new(1, 0.5)
				Arrow.Position = UDim2.new(1, -4, 0.5, 0)
				Arrow.Size = UDim2.new(0, 12, 0, 12)
				Arrow.BackgroundTransparency = 1
				Arrow.Image = TabIcons.ChevronRight
				Arrow.Rotation = 90
				Arrow.ImageColor3 = Theme.TextMuted

				local SelectedValues = {}
				if cfg.Multi then
					if type(cfg.Default) == "table" then
						for _, v in ipairs(cfg.Default) do table.insert(SelectedValues, v) end
					elseif cfg.Default then
						table.insert(SelectedValues, cfg.Default)
					end
				else
					if type(cfg.Default) == "table" and #cfg.Default > 0 then
						SelectedValues = { cfg.Default[1] }
					elseif cfg.Default then
						SelectedValues = { tostring(cfg.Default) }
					end
				end

				local DropdownObj = {
					Values = cfg.Values or {},
					Selected = SelectedValues
				}

				local function UpdatePillDisplay()
					if #DropdownObj.Selected == 0 then
						PillText.Text = "Select..."
						PillText.TextColor3 = Theme.TextMuted
					else
						PillText.Text = table.concat(DropdownObj.Selected, ", ")
						PillText.TextColor3 = Theme.Text
					end
				end

				UpdatePillDisplay()

				-- Open Popout Drawer (PinatHub Screenshot 2)
				-- renderedOptions tracks THIS dropdown's rows only for cleanup.
				-- On open we also nuke ALL stale children in PopoutScroll so options
				-- from a previously-opened dropdown never bleed through.
				local renderedOptions = {}
				local function OpenDrawer()
					-- ── Purge ALL existing option rows from the shared PopoutScroll ──
					-- This is the fix for cross-dropdown option mixing: every child that
					-- isn't the UIListLayout is an orphaned row from a prior dropdown.
					for _, child in ipairs(PopoutScroll:GetChildren()) do
						if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
							child:Destroy()
						end
					end
					renderedOptions = {}

					PopoutDrawer.Visible = true
					PopoutBackdrop.Visible = true
					PopoutTitle.Text = cfg.Title  -- Show which dropdown is open
					PopoutSBox.Text = ""

					local function RenderList()
						-- Clear only THIS dropdown's rendered rows (list re-render)
						for _, item in ipairs(renderedOptions) do
							if item and item.Parent then item:Destroy() end
						end
						renderedOptions = {}

						local query = string.lower(PopoutSBox.Text or "")
						for _, optVal in ipairs(DropdownObj.Values) do
							local strVal = tostring(optVal)
							if query == "" or string.find(string.lower(strVal), query) then
								local isSelected = table.find(DropdownObj.Selected, strVal) ~= nil

								local row = Instance.new("TextButton")
								row.Name = "Opt_" .. strVal
								row.Parent = PopoutScroll
								row.Size = UDim2.new(1, 0, 0, 26)
								row.BackgroundColor3 = isSelected and Theme.SurfaceActive or Theme.Header
								row.BackgroundTransparency = isSelected and 0.2 or 0.8
								row.BorderSizePixel = 0
								row.AutoButtonColor = false
								row.Text = ""

								local rCorner = Instance.new("UICorner")
								rCorner.CornerRadius = UDim.new(0, 5)
								rCorner.Parent = row

								-- Active Purple Indicator Bar (Screenshot 2)
								local optIndicator = Instance.new("Frame")
								optIndicator.Name = "Bar"
								optIndicator.Parent = row
								optIndicator.AnchorPoint = Vector2.new(0, 0.5)
								optIndicator.Position = UDim2.new(0, 2, 0.5, 0)
								optIndicator.Size = UDim2.new(0, 3, 0.6, 0)
								optIndicator.BackgroundColor3 = Theme.Accent
								optIndicator.BorderSizePixel = 0
								optIndicator.Visible = isSelected

								local optLbl = Instance.new("TextLabel")
								optLbl.Parent = row
								optLbl.BackgroundTransparency = 1
								optLbl.Position = UDim2.new(0, 10, 0, 0)
								optLbl.Size = UDim2.new(1, -14, 1, 0)
								optLbl.Font = isSelected and Enum.Font.GothamBold or Enum.Font.Gotham
								optLbl.Text = strVal
								optLbl.TextColor3 = isSelected and Theme.Text or Theme.TextSecondary
								optLbl.TextSize = 11
								optLbl.TextXAlignment = Enum.TextXAlignment.Left

								row.MouseButton1Click:Connect(function()
									if cfg.Multi then
										-- Multi-select: toggle item, keep drawer open
										local idx = table.find(DropdownObj.Selected, strVal)
										if idx then
											table.remove(DropdownObj.Selected, idx)
										else
											table.insert(DropdownObj.Selected, strVal)
										end
										UpdatePillDisplay()
										RenderList()
										pcall(cfg.Callback, DropdownObj.Selected)
									else
										-- Single-select: update selection, keep drawer open.
										-- Drawer closes ONLY via click-outside (UserInputService handler).
										DropdownObj.Selected = { strVal }
										UpdatePillDisplay()
										RenderList()
										pcall(cfg.Callback, strVal)
									end
								end)

								table.insert(renderedOptions, row)
							end
						end
					end

					PopoutSBox:GetPropertyChangedSignal("Text"):Connect(RenderList)
					RenderList()
				end

				DropPill.MouseButton1Click:Connect(function()
					if PopoutDrawer.Visible then
						PopoutDrawer.Visible = false
					else
						OpenDrawer()
					end
				end)

				function DropdownObj:Set(newValues)
					if type(newValues) == "table" then
						self.Selected = newValues
					else
						self.Selected = { tostring(newValues) }
					end
					UpdatePillDisplay()
				end

				function DropdownObj:Refresh(newOptions, resetSelection)
					self.Values = newOptions or {}
					if resetSelection then self.Selected = {} end
					UpdatePillDisplay()
				end

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return DropdownObj
			end

			-- 12.7 TEXT INPUT (PinatHub Style)
			function SecObj:AddInput(inputConfig)
				local cfg = Library:MakeConfig({
					Title = "Input",
					Description = "",
					PlaceHolder = "Type here...",
					Default = "",
					Callback = function() end
				}, inputConfig or {})

				if cfg.Desc and cfg.Description == "" then cfg.Description = cfg.Desc end

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Input_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 36)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, 0)
				TitleLabel.Size = UDim2.new(1, -125, 1, 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local BoxFrame = Instance.new("Frame")
				BoxFrame.Name = "BoxFrame"
				BoxFrame.Parent = ItemFrame
				BoxFrame.AnchorPoint = Vector2.new(1, 0.5)
				BoxFrame.Position = UDim2.new(1, -10, 0.5, 0)
				BoxFrame.Size = UDim2.new(0, 105, 0, 22)
				BoxFrame.BackgroundColor3 = Theme.SurfaceActive
				BoxFrame.BorderSizePixel = 0
				BoxFrame.ClipsDescendants = true

				local BoxCorner = Instance.new("UICorner")
				BoxCorner.CornerRadius = UDim.new(0, 5)
				BoxCorner.Parent = BoxFrame

				local BoxStroke = Instance.new("UIStroke")
				BoxStroke.Color = Theme.BorderSoft
				BoxStroke.Thickness = 1
				BoxStroke.Parent = BoxFrame

				local TextBox = Instance.new("TextBox")
				TextBox.Name = "TextBox"
				TextBox.Parent = BoxFrame
				TextBox.BackgroundTransparency = 1
				TextBox.Position = UDim2.new(0, 6, 0, 0)
				TextBox.Size = UDim2.new(1, -12, 1, 0)
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderColor3 = Theme.TextMuted
				TextBox.PlaceholderText = cfg.PlaceHolder or "Type..."
				TextBox.Text = cfg.Default or ""
				TextBox.TextColor3 = Theme.Text
				TextBox.TextSize = 11
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.TextWrapped = false
				TextBox.TextTruncate = Enum.TextTruncate.AtEnd

				TextBox.Focused:Connect(function()
					TweenService:Create(BoxStroke, TweenInfoFast, { Color = Theme.Accent, Transparency = 0.2 }):Play()
				end)

				TextBox.FocusLost:Connect(function()
					TweenService:Create(BoxStroke, TweenInfoFast, { Color = Theme.BorderSoft, Transparency = 0 }):Play()
					pcall(cfg.Callback, TextBox.Text)
				end)

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return TextBox
			end

			-- 12.8 SEPARATOR / DIVIDER
			function SecObj:AddSeperator(titleText)
				local SepFrame = Instance.new("Frame")
				SepFrame.Name = "Separator"
				SepFrame.Parent = ControlsContainer
				SepFrame.BackgroundTransparency = 1
				SepFrame.Size = UDim2.new(1, 0, 0, (titleText and titleText ~= "") and 22 or 8)

				if titleText and titleText ~= "" then
					local SepLabel = Instance.new("TextLabel")
					SepLabel.Parent = SepFrame
					SepLabel.BackgroundTransparency = 1
					SepLabel.Position = UDim2.new(0, 4, 0, 0)
					SepLabel.Size = UDim2.new(1, -8, 1, 0)
					SepLabel.Font = Enum.Font.GothamBold
					SepLabel.Text = string.upper(tostring(titleText))
					SepLabel.TextColor3 = Theme.AccentGlow
					SepLabel.TextSize = 10
					SepLabel.TextXAlignment = Enum.TextXAlignment.Left
				else
					local Line = Instance.new("Frame")
					Line.Parent = SepFrame
					Line.AnchorPoint = Vector2.new(0, 0.5)
					Line.Position = UDim2.new(0, 0, 0.5, 0)
					Line.Size = UDim2.new(1, 0, 0, 1)
					Line.BackgroundColor3 = Theme.BorderSoft
					Line.BorderSizePixel = 0
				end

				table.insert(secData.Elements, { Title = titleText or "Separator", Frame = SepFrame })
			end

			-- 12.9 KEYBIND SELECTOR (Standalone)
			function SecObj:AddKeybind(keybindConfig)
				local cfg = Library:MakeConfig({
					Title = "Keybind",
					Default = Enum.KeyCode.RightShift,
					Callback = function() end
				}, keybindConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "Keybind_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 36)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, 0)
				TitleLabel.Size = UDim2.new(1, -100, 1, 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local KeyBadge = Instance.new("TextButton")
				KeyBadge.Parent = ItemFrame
				KeyBadge.AnchorPoint = Vector2.new(1, 0.5)
				KeyBadge.Position = UDim2.new(1, -10, 0.5, 0)
				KeyBadge.Size = UDim2.new(0, 65, 0, 22)
				KeyBadge.BackgroundColor3 = Theme.SurfaceActive
				KeyBadge.BorderSizePixel = 0
				KeyBadge.Font = Enum.Font.GothamBold
				KeyBadge.Text = cfg.Default and cfg.Default.Name or "None"
				KeyBadge.TextColor3 = Theme.TextSecondary
				KeyBadge.TextSize = 11

				local BadgeCorner = Instance.new("UICorner")
				BadgeCorner.CornerRadius = UDim.new(0, 5)
				BadgeCorner.Parent = KeyBadge

				local BadgeStroke = Instance.new("UIStroke")
				BadgeStroke.Color = Theme.BorderSoft
				BadgeStroke.Thickness = 1
				BadgeStroke.Parent = KeyBadge

				local listening = false
				KeyBadge.MouseButton1Click:Connect(function()
					if listening then return end
					listening = true
					KeyBadge.Text = "..."
					TweenService:Create(BadgeStroke, TweenInfoFast, { Color = Theme.Accent }):Play()

					local conn
					conn = UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.Keyboard then
							listening = false
							KeyBadge.Text = input.KeyCode.Name
							TweenService:Create(BadgeStroke, TweenInfoFast, { Color = Theme.BorderSoft }):Play()
							conn:Disconnect()
							pcall(cfg.Callback, input.KeyCode)
						end
					end)
				end)

				local Controller = {
					Set = function(self, newKey)
						KeyBadge.Text = newKey and newKey.Name or "None"
						pcall(cfg.Callback, newKey)
					end,
					Get = function(self)
						return cfg.Default
					end
				}
				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame, Controller = Controller })
				return Controller
			end

			-- 12.11 COLOR PICKER
			function SecObj:AddColorPicker(cpConfig)
				local cfg = Library:MakeConfig({
					Title = "Color",
					Description = "",
					Default = Color3.fromRGB(168, 85, 247),
					Callback = function() end
				}, cpConfig or {})

				if cfg.Desc and cfg.Description == "" then cfg.Description = cfg.Desc end
				local currentColor = cfg.Default or Color3.fromRGB(168, 85, 247)

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "ColorPicker_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, (cfg.Description ~= "") and 44 or 36)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, (cfg.Description ~= "") and 5 or 0)
				TitleLabel.Size = UDim2.new(1, -90, (cfg.Description ~= "") and 0 or 1, (cfg.Description ~= "") and 16 or 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				if cfg.Description ~= "" then
					local DescLabel = Instance.new("TextLabel")
					DescLabel.Name = "Desc"
					DescLabel.Parent = ItemFrame
					DescLabel.BackgroundTransparency = 1
					DescLabel.Position = UDim2.new(0, 10, 0, 22)
					DescLabel.Size = UDim2.new(1, -90, 0, 16)
					DescLabel.Font = Enum.Font.Gotham
					DescLabel.Text = cfg.Description
					DescLabel.TextColor3 = Theme.TextMuted
					DescLabel.TextSize = 10
					DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				end

				local ColorTile = Instance.new("TextButton")
				ColorTile.Name = "ColorTile"
				ColorTile.Parent = ItemFrame
				ColorTile.AnchorPoint = Vector2.new(1, 0.5)
				ColorTile.Position = UDim2.new(1, -10, 0.5, 0)
				ColorTile.Size = UDim2.new(0, 48, 0, 22)
				ColorTile.BackgroundColor3 = currentColor
				ColorTile.BorderSizePixel = 0
				ColorTile.AutoButtonColor = false
				ColorTile.Text = ""

				local TileCorner = Instance.new("UICorner")
				TileCorner.CornerRadius = UDim.new(0, 5)
				TileCorner.Parent = ColorTile

				local TileStroke = Instance.new("UIStroke")
				TileStroke.Color = Color3.fromRGB(255, 255, 255)
				TileStroke.Thickness = 1
				TileStroke.Transparency = 0.5
				TileStroke.Parent = ColorTile

				local Presets = {
					Color3.fromRGB(168, 85, 247),
					Color3.fromRGB(59, 130, 246),
					Color3.fromRGB(74, 222, 128),
					Color3.fromRGB(251, 191, 36),
					Color3.fromRGB(248, 113, 113),
					Color3.fromRGB(236, 72, 153),
					Color3.fromRGB(45, 212, 191),
					Color3.fromRGB(255, 255, 255),
				}
				local pIdx = 1

				local function SetColor(c)
					currentColor = c
					ColorTile.BackgroundColor3 = c
					pcall(cfg.Callback, c)
				end

				ColorTile.MouseButton1Click:Connect(function()
					pIdx = (pIdx % #Presets) + 1
					SetColor(Presets[pIdx])
				end)

				local Controller = {
					Set = function(self, newColor)
						if typeof(newColor) == "Color3" then
							SetColor(newColor)
						end
					end,
					Get = function(self)
						return currentColor
					end
				}

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame, Controller = Controller })
				return Controller
			end

			-- 12.10 PROGRESS BAR
			function SecObj:AddProgressBar(pbConfig)
				local cfg = Library:MakeConfig({
					Title = "Progress",
					Default = 0,
					Max = 100
				}, pbConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "ProgressBar_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 44)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 7)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Parent = ItemFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, 6)
				TitleLabel.Size = UDim2.new(1, -70, 0, 16)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local PercentLabel = Instance.new("TextLabel")
				PercentLabel.Parent = ItemFrame
				PercentLabel.AnchorPoint = Vector2.new(1, 0)
				PercentLabel.Position = UDim2.new(1, -10, 0, 6)
				PercentLabel.Size = UDim2.new(0, 50, 0, 16)
				PercentLabel.BackgroundTransparency = 1
				PercentLabel.Font = Enum.Font.GothamBold
				PercentLabel.Text = tostring(cfg.Default) .. "%"
				PercentLabel.TextColor3 = Theme.AccentGlow
				PercentLabel.TextSize = 11
				PercentLabel.TextXAlignment = Enum.TextXAlignment.Right

				local Rail = Instance.new("Frame")
				Rail.Parent = ItemFrame
				Rail.Position = UDim2.new(0, 10, 0, 26)
				Rail.Size = UDim2.new(1, -20, 0, 6)
				Rail.BackgroundColor3 = Theme.SurfaceActive
				Rail.BorderSizePixel = 0

				local RailCorner = Instance.new("UICorner")
				RailCorner.CornerRadius = UDim.new(1, 0)
				RailCorner.Parent = Rail

				local Fill = Instance.new("Frame")
				Fill.Parent = Rail
				Fill.BackgroundColor3 = Theme.Accent
				Fill.BorderSizePixel = 0
				Fill.Size = UDim2.fromScale(math.clamp(cfg.Default / cfg.Max, 0, 1), 1)

				local FillCorner = Instance.new("UICorner")
				FillCorner.CornerRadius = UDim.new(1, 0)
				FillCorner.Parent = Fill

				local PBObj = { Value = cfg.Default }
				function PBObj:Set(newVal, newMax)
					local max = newMax or cfg.Max
					newVal = math.clamp(newVal, 0, max)
					self.Value = newVal
					local pct = math.floor((newVal / max) * 100)
					PercentLabel.Text = tostring(pct) .. "%"
					TweenService:Create(Fill, TweenInfoFast, { Size = UDim2.fromScale(newVal / max, 1) }):Play()
				end

				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
				return PBObj
			end

			-- 12.11 SEARCHABLE PLAYER SELECTION LIST
			function SecObj:AddPlayerList(plConfig)
				local cfg = Library:MakeConfig({
					Title = "Player Selection",
					Multi = true,
					Callback = function() end
				}, plConfig or {})

				local ItemFrame = Instance.new("Frame")
				ItemFrame.Name = "PlayerList_" .. cfg.Title
				ItemFrame.Parent = ControlsContainer
				ItemFrame.BackgroundColor3 = Theme.SurfaceHover
				ItemFrame.BackgroundTransparency = 0.55
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 190)

				local ItemCorner = Instance.new("UICorner")
				ItemCorner.CornerRadius = UDim.new(0, 8)
				ItemCorner.Parent = ItemFrame

				local ItemStroke = Instance.new("UIStroke")
				ItemStroke.Color = Theme.BorderSoft
				ItemStroke.Thickness = 1
				ItemStroke.Transparency = 0.4
				ItemStroke.Parent = ItemFrame

				local TopFrame = Instance.new("Frame")
				TopFrame.Parent = ItemFrame
				TopFrame.BackgroundTransparency = 1
				TopFrame.Size = UDim2.new(1, 0, 0, 30)

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Parent = TopFrame
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Position = UDim2.new(0, 10, 0, 0)
				TitleLabel.Size = UDim2.new(0.5, -10, 1, 0)
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.Text = cfg.Title
				TitleLabel.TextColor3 = Theme.Text
				TitleLabel.TextSize = 12
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

				local StatusCount = Instance.new("TextLabel")
				StatusCount.Parent = TopFrame
				StatusCount.AnchorPoint = Vector2.new(1, 0)
				StatusCount.Position = UDim2.new(1, -10, 0, 0)
				StatusCount.Size = UDim2.new(0.5, -10, 1, 0)
				StatusCount.BackgroundTransparency = 1
				StatusCount.Font = Enum.Font.Gotham
				StatusCount.Text = "0 selected"
				StatusCount.TextColor3 = Theme.AccentGlow
				StatusCount.TextSize = 10
				StatusCount.TextXAlignment = Enum.TextXAlignment.Right

				local BtnRow = Instance.new("Frame")
				BtnRow.Parent = ItemFrame
				BtnRow.BackgroundTransparency = 1
				BtnRow.Position = UDim2.new(0, 10, 0, 30)
				BtnRow.Size = UDim2.new(1, -20, 0, 24)

				local SelectAllBtn = Instance.new("TextButton")
				SelectAllBtn.Parent = BtnRow
				SelectAllBtn.Size = UDim2.new(0.48, 0, 1, 0)
				SelectAllBtn.BackgroundColor3 = Theme.SurfaceActive
				SelectAllBtn.Font = Enum.Font.GothamBold
				SelectAllBtn.Text = "Select All"
				SelectAllBtn.TextColor3 = Theme.Text
				SelectAllBtn.TextSize = 10
				SelectAllBtn.BorderSizePixel = 0

				local SABCorner = Instance.new("UICorner")
				SABCorner.CornerRadius = UDim.new(0, 5)
				SABCorner.Parent = SelectAllBtn

				local DeselectAllBtn = Instance.new("TextButton")
				DeselectAllBtn.Parent = BtnRow
				DeselectAllBtn.Position = UDim2.new(0.52, 0, 0, 0)
				DeselectAllBtn.Size = UDim2.new(0.48, 0, 1, 0)
				DeselectAllBtn.BackgroundColor3 = Theme.SurfaceActive
				DeselectAllBtn.Font = Enum.Font.GothamBold
				DeselectAllBtn.Text = "Deselect All"
				DeselectAllBtn.TextColor3 = Theme.TextMuted
				DeselectAllBtn.TextSize = 10
				DeselectAllBtn.BorderSizePixel = 0

				local DABCorner = Instance.new("UICorner")
				DABCorner.CornerRadius = UDim.new(0, 5)
				DABCorner.Parent = DeselectAllBtn

				local PlSearch = Instance.new("TextBox")
				PlSearch.Parent = ItemFrame
				PlSearch.Position = UDim2.new(0, 10, 0, 58)
				PlSearch.Size = UDim2.new(1, -20, 0, 22)
				PlSearch.BackgroundColor3 = Theme.Header
				PlSearch.BorderSizePixel = 0
				PlSearch.Font = Enum.Font.Gotham
				PlSearch.PlaceholderColor3 = Theme.TextMuted
				PlSearch.PlaceholderText = "Filter players..."
				PlSearch.Text = ""
				PlSearch.TextColor3 = Theme.Text
				PlSearch.TextSize = 10

				local PSCorner = Instance.new("UICorner")
				PSCorner.CornerRadius = UDim.new(0, 5)
				PSCorner.Parent = PlSearch

				local PlScroll = Instance.new("ScrollingFrame")
				PlScroll.Parent = ItemFrame
				PlScroll.BackgroundTransparency = 1
				PlScroll.Position = UDim2.new(0, 10, 0, 84)
				PlScroll.Size = UDim2.new(1, -20, 0, 98)
				PlScroll.BorderSizePixel = 0
				PlScroll.ScrollBarThickness = 2
				PlScroll.ScrollBarImageColor3 = Theme.Border

				local PlLayout = Instance.new("UIListLayout")
				PlLayout.Parent = PlScroll
				PlLayout.SortOrder = Enum.SortOrder.LayoutOrder
				PlLayout.Padding = UDim.new(0, 3)

				Library:UpdateScrolling(PlScroll, PlLayout)

				local selectedPlayers = {}
				local renderedItems = {}

				local function UpdateCount()
					local c = 0
					for _ in pairs(selectedPlayers) do c = c + 1 end
					StatusCount.Text = tostring(c) .. " selected"
				end

				local function RefreshPlayers()
					for _, item in ipairs(renderedItems) do item:Destroy() end
					renderedItems = {}

					local query = string.lower(PlSearch.Text or "")
					for _, plr in ipairs(Players:GetPlayers()) do
						if plr ~= LocalPlayer then
							local pName = plr.Name
							if query == "" or string.find(string.lower(pName), query) then
								local isSel = selectedPlayers[pName] ~= nil

								local row = Instance.new("TextButton")
								row.Name = "Row_" .. pName
								row.Parent = PlScroll
								row.BackgroundColor3 = isSel and Theme.SurfaceActive or Theme.Header
								row.BorderSizePixel = 0
								row.Size = UDim2.new(1, 0, 0, 24)
								row.AutoButtonColor = false
								row.Text = ""

								local rCorner = Instance.new("UICorner")
								rCorner.CornerRadius = UDim.new(0, 5)
								rCorner.Parent = row

								local check = Instance.new("TextLabel")
								check.Parent = row
								check.Position = UDim2.new(0, 6, 0, 0)
								check.Size = UDim2.new(0, 16, 1, 0)
								check.BackgroundTransparency = 1
								check.Font = Enum.Font.GothamBold
								check.Text = isSel and "✓" or "○"
								check.TextColor3 = isSel and Theme.Success or Theme.TextMuted
								check.TextSize = 11

								local nameLbl = Instance.new("TextLabel")
								nameLbl.Parent = row
								nameLbl.Position = UDim2.new(0, 24, 0, 0)
								nameLbl.Size = UDim2.new(1, -28, 1, 0)
								nameLbl.BackgroundTransparency = 1
								nameLbl.Font = Enum.Font.Gotham
								nameLbl.Text = pName
								nameLbl.TextColor3 = isSel and Theme.Text or Theme.TextSecondary
								nameLbl.TextSize = 10
								nameLbl.TextXAlignment = Enum.TextXAlignment.Left

								row.MouseButton1Click:Connect(function()
									if selectedPlayers[pName] then
										selectedPlayers[pName] = nil
									else
										selectedPlayers[pName] = plr
									end
									UpdateCount()
									RefreshPlayers()
									pcall(cfg.Callback, selectedPlayers)
								end)

								table.insert(renderedItems, row)
							end
						end
					end
				end

				SelectAllBtn.MouseButton1Click:Connect(function()
					for _, plr in ipairs(Players:GetPlayers()) do
						if plr ~= LocalPlayer then selectedPlayers[plr.Name] = plr end
					end
					UpdateCount()
					RefreshPlayers()
					pcall(cfg.Callback, selectedPlayers)
				end)

				DeselectAllBtn.MouseButton1Click:Connect(function()
					selectedPlayers = {}
					UpdateCount()
					RefreshPlayers()
					pcall(cfg.Callback, selectedPlayers)
				end)

				PlSearch:GetPropertyChangedSignal("Text"):Connect(RefreshPlayers)
				Players.PlayerAdded:Connect(RefreshPlayers)
				Players.PlayerRemoving:Connect(function(plr)
					selectedPlayers[plr.Name] = nil
					UpdateCount()
					RefreshPlayers()
				end)

				task.defer(RefreshPlayers)
				table.insert(secData.Elements, { Title = cfg.Title, Frame = ItemFrame })
			end

			-- Aliases for section methods
			SecObj.Toggle = SecObj.AddToggle
			SecObj.Button = SecObj.AddButton
			SecObj.Paragraph = SecObj.AddParagraph
			SecObj.Graph = SecObj.AddGraph
			SecObj.SubToggle = SecObj.AddSubToggle
			SecObj.ToggleSlider = SecObj.AddToggleSlider
			SecObj.AddGraph = SecObj.AddGraph
			SecObj.DiscordCard = SecObj.AddDiscordCard
			SecObj.CommunityCard = SecObj.AddDiscordCard
			SecObj.AddCommunityCard = SecObj.AddDiscordCard
			SecObj.Slider = SecObj.AddSlider
			SecObj.Dropdown = SecObj.AddDropdown
			SecObj.Input = SecObj.AddInput
			SecObj.Separator = SecObj.AddSeperator
			SecObj.AddSeparator = SecObj.AddSeperator
			SecObj.Divider = SecObj.AddSeperator
			SecObj.AddDivider = SecObj.AddSeperator
			SecObj.Keybind = SecObj.AddKeybind
			SecObj.ProgressBar = SecObj.AddProgressBar
			SecObj.PlayerList = SecObj.AddPlayerList
			SecObj.ColorPicker = SecObj.AddColorPicker
			SecObj.AddTextInput = SecObj.AddInput
			SecObj.TextInput = SecObj.AddInput

-- =========================================================================
-- SPECIALIZED UI EXTENSIONS FOR PINATHUB VIOLENCE DISTRICT (from otherscript.lua)
-- =========================================================================

-- 1. Custom Background Manager
function SecObj:AddCustomBgManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Custom Background Manager",
        DefaultAsset = "",
        DefaultOverlay = 40,
        DefaultScale = "Crop",
        Callback = function() end
    }, cfg or {})

    local container = Instance.new("Frame")
    container.Name = "CustomBgContainer"
    container.Parent = ControlsContainer
    container.BackgroundColor3 = Theme.BackgroundDark
    container.BackgroundTransparency = 0.5
    container.Size = UDim2.new(1, 0, 0, 110)
    container.BorderSizePixel = 0

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = container

    local cStroke = Instance.new("UIStroke")
    cStroke.Color = Theme.BorderSoft
    cStroke.Thickness = 1
    cStroke.Parent = container

    local preview = Instance.new("ImageLabel")
    preview.Name = "BgPreview"
    preview.Parent = container
    preview.Position = UDim2.new(0, 8, 0, 8)
    preview.Size = UDim2.new(0, 94, 0, 94)
    preview.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    preview.BorderSizePixel = 0
    preview.ScaleType = Enum.ScaleType[cfg.DefaultScale] or Enum.ScaleType.Crop
    preview.Image = cfg.DefaultAsset ~= "" and cfg.DefaultAsset or "rbxassetid://118264723961739"
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 4)
    prevCorner.Parent = preview

    local assetBox = Instance.new("TextBox")
    assetBox.Name = "AssetInput"
    assetBox.Parent = container
    assetBox.Position = UDim2.new(0, 110, 0, 12)
    assetBox.Size = UDim2.new(1, -118, 0, 28)
    assetBox.BackgroundColor3 = Theme.Surface
    assetBox.TextColor3 = Theme.TextPrimary
    assetBox.PlaceholderText = "Roblox Asset ID (rbxassetid://...)"
    assetBox.PlaceholderColor3 = Theme.TextMuted
    assetBox.Font = Enum.Font.Gotham
    assetBox.TextSize = 11
    assetBox.Text = cfg.DefaultAsset
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = assetBox

    local applyBtn = Instance.new("TextButton")
    applyBtn.Name = "ApplyBg"
    applyBtn.Parent = container
    applyBtn.Position = UDim2.new(0, 110, 0, 48)
    applyBtn.Size = UDim2.new(1, -118, 0, 26)
    applyBtn.BackgroundColor3 = Theme.Accent
    applyBtn.TextColor3 = Color3.new(1, 1, 1)
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.TextSize = 11
    applyBtn.Text = "Apply Background"
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = applyBtn

    local statusLbl = Instance.new("TextLabel")
    statusLbl.Name = "StatusLbl"
    statusLbl.Parent = container
    statusLbl.Position = UDim2.new(0, 110, 0, 80)
    statusLbl.Size = UDim2.new(1, -118, 0, 18)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Font = Enum.Font.Gotham
    statusLbl.TextSize = 10
    statusLbl.TextColor3 = Theme.TextSecondary
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.Text = "Scale: " .. tostring(cfg.DefaultScale) .. " | Overlay: " .. tostring(cfg.DefaultOverlay) .. "%"

    applyBtn.MouseButton1Click:Connect(function()
        local raw = assetBox.Text:gsub("%s+", "")
        local id = raw
        if raw:match("^%d+$") then
            id = "rbxassetid://" .. raw
        end
        preview.Image = id
        statusLbl.Text = "Background Updated!"
        cfg.Callback({ AssetId = id, Overlay = cfg.DefaultOverlay, ScaleType = cfg.DefaultScale })
    end)

    table.insert(secData.Elements, { Title = cfg.Title, Frame = container })
    return {
        SetAsset = function(_, asset) assetBox.Text = asset; preview.Image = asset end,
        SetStatus = function(_, txt) statusLbl.Text = txt end
    }
end

-- 2. Custom Emote Wheel Manager (8-slot wheel)
function SecObj:AddEmoteWheelManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Emote Wheel Manager",
        Slots = { "KWIK FLIP", "Schadenfreude (laugh)", "Wave", "Pop off", "Backflip", "Griddy", "The Dab", "California girls" },
        Callback = function() end
    }, cfg or {})

    local container = Instance.new("Frame")
    container.Name = "EmoteWheelContainer"
    container.Parent = ControlsContainer
    container.BackgroundColor3 = Theme.BackgroundDark
    container.BackgroundTransparency = 0.5
    container.Size = UDim2.new(1, 0, 0, 140)
    container.BorderSizePixel = 0

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = container

    local title = Instance.new("TextLabel")
    title.Parent = container
    title.Position = UDim2.new(0, 8, 0, 4)
    title.Size = UDim2.new(1, -16, 0, 20)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextColor3 = Theme.AccentGlow
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "EMOTE WHEEL SLOTS (8 SLOTS)"

    local grid = Instance.new("Frame")
    grid.Parent = container
    grid.Position = UDim2.new(0, 8, 0, 26)
    grid.Size = UDim2.new(1, -16, 0, 80)
    grid.BackgroundTransparency = 1

    local uigrid = Instance.new("UIGridLayout")
    uigrid.Parent = grid
    uigrid.CellSize = UDim2.new(0.23, 0, 0, 36)
    uigrid.CellPadding = UDim2.new(0.02, 0, 0, 4)

    local slotButtons = {}
    for i = 1, 8 do
        local slotName = cfg.Slots[i] or ("Slot " .. i)
        local btn = Instance.new("TextButton")
        btn.Name = "Slot_" .. i
        btn.Parent = grid
        btn.BackgroundColor3 = Theme.Surface
        btn.TextColor3 = Theme.TextPrimary
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 10
        btn.Text = tostring(i) .. ". " .. slotName:sub(1, 10)
        btn.ClipsDescendants = true
        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 4)
        bCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            cfg.Callback({ Slot = i, Name = slotName })
        end)
        slotButtons[i] = btn
    end

    local actionRow = Instance.new("Frame")
    actionRow.Parent = container
    actionRow.Position = UDim2.new(0, 8, 0, 110)
    actionRow.Size = UDim2.new(1, -16, 0, 24)
    actionRow.BackgroundTransparency = 1

    local openWheelBtn = Instance.new("TextButton")
    openWheelBtn.Parent = actionRow
    openWheelBtn.Size = UDim2.new(0.48, 0, 1, 0)
    openWheelBtn.BackgroundColor3 = Theme.Accent
    openWheelBtn.TextColor3 = Color3.new(1, 1, 1)
    openWheelBtn.Font = Enum.Font.GothamBold
    openWheelBtn.TextSize = 10
    openWheelBtn.Text = "Open Emote Wheel"
    local oCorner = Instance.new("UICorner")
    oCorner.CornerRadius = UDim.new(0, 4)
    oCorner.Parent = openWheelBtn

    local stopAnimBtn = Instance.new("TextButton")
    stopAnimBtn.Parent = actionRow
    stopAnimBtn.Position = UDim2.new(0.52, 0, 0, 0)
    stopAnimBtn.Size = UDim2.new(0.48, 0, 1, 0)
    stopAnimBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    stopAnimBtn.TextColor3 = Color3.new(1, 1, 1)
    stopAnimBtn.Font = Enum.Font.GothamBold
    stopAnimBtn.TextSize = 10
    stopAnimBtn.Text = "Stop Animation"
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 4)
    sCorner.Parent = stopAnimBtn

    table.insert(secData.Elements, { Title = cfg.Title, Frame = container })
    return {
        OnOpenWheel = function(_, cb) openWheelBtn.MouseButton1Click:Connect(cb) end,
        OnStopAnim = function(_, cb) stopAnimBtn.MouseButton1Click:Connect(cb) end
    }
end

-- 3. Perk Loadout Manager (3 slots + Loadout Selector)
function SecObj:AddPerkLoadoutManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Survivor Perk Loadout",
        Perk1 = "None",
        Perk2 = "None",
        Perk3 = "None",
        Callback = function() end
    }, cfg or {})

    local container = Instance.new("Frame")
    container.Name = "PerkLoadoutContainer"
    container.Parent = ControlsContainer
    container.BackgroundColor3 = Theme.BackgroundDark
    container.BackgroundTransparency = 0.5
    container.Size = UDim2.new(1, 0, 0, 80)
    container.BorderSizePixel = 0

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = container

    local title = Instance.new("TextLabel")
    title.Parent = container
    title.Position = UDim2.new(0, 8, 0, 4)
    title.Size = UDim2.new(1, -16, 0, 18)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextColor3 = Theme.AccentGlow
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "PERK SLOTS (SURVIVOR PERKS)"

    local row = Instance.new("Frame")
    row.Parent = container
    row.Position = UDim2.new(0, 8, 0, 26)
    row.Size = UDim2.new(1, -16, 0, 48)
    row.BackgroundTransparency = 1

    local pButtons = {}
    for i = 1, 3 do
        local pBtn = Instance.new("TextButton")
        pBtn.Name = "PerkSlot_" .. i
        pBtn.Parent = row
        pBtn.Position = UDim2.new((i - 1) * 0.34, 0, 0, 0)
        pBtn.Size = UDim2.new(0.31, 0, 0, 42)
        pBtn.BackgroundColor3 = Theme.Surface
        pBtn.TextColor3 = Theme.TextPrimary
        pBtn.Font = Enum.Font.GothamMedium
        pBtn.TextSize = 10
        pBtn.Text = "Slot " .. i .. "\n" .. (i == 1 and cfg.Perk1 or (i == 2 and cfg.Perk2 or cfg.Perk3))
        local pbCorner = Instance.new("UICorner")
        pbCorner.CornerRadius = UDim.new(0, 4)
        pbCorner.Parent = pBtn
        pButtons[i] = pBtn
    end

    table.insert(secData.Elements, { Title = cfg.Title, Frame = container })
    return {
        SetPerks = function(_, p1, p2, p3)
            pButtons[1].Text = "Slot 1\n" .. tostring(p1)
            pButtons[2].Text = "Slot 2\n" .. tostring(p2)
            pButtons[3].Text = "Slot 3\n" .. tostring(p3)
        end
    }
end

-- 4. Visual Preset Manager (Ambient Color & Lighting Preset)
function SecObj:AddVisualPresetManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Lighting Visual Presets",
        Presets = { "Default", "Cinematic", "Vibrant", "Grim Noir", "Cyberpunk", "Midnight" },
        CurrentPreset = "Default",
        Callback = function() end
    }, cfg or {})

    local container = Instance.new("Frame")
    container.Name = "VisualPresetContainer"
    container.Parent = ControlsContainer
    container.BackgroundColor3 = Theme.BackgroundDark
    container.BackgroundTransparency = 0.5
    container.Size = UDim2.new(1, 0, 0, 72)
    container.BorderSizePixel = 0

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = container

    local title = Instance.new("TextLabel")
    title.Parent = container
    title.Position = UDim2.new(0, 8, 0, 4)
    title.Size = UDim2.new(1, -16, 0, 18)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextColor3 = Theme.AccentGlow
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "LIGHTING & COLOR PRESET CONTROLLER"

    local grid = Instance.new("Frame")
    grid.Parent = container
    grid.Position = UDim2.new(0, 8, 0, 26)
    grid.Size = UDim2.new(1, -16, 0, 40)
    grid.BackgroundTransparency = 1

    local layout = Instance.new("UIGridLayout")
    layout.Parent = grid
    layout.CellSize = UDim2.new(0.31, 0, 0, 18)
    layout.CellPadding = UDim2.new(0.02, 0, 0, 3)

    for _, presetName in ipairs(cfg.Presets) do
        local btn = Instance.new("TextButton")
        btn.Name = "Preset_" .. presetName
        btn.Parent = grid
        btn.BackgroundColor3 = (presetName == cfg.CurrentPreset) and Theme.Accent or Theme.Surface
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 9
        btn.Text = presetName
        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 4)
        bCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            for _, child in ipairs(grid:GetChildren()) do
                if child:IsA("TextButton") then child.BackgroundColor3 = Theme.Surface end
            end
            btn.BackgroundColor3 = Theme.Accent
            cfg.Callback(presetName)
        end)
    end

    table.insert(secData.Elements, { Title = cfg.Title, Frame = container })
    return {}
end

-- 5. Fog Manager (Color + Fog Start & End)
function SecObj:AddFogManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Custom Fog Controller",
        Callback = function() end
    }, cfg or {})
    return self:AddParagraph({ Title = "Fog Controller", Desc = "Managed dynamically via Lighting settings below." })
end

-- 6. Bloom Manager (Intensity, Size, Threshold)
function SecObj:AddBloomManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Bloom Controller",
        Callback = function() end
    }, cfg or {})
    return self:AddParagraph({ Title = "Bloom Controller", Desc = "Adjust bloom parameters in real-time." })
end

-- 7. Info Banner Configurator
function SecObj:AddInfoBannerConfig(cfg)
    cfg = Library:MakeConfig({
        Title = "Info Banner Configuration",
        Callback = function() end
    }, cfg or {})
    return self:AddParagraph({ Title = "Info Banner", Desc = "HUD display: Map, Killer, Perks, FPS, Ping." })
end

-- 8. Aimbot Preview with Calibration Canvas
function SecObj:AddAimbotPreview(cfg)
    cfg = Library:MakeConfig({
        Title = "Aimbot Calibration & FOV Preview",
        DefaultRadius = 150,
        Callback = function() end
    }, cfg or {})

    local container = Instance.new("Frame")
    container.Name = "AimbotPreviewContainer"
    container.Parent = ControlsContainer
    container.BackgroundColor3 = Theme.BackgroundDark
    container.BackgroundTransparency = 0.5
    container.Size = UDim2.new(1, 0, 0, 90)
    container.BorderSizePixel = 0

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = container

    local title = Instance.new("TextLabel")
    title.Parent = container
    title.Position = UDim2.new(0, 8, 0, 4)
    title.Size = UDim2.new(1, -16, 0, 18)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextColor3 = Theme.AccentGlow
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "AIMBOT TARGET RETICLE & FOV PREVIEW"

    local canvas = Instance.new("Frame")
    canvas.Parent = container
    canvas.Position = UDim2.new(0, 8, 0, 24)
    canvas.Size = UDim2.new(0, 60, 0, 60)
    canvas.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    local canCorner = Instance.new("UICorner")
    canCorner.CornerRadius = UDim.new(1, 0)
    canCorner.Parent = canvas
    local canStroke = Instance.new("UIStroke")
    canStroke.Color = Theme.Accent
    canStroke.Thickness = 1.5
    canStroke.Parent = canvas

    local centerDot = Instance.new("Frame")
    centerDot.Parent = canvas
    centerDot.AnchorPoint = Vector2.new(0.5, 0.5)
    centerDot.Position = UDim2.new(0.5, 0, 0.5, 0)
    centerDot.Size = UDim2.new(0, 4, 0, 4)
    centerDot.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = centerDot

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Parent = container
    infoLabel.Position = UDim2.new(0, 80, 0, 28)
    infoLabel.Size = UDim2.new(1, -88, 0, 48)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 11
    infoLabel.TextColor3 = Theme.TextSecondary
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top
    infoLabel.Text = "FOV Circle active on screen.\nHorizontal / Vertical offsets calibrated dynamically for ballistics."

    table.insert(secData.Elements, { Title = cfg.Title, Frame = container })
    return {}
end

-- 9. Stalker Killer Manager
function SecObj:AddStalkerManager(cfg)
    cfg = Library:MakeConfig({
        Title = "Stalker Ability Suite",
        Callback = function() end
    }, cfg or {})
    return self:AddParagraph({ Title = "Stalker Suite", Desc = "Controls for Stalker killer abilities (cooldown bypass, grab, corrupt)." })
end


			return SecObj
		end

		TabObj.Section = TabObj.AddSection
		return TabObj
	end

	-- Compatibility stubs for pinathubforintregation.lua (WindUI v2 API)
	function Window:CreateTopbarButton(...) end
	function Window:EditOpenButton(...) end
	function Window:AddTab(...)
		return self:T(...)
	end
	function Window:Minimize()
		CloseWindow()
	end
	function Window:SelectTab(idx)
		if TabsCollection[idx] and TabsCollection[idx].SelectFn then
			TabsCollection[idx].SelectFn()
		end
	end

	Window.AddTab = Window.T
	Window.AddTab = Window.T
	Window.Tab = Window.T
	Window.NewTab = Window.T
	Window.CreateWindow = Window.NewWindow
	Library.CurrentWindow = Window

	return Window
end

Library.CreateWindow = Library.NewWindow
function Library:SetTheme(...) end
function Library:AddTheme(...) end
function Library:SetNotificationLower(...) end

return Library
