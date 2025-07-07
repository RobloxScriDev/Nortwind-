-- Gui.lua

local GuiModule = {}

-- SERVICES
local CoreGui = game:GetService("CoreGui")

function GuiModule.init()
    -- CREATE SCREEN GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NortwindGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui


    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame


    local TabsFrame = Instance.new("Frame")
    TabsFrame.Size = UDim2.new(1, 0, 0, 40)
    TabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabsFrame.Parent = MainFrame

    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 8)
    TabsCorner.Parent = TabsFrame

    local function createTab(name, position)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Position = UDim2.new(0, position, 0, 0)
        TabButton.Text = name
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.TextSize = 14

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = TabButton

        TabButton.MouseEnter:Connect(function()
            TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
        TabButton.MouseLeave:Connect(function()
            TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end)

        TabButton.Parent = TabsFrame

        return TabButton
    end


    local tabNames = {"ESP", "Aimlock", "HBE", "Config"}
    local Tabs = {}
    for i, name in ipairs(tabNames) do
        Tabs[name] = createTab(name, (i - 1) * 105)
    end


    local ContentFrames = {}
    for name, tabButton in pairs(Tabs) do
        local Content = Instance.new("Frame")
        Content.Size = UDim2.new(1, 0, 1, -40)
        Content.Position = UDim2.new(0, 0, 0, 40)
        Content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Content.Visible = false

        local ContentCorner = Instance.new("UICorner")
        ContentCorner.CornerRadius = UDim.new(0, 6)
        ContentCorner.Parent = Content

        Content.Parent = MainFrame

        ContentFrames[name] = Content

        tabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(ContentFrames) do
                frame.Visible = false
            end
            for _, button in pairs(Tabs) do
                button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            Content.Visible = true
            print("Switched to tab:", name)
        end)
    end

    ContentFrames.ESP.Visible = true
    Tabs.ESP.BackgroundColor3 = Color3.fromRGB(0, 120, 255)

    -- CONFIG TAB: Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
    MinimizeButton.Text = "X"
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 14
    MinimizeButton.Parent = ContentFrames.Config

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Parent = MinimizeButton

    local isVisible = true
    MinimizeButton.MouseButton1Click:Connect(function()
        isVisible = not isVisible
        MainFrame.Visible = isVisible
        if not isVisible then
            print("GUI minimized. Add a maximize button in the future.")
        end
    end)
end

return GuiModule