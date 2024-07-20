local addonName, Muzzle = ...

-- Initialize the OptionsPanel table
Muzzle.OptionsPanel = Muzzle.OptionsPanel or {}
local OP = Muzzle.OptionsPanel

-- Create a basic localization table if it doesn't exist
Muzzle.L = Muzzle.L or setmetatable({}, {
    __index = function(t, k)
        local v = tostring(k)
        rawset(t, k, v)
        return v
    end
})
local L = Muzzle.L

-- Initialize settings if they don't exist
Muzzle.settings = Muzzle.settings or {
    showOffline = false,
    showMinimap = true,
}

local MuzzleOptionsFrame = CreateFrame("Frame", "MuzzleOptionsFrame", UIParent, "BackdropTemplate")
MuzzleOptionsFrame:SetFrameStrata("DIALOG")
MuzzleOptionsFrame:SetFrameLevel(5)
MuzzleOptionsFrame:SetSize(650, 455)
MuzzleOptionsFrame:SetPoint("CENTER", UIParent, "CENTER")
MuzzleOptionsFrame:SetMovable(true)
MuzzleOptionsFrame:EnableMouse(true)
MuzzleOptionsFrame:RegisterForDrag("LeftButton")
MuzzleOptionsFrame:SetClampedToScreen(true)
MuzzleOptionsFrame:Hide()

MuzzleOptionsFrame.background = MuzzleOptionsFrame:CreateTexture(nil, "BACKGROUND")
MuzzleOptionsFrame.background:SetAllPoints(MuzzleOptionsFrame)
MuzzleOptionsFrame.background:SetColorTexture(0, 0, 0, 0.8)

local menuBar = CreateFrame("Frame", "$parentMenuBar", MuzzleOptionsFrame)
menuBar:SetWidth(50)
menuBar:SetHeight(455)
menuBar:SetPoint("TOPLEFT", MuzzleOptionsFrame, "TOPLEFT")
menuBar.texture = menuBar:CreateTexture(nil, "BACKGROUND")
menuBar.texture:SetAllPoints(menuBar)
menuBar.texture:SetColorTexture(33/255, 33/255, 33/255, 0.8)

MuzzleOptionsFrame:SetScript("OnDragStart", MuzzleOptionsFrame.StartMoving)
MuzzleOptionsFrame:SetScript("OnDragStop", MuzzleOptionsFrame.StopMovingOrSizing)

-- Remove the existing close button
if closeButton then
    closeButton:Hide()
    closeButton = nil
end

-- Create a new custom close button
local closeButton = CreateFrame("Button", "$parentCloseButton", MuzzleOptionsFrame)
closeButton:SetSize(12, 12)
closeButton:SetPoint("TOPRIGHT", MuzzleOptionsFrame, "TOPRIGHT", -14, -14)

-- Set the button textures
closeButton:SetNormalTexture("Interface\\AddOns\\Muzzle\\Media\\Texture\\baseline-close-24px@2x.tga")
closeButton:GetNormalTexture():SetVertexColor(0.8, 0.8, 0.8, 0.8)

-- Set up scripts for hover effects and click functionality
closeButton:SetScript("OnEnter", function(self)
    self:GetNormalTexture():SetVertexColor(126/255, 126/255, 126/255, 0.8)
end)

closeButton:SetScript("OnLeave", function(self)
    self:GetNormalTexture():SetVertexColor(0.8, 0.8, 0.8, 0.8)
end)

closeButton:SetScript("OnClick", function()
    MuzzleOptionsFrame:Hide()
end)

-- Content frame to anchor all option panels
local contentFrame = CreateFrame("Frame", "MuzzleFrame_OptionContent", MuzzleOptionsFrame)
contentFrame:SetPoint("TOPLEFT", menuBar, "TOPRIGHT", 15, -15)
contentFrame:SetSize(550, 360)

local generalHeader = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
generalHeader:SetText(L["GENERAL OPTIONS"])
generalHeader:SetPoint("TOPLEFT", contentFrame, "TOPLEFT")

-- Helper function to create checkboxes
local function CreateCheckBox(parent, label, onClick)
    local checkbox = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    checkbox.text = checkbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    checkbox.text:SetPoint("LEFT", checkbox, "RIGHT", 0, 1)
    checkbox.text:SetText(label)
    if onClick then
        checkbox:SetScript("OnClick", onClick)
    end
    return checkbox
end

-- Create some sample options
local showOffLine = CreateCheckBox(contentFrame, L["Show offline players"], function(self)
    Muzzle.settings.showOffline = self:GetChecked()
    -- Update frames or do whatever is needed when this option changes
end)
showOffLine:SetPoint("TOPLEFT", generalHeader, "BOTTOMLEFT", 10, -10)

local showMinimap = CreateCheckBox(contentFrame, L["Show Minimap button"], function(self)
    Muzzle.settings.showMinimap = self:GetChecked()
    -- Update minimap button visibility
end)
showMinimap:SetPoint("LEFT", showOffLine, "RIGHT", 150, 0)

-- Function to initialize option settings
local function InitializeOptionSettings()
    showOffLine:SetChecked(Muzzle.settings.showOffline)
    showMinimap:SetChecked(Muzzle.settings.showMinimap)
    -- Initialize other options...
end

MuzzleOptionsFrame:SetScript("OnShow", function(self)
    InitializeOptionSettings()
end)

function OP:Initialize()
    -- Any initialization code can go here
end

function OP:Open()
    MuzzleOptionsFrame:Show()
end

-- Slash command to open options
SLASH_MUZZLE1 = "/muzzle"
SlashCmdList["MUZZLE"] = function(msg)
    OP:Open()
end