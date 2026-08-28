-- SHOP GUI WITH LEADERSTAT INTEGRATION & HATCHING CUTSCENE
-- Place in StarterPlayer > StarterPlayerScripts as a LocalScript

print("🎮 Shop GUI Script Starting...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

print("✅ Got local player: " .. player.Name)

-- Wait for PlayerGui
local playerGui = player:WaitForChild("PlayerGui")
print("✅ Got PlayerGui")

-- Wait for remotes
local shopRemotes = ReplicatedStorage:WaitForChild("ShopRemotes")
local hatchRemotes = ReplicatedStorage:WaitForChild("HatchRemotes")
print("✅ Found remotes")

local buyEggEvent = shopRemotes:WaitForChild("BuyEgg")
local getShopDataFunc = shopRemotes:WaitForChild("GetShopData")
local getPlayerCurrencyFunc = shopRemotes:WaitForChild("GetPlayerCurrency")
local getInventoryFunc = shopRemotes:WaitForChild("GetInventory")
local hatchEggEvent = hatchRemotes:WaitForChild("HatchEgg")

print("✅ All remotes found")

-- Get coins leaderstat
local leaderstats = player:WaitForChild("leaderstats")
local coins = leaderstats:WaitForChild("Coins")

print("✅ Coins leaderstat found: $" .. coins.Value)

-- Create main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShopGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Panel (Right Side)
local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Size = UDim2.new(0, 400, 1, 0)
panel.Position = UDim2.new(1, -410, 0, 0)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.BorderColor3 = Color3.fromRGB(100, 100, 100)
panel.BorderSizePixel = 2
panel.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.Text = "🛍️ PET SHOP"
title.BorderSizePixel = 0
title.Parent = panel

-- Currency Label (connected to Coins leaderstat)
local currencyLabel = Instance.new("TextLabel")
currencyLabel.Name = "CurrencyLabel"
currencyLabel.Size = UDim2.new(1, -20, 0, 40)
currencyLabel.Position = UDim2.new(0, 10, 0, 70)
currencyLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
currencyLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
currencyLabel.TextSize = 16
currencyLabel.Font = Enum.Font.GothamBold
currencyLabel.Text = "💰 Coins: $" .. coins.Value
currencyLabel.BorderColor3 = Color3.fromRGB(255, 215, 0)
currencyLabel.BorderSizePixel = 1
currencyLabel.Parent = panel

-- Update currency display when coins change
coins.Changed:Connect(function(value)
    currencyLabel.Text = "💰 Coins: $" .. value
    print("💰 Currency updated: $" .. value)
end)

-- SHOP TAB BUTTON
local shopBtn = Instance.new("TextButton")
shopBtn.Name = "ShopBtn"
shopBtn.Size = UDim2.new(0.33, -3, 0, 40)
shopBtn.Position = UDim2.new(0, 10, 0, 120)
shopBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
shopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
shopBtn.TextSize = 14
shopBtn.Font = Enum.Font.GothamBold
shopBtn.Text = "🛒 SHOP"
shopBtn.BorderSizePixel = 0
shopBtn.Parent = panel

-- EGGS TAB BUTTON
local eggsBtn = Instance.new("TextButton")
eggsBtn.Name = "EggsBtn"
eggsBtn.Size = UDim2.new(0.33, -3, 0, 40)
eggsBtn.Position = UDim2.new(0.33, 7, 0, 120)
eggsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
eggsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
eggsBtn.TextSize = 14
eggsBtn.Font = Enum.Font.GothamBold
eggsBtn.Text = "🥚 EGGS"
eggsBtn.BorderSizePixel = 0
eggsBtn.Parent = panel

-- UPGRADES TAB BUTTON
local upgradesBtn = Instance.new("TextButton")
upgradesBtn.Name = "UpgradesBtn"
upgradesBtn.Size = UDim2.new(0.33, -3, 0, 40)
upgradesBtn.Position = UDim2.new(0.67, 3, 0, 120)
upgradesBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
upgradesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
upgradesBtn.TextSize = 14
upgradesBtn.Font = Enum.Font.GothamBold
upgradesBtn.Text = "⬆️ UP"
upgradesBtn.BorderSizePixel = 0
upgradesBtn.Parent = panel

-- Content Area
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, 0, 1, -170)
content.Position = UDim2.new(0, 0, 0, 170)
content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
content.BorderSizePixel = 0
content.CanvasSize = UDim2.new(0, 0, 0, 500)
content.ScrollBarThickness = 8
content.Parent = panel

-- Hatching cutscene function
local function showHatchingCutscene(petType)
    print("🎬 Starting hatching cutscene for: " .. petType)
    
    -- Create cutscene GUI
    local cutsceneGui = Instance.new("ScreenGui")
    cutsceneGui.Name = "HatchCutscene"
    cutsceneGui.ResetOnSpawn = false
    cutsceneGui.Parent = playerGui
    
    -- Black fade background
    local fadeBackground = Instance.new("Frame")
    fadeBackground.Name = "FadeBackground"
    fadeBackground.Size = UDim2.new(1, 0, 1, 0)
    fadeBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    fadeBackground.BackgroundTransparency = 0
    fadeBackground.BorderSizePixel = 0
    fadeBackground.Parent = cutsceneGui
    
    wait(0.5)
    
    -- Create egg part in workspace
    local egg = Instance.new("Part")
    egg.Shape = Enum.PartType.Ball
    egg.Size = Vector3.new(1.5, 1.5, 1.5)
    egg.Color = Color3.fromRGB(255, 200, 100)
    egg.Material = Enum.Material.SmoothPlastic
    egg.CanCollide = false
    egg.CFrame = camera.CFrame + camera.CFrame.LookVector * 15
    egg.Name = "HatchingEgg"
    egg.TopSurface = Enum.SurfaceType.Smooth
    egg.BottomSurface = Enum.SurfaceType.Smooth
    egg.Parent = workspace
    
    print("✅ Egg created for cutscene")
    
    -- Fade out black screen
    for i = 1, 20 do
        fadeBackground.BackgroundTransparency = 1 - (i / 20)
        wait(0.02)
    end
    
    wait(0.5)
    
    -- Egg hatching animation (shaking)
    print("⏳ Egg is hatching...")
    for i = 1, 30 do
        egg.CFrame = egg.CFrame * CFrame.Angles(math.rad(math.random(-10, 10)), math.rad(math.random(-10, 10)), math.rad(math.random(-10, 10)))
        wait(0.05)
    end
    
    wait(0.5)
    
    -- Egg explosion effect
    print("💥 Egg is exploding!")
    for i = 1, 15 do
        local particle = Instance.new("Part")
        particle.Shape = Enum.PartType.Ball
        particle.Size = Vector3.new(0.4, 0.4, 0.4)
        particle.Color = Color3.fromRGB(255, 200, 100)
        particle.Material = Enum.Material.SmoothPlastic
        particle.CanCollide = false
        particle.CFrame = egg.CFrame + Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
        particle.Parent = workspace
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(math.random(-30, 30), math.random(-30, 30), math.random(-30, 30))
        bodyVelocity.Parent = particle
        
        game:GetService("Debris"):AddItem(particle, 1)
    end
    
    egg:Destroy()
    
    wait(0.5)
    
    -- Show pet obtained message
    fadeBackground.BackgroundTransparency = 1
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "PetObtainedMessage"
    messageLabel.Size = UDim2.new(0, 600, 0, 200)
    messageLabel.Position = UDim2.new(0.5, -300, 0.5, -100)
    messageLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    messageLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    messageLabel.TextSize = 48
    messageLabel.Font = Enum.Font.GothamBold
    messageLabel.Text = "🎉 YOU GOT 🎉\n\n" .. petType .. "!"
    messageLabel.TextWrapped = true
    messageLabel.BorderColor3 = Color3.fromRGB(255, 215, 0)
    messageLabel.BorderSizePixel = 3
    messageLabel.Parent = cutsceneGui
    
    print("🎉 Showing pet obtained: " .. petType)
    
    -- Keep message for 3 seconds
    wait(3)
    
    -- Fade out message
    for i = 1, 10 do
        messageLabel.BackgroundTransparency = i / 10
        messageLabel.TextTransparency = i / 10
        fadeBackground.BackgroundTransparency = (i / 10)
        wait(0.05)
    end
    
    wait(0.5)
    cutsceneGui:Destroy()
    
    print("✅ Cutscene complete!")
end

-- Function to refresh shop display
local function refreshShop()
    content:ClearAllChildren()
    
    local shopData = getShopDataFunc:InvokeServer()
    print("✅ Got shop data from server")
    
    local yPos = 10
    for eggType, eggData in pairs(shopData) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = eggType
        itemFrame.Size = UDim2.new(1, -20, 0, 100)
        itemFrame.Position = UDim2.new(0, 10, 0, yPos)
        itemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        itemFrame.BorderColor3 = eggData.color
        itemFrame.BorderSizePixel = 2
        itemFrame.Parent = content
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 25)
        nameLabel.Position = UDim2.new(0, 5, 0, 5)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = eggData.color
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = "🥚 " .. eggData.name
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = itemFrame
        
        local rarityLabel = Instance.new("TextLabel")
        rarityLabel.Size = UDim2.new(0, 80, 0, 20)
        rarityLabel.Position = UDim2.new(1, -90, 0, 5)
        rarityLabel.BackgroundColor3 = eggData.color
        rarityLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        rarityLabel.TextSize = 11
        rarityLabel.Font = Enum.Font.GothamBold
        rarityLabel.Text = eggData.rarity
        rarityLabel.BorderSizePixel = 0
        rarityLabel.Parent = itemFrame
        
        local priceLabel = Instance.new("TextLabel")
        priceLabel.Size = UDim2.new(1, 0, 0, 20)
        priceLabel.Position = UDim2.new(0, 5, 0, 32)
        priceLabel.BackgroundTransparency = 1
        priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        priceLabel.TextSize = 12
        priceLabel.Font = Enum.Font.Gotham
        priceLabel.Text = "💰 Price: $" .. eggData.price
        priceLabel.TextXAlignment = Enum.TextXAlignment.Left
        priceLabel.Parent = itemFrame
        
        local petsLabel = Instance.new("TextLabel")
        petsLabel.Size = UDim2.new(1, 0, 0, 20)
        petsLabel.Position = UDim2.new(0, 5, 0, 52)
        petsLabel.BackgroundTransparency = 1
        petsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        petsLabel.TextSize = 10
        petsLabel.Font = Enum.Font.Gotham
        local petList = table.concat(eggData.petChances, ", ")
        petsLabel.Text = "Contains: " .. petList
        petsLabel.TextXAlignment = Enum.TextXAlignment.Left
        petsLabel.Parent = itemFrame
        
        local buyBtn = Instance.new("TextButton")
        buyBtn.Size = UDim2.new(0, 80, 0, 30)
        buyBtn.Position = UDim2.new(1, -90, 1, -35)
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyBtn.TextSize = 12
        buyBtn.Font = Enum.Font.GothamBold
        buyBtn.Text = "BUY"
        buyBtn.BorderSizePixel = 0
        buyBtn.Parent = itemFrame
        
        buyBtn.MouseButton1Click:Connect(function()
            print("🛒 Attempting to buy: " .. eggType)
            buyEggEvent:FireServer(eggType)
            wait(0.5)
            refreshInventory() -- Refresh inventory after purchase
        end)
        
        buyBtn.MouseEnter:Connect(function()
            buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        end)
        
        buyBtn.MouseLeave:Connect(function()
            buyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        end)
        
        yPos = yPos + 110
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Function to refresh inventory display
local function refreshInventory()
    content:ClearAllChildren()
    
    local inventory = getInventoryFunc:InvokeServer()
    print("✅ Got inventory from server, count: " .. #inventory)
    
    if #inventory == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, 0, 0, 60)
        emptyLabel.Position = UDim2.new(0, 0, 0.5, -30)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        emptyLabel.TextSize = 14
        emptyLabel.Font = Enum.Font.GothamBold
        emptyLabel.Text = "🥚 Inventory Empty\n(Buy eggs from shop!)"
        emptyLabel.TextWrapped = true
        emptyLabel.Parent = content
        return
    end
    
    local yPos = 10
    for i, egg in pairs(inventory) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = "EggItem_" .. i
        itemFrame.Size = UDim2.new(1, -20, 0, 95)
        itemFrame.Position = UDim2.new(0, 10, 0, yPos)
        itemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        itemFrame.BorderColor3 = Color3.fromRGB(200, 150, 100)
        itemFrame.BorderSizePixel = 2
        itemFrame.Parent = content
        
        local typeLabel = Instance.new("TextLabel")
        typeLabel.Size = UDim2.new(1, 0, 0, 25)
        typeLabel.Position = UDim2.new(0, 5, 0, 5)
        typeLabel.BackgroundTransparency = 1
        typeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        typeLabel.TextSize = 14
        typeLabel.Font = Enum.Font.GothamBold
        typeLabel.Text = "🥚 " .. egg.type
        typeLabel.TextXAlignment = Enum.TextXAlignment.Left
        typeLabel.Parent = itemFrame
        
        local slotLabel = Instance.new("TextLabel")
        slotLabel.Size = UDim2.new(0, 70, 0, 20)
        slotLabel.Position = UDim2.new(1, -80, 0, 5)
        slotLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        slotLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        slotLabel.TextSize = 11
        slotLabel.Font = Enum.Font.Gotham
        slotLabel.Text = "Slot " .. i
        slotLabel.BorderSizePixel = 0
        slotLabel.Parent = itemFrame
        
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(1, 0, 0, 18)
        statusLabel.Position = UDim2.new(0, 5, 0, 33)
        statusLabel.BackgroundTransparency = 1
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 150)
        statusLabel.TextSize = 11
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.Text = "✓ Ready to hatch"
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.Parent = itemFrame
        
        local hatchBtn = Instance.new("TextButton")
        hatchBtn.Size = UDim2.new(0, 80, 0, 30)
        hatchBtn.Position = UDim2.new(1, -90, 1, -35)
        hatchBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        hatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        hatchBtn.TextSize = 12
        hatchBtn.Font = Enum.Font.GothamBold
        hatchBtn.Text = "HATCH"
        hatchBtn.BorderSizePixel = 0
        hatchBtn.Parent = itemFrame
        
        hatchBtn.MouseButton1Click:Connect(function()
            print("🐣 Hatching egg at slot " .. i)
            showHatchingCutscene("Getting your pet...")
            hatchEggEvent:FireServer(i)
            wait(5)
            refreshInventory()
        end)
        
        hatchBtn.MouseEnter:Connect(function()
            hatchBtn.BackgroundColor3 = Color3.fromRGB(250, 150, 0)
        end)
        
        hatchBtn.MouseLeave:Connect(function()
            hatchBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        end)
        
        yPos = yPos + 105
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Listen for hatch results from server
hatchEggEvent.OnClientEvent:Connect(function(petType, petData)
    print("🐣 Client received pet from server: " .. petType)
    showHatchingCutscene(petType)
end)

-- Function to show upgrades
local function refreshUpgrades()
    content:ClearAllChildren()
    
    local upLabel = Instance.new("TextLabel")
    upLabel.Size = UDim2.new(1, 0, 0, 60)
    upLabel.Position = UDim2.new(0, 0, 0.5, -30)
    upLabel.BackgroundTransparency = 1
    upLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    upLabel.TextSize = 14
    upLabel.Font = Enum.Font.GothamBold
    upLabel.Text = "⬆️ Upgrades Coming Soon!\n(Check back later)"
    upLabel.TextWrapped = true
    upLabel.Parent = content
end

-- TAB SWITCHING
shopBtn.MouseButton1Click:Connect(function()
    shopBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    eggsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    upgradesBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    refreshShop()
end)

eggsBtn.MouseButton1Click:Connect(function()
    shopBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    eggsBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    upgradesBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    refreshInventory()
end)

upgradesBtn.MouseButton1Click:Connect(function()
    shopBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    eggsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    upgradesBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    refreshUpgrades()
end)

-- Initial setup
refreshShop()

print("✅✅✅ SHOP GUI IS READY! LOOK AT RIGHT SIDE! ✅✅✅")