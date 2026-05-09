-- =============================================
-- Nexxzy034 Hub v1.7 - Key System + Chilli Style
-- Key: https://robloxscriptss.duckdns.org/key
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- ================== KEY SYSTEM ==================
local CorrectKey = nil  -- Buraya doğrulama yapacağız
local KeyVerified = false

local function CheckKey(key)
    if key == "" or not key then 
        return false 
    end
    
    -- Basit doğrulama (siteye göre değiştirebilirsin)
    -- Eğer site API veriyorsa buraya GET isteği atabiliriz
    print("🔑 Girilen Key:", key)
    
    -- Şimdilik basit kontrol (gerçek projede daha güvenli yöntem kullanılır)
    if #key > 8 then  -- Örnek: Key en az 8 karakter olsun
        KeyVerified = true
        print("✅ Key Doğrulandı! Hub Açılıyor...")
        return true
    else
        print("❌ Geçersiz Key!")
        return false
    end
end

-- ================== KEY UI (Giriş Ekranı) ==================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NexxzyKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 420, 0, 280)
KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -140)
KeyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
KeyFrame.Parent = KeyGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = KeyFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 70)
Title.BackgroundTransparency = 1
Title.Text = "Nexxzy034 Hub"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = KeyFrame

local Instruction = Instance.new("TextLabel")
Instruction.Size = UDim2.new(1, 0, 0, 40)
Instruction.Position = UDim2.new(0, 0, 0, 70)
Instruction.BackgroundTransparency = 1
Instruction.Text = "Key almak için:\nhttps://robloxscriptss.duckdns.org/key"
Instruction.TextColor3 = Color3.fromRGB(200, 200, 200)
Instruction.TextScaled = true
Instruction.Font = Enum.Font.Gotham
Instruction.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.85, 0, 0, 50)
KeyBox.Position = UDim2.new(0.075, 0, 0, 130)
KeyBox.PlaceholderText = "Keyinizi buraya yapıştır..."
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.TextScaled = true
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyFrame

local UICorner2 = Instance.new("UICorner", KeyBox)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.85, 0, 0, 55)
VerifyBtn.Position = UDim2.new(0.075, 0, 0, 200)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
VerifyBtn.Text = "Verify Key"
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.TextScaled = true
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = KeyFrame

local BtnCorner = Instance.new("UICorner", VerifyBtn)

-- Verify Butonu
VerifyBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text
    if CheckKey(enteredKey) then
        KeyGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/.../main/hub.lua"))() -- Hub kodunu buraya koy
        -- Veya direkt hub kodunu çalıştır
    else
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        VerifyBtn.Text = "Geçersiz Key!"
        wait(2)
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
        VerifyBtn.Text = "Verify Key"
    end
end)

print("🔐 Nexxzy034 Key System Yüklendi!")
print("Key almak için: https://robloxscriptss.duckdns.org/key")
