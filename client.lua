-- client.lua

local isScoreboardOpen = false

-- Function to open the scoreboard
local function openScoreboard()
    SetNuiFocus(true, true)
    SendNUIMessage({ type = "open" })
    isScoreboardOpen = true
end

-- Function to close the scoreboard
local function closeScoreboard()
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "close" })
    isScoreboardOpen = false
end

-- Register /board command to toggle scoreboard
RegisterCommand("board", function()
    if isScoreboardOpen then
        closeScoreboard()
    else
        openScoreboard()
    end
end, false)

-- Optional: Toggle scoreboard with HOME key
--[[ Uncomment to enable keybind
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 213) then -- HOME key
            if isScoreboardOpen then
                closeScoreboard()
            else
                openScoreboard()
            end
        end
    end
end)
]]

-- Handle ESC key or manual close from NUI
RegisterNUICallback("close", function(_, cb)
    closeScoreboard()
    cb("ok")
end)

-- Receive updated player data from server
RegisterNetEvent("scoreboard:updatePlayers")
AddEventHandler("scoreboard:updatePlayers", function(data)
    SendNUIMessage({
        type = "update",
        players = data.players,
        police = data.police,
        medics = data.medics,
        taxis = data.taxis,
        municipal = data.municipal,
        heists = data.heists
    })
end)