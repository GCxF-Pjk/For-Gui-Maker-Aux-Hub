-- Aux Hub Gui maker



local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- // Helper for simple hover effect ( modify it if you want I'm tired so hard bro ;D )
local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        }):Play()
    end)
end

-- // Helper
local function style(obj)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = obj

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
end

-- // ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MultiGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- // Draggable Frame (container)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 30, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = screenGui
style(frame)

-- LAYOUT 
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Parent = frame

-- =====================================================
-- 1. TOGGLE BUTTON ( DNS )
-- =====================================================
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.Parent = frame
style(toggleButton)
addHoverEffect(toggleButton)

local isToggled = false
toggleButton.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    toggleButton.Text = isToggled and "ON" or "OFF"
    print("Toggle state:", isToggled)
end)

-- =====================================================
-- 2. BUTTON  ( DNS )
-- =====================================================
local actionButton = Instance.new("TextButton")
actionButton.Size = UDim2.new(0, 200, 0, 40)
actionButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
actionButton.Text = "Click Me"
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.Font = Enum.Font.GothamBold
actionButton.TextSize = 18
actionButton.Parent = frame
style(actionButton)
addHoverEffect(actionButton)

actionButton.MouseButton1Click:Connect(function()
    print("Button clicked!")
end)

-- =====================================================
-- 3. TEXTBOX ( DNS )
-- =====================================================
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 40)
textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
textBox.PlaceholderText = "Enter text here..."
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.GothamBold
textBox.TextSize = 18
textBox.ClearTextOnFocus = false
textBox.Parent = frame
style(textBox)

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        print("Textbox input:", textBox.Text)
    end
end)

-- =====================================================
-- Make Frame Draggable ( DNS )
-- =====================================================
local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
