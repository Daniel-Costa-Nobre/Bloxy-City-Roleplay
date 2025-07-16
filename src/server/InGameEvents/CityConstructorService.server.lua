-- Get plates folder
local platesfolder = workspace.Place.LocationPlates:GetChildren()

-- Structures folder
local structuresFolder = workspace.Place.Houses

-- Possible Structures
local possibleStructures = {
	"MinimalHouse"
}

local houseStyles = {
	AnateciasDesignA = {
		ExternalWallTexture = "Plaster",
		ExternalWallColor = Color3.fromRGB(242, 207, 161),  -- Fixed color value (light brown)
		InternalWallTextures = {
			LivingRoomT = "Ice",
			LivingRoomC = Color3.fromRGB(245, 245, 220),  -- Fixed color value (beige)
			BedroomT = "Ice",
			BedroomC = Color3.fromRGB(255, 182, 193),  -- Fixed color value (pink)
			BathroomT = "Slate",
			BathroomC = Color3.fromRGB(169, 169, 169),  -- Fixed color value (gray)
			KitchenT = "CeramicTiles",
			KitchenC = Color3.fromRGB(169, 169, 169),  -- Fixed color value (gray)
			GarageT = "Plaster",
			GarageC = Color3.fromRGB(169, 169, 169),  -- Fixed color value (gray)
			LaundryRoomT = "Plastic",
			LaundryRoomC = Color3.fromRGB(201, 160, 133),  -- Fixed color value (baby brown)
		},
		RoofTexture = "Concrete",
		RoofColor = Color3.fromRGB(137, 207, 240),  -- Fixed color value (baby blue)
		FloorTexture = "Wood",
		FloorColor = Color3.fromRGB(201, 160, 133),  -- Fixed color value (baby brown)
	},
	
	Modern = {
		ExternalWallTexture = "Concrete",
		ExternalWallColor = Color3.new(1, 1, 1),
		InternalWallTextures = {
			LivingRoomT = "Wood",
			LivingRoomC = Color3.new(0.8, 0.6, 0.4),
			BedroomT = "Wood",
			BedroomC = Color3.new(0.9, 0.7, 0.6),
			BathroomT = "CeramicTiles",
			BathroomC = Color3.new(0.95, 0.95, 0.95),
			KitchenT = "CeramicTiles",
			KitchenC = Color3.new(0.9, 0.9, 0.9),
			GarageT = "Metal",
			GarageC = Color3.new(0.8, 0.8, 0.8),
			LaundryRoomT = "Plastic",
			LaundryRoomC = Color3.new(1, 1, 1),
		},
		RoofTexture = "Concrete",
		RoofColor = Color3.new(0.5, 0.5, 0.5),
		FloorTexture = "Wood",
		FloorColor = Color3.new(0.8, 0.6, 0.4)
	},

	Classic = {
		ExternalWallTexture = "Brick",
		ExternalWallColor = Color3.new(1, 0.9, 0.7),
		InternalWallTextures = {
			LivingRoomT = "Wood",
			LivingRoomC = Color3.new(1, 0.8, 0.6),
			BedroomT = "Wood",
			BedroomC = Color3.new(0.9, 0.7, 0.5),
			BathroomT = "CeramicTiles",
			BathroomC = Color3.new(0.95, 0.95, 0.95),
			KitchenT = "CeramicTiles",
			KitchenC = Color3.new(0.7, 0.7, 0.7),
			GarageT = "Metal",
			GarageC = Color3.new(0.8, 0.8, 0.8),
			LaundryRoomT = "Plastic",
			LaundryRoomC = Color3.new(1, 1, 1),
		},
		RoofTexture = "Slate",
		RoofColor = Color3.new(0.7, 0.4, 0.3),
		FloorTexture = "Wood",
		FloorColor = Color3.new(0.8, 0.6, 0.4)
	},

	Industrial = {
		ExternalWallTexture = "Metal",
		ExternalWallColor = Color3.new(0.4, 0.4, 0.4),
		InternalWallTextures = {
			LivingRoomT = "Concrete",
			LivingRoomC = Color3.new(0.6, 0.6, 0.6),
			BedroomT = "Concrete",
			BedroomC = Color3.new(0.7, 0.7, 0.7),
			BathroomT = "CeramicTiles",
			BathroomC = Color3.new(0.9, 0.9, 0.9),
			KitchenT = "Granite",
			KitchenC = Color3.new(0.5, 0.5, 0.5),
			GarageT = "Metal",
			GarageC = Color3.new(0.8, 0.8, 0.8),
			LaundryRoomT = "Plastic",
			LaundryRoomC = Color3.new(1, 1, 1),
		},
		RoofTexture = "Slate",
		RoofColor = Color3.new(0.6, 0.5, 0.4),
		FloorTexture = "Concrete",
		FloorColor = Color3.new(0.6, 0.6, 0.6)
	},

	Rustic = {
		ExternalWallTexture = "Wood",
		ExternalWallColor = Color3.new(0.6, 0.4, 0.2),
		InternalWallTextures = {
			LivingRoomT = "Wood",
			LivingRoomC = Color3.new(0.7, 0.5, 0.3),
			BedroomT = "Wood",
			BedroomC = Color3.new(0.6, 0.4, 0.2),
			BathroomT = "CeramicTiles",
			BathroomC = Color3.new(0.9, 0.9, 0.9),
			KitchenT = "CeramicTiles",
			KitchenC = Color3.new(0.8, 0.8, 0.8),
			GarageT = "Metal",
			GarageC = Color3.new(0.7, 0.7, 0.7),
			LaundryRoomT = "Plastic",
			LaundryRoomC = Color3.new(1, 1, 1),
		},
		RoofTexture = "Wood",
		RoofColor = Color3.new(0.5, 0.3, 0.2),
		FloorTexture = "Wood",
		FloorColor = Color3.new(0.7, 0.5, 0.3)
	},

	Luxury = {
		ExternalWallTexture = "Marble",
		ExternalWallColor = Color3.new(1, 1, 1),
		InternalWallTextures = {
			LivingRoomT = "Wood",
			LivingRoomC = Color3.new(0.8, 0.6, 0.4),
			BedroomT = "Wood",
			BedroomC = Color3.new(0.9, 0.7, 0.6),
			BathroomT = "CeramicTiles",
			BathroomC = Color3.new(0.95, 0.95, 0.95),
			KitchenT = "CeramicTiles",
			KitchenC = Color3.new(0.9, 0.9, 0.9),
			GarageT = "Metal",
			GarageC = Color3.new(0.8, 0.8, 0.8),
			LaundryRoomT = "Plastic",
			LaundryRoomC = Color3.new(1, 1, 1),
		},
		RoofTexture = "Slate",
		RoofColor = Color3.new(0.6, 0.6, 0.6),
		FloorTexture = "Wood",
		FloorColor = Color3.new(0.8, 0.6, 0.4)
	}
}

local MinimalHouseBasicElementSets = {
	default = {
		DoorType = "DefaultDoor",
		GarageDoorType = "DefaultGarageDoor",
		LightType = "DefaultCeilingLight",
		WindowAType = "DefaultWindow",
		WindowBType = "DefaultSmallWindow"
	}
}

local styleKeys = {"Modern", "Classic", "Industrial", "Rustic", "Luxury", "AnateciasDesignA"}




-- Create structures
for index, part in ipairs(platesfolder) do
	if part.Name == "Plate" then
		-- Get Required Structure Builder
		local constructor = require(script.Parent.Parent.StructureBuilders:FindFirstChild(part:GetAttribute("ModuleRequirement")))

		-- Build Basic Structure (Structure with all bricks, structural rods, light systems, placeholders and texture pannels)
		local newStructure = constructor.buildBasicStructure(part, MinimalHouseBasicElementSets["default"], structuresFolder)

		-- Build Basic elements (Doors, Windows and more)
		constructor.buildBasicElements(newStructure)

		-- Build textures
		if newStructure.Name == "MinimalHouse" then
			-- Apply new textures
			local chosenStyle = styleKeys[(index % #styleKeys) + 1] -- Cycle through styles
			constructor.buildWallTextures(newStructure, houseStyles[chosenStyle])
		end

		-- Cooldown
		task.wait(0.1)
	end
end