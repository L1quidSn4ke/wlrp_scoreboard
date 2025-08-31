local QBCore = exports['qb-core']:GetCoreObject()

-- Server event to update active heists
RegisterServerEvent('scoreboard:updateHeists')
AddEventHandler('scoreboard:updateHeists', function()
    local heists = {} -- List of active heists (replace with actual logic)

    -- TODO: Add logic here to populate 'heists' based on current game state
    -- Example: Check active robberies, store locations, etc.

    TriggerClientEvent('scoreboard:sendHeists', -1, heists)
end)

-- Periodic update every 30 seconds
CreateThread(function()
    while true do
        Wait(30000) -- Update interval: 30 seconds
        TriggerEvent('scoreboard:updateHeists')
    end
end)