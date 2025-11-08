local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

if not lp then
    lp = Players.PlayerAdded:Wait()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFallGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = lp:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 5, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "防摔脚本"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -45, 0, 2)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -20, 0, 2)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.Gotham
CloseButton.Parent = TitleBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -25)
ContentFrame.Position = UDim2.new(0, 0, 0, 25)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -60, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "开启"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.Parent = ContentFrame

local rs = game:GetService("RunService")
local hb = rs.Heartbeat
local rsd = rs.RenderStepped
local z = Vector3.zero
local isEnabled = false
local currentConnections = {}

local function applyAntiFall(character)
    if not character then return end

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
    if not humanoidRootPart then return end

    local connection = hb:Connect(function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            if connection then
                connection:Disconnect()
            end
            return
        end

        local velocity = humanoidRootPart.AssemblyLinearVelocity
        humanoidRootPart.AssemblyLinearVelocity = z
        rsd:Wait()
        humanoidRootPart.AssemblyLinearVelocity = velocity
    end)

    table.insert(currentConnections, connection)
end

local function removeAntiFall()
    for _, connection in ipairs(currentConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    currentConnections = {}
end

local function toggleAntiFall()
    isEnabled = not isEnabled

    if isEnabled then
        ToggleButton.Text = "关闭"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 180, 60)

        if lp.Character then
            applyAntiFall(lp.Character)
        end

        lp.CharacterAdded:Connect(function(character)
            if isEnabled then
                applyAntiFall(character)
            end
        end)
    else
        ToggleButton.Text = "开启"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

        removeAntiFall()
    end
end

ToggleButton.MouseButton1Click:Connect(toggleAntiFall)

CloseButton.MouseButton1Click:Connect(function()
    removeAntiFall()
    ScreenGui:Destroy()
end)

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 25)
        MinimizeButton.Text = "+"
        ContentFrame.Visible = false
    else
        MainFrame.Size = UDim2.new(0, 200, 0, 100)
        MinimizeButton.Text = "-"
        ContentFrame.Visible = true
    end
end)

local function addCorner(parent)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = parent
end

addCorner(MainFrame)
addCorner(TitleBar)
addCorner(ToggleButton)
addCorner(MinimizeButton)
addCorner(CloseButton)

ToggleButton.MouseEnter:Connect(function()
    if isEnabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end)

ToggleButton.MouseLeave:Connect(function()
    if isEnabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

MinimizeButton.MouseEnter:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)

MinimizeButton.MouseLeave:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

CloseButton.MouseEnter:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)