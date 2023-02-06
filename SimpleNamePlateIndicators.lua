
function formatHp(hp)
    if(hp > 999999) then
        return (math.floor(hp/100000)/10).. " M"
    else
        return math.floor(hp/1000) .. " K"
    end
end

function numWithCommas(n)
  return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
                                :gsub(",(%-?)$","%1"):reverse()
end

hooksecurefunc("CompactUnitFrame_UpdateHealth", function(frame)

    if not frame:IsForbidden() then

        if not frame.health and frame.healthBar then
            frame.health = CreateFrame("Frame", nil, frame, "BackdropTemplate") -- Setting up health display frames.
 
            local backdrop = {
	            edgeFile = "Interface\\Buttons\\WHITE8x8",
	            tileEdge = true,
	            edgeSize = 1,
	            insets = {left = 4, right = 4, top = 4, bottom = 4},
            }
            
            local borderWidth = 2
			
	        local backdrop = {
		        edgeFile = "Interface\\Buttons\\WHITE8x8",
		        tileEdge = false,
		        edgeSize = borderWidth,
		        insets = {left = 10, right = 10, top = 0, bottom = 0},
	        }


	        frame.selectionHighlightTwo = CreateFrame("Frame", 'Frame', frame.healthBar, "BackdropTemplate")
            
            frame.selectionHighlightTwo:SetFrameLevel(frame:GetFrameLevel() + 0)
	        frame.selectionHighlightTwo:SetAllPoints()
            frame.selectionHighlightTwo:SetAlpha(1)
            frame.selectionHighlightTwo:SetPoint("CENTER")


            frame.selectionHighlightTwo.tex = frame.selectionHighlightTwo:CreateTexture('_text','ARTWORK')
            frame.selectionHighlightTwo.tex:SetPoint("CENTER")
	        frame.selectionHighlightTwo.tex:SetSize(132, 15)
	        frame.selectionHighlightTwo.tex:SetColorTexture(1,1,1,0.4);

            frame.health:SetSize(170,16)
            frame.health.text = frame.health.text or frame.health:CreateFontString(nil, "OVERLAY")
            frame.health.text:SetAllPoints(true)
            frame.health:SetFrameStrata("HIGH")
            frame.health:SetPoint("CENTER", frame.healthBar)
            frame.health.text:SetVertexColor(1, 1, 1)

            local dps_frame = CreateFrame("Frame", nil, frame)
            dps_frame:SetSize(24, 24)
            dps_frame:SetPoint("RIGHT", 15, -5)
            local DpsTexture = dps_frame:CreateTexture("texture", "background")
            DpsTexture:SetPoint("CENTER")
            DpsTexture:SetSize(24, 20)
            DpsTexture:SetDrawLayer("Background", 0)
            DpsTexture:SetAllPoints(dps_frame)
            DpsTexture:Show()
            frame.DpsTexture = DpsTexture
    
        end

    if ( UnitIsUnit(frame.unit, "target") ) then
        frame.selectionHighlightTwo:Show()
    else 
        frame.selectionHighlightTwo:Hide()
    end

    frame.health.text:SetFont("FONTS\\FRIZQT__.TTF", 8, "OUTLINE")

    local englishFaction, localizedFaction = UnitFactionGroup(frame.unit)   

    if (englishFaction == 'Alliance') then
        frame.DpsTexture:Show()
        frame.DpsTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-ALLIANCE")
    elseif (englishFaction == 'Horde') then
        frame.DpsTexture:Show()
        frame.DpsTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")
    else 
        frame.DpsTexture:Hide()
    end
	
    --    Alliance   = "|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:14:14:0:0:64:64:10:36:2:38|t",
        --Horde      = "|TInterface\\TargetingFrame\\UI-PVP-HORDE:14:14:0:0:64:64:4:38:2:36|t",

   
         local hp = formatHp(UnitHealth(frame.unit))
         local hpMax = formatHp(UnitHealthMax(frame.unit));


    frame.health.text:SetText(hp .. ' / ' .. hpMax) -- Update health numbers + percentages (player.)
    frame.health.text:Show() -- Thanks Blizzard...

    end
end)
