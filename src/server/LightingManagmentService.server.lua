-- Important services and modules importing
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local WorkspaceManager = require(ServerScriptService.WorkspaceManager)

-- Instructions to access folders
local PathInstructions = {
    MinimalHouse = {
        Light = {
            "Houses", "MinimalHouse", "LightSystem", "ANY"
        },
    }
}

-- Check if the place is fully loaded
local place = workspace.Place

while true do
    task.wait(0.01)
    if place:GetAttribute("IsLoaded") then
        break
    end
end

