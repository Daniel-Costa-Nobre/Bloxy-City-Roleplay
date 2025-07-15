local Constructor = {}

-- Creates basic Structure for the minimal house
function Constructor.buildBasicStructure(plate, attributes, parent)
	-- Check if function was called correctly
	if not (plate and attributes and parent) then
		warn("Error. Paramethers not declared or empty.")
		warn("Plate: ", plate)
		warn("Attributes:", attributes)
		warn("Parent: ", parent)
	end

	-- Create new house
	local houseModel = workspace.Assets.Structures.MinimalHouse
	local newHouse = houseModel:Clone()
	newHouse.Parent = parent

	-- Set the Id based on the plate
	local Id = plate:GetAttribute("Id")
	newHouse:SetAttribute("Id", Id)
	newHouse.HouseNumPannel.SurfaceGui.TextLabel.Text = Id
	
	-- Ensure the model has a PrimaryPart
	if newHouse.PrimaryPart then
		-- Compute new position and orientation
		local newPosition = CFrame.new(plate.Position)
		local newOrientation = CFrame.Angles(
			math.rad(plate.Orientation.X), 
			math.rad(plate.Orientation.Y), 
			math.rad(plate.Orientation.Z)
		)

		-- Move the house
		newHouse:PivotTo(newPosition * newOrientation)
	else
		warn("Error. New house has no PrimaryPart set")
	end
	
	-- Set all attributes if they were declared

	local attributes = attributes
		
	for name, attribute in pairs(attributes) do
		newHouse:SetAttribute(name, attribute)
	end
	
	-- Return the house location to the variable assigned
	return newHouse
end

-- Changes the texture and the color of the texture pannels of the house
function Constructor.buildWallTextures(newHouse, style)
	local style = style

	if style then
		-- Change default textures
		local style = style
		
		-- External Wall Textures
		local extWallTexture = style["ExternalWallTexture"]
		local extWallTextureColor = style["ExternalWallColor"]
		local externalWalls = newHouse.Textures.External:GetChildren()
		
		for _, texturePannel in pairs(externalWalls) do
			texturePannel.Color = extWallTextureColor
			texturePannel.Material = extWallTexture
		end

		-- Internal Wall Textures
		local internalWallTextures = style["InternalWallTextures"]

		-- Living Room
		local livingRoomTexture = internalWallTextures["LivingRoomT"]
		local livingRoomColor = internalWallTextures["LivingRoomC"]
		local livingRoomWalls = newHouse.Textures.LivingRoom:GetChildren()

		for _, texturePannel in pairs(livingRoomWalls) do
			texturePannel.Color = livingRoomColor
			texturePannel.Material = livingRoomTexture
		end
		
		-- Bedroom
		local bedroomTexture = internalWallTextures["BedroomT"]
		local bedroomColor = internalWallTextures["BedroomC"]
		local bedroomWalls = newHouse.Textures.Bedroom:GetChildren()
		
		for _, texturePannel in pairs(bedroomWalls) do	
			texturePannel.Color = bedroomColor
			texturePannel.Material = bedroomTexture
		end
		
		-- Bathroom
		local bathroomTexture = internalWallTextures["BathroomT"]
		local bathroomColor = internalWallTextures["BathroomC"]
		local bathroomWalls = newHouse.Textures.Bathroom:GetChildren()
		
		for _, texturePannel in pairs(bathroomWalls) do
			texturePannel.Color = bathroomColor
			texturePannel.Material = bathroomTexture
		end
		
		-- Kitchen
		local kitchenTexture = internalWallTextures["KitchenT"]
		local kitchenColor = internalWallTextures["KitchenC"]
		local kitchenWalls = newHouse.Textures.Kitchen:GetChildren()
		
		for _, texturePannel in pairs(kitchenWalls) do
			texturePannel.Color = kitchenColor
			texturePannel.Material = kitchenTexture
		end
		
		-- Garage
		local garageTexture = internalWallTextures["GarageT"]
		local garageColor = internalWallTextures["GarageC"]
		local garageWalls = newHouse.Textures.Garage:GetChildren()

		for _, texturePannel in pairs(garageWalls) do
			texturePannel.Color = garageColor
			texturePannel.Material = garageTexture
		end
		
		-- Laundry Room
		local laundryRoomTexture = internalWallTextures["LaundryRoomT"]
		local laundryRoomColor = internalWallTextures["LaundryRoomC"]
		local laundryRoomWalls = newHouse.Textures.LaundryRoom:GetChildren()

		for _, texturePannel in pairs(laundryRoomWalls) do
			texturePannel.Color = laundryRoomColor
			texturePannel.Material = laundryRoomTexture
		end
		
		-- Roof
		local roofTexture = style["RoofTexture"]
		local roofColor = style["RoofColor"]
		local roofWalls = newHouse.Textures.Roof:GetChildren()

		for _, texturePannel in pairs(roofWalls) do
			texturePannel.Color = roofColor
			texturePannel.Material = roofTexture
		end
		
		-- Floor
		local floorTexture = style["FloorTexture"]
		local floorColor = style["FloorColor"]
		local floorPannel = newHouse.Textures.FloorTexture
		
		floorPannel.Color = floorColor
		floorPannel.Material = floorTexture
	else
		warn("No style assigned.")
	end
end

-- Apply house owner
function Constructor.applyOwner(house, owner)
	-- Get house attributes
	local houseAttributes = house:GetAttributes()
	-- Apply owner
	houseAttributes.Owner = owner
end

-- Build basic elements, such as doors and windows
function Constructor.buildBasicElements(newHouse)
	-- Get House
	local house = newHouse
	
	-- Set Basic Elements models
	local door = newHouse:GetAttribute("DoorType")
	local windowA = newHouse:GetAttribute("WindowAType")
	local windowB = newHouse:GetAttribute("WindowBType")
	local garageDoor = newHouse:GetAttribute("GarageDoorType")
	local light = newHouse:GetAttribute("LightType")
	local mailBox = newHouse:GetAttribute("MailBoxType")
	
	-- Build doors
	for _, doorPlaceHolder in pairs(house.Doors:GetChildren()) do
		-- Clear existing children (only if needed)
		if #(doorPlaceHolder:GetChildren()) > 0 then
			doorPlaceHolder:ClearAllChildren()
		end

		-- Clone the door before applying transformations
		local newDoor = door:Clone()

		-- Fix Position
		if newDoor.PrimaryPart then
			local newPosition = doorPlaceHolder.Position
			local newOrientation = CFrame.Angles(
				math.rad(doorPlaceHolder.Orientation.X), 
				math.rad(doorPlaceHolder.Orientation.Y), 
				math.rad(doorPlaceHolder.Orientation.Z)
			)

			-- Apply transformation
			newDoor:PivotTo(CFrame.new(newPosition) * newOrientation)
			
			-- Parent new door to the placeholder
			newDoor.Parent = doorPlaceHolder
		else
			warn("Error. New door has no PrimaryPart set.")
			newDoor:Destroy()
		end

		-- Keep placeholder but make it invisible
		doorPlaceHolder.Transparency = 1
	end
	
	-- Build windows (A and B)
	for _, windowPlaceHolder in ipairs(house.Windows:GetChildren()) do
		-- Clear existing children (only if needed)
		if #(windowPlaceHolder:GetChildren()) > 0 then
			windowPlaceHolder:ClearAllChildren()
		end
		
		-- Set Door Type
		local isWindowA
		-- Set Door Type
		if windowPlaceHolder.Name == "WINDOWAPLACEHOLDER" then 
			isWindowA = true
		else
			isWindowA = false
		end
		
		-- Clone the window before applying transformations
		local newWindow
		
		if isWindowA then
			newWindow = windowA:Clone()
		else
			newWindow = windowB:Clone()
		end
		
		-- Fix Position
		if newWindow.PrimaryPart then
			local newPosition = windowPlaceHolder.Position
			local newOrientation = CFrame.Angles(
				math.rad(windowPlaceHolder.Orientation.X),  
				math.rad(windowPlaceHolder.Orientation.Y),  
				math.rad(windowPlaceHolder.Orientation.Z)   
			)
			-- Apply transformation
			newWindow:PivotTo(CFrame.new(newPosition) * newOrientation)
			
			-- Parent new window to the placeholder
			newWindow.Parent = windowPlaceHolder
		else
			warn("Error. New window has no PrimaryPart set.")
			newWindow:Destroy()
		end
	end
	
	-- Build Garage Door
	local garageDoorPlaceHolder = house.GARAGEDOORPLACEHOLDER
	-- Clear existing children (only if needed)
	if #(garageDoorPlaceHolder:GetChildren()) > 0 then
		garageDoorPlaceHolder:ClearAllChildren()
	end
	
	-- Clone the garage door before applying transformations
	local newGarageDoor = garageDoor:Clone()
	
	-- Fix Position
	if newGarageDoor.PrimaryPart then
		local newPosition = garageDoorPlaceHolder.Position
		local newOrientation = CFrame.Angles(
			math.rad(garageDoorPlaceHolder.Orientation.X),
			math.rad(garageDoorPlaceHolder.Orientation.Y),
			math.rad(garageDoorPlaceHolder.Orientation.Z)
		)
		--Apply transformation
		newGarageDoor:PivotTo(CFrame.new(newPosition) * newOrientation)
		
		-- Parent new garage door to the placeholder
		newGarageDoor.Parent = garageDoorPlaceHolder
	else
		warn("Error. New garage has no PrimaryPart set.")
		newGarageDoor:Destroy()
	end
	
	-- Keep placeholder but make it invisible
	garageDoorPlaceHolder.Transparency = 1
	
	-- Build Lights
	for _, LightCircuit in ipairs(house.LightSystem:GetChildren()) do
		local lightPlaceHolder = LightCircuit:FindFirstChild("LIGHTPLACEHOLDER")
		
		-- Clear existing children (only if needed)
		if #(lightPlaceHolder:GetChildren()) > 0 then
			lightPlaceHolder:ClearAllChildren()
		end
		
		-- Clone the light before applying transformations
		local newLight = light:Clone()
		
		-- Fix Position
		if newLight.PrimaryPart then
			local newPosition = lightPlaceHolder.Position
			local currentOrientation = newLight.PrimaryPart.CFrame - newLight.PrimaryPart.Position
			
			-- Apply Transformation
			newLight:PivotTo(CFrame.new(newPosition) * currentOrientation)
			
			-- Parent new light to the placeholder
			newLight.Parent = lightPlaceHolder
		else
			warn("Error. New Light has no PrimaryPart set.")
			newLight:Destroy()
		end
		
		-- Keep placeholder but make it invisible
		lightPlaceHolder.Transparency = 1
	end
	
	-- Build MailBox
	local mailBoxPlaceHolder = house.MAILBOXPLACEHOLDER
	-- Clear existing children (only if needed)
	if #(mailBoxPlaceHolder:GetChildren()) > 0 then
		mailBoxPlaceHolder:ClearAllChildren()
	end
	
	-- Clone mail box before applying transformations
	local newMailBox = mailBox:Clone()
	
	-- Fix Position
	if newMailBox.PrimaryPart then
		local newPosition = mailBoxPlaceHolder.Position
		local newOrientation = CFrame.Angles(
			math.rad(mailBoxPlaceHolder.Orientation.X),
			math.rad(mailBoxPlaceHolder.Orientation.Y),
			math.rad(mailBoxPlaceHolder.Orientation.Z)
		)
		--Apply transformation
		newMailBox:PivotTo(CFrame.new(newPosition) * newOrientation)

		-- Parent new garage door to the placeholder
		newMailBox.Parent = mailBoxPlaceHolder
	else
		warn("Error. New garage has no PrimaryPart set.")
		newMailBox:Destroy()
	end

	-- Keep placeholder but make it invisible
	mailBoxPlaceHolder.Transparency = 1
end

return Constructor