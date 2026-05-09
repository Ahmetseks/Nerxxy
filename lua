--[[ 
    T-90MMS MOBILE ELITE v5.0 - NOIR MOD MENU
    - Sürüklenebilir Menü
    - Team-Check Aimbot (FOV)
    - Fly & Noclip & ESP
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// AYARLAR
local _G_DATA = {
    Aim = false,
    Fly = false,
    Noclip = false,
    Esp = false,
    Radius = 120, -- Aimbot halka genişliği
    FlySpeed = 50
}

--// UI OLUŞTURMA
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "T90_Elite_Mobile"
ScreenGui.ResetOnSpawn = false

-- Menü Açma Butonu (Yüzen Buton)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.new(0,0,0)
OpenBtn.BorderSizePixel = 2
OpenBtn.BorderColor3 = Color3.new(1,1,1)
OpenBtn.Text = "T90"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = Enum.Font.Code
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1,0)

-- Ana Menü
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 280)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.new(0,0,0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.new(1,1,1)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Menü Başlığı (Sürükleme Alanı)
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "T-90MMS MOBILE ELITE"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.Code
Title.TextSize = 16

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
CloseBtn.BackgroundColor3 = Color3.new(0,0,0)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Text = "X"
CloseBtn.BorderSizePixel = 1
CloseBtn.BorderColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

-- FOV Halkası (Görsel)
local FOVCircle = Instance.new("Frame", ScreenGui)
FOVCircle.Size = UDim2.new(0, _G_DATA.Radius * 2, 0, _G_DATA.Radius * 2)
FOVCircle.Position = UDim2.new(0.5, -_G_DATA.Radius, 0.5, -_G_DATA.Radius)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
local CircleOutline = Instance.new("UIStroke", FOVCircle)
CircleOutline.Color = Color3.new(1,1,1)
CircleOutline.Thickness = 1
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1,0)

--// SÜRÜKLENEBİLİR UI MANTIĞI
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--// BUTON ÜRETİCİ
local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, pos)
    btn.BackgroundColor3 = Color3.new(0,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name .. ": OFF"
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.new(0.3,0.3,0.3)
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
end

--// ÖZELLİK KONTROLLERİ
CreateButton("AIMBOT", 50, function(b)
    _G_DATA.Aim = not _G_DATA.Aim
    b.Text = _G_DATA.Aim and "AIMBOT: ON" or "AIMBOT: OFF"
    b.TextColor3 = _G_DATA.Aim and Color3.new(0,1,0) or Color3.new(1,1,1)
    FOVCircle.Visible = _G_DATA.Aim
end)

CreateButton("FLY", 100, function(b)
    _G_DATA.Fly = not _G_DATA.Fly
    b.Text = _G_DATA.Fly and "FLY: ON" or "FLY: OFF"
    b.TextColor3 = _G_DATA.Fly and Color3.new(0,1,0) or Color3.new(1,1,1)
end)

CreateButton("NOCLIP", 150, function(b)
    _G_DATA.Noclip = not _G_DATA.Noclip
    b.Text = _G_DATA.Noclip and "NOCLIP: ON" or "NOCLIP: OFF"
    b.TextColor3 = _G_DATA.Noclip and Color3.new(0,1,0) or Color3.new(1,1,1)
end)

CreateButton("ESP", 200, function(b)
    _G_DATA.Esp = not _G_DATA.Esp
    b.Text = _G_DATA.Esp and "ESP: ON" or "ESP: OFF"
    b.TextColor3 = _G_DATA.Esp and Color3.new(0,1,0) or Color3.new(1,1,1)
end)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end)

--// MANTIK DÖNGÜSÜ
local function GetTarget()
    local closest = nil
    local dist = _G_DATA.Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= LocalPlayer.Team then
            local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < dist then
                    dist = mag
                    closest = p.Character.Head
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if _G_DATA.Aim then
        local t = GetTarget()
        if t then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Position), 0.15) end
    end
    if _G_DATA.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Camera.CFrame.LookVector * _G_DATA.FlySpeed
    end
end)

RunService.Stepped:Connect(function()
    if _G_DATA.Noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)
