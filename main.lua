-- Define the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a draggable frame for the UI
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Draggable = true

-- Minimize/Close Buttons
local closeButton = Instance.new("TextButton")
closeButton.Parent = mainFrame
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(1, -60, 0, 10)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false  -- Close the UI
end)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = mainFrame
minimizeButton.Size = UDim2.new(0, 50, 0, 50)
minimizeButton.Position = UDim2.new(1, -120, 0, 10)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Size = UDim2.new(0, 400, 0, 36)  -- Minimize the UI
end)

-- Hide/Show UI Button
local hideButton = Instance.new("TextButton")
hideButton.Parent = screenGui
hideButton.Size = UDim2.new(0, 100, 0, 50)
hideButton.Position = UDim2.new(0.5, -50, 0.95, -60)
hideButton.Text = "Hide UI"
hideButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false  -- Hide the entire GUI
end)

-- Show UI again (from settings)
local showButton = Instance.new("TextButton")
showButton.Parent = screenGui
showButton.Size = UDim2.new(0, 100, 0, 50)
showButton.Position = UDim2.new(0.5, -50, 0.95, -110)
showButton.Text = "Show UI"
showButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = true  -- Show the GUI again
end)

-- Color Customization (Example of Color Change)
local colorButton = Instance.new("TextButton")
colorButton.Parent = mainFrame
colorButton.Size = UDim2.new(0, 100, 0, 50)
colorButton.Position = UDim2.new(0.5, -50, 0, 100)
colorButton.Text = "Change Color"
colorButton.MouseButton1Click:Connect(function()
    mainFrame.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
end)

-- Loading Screen (example with progress bar)
local loadingFrame = Instance.new("Frame")
loadingFrame.Parent = screenGui
loadingFrame.Size = UDim2.new(0, 400, 0, 500)
loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingFrame.Visible = true

local progressBar = Instance.new("Frame")
progressBar.Parent = loadingFrame
progressBar.Size = UDim2.new(0, 0, 0, 50)
progressBar.Position = UDim2.new(0.5, -200, 0.5, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local loadingText = Instance.new("TextLabel")
loadingText.Parent = loadingFrame
loadingText.Size = UDim2.new(1, 0, 0, 50)
loadingText.Position = UDim2.new(0, 0, 0, -60)
loadingText.Text = "Loading..."
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Simulate loading
for i = 1, 100 do
    wait(0.05)
    progressBar.Size = UDim2.new(i/100, 0, 0, 50)
end
wait(1)
loadingFrame.Visible = false  -- Hide loading screen after completion

-- Key System
local keySystemFrame = Instance.new("Frame")
keySystemFrame.Parent = mainFrame
keySystemFrame.Size = UDim2.new(0, 400, 0, 200)
keySystemFrame.Position = UDim2.new(0, 0, 0, 150)
keySystemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local keyLabel = Instance.new("TextLabel")
keyLabel.Parent = keySystemFrame
keyLabel.Size = UDim2.new(1, 0, 0, 50)
keyLabel.Position = UDim2.new(0, 0, 0, 10)
keyLabel.Text = "Enter Key"
keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local keyTextBox = Instance.new("TextBox")
keyTextBox.Parent = keySystemFrame
keyTextBox.Size = UDim2.new(1, -20, 0, 50)
keyTextBox.Position = UDim2.new(0, 10, 0, 60)
keyTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keyTextBox.ClearTextOnFocus = false
keyTextBox.PlaceholderText = "Enter your key here"
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local submitButton = Instance.new("TextButton")
submitButton.Parent = keySystemFrame
submitButton.Size = UDim2.new(0, 100, 0, 50)
submitButton.Position = UDim2.new(0.5, -50, 1, -60)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
submitButton.MouseButton1Click:Connect(function()
    local enteredKey = keyTextBox.Text
    if enteredKey == "SECRETKEY" then
        -- Unlock functionality after correct key
        print("Key is correct!")
        keySystemFrame.Visible = false
        mainFrame.Visible = true  -- Show the UI after key is correct
    else
        -- Incorrect key message
        print("Incorrect Key!")
        keyTextBox.Text = ""
    end
end)

-- Player Selector (Dropdown style)
local playerSelectorFrame = Instance.new("Frame")
playerSelectorFrame.Parent = mainFrame
playerSelectorFrame.Size = UDim2.new(0, 400, 0, 100)
playerSelectorFrame.Position = UDim2.new(0, 0, 0, 250)
playerSelectorFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local playerDropdown = Instance.new("TextButton")
playerDropdown.Parent = playerSelectorFrame
playerDropdown.Size = UDim2.new(0, 400, 0, 50)
playerDropdown.Position = UDim2.new(0, 0, 0, 25)
playerDropdown.Text = "Select a Player"
playerDropdown.BackgroundColor3 = Color3.fromRGB(0, 100, 255)

local playerList = Instance.new("ScrollingFrame")
playerList.Parent = playerSelectorFrame
playerList.Size = UDim2.new(1, 0, 0, 200)
playerList.Position = UDim2.new(0, 0, 0, 75)
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 10

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = playerList
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 5)

-- Populate the player list
for _, player in ipairs(game.Players:GetPlayers()) do
    local playerButton = Instance.new("TextButton")
    playerButton.Parent = playerList
    playerButton.Size = UDim2.new(0, 380, 0, 40)
    playerButton.Text = player.Name
    playerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    playerButton.MouseButton1Click:Connect(function()
        print("Selected Player: " .. player.Name)
        playerDropdown.Text = "Selected: " .. player.Name
        playerList.Visible = false  -- Close the player list
    end)
end

-- Toggle player list visibility
playerDropdown.MouseButton1Click:Connect(function()
    playerList.Visible = not playerList.Visible
end)
