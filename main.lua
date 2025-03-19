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

function Library:CreateWindow(windowTitle, keybind)
    local GUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Corner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("ImageButton")
    local MinimizeButton = Instance.new("ImageButton")
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
    CloseButton.Image = "rbxassetid://124537315431255"
    CloseButton.BackgroundTransparency = 1
    
    MinimizeButton.Parent = TopBar
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.Image = "rbxassetid://83319488809387"
    MinimizeButton.BackgroundTransparency = 1
    
    -- Notification
    Notification.Parent = GUI
    Notification.Size = UDim2.new(0, 300, 0, 50)
    Notification.Position = UDim2.new(0.5, -150, 0.5, -25)
    Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notification.Font = Enum.Font.GothamBold
    Notification.TextSize = 14
    Notification.Visible = false
    Notification.Text = ""
    
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        isGUIVisible = false
        Notification.Text = "Script Closed. To Open It Again Press " .. keybind
        Notification.Visible = true
        wait(3)
        Notification.Visible = false
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    -- Keybind to Open GUI
    UIS.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode[keybind] then
            MainFrame.Visible = not MainFrame.Visible
            isGUIVisible = not isGUIVisible
        end
    end)
    
    -- Tabs & Pages
    TabContainer.Parent = MainFrame
    TabContainer.Size = UDim2.new(0, 120, 1, -30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundColor3 = Theme.AccentColor
    
    PageContainer.Parent = MainFrame
    PageContainer.Size = UDim2.new(1, -120, 1, -30)
    PageContainer.Position = UDim2.new(0, 120, 0, 30)
    PageContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    local function AddTab(tabName, page)
        local Tab = Instance.new("TextButton")
        Tab.Parent = TabContainer
        Tab.Size = UDim2.new(1, 0, 0, 40)
        Tab.BackgroundColor3 = Theme.AccentColor
        Tab.Text = tabName
        Tab.Font = Enum.Font.GothamSemibold
        Tab.TextSize = 14
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local function ShowPage()
            for _, child in pairs(PageContainer:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            page.Visible = true
        end
        
        Tab.MouseButton1Click:Connect(ShowPage)
        return ShowPage
    end
    
    local function CreatePage()
        local Page = Instance.new("Frame")
        Page.Parent = PageContainer
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        return Page
    end
    
    return {
        AddTab = AddTab,
        CreatePage = CreatePage,
        SetTheme = function(newTheme)
            Theme.MainColor = newTheme.MainColor or Theme.MainColor
            Theme.AccentColor = newTheme.AccentColor or Theme.AccentColor
            MainFrame.BackgroundColor3 = Theme.MainColor
            TabContainer.BackgroundColor3 = Theme.AccentColor
        end
    }
end

return Library
