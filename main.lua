-- Advanced Roblox GUI Library with Themes, Animations & Keybinds

local UIS = game:GetService("UserInputService")
local function DestroyExistingGUI()
    for _ = 1, 50 do 
        local existingGUI = game.CoreGui:FindFirstChild("AdvancedGUI")
        if existingGUI then existingGUI:Destroy() end
    end
end

DestroyExistingGUI()

wait(0.05)

local Library = {}

-- Loading Screen
local LoadingScreen = Instance.new("ScreenGui")
local LoadingFrame = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")

LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Parent = game.CoreGui

LoadingFrame.Parent = LoadingScreen
LoadingFrame.Size = UDim2.new(0, 300, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Text = "Loading GUI..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 18

wait(3) -- Simulate loading time
LoadingScreen:Destroy()

-- Key System
local KeySystemScreen = Instance.new("ScreenGui")
local KeyFrame = Instance.new("Frame")
local KeyInput = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")

KeySystemScreen.Name = "KeySystemScreen"
KeySystemScreen.Parent = game.CoreGui

KeyFrame.Parent = KeySystemScreen
KeyFrame.Size = UDim2.new(0, 300, 0, 100)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

KeyInput.Parent = KeyFrame
KeyInput.Size = UDim2.new(1, 0, 0, 40)
KeyInput.Position = UDim2.new(0, 0, 0, 10)
KeyInput.PlaceholderText = "Enter Key"
KeyInput.Font = Enum.Font.GothamBold
KeyInput.TextSize = 14
KeyInput.TextColor3 = Color3.fromRGB(0, 0, 0)

SubmitButton.Parent = KeyFrame
SubmitButton.Size = UDim2.new(1, 0, 0, 40)
SubmitButton.Position = UDim2.new(0, 0, 0, 50)
SubmitButton.Text = "Submit"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 14
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == "SubTo _V5Q" then
        KeySystemScreen:Destroy()
    else
        KeyInput.Text = "Invalid Key!"
    end
end)

function Library:CreateWindow(windowTitle, keybind)
    print("Creating Window: " .. windowTitle)
    local GUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Corner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local TabContainer = Instance.new("Frame")
    local PageContainer = Instance.new("Frame")
    local Notification = Instance.new("TextLabel")
    local Theme = {MainColor = Color3.fromRGB(25, 25, 25), AccentColor = Color3.fromRGB(40, 40, 40)}
    local isGUIVisible = true
    
    -- GUI Properties
    GUI.Name = "AdvancedGUI"
    GUI.Parent = game.CoreGui
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    GUI.ResetOnSpawn = false
    
    MainFrame.Parent = GUI
    MainFrame.BackgroundColor3 = Theme.MainColor
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.Size = UDim2.new(0, 450, 0, 320)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame
    
    -- Top Bar
    TopBar.Parent = MainFrame
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    
    Title.Parent = TopBar
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = windowTitle
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Position = UDim2.new(0, 10, 0, 0)
    
    -- Buttons (Close & Minimize)
    CloseButton.Parent = TopBar
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Text = "X"
    
    MinimizeButton.Parent = TopBar
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.Text = "-"
    
    return Library
end

return Library
