-- VEXORA KEY GATE (server-validated; keep the Supabase service-role key out of this file)
do
    local VEXORA_PROJECT_URL = "https://phxpqrzhhzdasnoytvcs.supabase.co"
    local VEXORA_PUBLISHABLE_KEY = "sb_publishable_tAZCQzelVQB1_nRqaRPd7g_Jkrb600l"
    local VEXORA_VALIDATE_URL = VEXORA_PROJECT_URL .. "/functions/v1/validate-vexora-key"

    local VEXORA_Players = game:GetService("Players")
    local VEXORA_HttpService = game:GetService("HttpService")
    local VEXORA_Player = VEXORA_Players.LocalPlayer
    local VEXORA_Authorized, VEXORA_Cancelled, VEXORA_Busy = false, false, false

    local function VEXORA_RequestFunction()
        local candidates = {
            rawget(_G, "request"), rawget(_G, "http_request"), rawget(_G, "httprequest"),
        }
        local ok, synTable = pcall(function() return syn end)
        if ok and type(synTable) == "table" then candidates[#candidates + 1] = synTable.request end
        local okHttp, httpTable = pcall(function() return http end)
        if okHttp and type(httpTable) == "table" then candidates[#candidates + 1] = httpTable.request end
        for _, candidate in ipairs(candidates) do
            if type(candidate) == "function" then return candidate end
        end
        return nil
    end

    local VEXORA_Parent
    pcall(function()
        if type(gethui) == "function" then VEXORA_Parent = gethui() end
    end)
    if not VEXORA_Parent then
        pcall(function() VEXORA_Parent = game:GetService("CoreGui") end)
    end
    if not VEXORA_Parent then
        VEXORA_Parent = VEXORA_Player:WaitForChild("PlayerGui")
    end

    local VEXORA_Gui = Instance.new("ScreenGui")
    VEXORA_Gui.Name = "VexoraKeyGate"
    VEXORA_Gui.ResetOnSpawn = false
    VEXORA_Gui.IgnoreGuiInset = true
    VEXORA_Gui.DisplayOrder = 999999
    VEXORA_Gui.Parent = VEXORA_Parent

    local VEXORA_Panel = Instance.new("Frame")
    VEXORA_Panel.Name = "Panel"
    VEXORA_Panel.AnchorPoint = Vector2.new(0.5, 0.5)
    VEXORA_Panel.Position = UDim2.fromScale(0.5, 0.5)
    VEXORA_Panel.Size = UDim2.fromOffset(360, 220)
    VEXORA_Panel.BackgroundColor3 = Color3.fromRGB(14, 14, 19)
    VEXORA_Panel.BorderSizePixel = 0
    VEXORA_Panel.Parent = VEXORA_Gui
    local VEXORA_Corner = Instance.new("UICorner")
    VEXORA_Corner.CornerRadius = UDim.new(0, 14)
    VEXORA_Corner.Parent = VEXORA_Panel
    local VEXORA_Stroke = Instance.new("UIStroke")
    VEXORA_Stroke.Color = Color3.fromRGB(135, 70, 245)
    VEXORA_Stroke.Thickness = 1.4
    VEXORA_Stroke.Transparency = 0.12
    VEXORA_Stroke.Parent = VEXORA_Panel

    local function VEXORA_Label(name, text, pos, size, textSize, color)
        local label = Instance.new("TextLabel")
        label.Name = name
        label.BackgroundTransparency = 1
        label.Position = pos
        label.Size = size
        label.Font = Enum.Font.GothamBold
        label.Text = text
        label.TextSize = textSize
        label.TextColor3 = color
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.Parent = VEXORA_Panel
        return label
    end
    VEXORA_Label("Title", "VEXORA  /  KEY SYSTEM", UDim2.fromOffset(18, 18), UDim2.new(1, -36, 0, 28), 18, Color3.fromRGB(245, 242, 255))
    VEXORA_Label("Subtitle", "Redeem once. Your key is bound to this Roblox account.", UDim2.fromOffset(18, 48), UDim2.new(1, -36, 0, 24), 10, Color3.fromRGB(157, 151, 174))

    local VEXORA_KeyBox = Instance.new("TextBox")
    VEXORA_KeyBox.Name = "KeyInput"
    VEXORA_KeyBox.Position = UDim2.fromOffset(22, 86)
    VEXORA_KeyBox.Size = UDim2.new(1, -44, 0, 40)
    VEXORA_KeyBox.BackgroundColor3 = Color3.fromRGB(25, 24, 32)
    VEXORA_KeyBox.BorderSizePixel = 0
    VEXORA_KeyBox.ClearTextOnFocus = false
    VEXORA_KeyBox.PlaceholderText = "Enter your Vexora key"
    VEXORA_KeyBox.PlaceholderColor3 = Color3.fromRGB(133, 127, 149)
    VEXORA_KeyBox.Text = ""
    VEXORA_KeyBox.TextColor3 = Color3.fromRGB(245, 242, 255)
    VEXORA_KeyBox.TextSize = 13
    VEXORA_KeyBox.Font = Enum.Font.Gotham
    VEXORA_KeyBox.Parent = VEXORA_Panel
    local VEXORA_BoxCorner = Instance.new("UICorner")
    VEXORA_BoxCorner.CornerRadius = UDim.new(0, 9)
    VEXORA_BoxCorner.Parent = VEXORA_KeyBox
    local VEXORA_BoxPad = Instance.new("UIPadding")
    VEXORA_BoxPad.PaddingLeft = UDim.new(0, 12)
    VEXORA_BoxPad.PaddingRight = UDim.new(0, 12)
    VEXORA_BoxPad.Parent = VEXORA_KeyBox

    local VEXORA_Redeem = Instance.new("TextButton")
    VEXORA_Redeem.Name = "RedeemButton"
    VEXORA_Redeem.Position = UDim2.fromOffset(22, 137)
    VEXORA_Redeem.Size = UDim2.new(1, -44, 0, 36)
    VEXORA_Redeem.BackgroundColor3 = Color3.fromRGB(133, 70, 245)
    VEXORA_Redeem.BorderSizePixel = 0
    VEXORA_Redeem.AutoButtonColor = true
    VEXORA_Redeem.Text = "REDEEM KEY"
    VEXORA_Redeem.TextColor3 = Color3.new(1, 1, 1)
    VEXORA_Redeem.TextSize = 12
    VEXORA_Redeem.Font = Enum.Font.GothamBold
    VEXORA_Redeem.Parent = VEXORA_Panel
    local VEXORA_RedeemCorner = Instance.new("UICorner")
    VEXORA_RedeemCorner.CornerRadius = UDim.new(0, 9)
    VEXORA_RedeemCorner.Parent = VEXORA_Redeem

    local VEXORA_Status = VEXORA_Label("Status", "Enter your key to continue.", UDim2.fromOffset(16, 179), UDim2.new(1, -32, 0, 24), 10, Color3.fromRGB(173, 166, 190))

    local function VEXORA_SetStatus(message, color)
        VEXORA_Status.Text = message
        VEXORA_Status.TextColor3 = color or Color3.fromRGB(173, 166, 190)
    end

    local function VEXORA_Validate()
        if VEXORA_Busy or VEXORA_Authorized or VEXORA_Cancelled then return end
        local enteredKey = VEXORA_KeyBox.Text:match("^%s*(.-)%s*$")
        if enteredKey == "" then
            VEXORA_SetStatus("Enter a key first.", Color3.fromRGB(255, 110, 125))
            return
        end
        local httpRequest = VEXORA_RequestFunction()
        if not httpRequest then
            VEXORA_SetStatus("HTTP request function not found.", Color3.fromRGB(255, 110, 125))
            return
        end
        VEXORA_Busy = true
        VEXORA_Redeem.Text = "CHECKING..."
        VEXORA_SetStatus("Checking key securely...", Color3.fromRGB(196, 180, 255))
        task.spawn(function()
            local body
            local encoded, encodeResult = pcall(function()
                return VEXORA_HttpService:JSONEncode({
                    key = enteredKey,
                    userId = tostring(VEXORA_Player.UserId),
                })
            end)
            if not encoded then
                VEXORA_Busy = false
                VEXORA_Redeem.Text = "REDEEM KEY"
                VEXORA_SetStatus("Could not prepare request.", Color3.fromRGB(255, 110, 125))
                return
            end
            local ok, response = pcall(function()
                return httpRequest({
                    Url = VEXORA_VALIDATE_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["apikey"] = VEXORA_PUBLISHABLE_KEY,
                    },
                    Body = encodeResult,
                })
            end)
            VEXORA_Busy = false
            VEXORA_Redeem.Text = "REDEEM KEY"
            if not ok or type(response) ~= "table" then
                VEXORA_SetStatus("Connection failed. Try again.", Color3.fromRGB(255, 110, 125))
                return
            end
            local parsed
            pcall(function() parsed = VEXORA_HttpService:JSONDecode(response.Body or "") end)
            if tonumber(response.StatusCode) == 200 and type(parsed) == "table" and parsed.ok == true then
                VEXORA_Authorized = true
                VEXORA_SetStatus("KEY ACCEPTED — loading Vexora...", Color3.fromRGB(112, 240, 165))
                task.wait(0.55)
                pcall(function() VEXORA_Gui:Destroy() end)
            else
                local reason = type(parsed) == "table" and parsed.status or nil
                local messages = {
                    invalid = "Invalid key.", used = "Key belongs to another account.",
                    expired = "This key has expired.", inactive = "This key is disabled.",
                    bad_request = "Request data was rejected.", rate_limited = "Too many attempts. Try later.",
                }
                VEXORA_SetStatus(messages[reason] or "Key rejected or server not configured.", Color3.fromRGB(255, 110, 125))
            end
        end)
    end

    VEXORA_Redeem.Activated:Connect(VEXORA_Validate)
    VEXORA_KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then VEXORA_Validate() end
    end)
    -- Keep the rest of the script from starting until validation succeeds.
    repeat task.wait(0.1) until VEXORA_Authorized or VEXORA_Cancelled
    if not VEXORA_Authorized then
        pcall(function() VEXORA_Gui:Destroy() end)
    
