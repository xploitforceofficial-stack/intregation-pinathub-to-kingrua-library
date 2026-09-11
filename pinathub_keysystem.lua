-- =============================================================================
-- PINATHUB KEY SYSTEM & AUTHENTICATION GATEWAY
-- Next-Gen Compact Glassmorphism & Cyber-Obsidian Edition (100% Real Decal Icons)
-- Powered by Jnkie
--
-- Official Website : https://pinathub.my.id/
-- Get Key Link     : https://jnkie.com/get-key/pinathub
-- Discord Invite   : https://discord.gg/Y6Kjfu5XPN
-- TikTok Profile   : https://www.tiktok.com/@viunze
-- PinatHub Logo    : rbxassetid://118264723961739
-- =============================================================================

local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local RunService         = game:GetService("RunService")
local HttpService        = game:GetService("HttpService")
local Players            = game:GetService("Players")
local LocalPlayer        = Players.LocalPlayer

-- -----------------------------------------------------------------------------
-- 1. BRANDING & ASSETS (Zero Emojis - 100% Authentic Roblox Decals)
-- -----------------------------------------------------------------------------
local Assets = {
    Logo         = "rbxassetid://118264723961739",
    Discord      = "rbxassetid://18505728250",
    TikTok       = "rbxassetid://114030178331137",
    Globe        = "rbxassetid://10723404337",
    Key          = "rbxassetid://10734920623",
    Lock         = "rbxassetid://10734920623",
    Clipboard    = "rbxassetid://10709783474",
    Clear        = "rbxassetid://10747384394",
    Check        = "rbxassetid://10709782497",
    Close        = "rbxassetid://10747384394",
    Shield       = "rbxassetid://10734951847",
    ChevronRight = "rbxassetid://10709791437",
    Info         = "rbxassetid://10723415903",
    Warning      = "rbxassetid://10709752906",
    Refresh      = "rbxassetid://10734940608"
}

-- -----------------------------------------------------------------------------
-- 2. THEME PALETTE: Deep Obsidian & Translucent Amethyst Glass
-- -----------------------------------------------------------------------------
local Theme = {
    GlassBackdrop     = Color3.fromRGB(10, 8, 16),
    GlassWindow       = Color3.fromRGB(14, 12, 22),
    GlassHeader       = Color3.fromRGB(20, 17, 32),
    GlassCard         = Color3.fromRGB(22, 19, 36),
    GlassSurface      = Color3.fromRGB(26, 22, 42),
    GlassSurfaceHover = Color3.fromRGB(36, 31, 58),
    GlassSurfaceActive= Color3.fromRGB(46, 39, 74),

    GlassBorder       = Color3.fromRGB(62, 54, 90),
    GlassBorderSoft   = Color3.fromRGB(44, 38, 64),
    GlassBorderGlow   = Color3.fromRGB(168, 85, 247),
    GlassSpecular     = Color3.fromRGB(255, 255, 255),

    Accent            = Color3.fromRGB(168, 85, 247),
    AccentGlow        = Color3.fromRGB(192, 132, 252),
    AccentDeep        = Color3.fromRGB(126, 34, 206),
    AccentPink        = Color3.fromRGB(217, 70, 239),

    TextPrimary       = Color3.fromRGB(250, 250, 255),
    TextSecondary     = Color3.fromRGB(175, 170, 195),
    TextMuted         = Color3.fromRGB(130, 125, 150),

    Success           = Color3.fromRGB(74, 222, 128),
    Warning           = Color3.fromRGB(251, 191, 36),
    Danger            = Color3.fromRGB(248, 113, 113),
    Info              = Color3.fromRGB(96, 165, 250)
}

local TweenInfoFast   = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfoSmooth = TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TweenInfoSpring = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- -----------------------------------------------------------------------------
-- 3. UTILITY FUNCTIONS
-- -----------------------------------------------------------------------------
local function GetSafeGuiParent()
    local success, parent = pcall(function()
        return game:GetService("CoreGui")
    end)
    if success and parent then return parent end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function SetClipboardText(str)
    local fn = setclipboard or toclipboard or (Clipboard and Clipboard.set) or (syn and syn.write_clipboard)
    if fn then pcall(fn, str) end
end

local function GetClipboardText()
    local fn = getclipboard or (Clipboard and Clipboard.get) or (syn and syn.read_clipboard)
    if fn then
        local ok, val = pcall(fn)
        if ok and type(val) == "string" then return val end
    end
    return nil
end

local function OpenURL(url)
    local fn = open_url or (syn and syn.open_url)
    if fn then pcall(fn, url) end
end

local function MakeDraggable(dragHandle, targetFrame)
    if not dragHandle or not targetFrame then return end
    dragHandle.Active = true
    local dragging = false
    local dragStart = nil
    local startPos = nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = targetFrame.Position
        end
    end)

    dragHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            targetFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function AddGlassSpecularHighlight(parentFrame, cornerRadius)
    local highlight = Instance.new("Frame")
    highlight.Name = "GlassSpecularHighlight"
    highlight.Parent = parentFrame
    highlight.Position = UDim2.new(0, 0, 0, 0)
    highlight.Size = UDim2.new(1, 0, 0, 1)
    highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    highlight.BackgroundTransparency = 0.6
    highlight.BorderSizePixel = 0
    highlight.ZIndex = 4

    local grad = Instance.new("UIGradient")
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.0, 1.0),
        NumberSequenceKeypoint.new(0.2, 0.45),
        NumberSequenceKeypoint.new(0.5, 0.25),
        NumberSequenceKeypoint.new(0.8, 0.45),
        NumberSequenceKeypoint.new(1.0, 1.0)
    })
    grad.Parent = highlight

    if cornerRadius then
        local c = Instance.new("UICorner")
        c.CornerRadius = cornerRadius
        c.Parent = highlight
    end
    return highlight
end

-- -----------------------------------------------------------------------------
-- 4. JUNKIE KEY SYSTEM CLIENT (v2 REST API & SDK)
-- -----------------------------------------------------------------------------
local JunkieService = {
    SDK = nil,
    Service = "pinathub",
    Identifier = "pinathub",
    Provider = "Mixed",
    GetKeyUrl = "https://jnkie.com/get-key/pinathub",
    WebsiteUrl = "https://pinathub.my.id/",
    DiscordUrl = "https://discord.gg/Y6Kjfu5XPN",
    TikTokUrl = "https://www.tiktok.com/@viunze",
    KeySaveFile = "PinatHub_Key.txt"
}

function JunkieService:InitSDK()
    if self.SDK then return self.SDK end
    local ok, res = pcall(function()
        local code = game:HttpGet("https://jnkie.com/sdk/library.lua")
        local fn = loadstring(code)
        if fn then
            local junkie = fn()
            junkie.service = self.Service
            junkie.identifier = self.Identifier
            junkie.provider = self.Provider
            return junkie
        end
    end)
    if ok and res then
        self.SDK = res
        return self.SDK
    end
    return nil
end

function JunkieService:GetKeyLink()
    local sdk = self:InitSDK()
    if sdk and type(sdk.get_key_link) == "function" then
        local ok, link = pcall(sdk.get_key_link)
        if ok and type(link) == "string" and #link > 0 then
            return link
        end
    end
    return self.GetKeyUrl
end

function JunkieService:ValidateKey(rawKey)
    local key = tostring(rawKey or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if #key == 0 then
        return false, "Please enter a key before verifying."
    end

    local sdk = self:InitSDK()
    if sdk and type(sdk.check_key) == "function" then
        local ok, result = pcall(function()
            return sdk.check_key(key)
        end)
        if ok and type(result) == "table" then
            if result.valid then
                return true, "Key validated successfully!"
            else
                local err = result.message or result.error or "Invalid key"
                if err == "KEY_EXPIRED" then
                    return false, "Key expired. Please obtain a new key."
                elseif err == "HWID_BANNED" then
                    return false, "Hardware ID is banned from this service."
                elseif err == "SERVICE_MISMATCH" then
                    return false, "Key is for a different service."
                elseif err == "HWID_MISMATCH" then
                    return false, "HWID limit reached. Please reset your HWID on Junkie."
                else
                    return false, "Invalid key: " .. tostring(err)
                end
            end
        end
    end

    -- Direct REST fallback if SDK is unavailable
    local req = (syn and syn.request) or (http and http.request) or request or http_request
    if req then
        local apiOk, apiRes = pcall(function()
            return req({
                Url = "https://api.jnkie.com/api/v2/keys?key=" .. HttpService:UrlEncode(key),
                Method = "GET",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["User-Agent"] = "PinatHub-KeySystem/2.0"
                }
            })
        end)
        if apiOk and apiRes and apiRes.StatusCode == 200 then
            local dataOk, data = pcall(function() return HttpService:JSONDecode(apiRes.Body) end)
            if dataOk and data and data.keys and #data.keys > 0 then
                local k = data.keys[1]
                if not k.is_invalidated and (not k.expires_at or k.expires_at > os.date("!%Y-%m-%dT%H:%M:%SZ")) then
                    return true, "Key validated successfully via API!"
                end
            end
        end
    end

    return false, "Verification failed or key is invalid. Please check your key."
end

function JunkieService:SaveKey(key)
    if writefile then
        pcall(writefile, self.KeySaveFile, tostring(key))
    end
end

function JunkieService:LoadSavedKey()
    if readfile and isfile and isfile(self.KeySaveFile) then
        local ok, content = pcall(readfile, self.KeySaveFile)
        if ok and type(content) == "string" then
            local trimmed = content:gsub("^%s+", ""):gsub("%s+$", "")
            if #trimmed > 0 then
                return trimmed
            end
        end
    end
    return nil
end

function JunkieService:ClearSavedKey()
    if delfile and isfile and isfile(self.KeySaveFile) then
        pcall(delfile, self.KeySaveFile)
    elseif writefile then
        pcall(writefile, self.KeySaveFile, "")
    end
end

-- -----------------------------------------------------------------------------
-- 5. COMPACT GLASSMORPHISM KEY SYSTEM UI
-- -----------------------------------------------------------------------------
local PinatKeySystem = {}
PinatKeySystem.__index = PinatKeySystem

function PinatKeySystem.Create(options)
    options = options or {}
    local self = setmetatable({}, PinatKeySystem)

    self.Service       = options.Service or JunkieService.Service
    self.GetKeyUrl     = options.GetKeyUrl or JunkieService.GetKeyUrl
    self.WebsiteUrl    = options.WebsiteUrl or JunkieService.WebsiteUrl
    self.DiscordUrl    = options.DiscordUrl or JunkieService.DiscordUrl
    self.TikTokUrl     = options.TikTokUrl or JunkieService.TikTokUrl
    self.Callback      = options.Callback or nil
    self.RememberKey   = true
    self.IsVerifying   = false

    JunkieService.Service   = self.Service
    JunkieService.GetKeyUrl = self.GetKeyUrl

    self:BuildUI()
    return self
end

function PinatKeySystem:Notify(title, message, notifType, duration)
    if not self.NotificationContainer then return end
    duration = duration or 3

    local color = Theme.Accent
    local iconAsset = Assets.Info
    if notifType == "Success" then
        color = Theme.Success
        iconAsset = Assets.Check
    elseif notifType == "Danger" or notifType == "Error" then
        color = Theme.Danger
        iconAsset = Assets.Warning
    elseif notifType == "Warning" then
        color = Theme.Warning
        iconAsset = Assets.Warning
    elseif notifType == "Info" then
        color = Theme.Info
        iconAsset = Assets.Info
    end

    local toast = Instance.new("Frame")
    toast.Name = "Toast"
    toast.Parent = self.NotificationContainer
    toast.Size = UDim2.new(1, 0, 0, 46)
    toast.BackgroundColor3 = Theme.GlassCard
    toast.BackgroundTransparency = 0.2
    toast.BorderSizePixel = 0
    toast.Position = UDim2.new(1, 30, 0, 0)
    toast.ClipsDescendants = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toast

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = toast

    AddGlassSpecularHighlight(toast, UDim.new(0, 8))

    local bar = Instance.new("Frame")
    bar.Parent = toast
    bar.Size = UDim2.new(0, 3, 1, -12)
    bar.Position = UDim2.new(0, 5, 0, 6)
    bar.BackgroundColor3 = color
    bar.BorderSizePixel = 0
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local icImg = Instance.new("ImageLabel")
    icImg.Parent = toast
    icImg.Position = UDim2.new(0, 14, 0, 15)
    icImg.Size = UDim2.new(0, 15, 0, 15)
    icImg.BackgroundTransparency = 1
    icImg.Image = iconAsset
    icImg.ImageColor3 = color
    icImg.ScaleType = Enum.ScaleType.Fit

    local tLbl = Instance.new("TextLabel")
    tLbl.Parent = toast
    tLbl.BackgroundTransparency = 1
    tLbl.Position = UDim2.new(0, 36, 0, 6)
    tLbl.Size = UDim2.new(1, -42, 0, 16)
    tLbl.Font = Enum.Font.GothamBold
    tLbl.Text = title
    tLbl.TextColor3 = Theme.TextPrimary
    tLbl.TextSize = 11
    tLbl.TextXAlignment = Enum.TextXAlignment.Left

    local mLbl = Instance.new("TextLabel")
    mLbl.Parent = toast
    mLbl.BackgroundTransparency = 1
    mLbl.Position = UDim2.new(0, 36, 0, 23)
    mLbl.Size = UDim2.new(1, -42, 0, 16)
    mLbl.Font = Enum.Font.Gotham
    mLbl.Text = message
    mLbl.TextColor3 = Theme.TextSecondary
    mLbl.TextSize = 9.5
    mLbl.TextXAlignment = Enum.TextXAlignment.Left
    mLbl.TextTruncate = Enum.TextTruncate.AtEnd

    TweenService:Create(toast, TweenInfoFast, { Position = UDim2.new(0, 0, 0, 0) }):Play()

    task.delay(duration, function()
        if toast and toast.Parent then
            local tw = TweenService:Create(toast, TweenInfoFast, {
                Position = UDim2.new(1, 30, 0, 0),
                BackgroundTransparency = 1
            })
            tw:Play()
            tw.Completed:Connect(function()
                toast:Destroy()
            end)
        end
    end)
end

function PinatKeySystem:SetStatus(text, statusType)
    if not self.StatusLabel or not self.StatusDot then return end
    self.StatusLabel.Text = text

    local color = Theme.TextSecondary
    if statusType == "Loading" then
        color = Theme.AccentGlow
    elseif statusType == "Success" then
        color = Theme.Success
    elseif statusType == "Error" then
        color = Theme.Danger
    elseif statusType == "Warning" then
        color = Theme.Warning
    elseif statusType == "Info" then
        color = Theme.Info
    end

    self.StatusDot.BackgroundColor3 = color
    self.StatusLabel.TextColor3 = color
end

function PinatKeySystem:BuildUI()
    local parent = GetSafeGuiParent()
    if not parent then return end

    -- Destroy old key system instances if present
    local old = parent:FindFirstChild("PinatHub_KeySystem")
    if old then pcall(function() old:Destroy() end) end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PinatHub_KeySystem"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999999
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = parent
    self.ScreenGui = ScreenGui

    -- Subtle Frosted Dimmer Overlay (No Stray Colored Boxes)
    local Backdrop = Instance.new("Frame")
    Backdrop.Name = "Backdrop"
    Backdrop.Parent = ScreenGui
    Backdrop.Size = UDim2.fromScale(1, 1)
    Backdrop.BackgroundColor3 = Theme.GlassBackdrop
    Backdrop.BackgroundTransparency = 1
    Backdrop.BorderSizePixel = 0

    TweenService:Create(Backdrop, TweenInfoSmooth, { BackgroundTransparency = 0.65 }):Play()

    -- -------------------------------------------------------------------------
    -- MAIN MINIMIZED GLASS WINDOW (Compact & Razor-Clean)
    -- -------------------------------------------------------------------------
    local Window = Instance.new("Frame")
    Window.Name = "MainWindow"
    Window.Parent = ScreenGui
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.Position = UDim2.new(0.5, 0, 0.5, 15)
    Window.Size = UDim2.new(0, 420, 0, 248)
    Window.BackgroundColor3 = Theme.GlassWindow
    Window.BackgroundTransparency = 0.16
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = false
    self.Window = Window

    local WinCorner = Instance.new("UICorner")
    WinCorner.CornerRadius = UDim.new(0, 12)
    WinCorner.Parent = Window

    -- Specular Ambient Border
    local WinStroke = Instance.new("UIStroke")
    WinStroke.Color = Theme.GlassBorderGlow
    WinStroke.Thickness = 1.2
    WinStroke.Transparency = 0.25
    WinStroke.Parent = Window

    local StrokeGradient = Instance.new("UIGradient")
    StrokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Theme.GlassSpecular),
        ColorSequenceKeypoint.new(0.2, Theme.AccentGlow),
        ColorSequenceKeypoint.new(0.6, Theme.Accent),
        ColorSequenceKeypoint.new(0.85, Theme.AccentPink),
        ColorSequenceKeypoint.new(1.0, Theme.AccentDeep)
    })
    StrokeGradient.Rotation = 45
    StrokeGradient.Parent = WinStroke

    AddGlassSpecularHighlight(Window, UDim.new(0, 12))

    -- Smooth Spawn Transition
    Window.Size = UDim2.new(0, 395, 0, 235)
    TweenService:Create(Window, TweenInfoSpring, {
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 420, 0, 248)
    }):Play()

    -- -------------------------------------------------------------------------
    -- 1. HEADER BAR (Height: 44px - Powered by Jnkie)
    -- -------------------------------------------------------------------------
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = Window
    Header.Size = UDim2.new(1, 0, 0, 44)
    Header.BackgroundColor3 = Theme.GlassHeader
    Header.BackgroundTransparency = 0.4
    Header.BorderSizePixel = 0

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header

    AddGlassSpecularHighlight(Header, UDim.new(0, 12))

    local HeaderDivider = Instance.new("Frame")
    HeaderDivider.Parent = Header
    HeaderDivider.Size = UDim2.new(1, 0, 0, 1)
    HeaderDivider.Position = UDim2.new(0, 0, 1, -1)
    HeaderDivider.BackgroundColor3 = Theme.GlassBorderSoft
    HeaderDivider.BorderSizePixel = 0

    -- Logo Frame (PinatHub Official Logo)
    local LogoFrame = Instance.new("Frame")
    LogoFrame.Name = "LogoFrame"
    LogoFrame.Parent = Header
    LogoFrame.AnchorPoint = Vector2.new(0, 0.5)
    LogoFrame.Position = UDim2.new(0, 10, 0.5, 0)
    LogoFrame.Size = UDim2.new(0, 28, 0, 28)
    LogoFrame.BackgroundColor3 = Theme.GlassSurface
    LogoFrame.BackgroundTransparency = 0.35
    LogoFrame.BorderSizePixel = 0

    local LfCorner = Instance.new("UICorner")
    LfCorner.CornerRadius = UDim.new(0, 7)
    LfCorner.Parent = LogoFrame

    local LfStroke = Instance.new("UIStroke")
    LfStroke.Color = Theme.GlassBorderGlow
    LfStroke.Thickness = 1
    LfStroke.Transparency = 0.35
    LfStroke.Parent = LogoFrame

    local LogoImg = Instance.new("ImageLabel")
    LogoImg.Parent = LogoFrame
    LogoImg.AnchorPoint = Vector2.new(0.5, 0.5)
    LogoImg.Position = UDim2.fromScale(0.5, 0.5)
    LogoImg.Size = UDim2.new(0, 20, 0, 20)
    LogoImg.BackgroundTransparency = 1
    LogoImg.Image = Assets.Logo
    LogoImg.ScaleType = Enum.ScaleType.Fit
    LogoImg.ZIndex = 4

    -- Title: PinatHub
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Parent = Header
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 46, 0, 6)
    TitleLabel.Size = UDim2.new(0, 80, 0, 16)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "PinatHub"
    TitleLabel.TextColor3 = Theme.TextPrimary
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Subtitle: Powered by Jnkie (Strictly requested by user)
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "Subtitle"
    SubtitleLabel.Parent = Header
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Position = UDim2.new(0, 46, 0, 23)
    SubtitleLabel.Size = UDim2.new(0, 180, 0, 14)
    SubtitleLabel.Font = Enum.Font.GothamMedium
    SubtitleLabel.Text = "Powered by Jnkie"
    SubtitleLabel.TextColor3 = Theme.TextMuted
    SubtitleLabel.TextSize = 9.5
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Security Pill Badge
    local PillBadge = Instance.new("Frame")
    PillBadge.Name = "PillBadge"
    PillBadge.Parent = Header
    PillBadge.Position = UDim2.new(0, 118, 0, 7)
    PillBadge.Size = UDim2.new(0, 76, 0, 15)
    PillBadge.BackgroundColor3 = Theme.GlassSurfaceActive
    PillBadge.BackgroundTransparency = 0.4
    PillBadge.BorderSizePixel = 0

    local PillCorner = Instance.new("UICorner")
    PillCorner.CornerRadius = UDim.new(1, 0)
    PillCorner.Parent = PillBadge

    local PillStroke = Instance.new("UIStroke")
    PillStroke.Color = Theme.Accent
    PillStroke.Thickness = 0.8
    PillStroke.Transparency = 0.4
    PillStroke.Parent = PillBadge

    local PillIcon = Instance.new("ImageLabel")
    PillIcon.Parent = PillBadge
    PillIcon.AnchorPoint = Vector2.new(0, 0.5)
    PillIcon.Position = UDim2.new(0, 6, 0.5, 0)
    PillIcon.Size = UDim2.new(0, 9, 0, 9)
    PillIcon.BackgroundTransparency = 1
    PillIcon.Image = Assets.Shield
    PillIcon.ImageColor3 = Theme.AccentGlow
    PillIcon.ScaleType = Enum.ScaleType.Fit

    local PillText = Instance.new("TextLabel")
    PillText.Parent = PillBadge
    PillText.Position = UDim2.new(0, 18, 0, 0)
    PillText.Size = UDim2.new(1, -20, 1, 0)
    PillText.BackgroundTransparency = 1
    PillText.Font = Enum.Font.GothamBold
    PillText.Text = "GATEWAY"
    PillText.TextColor3 = Theme.AccentGlow
    PillText.TextSize = 8
    PillText.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button (Decal Icon: 10747384394)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = Header
    CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
    CloseBtn.Position = UDim2.new(1, -10, 0.5, 0)
    CloseBtn.Size = UDim2.new(0, 24, 0, 24)
    CloseBtn.BackgroundColor3 = Theme.GlassSurface
    CloseBtn.BackgroundTransparency = 0.5
    CloseBtn.BorderSizePixel = 0
    CloseBtn.AutoButtonColor = false
    CloseBtn.Text = ""

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn

    local CloseStroke = Instance.new("UIStroke")
    CloseStroke.Color = Theme.GlassBorderSoft
    CloseStroke.Thickness = 0.8
    CloseStroke.Parent = CloseBtn

    local CloseIcon = Instance.new("ImageLabel")
    CloseIcon.Parent = CloseBtn
    CloseIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseIcon.Position = UDim2.fromScale(0.5, 0.5)
    CloseIcon.Size = UDim2.new(0, 11, 0, 11)
    CloseIcon.BackgroundTransparency = 1
    CloseIcon.Image = Assets.Close
    CloseIcon.ImageColor3 = Theme.TextMuted
    CloseIcon.ScaleType = Enum.ScaleType.Fit

    CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(CloseBtn, TweenInfoFast, { BackgroundColor3 = Theme.Danger, BackgroundTransparency = 0.2 }):Play()
        CloseIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end)
    CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(CloseBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurface, BackgroundTransparency = 0.5 }):Play()
        CloseIcon.ImageColor3 = Theme.TextMuted
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        self:Close()
    end)

    MakeDraggable(Header, Window)

    -- -------------------------------------------------------------------------
    -- 2. BODY CONTAINER
    -- -------------------------------------------------------------------------
    local Body = Instance.new("Frame")
    Body.Name = "Body"
    Body.Parent = Window
    Body.Position = UDim2.new(0, 12, 0, 52)
    Body.Size = UDim2.new(1, -24, 1, -60)
    Body.BackgroundTransparency = 1

    -- -------------------------------------------------------------------------
    -- ROW 1: UNIFIED COMPACT WEBSITE & SOCIAL PILL BAR (Height: 26px)
    -- -------------------------------------------------------------------------
    local NavRow = Instance.new("Frame")
    NavRow.Name = "NavRow"
    NavRow.Parent = Body
    NavRow.Position = UDim2.new(0, 0, 0, 0)
    NavRow.Size = UDim2.new(1, 0, 0, 26)
    NavRow.BackgroundTransparency = 1

    local NavLayout = Instance.new("UIListLayout")
    NavLayout.Parent = NavRow
    NavLayout.FillDirection = Enum.FillDirection.Horizontal
    NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    NavLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    NavLayout.Padding = UDim.new(0, 6)

    -- 1.1 Website Button (pinathub.my.id)
    local WebBtn = Instance.new("TextButton")
    WebBtn.Name = "WebBtn"
    WebBtn.Parent = NavRow
    WebBtn.Size = UDim2.new(0, 150, 1, 0)
    WebBtn.BackgroundColor3 = Theme.GlassSurface
    WebBtn.BackgroundTransparency = 0.35
    WebBtn.BorderSizePixel = 0
    WebBtn.AutoButtonColor = false
    WebBtn.Text = ""

    local WbCorner = Instance.new("UICorner")
    WbCorner.CornerRadius = UDim.new(0, 6)
    WbCorner.Parent = WebBtn

    local WbStroke = Instance.new("UIStroke")
    WbStroke.Color = Theme.GlassBorderSoft
    WbStroke.Thickness = 0.8
    WbStroke.Parent = WebBtn

    local WbIcon = Instance.new("ImageLabel")
    WbIcon.Parent = WebBtn
    WbIcon.AnchorPoint = Vector2.new(0, 0.5)
    WbIcon.Position = UDim2.new(0, 8, 0.5, 0)
    WbIcon.Size = UDim2.new(0, 12, 0, 12)
    WbIcon.BackgroundTransparency = 1
    WbIcon.Image = Assets.Globe
    WbIcon.ImageColor3 = Theme.AccentGlow
    WbIcon.ScaleType = Enum.ScaleType.Fit

    local WbText = Instance.new("TextLabel")
    WbText.Parent = WebBtn
    WbText.Position = UDim2.new(0, 24, 0, 0)
    WbText.Size = UDim2.new(1, -26, 1, 0)
    WbText.BackgroundTransparency = 1
    WbText.Font = Enum.Font.GothamMedium
    WbText.Text = "pinathub.my.id"
    WbText.TextColor3 = Theme.TextPrimary
    WbText.TextSize = 10
    WbText.TextXAlignment = Enum.TextXAlignment.Left

    WebBtn.MouseEnter:Connect(function()
        TweenService:Create(WebBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceHover }):Play()
        TweenService:Create(WbStroke, TweenInfoFast, { Color = Theme.Accent }):Play()
    end)
    WebBtn.MouseLeave:Connect(function()
        TweenService:Create(WebBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurface }):Play()
        TweenService:Create(WbStroke, TweenInfoFast, { Color = Theme.GlassBorderSoft }):Play()
    end)
    WebBtn.MouseButton1Click:Connect(function()
        SetClipboardText(self.WebsiteUrl)
        OpenURL(self.WebsiteUrl)
        self:Notify("Website Copied", "Copied https://pinathub.my.id/ to clipboard", "Info", 2.5)
    end)

    -- 1.2 Discord Button (Asset: 18505728250)
    local DiscBtn = Instance.new("TextButton")
    DiscBtn.Name = "DiscordBtn"
    DiscBtn.Parent = NavRow
    DiscBtn.Size = UDim2.new(0, 115, 1, 0)
    DiscBtn.BackgroundColor3 = Theme.GlassSurface
    DiscBtn.BackgroundTransparency = 0.35
    DiscBtn.BorderSizePixel = 0
    DiscBtn.AutoButtonColor = false
    DiscBtn.Text = ""

    local DcCorner = Instance.new("UICorner")
    DcCorner.CornerRadius = UDim.new(0, 6)
    DcCorner.Parent = DiscBtn

    local DcStroke = Instance.new("UIStroke")
    DcStroke.Color = Theme.GlassBorderSoft
    DcStroke.Thickness = 0.8
    DcStroke.Parent = DiscBtn

    local DcIcon = Instance.new("ImageLabel")
    DcIcon.Parent = DiscBtn
    DcIcon.AnchorPoint = Vector2.new(0, 0.5)
    DcIcon.Position = UDim2.new(0, 8, 0.5, 0)
    DcIcon.Size = UDim2.new(0, 13, 0, 13)
    DcIcon.BackgroundTransparency = 1
    DcIcon.Image = Assets.Discord
    DcIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DcIcon.ScaleType = Enum.ScaleType.Fit

    local DcText = Instance.new("TextLabel")
    DcText.Parent = DiscBtn
    DcText.Position = UDim2.new(0, 25, 0, 0)
    DcText.Size = UDim2.new(1, -27, 1, 0)
    DcText.BackgroundTransparency = 1
    DcText.Font = Enum.Font.GothamMedium
    DcText.Text = "Discord"
    DcText.TextColor3 = Theme.TextSecondary
    DcText.TextSize = 10
    DcText.TextXAlignment = Enum.TextXAlignment.Left

    DiscBtn.MouseEnter:Connect(function()
        TweenService:Create(DiscBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceHover }):Play()
        TweenService:Create(DcStroke, TweenInfoFast, { Color = Theme.Accent }):Play()
        DcText.TextColor3 = Theme.TextPrimary
    end)
    DiscBtn.MouseLeave:Connect(function()
        TweenService:Create(DiscBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurface }):Play()
        TweenService:Create(DcStroke, TweenInfoFast, { Color = Theme.GlassBorderSoft }):Play()
        DcText.TextColor3 = Theme.TextSecondary
    end)
    DiscBtn.MouseButton1Click:Connect(function()
        SetClipboardText(self.DiscordUrl)
        pcall(function()
            local req = (syn and syn.request) or (http and http.request) or request or http_request
            if req then
                req({
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json", ["Origin"] = "https://discord.com" },
                    Body = HttpService:JSONEncode({ cmd = "INVITE_BROWSER", args = { code = "Y6Kjfu5XPN" }, nonce = HttpService:GenerateGUID(false) })
                })
            end
        end)
        self:Notify("Discord Invite Copied", "Copied discord.gg/Y6Kjfu5XPN to clipboard", "Info", 2.5)
    end)

    -- 1.3 TikTok Button (Asset: 114030178331137)
    local TTBtn = Instance.new("TextButton")
    TTBtn.Name = "TikTokBtn"
    TTBtn.Parent = NavRow
    TTBtn.Size = UDim2.new(0, 115, 1, 0)
    TTBtn.BackgroundColor3 = Theme.GlassSurface
    TTBtn.BackgroundTransparency = 0.35
    TTBtn.BorderSizePixel = 0
    TTBtn.AutoButtonColor = false
    TTBtn.Text = ""

    local TtCorner = Instance.new("UICorner")
    TtCorner.CornerRadius = UDim.new(0, 6)
    TtCorner.Parent = TTBtn

    local TtStroke = Instance.new("UIStroke")
    TtStroke.Color = Theme.GlassBorderSoft
    TtStroke.Thickness = 0.8
    TtStroke.Parent = TTBtn

    local TtIcon = Instance.new("ImageLabel")
    TtIcon.Parent = TTBtn
    TtIcon.AnchorPoint = Vector2.new(0, 0.5)
    TtIcon.Position = UDim2.new(0, 8, 0.5, 0)
    TtIcon.Size = UDim2.new(0, 13, 0, 13)
    TtIcon.BackgroundTransparency = 1
    TtIcon.Image = Assets.TikTok
    TtIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    TtIcon.ScaleType = Enum.ScaleType.Fit

    local TtText = Instance.new("TextLabel")
    TtText.Parent = TTBtn
    TtText.Position = UDim2.new(0, 25, 0, 0)
    TtText.Size = UDim2.new(1, -27, 1, 0)
    TtText.BackgroundTransparency = 1
    TtText.Font = Enum.Font.GothamMedium
    TtText.Text = "@viunze"
    TtText.TextColor3 = Theme.TextSecondary
    TtText.TextSize = 10
    TtText.TextXAlignment = Enum.TextXAlignment.Left

    TTBtn.MouseEnter:Connect(function()
        TweenService:Create(TTBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceHover }):Play()
        TweenService:Create(TtStroke, TweenInfoFast, { Color = Theme.Accent }):Play()
        TtText.TextColor3 = Theme.TextPrimary
    end)
    TTBtn.MouseLeave:Connect(function()
        TweenService:Create(TTBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurface }):Play()
        TweenService:Create(TtStroke, TweenInfoFast, { Color = Theme.GlassBorderSoft }):Play()
        TtText.TextColor3 = Theme.TextSecondary
    end)
    TTBtn.MouseButton1Click:Connect(function()
        SetClipboardText(self.TikTokUrl)
        self:Notify("TikTok Copied", "Copied @viunze link to clipboard", "Info", 2.5)
    end)

    -- -------------------------------------------------------------------------
    -- ROW 2: KEY INPUT BOX (Height: 36px)
    -- -------------------------------------------------------------------------
    local BoxFrame = Instance.new("Frame")
    BoxFrame.Name = "BoxFrame"
    BoxFrame.Parent = Body
    BoxFrame.Position = UDim2.new(0, 0, 0, 34)
    BoxFrame.Size = UDim2.new(1, 0, 0, 36)
    BoxFrame.BackgroundColor3 = Theme.GlassSurface
    BoxFrame.BackgroundTransparency = 0.35
    BoxFrame.BorderSizePixel = 0

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 7)
    BoxCorner.Parent = BoxFrame

    local BoxStroke = Instance.new("UIStroke")
    BoxStroke.Color = Theme.GlassBorderSoft
    BoxStroke.Thickness = 1
    BoxStroke.Parent = BoxFrame

    local BoxKeyIcon = Instance.new("ImageLabel")
    BoxKeyIcon.Parent = BoxFrame
    BoxKeyIcon.AnchorPoint = Vector2.new(0, 0.5)
    BoxKeyIcon.Position = UDim2.new(0, 10, 0.5, 0)
    BoxKeyIcon.Size = UDim2.new(0, 14, 0, 14)
    BoxKeyIcon.BackgroundTransparency = 1
    BoxKeyIcon.Image = Assets.Lock
    BoxKeyIcon.ImageColor3 = Theme.TextMuted
    BoxKeyIcon.ScaleType = Enum.ScaleType.Fit

    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Parent = BoxFrame
    KeyInput.Position = UDim2.new(0, 32, 0, 0)
    KeyInput.Size = UDim2.new(1, -96, 1, 0)
    KeyInput.BackgroundTransparency = 1
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderColor3 = Theme.TextMuted
    KeyInput.PlaceholderText = "Paste your license key here..."
    KeyInput.Text = ""
    KeyInput.TextColor3 = Theme.TextPrimary
    KeyInput.TextSize = 11
    KeyInput.TextXAlignment = Enum.TextXAlignment.Left
    KeyInput.ClearTextOnFocus = false
    self.KeyInput = KeyInput

    KeyInput.Focused:Connect(function()
        TweenService:Create(BoxStroke, TweenInfoFast, { Color = Theme.Accent, Transparency = 0 }):Play()
        TweenService:Create(BoxKeyIcon, TweenInfoFast, { ImageColor3 = Theme.AccentGlow }):Play()
    end)
    KeyInput.FocusLost:Connect(function()
        TweenService:Create(BoxStroke, TweenInfoFast, { Color = Theme.GlassBorderSoft, Transparency = 0.3 }):Play()
        TweenService:Create(BoxKeyIcon, TweenInfoFast, { ImageColor3 = Theme.TextMuted }):Play()
    end)

    -- Paste Button (Clipboard Decal: 10709783474)
    local PasteBtn = Instance.new("TextButton")
    PasteBtn.Name = "PasteBtn"
    PasteBtn.Parent = BoxFrame
    PasteBtn.AnchorPoint = Vector2.new(1, 0.5)
    PasteBtn.Position = UDim2.new(1, -34, 0.5, 0)
    PasteBtn.Size = UDim2.new(0, 26, 0, 24)
    PasteBtn.BackgroundColor3 = Theme.GlassSurfaceActive
    PasteBtn.BackgroundTransparency = 0.35
    PasteBtn.BorderSizePixel = 0
    PasteBtn.AutoButtonColor = false
    PasteBtn.Text = ""

    local PasteCorner = Instance.new("UICorner")
    PasteCorner.CornerRadius = UDim.new(0, 5)
    PasteCorner.Parent = PasteBtn

    local PasteIcon = Instance.new("ImageLabel")
    PasteIcon.Parent = PasteBtn
    PasteIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    PasteIcon.Position = UDim2.fromScale(0.5, 0.5)
    PasteIcon.Size = UDim2.new(0, 13, 0, 13)
    PasteIcon.BackgroundTransparency = 1
    PasteIcon.Image = Assets.Clipboard
    PasteIcon.ImageColor3 = Theme.TextSecondary
    PasteIcon.ScaleType = Enum.ScaleType.Fit

    PasteBtn.MouseEnter:Connect(function()
        TweenService:Create(PasteBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceHover }):Play()
        PasteIcon.ImageColor3 = Theme.TextPrimary
    end)
    PasteBtn.MouseLeave:Connect(function()
        TweenService:Create(PasteBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceActive }):Play()
        PasteIcon.ImageColor3 = Theme.TextSecondary
    end)
    PasteBtn.MouseButton1Click:Connect(function()
        local clip = GetClipboardText()
        if clip and #clip > 0 then
            KeyInput.Text = clip
            self:Notify("Pasted", "License key pasted from clipboard", "Info", 2)
        else
            KeyInput:CaptureFocus()
        end
    end)

    -- Clear Button (Close Decal: 10747384394)
    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Name = "ClearBtn"
    ClearBtn.Parent = BoxFrame
    ClearBtn.AnchorPoint = Vector2.new(1, 0.5)
    ClearBtn.Position = UDim2.new(1, -6, 0.5, 0)
    ClearBtn.Size = UDim2.new(0, 24, 0, 24)
    ClearBtn.BackgroundColor3 = Theme.GlassSurfaceActive
    ClearBtn.BackgroundTransparency = 0.5
    ClearBtn.BorderSizePixel = 0
    ClearBtn.AutoButtonColor = false
    ClearBtn.Text = ""

    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, 5)
    ClearCorner.Parent = ClearBtn

    local ClearIcon = Instance.new("ImageLabel")
    ClearIcon.Parent = ClearBtn
    ClearIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    ClearIcon.Position = UDim2.fromScale(0.5, 0.5)
    ClearIcon.Size = UDim2.new(0, 10, 0, 10)
    ClearIcon.BackgroundTransparency = 1
    ClearIcon.Image = Assets.Clear
    ClearIcon.ImageColor3 = Theme.TextMuted
    ClearIcon.ScaleType = Enum.ScaleType.Fit

    ClearBtn.MouseEnter:Connect(function()
        TweenService:Create(ClearBtn, TweenInfoFast, { BackgroundColor3 = Theme.Danger, BackgroundTransparency = 0.2 }):Play()
        ClearIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end)
    ClearBtn.MouseLeave:Connect(function()
        TweenService:Create(ClearBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceActive, BackgroundTransparency = 0.5 }):Play()
        ClearIcon.ImageColor3 = Theme.TextMuted
    end)
    ClearBtn.MouseButton1Click:Connect(function()
        KeyInput.Text = ""
        self:SetStatus("Key cleared. Ready for input.", "Info")
    end)

    -- -------------------------------------------------------------------------
    -- ROW 3: MODERN SLIDING SWITCH (Remember Key - Height: 18px)
    -- -------------------------------------------------------------------------
    local RememberFrame = Instance.new("Frame")
    RememberFrame.Name = "RememberFrame"
    RememberFrame.Parent = Body
    RememberFrame.Position = UDim2.new(0, 0, 0, 76)
    RememberFrame.Size = UDim2.new(1, 0, 0, 18)
    RememberFrame.BackgroundTransparency = 1

    local SwitchTrack = Instance.new("TextButton")
    SwitchTrack.Name = "SwitchTrack"
    SwitchTrack.Parent = RememberFrame
    SwitchTrack.Size = UDim2.new(0, 28, 0, 15)
    SwitchTrack.Position = UDim2.new(0, 0, 0, 1)
    SwitchTrack.BackgroundColor3 = Theme.Accent
    SwitchTrack.BorderSizePixel = 0
    SwitchTrack.AutoButtonColor = false
    SwitchTrack.Text = ""

    local StCorner = Instance.new("UICorner")
    StCorner.CornerRadius = UDim.new(1, 0)
    StCorner.Parent = SwitchTrack

    local StStroke = Instance.new("UIStroke")
    StStroke.Color = Theme.GlassBorderSoft
    StStroke.Thickness = 0.8
    StStroke.Parent = SwitchTrack

    local SwitchKnob = Instance.new("Frame")
    SwitchKnob.Name = "Knob"
    SwitchKnob.Parent = SwitchTrack
    SwitchKnob.AnchorPoint = Vector2.new(0, 0.5)
    SwitchKnob.Position = UDim2.new(1, -13, 0.5, 0)
    SwitchKnob.Size = UDim2.new(0, 11, 0, 11)
    SwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchKnob.BorderSizePixel = 0

    local SkCorner = Instance.new("UICorner")
    SkCorner.CornerRadius = UDim.new(1, 0)
    SkCorner.Parent = SwitchKnob

    local RememberLabel = Instance.new("TextLabel")
    RememberLabel.Parent = RememberFrame
    RememberLabel.BackgroundTransparency = 1
    RememberLabel.Position = UDim2.new(0, 36, 0, 0)
    RememberLabel.Size = UDim2.new(1, -36, 1, 0)
    RememberLabel.Font = Enum.Font.GothamMedium
    RememberLabel.Text = "Remember key on this device (Save HWID session for auto-login)"
    RememberLabel.TextColor3 = Theme.TextSecondary
    RememberLabel.TextSize = 9.5
    RememberLabel.TextXAlignment = Enum.TextXAlignment.Left

    local function updateSwitchUI()
        if self.RememberKey then
            TweenService:Create(SwitchTrack, TweenInfoFast, { BackgroundColor3 = Theme.Accent }):Play()
            TweenService:Create(SwitchKnob, TweenInfoFast, { Position = UDim2.new(1, -13, 0.5, 0) }):Play()
        else
            TweenService:Create(SwitchTrack, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurface }):Play()
            TweenService:Create(SwitchKnob, TweenInfoFast, { Position = UDim2.new(0, 2, 0.5, 0) }):Play()
        end
    end

    SwitchTrack.MouseButton1Click:Connect(function()
        self.RememberKey = not self.RememberKey
        updateSwitchUI()
        if not self.RememberKey then
            JunkieService:ClearSavedKey()
            self:Notify("Session Cleared", "Saved device key has been removed", "Warning", 2)
        end
    end)

    -- -------------------------------------------------------------------------
    -- ROW 4: ACTION BUTTONS (Height: 34px)
    -- -------------------------------------------------------------------------
    local ActionsFrame = Instance.new("Frame")
    ActionsFrame.Name = "ActionsFrame"
    ActionsFrame.Parent = Body
    ActionsFrame.Position = UDim2.new(0, 0, 0, 100)
    ActionsFrame.Size = UDim2.new(1, 0, 0, 34)
    ActionsFrame.BackgroundTransparency = 1

    local ActionLayout = Instance.new("UIListLayout")
    ActionLayout.Parent = ActionsFrame
    ActionLayout.FillDirection = Enum.FillDirection.Horizontal
    ActionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ActionLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ActionLayout.Padding = UDim.new(0, 8)

    -- 4.1 "Get Key Link" Button
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Name = "GetKeyBtn"
    GetKeyBtn.Parent = ActionsFrame
    GetKeyBtn.Size = UDim2.new(0.5, -4, 1, 0)
    GetKeyBtn.BackgroundColor3 = Theme.GlassSurface
    GetKeyBtn.BackgroundTransparency = 0.3
    GetKeyBtn.BorderSizePixel = 0
    GetKeyBtn.AutoButtonColor = false
    GetKeyBtn.Text = ""

    local GkCorner = Instance.new("UICorner")
    GkCorner.CornerRadius = UDim.new(0, 8)
    GkCorner.Parent = GetKeyBtn

    local GkStroke = Instance.new("UIStroke")
    GkStroke.Color = Theme.GlassBorderSoft
    GkStroke.Thickness = 1
    GkStroke.Parent = GetKeyBtn

    AddGlassSpecularHighlight(GetKeyBtn, UDim.new(0, 8))

    local GkContent = Instance.new("Frame")
    GkContent.Parent = GetKeyBtn
    GkContent.AnchorPoint = Vector2.new(0.5, 0.5)
    GkContent.Position = UDim2.fromScale(0.5, 0.5)
    GkContent.Size = UDim2.new(0, 100, 0, 16)
    GkContent.BackgroundTransparency = 1

    local GkIcon = Instance.new("ImageLabel")
    GkIcon.Parent = GkContent
    GkIcon.AnchorPoint = Vector2.new(0, 0.5)
    GkIcon.Position = UDim2.new(0, 0, 0.5, 0)
    GkIcon.Size = UDim2.new(0, 13, 0, 13)
    GkIcon.BackgroundTransparency = 1
    GkIcon.Image = Assets.Key
    GkIcon.ImageColor3 = Theme.AccentGlow
    GkIcon.ScaleType = Enum.ScaleType.Fit

    local GkText = Instance.new("TextLabel")
    GkText.Parent = GkContent
    GkText.Position = UDim2.new(0, 18, 0, 0)
    GkText.Size = UDim2.new(1, -18, 1, 0)
    GkText.BackgroundTransparency = 1
    GkText.Font = Enum.Font.GothamBold
    GkText.Text = "Get Key Link"
    GkText.TextColor3 = Theme.TextPrimary
    GkText.TextSize = 11.5
    GkText.TextXAlignment = Enum.TextXAlignment.Left

    GetKeyBtn.MouseEnter:Connect(function()
        TweenService:Create(GetKeyBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurfaceHover }):Play()
        TweenService:Create(GkStroke, TweenInfoFast, { Color = Theme.Accent }):Play()
    end)
    GetKeyBtn.MouseLeave:Connect(function()
        TweenService:Create(GetKeyBtn, TweenInfoFast, { BackgroundColor3 = Theme.GlassSurface }):Play()
        TweenService:Create(GkStroke, TweenInfoFast, { Color = Theme.GlassBorderSoft }):Play()
    end)
    GetKeyBtn.MouseButton1Click:Connect(function()
        local link = JunkieService:GetKeyLink()
        SetClipboardText(link)
        OpenURL(link)
        self:Notify("Key Link Copied", "Copied " .. link .. " to clipboard", "Success", 3)
        self:SetStatus("Key link copied. Complete checkpoint & paste your key.", "Info")
    end)

    -- 4.2 "Verify Key" Button
    local VerifyBtn = Instance.new("TextButton")
    VerifyBtn.Name = "VerifyBtn"
    VerifyBtn.Parent = ActionsFrame
    VerifyBtn.Size = UDim2.new(0.5, -4, 1, 0)
    VerifyBtn.BackgroundColor3 = Theme.Accent
    VerifyBtn.BorderSizePixel = 0
    VerifyBtn.AutoButtonColor = false
    VerifyBtn.Text = ""
    self.VerifyBtn = VerifyBtn

    local VfCorner = Instance.new("UICorner")
    VfCorner.CornerRadius = UDim.new(0, 8)
    VfCorner.Parent = VerifyBtn

    local VfGradient = Instance.new("UIGradient")
    VfGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Theme.AccentGlow),
        ColorSequenceKeypoint.new(0.5, Theme.Accent),
        ColorSequenceKeypoint.new(1.0, Theme.AccentDeep)
    })
    VfGradient.Rotation = 45
    VfGradient.Parent = VerifyBtn

    local VfStroke = Instance.new("UIStroke")
    VfStroke.Color = Theme.GlassSpecular
    VfStroke.Thickness = 1
    VfStroke.Transparency = 0.4
    VfStroke.Parent = VerifyBtn

    AddGlassSpecularHighlight(VerifyBtn, UDim.new(0, 8))

    local VfContent = Instance.new("Frame")
    VfContent.Parent = VerifyBtn
    VfContent.AnchorPoint = Vector2.new(0.5, 0.5)
    VfContent.Position = UDim2.fromScale(0.5, 0.5)
    VfContent.Size = UDim2.new(0, 95, 0, 16)
    VfContent.BackgroundTransparency = 1

    local VfIcon = Instance.new("ImageLabel")
    VfIcon.Parent = VfContent
    VfIcon.AnchorPoint = Vector2.new(0, 0.5)
    VfIcon.Position = UDim2.new(0, 0, 0.5, 0)
    VfIcon.Size = UDim2.new(0, 13, 0, 13)
    VfIcon.BackgroundTransparency = 1
    VfIcon.Image = Assets.ChevronRight
    VfIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    VfIcon.ScaleType = Enum.ScaleType.Fit
    self.VerifyBtnIcon = VfIcon

    local VfText = Instance.new("TextLabel")
    VfText.Parent = VfContent
    VfText.Position = UDim2.new(0, 18, 0, 0)
    VfText.Size = UDim2.new(1, -18, 1, 0)
    VfText.BackgroundTransparency = 1
    VfText.Font = Enum.Font.GothamBold
    VfText.Text = "Verify Key"
    VfText.TextColor3 = Color3.fromRGB(255, 255, 255)
    VfText.TextSize = 11.5
    VfText.TextXAlignment = Enum.TextXAlignment.Left
    self.VerifyBtnText = VfText

    VerifyBtn.MouseEnter:Connect(function()
        TweenService:Create(VerifyBtn, TweenInfoFast, { BackgroundTransparency = 0.1 }):Play()
        TweenService:Create(VfStroke, TweenInfoFast, { Transparency = 0.15 }):Play()
    end)
    VerifyBtn.MouseLeave:Connect(function()
        TweenService:Create(VerifyBtn, TweenInfoFast, { BackgroundTransparency = 0 }):Play()
        TweenService:Create(VfStroke, TweenInfoFast, { Transparency = 0.4 }):Play()
    end)
    VerifyBtn.MouseButton1Click:Connect(function()
        self:ProcessVerification()
    end)

    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed and not self.IsVerifying then
            self:ProcessVerification()
        end
    end)

    -- -------------------------------------------------------------------------
    -- ROW 5: STATUS BAR (Height: 22px)
    -- -------------------------------------------------------------------------
    local StatusCard = Instance.new("Frame")
    StatusCard.Name = "StatusCard"
    StatusCard.Parent = Body
    StatusCard.Position = UDim2.new(0, 0, 0, 142)
    StatusCard.Size = UDim2.new(1, 0, 0, 22)
    StatusCard.BackgroundColor3 = Theme.GlassCard
    StatusCard.BackgroundTransparency = 0.5
    StatusCard.BorderSizePixel = 0

    local ScCorner = Instance.new("UICorner")
    ScCorner.CornerRadius = UDim.new(0, 6)
    ScCorner.Parent = StatusCard

    local ScStroke = Instance.new("UIStroke")
    ScStroke.Color = Theme.GlassBorderSoft
    ScStroke.Thickness = 0.8
    ScStroke.Parent = StatusCard

    local StatusDot = Instance.new("Frame")
    StatusDot.Parent = StatusCard
    StatusDot.AnchorPoint = Vector2.new(0, 0.5)
    StatusDot.Position = UDim2.new(0, 8, 0.5, 0)
    StatusDot.Size = UDim2.new(0, 6, 0, 6)
    StatusDot.BackgroundColor3 = Theme.Accent
    StatusDot.BorderSizePixel = 0
    self.StatusDot = StatusDot

    local SdCorner = Instance.new("UICorner")
    SdCorner.CornerRadius = UDim.new(1, 0)
    SdCorner.Parent = StatusDot

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Parent = StatusCard
    StatusLabel.Position = UDim2.new(0, 20, 0, 0)
    StatusLabel.Size = UDim2.new(1, -26, 1, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Font = Enum.Font.GothamMedium
    StatusLabel.Text = "Ready for verification. Enter your key or click Get Key Link."
    StatusLabel.TextColor3 = Theme.TextSecondary
    StatusLabel.TextSize = 9.5
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
    self.StatusLabel = StatusLabel

    -- -------------------------------------------------------------------------
    -- 3. NOTIFICATION CONTAINER
    -- -------------------------------------------------------------------------
    local NotifContainer = Instance.new("Frame")
    NotifContainer.Name = "NotificationContainer"
    NotifContainer.Parent = ScreenGui
    NotifContainer.AnchorPoint = Vector2.new(1, 0)
    NotifContainer.Position = UDim2.new(1, -14, 0, 20)
    NotifContainer.Size = UDim2.new(0, 260, 0, 280)
    NotifContainer.BackgroundTransparency = 1

    local NotifLayout = Instance.new("UIListLayout")
    NotifLayout.Parent = NotifContainer
    NotifLayout.FillDirection = Enum.FillDirection.Vertical
    NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    NotifLayout.Padding = UDim.new(0, 6)
    self.NotificationContainer = NotifContainer

    -- -------------------------------------------------------------------------
    -- 4. AUTO-AUTHENTICATION SEQUENCE
    -- -------------------------------------------------------------------------
    task.spawn(function()
        task.wait(0.2)
        local savedKey = JunkieService:LoadSavedKey()
        if savedKey and #savedKey > 0 then
            KeyInput.Text = savedKey
            self:SetStatus("Found saved key on device. Auto-authenticating...", "Loading")
            task.wait(0.3)
            self:ProcessVerification(true)
        end
    end)
end

function PinatKeySystem:ProcessVerification(isAuto)
    if self.IsVerifying then return end
    local key = tostring(self.KeyInput and self.KeyInput.Text or "")
    key = key:gsub("^%s+", ""):gsub("%s+$", "")

    if #key == 0 then
        self:SetStatus("Please enter your key before verifying.", "Warning")
        self:Notify("Key Missing", "Please enter or paste your license key", "Warning", 2.5)
        return
    end

    self.IsVerifying = true
    self:SetStatus("Contacting Jnkie Key System and verifying device HWID...", "Loading")

    if self.VerifyBtnText then
        self.VerifyBtnText.Text = "Verifying..."
    end
    if self.VerifyBtnIcon then
        self.VerifyBtnIcon.Image = Assets.Refresh
    end

    task.spawn(function()
        local success, message = JunkieService:ValidateKey(key)
        self.IsVerifying = false

        if self.VerifyBtnText then
            self.VerifyBtnText.Text = "Verify Key"
        end
        if self.VerifyBtnIcon then
            self.VerifyBtnIcon.Image = Assets.ChevronRight
        end

        if success then
            self:SetStatus("Key validated successfully. Launching PinatHub...", "Success")
            self:Notify("Access Granted", "Key verified successfully. Loading PinatHub...", "Success", 2.5)

            getgenv().SCRIPT_KEY = key
            if self.RememberKey then
                JunkieService:SaveKey(key)
            end

            task.wait(0.6)
            self:OnValidationSuccess(key)
        else
            self:SetStatus(message, "Error")
            self:Notify("Authentication Failed", message, "Danger", 3)
            if isAuto then
                JunkieService:ClearSavedKey()
            end
        end
    end)
end

function PinatKeySystem:OnValidationSuccess(validatedKey)
    if self.Window then
        local tw = TweenService:Create(self.Window, TweenInfoFast, {
            Size = UDim2.new(0, 380, 0, 220),
            BackgroundTransparency = 1
        })
        tw:Play()
        tw.Completed:Connect(function()
            if self.ScreenGui then
                pcall(function() self.ScreenGui:Destroy() end)
            end
        end)
    end

    if type(self.Callback) == "function" then
        pcall(self.Callback, validatedKey)
        return
    end

    task.spawn(function()
        local function loadMainScript()
            if readfile and isfile and isfile("pinathub_kys_integrated.lua") then
                local content = readfile("pinathub_kys_integrated.lua")
                local fn, err = loadstring(content)
                if not fn then error(err) end
                return fn()
            end
            local url = "https://raw.githubusercontent.com/xploitforceofficial-stack/intregation-pinathub-to-kingrua-library/refs/heads/main/pinathub_kys_integrated.lua"
            local content = game:HttpGet(url .. "?t=" .. os.time())
            local fn, err = loadstring(content)
            if not fn then error(err) end
            return fn()
        end

        local ok, err = pcall(loadMainScript)
        if not ok then
            warn("[PinatHub KeySystem] Failed to launch main script:", err)
        end
    end)
end

function PinatKeySystem:Close()
    if self.ScreenGui then
        if self.Window then
            local tw = TweenService:Create(self.Window, TweenInfoFast, {
                Position = UDim2.new(0.5, 0, 0.5, 20),
                BackgroundTransparency = 1
            })
            tw:Play()
            tw.Completed:Connect(function()
                pcall(function() self.ScreenGui:Destroy() end)
            end)
        else
            pcall(function() self.ScreenGui:Destroy() end)
        end
    end
end

-- -----------------------------------------------------------------------------
-- 6. EXPORT / AUTO-RUNNER
-- -----------------------------------------------------------------------------
local function InitKeySystemStandalone()
    return PinatKeySystem.Create({
        Service    = "pinathub",
        GetKeyUrl  = "https://jnkie.com/get-key/pinathub",
        WebsiteUrl = "https://pinathub.my.id/",
        DiscordUrl = "https://discord.gg/Y6Kjfu5XPN",
        TikTokUrl  = "https://www.tiktok.com/@viunze"
    })
end

getgenv().PinatKeySystem = PinatKeySystem

if not getgenv()._PINATHUB_KEYSYSTEM_NO_AUTORUN then
    InitKeySystemStandalone()
end

return PinatKeySystem
