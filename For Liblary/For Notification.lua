local Notify = {}
Notify.__index = Notify

local TweenService = game:GetService("TweenService")

Notify.Theme = {
    bg = Color3.fromRGB(18, 18, 18),
    success = Color3.fromRGB(88, 166, 255),
    warning = Color3.fromRGB(255, 179, 71),
    error = Color3.fromRGB(255, 107, 107),
    text = Color3.fromRGB(255, 255, 255)
}

local function tween(obj, props, duration, style, direction)
    local info = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function makeCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function Parent(GUI)
    if syn and syn.protect_gui then
        syn.protect_gui(GUI)
        GUI.Parent = game:GetService("CoreGui")
    else
        GUI.Parent = game:GetService("CoreGui")
    end
end

function Notify:Send(text, typeName, duration)
    duration = duration or 2
    typeName = typeName or "success"
    local color = self.Theme[typeName] or self.Theme.success

    local GUI = Instance.new("ScreenGui")
    GUI.Name = "ModernNotification"
    GUI.IgnoreGuiInset = true
    Parent(GUI)

    local notif = Instance.new("Frame")
    notif.Parent = GUI
    notif.BackgroundColor3 = self.Theme.bg
    notif.BorderSizePixel = 0
    notif.Size = UDim2.new(0, 320, 0, 50)
    notif.Position = UDim2.new(0.5, -160, 0, -60)
    makeCorner(notif, 12)

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color),
        ColorSequenceKeypoint.new(1, self.Theme.text)
    }
    gradient.Rotation = 45
    gradient.Parent = notif

    local notifText = Instance.new("TextLabel")
    notifText.Parent = notif
    notifText.BackgroundTransparency = 1
    notifText.Size = UDim2.new(1, -20, 1, -10)
    notifText.Position = UDim2.new(0, 10, 0, 5)
    notifText.Font = Enum.Font.GothamBlack
    notifText.Text = text
    notifText.TextColor3 = self.Theme.text
    notifText.TextSize = 16
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.TextYAlignment = Enum.TextYAlignment.Center
    notifText.RichText = true

    tween(notif, {Position = UDim2.new(0.5, -160, 0, 20)}, 0.4)

    task.delay(duration, function()
        tween(notif, {Position = UDim2.new(0.5, -160, 0, -60)}, 0.4)
        task.wait(0.4)
        GUI:Destroy()
    end)
end

return Notify
