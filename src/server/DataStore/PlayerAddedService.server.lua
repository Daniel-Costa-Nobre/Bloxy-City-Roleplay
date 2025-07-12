local DataStoreHandler = require(game.ServerScriptService.DataStore.DataStoreHandler)
local players = game:GetService("Players")

-- Define the keys and their default values that will be used for player data
local DataKeys = {
	Cash = {
		name = "Cash",
		type_ = "IntValue",
		defaultData = 0
	},
	Playtime = {
		name = "Playtime",
		type_ = "IntValue",
		defaultData = 2
	}
}

players.PlayerAdded:Connect(function(player)
	-- STEP 1 - Initialize player data
	-- Load player data from DataStore
	local PlayerData = DataStoreHandler.loadPlayerData(player)

	-- Create a folder to store player data in the player's instance
	local DataFolder = Instance.new("Folder")
	DataFolder.Name = "DataFolder"
	DataFolder.Parent = player

	if PlayerData then
		-- If player data exists, apply it to the corresponding values in the folder
		for key, value in pairs(PlayerData) do
			local valueType = type(value)

			-- Create and assign the appropriate value type based on the data type
			if valueType == "number" then
				local Value = Instance.new("IntValue")
				Value.Name = key  -- Set the name of the IntValue
				Value.Value = value  -- Set the value of the IntValue
				Value.Parent = DataFolder
			elseif valueType == "string" then
				local Value = Instance.new("StringValue")
				Value.Name = key  -- Set the name of the StringValue
				Value.Value = value  -- Set the value of the StringValue
				Value.Parent = DataFolder
			elseif valueType == "boolean" then
				local Value = Instance.new("BoolValue")
				Value.Name = key  -- Set the name of the BoolValue
				Value.Value = value  -- Set the value of the BoolValue
				Value.Parent = DataFolder
			else
				warn("Unsupported data type for key: " .. key .. ", type: " .. valueType)
			end
		end
	else
		-- If no data exists, create a default 'auth' value
		local auth = Instance.new("BoolValue")
		auth.Name = ("auth")
		auth.Value = false
		auth.Parent = player:FindFirstChild("DataFolder")
		DataStoreHandler.updateKey(player, "auth", false)
	end

	-- Loop through the predefined DataKeys and ensure each key exists for the player
	for _, key in pairs(DataKeys) do
		local valueType = key.type_

		-- If the key does not exist in the DataStore, create it with a default value
		if not DataStoreHandler.getKey(player, key.name, false) then
			if valueType == "IntValue" then
				local Value = Instance.new("IntValue")
				Value.Name = key.name  -- Set the name of the IntValue
				Value.Value = key.defaultData  -- Set the value of the IntValue
				Value.Parent = DataFolder
				DataStoreHandler.updateKey(player, key.name, key.defaultData)
			elseif valueType == "StringValue" then
				local Value = Instance.new("StringValue")
				Value.Name = key.name  -- Set the name of the StringValue
				Value.Value = key.defaultData  -- Set the value of the StringValue
				Value.Parent = DataFolder
				DataStoreHandler.updateKey(player, key.name, key.defaultData)
			elseif valueType == "BoolValue" then 
				local Value = Instance.new("BoolValue")
				Value.Name = key.name  -- Set the name of the BoolValue
				Value.Value = key.defaultData  -- Set the value of the BoolValue
				Value.Parent = DataFolder
				DataStoreHandler.updateKey(player, key.name, key.defaultData)
			else
				warn("Unsupported data type for key: " .. key.name .. ", type: " .. valueType)
			end
		end
	end
end)
