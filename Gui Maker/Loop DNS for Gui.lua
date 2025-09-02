-- For Loops 


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = ReplicatedStorage:WaitForChild("YourRemoteEvent") -- Replace with your event name

local isLooping = false

-- Toggle function (you can connect this to your toggle button!)
local function toggleLoop()
    isLooping = not isLooping
    
    if isLooping then
        print("Loop started!")
        -- Start the loop
        spawn(function()
            while isLooping do
                remoteEvent:FireServer("your", "arguments", "here")
                wait(1) -- Wait 1 second between fires (adjust as needed)
            end
        end)
    else
        print("Loop stopped!")
    end
end
