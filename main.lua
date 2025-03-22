-- ModuleScript: UILibrary.lua
local UILibrary = {}
local TweenService = game:GetService("TweenService")

-- ========== CORE FUNCTIONS ==========
function UILibrary:CreateScreen(parent)
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Parent = parent or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return gui
end

-- ========== LOADING SCREEN ==========
function UILibrary:LoadingScreen()
    local gui = self:CreateScreen()
    gui.Name = "LoadingScreen"
    gui.IgnoreGuiInset = true

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    container.Parent = gui

    local logo = Instance.new("ImageLabel")
    logo.Image = "rbxassetid://your_image_id"
    logo.Size = UDim2.new(0.3, 0, 0.3, 0)
    logo.Position = UDim2.new(0.35, 0, 0.2, 0)
    logo.Parent = container

    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0.4, 0, 0.02, 0)
    progressBar.Position = UDim2.new(0.3, 0, 0.6, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    progressBar.Parent = container

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    fill.Parent = progressBar

    local percentage = Instance.new("TextLabel")
    percentage.Text = "0%"
    percentage.Font = Enum.Font.GothamBold
    percentage.TextColor3 = Color3.new(1, 1, 1)
    percentage.Size = UDim2.new(1, 0, 0.1, 0)
    percentage.Position = UDim2.new(0, 0, 0.65, 0)
    percentage.Parent = container

    return {
        Gui = gui,
        Update = function(percent)
            fill.Size = UDim2.new(percent/100, 0, 1, 0)
            percentage.Text = math.floor(percent).."% Loaded"
        end,
        Destroy = function()
            gui:Destroy()
        end
    }
end

-- ========== CHARACTER SELECTOR ==========
function UILibrary:CharacterSelector(characters)
    local gui = self:CreateScreen()
    gui.Name = "CharacterSelect"

    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.8, 0, 0.8, 0)
    container.Position = UDim2.new(0.1, 0, 0.1, 0)
    container.BackgroundTransparency = 1
    container.Parent = gui

    local layout = Instance.new("UIGridLayout")
    layout.CellSize = UDim2.new(0.2, 0, 0.3, 0)
    layout.CellPadding = UDim2.new(0.05, 0, 0.05, 0)
    layout.Parent = container

    local selected
    local event = Instance.new("BindableEvent")

    for _, char in pairs(characters) do
        local button = Instance.new("TextButton")
        button.Text = char.Name
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.GothamBold
        
        local icon = Instance.new("ImageLabel")
        icon.Image = char.Icon
        icon.Size = UDim2.new(0.8, 0, 0.6, 0)
        icon.Position = UDim2.new(0.1, 0, 0.1, 0)
        icon.Parent = button

        button.MouseButton1Click:Connect(function()
            if selected then
                selected.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
            selected = button
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            event:Fire(char)
        end)
        
        button.Parent = container
    end

    return {
        Gui = gui,
        Selected = event.Event,
        Destroy = function()
            gui:Destroy()
        end
    }
end

-- ========== COLOR PICKER ==========
function UILibrary:ColorPicker(defaultColor)
    local gui = self:CreateScreen()
    local currentColor = defaultColor or Color3.new(1, 1, 1)

    -- Main container
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.4, 0, 0.5, 0)
    main.Position = UDim2.new(0.3, 0, 0.25, 0)
    main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main.Parent = gui

    -- Color preview
    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0.2, 0, 0.2, 0)
    preview.Position = UDim2.new(0.75, 0, 0.1, 0)
    preview.BackgroundColor3 = currentColor
    preview.Parent = main

    -- RGB Sliders
    local sliders = {
        self:CreateSlider(main, "R", 0.05, 0.75, Color3.fromRGB(255, 0, 0)),
        self:CreateSlider(main, "G", 0.05, 0.85, Color3.fromRGB(0, 255, 0)),
        self:CreateSlider(main, "B", 0.05, 0.95, Color3.fromRGB(0, 0, 255))
    }

    -- HSV Picker
    local hueMap = Instance.new("ImageButton")
    hueMap.Size = UDim2.new(0.6, 0, 0.6, 0)
    hueMap.Position = UDim2.new(0.05, 0, 0.1, 0)
    hueMap.Image = "rbxassetid://your_hsv_texture_id"
    hueMap.Parent = main

    -- Value slider
    local valueSlider = self:CreateSlider(main, "Value", 0.75, 0.85)

    local event = Instance.new("BindableEvent")

    local function UpdateColor(color, source)
        currentColor = color
        preview.BackgroundColor3 = color
        
        if source ~= "rgb" then
            sliders[1]:Set(color.R * 255)
            sliders[2]:Set(color.G * 255)
            sliders[3]:Set(color.B * 255)
        end
        
        event:Fire(color)
    end

    hueMap.MouseButton1Down:Connect(function(x, y)
        local relX = (x - hueMap.AbsolutePosition.X) / hueMap.AbsoluteSize.X
        local relY = (y - hueMap.AbsolutePosition.Y) / hueMap.AbsoluteSize.Y
        local h = math.clamp(relX, 0, 1)
        local s = 1 - math.clamp(relY, 0, 1)
        local _, _, v = Color3.toHSV(currentColor)
        UpdateColor(Color3.fromHSV(h, s, v), "hsv")
    end)

    for _, slider in pairs(sliders) do
        slider.Changed:Connect(function()
            UpdateColor(Color3.new(
                sliders[1].Value/255,
                sliders[2].Value/255,
                sliders[3].Value/255
            ), "rgb")
        end)
    end

    valueSlider.Changed:Connect(function(val)
        local h, s = Color3.toHSV(currentColor)
        UpdateColor(Color3.fromHSV(h, s, val/100), "hsv")
    end)

    return {
        Gui = gui,
        ColorChanged = event.Event,
        Destroy = function()
            gui:Destroy()
        end
    }
end

function UILibrary:CreateSlider(parent, label, x, y, color)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.9, 0, 0.08, 0)
    slider.Position = UDim2.new(x, 0, y, 0)
    slider.BackgroundTransparency = 1
    slider.Parent = parent

    local title = Instance.new("TextLabel")
    title.Text = label
    title.Size = UDim2.new(0.15, 0, 1, 0)
    title.Font = Enum.Font.Gotham
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Parent = slider

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0.7, 0, 0.5, 0)
    track.Position = UDim2.new(0.2, 0, 0.25, 0)
    track.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    track.Parent = slider

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0.5, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    fill.Parent = track

    local value = Instance.new("TextLabel")
    value.Text = "0"
    value.Size = UDim2.new(0.15, 0, 1, 0)
    value.Position = UDim2.new(0.9, 0, 0, 0)
    value.Font = Enum.Font.Gotham
    value.TextColor3 = Color3.new(1, 1, 1)
    value.Parent = slider

    local event = Instance.new("BindableEvent")
    local dragging = false

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = label == "Value" and math.floor(pos * 100) or math.floor(pos * 255)
            value.Text = tostring(val)
            event:Fire(val)
        end
    end)

    return {
        Changed = event.Event,
        Set = function(val)
            local pos = val / (label == "Value" and 100 or 255)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            value.Text = tostring(val)
        end
    }
end

-- ========== NOTIFICATIONS ==========
function UILibrary:Notify(title, message, duration)
    local gui = self:CreateScreen()
    gui.Name = "Notification"

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.25, 0, 0.1, 0)
    main.Position = UDim2.new(0.75, 0, 0.05, 0)
    main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main.Parent = gui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    titleLabel.Parent = main

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = message
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    messageLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
    messageLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
    messageLabel.Parent = main

    TweenService:Create(main, TweenInfo.new(0.5), {Position = UDim2.new(0.75, 0, 0.03, 0)}):Play()
    
    task.wait(duration or 5)
    
    TweenService:Create(main, TweenInfo.new(0.5), {Position = UDim2.new(0.75, 0, -0.2, 0)}):Play()
    task.wait(0.5)
    gui:Destroy()
end

return UILibrary
