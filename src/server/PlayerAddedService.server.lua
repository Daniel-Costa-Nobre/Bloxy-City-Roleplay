-- Important services and modules importing
local Players = game:GetService("Players")
local DataStore = require(script.Parent.DataStore.DataStoreHandler)

-- Necessary keys
local defaultData = {
    ["PlayerSpawnPositionX"] = 0,
    ["PlayerSpawnPositionY"] = 0,
    ["PlayerSpawnPositionZ"] = 0
}

local gameKeys = {"PlayerSpawnPositionX", "PlayerSpawnPositionY", "PlayerSpawnPositionZ"}
local deletedKeys = {}
-- Control player added
Players.PlayerAdded:Connect(function(player)
    -- Check if all keys exist for player and add them if necessary
    for _, key in ipairs(gameKeys) do
        local success, value = DataStore.loadData(player, key)
        if not success then
            local setSuccess = DataStore.changeData(player, key, defaultData[key])
            if not setSuccess then
                player:Kick("Failed to load player data. Please try to join later.")
                return
            end
        end
    end

    -- Check if an unwanted key exists for player and delete it if necessary
    for _, key in ipairs(deletedKeys) do
        local success, value = DataStore.loadData(player, key)
        if success then 
            local setSuccess = DataStore.deleteKey(player, key)
            if not setSuccess then
                player:Kick("Failed to delete unnalowed player data. Please try to join later.")
                return
            end
        end
    end

    player.CharacterAdded:Connect(function()
        -- Spawn player in saved spawn position

    end)
end)