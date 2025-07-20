-- Important services and modules importing
local Lighting = game:GetService("Lighting")
local StarterPlayer = game:GetService("StarterPlayer")
local WorkspaceManager = require(StarterPlayer.StarterPlayerScripts.WorkspaceManagerClient)

-- Instructions to access folders
local PathInstructions = {
    AmbientLightParts = {
    "Houses", "MinimalHouse", "AmbientLightParts"
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

-- Get all ambient light parts
local AmbientLightParts = WorkspaceManager.getAllInstancesFromPath(PathInstructions.AmbientLightParts)

for _, part in pairs(AmbientLightParts) do
    print("Found!", part)
end