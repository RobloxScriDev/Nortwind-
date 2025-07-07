local function fetchModule(url)
    return assert(loadstring(game:HttpGet(url, true)))()
end

local gui = fetchModule("https://raw.githubusercontent.com/RobloxScriDev/Nortwind-/main/Gui.lua")
gui.init()