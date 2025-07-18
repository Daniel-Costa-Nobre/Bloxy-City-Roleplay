local DataStoreHandler = {}

-- Getting Data Store
local DataStoreService = game:GetService("DataStoreService")

-- Returns the full data table from the key (local help)
local function getFullData(key, dataStoreName)
    local DataStore = DataStoreService:GetDataStore(dataStoreName)

    local success, data = pcall(function()
        return DataStore:GetAsync(key)
    end)
    
    if success and data then 
        return data
    else
        warn("Error. Failed fetching the ", key, "'s data.")
        return nil
    end
end

-- Changes the full data table of the key (local help)
local function setFullData(key, value, dataStoreName)
    local DataStore = DataStoreService:GetDataStore(dataStoreName)

    local success = pcall(function()
        DataStore:SetAsync(key, value)
    end)

    if success then return true else warn("Error. Failed to set the ", key, "'s data.") return nil end
end

-- Practical Functions
function DataStoreHandler.changeData(key, subKey, value, dataStoreName)
    -- Get full table
    local data = getFullData(key, dataStoreName)

    if data == nil then
        print(key, "'s datastore is currently empty.")
        data = {}
    end

    -- Communicate if the key was not there before
    if not data[subKey] then
        print("Adding new SubKey...")
    end

    -- Find and change key
    data[subKey] = value

    -- Try to change inside database
    local procedureAnswer = setFullData(key, data, dataStoreName)
    return procedureAnswer
end

function DataStoreHandler.loadData(key, subKey, dataStoreName)
    -- Get full table
    local data = getFullData(key, dataStoreName) or {}

    -- Try to fetch value from key
    if data and data[subKey] ~= nil then
        return true, data[subKey]
    else
        warn("Error. SubKey not found or empty.")
        return nil, nil
    end
end

function DataStoreHandler.deleteSubKey(key, subKey, dataStoreName)
    -- Get table
    local data = getFullData(key, dataStoreName) or {}

    -- Delete data
    print("Deleting key \"" .. subKey .. "\" that contains \"" .. tostring(data[subKey]) .. "\" value...")
    data[subKey] = nil

    -- Update database
    local procedureAnswer = setFullData(key, data, dataStoreName)

    if procedureAnswer then print("SubKey deleted.") return true else return false end
end

-- Tecnical Diagnostic Functions
function DataStoreHandler.clearKeyData(key, dataStoreName)
    local DataStore = DataStoreService:GetDataStore(dataStoreName)

    -- Resets all player data to nil
    local success = pcall(function()
        return DataStore:SetAsync(key, {})
    end)

    if success then
        print("All ", key, "'s data deleted.")
    else
        warn("Error. Failed to delete ", key ,"'s data.")
    end
end

return DataStoreHandler