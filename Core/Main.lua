local addonName, Muzzle = ...

-- Initialize modules
Muzzle.OptionsPanel = Muzzle.OptionsPanel or {}

local function InitializeAddon()
    -- Initialize OptionsPanel
    Muzzle.OptionsPanel:Initialize()
end

-- Slash command
SLASH_MUZZLE1 = "/muzzle"
SlashCmdList["MUZZLE"] = function(msg)
    Muzzle.OptionsPanel:Open()
end

-- Event frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, loadedAddonName)
    if event == "ADDON_LOADED" and loadedAddonName == addonName then
        InitializeAddon()
    end
end)