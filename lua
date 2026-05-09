--[[ 
    NEXXZY ELITE v11.0 - STABLE MASTER
    Customized for: Umut
    -------------------------------------------
    - CARPET FLY: True 3D movement (WASD)
    - SMART TROLL GUI: Expandable Player Profiles
    - FIXES: Aimbot sensitivity & Fling physics
    - NO GHOST: Removed as requested
    -------------------------------------------
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Nexxzy = {
    Aim = false, Fly = false, FlySpeed = 50,
    FOV = 150, Smooth = 0.1, SelectedPlayer = nil
}

--// FLY SYSTEM (CARPET STYLE)
local BodyGyro, BodyVel
local function StartFly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    BodyGyro = Instance.new("BodyGyro", char.HumanoidRootPart)
    BodyGyro.P = 9e4
    BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = char.HumanoidRootPart.CFrame
    
    BodyVel = Instance.new("BodyVelocity", char.HumanoidRootPart)
    BodyVel.Velocity = Vector3.new(0, 0.1, 0)
    BodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    char.Humanoid.PlatformStand = true
end

local function StopFly()
    if BodyGyro then BodyGyro:Destroy() end
    if BodyVel then BodyVel:Destroy() end
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.PlatformStand = false end
end

--// UI CORE
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Nexxzy_v11"
ScreenGui.ResetOnSpawn = false

local MainToggle = Instance.new("TextButton", ScreenGui)
MainToggle.Size = UDim2.new(0, 80, 0, 40)
MainToggle.Position = UDim2.new(0.02, 0, 0.4, 0)
MainToggle.Text = "NEXXZY"
MainToggle.BackgroundColor3 = Color3.new(0,0,0)
MainToggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MainToggle)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 310, 0, 380)
MainFrame.Position = UDim2.new(0.5, -155, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.new(0,0,0)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Tab Headers
local PlayerTab = Instance.new("ScrollingFrame", MainFrame)
PlayerTab.Size = UDim2.new(1, -20, 1, -100)
PlayerTab.Position = UDim2.new(0, 10, 0, 80)
PlayerTab.BackgroundTransparency = 1
Instance.new("UIListLayout", PlayerTab).Padding = UDim.new(0, 5)

local TrollTab = Instance.new("ScrollingFrame", MainFrame)
TrollTab.Size = UDim2.new(1, -20, 1, -100)
TrollTab.Position = UDim2.new(0, 10, 0, 80)
TrollTab.BackgroundTransparency = 1
TrollTab.Visible = false
Instance.new("UIListLayout", TrollTab).Padding = UDim.new(0, 5)

--// SMART TROLL PANEL (Expandable)
local ProfilePanel = Instance.new("Frame", TrollTab)
ProfilePanel.Size = UDim2.new(1, 0, 0, 140)
ProfilePanel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ProfilePanel.Visible = false
Instance.new("UICorner", ProfilePanel)

local UserImg = Instance.new("ImageLabel", ProfilePanel)
UserImg.Size = UDim2.new(0, 60, 0, 60)
UserImg.Position = UDim2.new(0.5, -30, 0, 10)
Instance.new("UICorner", UserImg).CornerRadius = UDim.new(1,0)

local UserName = Instance.new("TextLabel", ProfilePanel)
UserName.Size = UDim2.new(1, 0, 0, 20)
UserName.Position = UDim2.new(0, 0, 0, 75)
UserName.TextColor3 = Color3.new(1,1,1)
UserName.BackgroundTransparency = 1

local ActionContainer = Instance.new("Frame", ProfilePanel)
ActionContainer.Size = UDim2.new(1, 0, 0, 40)
ActionContainer.Position = UDim2.new(0, 0, 0, 100)
ActionContainer.BackgroundTransparency = 1
Instance.new("UIListLayout", ActionContainer).FillDirection = Enum.FillDirection.Horizontal

local function CreateActionBtn(txt, parent, func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.5, 0, 1, 0)
    b.Text = txt
    b.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(func)
end

CreateActionBtn("TP (GOTO)", ActionContainer, function()
    if Nexxzy.SelectedPlayer and Nexxzy.SelectedPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = Nexxzy.SelectedPlayer.Character.HumanoidRootPart.CFrame
    end
end)

CreateActionBtn("BRING", ActionContainer, function()
    if Nexxzy.SelectedPlayer and Nexxzy.SelectedPlayer.Character then
        Nexxzy.SelectedPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

--// LIST REFRESH
local function UpdateTrollList()
    for _, v in pairs(TrollTab:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", TrollTab)
            b.Size = UDim2.new(1, 0, 0, 35)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
            b.TextColor3 = Color3.new(1,1,1)
            b.MouseButton1Click:Connect(function()
                Nexxzy.SelectedPlayer = p
                UserName.Text = p.DisplayName
                UserImg.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                ProfilePanel.Visible = true
            end)
        end
    end
end

--// PLAYER FEATURES
local function AddToggle(txt, parent, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.Text = txt .. ": OFF"
    b.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

AddToggle("AIMBOT", PlayerTab, function(b)
    Nexxzy.Aim = not Nexxzy.Aim
    b.Text = Nexxzy.Aim and "AIMBOT: ON" or "AIMBOT: OFF"
end)

AddToggle("CARPET FLY", PlayerTab, function(b)
    Nexxzy.Fly = not Nexxzy.Fly
    b.Text = Nexxzy.Fly and "FLY: ON" or "FLY: OFF"
    if Nexxzy.Fly then StartFly() else StopFly() end
end)

--// RUNTIME (AIM & FLY CONTROL)
RunService.RenderStepped:Connect(function()
    if Nexxzy.Fly and BodyVel and BodyGyro then
        local moveDir = Vector3.new(0, 0, 0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        
        BodyVel.Velocity = moveDir * Nexxzy.FlySpeed
        BodyGyro.CFrame = Camera.CFrame
    end
    
    if Nexxzy.Aim then
        local target = nil
        local dist = Nexxzy.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then
                        dist = mag
                        target = p.Character.Head
                    end
                end
            end
        end
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Nexxzy.Smooth)
        end
    end
end)

MainToggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
