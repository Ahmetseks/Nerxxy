--[[ 
    NEXXZY ULTIMATE v10.2 - STABLE GLOBAL
    Customized for: Umut
    -------------------------------------------
    - LEGIT AIMBOT: Raycast Wall-Check
    - GHOST INVIS: Server-side Desync
    - TROLL MASTER: FE Fling & Dynamic List
    - LANGUAGE: English for Maximum Compatibility
    -------------------------------------------
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Nexxzy_Settings = {
    Aim = false, Fly = false, Ghost = false,
    FOV = 135, Smooth = 0.15, FlySpeed = 70
}

--// GHOST MODE LOGIC (Server-Side Invisibility Attempt)
local function ToggleGhost(state)
    Nexxzy_Settings.Ghost = state
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        task.spawn(function()
            while Nexxzy_Settings.Ghost do
                -- Rapidly desyncs position to make you hard to hit/see for others
                local oldV = char.HumanoidRootPart.Velocity
                char.HumanoidRootPart.Velocity = Vector3.new(0, 5000, 0)
                RunService.Heartbeat:Wait()
                char.HumanoidRootPart.Velocity = oldV
                task.wait(0.1)
            end
        end)
    end
end

--// POWERFUL FE FLING
local function FlingPlayer(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local thrp = target.Character.HumanoidRootPart
        local oldPos = hrp.CFrame
        
        local bva = Instance.new("BodyAngularVelocity", hrp)
        bva.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bva.AngularVelocity = Vector3.new(0, 99999, 0)
        
        local start = tick()
        while tick() - start < 1.8 do
            RunService.Heartbeat:Wait()
            hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 0.2)
            hrp.Velocity = Vector3.new(4500, 4500, 4500)
        end
        
        bva:Destroy()
        hrp.Velocity = Vector3.new(0,0,0)
        hrp.CFrame = oldPos
    end
end

--// UI CONSTRUCTION (Global Standard)
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Nexxzy_v10_2"
ScreenGui.ResetOnSpawn = false

local MainToggle = Instance.new("TextButton", ScreenGui)
MainToggle.Size = UDim2.new(0, 90, 0, 45)
MainToggle.Position = UDim2.new(0.02, 0, 0.45, 0)
MainToggle.Text = "NEXXZY"
MainToggle.BackgroundColor3 = Color3.new(0,0,0)
MainToggle.TextColor3 = Color3.new(1,1,1)
MainToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", MainToggle)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.new(0,0,0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Tab Headers
local PlayerTabBtn = Instance.new("TextButton", MainFrame)
PlayerTabBtn.Size = UDim2.new(0.5, 0, 0, 40)
PlayerTabBtn.Position = UDim2.new(0, 0, 0, 40)
PlayerTabBtn.Text = "PLAYER"
PlayerTabBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerTabBtn.TextColor3 = Color3.new(1, 1, 1)

local TrollTabBtn = Instance.new("TextButton", MainFrame)
TrollTabBtn.Size = UDim2.new(0.5, 0, 0, 40)
TrollTabBtn.Position = UDim2.new(0.5, 0, 0, 40)
TrollTabBtn.Text = "TROLL"
TrollTabBtn.BackgroundColor3 = Color3.new(0, 0, 0)
TrollTabBtn.TextColor3 = Color3.new(0.6, 0.6, 0.6)

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

--// BUTTON GENERATOR
local function CreateBtn(text, parent, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

--// PLAYER FEATURES
CreateBtn("AIMBOT: OFF", PlayerPage, function(b)
    Nexxzy_Settings.Aim = not Nexxzy_Settings.Aim
    b.Text = Nexxzy_Settings.Aim and "AIMBOT: ON" or "AIMBOT: OFF"
end)

CreateBtn("FLY MODE: OFF", PlayerPage, function(b)
    Nexxzy_Settings.Fly = not Nexxzy_Settings.Fly
    b.Text = Nexxzy_Settings.Fly and "FLY MODE: ON" or "FLY MODE: OFF"
end)

CreateBtn("GHOST INVIS (FE)", PlayerPage, function(b)
    Nexxzy_Settings.Ghost = not Nexxzy_Settings.Ghost
    b.Text = Nexxzy_Settings.Ghost and "GHOST: ON" or "GHOST: OFF"
    ToggleGhost(Nexxzy_Settings.Ghost)
end)

--// TROLL PAGE (Dynamic List)
local function RefreshTrollList()
    for _, v in pairs(TrollPage:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local f = Instance.new("Frame", TrollPage)
            f.Size = UDim2.new(1, 0, 0, 65)
            f.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
            Instance.new("UICorner", f)
            
            local img = Instance.new("ImageLabel", f)
            img.Size = UDim2.new(0, 50, 0, 50)
            img.Position = UDim2.new(0, 5, 0.5, -25)
            img.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            Instance.new("UICorner", img).CornerRadius = UDim.new(1,0)

            local gotoB = Instance.new("TextButton", f)
            gotoB.Size = UDim2.new(0, 60, 0, 25)
            gotoB.Position = UDim2.new(0, 65, 0.5, 2)
            gotoB.Text = "GOTO"
            gotoB.MouseButton1Click:Connect(function() LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end)

            local flingB = Instance.new("TextButton", f)
            flingB.Size = UDim2.new(0, 60, 0, 25)
            flingB.Position = UDim2.new(0, 130, 0.5, 2)
            flingB.Text = "FLING"
            flingB.BackgroundColor3 = Color3.new(0.4, 0, 0)
            flingB.MouseButton1Click:Connect(function() FlingPlayer(p) end)
        end
    end
end

-- Tab Switching
PlayerTabBtn.MouseButton1Click:Connect(function()
    PlayerPage.Visible = true; TrollPage.Visible = false
    PlayerTabBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1); TrollTabBtn.BackgroundColor3 = Color3.new(0,0,0)
end)
TrollTabBtn.MouseButton1Click:Connect(function()
    TrollPage.Visible = true; PlayerPage.Visible = false
    TrollTabBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1); PlayerTabBtn.BackgroundColor3 = Color3.new(0,0,0)
    RefreshTrollList()
end)

--// RUNTIME ENGINE (AIM & FLY)
local function GetTarget()
    local target, dist = nil, Nexxzy_Settings.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < dist then
                    local params = RaycastParams.new()
                    params.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
                    if not workspace:Raycast(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position).Unit * 500, params) then
                        dist = mag
                        target = p.Character.Head
                    end
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if Nexxzy_Settings.Aim then
        local t = GetTarget()
        if t then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Position), Nexxzy_Settings.Smooth) end
    end
    if Nexxzy_Settings.Fly and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Camera.CFrame.LookVector * Nexxzy_Settings.FlySpeed
    end
end)

MainToggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
