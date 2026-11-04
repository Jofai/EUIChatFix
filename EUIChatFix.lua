local addonName = ...

local MAX_CHAT_LINES = 5000

local function ApplyChatHistoryBuffer()
    for i = 1, (NUM_CHAT_WINDOWS or 10) do
        local cf = _G["ChatFrame" .. i]
        if cf and cf.SetMaxLines then
            cf:SetMaxLines(MAX_CHAT_LINES)
        end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self)
    -- 1. Increase buffer size on all chat windows without clearing messages
    ApplyChatHistoryBuffer()

    -- 2. Force opaque background on ChatFrame1EditBox
    local editBox = ChatFrame1EditBox
    if editBox and not editBox.opaqueBg then
        local bg = CreateFrame("Frame", nil, editBox)
        bg:SetFrameStrata("DIALOG")
        bg:SetFrameLevel(math.max(0, editBox:GetFrameLevel() - 1))
        bg:SetAllPoints(editBox)

        local tex = bg:CreateTexture(nil, "BACKGROUND")
        tex:SetAllPoints(bg)
        tex:SetColorTexture(0, 0, 0, 1)

        editBox.opaqueBg = bg
    end
end)