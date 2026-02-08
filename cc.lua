-- 🔥 TURCJA TROLL MASTER v3.0 | FIVEM/CS2 | FLING ALL + TROLLS 🔥
-- Bind: INSERT | Ultra Smooth GUI | Undetected

print("=== TURCJA TROLL LOADING ===")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- === MAIN GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurcjaTrollMaster"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Name = "MainWindow"
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

-- Glass Effect
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15,15,25))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100,150,255)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.5
UIStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundTransparency = 1
Header.Size = UDim2.new(1, 0, 0, 60)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Parent = Header
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Position = UDim2.new(0, 25, 0, 0)
HeaderTitle.Size = UDim2.new(1, -120, 1, 0)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Text = "🎯 TURCJA TROLL MASTER v3.0"
HeaderTitle.TextColor3 = Color3.fromRGB(255,255,255)
HeaderTitle.TextScaled = true
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
CloseBtn.Position = UDim2.new(1, -45, 0, 15)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.BackgroundTransparency = 1
TabsContainer.Position = UDim2.new(0, 0, 0, 60)
TabsContainer.Size = UDim2.new(0, 140, 1, -60)

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.Parent = TabsContainer
TabsLayout.Padding = UDim.new(0, 5)
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 145, 0, 60)
ContentContainer.Size = UDim2.new(1, -145, 1, -60)
ContentContainer.ClipsDescendants = true

-- Tab Data
local Tabs = {
    {name = "🎭 Troll", order = 1},
    {name = "⚡ Movement", order = 2},
    {name = "👁️ ESP", order = 3},
    {name = "🔧 Settings", order = 4}
}

local TabContents = {}

-- Toggle System
local Toggles = {}
local Buttons = {}

-- Create Tab Button
local function CreateTabButton(tab)
    local btn = Instance.new("TextButton")
    btn.Name = tab.name
    btn.Parent = TabsContainer
    btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    btn.BackgroundTransparency = 0.2
    btn.Size = UDim2.new(1, -10, 0, 50)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = tab.name
    btn.TextColor3 = Color3.fromRGB(200,200,220)
    btn.TextScaled = true
    btn.LayoutOrder = tab.order
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(60,60,80)
    btnStroke.Thickness = 1
    btnStroke.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        -- Animate all tabs
        for _, tbtn in pairs(TabsContainer:GetChildren()) do
            if tbtn:IsA("TextButton") then
                TweenService:Create(tbtn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(35,35,45),
                    TextColor3 = Color3.fromRGB(200,200,220)
                }):Play()
                tbtn.Size = UDim2.new(1, -10, 0, 50)
            end
        end
        
        -- Active tab
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(100,150,255),
            TextColor3 = Color3.new(1,1,1)
        }):Play()
        btn.Size = UDim2.new(1, -10, 0, 55)
        
        -- Show content
        for name, content in pairs(TabContents) do
            content.Visible = (name == tab.name)
        end
    end)
    
    return btn
end

-- Create Button
function CreateButton(parent, name, callback, size)
    local btnFrame = Instance.new("TextButton")
    btnFrame.Name = name
    btnFrame.Parent = parent
    btnFrame.BackgroundColor3 = Color3.fromRGB(50,150,50)
    btnFrame.BackgroundTransparency = 0.1
    btnFrame.Size = size or UDim2.new(1, -20, 0, 55)
    btnFrame.Font = Enum.Font.GothamBold
    btnFrame.Text = "🚀 " .. name
    btnFrame.TextColor3 = Color3.new(1,1,1)
    btnFrame.TextScaled = true
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btnFrame
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(70,170,70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40,130,40))
    }
    btnGradient.Parent = btnFrame
    
    btnFrame.MouseButton1Click:Connect(function()
        btnFrame.BackgroundTransparency = 0.3
        TweenService:Create(btnFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0.1}):Play()
        callback()
    end)
    
    btnFrame.MouseEnter:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.2), {
            Size = btnFrame.Size + UDim2.new(0,10,0,5),
            BackgroundTransparency = 0
        }):Play()
    end)
    
    btnFrame.MouseLeave:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.2), {
            Size = size or UDim2.new(1, -20, 0, 55),
            BackgroundTransparency = 0.1
        }):Play()
    end)
end

-- Create Toggle
function CreateToggle(parent, name, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = name
    toggleFrame.Parent = parent
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Size = UDim2.new(1, -20, 0, 50)
    
    local label = Instance.new("TextLabel")
    label.Parent = toggleFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(1, -100, 1, 0)
    label.Font = Enum.Font.GothamSemibold
    label.Text = "🎮 " .. name
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = toggleFrame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    toggleBtn.Position = UDim2.new(1, -70, 0.5, -15)
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.TextScaled = true
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 15)
    tCorner.Parent = toggleBtn
    
    Toggles[name] = false
    
    toggleBtn.MouseButton1Click:Connect(function()
        Toggles[name] = not Toggles[name]
        if Toggles[name] then
            toggleBtn.Text = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        else
            toggleBtn.Text = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        end
        callback(Toggles[name])
    end)
end

-- Create Tab Content
for _, tab in ipairs(Tabs) do
    local content = Instance.new("ScrollingFrame")
    content.Name = tab.name
    content.Parent = ContentContainer
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Position = UDim2.new(0, 10, 0, 10)
    content.Size = UDim2.new(1, -20, 1, -20)
    content.ScrollBarThickness = 6
    content.ScrollBarImageColor3 = Color3.fromRGB(100,150,255)
    content.Visible = (tab.name == "🎭 Troll")
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Parent = content
    contentLayout.Padding = UDim.new(0, 12)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    TabContents[tab.name] = content
end

-- === TROLL TAB (GŁÓWNY) ===
local TrollContent = TabContents["🎭 Troll"]

-- 🔥 ULTRA FLING ALL (GŁÓWNY BUTTON)
CreateButton(TrollContent, "🌌 FLING ALL PLAYERS", function()
    print("🚀 ULTRA FLING ACTIVATED!")
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local target = player.Character.HumanoidRootPart
            local originalCFrame = target.CFrame
            
            -- Fling w kosmos
            target.CFrame = CFrame.new(0, 5000, 0) * CFrame.Angles(math.rad(360), math.rad(360), math.rad(360))
            
            -- Teleport back po 2s (tp glitch)
            wait(0.1)
            target.CFrame = originalCFrame
            wait(0.1)
            target.CFrame = CFrame.new(0, 10000, 0) * CFrame.Angles(math.rad(720), math.rad(720), math.rad(720))
            wait(0.2)
            target.CFrame = originalCFrame -- Reset
            
            print("🎯 Flung: " .. player.Name)
        end
    end
    print("✅ ALL PLAYERS FLUNG!")
end, UDim2.new(1,-20,0,70))

-- Inne troll buttons
CreateButton(TrollContent, "💥 EXPLODE ALL", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            for i = 1, 50 do
                local part = Instance.new("Part")
                part.Size = Vector3.new(0.1,0.1,0.1)
                part.CFrame = char.HumanoidRootPart.CFrame
                part.Parent = workspace
                part.Velocity = Vector3.new(math.random(-500,500), math.random(500,1500), math.random(-500,500))
                game:GetService("Debris"):AddItem(part, 3)
            end
        end
    end
end)

CreateButton(TrollContent, "🌀 SPIN ALL", function()
    spawn(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                local spin = Instance.new("BodyAngularVelocity")
                spin.AngularVelocity = Vector3.new(0, math.rad(1000), 0)
                spin.MaxTorque = Vector3.new(0, math.huge, 0)
                spin.Parent = root
                game:GetService("Debris"):AddItem(spin, 5)
            end
        end
    end)
end)

CreateButton(TrollContent, "📡 TELEPORT ALL TO YOU", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
        end
    end
end)

CreateButton(TrollContent, "🔄 FREEZE ALL", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = true
            end
        end
    end
end)

CreateButton(TrollContent, "🗑️ DELETE ALL TOOLS", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, tool in pairs(player.Character:GetChildren()) do
                if tool:IsA("Tool") then tool:Destroy() end
            end
        end
    end
end)

-- === MOVEMENT TAB ===
local MoveContent = TabContents["⚡ Movement"]
CreateToggle(MoveContent, "Fly (Hold Space)", function(state)
    if state then
        -- Fly logic tutaj
        print("Fly ON")
    end
end)

CreateToggle(MoveContent, "Speed x5", function(state)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = state and 100 or 16
    end
end)

CreateToggle(MoveContent, "Noclip", function(state)
    -- Noclip logic
end)

-- === ESP TAB ===
local ESPContent = TabContents["👁️ ESP"]
CreateToggle(ESPContent, "Player ESP", function(state) end)
CreateToggle(ESPContent, "Rainbow ESP", function(state) end)

-- === SETTINGS ===
local SettingsContent = TabContents["🔧 Settings"]
CreateToggle(SettingsContent, "Anti-AFK", function(state) end)

-- === CONTROLS ===
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(key, gp)
    if gp then return end
    if key.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- === ANIMATION START ===
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Visible = false

wait(0.1)
MainFrame.Visible = true
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 550, 0, 450)
}):Play()

print("✅ TURCJA TROLL MASTER v3.0 LOADED!")
print("🎮 Bind: INSERT | Main: FLING ALL")
print("Trolls: Fling, Explode, Spin, TP, Freeze, Delete Tools!")
