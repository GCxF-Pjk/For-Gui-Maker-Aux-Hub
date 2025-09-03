local ScreenGui = Instance.new("ScreenGui")
local TweenService = game:GetService("TweenService")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Name = "AuxLib"

local lib = {}

-- Theme
lib.Colors = {}
lib.Colors.Underline = Color3.new(1, 1, 1)
lib.Colors.Header = Color3.new(0.1, 0.1, 0.1)
lib.Colors.Body = Color3.new(0.13, 0.13, 0.13)
lib.Colors.Text = Color3.new(0.9, 0.9, 0.9)
lib.Colors.Button = Color3.new(0.16, 0.16, 0.16)
lib.Colors.ButtonHover = Color3.new(0.22, 0.22, 0.22)
lib.Colors.Dropdown = Color3.new(0.14, 0.14, 0.14)
lib.Colors.PlaceholderText = Color3.new(0.55, 0.55, 0.55)
lib.Colors.HideButton = Color3.new(0.85, 0.85, 0.85)
lib.Colors.Border = Color3.new(0.25, 0.25, 0.25)
lib.Colors.Checkbox = {}
lib.Colors.Checkbox.Checked = Color3.new(0.9, 0.9, 0.9)
lib.Colors.Checkbox.Unchecked = Color3.new(0.18, 0.18, 0.18)

lib.AnimationInfo = TweenInfo.new(
	0.15,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

lib.HoverInfo = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local function addHoverEffect(element, hoverColor, normalColor)
	element.MouseEnter:Connect(function()
		TweenService:Create(element, lib.HoverInfo, {BackgroundColor3 = hoverColor}):Play()
	end)
	
	element.MouseLeave:Connect(function()
		TweenService:Create(element, lib.HoverInfo, {BackgroundColor3 = normalColor}):Play()
	end)
end

local function addCorners(element, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 4)
	corner.Parent = element
	return corner
end

local function getNextWindowPos()
	local biggest = 0;
	local ok = nil;
	for i,v in pairs(ScreenGui:GetChildren()) do
		if v.Position.X.Offset > biggest then
			biggest = v.Position.X.Offset
			ok = v;
		end
	end
	if biggest == 0 then
		biggest = biggest + 5;
	else
		biggest = biggest + ok.Size.X.Offset + 5;
	end
	
	return biggest;
end

function lib:MakeWindow(title)
	local Top = Instance.new("Frame")
	local Style = Instance.new("Frame")
	local Body = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Hide = Instance.new("TextButton")
	
	Top.Name = title
	Top.BackgroundColor3 = lib.Colors.Header
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, getNextWindowPos() + 100, 0, 100)
	Top.Size = UDim2.new(0, 280, 0, 30)
	Top.Active = true
	Top.Draggable = true
	Top.Parent = ScreenGui
	
	addCorners(Top, 8)
	
	local Shadow = Instance.new("Frame")
	Shadow.Name = "Shadow"
	Shadow.Parent = Top
	Shadow.BackgroundColor3 = Color3.new(0, 0, 0)
	Shadow.BackgroundTransparency = 0.7
	Shadow.BorderSizePixel = 0
	Shadow.Position = UDim2.new(0, 2, 0, 2)
	Shadow.Size = UDim2.new(1, 0, 1, 0)
	Shadow.ZIndex = -1
	addCorners(Shadow, 8)
	
	Style.Name = "Style"
	Style.Parent = Top
	Style.BackgroundColor3 = lib.Colors.Underline
	Style.BorderSizePixel = 0
	Style.Position = UDim2.new(0, 0, 1, -2)
	Style.Size = UDim2.new(1, 0, 0, 2)
	
	Body.Name = "Body"
	Body.Parent = Style
	Body.BackgroundColor3 = lib.Colors.Body
	Body.BorderSizePixel = 0
	Body.Position = UDim2.new(0, 0, 1, 0)
	Body.Size = UDim2.new(1, 0, 0, 100)
	addCorners(Body, 6)
	
	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.Size = UDim2.new(0, 200, 1, 0)
	Title.Font = Enum.Font.GothamBold 
	Title.Text = title
	Title.TextColor3 = lib.Colors.Text
	Title.TextSize = 16 
	Title.TextXAlignment = Enum.TextXAlignment.Left
	
	Hide.Name = "Hide"
	Hide.Parent = Top
	Hide.BackgroundColor3 = Color3.new(1, 1, 1)
	Hide.BackgroundTransparency = 1
	Hide.Position = UDim2.new(1, -30, 0, 2)
	Hide.Size = UDim2.new(0, 26, 0, 26)
	Hide.Font = Enum.Font.GothamBold
	Hide.Text = "v"
	Hide.TextColor3 = lib.Colors.HideButton
	Hide.TextSize = 18
	addCorners(Hide, 4)
	
	addHoverEffect(Hide, Color3.new(0.2, 0.2, 0.2), Color3.new(1, 1, 1))
	Hide.MouseEnter:Connect(function()
		Hide.BackgroundTransparency = 0.8
	end)
	Hide.MouseLeave:Connect(function()
		Hide.BackgroundTransparency = 1
	end)
	
	local hidden = false
	local isAnimating = false
	local originalBodySize = nil
	
	local ez = {}
	ez.Frame = Top
	
	local function getNextPos()
		local biggest = 0
		local ok = nil
		for i,v in pairs(Body:GetChildren()) do
			if v:IsA("GuiObject") and v.Position.Y.Offset > biggest then
				biggest = v.Position.Y.Offset
				ok = v
			end
		end
		if biggest == 0 then
			biggest = biggest + 10
		else
			biggest = biggest + ok.Size.Y.Offset + 8
		end
		
		return biggest
	end
	
	local function getProperBodySize()
		return getNextPos() + 10
	end
	
	Hide.MouseButton1Click:Connect(function()
		if isAnimating then return end 
		
		isAnimating = true
		hidden = not hidden
		
		if hidden then
			
			originalBodySize = Body.Size.Y.Offset
			
			
			Hide.Text = "<"
			Style.Visible = false -- 
			
			local tween = TweenService:Create(Body, lib.AnimationInfo, {Size = UDim2.new(1, 0, 0, 0)})
			tween:Play()
			
			tween.Completed:Connect(function()
				Body.Visible = false
				isAnimating = false
			end)
		else
		
			Hide.Text = "−"
			Body.Visible = true
			Style.Visible = true
			
			local targetSize = originalBodySize or getProperBodySize()
			
			local tween = TweenService:Create(Body, lib.AnimationInfo, {Size = UDim2.new(1, 0, 0, targetSize)})
			tween:Play()
			
			tween.Completed:Connect(function()
				isAnimating = false
			end)
		end
	end)
	
	local function updateBodySize()
		if not hidden then
			local newSize = getProperBodySize()
			Body.Size = UDim2.new(1, 0, 0, newSize)
			originalBodySize = newSize
		end
	end
	
	function ez:addCheckbox(title)
		local Checkbox = Instance.new("TextButton")
		local CheckboxLabel = Instance.new("TextLabel")
		local checked = Instance.new("BoolValue")
		local CheckMark = Instance.new("TextLabel")
	
		Checkbox.Name = "Checkbox"
		Checkbox.BackgroundColor3 = lib.Colors.Checkbox.Unchecked
		Checkbox.BorderSizePixel = 0
		Checkbox.Size = UDim2.new(0, 22, 0, 22)
		Checkbox.Font = Enum.Font.GothamBold
		Checkbox.Text = ""
		Checkbox.TextColor3 = lib.Colors.Text
		Checkbox.TextSize = 14
		addCorners(Checkbox, 4)
		
		CheckMark.Name = "CheckMark"
		CheckMark.Parent = Checkbox
		CheckMark.BackgroundTransparency = 1
		CheckMark.Size = UDim2.new(1, 0, 1, 0)
		CheckMark.Font = Enum.Font.GothamBold
		CheckMark.Text = "✓" -- Will be replace with Rbxassetid Soon!
		CheckMark.TextColor3 = Color3.new(0, 0, 0)
		CheckMark.TextSize = 16
		CheckMark.Visible = false
		
		CheckboxLabel.Name = "CheckboxLabel"
		CheckboxLabel.Parent = Checkbox
		CheckboxLabel.BackgroundTransparency = 1
		CheckboxLabel.Position = UDim2.new(1, 8, 0, 0)
		CheckboxLabel.Size = UDim2.new(0, 220, 0, 22)
		CheckboxLabel.Font = Enum.Font.Gotham
		CheckboxLabel.Text = title
		CheckboxLabel.TextColor3 = lib.Colors.Text
		CheckboxLabel.TextSize = 14
		CheckboxLabel.TextWrapped = true
		CheckboxLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		checked.Parent = Checkbox
		Checkbox.Position = UDim2.new(0, 10, 0, getNextPos())
		Checkbox.Parent = Body
		updateBodySize()
		
		addHoverEffect(Checkbox, lib.Colors.ButtonHover, checked.Value and lib.Colors.Checkbox.Checked or lib.Colors.Checkbox.Unchecked)
		
		Checkbox.MouseButton1Click:Connect(function()
			checked.Value = not checked.Value
			
			local targetColor = checked.Value and lib.Colors.Checkbox.Checked or lib.Colors.Checkbox.Unchecked
			local textColor = checked.Value and Color3.new(0, 0, 0) or lib.Colors.Text
			
			TweenService:Create(Checkbox, lib.HoverInfo, {BackgroundColor3 = targetColor}):Play()
			CheckMark.Visible = checked.Value
			
			if checked.Value then
				CheckMark.TextTransparency = 1
				CheckMark.Visible = true
				TweenService:Create(CheckMark, lib.HoverInfo, {TextTransparency = 0}):Play()
			else
				local hideTween = TweenService:Create(CheckMark, lib.HoverInfo, {TextTransparency = 1})
				hideTween:Play()
				hideTween.Completed:Connect(function()
					CheckMark.Visible = false
				end)
			end
		end)
		
		local cb = {}
		cb.Checked = checked
		cb.Frame = Checkbox
		
		return cb
	end
	
	function ez:addButton(title, func)
		local Button = Instance.new("TextButton")
		
		Button.Name = "Button"
		Button.BackgroundColor3 = lib.Colors.Button
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(0, 260, 0, 30)
		Button.Font = Enum.Font.GothamSemibold
		Button.Text = title
		Button.TextColor3 = lib.Colors.Text
		Button.TextSize = 14
		Button.Position = UDim2.new(0, 10, 0, getNextPos())
		addCorners(Button, 6)
		
		Button.Parent = Body
		updateBodySize()
		
		addHoverEffect(Button, lib.Colors.ButtonHover, lib.Colors.Button)
		
		Button.MouseButton1Down:Connect(function()
			TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0, 258, 0, 28)}):Play()
		end)
		
		Button.MouseButton1Up:Connect(function()
			TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0, 260, 0, 30)}):Play()
		end)
		
		Button.MouseButton1Click:Connect(func)
	end
	
	function ez:addTextBox(title)
		local TextBox = Instance.new("TextBox")

		TextBox.BackgroundColor3 = lib.Colors.Button
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(0, 260, 0, 30)
		TextBox.Font = Enum.Font.Gotham
		TextBox.PlaceholderColor3 = lib.Colors.PlaceholderText
		TextBox.PlaceholderText = title
		TextBox.Text = ""
		TextBox.TextColor3 = lib.Colors.Text
		TextBox.TextSize = 14
		TextBox.TextWrapped = true
		TextBox.ZIndex = 1
		TextBox.Position = UDim2.new(0, 10, 0, getNextPos())
		addCorners(TextBox, 6)
		
		local Padding = Instance.new("UIPadding")
		Padding.PaddingLeft = UDim.new(0, 8)
		Padding.PaddingRight = UDim.new(0, 8)
		Padding.Parent = TextBox
		
		TextBox.Parent = Body
		
		local k = Instance.new("StringValue", TextBox)
		updateBodySize()
		
		TextBox.Focused:Connect(function()
			TweenService:Create(TextBox, lib.HoverInfo, {BackgroundColor3 = lib.Colors.ButtonHover}):Play()
		end)
		
		TextBox.FocusLost:Connect(function()
			TweenService:Create(TextBox, lib.HoverInfo, {BackgroundColor3 = lib.Colors.Button}):Play()
		end)
		
		local r = {}
		TextBox.Changed:Connect(function()
			k.Value = TextBox.Text
		end)
		
		r.Text = k
		r.Frame = TextBox
		
		return r
	end
	
	function ez:addTextBoxF(title, func)
		local TextBox = Instance.new("TextBox")

		TextBox.BackgroundColor3 = lib.Colors.Button
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(0, 260, 0, 30)
		TextBox.Font = Enum.Font.Gotham
		TextBox.PlaceholderColor3 = lib.Colors.PlaceholderText
		TextBox.PlaceholderText = title
		TextBox.Text = ""
		TextBox.TextColor3 = lib.Colors.Text
		TextBox.TextSize = 14
		TextBox.TextWrapped = true
		TextBox.ZIndex = 1
		TextBox.Position = UDim2.new(0, 10, 0, getNextPos())
		addCorners(TextBox, 6)
	
		local Padding = Instance.new("UIPadding")
		Padding.PaddingLeft = UDim.new(0, 8)
		Padding.PaddingRight = UDim.new(0, 8)
		Padding.Parent = TextBox
		
		local val = Instance.new("StringValue")
		val.Parent = TextBox
		val.Value = ""
		
		TextBox.Parent = Body
		updateBodySize()
		
		TextBox.Focused:Connect(function()
			TweenService:Create(TextBox, lib.HoverInfo, {BackgroundColor3 = lib.Colors.ButtonHover}):Play()
		end)
		
		TextBox.FocusLost:Connect(function(enterPressed)
			TweenService:Create(TextBox, lib.HoverInfo, {BackgroundColor3 = lib.Colors.Button}):Play()
			if enterPressed then
				func(val.Value)
			end
		end)
		
		TextBox.Changed:Connect(function()
			val.Value = TextBox.Text
		end)
		
		return val
	end
	
	function ez:addLabel(text, align)
		local Label = Instance.new("TextLabel")

		Label.Name = "Label"
		Label.BackgroundTransparency = 1
		Label.Size = UDim2.new(1, -20, 0, 20)
		Label.Font = Enum.Font.Gotham
		Label.Text = text
		Label.TextColor3 = lib.Colors.Text
		Label.TextSize = 14
		Label.TextWrapped = true
		Label.TextXAlignment = Enum.TextXAlignment[align or "Left"]
		
		local val = Instance.new("StringValue")
		val.Parent = Label
		val.Value = text
		
		Label.Position = UDim2.new(0, 10, 0, getNextPos())
		Label.Parent = Body
		updateBodySize()
		
		val.Changed:Connect(function()
			Label.Text = val.Value
		end)
		
		return val
	end
	
	function ez:addDropdown(options)
		local Dropdown = Instance.new("TextButton")
		local DropdownArrow = Instance.new("TextLabel")
		
		Dropdown.Name = "Dropdown"
		Dropdown.BackgroundColor3 = lib.Colors.Dropdown
		Dropdown.BorderSizePixel = 0
		Dropdown.Size = UDim2.new(0, 260, 0, 30)
		Dropdown.Font = Enum.Font.Gotham
		Dropdown.Text = "  " .. options[1]
		Dropdown.TextColor3 = lib.Colors.Text
		Dropdown.TextSize = 14
		Dropdown.TextWrapped = true
		Dropdown.TextXAlignment = Enum.TextXAlignment.Left
		Dropdown.ZIndex = 4
		addCorners(Dropdown, 6)
		
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Parent = Dropdown
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Position = UDim2.new(1, -30, 0, 0)
		DropdownArrow.Size = UDim2.new(0, 30, 1, 0)
		DropdownArrow.Font = Enum.Font.GothamBold
		DropdownArrow.Text = "▼"
		DropdownArrow.TextColor3 = lib.Colors.Text
		DropdownArrow.TextSize = 12
		
		local items = Instance.new("ScrollingFrame")
		items.Parent = Dropdown
		items.Name = "items"
		items.BackgroundColor3 = lib.Colors.Dropdown
		items.BorderSizePixel = 0
		items.Position = UDim2.new(0, 0, 1, 2)
		items.Size = UDim2.new(1, 0, 0, math.min(#options * 32, 120))
		items.CanvasSize = UDim2.new(0, 0, 0, #options * 32)
		items.ScrollBarThickness = 4
		items.Visible = false
		items.ZIndex = 10
		addCorners(items, 6)
		
		local open = Instance.new("BoolValue")
		open.Parent = Dropdown
		open.Name = "Open"
		open.Value = false
		
		local selected = Instance.new("StringValue")
		selected.Parent = Dropdown
		selected.Value = "Selected"
		selected.Value = options[1]
		
		Dropdown.Position = UDim2.new(0, 10, 0, getNextPos())
		Dropdown.Parent = Body
		updateBodySize()
		
		addHoverEffect(Dropdown, lib.Colors.ButtonHover, lib.Colors.Dropdown)
		
		for i, v in pairs(options) do
			local option = Instance.new("TextButton")
			
			option.Name = v
			option.Parent = items
			option.BackgroundColor3 = lib.Colors.Dropdown
			option.BorderSizePixel = 0
			option.Position = UDim2.new(0, 0, 0, (i-1) * 32)
			option.Size = UDim2.new(1, 0, 0, 32)
			option.Font = Enum.Font.Gotham
			option.Text = " " .. v
			option.TextColor3 = lib.Colors.Text
			option.TextSize = 14
			option.TextXAlignment = Enum.TextXAlignment.Left
			option.ZIndex = 11
			
			addHoverEffect(option, lib.Colors.ButtonHover, lib.Colors.Dropdown)
			
			option.MouseButton1Click:Connect(function()
				selected.Value = v
				open.Value = false
				
				local closeTween = TweenService:Create(items, lib.HoverInfo, {Size = UDim2.new(1, 0, 0, 0)})
				TweenService:Create(DropdownArrow, lib.HoverInfo, {Rotation = 0}):Play()
				closeTween:Play()
				
				closeTween.Completed:Connect(function()
					items.Visible = false
					items.Size = UDim2.new(1, 0, 0, math.min(#options * 32, 120))
				end)
				
				Dropdown.Text = "  " .. v
			end)
		end
		
		Dropdown.MouseButton1Click:Connect(function()
			open.Value = not open.Value
			
			if open.Value then
				items.Visible = true
				items.Size = UDim2.new(1, 0, 0, 0)
				TweenService:Create(items, lib.HoverInfo, {Size = UDim2.new(1, 0, 0, math.min(#options * 32, 120))}):Play()
				TweenService:Create(DropdownArrow, lib.HoverInfo, {Rotation = 180}):Play()
			else
				local closeTween = TweenService:Create(items, lib.HoverInfo, {Size = UDim2.new(1, 0, 0, 0)})
				TweenService:Create(DropdownArrow, lib.HoverInfo, {Rotation = 0}):Play()
				closeTween:Play()
				
				closeTween.Completed:Connect(function()
					items.Visible = false
					items.Size = UDim2.new(1, 0, 0, math.min(#options * 32, 120))
				end)
			end
		end)
		
		local dr = {}
		dr.Open = open
		dr.Selected = selected
		dr.Frame = Dropdown
		
		return dr
	end
	
	return ez
end

return lib
