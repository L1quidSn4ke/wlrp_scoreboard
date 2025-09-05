local QBCore = exports['qb-core']:GetCoreObject()

-- Function to gather and broadcast heist data
local function UpdateHeists()
    local heists = {}
    
--Example logic: Replace with actual heist tracking
    --[[local ondutyCops = exports.sg_utils:GetPoliceCount(true)

    for id, data in pairs(ActiveHeists or {}) do
        local statusColor = "red"
        if ondutyCops >= data.requiredcops then
            statusColor = "green"
        end

        table.insert(heists, {
            location = data.label,
            status = statusColor,
            requiredCops = data.requiredcops
        })]]
    end

    TriggerClientEvent('scoreboard:sendHeists', -1, heists)
end

-- Event-based trigger (e.g., manual refresh or menu open)
RegisterServerEvent('scoreboard:updateHeists', function()
    UpdateHeists()
end)
