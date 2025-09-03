-- This for Toggle ( DNS )



Main:Toggle("Give Item Fast", function(state)
    getgenv().GiveItemFast = state

    if state then
        spawn(function()
            while getgenv().GiveItemFast do
                if getgenv().SelectedItem ~= "" then
                    local args = {getgenv().SelectedItem, 0}  -- adjust if needed
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("NewEvents")  -- new folder
                        :WaitForChild("Give_Item")  -- new RemoteEvent
                        :FireServer(unpack(args))
                    print("Gave Item via New RemoteEvent:", getgenv().SelectedItem)
                end
                wait(0.5)
            end
        end)
    end
end)
