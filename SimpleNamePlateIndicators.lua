

function numWithCommas(n)
  return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
                                :gsub(",(%-?)$","%1"):reverse()
end

hooksecurefunc("CompactUnitFrame_UpdateHealth", function(frame)

if not frame:IsForbidden() then
--local healthPercentage = ceil((UnitHealth(frame.displayedUnit) / UnitHealthMax(frame.displayedUnit) * 100)) -- Calculating a percentage value for health.

if not frame.health then
    frame.health = CreateFrame("Frame", nil, frame) -- Setting up health display frames.
    --inv_hordewareffort

    frame.health:SetSize(170,16)
    frame.health.text = frame.health.text or frame.health:CreateFontString(nil, "OVERLAY")
    frame.health.text:SetAllPoints(true)
    frame.health:SetFrameStrata("HIGH")
    frame.health:SetPoint("CENTER", frame.healthBar)
    frame.health.text:SetVertexColor(1, 1, 1)

    local dps_frame = CreateFrame("Frame", nil, frame)
    dps_frame:SetSize(24, 24)
    dps_frame:SetPoint("RIGHT", 15, 0)
    local DpsTexture = dps_frame:CreateTexture("texture", "background")
    DpsTexture:SetPoint("CENTER")
    DpsTexture:SetSize(24, 24)
    DpsTexture:SetDrawLayer("Background", 0)
    DpsTexture:SetAllPoints(dps_frame)
    DpsTexture:Show()
    frame.DpsTexture = DpsTexture
    frame.DpsTexture:SetTexture("Interface\\PVPScoreboard\\PVPScoreboardColumnStats.PNG")
end

frame.health.text:SetFont("FONTS\\FRIZQT__.TTF", 8, "OUTLINE")

local englishFaction, localizedFaction = UnitFactionGroup(frame.unit)   

if (englishFaction == 'Alliance') then
    frame.DpsTexture:Show()
    --left right top bottom
    frame.DpsTexture:SetTexCoord(0,0.25,0,0.25)
elseif (englishFaction == 'Horde') then
    frame.DpsTexture:Show()
    frame.DpsTexture:SetTexCoord(0,0.25,0.25,0.50)
else 
     frame.DpsTexture:Hide()
end
	

frame.health.text:SetText(math.floor(UnitHealth(frame.unit)/1000) .. ' K / ' .. math.floor(UnitHealthMax(frame.unit)/1000) .. ' K' ) -- Update health numbers + percentages (player.)
frame.health.text:Show() -- Thanks Blizzard...

end
end)
