-- Load the GUI library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GCxF-Pjk/For-Gui-Maker-Aux-Hub/refs/heads/main/For%20Liblary/Source.lua"))()
local Main = Library:CreateWindow("Made by VantaXock") -- Main window of your hub

-- List of items (table)
local Items = {"Fern", "Bamboo", "Cyca Palm", "Small Acacia", "Rain Tree"}

-- Loop through the items table to create buttons dynamically
for _, item in ipairs(Items) do
    Main:Button("Get " .. item, function()
        local args = {item, 0}  -- 🔹 Arguments sent to the RemoteEvent (item name + quantity)

        -- 🔹 THIS IS THE LINE TO MODIFY WHEN USING A NEW REMOTEEVENT:
        -- Current RemoteEvent:
        -- Folder: "NewEvents" (replace with your folder if different)
        -- RemoteEvent name: "Give_Item" (replace with your RemoteEvent name)
        game:GetService("ReplicatedStorage"):WaitForChild("NewEvents"):WaitForChild("Give_Item"):FireServer(unpack(args))

        print("Gave Item:", item) -- logs the item you sent
    end)
end
