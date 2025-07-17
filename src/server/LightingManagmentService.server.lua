-- Important services and modules importing
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- Instructions to access folders
local PathInstructions = {
    MinimalHouse = {
        Brick = {
            "Houses", "MinimalHouse", "Structure", "Bricks", "Brick"
        },
        Light = {
            "Houses", "MinimalHouse", "LightSystem", "ANY", "LIGHTPLACEHOLDER", "LightModel", "LightPart", "ArtificialLight"
        },
        ProximityPrompt = {
            "Houses", "MinimalHouse", "LightSystem", "ANY", "Interruptor", "MainBody", "Union", "ProximityPrompt"
        },
        Sound = {
            "Houses", "MinimalHouse","LightSystem", "ANY", "Interruptor", "MainBody", "Union", "SwitchSound"
        },
        SwitchOn = {
            "Houses", "MinimalHouse", "LightSystem", "ANY", "Interruptor", "On"
        },
        SwitchOff = {
            "Houses", "MinimalHouse", "LightSystem", "ANY", "Interruptor", "Off"
        }
    }
}

local function nestLoops(path, currentInstances, collectedData, cycle, target)
    -- if we've reached the end of the path, stop
    if cycle > #path then
        return
    end

    local currentName = path[cycle]

    for _, instance in ipairs(currentInstances) do
        -- if this step is ANY, we don't check name
        if currentName == "ANY" or instance.Name == currentName then
            -- if this is the last step in the path
            if cycle == #path then
                if instance.Name == target then
                    print("Target found")
                    table.insert(collectedData, instance)
                end
            else
                -- recurse deeper with this instance's children
                task.wait()
                nestLoops(path, instance:GetChildren(), collectedData, cycle + 1, target)
            end
        end
    end
end

local function getAllInstancesFromPath(path)
    local collectedInstances = {}
    local root = workspace.Place
    local target = path[#path]

    nestLoops(path, root:GetChildren(), collectedInstances, 1, target)

    return collectedInstances
end

-- Check if the place is fully loaded
local place = workspace.Place

while true do
    task.wait(0.01)
    if place:GetAttribute("IsLoaded") then
        break
    end
end

local LightsFolder = getAllInstancesFromPath(PathInstructions["MinimalHouse"]["Brick"])

print(LightsFolder)