

--[[ Remade by VantaXock ]]local GhostLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/GCxF-Pjk/For-Gui-Maker-Aux-Hub/refs/heads/main/Main%20Liblary/Ghost%20Liblary%20V3.lua'))()
local Window = GhostLib:CreateWindow("Ghost Liblary")

-- Button
Window:AddElement("TextButton", "Click Me", [[
    print("Button clicked!")
]])

-- Toggle
Window:AddElement("Switch", "Speed Boost", [[
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
]], [[
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
]])

-- Textbox
local textInput = Window:AddElement("TextBox", "Enter text...")

-- Slider
Window:AddElement("Slider", "Speed", "16,100,false", [[
    local speed = tonumber("VALUE")
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
]])

-- Dropdown
Window:AddElement("Dropdown", "Teleport", "Spawn,Shop,Bank", [[
    if "OPTION" == "Spawn" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
    elseif "OPTION" == "Shop" then  
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(50, 5, 50)
    elseif "OPTION" == "Bank" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50, 5, -50)
    end
]])
