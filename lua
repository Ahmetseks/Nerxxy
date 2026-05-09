--[[ 
    T-90MMS ELITE V7 (GLOBAL MOBILE VERSION)
    - Full English Interface for 100% Compatibility
    - Enhanced Highlight ESP
    - Team-Check Aimbot (FOV Based)
    - Smooth Fly & Noclip
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// SYSTEM SETTINGS
local T90_Config = {
    AimActive = false,
    FlyActive = false,
    NoclipActive = false,
    EspActive = false,
    
    FOV_Radius = 140,
    FlySpeed = 60,
    AimSmoothing = 0.18 -- Lower = Smoother
}

--// UI GENERATION (Noir Aesthetic)
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "T90_Global_Pro"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Floating Open Button
local MenuBtn = Instance.new("TextButton", ScreenGui)
MenuBtn.Size = UDim2.new(0, 65, 0, 65)
MenuBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
MenuBtn.BackgroundColor3 = Color3.new(0, 0, 0)
MenuBtn.Text = "T90"
MenuBtn.TextColor3 = Color3.new(1, 1, 1)
MenuBtn.Font = Enum.Font.GothamBold
MenuBtn.TextSize = 18
Instance.new("UICorner", MenuBtn).CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke", MenuBtn)
Stroke.Color = Color3.new(1, 1, 1)
Stroke.Thickness = 2

-- Main Dashboard
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Drag Area
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "T-90MMS GLOBAL v7"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15

local ExitBtn = Instance.new("TextButton", MainFrame)
ExitBtn.Size = UDim2.new(0, 35, 0, 35)
ExitBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
ExitBtn.Text = "X"
ExitBtn.BackgroundColor3 = Color3.new(1, 1, 1)
ExitBtn.TextColor3 = Color3.new(0, 0, 0)
Instance.new("UICorner", ExitBtn)

-- FOV Circle Visual
local FOVFrame = Instance.new("Frame", ScreenGui)
FOVFrame.Size = UDim2.new(0, T90_Config.FOV_Radius * 2, 0, T90_Config.FOV_Radius * 2)
FOVFrame.Position = UDim2.new(0.5, -T90_Config.FOV_Radius, 0.5, -T90_Config.FOV_Radius)
FOVFrame.BackgroundTransparency = 1
FOVFrame.Visible = false
local Circle = Instance.new("UICorner", FOVFrame)
Circle.CornerRadius = UDim.new(1, 0)
local CircleStroke = Instance.new("UIStroke", FOVFrame)
CircleStroke.Color = Color3.new(1, 1, 1)
CircleStroke.Thickness = 1

--// MOBILE DRAG LOGIC
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

--// COMPONENT BUILDER
local function NewButton(text, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Position = UDim2.new(0.075, 0, 0, pos)
    btn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text .. ": OFF"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
end

--// FEATURE CONTROLS
NewButton("AIM ASSIST", 60, function(b)
    T90_Config.AimActive = not T90_Config.AimActive
    b.Text = T90_Config.AimActive and "AIM ASSIST: ON" or "AIM ASSIST: OFF"
    b.BackgroundColor3 = T90_Config.AimActive and Color3.new(1,1,1) or Color3.new(0.1,0.1,0.1)
    b.TextColor3 = T90_Config.AimActive and Color3.new(0,0,0) or Color3.new(1,1,1)
    FOVFrame.Visible = T90_Config.AimActive
end)

NewButton("FLIGHT MODE", 120, function(b)
    T90_Config.FlyActive = not T90_Config.FlyActive
    b.Text = T90_Config.FlyActive and "FLIGHT: ON" or "FLIGHT: OFF"
end)

NewButton("NOCLIP", 180, function(b)
    T90_Config.NoclipActive = not T90_Config.NoclipActive
    b.Text = T90_Config.NoclipActive and "NOCLIP: ON" or "NOCLIP: OFF"
end)

NewButton("ULTRA ESP", 240, function(b)
    T90_Config.EspActive = not T90_Config.EspActive
    b.Text = T90_Config.EspActive and "ESP: ON" or "ESP: OFF"
end)

MenuBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true MenuBtn.Visible = false end)
ExitBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false MenuBtn.Visible = true end)

--// LOGIC ENGINES
local function GetBestEnemy()
    local target = nil
    local shortestDist = T90_Config.FOV_Radius
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            -- Team Check (English Logic)
            if player.Team ~= LocalPlayer.Team or player.Team == nil then
                local point, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
                if onScreen then
                    local magnitude = (Vector2.new(point.X, point.Y) - center).Magnitude
                    if magnitude < shortestDist then
                        shortestDist = magnitude
                        target = player.Character.Head
                    end
                end
            end
        end
    end
    return target
end

--// RUNTIME LOOPS
RunService.RenderStepped:Connect(function()
    -- Aim Engine
    if T90_Config.AimActive then
        local lockOn = GetBestEnemy()
        if lockOn then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, lockOn.Position), T90_Config.AimSmoothing)
        end
    end

    -- Fly Engine
    if T90_Config.FlyActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Camera.CFrame.LookVector * T90_Config.FlySpeed
    end

    -- ESP Engine (Modern Highlight)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("T90_ESP")
            if T90_Config.EspActive and (p.Team ~= LocalPlayer.Team) then
                if not highlight then
                    highlight = Instance.new("Highlight", p.Character)
                    highlight.Name = "T90_ESP"
                    highlight.FillColor = Color3.new(1, 1, 1)
                    highlight.OutlineColor = Color3.new(0, 0, 0)
                    highlight.FillTransparency = 0.5
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if T90_Config.NoclipActive and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)
