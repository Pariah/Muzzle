local addonName, Muzzle = ...
Muzzle.Animations = {}
local Anim = Muzzle.Animations

function Anim:FadeIn(frame, duration)
    if not frame.fader then
        frame.fader = frame:CreateAnimationGroup()
        local fade = frame.fader:CreateAnimation("Alpha")
        fade:SetFromAlpha(0)
        fade:SetToAlpha(1)
        fade:SetDuration(duration or 0.3)
    end
    
    frame:SetAlpha(0)
    frame.fader:Play()
end

function Anim:SlideIn(frame, direction, distance, duration)
    if not frame.slider then
        frame.slider = frame:CreateAnimationGroup()
        local slide = frame.slider:CreateAnimation("Translation")
        slide:SetDuration(duration or 0.3)
        
        if direction == "LEFT" then
            slide:SetOffset(distance or 50, 0)
        elseif direction == "RIGHT" then
            slide:SetOffset(-distance or -50, 0)
        elseif direction == "UP" then
            slide:SetOffset(0, -distance or -50)
        elseif direction == "DOWN" then
            slide:SetOffset(0, distance or 50)
        end
    end
    
    frame.slider:Play()
end