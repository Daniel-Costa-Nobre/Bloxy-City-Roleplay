-- Important services and modules importing
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local DataStore = require(script.Parent.DataStore.DataStoreHandler)

-- Useful local functions/variables
local function toVector3(x,y,z)
    return Vector3.new(x,y,z)
end

local function hasValue(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

local function teleportCharacter(character, position)
    local hrp = character:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(position)
end

local yFix = 1

-- Tables with information for the datastore iteration process
local defaultData = {
    ["PlayerSpawnPositionX"] = 0,
    ["PlayerSpawnPositionY"] = 0,
    ["PlayerSpawnPositionZ"] = 0
}
local activeKeys = {"PlayerSpawnPositionX", "PlayerSpawnPositionY", "PlayerSpawnPositionZ"}
local deletedKeys = {}

-- Table containing default spawn positions
local defaultSpawnPositionsXYZ = {toVector3(-789, -162.5 + yFix, -20), toVector3(-767.787, -162.5 + yFix, -28.787), toVector3(-759, -162.5 + yFix, -50), toVector3(-767.787, -162.5 + yFix, -71.213), toVector3(-789, -162.5 + yFix, -80), toVector3(-810.213, -162.5 + yFix, -71.213), toVector3(-819, -162.5 + yFix, -50), toVector3(-810.213, -162.5 + yFix, -28.787)}

-- Control player added
Players.PlayerAdded:Connect(function(player)
    -- Check if all keys exist for player and add them if necessary
    for _, key in ipairs(activeKeys) do
        local success, value = DataStore.loadData(player, key)
        if not success then
            local setSuccess = DataStore.changeData(player, key, defaultData[key])
            if not setSuccess then player:Kick("Failed to load player data. Please try to join later.") return end
        end
    end

    -- Check if an unwanted key exists for player and delete it if necessary
    for _, key in ipairs(deletedKeys) do
        local success, value = DataStore.loadData(player, key)
        if success then 
            local setSuccess = DataStore.deleteKey(player, key)
            if not setSuccess then player:Kick("Failed to delete unnalowed player data. Please try to join later.") return end
        end
    end

    player.CharacterAdded:Connect(function(character)
        -- Spawn player in saved spawn position
        local posX, posY, posZ
        local answer_x, answer_y, answer_z

        for attempt = 1, 10 do
            answer_x, posX = DataStore.loadData(player, "PlayerSpawnPositionX")
            answer_y, posY = DataStore.loadData(player, "PlayerSpawnPositionY")
            answer_z, posZ = DataStore.loadData(player, "PlayerSpawnPositionZ")

            if answer_x and answer_y and answer_z then break end

            if attempt == 10 then player:Kick("Failed to load player data. Please try to join later.") return end
        end

        local spawnPosition = toVector3(posX, posY, posZ)

        -- Check if it's the default spawn position
        if (posX == 0 and posY == 0 and posZ == 0) or hasValue(defaultSpawnPositionsXYZ, spawnPosition) then 
            -- Assign one of the default values to the database and spawn
            local randomInteger = math.random(1,8)
            local chosenPos = defaultSpawnPositionsXYZ[randomInteger]

            for attempt = 1, 10 do
                local success_x = DataStore.changeData(player, "PlayerSpawnPositionX", chosenPos.X)
                local success_y = DataStore.changeData(player, "PlayerSpawnPositionY", chosenPos.Y)
                local success_z = DataStore.changeData(player, "PlayerSpawnPositionZ", chosenPos.Z)

                if success_x and success_y and success_z then teleportCharacter(character, chosenPos) break end

                if attempt == 10 then player:Kick("Failed to update player data. Please try to join later.") return end
            end
        else
            teleportCharacter(character, spawnPosition)
        end
    end)
end)