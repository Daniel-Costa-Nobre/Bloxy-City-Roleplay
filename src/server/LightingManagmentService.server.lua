-- Important services and modules importing
local ServerScriptService = game:GetService("ServerScriptService")
local WorkspaceManager = require(ServerScriptService.WorkspaceManager)

-- Instructions to access folders
local PathInstructions = {
    MinimalHouse = {
        Light = {
            "Houses", "MinimalHouse", "LightSystem", "ANY"
        },
    }
}

-- Check if the place is fully loaded
local place = workspace.Place

while true do
    task.wait(0.01)
    if place:GetAttribute("IsLoaded") then
        break
    end
end

-- Get all useful folders
local MinimalHouseLightsFolder = WorkspaceManager.getAllInstancesFromPath(PathInstructions.MinimalHouse.Light)

for _, LightSctructure in pairs(MinimalHouseLightsFolder) do
    -- Fetch important instances inside the light structure
    local proximityPrompt = LightSctructure:FindFirstChild("Interruptor"):FindFirstChild("ProximityPromptPart"):FindFirstChild("ProximityPrompt")
    local onSwitch = LightSctructure:FindFirstChild("Interruptor"):FindFirstChild("On")
    local offSwitch = LightSctructure:FindFirstChild("Interruptor"):FindFirstChild("Off")
    local switchSound = LightSctructure:FindFirstChild("Interruptor"):FindFirstChild("MainBody"):FindFirstChild("Union"):FindFirstChild("SwitchSound")
    local spotLight = LightSctructure:FindFirstChild("LIGHTPLACEHOLDER"):FindFirstChild("LightModel"):FindFirstChild("LightPart"):FindFirstChild("ArtificialLight")

    proximityPrompt.Triggered:Connect(function()
        if spotLight.Enabled then
            proximityPrompt.ActionText = ""
            proximityPrompt.Enabled = false
            -- Disable light
            spotLight.Enabled = false

            -- Reset sound and play again
            switchSound:Stop()
            switchSound:Play()

            -- Visible change
            onSwitch.Transparency = 0
            offSwitch.Transparency = 1
        else
            proximityPrompt.ActionText = ""
            proximityPrompt.Enabled = false
            -- Enable light
            spotLight.Enabled = true

            -- Reset sound and play again
            switchSound:Stop()
            switchSound:Play()

            -- Visible change
            onSwitch.Transparency = 1
            offSwitch.Transparency = 0
        end

        -- Cooldown
        task.wait(0.5)
        if spotLight.Enabled then proximityPrompt.ActionText = "Turn off" else proximityPrompt.ActionText = "Turn on" end

        proximityPrompt.Enabled = true
    end)
end