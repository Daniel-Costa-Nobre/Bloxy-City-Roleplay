local DataStoreHandler = {}

-- Getting Data Store
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("PlayerDataStore")

-- Returns the id of the player (local help)
local function getId(player)
    local id = player.UserId
    return id
end

-- Returns the full data table from the player Id (local help)
local function getFullData(player)
    local success, data = pcall(function()
        return DataStore:GetAsync(tostring(getId(player)))
    end)
    
    if success and data then 
        return data
    else
        print("Failed fetching the user's Id ", getId(player), "data. ")
        return nil
    end
end

-- Practical Functions
function DataStoreHandler.changeData(player, key, value)
    -- Get full table
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