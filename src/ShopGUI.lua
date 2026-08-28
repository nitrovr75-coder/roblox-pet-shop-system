-- Shop GUI Script - Right Side of Screen
-- Place in StarterPlayer > StarterPlayerScripts as a LocalScript

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for remotes
local shopRemotes = ReplicatedStorage:WaitForChild("ShopRemotes")
local hatchRemotes = ReplicatedStorage:WaitForChild("HatchRemotes")
local upgradeRemotes = ReplicatedStorage:WaitForChild("UpgradeRemotes")

local buyEggEvent = shopRemotes:WaitForChild("BuyEgg")
local getShopDataFunc = shopRemotes:WaitForChild("GetShopData")
local getPlayerCurrencyFunc = shopRemotes:WaitForChild("GetPlayerCurrency")
local hatchEggEvent = hatchRemotes:WaitForChild("HatchEgg")
local getInventoryFunc = hatchRemotes:WaitForChild("GetInventory")
local buyUpgradeEvent = upgradeRemotes:WaitForChild("BuyUpgrade")
local getUpgradesFunc = upgradeRemotes:WaitForChild("GetUpgrades")

-- Create main screen GUI on RIGHT SIDE
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetShopGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main panel on RIGHT SIDE
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 400, 1, 0)
mainPanel.Position = UDim2.new(1, -410, 0, 0)
mainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainPanel.BorderSizePixel = 2
mainPanel.BorderColor3 = Color3.fromRGB(100, 100, 100)
mainPanel.Parent = screenGui

-- Create top bar background
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 70)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
topBar.BorderSizePixel = 0
topBar.Parent = mainPanel

-- Currency display at top
local currencyLabel = Instance.new("TextLabel")
currencyLabel.Name = "CurrencyLabel"
currencyLabel.Size = UDim2.new(1, -10, 0, 30)
currencyLabel.Position = UDim2.new(0, 5, 0, 5)
currencyLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
currencyLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
currencyLabel.TextSize = 16
currencyLabel.Font = Enum.Font.GothamBold
currencyLabel.Text = "💰 Currency: $0"
currencyLabel.BorderSizePixel = 1
currencyLabel.BorderColor3 = Color3.fromRGB(255, 215, 0)
currencyLabel.Parent = topBar

-- Tab buttons frame
local tabsFrame = Instance.new("Frame")
tabsFrame.Name = "TabsFrame"
tabsFrame.Size = UDim2.new(1, -10, 0, 30)
tabsFrame.Position = UDim2.new(0, 5, 0, 35)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = topBar

-- Shop Tab button
local shopTab = Instance.new("TextButton")
shopTab.Name = "ShopTab"
shopTab.Size = UDim2.new(0, 125, 0, 30)
shopTab.Position = UDim2.new(0, 0, 0, 0)
shopTab.Text = "🛒 SHOP"
shopTab.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
shopTab.TextColor3 = Color3.fromRGB(255, 255, 255)
shopTab.TextSize = 12
shopTab.Font = Enum.Font.GothamBold
shopTab.BorderSizePixel = 0
shopTab.Parent = tabsFrame

-- Inventory Tab button
local inventoryTab = Instance.new("TextButton")
inventoryTab.Name = "InventoryTab"
inventoryTab.Size = UDim2.new(0, 125, 0, 30)
inventoryTab.Position = UDim2.new(0, 130, 0, 0)
inventoryTab.Text = "🥚 EGGS"
inventoryTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
inventoryTab.TextColor3 = Color3.fromRGB(255, 255, 255)
inventoryTab.TextSize = 12
inventoryTab.Font = Enum.Font.GothamBold
inventoryTab.BorderSizePixel = 0
inventoryTab.Parent = tabsFrame

-- Upgrades Tab button
local upgradesTab = Instance.new("TextButton")
upgradesTab.Name = "UpgradesTab"
upgradesTab.Size = UDim2.new(0, 125, 0, 30)
upgradesTab.Position = UDim2.new(0, 260, 0, 0)
upgradesTab.Text = "⬆️ UPGRADES"
upgradesTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
upgradesTab.TextColor3 = Color3.fromRGB(255, 255, 255)
upgradesTab.TextSize = 12
upgradesTab.Font = Enum.Font.GothamBold
upgradesTab.BorderSizePixel = 0
upgradesTab.Parent = tabsFrame

-- Content frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -70)
contentFrame.Position = UDim2.new(0, 0, 0, 70)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainPanel

-- Shop frame with scroll
local shopFrame = Instance.new("Frame")
shopFrame.Name = "ShopFrame"
shopFrame.Size = UDim2.new(1, 0, 1, 0)
shopFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
shopFrame.BorderSizePixel = 0
shopFrame.Parent = contentFrame

local shopScroll = Instance.new("ScrollingFrame")
shopScroll.Name = "ScrollingFrame"
shopScroll.Size = UDim2.new(1, -10, 1, -10)
shopScroll.Position = UDim2.new(0, 5, 0, 5)
shopScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
shopScroll.BackgroundTransparency = 1
shopScroll.BorderSizePixel = 0
shopScroll.ScrollBarThickness = 8
shopScroll.Parent = shopFrame

-- Inventory frame with scroll
local inventoryFrame = Instance.new("Frame")
inventoryFrame.Name = "InventoryFrame"
inventoryFrame.Size = UDim2.new(1, 0, 1, 0)
inventoryFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inventoryFrame.Visible = false
inventoryFrame.BorderSizePixel = 0
inventoryFrame.Parent = contentFrame

local inventoryScroll = Instance.new("ScrollingFrame")
inventoryScroll.Name = "ScrollingFrame"
inventoryScroll.Size = UDim2.new(1, -10, 1, -10)
inventoryScroll.Position = UDim2.new(0, 5, 0, 5)
inventoryScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
inventoryScroll.BackgroundTransparency = 1
inventoryScroll.BorderSizePixel = 0
inventoryScroll.ScrollBarThickness = 8
inventoryScroll.Parent = inventoryFrame

-- Upgrades frame with scroll
local upgradesFrame = Instance.new("Frame")
upgradesFrame.Name = "UpgradesFrame"
upgradesFrame.Size = UDim2.new(1, 0, 1, 0)
upgradesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
upgradesFrame.Visible = false
upgradesFrame.BorderSizePixel = 0
upgradesFrame.Parent = contentFrame

local upgradesScroll = Instance.new("ScrollingFrame")
upgradesScroll.Name = "ScrollingFrame"
upgradesScroll.Size = UDim2.new(1, -10, 1, -10)
upgradesScroll.Position = UDim2.new(0, 5, 0, 5)
upgradesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
upgradesScroll.BackgroundTransparency = 1
upgradesScroll.BorderSizePixel = 0
upgradesScroll.ScrollBarThickness = 8
upgradesScroll.Parent = upgradesFrame

-- Create shop items
local function refreshShop()
    shopScroll:ClearAllChildren()
    
    local shopData = getShopDataFunc:InvokeServer()
    local playerData = getPlayerCurrencyFunc:InvokeServer()
    
    local yPos = 10
    local itemCount = 0
    
    for eggType, eggData in pairs(shopData) do
        itemCount = itemCount + 1
        
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = eggType
        itemFrame.Size = UDim2.new(1, -10, 0, 110)
        itemFrame.Position = UDim2.new(0, 5, 0, yPos)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.BorderColor3 = eggData.color
        itemFrame.BorderSizePixel = 2
        itemFrame.Parent = shopScroll
        
        -- Item name
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -10, 0, 25)
        nameLabel.Position = UDim2.new(0, 5, 0, 3)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = eggData.color
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = "🥚 " .. eggData.name
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = itemFrame
        
        -- Rarity badge
        local rarityLabel = Instance.new("TextLabel")
        rarityLabel.Size = UDim2.new(0, 80, 0, 20)
        rarityLabel.Position = UDim2.new(1, -90, 0, 3)
        rarityLabel.BackgroundColor3 = eggData.color
        rarityLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        rarityLabel.TextSize = 11
        rarityLabel.Font = Enum.Font.GothamBold
        rarityLabel.Text = eggData.rarity
        rarityLabel.BorderSizePixel = 0
        rarityLabel.Parent = itemFrame
        
        -- Price label
        local priceLabel = Instance.new("TextLabel")
        priceLabel.Size = UDim2.new(1, -10, 0, 20)
        priceLabel.Position = UDim2.new(0, 5, 0, 30)
        priceLabel.BackgroundTransparency = 1
        priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        priceLabel.TextSize = 12
        priceLabel.Font = Enum.Font.GothamBold
        priceLabel.Text = "💰 $" .. eggData.price
        priceLabel.TextXAlignment = Enum.TextXAlignment.Left
        priceLabel.Parent = itemFrame
        
        -- Description
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -10, 0, 30)
        descLabel.Position = UDim2.new(0, 5, 0, 52)
        descLabel.BackgroundTransparency = 1
        descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        descLabel.TextSize = 10
        descLabel.Font = Enum.Font.Gotham
        local petList = table.concat(eggData.petChances, ", ")
        descLabel.Text = petList
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextWrapped = true
        descLabel.Parent = itemFrame
        
        -- Buy button
        local buyButton = Instance.new("TextButton")
        buyButton.Name = "BuyButton"
        buyButton.Size = UDim2.new(0, 85, 0, 28)
        buyButton.Position = UDim2.new(1, -95, 1, -33)
        buyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyButton.TextSize = 12
        buyButton.Font = Enum.Font.GothamBold
        buyButton.Text = "BUY"
        buyButton.BorderSizePixel = 1
        buyButton.BorderColor3 = Color3.fromRGB(0, 200, 0)
        buyButton.Parent = itemFrame
        
        buyButton.MouseButton1Click:Connect(function()
            local currentData = getPlayerCurrencyFunc:InvokeServer()
            if currentData.currency >= eggData.price then
                buyEggEvent:FireServer(eggType)
                wait(0.3)
                refreshShop()
                updateCurrency()
            else
                print("❌ Not enough currency!")
            end
        end)
        
        buyButton.MouseEnter:Connect(function()
            buyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        end)
        
        buyButton.MouseLeave:Connect(function()
            buyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        end)
        
        yPos = yPos + 120
    end
    
    shopScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Create inventory items
local function refreshInventory()
    inventoryScroll:ClearAllChildren()
    
    local inventory = getInventoryFunc:InvokeServer()
    
    if #inventory == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, -20, 0, 60)
        emptyLabel.Position = UDim2.new(0, 10, 0.5, -30)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        emptyLabel.TextSize = 14
        emptyLabel.Font = Enum.Font.GothamBold
        emptyLabel.Text = "Your inventory is empty!\n\nBuy eggs from the shop!"
        emptyLabel.TextWrapped = true
        emptyLabel.Parent = inventoryScroll
        return
    end
    
    local yPos = 10
    for i, egg in pairs(inventory) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = "EggItem_" .. i
        itemFrame.Size = UDim2.new(1, -10, 0, 95)
        itemFrame.Position = UDim2.new(0, 5, 0, yPos)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.BorderColor3 = Color3.fromRGB(200, 150, 100)
        itemFrame.BorderSizePixel = 2
        itemFrame.Parent = inventoryScroll
        
        -- Egg type
        local typeLabel = Instance.new("TextLabel")
        typeLabel.Size = UDim2.new(1, -10, 0, 25)
        typeLabel.Position = UDim2.new(0, 5, 0, 5)
        typeLabel.BackgroundTransparency = 1
        typeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        typeLabel.TextSize = 14
        typeLabel.Font = Enum.Font.GothamBold
        typeLabel.Text = "🥚 " .. egg.type
        typeLabel.TextXAlignment = Enum.TextXAlignment.Left
        typeLabel.Parent = itemFrame
        
        -- Slot number
        local numLabel = Instance.new("TextLabel")
        numLabel.Size = UDim2.new(0, 70, 0, 20)
        numLabel.Position = UDim2.new(1, -80, 0, 5)
        numLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        numLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        numLabel.TextSize = 11
        numLabel.Font = Enum.Font.Gotham
        numLabel.Text = "Slot " .. i
        numLabel.BorderSizePixel = 0
        numLabel.Parent = itemFrame
        
        -- Status label
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(1, -10, 0, 18)
        statusLabel.Position = UDim2.new(0, 5, 0, 33)
        statusLabel.BackgroundTransparency = 1
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 150)
        statusLabel.TextSize = 11
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.Text = "✓ Ready to hatch"
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.Parent = itemFrame
        
        -- Hatch button
        local hatchButton = Instance.new("TextButton")
        hatchButton.Name = "HatchButton"
        hatchButton.Size = UDim2.new(0, 85, 0, 28)
        hatchButton.Position = UDim2.new(1, -95, 1, -33)
        hatchButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        hatchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        hatchButton.TextSize = 12
        hatchButton.Font = Enum.Font.GothamBold
        hatchButton.Text = "HATCH"
        hatchButton.BorderSizePixel = 1
        hatchButton.BorderColor3 = Color3.fromRGB(255, 150, 0)
        hatchButton.Parent = itemFrame
        
        hatchButton.MouseButton1Click:Connect(function()
            hatchEggEvent:FireServer(i)
            wait(1)
            refreshInventory()
        end)
        
        hatchButton.MouseEnter:Connect(function()
            hatchButton.BackgroundColor3 = Color3.fromRGB(250, 150, 0)
        end)
        
        hatchButton.MouseLeave:Connect(function()
            hatchButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        end)
        
        yPos = yPos + 105
    end
    
    inventoryScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Create upgrade items
local function refreshUpgrades()
    upgradesScroll:ClearAllChildren()
    
    local upgrades = getUpgradesFunc:InvokeServer()
    local playerData = getPlayerCurrencyFunc:InvokeServer()
    
    local yPos = 10
    for upgradeType, upgradeData in pairs(upgrades) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = upgradeType
        itemFrame.Size = UDim2.new(1, -10, 0, 110)
        itemFrame.Position = UDim2.new(0, 5, 0, yPos)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.BorderColor3 = Color3.fromRGB(200, 150, 100)
        itemFrame.BorderSizePixel = 2
        itemFrame.Parent = upgradesScroll
        
        -- Upgrade name
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -10, 0, 22)
        nameLabel.Position = UDim2.new(0, 5, 0, 3)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
        nameLabel.TextSize = 13
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = upgradeData.name
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = itemFrame
        
        -- Calculate cost
        local currentLevel = playerData.upgrades[upgradeType] or 0
        local nextCost = 0
        if currentLevel < upgradeData.maxLevel then
            nextCost = math.floor(upgradeData.baseCost * (upgradeData.multiplier ^ currentLevel))
        end
        
        -- Cost and level info
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Size = UDim2.new(1, -10, 0, 35)
        infoLabel.Position = UDim2.new(0, 5, 0, 27)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        infoLabel.TextSize = 10
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.Text = "💰 Cost: $" .. nextCost .. "\nLevel: " .. currentLevel .. "/" .. upgradeData.maxLevel .. "\n" .. upgradeData.effect
        infoLabel.TextXAlignment = Enum.TextXAlignment.Left
        infoLabel.TextWrapped = true
        infoLabel.Parent = itemFrame
        
        -- Buy button
        local buyButton = Instance.new("TextButton")
        buyButton.Name = "BuyButton"
        buyButton.Size = UDim2.new(0, 85, 0, 28)
        buyButton.Position = UDim2.new(1, -95, 1, -33)
        buyButton.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
        buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyButton.TextSize = 11
        buyButton.Font = Enum.Font.GothamBold
        buyButton.Text = "UPGRADE"
        buyButton.BorderSizePixel = 1
        buyButton.BorderColor3 = Color3.fromRGB(200, 150, 255)
        buyButton.Parent = itemFrame
        
        if currentLevel >= upgradeData.maxLevel then
            buyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            buyButton.Text = "MAX"
            buyButton.Enabled = false
        end
        
        buyButton.MouseButton1Click:Connect(function()
            buyUpgradeEvent:FireServer(upgradeType)
            wait(0.3)
            refreshUpgrades()
            updateCurrency()
        end)
        
        buyButton.MouseEnter:Connect(function()
            if buyButton.Enabled then
                buyButton.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
            end
        end)
        
        buyButton.MouseLeave:Connect(function()
            if buyButton.Enabled then
                buyButton.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
            end
        end)
        
        yPos = yPos + 120
    end
    
    upgradesScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Update currency display
function updateCurrency()
    local playerData = getPlayerCurrencyFunc:InvokeServer()
    currencyLabel.Text = "💰 Currency: $" .. playerData.currency
end

-- Tab switching
shopTab.MouseButton1Click:Connect(function()
    shopFrame.Visible = true
    inventoryFrame.Visible = false
    upgradesFrame.Visible = false
    shopTab.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    inventoryTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    upgradesTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    refreshShop()
end)

inventoryTab.MouseButton1Click:Connect(function()
    shopFrame.Visible = false
    inventoryFrame.Visible = true
    upgradesFrame.Visible = false
    shopTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    inventoryTab.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    upgradesTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    refreshInventory()
end)

upgradesTab.MouseButton1Click:Connect(function()
    shopFrame.Visible = false
    inventoryFrame.Visible = false
    upgradesFrame.Visible = true
    shopTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    inventoryTab.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    upgradesTab.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    refreshUpgrades()
end)

-- Initial setup
updateCurrency()
refreshShop()

-- Update currency every second
while true do
    wait(1)
    updateCurrency()
end