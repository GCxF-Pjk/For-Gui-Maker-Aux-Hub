local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GCxF-Pjk/For-Gui-Maker-Aux-Hub/refs/heads/main/For%20Liblary/Source.lua"))()

-- Create a main window 
local Main = Library:CreateWindow("Made by VantaXock") -- your Credits or Name hub ( Title )

-- Add a toggle 
Main:Toggle("Auto Kill", function(state)
    print("Auto kill state", state) -- your logic
end)

-- Add a button 
Main:Button("Click me!", function()
    print("Clicked!") -- your logic
end)

-- Add a textbox
Main:TextBox("Enter player name...", function(text)
    print("Player name:", text) -- your logic
end)
