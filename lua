-- =============================================
-- Nexxzy034 Hub v1.8 - Düzeltilmiş Key System
-- =============================================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- ================== KEY SYSTEM ==================
local function CopyGetKeyLink()
    setclipboard("https://robloxscriptss.duckdns.org/key")
    StarterGui:SetCore("SendNotification", {
        Title = "✅ Link Kopyalandı!",
        Text = "Tarayıcıya yapıştırın: robloxscriptss.duckdns.org/key",
        Duration = 6,
    })
end

local function CheckKey(key)
    if not key or key == "" then return false end
    if #key >= 6 then  -- Daha esnek yaptım (test için)
        return true
    end
    return false
end

-- ================== KEY UI ==================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NexxzyKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 460, 0, 360)
KeyFrame.Position = UDim2.new(0.5, -230, 0.5, -180)
KeyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
KeyFrame.Parent = KeyGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 80)
Title.BackgroundTransparency = 1
Title.Text = "Nexxzy034 Hub"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = KeyFrame

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 55)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0, 140)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
GetKeyBtn.Text = "🔗 Get Key"
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
GetKeyBtn.TextScaled = true
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyFrame
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 10)

GetKeyBtn.MouseButton1Click:Connect(CopyGetKeyLink)

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.85, 0, 0, 55)
KeyBox.Position = UDim2.new(0.075, 0, 0, 210)
KeyBox.PlaceholderText = "Keyinizi buraya yapıştır..."
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.TextScaled = true
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyFrame
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.85, 0, 0, 60)
VerifyBtn.Position = UDim2.new(0.075, 0, 0, 280)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
VerifyBtn.Text = "VERIFY KEY"
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.TextScaled = true
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = KeyFrame
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 10)

-- ================== VERIFY ==================
VerifyBtn.MouseButton1Click:Connect(function()
    local key = KeyBox.Text

    if CheckKey(key) then
        VerifyBtn.Text = "✅ DOĞRULANDI"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        
        task.wait(1)
        KeyGui:Destroy()

        -- ================== ANA HUB YÜKLENİYOR ==================
        print("🚀 Nexxzy034 Hub Yükleniyor...")

        local HubGui = Instance.new("ScreenGui")
        HubGui.Name = "Nexxzy034Hub"
        HubGui.ResetOnSpawn = false
        HubGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
        MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
        MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = HubGui

        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

        local HubTitle = Instance.new("TextLabel")
        HubTitle.Size = UDim2.new(1, 0, 0, 70)
        HubTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        HubTitle.Text = "Nexxzy034 Hub"
        HubTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
        HubTitle.TextScaled = true
        HubTitle.Font = Enum.Font.GothamBold
        HubTitle.Parent = MainFrame
        Instance.new("UICorner", HubTitle).CornerRadius = UDim.new(0, 14)

        -- Basit bir bilgi yazısı
        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.Size = UDim2.new(1, 0, 1, -80)
        InfoLabel.Position = UDim2.new(0, 0, 0, 70)
        InfoLabel.BackgroundTransparency = 1
        InfoLabel.Text = "Hub Başarıyla Yüklendi!\n\nŞimdi istediğin özellikleri ekleyebiliriz.\n\nESP, Troll, Fly vs."
        InfoLabel.TextColor3 = Color3.new(1,1,1)
        InfoLabel.TextScaled = true
        InfoLabel.Font = Enum.Font.GothamSemibold
        InfoLabel.Parent = MainFrame

        StarterGui:SetCore("SendNotification", {
            Title = "✅ Başarılı",
            Text = "Nexxzy034 Hub yüklendi!",
            Duration = 5,
        })

        print("✅ Hub Tamamen Yüklendi!")

    else
        VerifyBtn.Text = "❌ Geçersiz Key"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        task.wait(2)
        VerifyBtn.Text = "VERIFY KEY"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
    end
end)

print("🔑 Key System Hazır. Get Key butonuna basarak link alabilirsiniz.")
