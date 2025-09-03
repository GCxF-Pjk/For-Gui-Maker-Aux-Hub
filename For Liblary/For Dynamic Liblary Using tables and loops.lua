-- Load library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GCxF-Pjk/For-Gui-Maker-Aux-Hub/refs/heads/main/For%20Liblary/Source.lua"))()
local Main = Library:CreateWindow("Made by VantaXock") -- this is the main GUI window

-- Table of seeed ( JUST EXAMPLE! )
-- List all seeds you want to make buttons for
local Seeds = {
    "Fern", "Bamboo", "Cyca Palm", "Small Acacia", "Rain Tree",
    "Kapok", "Acacia", "HUGE Kapok", "Jungle Tree", "Void Tree",
    "Venus FlyTrap", "Mushrooms", "Toxic Acacia"
}

-- Loop through each seed
for _, seed in ipairs(Seeds) do  -- '_' = index in the table (not used), 'seed' = current seed in the loop

    -- Create a button for each seed
    -- Button label = "Get <seed> Seed", e.g., "Get Fern Seed"
    Main:Button("Get " .. seed .. " Seed", function()
        
        -- Prepare arguments for the RemoteEvent
        local args = {seed, 0}  -- first = seed name, second = quantity (adjust depending on game logic)
        
        -- FireServer to buy the seed
        -- Path: ReplicatedStorage -> Events -> Buy_Seed
        game:GetService("ReplicatedStorage")
            :WaitForChild("Events")
            :WaitForChild("Buy_Seed")
            :FireServer(unpack(args))  -- unpack(args) converts table {seed, 0} into arguments
    end)
end
