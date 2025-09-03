-- Half credit to Healrous help make this

--  Create ScreenGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoordinateGui"
screenGui.Parent = playerGui

-- Create TextLabel
local coordLabel = Instance.new("TextLabel")
coordLabel.Size = UDim2.new(0, 200, 0, 50)
coordLabel.Position = UDim2.new(0, 10, 0, 10)
coordLabel.BackgroundTransparency = 0.5
coordLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
coordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
coordLabel.TextScaled = true
coordLabel.Text = "Coordinates: X=0, Y=0, Z=0"
coordLabel.Parent = screenGui

--  Create Button to copy coordinates
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 200, 0, 50)
copyButton.Position = UDim2.new(0, 10, 0, 70) -- below the label
copyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextScaled = true
copyButton.Text = "Copy Coordinates"
copyButton.Parent = screenGui

--  Update coordinates every frame
spawn(function()
    while true do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local pos = character.HumanoidRootPart.Position
            coordLabel.Text = string.format("Coordinates: X=%.1f, Y=%.1f, Z=%.1f", pos.X, pos.Y, pos.Z)
        end
        wait(0.1)
    end
end)

--  Copy button functionality
copyButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local pos = character.HumanoidRootPart.Position
        local coords = string.format("%.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z)
        setclipboard(coords) -- copy to clipboard
        print("Copied coordinates:", coords)
    end
end)
