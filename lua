--[[ 
    T-90MMS ELITE SYSTEM v3.0 (ULTIMATE EDITION)
    -------------------------------------------
    [K] - AIM ASSIST (Head-Lock & Smooth Lerp)
    [N] - NOCLIP (Physics Bypass)
    [L] - ADVANCED ESP (Box, Name, Health)
    -------------------------------------------
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// SYSTEM STATES
local _G_DATA = {
    AimActive = false,
    NoclipActive = false,
    EspActive = false,
    MaksDist = 750,
    Smoothing = 0.25 -- Ne kadar düşükse o kadar pürüzsüz
}

--// UI CONSTRUCT (NOIR THEME)
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "T90_Elite_v3"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 160)
MainFrame.Position = UDim2.new(0.02, 0, 0.7, 0)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local UIList = Instance.new("UIListLayout", MainFrame)
UIList.Padding = UDim.new(0, 5)
UIList.VerticalAlignment = Enum.VerticalAlignment.Center
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateStatus(key, label)
    local txt = Instance.new("TextLabel", MainFrame)
    txt.Size = UDim2.new(0.9, 0, 0, 40)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.Code
    txt.Text = string.format("[%s] %s: OFF", key, label)
    txt.TextColor3 = Color3.new(0.4, 0.4, 0.4)
    txt.TextSize = 15
    txt.TextXAlignment = Enum.TextXAlignment.Left
    return txt
end

local AimStatus = CreateStatus("K", "AIM ASSIST")
local NoclipStatus = CreateStatus("N", "NOCLIP")
local EspStatus = CreateStatus("L", "ESP SYSTEM")

--// ESP ENGINE
local ESP_Objects = {}

local function BuildESP(player)
    if player == LocalPlayer then return end
    
    local function Setup(char)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        local head = char:WaitForChild("Head", 10)
        local hum = char:WaitForChild("Humanoid", 10)
        if not root or not head or not hum then return end

        -- Box
        local bBox = Instance.new("BillboardGui", root)
        bBox.AlwaysOnTop = true
        bBox.Size = UDim2.new(4, 0, 5.5, 0)
        bBox.Enabled = _G_DATA.EspActive
        
        local frame = Instance.new("Frame", bBox)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 1
        frame.BorderColor3 = Color3.new(1, 1, 1)

        -- Info
        local bInfo = Instance.new("BillboardGui", head)
        bInfo.AlwaysOnTop = true
        bInfo.Size = UDim2.new(0, 200, 0, 50)
        bInfo.ExtentsOffset = Vector3.new(0, 3, 0)
        bInfo.Enabled = _G_DATA.EspActive
        
        local label = Instance.new("TextLabel", bInfo)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextStrokeTransparency = 0.5

        ESP_Objects[player.Name] = {Box = bBox, Info = bInfo, Label = label, Hum = hum}
    end

    player.CharacterAdded:Connect(Setup)
    if player.Character then Setup(player.Character) end
end

--// CORE LOGIC
local function GetBestTarget()
    local target = nil
    local dist = _G_DATA.MaksDist
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if onScreen then
                local mag = (p.Character.Head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if mag < dist then
                    -- Raycast check
                    local rp = RaycastParams.new()
                    rp.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
                    local res = workspace:Raycast(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position).Unit * mag, rp)
                    
                    if not res then
                        dist = mag
                        target = p.Character.Head
                    end
                end
            end
        end
    end
    return target
end

--// INPUT & TOGGLES
UIS.InputBegan:Connect(function(io, gpe)
    if gpe then return end
    
    if io.KeyCode == _G_DATA.AimTusu or io.KeyCode == Enum.KeyCode.K then
        _G_DATA.AimActive = not _G_DATA.AimActive
        AimStatus.Text = _G_DATA.AimActive and "[K] AIM ASSIST: ON" or "[K] AIM ASSIST: OFF"
        AimStatus.TextColor3 = _G_DATA.AimActive and Color3.new(1,1,1) or Color3.new(0.4,0.4,0.4)
    
    elseif io.KeyCode == Enum.KeyCode.N then
        _G_DATA.NoclipActive = not _G_DATA.NoclipActive
        NoclipStatus.Text = _G_DATA.NoclipActive and "[N] NOCLIP: ON" or "[N] NOCLIP: OFF"
        NoclipStatus.TextColor3 = _G_DATA.NoclipActive and Color3.new(1,1,1) or Color3.new(0.4,0.4,0.4)

    elseif io.KeyCode == Enum.KeyCode.L then
        _G_DATA.EspActive = not _G_DATA.EspActive
        EspStatus.Text = _G_DATA.EspActive and "[L] ESP SYSTEM: ON" or "[L] ESP SYSTEM: OFF"
        EspStatus.TextColor3 = _G_DATA.EspActive and Color3.new(1,1,1) or Color3.new(0.4,0.4,0.4)
        for _, obj in pairs(ESP_Objects) do
            obj.Box.Enabled = _G_DATA.EspActive
            obj.Info.Enabled = _G_DATA.EspActive
        end
    end
end)

--// MAIN RUNTIME
for _, p in pairs(Players:GetPlayers()) do BuildESP(p) end
Players.PlayerAdded:Connect(BuildESP)

RunService.RenderStepped:Connect(function()
    -- Aim Assist
    if _G_DATA.AimActive then
        local target = GetBestTarget()
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), _G_DATA.Smoothing)
        end
    end

    -- ESP Refresh
    if _G_DATA.EspActive then
        for name, obj in pairs(ESP_Objects) do
            if obj.Hum and obj.Label then
                obj.Label.Text = string.format("%s\n[%d HP]", name, math.floor(obj.Hum.Health))
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if _G_DATA.NoclipActive and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

