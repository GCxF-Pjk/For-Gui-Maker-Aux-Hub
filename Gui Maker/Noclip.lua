local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

getgenv().NoClip = true -- set true 

spawn(function()
    while true do
        if getgenv().NoClip then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            hrp.CanCollide = false
        else
            hrp.CanCollide = true
        end
        wait(0.1)
    end
end)
