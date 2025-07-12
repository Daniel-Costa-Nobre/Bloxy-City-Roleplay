local DataStoreHandler = {}
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

-- Return loaded playerData
function DataStoreHandler.loadPlayerData(player)
	local success, data = pcall(function()
		return playerDataStore:GetAsync(player.UserId)
	end)
	if success then
		return data
	else
		warn("Failed to load player data for player: " .. player.Name .. " due to error: " .. data)
		return nil
	end
end

-- Update a key with a new value
function DataStoreHandler.updateKey(player, key, value)
	local success, error = pcall(function()
		playerDataStore:UpdateAsync(player.UserId, function(data)
			data = data or {}  -- Ensure data is not nil
			data[key] = value
			return data
		end)
	end)
	if not success then
		warn("Failed to update key: " .. key .. " for player: " .. player.Name .. " with value: " .. value .. " due to error: " .. error)
		return nil
	else
		return true
	end
end

function DataStoreHandler.getKey(player, key, blindWarn)
	local success, data = pcall(function()
		return playerDataStore:GetAsync(player.UserId)
	end)
	if success then
		if data then
			return data[key]
		else
			return nil
		end
	else
		if not blindWarn then
			warn("Failed to get key: " .. key .. " for player: " .. player.Name .. " due to error: " .. data)
		end
		return false
	end
end
-- Remove a key (use in playtesting and in some issues)
function DataStoreHandler.removeKey(player, key)
	local success, error = pcall(function()
		playerDataStore:UpdateAsync(player.UserId, function(data)
			data[key] = nil
			return data
		end)
	end)
	if not success then
		warn("Failed to remove key: " .. key .. " for player: " .. player.Name .. " due to error: " .. error)
		return nil
	end
end

--  Increment an integer value key
function DataStoreHandler.incrementIntegerKey(player, key, num)
	local success, error = pcall(function()
		playerDataStore:UpdateAsync(player.UserId, function(data)
			if data[key] then
				data[key] = data[key] + num
			else
				data[key] = num
			end
			return data
		end)
	end)
	if not success then
		warn("Failed to increment integer key: " .. key .. " for player: " .. player.Name .. " due to error: " .. error)
		return nil
	end
end

return DataStoreHandler