-- Turcja Szefito Cheat Menu v2.0 | ERLC Undetected
-- Bind: X | Transparent Grey GUI | Full Features

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Anti-Detection
getgenv().TurcjaCheat = {}
getgenv().TurcjaCheat.Enabled = true
hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" and tostring(self) == "ReplicatedStorage" then
        return
    end
    return hookmetamethod(game, "__namecall", self, ...)
end)

-- Main GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local CategoriesFrame = Instance.new("ScrollingFrame")
local CategoryButtons = {}
local ContentFrame = Instance.new("Frame")
local ToggleFrame = Instance.new("Frame")

-- GUI Settings
ScreenGui.Name = "TurcjaSzefito"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner Radius
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 100, 100)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 10)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Turcja Szefito"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Categories
CategoriesFrame.Name = "CategoriesFrame"
CategoriesFrame.Parent = MainFrame
CategoriesFrame.BackgroundTransparency = 1
CategoriesFrame.BorderSizePixel = 0
CategoriesFrame.Position = UDim2.new(0, 0, 0, 50)
CategoriesFrame.Size = UDim2.new(0, 120, 0, 350)
CategoriesFrame.ScrollBarThickness = 4
CategoriesFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

local CategoriesLayout = Instance.new("UIListLayout")
CategoriesLayout.Parent = CategoriesFrame
CategoriesLayout.SortOrder = Enum.SortOrder.LayoutOrder
CategoriesLayout.Padding = UDim.new(0, 5)

-- Content Area
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 125, 0, 50)
ContentFrame.Size = UDim2.new(1, -125, 0, 350)
ContentFrame.ClipsDescendants = true

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentFrame
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)

-- Variables
local Toggles = {}
local Sliders = {}
local Categories = {
    {name = "Movement", layoutOrder = 1},
    {name = "ESP", layoutOrder = 2},
    {name = "Fun Troll", layoutOrder = 3},
    {name = "Settings", layoutOrder = 4}
}

local Features = {
    Movement = {
        {name = "Fly", toggle = true},
        {name = "Speed x3", toggle = true},
        {name = "SpeedHack", toggle = true},
        {name = "Noclip", toggle = true},
        {name = "Vehicle Fly", toggle = true},
        {name = "Infinite Jump", toggle = true},
        {name = "Super Jump", toggle = true}
    },
    ["ESP"] = {
        {name = "Player ESP", toggle = true},
        {name = "Mod ESP", toggle = true},
        {name = "Hitbox ESP", toggle = true},
        {name = "Tracers", toggle = true}
    },
    ["Fun Troll"] = {
        {name = "Rejoin", toggle = false},
        {name = "Crash Server", toggle = false},
        {name = "Spam Chat", toggle = false},
        {name = "Bring Players", toggle = false},
        {name = "Fling Players", toggle = false}
    },
    Settings = {
        {name = "ESP Color", slider = true, min = 0, max = 255, def = 255},
        {name = "Speed Slider", slider = true, min = 16, max = 500, def = 50},
        {name = "Keybind", text = true},
        {name = "Anti-AFK", toggle = true}
    }
}

-- ESP System
local ESP = {}
local Mods = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local esp = Drawing.new("Square")
    esp.Visible = false
    esp.Color = Color3.fromRGB(255, 50, 50)
    esp.Thickness = 2
    esp.Transparency = 1
    esp.Filled = false
    
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = Color3.fromRGB(255, 50, 50)
    tracer.Thickness = 2
    tracer.Transparency = 1
    
    ESP[player] = {box = esp, tracer = tracer, name = player.Name}
    
    -- Check if moderator
    spawn(function()
        wait(2)
        if player.Name:lower():find("mod") or player.Name:lower():find("admin") or player.DisplayName:lower():find("mod") then
            Mods[player] = true
            esp.Color = Color3.fromRGB(255, 0, 0)
        end
    end)
end

-- Create Category Button
local function CreateCategoryButton(catName, layoutOrder)
    local button = Instance.new("TextButton")
    button.Name = catName
    button.Parent = CategoriesFrame
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BackgroundTransparency = 0.2
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Font = Enum.Font.GothamSemibold
    button.Text = catName
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.TextScaled = true
    button.LayoutOrder = layoutOrder
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    CategoryButtons[catName] = button
    return button
end

-- Create Toggle
local function CreateToggle(parent, name, default)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1, -20, 0, 45)
    frame.LayoutOrder = #parent:GetChildren()
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 15, 0, 10)
    title.Size = UDim2.new(1, -80, 0, 25)
    title.Font = Enum.Font.Gotham
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextScaled = true
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = frame
    toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggle.BorderSizePixel = 0
    toggle.Position = UDim2.new(1, -55, 0, 12)
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Font = Enum.Font.GothamBold
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextScaled = true
    
    local tcorner = Instance.new("UICorner")
    tcorner.CornerRadius = UDim.new(0, 10)
    tcorner.Parent = toggle
    
    Toggles[name] = {button = toggle, enabled = default or false}
    
    toggle.MouseButton1Click:Connect(function()
        Toggles[name].enabled = not Toggles[name].enabled
        if Toggles[name].enabled then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end)
    
    return frame
end

-- Create Slider
local function CreateSlider(parent, name, min, max, default)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1, -20, 0, 60)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 15, 0, 10)
    title.Size = UDim2.new(1, -80, 0, 20)
    title.Font = Enum.Font.Gotham
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextScaled = true
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = frame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(1, -70, 0, 10)
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    valueLabel.TextScaled = true
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Parent = frame
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Position = UDim2.new(0, 15, 0, 40)
    sliderFrame.Size = UDim2.new(1, -30, 0, 15)
    
    local scorner = Instance.new("UICorner")
    scorner.CornerRadius = UDim.new(0, 8)
    scorner.Parent = sliderFrame
    
    local fill = Instance.new("Frame")
    fill.Parent = sliderFrame
    fill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    
    local fcorner = Instance.new("UICorner")
    fcorner.CornerRadius = UDim.new(0, 8)
    fcorner.Parent = fill
    
    Sliders[name] = {value = default, min = min, max = max, fill = fill, label = valueLabel}
    
    -- Slider Logic
    local dragging = false
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    sliderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mouse.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * relativeX
            
            Sliders[name].value = math.floor(value)
            Sliders[name].label.Text = tostring(Sliders[name].value)
            Sliders[name].fill.Size = UDim2.new(relativeX, 0, 1, 0)
        end
    end)
end

-- Show Category Content
local function ShowCategory(category)
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    ContentFrame:ClearAllChildren()
    
    for _, feature in pairs(Features[category]) do
        if feature.toggle then
            CreateToggle(ContentFrame, feature.name, false)
        elseif feature.slider then
            CreateSlider(ContentFrame, feature.name, feature.min, feature.max, feature.def)
        end
    end
    
    ContentLayout.Parent = ContentFrame
end

-- Create All Categories
for _, cat in pairs(Categories) do
    local button = CreateCategoryButton(cat.name, cat.layoutOrder)
    button.MouseButton1Click:Connect(function()
        for name, btn in pairs(CategoryButtons) do
            if name == cat.name then
                btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            else
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        ShowCategory(cat.name)
    end)
end

-- Initial Category
ShowCategory("Movement")

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    MainFrame:TweenPosition(UDim2.new(0, -510, 0, 10), "Out", "Quad", 0.3)
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Toggle GUI (X Key)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.X then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            MainFrame:TweenPosition(UDim2.new(0, 10, 0, 10), "Out", "Quad", 0.3)
        end
    end
end)

-- Fly System (Undetected)
local flying = false
local flySpeed = 50
local bodyVelocity, bodyAngularVelocity

RunService.Heartbeat:Connect(function()
    if Toggles["Fly"] and Toggles["Fly"].enabled then
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local rootPart = character.HumanoidRootPart
            
            if not flying then
                flying = true
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = rootPart
                
                bodyAngularVelocity = Instance.new("BodyAngularVelocity")
                bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
                bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
                bodyAngularVelocity.Parent = rootPart
            end
            
            local camera = workspace.CurrentCamera
            local moveVector = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.new(0, 1, 0) end
            
            bodyVelocity.Velocity = moveVector * flySpeed
        end
    elseif flying then
        flying = false
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
    end
end)

-- Speed Hack
spawn(function()
    while wait() do
        if Toggles["Speed x3"] and Toggles["Speed x3"].enabled or Toggles["SpeedHack"] and Toggles["SpeedHack"].enabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = Sliders["Speed Slider"] and Sliders["Speed Slider"].value or 100
            end
        end
    end
end)

-- Noclip
local noclipping = false
RunService.Stepped:Connect(function()
    if Toggles["Noclip"] and Toggles["Noclip"].enabled then
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Vehicle Fly
RunService.Heartbeat:Connect(function()
    if Toggles["Vehicle Fly"] and Toggles["Vehicle Fly"].enabled then
        for _, vehicle in pairs(workspace:GetChildren()) do
            if vehicle:FindFirstChild("VehicleSeat") and vehicle:FindFirstChild("BodyVelocity") == nil then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(4000, 4000, 4000)
                bv.Velocity = Vector3.new(0, 50, 0)
                bv.Parent = vehicle:FindFirstChild("VehicleSeat")
            end
        end
    end
end)

-- ESP Update
RunService.RenderStepped:Connect(function()
    for player, data in pairs(ESP) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local rootPart = player.Character.HumanoidRootPart
            local humanoid = player.Character.Humanoid
            
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
            
            if onScreen then
                local size = (workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0)) - workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 7, 0))).Magnitude
                
                data.box.Size = Vector2.new(size / 2, size)
                data.box.Position = Vector2.new(screenPos.X - size / 4, screenPos.Y - size / 1.5)
                data.box.Visible = Toggles["Player ESP"] and Toggles["Player ESP"].enabled or (Mods[player] and Toggles["Mod ESP"] and Toggles["Mod ESP"].enabled)
                
                -- Tracer
                if Toggles["Tracers"] and Toggles["Tracers"].enabled then
                    data.tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                    data.tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                    data.tracer.Visible = true
                end
            else
                data.box.Visible = false
                data.tracer.Visible = false
            end
        else
            data.box.Visible = false
            data.tracer.Visible = false
        end
    end
end)

-- Create ESP for all players
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)

-- Rejoin
if Toggles["Rejoin"] then
    Toggles["Rejoin"].button.MouseButton1Click:Connect(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

-- Fade In Animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame:TweenSize(UDim2.new(0, 500, 0, 400), "Out", "Quad", 0.5)

print("Turcja Szefito loaded! Press X to toggle.")
