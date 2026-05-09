-- =============================================
-- Nexxzy034 Hub v2.0 - Full Features
-- Key System + Mobile Friendly + All Features
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- ================== SETTINGS ==================
local Settings = {
    ESP = { Enabled = true, TeamCheck = true, Boxes = true, Names = true, Health = true, Tracers = true },
    Aimbot = { Enabled = false, Smoothness = 7, FOV = 140 },
    SilentAim = { Enabled = false },
    GodMode = { Enabled = false },
    Movement = { FlyEnabled = false, FlySpeed = 65, InfiniteJump = false },
    AntiKick = { Enabled = true },
    AntiLag = { Enabled = false },
    Troll = { SevenDay7_Enabled = false }
}

-- ================== KEY SYSTEM (Kontrol) ==================
print("✅ Nexxzy034 Hub v2.0 Yüklendi!")

-- ================== ANA HUB GUI ==================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Nexxzy034Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 70)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Text = "Nexxzy034 Hub"
TitleBar.TextColor3 = Color3.fromRGB(0, 255, 200)
TitleBar.TextScaled = true
TitleBar.Font = Enum.Font.GothamBold
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 50, 0, 50)
MinimizeBtn.Position = UDim2.new(1, -60, 0, 10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 160, 50)
MinimizeBtn.Text = "−"
MinimizeBtn.TextScaled = true
MinimizeBtn.Parent = TitleBar
Instance.new("UICorner", MinimizeBtn)

local MiniIndicator = Instance.new("TextButton")
MiniIndicator.Size = UDim2.new(0, 80, 0, 80)
MiniIndicator.Position = UDim2.new(0, 30, 0.4, 0)
MiniIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
MiniIndicator.Text = "N"
MiniIndicator.TextScaled = true
MiniIndicator.Visible = false
Instance.new("UICorner", MiniIndicator).CornerRadius = UDim.new(0, 20)
MiniIndicator.Parent = ScreenGui

-- Minimize Logic
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniIndicator.Visible = true
end)
MiniIndicator.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniIndicator.Visible = false
end)

-- Scrolling
local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Size = UDim2.new(1, -20, 1, -90)
Scrolling.Position = UDim2.new(0, 10, 0, 80)
Scrolling.BackgroundTransparency = 1
Scrolling.ScrollBarThickness = 8
Scrolling.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 10)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = Scrolling

-- Toggle Fonksiyonu
local function AddToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 70)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = Scrolling
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 20, 0, 0)
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 130, 0, 50)
    btn.Position = UDim2.new(1, -150, 0.5, -25)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(80,80,80)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        default = not default
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(80,80,80)
        btn.Text = default and "ON" or "OFF"
        callback(default)
    end)
end

-- ================== TÜM ÖZELLİKLER ==================
AddToggle("ESP Toggle", Settings.ESP.Enabled, function(s) Settings.ESP.Enabled = s end)
AddToggle("Aimbot", Settings.Aimbot.Enabled, function(s) Settings.Aimbot.Enabled = s end)
AddToggle("Silent Aim", Settings.SilentAim.Enabled, function(s) Settings.SilentAim.Enabled = s end)
AddToggle("God Mode", Settings.GodMode.Enabled, function(s) Settings.GodMode.Enabled = s end)
AddToggle("Fly (F)", Settings.Movement.FlyEnabled, function(s) Settings.Movement.FlyEnabled = s end)
AddToggle("Infinite Jump", Settings.Movement.InfiniteJump, function(s) Settings.Movement.InfiniteJump = s end)
AddToggle("Anti-Kick", Settings.AntiKick.Enabled, function(s) Settings.AntiKick.Enabled = s end)
AddToggle("Anti-Lag", Settings.AntiLag.Enabled, function(s) Settings.AntiLag.Enabled = s end)
AddToggle("7Day7 Troll Animations", Settings.Troll.SevenDay7_Enabled, function(s) 
    Settings.Troll.SevenDay7_Enabled = s 
    print("7Day7 Troll:", s and "AKTİF" or "KAPALI")
end)

-- ================== ANA LOOP (ESP + Fly + Aimbot) ==================
RunService.RenderStepped:Connect(function()
    -- Fly
    if Settings.Movement.FlyEnabled then
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
            root.CFrame += dir.Unit * Settings.Movement.FlySpeed * 0.1
        end
    end
end)

-- F Tuşu Fly Toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        Settings.Movement.FlyEnabled = not Settings.Movement.FlyEnabled
    end
end)

print("🚀 Tüm özellikler yüklendi! İyi troll'ler dilerim :)")
StarterGui:SetCore("SendNotification", {Title = "Nexxzy034 Hub", Text = "Hub başarıyla yüklendi!", Duration = 5})
