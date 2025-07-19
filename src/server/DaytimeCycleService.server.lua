local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local inGameSecondsPerRealSecond = 2
local lastTick = tick()
local accumulatedSeconds = 22000

local updateInterval = 0.25  -- how often we apply to Lighting
local timeSinceLastUpdate = 0

RunService.Heartbeat:Connect(function()
    local currentTick = tick()
    local deltaTime = currentTick - lastTick
    lastTick = currentTick

    -- progress the in-game time every frame internally
    accumulatedSeconds = accumulatedSeconds + deltaTime * inGameSecondsPerRealSecond
    timeSinceLastUpdate = timeSinceLastUpdate + deltaTime

    if timeSinceLastUpdate >= updateInterval then
        timeSinceLastUpdate = 0

        local totalSecondsInDay = 86400
        local newTime = accumulatedSeconds % totalSecondsInDay

        local h = math.floor(newTime / 3600) % 24
        local m = math.floor((newTime % 3600) / 60)
        local s = math.floor(newTime % 60)

        Lighting.TimeOfDay = string.format("%02d:%02d:%02d", h, m, s)
    end
end)
