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
        print("Error. Failed fetching the user's Id ", getId(player), "data.")
        return nil
    end
end

-- Changes the full data table of the player Id (local help)
local function setFullData(player, value)
    local sucess = pcall(function()
        DataStore:SetAsync(getId(player), value)
    end)

    if sucess then return true else print("Error. Failed to set the user's Id ", getId(player), "data.") return false end
end

-- Practical Functions
function DataStoreHandler.changeData(player, key, value)
    -- Get full table
    local data = getFullData(player)

    if #data == 0 then
        print("Player datastore is currently empty.")
    end
    -- Communicate if the key was not there before
    if not data[key] then
        print("Adding new key...")
    end
    -- Find and change key
    data[key] = value

    -- Try to change inside database
    local procedureAnswer = setFullData(player, data)
    return procedureAnswer

end

function DataStoreHandler.loadData(player, key)
    -- Get full table
    local data = getFullData(player)

    -- Try to fetch value from key
    local success, value = pcall(function()
        return data[key]
    end)

    -- Return value if possible
    if success and value then
        return value
    else
        print("Error. Key not found.")
        return false
    end
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