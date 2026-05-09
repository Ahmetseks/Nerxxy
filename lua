--[[ 
    T-90MMS MOBILE ELITE v4.0
    -------------------------------------------
    MOBİL ÖZEL: GUI Kontrollü (Tuşsuz Kullanım)
    Özellikler: Fly, Aimbot (Team Check), Noclip, ESP
    -------------------------------------------
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

--// SİSTEM DURUMLARI
local Settings = {
    AimActive = false,
    FlyActive = false,
    NoclipActive = false,
    EspActive = false,
    TeamCheck = true,
    AimRadius = 150, -- Ekran ortasındaki yuvarlak alanı
    FlySpeed = 50
}

--// MOBİL UI OLUŞTURMA (Siyah-Beyaz)
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "T90_Mobile"
ScreenGui.ResetOnSpawn = false

-- Menüyü Açma Butonu
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.new(0,0,0)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Text = "T90"
OpenBtn.TextSize = 15
local Round = Instance.new("UICorner", OpenBtn)
Round.CornerRadius = UDim.new(1, 0)

-- Ana Menü Paneli
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.new(0,0,0)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Visible = false -- Başlangıçta gizli
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "T-90MMS MOBILE"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.TextSize = 18

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.85, 0, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.new(1,0,0)
CloseBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

--// BUTTON GENERATOR
local function CreateToggle(name, pos)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, pos)
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name .. ": OFF"
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    return btn
end

local AimBtn = CreateToggle("AIMBOT", 50)
local FlyBtn = CreateToggle("FLY", 100)
local NoclipBtn = CreateToggle("NOCLIP", 150)
local EspBtn = CreateToggle("ESP", 200)

-- FOV Circle (Ekran Ortasındaki Yuvarlak)
local FOVCircle = Instance.new("Frame", ScreenGui)
FOVCircle.Size = UDim2.new(0, Settings.AimRadius * 2, 0, Settings.AimRadius * 2)
FOVCircle.Position = UDim2.new(0.5, -Settings.AimRadius, 0.5, -Settings.AimRadius)
FOVCircle.BackgroundColor3 = Color3.new(1,1,1)
FOVCircle.BackgroundTransparency = 0.9
FOVCircle.Visible = false
local CircleCorner = Instance.new("UICorner", FOVCircle)
CircleCorner.CornerRadius = UDim.new(1,0)

--// LOGIC FUNCTIONS
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenBtn.Visible = true end)

AimBtn.MouseButton1Click:Connect(function()
    Settings.AimActive = not Settings.AimActive
    AimBtn.Text = Settings.AimActive and "AIMBOT: ON" or "AIMBOT: OFF"
    FOVCircle.Visible = Settings.AimActive
end)

FlyBtn.MouseButton1Click:Connect(function()
    Settings.FlyActive = not Settings.FlyActive
    FlyBtn.Text = Settings.FlyActive and "FLY: ON" or "FLY: OFF"
end)

NoclipBtn.MouseButton1Click:Connect(function()
    Settings.NoclipActive = not Settings.NoclipActive
    NoclipBtn.Text = Settings.NoclipActive and "NOCLIP: ON" or "NOCLIP: OFF"
end)

EspBtn.MouseButton1Click:Connect(function()
    Settings.EspActive = not Settings.EspActive
    EspBtn.Text = Settings.EspActive and "ESP: ON" or "ESP: OFF"
end)

--// AIMBOT TARGETING (Mobile Friendly)
local function GetClosestToCenter()
    local target = nil
    local dist = Settings.AimRadius

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            -- Team Check
            if Settings.TeamCheck and p.Team == LocalPlayer.Team then continue end

            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if onScreen then
                local screenPos = Vector2.new(pos.X, pos.Y)
                local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                local mag = (screenPos - mousePos).Magnitude

                if mag < dist then
                    dist = mag
                    target = p.Character.Head
                end
            end
        end
    end
    return target
end

--// RUNTIME LOOPS
RunService.RenderStepped:Connect(function()
    -- Aimbot
    if Settings.AimActive then
        local target = GetClosestToCenter()
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), 0.2)
        end
    end

    -- Fly
    if Settings.FlyActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.Velocity = Camera.CFrame.LookVector * Settings.FlySpeed
    end
end)

RunService.Stepped:Connect(function()
    if Settings.NoclipActive and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)
