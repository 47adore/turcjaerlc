-- Turcja Szefito ERLC v2.1 | WORKING LOADSTRING
-- https://pastebin.com/raw/ (wklej tutaj)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("Turcia Szefito loading...") -- DEBUG

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaSzefito"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02,0,0.02,0)
MainFrame.Size = UDim2.new(0,450,0,350)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,15,0,10)
Title.Size = UDim2.new(0,300,0,35)
Title.Font = Enum.Font.GothamBold
Title.Text = "Turcja Szefito"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,60,60)
CloseBtn.Position = UDim2.new(1,-40,0,10)
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,6)
CloseCorner.Parent = CloseBtn

-- Toggles Table
local Toggles = {}

-- Create Toggle Function
local function CreateToggle(name, posY, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = MainFrame
    Frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Frame.BackgroundTransparency = 0.3
    Frame.Position = UDim2.new(0,20,posY)
    Frame.Size = UDim2.new(1,-40,0,40)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,8)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1,-60,1,0)
    Label.Position = UDim2.new(0,10,0,0)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextScaled = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = Frame
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    ToggleBtn.Position = UDim2.new(1,-45,0.5,-12)
    ToggleBtn.Size = UDim2.new(0,35,0,24)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.TextScaled = true
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0,12)
    TCorner.Parent = ToggleBtn
    
    Toggles[name] = false
    
    ToggleBtn.MouseButton1Click:Connect(function()
        Toggles[name] = not Toggles[name]
        if Toggles[name] then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
            ToggleBtn.Text = "ON"
            if callback then callback(true) end
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
            ToggleBtn.Text = "OFF"
            if callback then callback(false) end
        end
    end)
end

-- FEATURES
CreateToggle("Fly", UDim2.new(0,0,0,60), function(state)
    if state then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(4000,4000,4000)
            BV.Velocity = Vector3.new(0,0,0)
            BV.Parent = char.HumanoidRootPart
            
            RunService.Heartbeat:Connect(function()
                if Toggles["Fly"] then
                    local cam = workspace.CurrentCamera
                    local move = Vector3.new(0,0,0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + cam.CFrame.UpVector end
                    BV.Velocity = move * 50
                end
            end)
        end
    end
end)

CreateToggle("Speed x3", UDim2.new(0,0,0,110))
CreateToggle("Noclip", UDim2.new(0,0,0,160))
CreateToggle("Player ESP", UDim2.new(0,0,0,210))
CreateToggle("Mod ESP", UDim2.new(0,0,0,260))
CreateToggle("Vehicle Fly", UDim2.new(0,0,0,310))

-- Speed Loop
spawn(function()
    while true do
        wait()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            if Toggles["Speed x3"] then
                char.Humanoid.WalkSpeed = 75
            end
        end
    end
end)

-- Noclip Loop
RunService.Stepped:Connect(function()
    if Toggles["Noclip"] then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Close Button
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Toggle GUI (X)
UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Fade In
MainFrame.Size = UDim2.new(0,0,0,0)
MainFrame:TweenSize(UDim2.new(0,450,0,350),"Out","Quad",0.5,true)

print("Turcia Szefito LOADED! Press X") -- SUCCESS
