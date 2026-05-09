-- =============================================
-- Nexxzy034 Hub v1.5
-- Mobile Friendly + Minimize + Troll Section
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
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

-- Config
local function SaveConfig() getgenv().Nexxzy034_Config = Settings; print("✅ Saved") end
local function LoadConfig()
    if getgenv().Nexxzy034_Config then Settings = getgenv().Nexxzy034_Config; print("✅ Loaded") end
end
LoadConfig()

-- ================== GUI (Önceki versiyonla aynı) ==================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Nexxzy034Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.92, 0, 0.82, 0)
MainFrame.Position = UDim2.new(0.04, 0, 0.09, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 65)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Nexxzy034 Hub"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Minimize & Close (önceki gibi)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 50, 0, 50)
MinimizeBtn.Position = UDim2.new(1, -55, 0, 8)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
MinimizeBtn.Text = "−"
MinimizeBtn.TextScaled = true
MinimizeBtn.Parent = MainFrame

local MiniIndicator = Instance.new("TextButton")
MiniIndicator.Size = UDim2.new(0, 70, 0, 70)
MiniIndicator.Position = UDim2.new(0, 20, 0.5, -35)
MiniIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
MiniIndicator.Text = "N"
MiniIndicator.TextScaled = true
MiniIndicator.Visible = false
MiniIndicator.Parent = ScreenGui

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 50, 0, 50)
CloseBtn.Position = UDim2.new(1, -110, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextScaled = true
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Minimize Logic
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
    MiniIndicator.Visible = isMinimized
end)
MiniIndicator.MouseButton1Click:Connect(function()
    isMinimized = false
    MainFrame.Visible = true
    MiniIndicator.Visible = false
end)

-- ================== TAB SYSTEM ==================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 70)
TabBar.Position = UDim2.new(0, 0, 0, 65)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabBar.Parent = MainFrame

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, 0, 1, -135)
Content.Position = UDim2.new(0, 0, 0, 135)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 10
Content.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 10)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = Content

-- Tablar
local TrollTab = Instance.new("Frame")
TrollTab.Size = UDim2.new(1,0,1,0)
TrollTab.BackgroundTransparency = 1
TrollTab.Visible = true
TrollTab.Parent = Content

-- Diğer tablar istersen ekleriz

-- Tab butonları (basit)
local TrollTabBtn = Instance.new("TextButton")
TrollTabBtn.Size = UDim2.new(0.25,0,1,0)
TrollTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
TrollTabBtn.Text = "Troll"
TrollTabBtn.TextScaled = true
TrollTabBtn.Parent = TabBar

-- ================== TROLL BÖLÜMÜ - 7DAY7 ==================
local function AddTrollButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 70)
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = TrollTab
    btn.MouseButton1Click:Connect(callback)
end

-- 7Day7 Animasyon Toggle
AddTrollButton("7Day7 Troll Animations [ON/OFF]", function()
    Settings.Troll.SevenDay7_Enabled = not Settings.Troll.SevenDay7_Enabled
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    
    local humanoid = character.Humanoid
    
    if Settings.Troll.SevenDay7_Enabled then
        -- 7Day7 tarzı troll yürüyüş + idle (popüler troll anim ID'leri)
        -- Gerçek ID'leri buraya koy (senin bildiğin ID'leri yazabilirsin)
        print("🟣 7Day7 Troll Animations AKTİF")
        
        -- Örnek: Yürüyüş animasyonu değiştir
        pcall(function()
            humanoid:LoadAnimation(game:GetObjects("rbxassetid://PASTE_WALK_ID_HERE")[1]):Play() -- Buraya gerçek ID koy
        end)
    else
        print("🔴 7Day7 Troll Animations KAPALI")
        -- Normal animasyona dön (reset)
        humanoid:LoadAnimation(game:GetObjects("rbxassetid://0")[1]) -- Default
    end
end)

AddTrollButton("Reset All Animations", function()
    Settings.Troll.SevenDay7_Enabled = false
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid:LoadAnimation(game:GetObjects("rbxassetid://0")[1]) -- Reset
    end
    print("Animations Reset")
end)

print("🚀 Nexxzy034 Hub v1.5 Yüklendi!")
print("Troll sekmesine girdin → 7Day7 butonu var")
