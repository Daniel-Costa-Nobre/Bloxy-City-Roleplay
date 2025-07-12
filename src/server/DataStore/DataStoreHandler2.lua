local DataStoreHandler = {}

-- Getting Data Store
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("PlayerDataStore")

-- Practical Functions
function DataStoreHandler.changeData(player, key, value)
    -- Build here a function that changes the given key data
end

function DataStoreHandler.loadData(player, key)
    -- Build here a function that loads the given key data (returns value)
end

function DataStoreHandler.deleteKey(player, key)
    -- Build here a function that deletes the given key
end

function DataStoreHandler.addKey(player, key, value)
    -- Build here a function that adds a requested key
end

-- Tecnical Diagnostic Functions
function DataStoreHandler.resetPlayerData(playerId)
    -- Build here a function that resets all player data to nil
end

return DataStoreHandler