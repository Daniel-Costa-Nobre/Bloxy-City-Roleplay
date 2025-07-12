local players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")


players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		-- Loop through all parts in the player's character
		for _, part in ipairs(character:GetDescendants()) do
			-- Check if it's a BasePart
			if part:IsA("BasePart") then
				-- Set the CollisionGroup property instead of using SetPartCollisionGroup
				part.CollisionGroup = "Players"
			end
		end
		print("Collision Group added for player:", player.Name)
	end)
end)
