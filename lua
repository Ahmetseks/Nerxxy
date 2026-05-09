-- =============================================
-- Nexxzy034 Hub v2.1 - Chilli Hub Style
-- Key System + Modern UI
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- ================== KEY SYSTEM ==================
local KeyVerified = false

local function CopyKeyLink()
    setclipboard("https://robloxscriptss.duckdns.org/key")
    StarterGui:SetCore("SendNotification", {
        Title = "✅ Get Key",
        Text = "Link kopyalandı! Tarayıcıya yapıştır.",
        Duration = 5
    })
end

local function CheckKey(key)
    if not key or #key < 6 then return false end
    return true
end

-- ================== KEY SCREEN (Chilli Style) ==================
local KeyGui = Instance.new("ScreenGui")
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 480, 0, 320)
KeyFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyFrame.Parent = KeyGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 16)
local Stroke = Instance.new("UIStroke", KeyFrame)
Stroke.Color = Color3.fromRGB(0, 255, 180)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 80)
Title.BackgroundTransparency = 1
Title.Text = "Nexxzy034"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = KeyFrame

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 55)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0, 100)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
GetKeyBtn.Text = "🔗 GET KEY"
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
GetKeyBtn.TextScaled = true
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyFrame
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 12)

GetKeyBtn.MouseButton1Click:Connect(CopyKeyLink)

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 55)
KeyBox.Position = UDim2.new(0.1, 0, 0, 170)
KeyBox.PlaceholderText = "Keyinizi buraya yapıştır..."
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.TextScaled = true
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyFrame
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 12)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 60)
VerifyBtn.Position = UDim2.new(0.1, 0, 0, 240)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
VerifyBtn.Text = "VERIFY KEY"
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.TextScaled = true
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = KeyFrame
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 12)

-- ================== VERIFY & HUB LOAD ==================
VerifyBtn.MouseButton1Click:Connect(function()
    if CheckKey(KeyBox.Text) then
        VerifyBtn.Text = "✅ SUCCESS"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        
        task.wait(1)
        KeyGui:Destroy()

        -- ================== CHILLI STYLE HUB ==================
        local HubGui = Instance.new("ScreenGui")
        HubGui.ResetOnSpawn = false
        HubGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0.85, 0, 0.75, 0)
        MainFrame.Position = UDim2.new(0.075, 0, 0.125, 0)
        MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = HubGui

        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
        local HubStroke = Instance.new("UIStroke", MainFrame)
        HubStroke.Color = Color3.fromRGB(0, 255, 180)
        HubStroke.Thickness = 1.5

        local HubTitle = Instance.new("TextLabel")
        HubTitle.Size = UDim2.new(1, 0, 0, 65)
        HubTitle.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        HubTitle.Text = "Nexxzy034 Hub"
        HubTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
        HubTitle.TextScaled = true
        HubTitle.Font = Enum.Font.GothamBold
        HubTitle.Parent = MainFrame
        Instance.new("UICorner", HubTitle).CornerRadius = UDim.new(0, 16)

        -- Scrolling + Toggle'lar
        local Scrolling = Instance.new("ScrollingFrame")
        Scrolling.Size = UDim2.new(1, -30, 1, -85)
        Scrolling.Position = UDim2.new(0, 15, 0, 75)
        Scrolling.BackgroundTransparency = 1
        Scrolling.ScrollBarThickness = 6
        Scrolling.Parent = MainFrame

        local Layout = Instance.new("UIListLayout")
        Layout.Padding = UDim.new(0, 12)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Parent = Scrolling

        local function AddToggle(text, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 65)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ToggleFrame.Parent = Scrolling
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 12)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.7, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.new(1,1,1)
            Label.TextScaled = true
            Label.Font = Enum.Font.GothamSemibold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = UDim2.new(0, 20, 0, 0)
            Label.Parent = ToggleFrame

            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 110, 0, 45)
            Button.Position = UDim2.new(1, -130, 0.5, -22.5)
            Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Button.Text = "OFF"
            Button.TextColor3 = Color3.new(1,1,1)
            Button.TextScaled = true
            Button.Font = Enum.Font.GothamBold
            Button.Parent = ToggleFrame
            Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 12)

            local enabled = false
            Button.MouseButton1Click:Connect(function()
                enabled = not enabled
                Button.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(80, 80, 80)
                Button.Text = enabled and "ON" or "OFF"
                callback(enabled)
            end)
        end

        -- Özellikler
        AddToggle("ESP Toggle", function(v) print("ESP:", v) end)
        AddToggle("Aimbot", function(v) print("Aimbot:", v) end)
        AddToggle("Fly (F Key)", function(v) print("Fly:", v) end)
        AddToggle("God Mode", function(v) print("God Mode:", v) end)
        AddToggle("7Day7 Troll", function(v) print("7Day7 Troll:", v) end)
        AddToggle("Anti-Kick", function(v) print("Anti-Kick:", v) end)

        StarterGui:SetCore("SendNotification", {Title = "Nexxzy034", Text = "Hub Başarıyla Yüklendi!", Duration = 6})
        print("✅ Nexxzy034 Hub v2.1 Yüklendi!")

    else
        VerifyBtn.Text = "❌ Wrong Key"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        task.wait(2)
        VerifyBtn.Text = "VERIFY KEY"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
    end
end)

print("🔑 Key System Yüklendi. Get Key butonuna bas.")
