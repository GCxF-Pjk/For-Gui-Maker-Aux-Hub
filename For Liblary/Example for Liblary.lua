local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GCxF-Pjk/For-Gui-Maker-Aux-Hub/refs/heads/main/For%20Liblary/Source.lua"))()

local Main = Library:CreateWindow("Made by VantaXock") 

Main:Toggle("Auto Kill", function(state)
    print("Auto kill state", state) 
end)

Main:Button("Click me!", function()
    print("Clicked!") 
end)

Main:TextBox("Enter player name...", function(text)
    print("Player name:", text) 
end)
