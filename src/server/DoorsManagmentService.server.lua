-- Important services and modules importing
local ServerScriptService = game:GetService("ServerScriptService")
local WorkspaceManager = require(ServerScriptService.WorkspaceManager)

-- Path Instructions
local PathInstructions = {
    MinimalHouse = {
        Door = {
            "Houses", "MinimalHouse", "Doors", "DOORPLACEHOLDER", "DoorModel"
        }
    }
}

-- Collect doors when place loading is completed
local place = workspace.Place

while true do
    task.wait(0.01)
    if place:GetAttribute("IsLoaded") then
        break
    end
end

local MinimalHouseDoors = WorkspaceManager.getAllInstancesFromPath(PathInstructions.MinimalHouse.Door)

-- Go through table
for _, door in pairs(MinimalHouseDoors) do
    -- Fetching important instances
    local openingForce = door.DoorPanel.OpeningForce
    local closingForce = door.DoorPanel.ClosingForce
    local doorPanel = door.DoorPanel
    local proximityPrompt = door.DoorPanel.ProximityPrompt
    local openingSound = door.DoorPanel.OpeningSound
    local closingSound = door.DoorPanel.ClosingSound
    local restriction = door.TemporaryRestriction

    proximityPrompt.Triggered:Connect(function()
        if closingForce.Enabled then
            proximityPrompt.Enabled = false

            -- Disable Restriction
            restriction.CanCollide = false

            -- Open the door
            openingForce.Enabled = true
            closingForce.Enabled = false

            -- Play sound
            closingSound:Stop()
            openingSound:Play()

            -- Make door easier to pass
            doorPanel.CanCollide = false

            -- Set cooldown and update proximityPrompt action text
            proximityPrompt.ActionText = "Close Door"

            task.wait(0.5)
            doorPanel.CanCollide = true
            
            task.wait(1.5)
            proximityPrompt.Enabled = true
        else
            proximityPrompt.Enabled = false

            -- Close the door
            openingForce.Enabled = false
            closingForce.Enabled = true

            -- Play sound
            openingSound:Stop()
            closingSound:Play()

            -- Make door easier to pass
            doorPanel.CanCollide = false

            -- Enable restriction, set cooldown and update proximityPrompt action text
            task.wait(0.25)
            doorPanel.CanCollide = true
            restriction.CanCollide = true
            proximityPrompt.ActionText = "Open Door"

            task.wait(1.75)
            proximityPrompt.Enabled = true
        end
    end)
end