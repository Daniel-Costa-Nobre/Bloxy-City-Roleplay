-- Important services and modules importing
local ServerScriptService = game:GetService("ServerScriptService")
local WorkspaceManager = require(ServerScriptService.WorkspaceManager)

-- Path Instructions
local PathInstructions = {
    MinimalHouse = {
        Door = {
            "Houses", "MinimalHouse", "Doors", "DOORPLACEHOLDER", "DoorModel"
        },
        GarageDoor = {
            "Houses", "MinimalHouse", "GARAGEDOORPLACEHOLDER", "GarageDoorModel"
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
local MinimalHouseGarageDoors = WorkspaceManager.getAllInstancesFromPath(PathInstructions.MinimalHouse.GarageDoor)

-- Go through all instances collected and script
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

for _, garageDoor in pairs(MinimalHouseGarageDoors) do
    -- Fetching important instances
    local forcefieldA = garageDoor:FindFirstChild("ForcefieldA")
    local forcefieldB = garageDoor:FindFirstChild("ForcefieldB")
    local garageOpen = garageDoor:FindFirstChild("PartC"):FindFirstChild("Union")
    local garageClosed1 = garageDoor:FindFirstChild("PartA"):FindFirstChild("Union")
    local garageClosed2 = garageDoor:FindFirstChild("PartB"):FindFirstChild("Union")
    
    local proxA = garageDoor:FindFirstChild("ForcefieldA"):FindFirstChild("ProximityPromptA")
    local proxB = garageDoor:FindFirstChild("ForcefieldB"):FindFirstChild("ProximityPromptB")

    local sound = garageDoor:FindFirstChild("ForcefieldA"):FindFirstChild("Sound")

    -- Proximity Prompt Triggered
    proxA.Triggered:Connect(function()
        if proxA.ActionText == "Open" then
            garageOpen.Transparency = 0
            garageOpen.CanCollide = true
            garageClosed1.Transparency = 1
            garageClosed2.Transparency = 1
            garageClosed1.CanCollide = false
            garageClosed2.CanCollide = false

            sound.Playing = true
            
            proxA.ActionText = "Close"
            proxB.ActionText = "Close"
            
            proxB.Enabled = false
        else
            garageOpen.Transparency = 1
            garageOpen.CanCollide = false
            garageClosed1.Transparency = 0
            garageClosed2.Transparency = 0
            garageClosed1.CanCollide = true
            garageClosed2.CanCollide = true

            sound.Playing = true

            proxA.ActionText = "Open"
            proxB.ActionText = "Open"
            
            proxA.Enabled = true
            proxB.Enabled = true
        end
    end)

    proxB.Triggered:Connect(function()
        if proxA.ActionText == "Open" then
            garageOpen.Transparency = 0
            garageOpen.CanCollide = true
            garageClosed1.Transparency = 1
            garageClosed2.Transparency = 1
            garageClosed1.CanCollide = false
            garageClosed2.CanCollide = false

            sound.Playing = true

            proxA.ActionText = "Close"
            proxB.ActionText = "Close"
            
            proxA.Enabled = false
        else
            garageOpen.Transparency = 1
            garageOpen.CanCollide = false
            garageClosed1.Transparency = 0
            garageClosed2.Transparency = 0
            garageClosed1.CanCollide = true
            garageClosed2.CanCollide = true

            sound.Playing = true

            proxA.ActionText = "Open"
            proxB.ActionText = "Open"
            
            proxA.Enabled = true
            proxB.Enabled = true
        end
    end)
end