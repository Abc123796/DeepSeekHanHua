local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- 配置
local FLY_HEIGHT_LIMIT = 500          -- 在此高度以上会死亡
local SPEED_KILL_THRESHOLD = 10       -- 如果速度倍数超过此值则死亡（当按下+时）
local BASE_SPEED = 50                 -- 基础水平速度（乘以速度倍数）
local VERTICAL_SPEED = 30             -- 每次按住的垂直速度（乘以速度倍数）

-- =========
-- 构建 GUI (保持你分享的相同布局风格)
-- =========
local main = Instance.new("ScreenGui")
main.Name = "main"
main.Parent = player:WaitForChild("PlayerGui")
main.ResetOnSpawn = false

local Frame = Instance.new("Frame", main)
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

local up = Instance.new("TextButton", Frame)
up.Name = "up"
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "上升"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14

local down = Instance.new("TextButton", Frame)
down.Name = "down"
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "下降"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14

local onof = Instance.new("TextButton", Frame)
onof.Name = "onof"
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "飞行"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14

local TextLabel = Instance.new("TextLabel", Frame)
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "飞行 GUI V4"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextWrapped = true

local plus = Instance.new("TextButton", Frame)
plus.Name = "plus"
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true

local speedLabel = Instance.new("TextLabel", Frame)
speedLabel.Name = "speed"
speedLabel.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speedLabel.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speedLabel.Size = UDim2.new(0, 44, 0, 28)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.Text = "1"
speedLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
speedLabel.TextScaled = true

local mine = Instance.new("TextButton", Frame)
mine.Name = "mine"
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true

local closebutton = Instance.new("TextButton", main)
closebutton.Name = "Close"
closebutton.Parent = main.Frame or main -- 保持相似的父级位置
closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
closebutton.Font = Enum.Font.SourceSans
closebutton.Size = UDim2.new(0, 45, 0, 28)
closebutton.Text = "X"
closebutton.TextSize = 30
closebutton.Position = UDim2.new(0, 0, -1, 27)

local mini = Instance.new("TextButton", Frame)
mini.Name = "minimize"
mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini.Font = Enum.Font.SourceSans
mini.Size = UDim2.new(0, 45, 0, 28)
mini.Text = "-"
mini.TextSize = 40
mini.Position = UDim2.new(0, 44, -1, 27)

local mini2 = Instance.new("TextButton", Frame)
mini2.Name = "minimize2"
mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini2.Font = Enum.Font.SourceSans
mini2.Size = UDim2.new(0, 45, 0, 28)
mini2.Text = "+"
mini2.TextSize = 40
mini2.Position = UDim2.new(0, 44, -1, 57)
mini2.Visible = false

Frame.Active = true
Frame.Draggable = true

-- =========
-- 状态
-- =========
local speedMultiplier = 1
speedLabel.Text = tostring(speedMultiplier)
local verticalHold = 0   -- -1 下降, 0 无, +1 上升
local flying = false
local bodyGyro, bodyVelocity, renderConn

-- 辅助函数获取角色和根部位
local function getCharRoot()
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	return char, humanoid, root
end

-- 安全杀死玩家
local function killPlayer()
	pcall(function()
		if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
			player.Character:BreakJoints()
		end
	end)
end

-- 开始飞行
local function startFlying()
	if flying then return end
	local char, humanoid, root = getCharRoot()
	if not humanoid or not root then return end

	-- 创建控制器
	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 9e4
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.CFrame = workspace.CurrentCamera.CFrame
	bodyGyro.Parent = root

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = root

	-- 可选地冻结动画，如你的原始脚本
	pcall(function() char.Animate.Disabled = true end)

	flying = true
	onof.Text = "停止"

	-- 主更新循环 (使用 RenderStepped 使移动更流畅)
	renderConn = RunService.RenderStepped:Connect(function()
		if not flying then return end
		if not char or not char.Parent then return end

		-- 面向相机以获得自然感觉
		if bodyGyro and workspace.CurrentCamera then
			bodyGyro.CFrame = workspace.CurrentCamera.CFrame
		end

		-- 水平移动来自 Humanoid.MoveDirection (适用于移动端摇杆和 WASD)
		local moveDir = Vector3.new(0,0,0)
		if humanoid and humanoid.MoveDirection then
			moveDir = humanoid.MoveDirection
		end

		-- 垂直移动来自按钮按住
		local verticalVel = Vector3.new(0, verticalHold * VERTICAL_SPEED * speedMultiplier, 0)
		local horizontalVel = moveDir * (BASE_SPEED * speedMultiplier)

		-- 应用组合速度
		if bodyVelocity then
			bodyVelocity.Velocity = horizontalVel + verticalVel
		end

		-- 高度死亡检查
		if root.Position and root.Position.Y and root.Position.Y > FLY_HEIGHT_LIMIT then
			killPlayer()
			-- 停止飞行以防止残留对象
			flying = false
		end
	end)
end

-- 停止飞行
local function stopFlying()
	flying = false
	onof.Text = "飞行"
	if renderConn then renderConn:Disconnect() renderConn = nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
	-- 恢复动画
	pcall(function() 
		local char = player.Character
		if char and char:FindFirstChild("Animate") then
			char.Animate.Disabled = false
		end
	end)
end

-- 切换飞行按钮 (保持原始的状态启用/禁用模式，但使用我们的移动系统)
onof.MouseButton1Down:Connect(function()
	if flying then
		stopFlying()
		-- 重新启用人体状态
		local char, humanoid = getCharRoot()
		if humanoid then
			for _, st in ipairs({
				Enum.HumanoidStateType.Climbing, Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Flying,
				Enum.HumanoidStateType.Freefall, Enum.HumanoidStateType.GettingUp, Enum.HumanoidStateType.Jumping,
				Enum.HumanoidStateType.Landed, Enum.HumanoidStateType.Physics, Enum.HumanoidStateType.PlatformStanding,
				Enum.HumanoidStateType.Ragdoll, Enum.HumanoidStateType.Running, Enum.HumanoidStateType.RunningNoPhysics,
				Enum.HumanoidStateType.Seated, Enum.HumanoidStateType.StrafingNoPhysics, Enum.HumanoidStateType.Swimming
			}) do pcall(function() humanoid:SetStateEnabled(st, true) end) end
			pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics) end)
		end
	else
		-- 禁用多个人体状态（如你的原始脚本）然后开始飞行
		local char, humanoid = getCharRoot()
		if humanoid then
			for _, st in ipairs({
				Enum.HumanoidStateType.Climbing, Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Flying,
				Enum.HumanoidStateType.Freefall, Enum.HumanoidStateType.GettingUp, Enum.HumanoidStateType.Jumping,
				Enum.HumanoidStateType.Landed, Enum.HumanoidStateType.Physics, Enum.HumanoidStateType.PlatformStanding,
				Enum.HumanoidStateType.Ragdoll, Enum.HumanoidStateType.Running, Enum.HumanoidStateType.RunningNoPhysics,
				Enum.HumanoidStateType.Seated, Enum.HumanoidStateType.StrafingNoPhysics, Enum.HumanoidStateType.Swimming
			}) do pcall(function() humanoid:SetStateEnabled(st, false) end) end
			pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Swimming) end)
		end
		startFlying()
	end
end)

-- 上升/下降按住系统 (适用于触摸和鼠标)
local function bindHold(button, val)
	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			button:SetAttribute("Held", true)
			verticalHold = val
		end
	end)
	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			button:SetAttribute("Held", false)
			verticalHold = 0
		end
	end)
end
bindHold(up, 1)
bindHold(down, -1)

-- 加/减调整
plus.MouseButton1Down:Connect(function()
	speedMultiplier = speedMultiplier + 1
	speedLabel.Text = tostring(speedMultiplier)
	-- 如果速度太快，杀死玩家（按要求）
	if speedMultiplier >= SPEED_KILL_THRESHOLD then
		killPlayer()
	end
end)

mine.MouseButton1Down:Connect(function()
	if speedMultiplier > 1 then
		speedMultiplier = speedMultiplier - 1
		speedLabel.Text = tostring(speedMultiplier)
	end
end)

-- 关闭/最小化
closebutton.MouseButton1Click:Connect(function() main:Destroy() end)
mini.MouseButton1Click:Connect(function()
	up.Visible = false; down.Visible = false; onof.Visible = false; plus.Visible = false
	speedLabel.Visible = false; mine.Visible = false; mini.Visible = false; mini2.Visible = true
	Frame.BackgroundTransparency = 1
	closebutton.Position = UDim2.new(0, 0, -1, 57)
end)
mini2.MouseButton1Click:Connect(function()
	up.Visible = true; down.Visible = true; onof.Visible = true; plus.Visible = true
	speedLabel.Visible = true; mine.Visible = true; mini.Visible = true; mini2.Visible = false
	Frame.BackgroundTransparency = 0
	closebutton.Position = UDim2.new(0, 0, -1, 27)
end)

-- 重生时清理
player.CharacterAdded:Connect(function()
	-- 角色设置的小延迟
	task.wait(0.2)
	-- 确保没有残留
	stopFlying()
end)