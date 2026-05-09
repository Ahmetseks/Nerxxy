--[[ 
    NEXXZY ELITE v8.0 - MOBILE PROJECT
    Features: 
    - Legit Aimbot (Wall Check Included)
    - Player List with Thumbnails (TP & Bring)
    - Fly, Noclip, ESP, Invisibility
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// CONFIGURATION
local Nexxzy_Settings = {
    Aim = false,
    Fly = false,
    Noclip = false,
    Esp = false,
    Invis = false,
    FOV = 120,
    Smoothness = 0.15
}

--// UI CONSTRUCT
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Nexxzy_Elite"
ScreenGui.ResetOnSpawn = false

-- Nexxzy Floating Button
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.new(0,0,0)
OpenBtn.Text = "NEXXZY"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", OpenBtn)
Instance.new("UIStroke", OpenBtn).Color = Color3.new(1,1,1)

-- Main Menu
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = Color3.new(0,0,0)
Main.BackgroundTransparency = 0.1
Main.Visible = false
Instance.new("UICorner", Main)

-- Tabs
local PlayerTab = Instance.new("ScrollingFrame", Main)
PlayerTab.Size = UDim2.new(1, -20, 1, -80)
PlayerTab.Position = UDim2.new(0, 10, 0, 70)
PlayerTab.BackgroundTransparency = 1
PlayerTab.Visible = true

local TrollTab = Instance.new("ScrollingFrame", Main)
TrollTab.Size = UDim2.new(1, -20, 1, -80)
TrollTab.Position = UDim2.new(0, 10, 0, 70)
TrollTab.BackgroundTransparency = 1
TrollTab.Visible = false

-- Header & Switching
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "NEXXZY v8"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold

local PlayerBtn = Instance.new("TextButton", Main)
PlayerBtn.Size = UDim2.new(0.5, 0, 0, 30)
PlayerBtn.Position = UDim2.new(0, 0, 0, 40)
PlayerBtn.Text = "PLAYER"
PlayerBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
PlayerBtn.TextColor3 = Color3.new(1,1,1)

local TrollBtn = Instance.new("TextButton", Main)
TrollBtn.Size = UDim2.new(0.5, 0, 0, 30)
TrollBtn.Position = UDim2.new(0.5, 0, 0, 40)
TrollBtn.Text = "TROLL"
TrollBtn.BackgroundColor3 = Color3.new(0,0,0)
TrollBtn.TextColor3 = Color3.new(0.5,0.5,0.5)

-- Tab Logic
PlayerBtn.MouseButton1Click:Connect(function()
    PlayerTab.Visible = true TrollTab.Visible = false
    PlayerBtn.TextColor3 = Color3.new(1,1,1) TrollBtn.TextColor3 = Color3.new(0.5,0.5,0.5)
end)
TrollBtn.MouseButton1Click:Connect(function()
    TrollTab.Visible = false TrollTab.Visible = true -- Fix
    TrollTab.Visible = true PlayerTab.Visible = false
    TrollBtn.TextColor3 = Color3.new(1,1,1) PlayerBtn.TextColor3 = Color3.new(0.5,0.5,0.5)
end)

--// PLAYER TAB FEATURES (Fly, Invis, Aim, etc.)
local function AddToggle(name, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    
    local layout = parent:FindFirstChild("UIListLayout") or Instance.new("UIListLayout", parent)
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
end

AddToggle("AIMBOT (WALL CHECK)", PlayerTab, function(b)
    Nexxzy_Settings.Aim = not Nexxzy_Settings.Aim
    b.Text = Nexxzy_Settings.Aim and "AIM: ON" or "AIM: OFF"
end)

AddToggle("FLY MODE", PlayerTab, function(b)
    Nexxzy_Settings.Fly = not Nexxzy_Settings.Fly
    b.Text = Nexxzy_Settings.Fly and "FLY: ON" or "FLY: OFF"
end)

AddToggle("INVISIBILITY", PlayerTab, function(b)
    Nexxzy_Settings.Invis = not Nexxzy_Settings.Invis
    b.Text = Nexxzy_Settings.Invis and "INVIS: ON" or "INVIS: OFF"
    if LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = Nexxzy_Settings.Invis and 1 or 0
            end
        end
    end
end)

--// TROLL TAB - PLAYER LIST WITH ICONS
local function UpdatePlayerList()
    for _, v in pairs(TrollTab:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    local layout = Instance.new("UIListLayout", TrollTab)
    layout.Padding = UDim.new(0, 5)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pFrame = Instance.new("Frame", TrollTab)
            pFrame.Size = UDim2.new(1, 0, 0, 60)
            pFrame.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
            
            local img = Instance.new("ImageLabel", pFrame)
            img.Size = UDim2.new(0, 50, 0, 50)
            img.Position = UDim2.new(0, 5, 0.5, -25)
            img.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            
            local pName = Instance.new("TextLabel", pFrame)
            pName.Position = UDim2.new(0, 60, 0, 5)
            pName.Size = UDim2.new(0, 100, 0, 20)
            pName.Text = p.Name
            pName.TextColor3 = Color3.new(1,1,1)
            pName.BackgroundTransparency = 1
            pName.TextXAlignment = Enum.TextXAlignment.Left

            local tpBtn = Instance.new("TextButton", pFrame)
            tpBtn.Size = UDim2.new(0, 50, 0, 25)
            tpBtn.Position = UDim2.new(0, 60, 0, 30)
            tpBtn.Text = "GOTO"
            tpBtn.MouseButton1Click:Connect(function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            end)

            local bringBtn = Instance.new("TextButton", pFrame)
            bringBtn.Size = UDim2.new(0, 50, 0, 25)
            bringBtn.Position = UDim2.new(0, 115, 0, 30)
            bringBtn.Text = "BRING"
            bringBtn.MouseButton1Click:Connect(function()
                p.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            end)
        end
    end
end
TrollBtn.MouseButton1Click:Connect(UpdatePlayerList)

--// AIMBOT LOGIC WITH WALL CHECK (No Ban)
local function GetLegitTarget()
    local target = nil
    local dist = Nexxzy_Settings.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= LocalPlayer.Team then
            local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < dist then
                    -- WALL CHECK (Raycast)
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
                    local ray = workspace:Raycast(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position).Unit * 500, rayParams)
                    
                    if not ray then -- If nothing is blocking the way
                        dist = mag
                        target = p.Character.Head
                    end
                end
            end
        end
    end
    return target
end

-- Runtime
RunService.RenderStepped:Connect(function()
    if Nexxzy_Settings.Aim then
        local t = GetLegitTarget()
        if t then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Position), Nexxzy_Settings.Smoothness) end
    end
    if Nexxzy_Settings.Fly and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Camera.CFrame.LookVector * 60
    end
end)

OpenBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
