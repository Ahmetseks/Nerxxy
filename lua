--[[ 
    NEXXZY ELITE v11.1 - ULTIMATE TROLL & FIX
    Customized for: Umut
    -------------------------------------------
    - SMOOTH CFRAME FLY: No more freezing (WASD/Mobile)
    - STICKY AIMBOT: Better focus & tracking
    - SMART TROLL PANEL: Expandable profiles with Animations
    - NO GHOST: Removed for stability
    -------------------------------------------
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Nexxzy = {
    Aim = false, Fly = false, FlySpeed = 2,
    FOV = 180, Smooth = 0.25, SelectedPlayer = nil
}

--// IMPROVED CFRAME FLY (CARPET STYLE)
local function StartFly()
    task.spawn(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        char.Humanoid.PlatformStand = true
        
        while Nexxzy.Fly do
            local moveDir = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end
            
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (moveDir * Nexxzy.FlySpeed)
            char.HumanoidRootPart.Velocity = Vector3.new(0, 0.1, 0)
            RunService.RenderStepped:Wait()
        end
        char.Humanoid.PlatformStand = false
    end)
end

--// UI CORE SETUP
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Nexxzy_v11_1"
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

-- Tabs
local PlayerPage = Instance.new("ScrollingFrame", MainFrame)
PlayerPage.Size = UDim2.new(1, -20, 1, -100)
PlayerPage.Position = UDim2.new(0, 10, 0, 90)
PlayerPage.BackgroundTransparency = 1
Instance.new("UIListLayout", PlayerPage).Padding = UDim.new(0, 5)

local TrollPage = Instance.new("ScrollingFrame", MainFrame)
TrollPage.Size = UDim2.new(1, -20, 1, -100)
TrollPage.Position = UDim2.new(0, 10, 0, 90)
TrollPage.BackgroundTransparency = 1
TrollPage.Visible = false
Instance.new("UIListLayout", TrollPage).Padding = UDim.new(0, 5)

--// SMART TROLL PANEL (Expandable UI)
local ProfilePanel = Instance.new("Frame", TrollPage)
ProfilePanel.Size = UDim2.new(1, 0, 0, 180) -- Larger for animations
ProfilePanel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ProfilePanel.Visible = false
Instance.new("UICorner", ProfilePanel)

local UserImg = Instance.new("ImageLabel", ProfilePanel)
UserImg.Size = UDim2.new(0, 50, 0, 50)
UserImg.Position = UDim2.new(0, 10, 0, 10)
Instance.new("UICorner", UserImg).CornerRadius = UDim.new(1,0)

local UserName = Instance.new("TextLabel", ProfilePanel)
UserName.Size = UDim2.new(0, 200, 0, 20)
UserName.Position = UDim2.new(0, 70, 0, 25)
UserName.TextColor3 = Color3.new(1,1,1)
UserName.TextXAlignment = Enum.TextXAlignment.Left
UserName.BackgroundTransparency = 1

local ActionGrid = Instance.new("Frame", ProfilePanel)
ActionGrid.Size = UDim2.new(1, -20, 0, 100)
ActionGrid.Position = UDim2.new(0, 10, 0, 70)
ActionGrid.BackgroundTransparency = 1
local grid = Instance.new("UIGridLayout", ActionGrid)
grid.CellSize = UDim2.new(0, 135, 0, 30)

local function CreateAction(txt, func)
    local b = Instance.new("TextButton", ActionGrid)
    b.Text = txt
    b.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- Troll Buttons
CreateAction("TELEPORT", function()
    if Nexxzy.SelectedPlayer and Nexxzy.SelectedPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = Nexxzy.SelectedPlayer.Character.HumanoidRootPart.CFrame
    end
end)

CreateAction("BRING", function()
    if Nexxzy.SelectedPlayer and Nexxzy.SelectedPlayer.Character then
        Nexxzy.SelectedPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

CreateAction("CRAWL (ANIM)", function() 
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://282574440"
    hum:LoadAnimation(anim):Play()
end)

CreateAction("GLITCH (ANIM)", function() 
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://35154961"
    hum:LoadAnimation(anim):Play()
end)

--// LIST LOGIC
local function RefreshTroll()
    for _, v in pairs(TrollPage:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", TrollPage)
            b.Size = UDim2.new(1, 0, 0, 35)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
            b.TextColor3 = Color3.new(1,1,1)
            b.MouseButton1Click:Connect(function()
                Nexxzy.SelectedPlayer = p
                UserName.Text = p.DisplayName or p.Name
                UserImg.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                ProfilePanel.Visible = true
            end)
        end
    end
end

--// PLAYER TAB FEATURES
local function AddToggle(txt, parent, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.Text = txt .. ": OFF"
    b.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

AddToggle("AIMBOT", PlayerPage, function(b)
    Nexxzy.Aim = not Nexxzy.Aim
    b.Text = Nexxzy.Aim and "AIMBOT: ON" or "AIMBOT: OFF"
end)

AddToggle("FLY (CARPET)", PlayerPage, function(b)
    Nexxzy.Fly = not Nexxzy.Fly
    b.Text = Nexxzy.Fly and "FLY: ON" or "FLY: OFF"
    if Nexxzy.Fly then StartFly() end
end)

--// STICKY AIMBOT LOGIC
RunService.RenderStepped:Connect(function()
    if Nexxzy.Aim then
        local target = nil
        local dist = Nexxzy.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= LocalPlayer.Team then
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

-- Navigation Buttons
local PlayerBtn = Instance.new("TextButton", MainFrame)
PlayerBtn.Size = UDim2.new(0.5, 0, 0, 40)
PlayerBtn.Position = UDim2.new(0, 0, 0, 40)
PlayerBtn.Text = "PLAYER"
PlayerBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerBtn.TextColor3 = Color3.new(1,1,1)

local TrollBtn = Instance.new("TextButton", MainFrame)
TrollBtn.Size = UDim2.new(0.5, 0, 0, 40)
TrollBtn.Position = UDim2.new(0.5, 0, 0, 40)
TrollBtn.Text = "TROLL"
TrollBtn.BackgroundColor3 = Color3.new(0, 0, 0)
TrollBtn.TextColor3 = Color3.new(0.5, 0.5, 0.5)

PlayerBtn.MouseButton1Click:Connect(function()
    PlayerPage.Visible = true; TrollPage.Visible = false
    PlayerBtn.TextColor3 = Color3.new(1,1,1); TrollBtn.TextColor3 = Color3.new(0.5,0.5,0.5)
end)

TrollBtn.MouseButton1Click:Connect(function()
    TrollPage.Visible = true; PlayerPage.Visible = false
    TrollBtn.TextColor3 = Color3.new(1,1,1); PlayerBtn.TextColor3 = Color3.new(0.5,0.5,0.5)
    RefreshTroll()
end)

MainToggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
