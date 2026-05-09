-- =============================================
-- Nexxzy034 Hub v1.8 - Key System + Get Key Button
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- ================== KEY SYSTEM ==================
local KeyVerified = false

local function CheckKey(key)
    if not key or key == "" then return false end
    if #key >= 8 then
        KeyVerified = true
        return true
    end
    return false
end

local function CopyGetKeyLink()
    local link = "https://robloxscriptss.duckdns.org/key"
    setclipboard(link)
    
    StarterGui:SetCore("SendNotification", {
        Title = "✅ Link Kopyalandı!",
        Text = "Tarayıcıda yapıştırabilirsiniz.\nhttps://robloxscriptss.duckdns.org/key",
        Duration = 5,
    })
end

-- ================== KEY UI ==================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NexxzyKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 460, 0, 340)
KeyFrame.Position = UDim2.new(0.5, -230, 0.5, -170)
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

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, 0, 0, 50)
Info.Position = UDim2.new(0, 0, 0, 80)
Info.BackgroundTransparency = 1
Info.Text = "Key almak için linke tıklayın veya butona basın"
Info.TextColor3 = Color3.fromRGB(180, 180, 180)
Info.TextScaled = true
Info.Font = Enum.Font.Gotham
Info.Parent = KeyFrame

-- Get Key Butonu
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 55)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0, 145)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
GetKeyBtn.Text = "🔗 Get Key"
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
GetKeyBtn.TextScaled = true
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyFrame
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 10)

GetKeyBtn.MouseButton1Click:Connect(CopyGetKeyLink)

-- Key Kutusu
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

-- Verify Butonu
local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.85, 0, 0, 60)
VerifyBtn.Position = UDim2.new(0.075, 0, 0, 275)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
VerifyBtn.Text = "VERIFY KEY"
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.TextScaled = true
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = KeyFrame
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 10)

-- ================== VERIFY LOGIC ==================
VerifyBtn.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    
    if CheckKey(key) then
        VerifyBtn.Text = "✅ DOĞRULANDI"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        
        wait(1.2)
        KeyGui:Destroy()
        
        -- ================== HUB YÜKLENİYOR ==================
        print("🚀 Nexxzy034 Hub Başarıyla Yüklendi!")
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0.88, 0, 0.78, 0)
        MainFrame.Position = UDim2.new(0.06, 0, 0.11, 0)
        MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = LocalPlayer:WaitForChild("PlayerGui")
        
        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
        
        local HubTitle = Instance.new("TextLabel")
        HubTitle.Size = UDim2.new(1, 0, 0, 70)
        HubTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        HubTitle.Text = "Nexxzy034 Hub"
        HubTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
        HubTitle.TextScaled = true
        HubTitle.Font = Enum.Font.GothamBold
        HubTitle.Parent = MainFrame
        Instance.new("UICorner", HubTitle).CornerRadius = UDim.new(0, 12)
        
        print("Hub hazır. İstediğin özellikleri ekleyebiliriz.")
        
    else
        VerifyBtn.Text = "❌ Geçersiz Key"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        wait(2)
        VerifyBtn.Text = "VERIFY KEY"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
    end
end)

print("🔑 Nexxzy034 Key System Yüklendi!")
