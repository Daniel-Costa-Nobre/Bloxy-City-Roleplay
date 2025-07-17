WorkspaceManager = {}

function WorkspaceManager.getAllInstancesFromPath(path)
    local collected = {}
    local target = path[#path]

    local function recurse(currentInstances, cycle)
        cycle = cycle or 1
        if cycle > #path then return end

        local currentName = path[cycle]
        for _, inst in ipairs(currentInstances) do
            if currentName == "ANY" or inst.Name == currentName then
                if cycle == #path then
                    if inst.Name == target then
                        table.insert(collected, inst)
                    end
                else
                    recurse(inst:GetChildren(), cycle + 1)
                end
            end
        end
    end

    -- start recursion without ever exposing cycle to the caller
    recurse(workspace.Place:GetChildren())

    return collected
end

return WorkspaceManager