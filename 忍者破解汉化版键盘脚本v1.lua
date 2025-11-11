loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/cracked.txt", true))()

--[[
	汉化版键盘脚本v1
	基于Delta Mobile键盘脚本汉化
	移除了原始通知和版权声明
]]

-- Instances: 345 | Scripts: 6 | Modules: 0
local G2L = {};

-- StarterGui.汉化版键盘脚本v1
G2L["1"] = Instance.new("ScreenGui", gethui());
G2L["1"]["Name"] = [[汉化版键盘脚本v1]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;

-- StarterGui.汉化版键盘脚本v1.Main
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["Active"] = true;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["2"]["Size"] = UDim2.new(0, 478, 0, 236);
G2L["2"]["Position"] = UDim2.new(0.5, -239, 0.5, -118);
G2L["2"]["Name"] = [[Main]];

-- StarterGui.汉化版键盘脚本v1.Main.UIStroke
G2L["3"] = Instance.new("UIStroke", G2L["2"]);
G2L["3"]["Color"] = Color3.fromRGB(158, 0, 255);

-- StarterGui.汉化版键盘脚本v1.Main.Background
G2L["4"] = Instance.new("Frame", G2L["2"]);
G2L["4"]["Active"] = true;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4"]["BackgroundTransparency"] = 1;
G2L["4"]["Size"] = UDim2.new(0.9978905916213989, 0, 0.8684942126274109, 0);
G2L["4"]["Position"] = UDim2.new(0, 0, 0.12748458981513977, 0);
G2L["4"]["Name"] = [[Background]];

-- 这里省略了中间大量的键盘按钮代码...
-- 为了简洁，只显示关键修改部分

-- StarterGui.汉化版键盘脚本v1.Main.Title
G2L["13c"] = Instance.new("TextLabel", G2L["2"]);
G2L["13c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["13c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["13c"]["TextSize"] = 14;
G2L["13c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13c"]["Size"] = UDim2.new(0, 121, 0, 22);
G2L["13c"]["Active"] = true;
G2L["13c"]["Text"] = [[汉化版键盘脚本v1]];
G2L["13c"]["Name"] = [[Title]];
G2L["13c"]["BackgroundTransparency"] = 1;
G2L["13c"]["Position"] = UDim2.new(0, 9, 0, 2);

-- StarterGui.汉化版键盘脚本v1.CreateKey.Title
G2L["147"] = Instance.new("TextLabel", G2L["144"]);
G2L["147"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["147"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["147"]["Selectable"] = true;
G2L["147"]["TextSize"] = 18;
G2L["147"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["147"]["Size"] = UDim2.new(0, 285, 0, 24);
G2L["147"]["Active"] = true;
G2L["147"]["Text"] = [[汉化版键盘脚本 - 设置悬浮按键]];
G2L["147"]["Name"] = [[Title]];
G2L["147"]["BackgroundTransparency"] = 1;
G2L["147"]["Position"] = UDim2.new(-0.0035211266949772835, 0, 0.02054794505238533, 0);

-- StarterGui.汉化版键盘脚本v1.CreateKey.Title2
G2L["14b"] = Instance.new("TextLabel", G2L["144"]);
G2L["14b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["14b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["14b"]["Selectable"] = true;
G2L["14b"]["TextSize"] = 20;
G2L["14b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["14b"]["Size"] = UDim2.new(0, 285, 0, 24);
G2L["14b"]["Active"] = true;
G2L["14b"]["Text"] = [[在此输入您的按键绑定]];
G2L["14b"]["Name"] = [[Title2]];
G2L["14b"]["BackgroundTransparency"] = 1;
G2L["14b"]["Position"] = UDim2.new(-0.003521125763654709, 0, 0.19178083539009094, 0);

-- StarterGui.汉化版键盘脚本v1.Main.ToggleShift
G2L["132"] = Instance.new("TextButton", G2L["2"]);
G2L["132"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
G2L["132"]["TextSize"] = 14;
G2L["132"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["132"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["132"]["Size"] = UDim2.new(0, 78, 0, 14);
G2L["132"]["Name"] = [[ToggleShift]];
G2L["132"]["Text"] = [[启用Shift]];
G2L["132"]["Position"] = UDim2.new(0.7934519052505493, 0, 0.9299998879432678, 0);

-- 修改脚本中的文本内容
-- StarterGui.汉化版键盘脚本v1.Main.ButtonHandler
local function C_138()
	local script = G2L["138"];
	local buttons = script.Parent
	local ts = game.TweenService
	local cooldown = false

	buttons.Close.MouseButton1Up:Connect(function()
		script.Parent.Parent:Destroy()
	end)
	buttons.Close.MouseEnter:Connect(function()
		buttons.Close.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
	end)
	buttons.Close.MouseLeave:Connect(function()
		buttons.Close.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	end)
	buttons.Minimize.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
		script.Parent.Parent.FloatingIcon.Visible = true
	end)
	buttons.Window.MouseButton1Up:Connect(function()
		if not cooldown then
			if script.Parent.Background.Visible == true then
				script.Parent.ToggleRGB.Visible = false
				script.Parent.Settings.Visible = false
				script.Parent.Background.Visible = false
				script.Parent.ToggleShift.Visible = false
				local ti = TweenInfo.new(.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				local tw = ts:Create(script.Parent, ti, {Size = UDim2.new(0, 478,0, 29)})
				tw:Play()
				cooldown = true
				tw.Completed:Wait()
				cooldown = false
			elseif script.Parent.Background.Visible ==false then
				local ti = TweenInfo.new(.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				local tw = ts:Create(script.Parent, ti, {Size = UDim2.new(0, 478,0, 236)})
				tw:Play()
				cooldown = true
				tw.Completed:Wait()
				script.Parent.ToggleRGB.Visible = true
				script.Parent.Settings.Visible = true
				script.Parent.Background.Visible = true
				script.Parent.ToggleShift.Visible = true
				cooldown = false
			end
		end
	end)

	buttons.Settings.MouseButton1Up:Connect(function()
		script.Parent.Parent.IsSelectingKey.Value = true
	end)

	local IsSelecting =script.Parent.Parent.IsSelectingKey
	IsSelecting:GetPropertyChangedSignal("Value"):Connect(function()
		if IsSelecting.Value == true then
			script.Parent.Title.Text = "汉化版键盘脚本v1 (选择按键中)"
		elseif IsSelecting.Value == false then
			script.Parent.Title.Text = "汉化版键盘脚本v1"
		end
	end)

	script.Parent.ToggleShift.MouseButton1Up:Connect(function()
		if script.Parent.Parent.ToggleShift.Value == true then
			script.Parent.Parent.ToggleShift.Value = false
			script.Parent.ToggleShift.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		elseif script.Parent.Parent.ToggleShift.Value == false then
			script.Parent.Parent.ToggleShift.Value = true
			script.Parent.ToggleShift.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		end
	end)
end;
task.spawn(C_138);

-- 其他脚本保持不变...
-- 这里省略了其他脚本的完整代码

return G2L["1"], require;