local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local waypoint = nil

local gui = Instance.new("ScreenGui")
gui.Name = "TeleportUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 240, 0, 160)
main.Position = UDim2.new(0.5, -120, 0.5, -80)
main.BackgroundColor3 = Color3.fromRGB(25,25,30)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "⚡ Teleport"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = main

local create = Instance.new("TextButton")
create.Size = UDim2.new(1,-30,0,45)
create.Position = UDim2.new(0,15,0,50)
create.Text = "📍 สร้างจุดวาร์ป"
create.TextSize = 16
create.TextColor3 = Color3.new(1,1,1)
create.BackgroundColor3 = Color3.fromRGB(45,45,55)
create.Parent = main
Instance.new("UICorner", create).CornerRadius = UDim.new(0,8)

local teleport = Instance.new("TextButton")
teleport.Size = UDim2.new(1,-30,0,45)
teleport.Position = UDim2.new(0,15,0,105)
teleport.Text = "⚡ วาร์ป"
teleport.TextSize = 16
teleport.TextColor3 = Color3.new(1,1,1)
teleport.BackgroundColor3 = Color3.fromRGB(65,90,180)
teleport.Parent = main
Instance.new("UICorner", teleport).CornerRadius = UDim.new(0,8)

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,55,0,55)
toggle.Position = UDim2.new(0,15,0.5,-27)
toggle.Text = "☰"
toggle.TextSize = 24
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(35,35,40)
toggle.Parent = gui
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

create.MouseButton1Click:Connect(function()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if root then
        waypoint = root.CFrame
        create.Text = "✅ สร้างจุดแล้ว"
        task.wait(1)
        create.Text = "📍 สร้างจุดวาร์ป"
    end
end)

teleport.MouseButton1Click:Connect(function()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if root and waypoint then
        root.CFrame = waypoint
    else
        teleport.Text = "❌ ยังไม่มีจุดวาร์ป"
        task.wait(1)
        teleport.Text = "⚡ วาร์ป"
    end
end)

toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then

        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
