-- For Loops 

-- Simple Loops
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




-- For Gui Loops 


-- Replace your existing toggle button click event with:
toggleButton.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    toggleButton.Text = isToggled and "ON" or "OFF"
    
    -- Add the loop toggle here
    isLooping = isToggled
    
    if isLooping then
        spawn(function()
            while isLooping do
                -- Fire your remote event here
                remoteEvent:FireServer() -- Add your arguments
                wait(0.5) -- Adjust delay as needed
            end
        end)
    end
    
    print("Toggle state:", isToggled)
end)
