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
        warn("Error. Failed fetching the user's Id ", getId(player), "data.")
        return nil
    end
end

-- Changes the full data table of the player Id (local help)
local function setFullData(player, value)
    local success = pcall(function()
        DataStore:SetAsync(tostring(getId(player)), value)
    end)

    if success then return true else warn("Error. Failed to set the user's Id ", getId(player), "data.") return nil end
end

-- Practical Functions
function DataStoreHandler.changeData(player, key, value)
    -- Get full table
    local data = getFullData(player)

    if data == nil then
        print("Player datastore is currently empty.")
        data = {}
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
    local data = getFullData(player) or {}

    -- Try to fetch value from key
    if data and data[key] ~= nil then
        return data[key]
    else
        warn("Error. Key not found or empty.")
        return nil
    end
end

-- Tecnical Diagnostic Functions
function DataStoreHandler.resetPlayerData(player)
    -- Resets all player data to nil
    local success = pcall(function()
        return DataStore:SetAsync(getId(player), {})
    end)

    if success then
        print("All player data deleted.")
    else
        warn("Error. Failed to delete player data.")
    end
end

function DataStoreHandler.deleteKey(player, key)
    -- Get table
    local data = getFullData(player) or {}

    -- Delete data
    print("Deleting key \"" .. key .. "\" that contains \"" .. tostring(data[key]) .. "\" value...")
    data[key] = nil

    -- Update database
    local procedureAnswer = setFullData(player, data)

    if procedureAnswer then print("Key deleted.") end
end

return DataStoreHandler