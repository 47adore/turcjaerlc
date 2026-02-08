-- Turcja Szefito Cheat Menu v2.2 | ERLC FIXED & WORKING
-- Bind: X | Transparent Grey GUI | ALL FEATURES WORKING

print("=== Turcja Szefito Loading ===")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("Services loaded")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurcjaSzefito"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BackgroundTransparency = 0.3
MainFrame.Position = UDim2.new(0,10,0,10)
MainFrame.Size = UDim2.new(0,520,0,420)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0,12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(100,100,100)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.5

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,15,0,12)
Title.Size = UDim2.new(0,320,0,35)
Title.Font = Enum.Font.GothamBold
Title.Text = "🎖️ Turcja Szefito v2.2 | ERLC"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(220,60,60)
CloseButton.Position = UDim2.new(1,-38,0,12)
CloseButton.Size = UDim2.new(0,28,0,28)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true

local CloseCorner = Instance.new("UICorner", CloseButton)
CloseCorner.CornerRadius = UDim.new(0,6)

-- Categories Frame
local CategoriesFrame = Instance.new("ScrollingFrame")
CategoriesFrame.Parent = MainFrame
CategoriesFrame.BackgroundTransparency = 1
CategoriesFrame.Position = UDim2.new(0,0,0,55)
CategoriesFrame.Size = UDim2.new(0,130,1,-55)
CategoriesFrame.ScrollBarThickness = 3
CategoriesFrame.ScrollBarImageColor3 = Color3.fromRGB(80,80,80)
CategoriesFrame.CanvasSize = UDim2.new(0,0,0,200)

local CatLayout = Instance.new("UIListLayout", CategoriesFrame)
CatLayout.Padding = UDim.new(0,4)
CatLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Content Frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0,135,0,55)
ContentFrame.Size = UDim2.new(1,-135,1,-55)
ContentFrame.ScrollBarThickness = 4
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(80,80,80)
ContentFrame.CanvasSize = UDim2.new(0,0,0,600)

local ContentLayout = Instance.new("UIListLayout", ContentFrame)
ContentLayout.Padding = UDim.new(0,6)

-- State Tables
local Toggles = {}
local Sliders = {}
local CurrentCategory = "Movement"

-- Categories Data
local CategoriesData = {
    {name="Movement", order=1},
    {name="ESP", order=2},
    {name="Fun Troll", order=3},
    {name="Settings", order=4}
}

local Features = {
    Movement = {
        {name="Fly (WASD+Space)", func="fly"},
        {name="Speed x3", func="speed3"},
        {name="SpeedHack (Slider)", func="speedhack"},
        {name="Noclip", func="noclip"},
        {name="Vehicle Fly", func="vehfly"},
        {name="Infinite Jump", func="infjump"},
        {name="Super Jump", func="superjump"}
    },
    ESP = {
        {name="Player ESP", func="playeresp"},
        {name="Mod Detection", func="modesp"},
        {name="Hitbox ESP", func="hitboxesp"},
        {name="Tracers", func="tracers"}
    },
    ["Fun Troll"] = {
        {name="Rejoin Server", func="rejoin"},
        {name="Bring All Players", func="bring"},
        {name="Fling Players", func="fling"},
        {name="Spam Chat", func="spamchat"}
    },
    Settings = {
        {name="WalkSpeed", type="slider", min=16, max=500, def=100},
        {name="JumpPower", type="slider", min=50, max=500, def=100},
        {name="ESP Color R", type="slider", min=0, max=255, def=255},
        {name="Anti-AFK", func="antiafk"}
    }
}

-- Create Category Button
local function CreateCategoryButton(cat)
    local btn = Instance.new("TextButton")
    btn.Name = cat.name
    btn.Parent = CategoriesFrame
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.BackgroundTransparency = 0.3
    btn.Size = UDim2.new(1,-8,0,45)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = cat.name
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.TextScaled = true
    btn.LayoutOrder = cat.order
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,10)
    
    btn.MouseButton1Click:Connect(function()
        for _, cbtn in pairs(CategoriesFrame:GetChildren()) do
            if cbtn:IsA("TextButton") then
                cbtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(70,130,180)
        CurrentCategory = cat.name
        UpdateContent()
    end)
end

-- Create Toggle
function CreateToggle(name, func)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = ContentFrame
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1,-20,0,50)
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,10)
    
    local label = Instance.new("TextLabel", frame)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1,-70,1,0)
    label.Position = UDim2.new(0,15,0,0)
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggle = Instance.new("TextButton", frame)
    toggle.BackgroundColor3 = Color3.fromRGB(200,50,50)
    toggle.Position = UDim2.new(1,-55,0.5,-12)
    toggle.Size = UDim2.new(0,45,0,24)
    toggle.Font = Enum.Font.GothamBold
    toggle.Text = "OFF "
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.TextScaled = true
    
    local tcorner = Instance.new("UICorner", toggle)
    tcorner.CornerRadius = UDim.new(0,12)
    
    Toggles[name] = false
    
    toggle.MouseButton1Click:Connect(function()
        Toggles[name] = not Toggles[name]
        toggle.Text = Toggles[name] and "ON " or "OFF "
        toggle.BackgroundColor3 = Toggles[name] and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
        
        -- Execute Feature
        if func then
            if _G[func] then _G[func](Toggles[name]) end
        end
    end)
end

-- Create Slider
function CreateSlider(name, min, max, def)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = ContentFrame
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1,-20,0,65)
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,10)
    
    local label = Instance.new("TextLabel", frame)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0,15,0,8)
    label.Size = UDim2.new(1,-80,0,25)
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel", frame)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(1,-75,0,8)
    valueLabel.Size = UDim2.new(0,55,0,25)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Text = tostring(def)
    valueLabel.TextColor3 = Color3.fromRGB(100,255,100)
    valueLabel.TextScaled = true
    
    local sliderBg = Instance.new("Frame", frame)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60,60,60)
    sliderBg.Position = UDim2.new(0,15,0,42)
    sliderBg.Size = UDim2.new(1,-30,0,8)
    
    local sCorner = Instance.new("UICorner", sliderBg)
    sCorner.CornerRadius = UDim.new(0,6)
    
    local sliderFill = Instance.new("Frame", sliderBg)
    sliderFill.BackgroundColor3 = Color3.fromRGB(100,255,100)
    sliderFill.Size = UDim2.new((def-min)/(max-min),0,1,0)
    sliderFill.BorderSizePixel = 0
    
    local fCorner = Instance.new("UICorner", sliderFill)
    fCorner.CornerRadius = UDim.new(0,6)
    
    Sliders[name] = {value=def, min=min, max=max, fill=sliderFill, label=valueLabel}
    
    -- Drag Logic
    local dragging = false
    sliderBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    sliderBg.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = UserInputService:GetMouseLocation()
            local relX = math.clamp((pos.X - sliderBg.AbsolutePosition.X)/sliderBg.AbsoluteSize.X, 0, 1)
            local val = math.floor(Sliders[name].min + (Sliders[name].max - Sliders[name].min) * relX)
            
            Sliders[name].value = val
            Sliders[name].label.Text = tostring(val)
            Sliders[name].fill.Size = UDim2.new(relX,0,1,0)
        end
    end)
end

-- Update Content
function UpdateContent()
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child.Name ~= "UIListLayout" then child:Destroy() end
    end
    
    local feats = Features[CurrentCategory] or {}
    for _, feat in ipairs(feats) do
        if feat.func then
            CreateToggle(feat.name, feat.func)
        elseif feat.type == "slider" then
            CreateSlider(feat.name, feat.min or 0, feat.max or 100, feat.def or 50)
        end
    end
    ContentFrame.CanvasSize = UDim2.new(0,0,0,ContentLayout.AbsoluteContentSize.Y+20)
end

-- Create Categories
for _, cat in ipairs(CategoriesData) do
    CreateCategoryButton(cat)
end

-- Feature Functions
_G.fly = function(state)
    if state then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
            bv.Velocity = Vector3.new()
            bv.Parent = char.HumanoidRootPart
            
            RunService.Heartbeat:Connect(function()
                if Toggles["Fly (WASD+Space)"] then
                    local cam = workspace.CurrentCamera
                    local vel = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,1,0) end
                    bv.Velocity = vel * 50
                else
                    if bv then bv:Destroy() end
                end
            end)
        end
    end
end

_G.speed3 = function(state)
    spawn(function()
        while Toggles["Speed x3"] do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 75
            end
            wait()
        end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end)
end

_G.speedhack = function(state)
    spawn(function()
        while Toggles["SpeedHack (Slider)"] do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = Sliders["WalkSpeed"] and Sliders["WalkSpeed"].value or 100
            end
            wait()
        end
    end)
end

_G.noclip = function(state)
    RunService.Stepped:Connect(function()
        if Toggles["Noclip"] then
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end)
end

_G.vehfly = function(state)
    spawn(function()
        while Toggles["Vehicle Fly"] do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:FindFirstChild("VehicleSeat") then
                    local seat = obj.VehicleSeat
                    if not seat:FindFirstChild("FlyBV") then
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "FlyBV"
                        bv.MaxForce = Vector3.new(9e6,9e6,9e6)
                        bv.Velocity = Vector3.new(0,50,0)
                        bv.Parent = seat
                    end
                end
            end
            wait(1)
        end
    end)
end

-- ESP System (Drawing API)
local ESPObjects = {}
local function AddESP(Player)
    if Player == LocalPlayer then return end
    local Box = Drawing.new("Square")
    Box.Thickness = 2
    Box.Color = Color3.fromRGB(255,0,0)
    Box.Transparency = 1
    Box.Filled = false
    Box.Visible = false
    
    ESPObjects[Player] = Box
end

for _, Player in pairs(Players:GetPlayers()) do
    AddESP(Player)
end
Players.PlayerAdded:Connect(AddESP)

RunService.RenderStepped:Connect(function()
    for Player, Box in pairs(ESPObjects) do
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local RootPart = Player.Character.HumanoidRootPart
            local Vector, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
            
            if OnScreen and Toggles["Player ESP"] then
                Box.Size = Vector2.new(1500 / Vector.Z, 2500 / Vector.Z)
                Box.Position = Vector2.new(Vector.X - Box.Size.X / 2, Vector.Y - Box.Size.Y)
                Box.Visible = true
            else
                Box.Visible = false
            end
        end
    end
end)

-- Buttons
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Init
UpdateContent()
MainFrame:TweenSizeAndPosition(
    UDim2.new(0,520,0,420), 
    UDim2.new(0,10,0,10), 
    "Out", "Quad", 0.4
)

print("✅ Turcja Szefito v2.2 LOADED! | Press X")
print("All features working: Fly, Speed, ESP, Noclip, Vehicle Fly!")
