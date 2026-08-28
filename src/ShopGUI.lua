-- SHOP GUI V2 - CLEANER DESIGN
-- Place in StarterPlayer > StarterPlayerScripts as a LocalScript

print("🎮 Shop GUI V2 Starting...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local playerGui = player:WaitForChild("PlayerGui")

-- Wait for remotes
local shopRemotes = ReplicatedStorage:WaitForChild("ShopRemotes")
local hatchRemotes = ReplicatedStorage:WaitForChild("HatchRemotes")

local buyEggEvent = shopRemotes:WaitForChild("BuyEgg")
local getShopDataFunc = shopRemotes:WaitForChild("GetShopData")
local getPlayerCurrencyFunc = shopRemotes:WaitForChild("GetPlayerCurrency")
local getInventoryFunc = shopRemotes:WaitForChild("GetInventory")
local hatchEggEvent = hatchRemotes:WaitForChild("HatchEgg")
local equipPetEvent = hatchRemotes:WaitForChild("EquipPet")

-- Get coins leaderstat
local leaderstats = player:WaitForChild("leaderstats")
local coins = leaderstats:WaitForChild("Coins")

-- Pet data
local PETS = {
    ["Mouse"] = { 
        name = "Mouse", 
        rarity = "Common",
        messages = {
            "A tiny mouse appeared! 🐭",
            "You got a squeaky mouse! 🐭",
            "A little mouse scurried out! 🐭",
            "Meet your new mouse friend! 🐭",
            "A curious mouse is here! 🐭"
        }
    },
    ["Bunny"] = { 
        name = "Bunny", 
        rarity = "Common",
        messages = {
            "A fluffy bunny hopped out! 🐰",
            "You got an adorable bunny! 🐰",
            "A cute bunny appeared! 🐰",
            "Meet your fluffy bunny! 🐰",
            "A bouncy bunny is ready! 🐰"
        }
    },
    ["Chicken"] = { 
        name = "Chicken", 
        rarity = "Common",
        messages = {
            "A chicken has hatched! 🐔",
            "You got a loud chicken! 🐔",
            "A clucking chicken appeared! 🐔",
            "Meet your feathered chicken! 🐔",
            "Your chicken is ready to go! 🐔"
        }
    },
    ["Dragon"] = { 
        name = "Dragon", 
        rarity = "Rare",
        messages = {
            "An epic dragon emerged! 🐉",
            "You got a powerful dragon! 🐉",
            "A magnificent dragon appeared! 🐉",
            "Meet your fearless dragon! 🐉",
            "A dragon rises from the egg! 🐉"
        }
    },
    ["Phoenix"] = { 
        name = "Phoenix", 
        rarity = "Rare",
        messages = {
            "A phoenix rose from the flames! 🔥",
            "You got a legendary phoenix! 🔥",
            "A majestic phoenix appeared! 🔥",
            "Meet your fiery phoenix! 🔥",
            "A phoenix bursts forth! 🔥"
        }
    },
    ["Unicorn"] = { 
        name = "Unicorn", 
        rarity = "Rare",
        messages = {
            "A magical unicorn appeared! ✨",
            "You got a mystical unicorn! ✨",
            "A beautiful unicorn emerged! ✨",
            "Meet your enchanted unicorn! ✨",
            "A unicorn shimmers into view! ✨"
        }
    },
    ["LegendaryDragon"] = { 
        name = "Legendary Dragon", 
        rarity = "Epic",
        messages = {
            "AN ANCIENT DRAGON HAS AWAKENED! 🐉⚡",
            "You got a LEGENDARY dragon! 🐉⚡",
            "BEHOLD! An ancient dragon emerges! 🐉⚡",
            "Meet the LEGENDARY dragon! 🐉⚡",
            "A MYTHICAL dragon rises before you! 🐉⚡"
        }
    },
    ["GoldenPhoenix"] = { 
        name = "Golden Phoenix", 
        rarity = "Epic",
        messages = {
            "A GOLDEN PHOENIX RISES! ✨🔥",
            "You got a GOLDEN PHOENIX! ✨🔥",
            "BEHOLD! A legendary golden phoenix! ✨🔥",
            "Meet the GOLDEN PHOENIX! ✨🔥",
            "A MAGNIFICENT golden phoenix emerges! ✨🔥"
        }
    },
    ["MythicalUnicorn"] = { 
        name = "Mythical Unicorn", 
        rarity = "Epic",
        messages = {
            "A MYTHICAL UNICORN APPEARS! 🌟✨",
            "You got a MYTHICAL UNICORN! 🌟✨",
            "BEHOLD! A celestial unicorn! 🌟✨",
            "Meet the MYTHICAL UNICORN! 🌟✨",
            "A DIVINE unicorn manifests! 🌟✨"
        }
    }
}

-- Create main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShopGuiV2"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main container centered
local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0, 500, 0, 600)
mainContainer.Position = UDim2.new(0.5, -250, 0.5, -300)
mainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainContainer.BorderColor3 = Color3.fromRGB(100, 200, 255)
mainContainer.BorderSizePixel = 3
mainContainer.Parent = screenGui

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 100)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
header.BorderSizePixel = 0
header.Parent = mainContainer

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 32
title.Font = Enum.Font.GothamBold
title.Text = "🎮 PET WORLD"
title.Parent = header

-- Coins display
local coinsDisplay = Instance.new("TextLabel")
coinsDisplay.Name = "CoinsDisplay"
coinsDisplay.Size = UDim2.new(1, -20, 0, 40)
coinsDisplay.Position = UDim2.new(0, 10, 0, 50)
coinsDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
coinsDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
coinsDisplay.TextSize = 18
coinsDisplay.Font = Enum.Font.GothamBold
coinsDisplay.Text = "💰 " .. coins.Value .. " Coins"
coinsDisplay.BorderColor3 = Color3.fromRGB(255, 215, 0)
coinsDisplay.BorderSizePixel = 2
coinsDisplay.Parent = header

coins.Changed:Connect(function(value)
    coinsDisplay.Text = "💰 " .. value .. " Coins"
end)

-- Tabs
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 0, 50)
tabBar.Position = UDim2.new(0, 0, 0, 100)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
tabBar.BorderSizePixel = 0
tabBar.Parent = mainContainer

local function createTab(name, icon, pos)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "Tab"
    tabBtn.Size = UDim2.new(0.25, -2, 1, 0)
    tabBtn.Position = UDim2.new(pos, 0, 0, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.TextSize = 14
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Text = icon .. "\n" .. name
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = tabBar
    return tabBtn
end

local shopTabBtn = createTab("SHOP", "🛒", 0)
local eggsTabBtn = createTab("EGGS", "🥚", 0.25)
local petsTabBtn = createTab("PETS", "🐾", 0.5)
local upgradesTabBtn = createTab("UPGRADES", "⬆️", 0.75)

-- Content area
local contentArea = Instance.new("ScrollingFrame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, 0, 1, -150)
contentArea.Position = UDim2.new(0, 0, 0, 150)
contentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
contentArea.BorderSizePixel = 0
contentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
contentArea.ScrollBarThickness = 8
contentArea.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
contentArea.Parent = mainContainer

-- Hatching cutscene
local function showHatchingCutscene(petType)
    print("🎬 Hatching: " .. petType)
    
    local petData = PETS[petType]
    if not petData then return end
    
    local randomMessage = petData.messages[math.random(1, #petData.messages)]
    
    local cutsceneGui = Instance.new("ScreenGui")
    cutsceneGui.Name = "HatchCutscene"
    cutsceneGui.ResetOnSpawn = false
    cutsceneGui.Parent = playerGui
    
    local fadeBackground = Instance.new("Frame")
    fadeBackground.Name = "FadeBackground"
    fadeBackground.Size = UDim2.new(1, 0, 1, 0)
    fadeBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    fadeBackground.BackgroundTransparency = 0
    fadeBackground.BorderSizePixel = 0
    fadeBackground.Parent = cutsceneGui
    
    wait(0.5)
    
    local egg = Instance.new("Part")
    egg.Shape = Enum.PartType.Ball
    egg.Size = Vector3.new(1.5, 1.5, 1.5)
    egg.Color = Color3.fromRGB(255, 200, 100)
    egg.Material = Enum.Material.SmoothPlastic
    egg.CanCollide = false
    egg.CFrame = camera.CFrame + camera.CFrame.LookVector * 15
    egg.Name = "HatchingEgg"
    egg.Parent = workspace
    
    for i = 1, 20 do
        fadeBackground.BackgroundTransparency = 1 - (i / 20)
        wait(0.02)
    end
    
    wait(0.5)
    
    for i = 1, 30 do
        egg.CFrame = egg.CFrame * CFrame.Angles(math.rad(math.random(-10, 10)), math.rad(math.random(-10, 10)), math.rad(math.random(-10, 10)))
        wait(0.05)
    end
    
    wait(0.5)
    
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
    
    fadeBackground.BackgroundTransparency = 1
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "PetObtainedMessage"
    messageLabel.Size = UDim2.new(0, 600, 0, 250)
    messageLabel.Position = UDim2.new(0.5, -300, 0.5, -125)
    messageLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    messageLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    messageLabel.TextSize = 36
    messageLabel.Font = Enum.Font.GothamBold
    messageLabel.Text = randomMessage .. "\n\n" .. petData.name .. "\n(" .. petData.rarity .. ")"
    messageLabel.TextWrapped = true
    messageLabel.BorderColor3 = Color3.fromRGB(100, 200, 255)
    messageLabel.BorderSizePixel = 3
    messageLabel.Parent = cutsceneGui
    
    wait(3)
    
    for i = 1, 10 do
        messageLabel.BackgroundTransparency = i / 10
        messageLabel.TextTransparency = i / 10
        fadeBackground.BackgroundTransparency = (i / 10)
        wait(0.05)
    end
    
    wait(0.5)
    cutsceneGui:Destroy()
end

-- Refresh shop
local function refreshShop()
    contentArea:ClearAllChildren()
    
    local shopData = getShopDataFunc:InvokeServer()
    
    local yPos = 10
    for eggType, eggData in pairs(shopData) do
        local card = Instance.new("Frame")
        card.Name = eggType
        card.Size = UDim2.new(1, -30, 0, 120)
        card.Position = UDim2.new(0, 15, 0, yPos)
        card.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        card.BorderColor3 = eggData.color
        card.BorderSizePixel = 2
        card.Parent = contentArea
        
        local eggName = Instance.new("TextLabel")
        eggName.Size = UDim2.new(0.6, -10, 0, 30)
        eggName.Position = UDim2.new(0, 10, 0, 5)
        eggName.BackgroundTransparency = 1
        eggName.TextColor3 = eggData.color
        eggName.TextSize = 16
        eggName.Font = Enum.Font.GothamBold
        eggName.Text = "🥚 " .. eggData.name
        eggName.TextXAlignment = Enum.TextXAlignment.Left
        eggName.Parent = card
        
        local rarity = Instance.new("TextLabel")
        rarity.Size = UDim2.new(0.35, -10, 0, 30)
        rarity.Position = UDim2.new(0.65, 0, 0, 5)
        rarity.BackgroundColor3 = eggData.color
        rarity.TextColor3 = Color3.fromRGB(0, 0, 0)
        rarity.TextSize = 12
        rarity.Font = Enum.Font.GothamBold
        rarity.Text = eggData.rarity
        rarity.BorderSizePixel = 0
        rarity.Parent = card
        
        local pets = Instance.new("TextLabel")
        pets.Size = UDim2.new(1, -20, 0, 30)
        pets.Position = UDim2.new(0, 10, 0, 40)
        pets.BackgroundTransparency = 1
        pets.TextColor3 = Color3.fromRGB(180, 180, 180)
        pets.TextSize = 11
        pets.Font = Enum.Font.Gotham
        pets.Text = "Contains: " .. table.concat(eggData.petChances, ", ")
        pets.TextXAlignment = Enum.TextXAlignment.Left
        pets.TextWrapped = true
        pets.Parent = card
        
        local price = Instance.new("TextLabel")
        price.Size = UDim2.new(0.4, -10, 0, 25)
        price.Position = UDim2.new(0, 10, 0, 80)
        price.BackgroundTransparency = 1
        price.TextColor3 = Color3.fromRGB(255, 215, 0)
        price.TextSize = 14
        price.Font = Enum.Font.GothamBold
        price.Text = "💰 $" .. eggData.price
        price.TextXAlignment = Enum.TextXAlignment.Left
        price.Parent = card
        
        local buyBtn = Instance.new("TextButton")
        buyBtn.Size = UDim2.new(0.4, -10, 0, 30)
        buyBtn.Position = UDim2.new(0.55, 5, 0, 80)
        buyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyBtn.TextSize = 13
        buyBtn.Font = Enum.Font.GothamBold
        buyBtn.Text = "BUY"
        buyBtn.BorderSizePixel = 0
        buyBtn.Parent = card
        
        buyBtn.MouseButton1Click:Connect(function()
            buyEggEvent:FireServer(eggType)
            wait(0.3)
            refreshEggs()
        end)
        
        buyBtn.MouseEnter:Connect(function()
            buyBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        end)
        
        buyBtn.MouseLeave:Connect(function()
            buyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        end)
        
        yPos = yPos + 130
    end
    
    contentArea.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Refresh eggs
local function refreshEggs()
    contentArea:ClearAllChildren()
    
    local inventory = getInventoryFunc:InvokeServer()
    
    if #inventory.eggs == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 0, 80)
        empty.Position = UDim2.new(0, 0, 0.5, -40)
        empty.BackgroundTransparency = 1
        empty.TextColor3 = Color3.fromRGB(150, 150, 150)
        empty.TextSize = 16
        empty.Font = Enum.Font.GothamBold
        empty.Text = "No eggs yet!\nBuy some from the shop."
        empty.TextWrapped = true
        empty.Parent = contentArea
        return
    end
    
    local yPos = 10
    for i, egg in pairs(inventory.eggs) do
        local card = Instance.new("Frame")
        card.Name = "EggCard_" .. i
        card.Size = UDim2.new(1, -30, 0, 100)
        card.Position = UDim2.new(0, 15, 0, yPos)
        card.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        card.BorderColor3 = Color3.fromRGB(200, 150, 100)
        card.BorderSizePixel = 2
        card.Parent = contentArea
        
        local eggType = Instance.new("TextLabel")
        eggType.Size = UDim2.new(0.6, -10, 0, 30)
        eggType.Position = UDim2.new(0, 10, 0, 10)
        eggType.BackgroundTransparency = 1
        eggType.TextColor3 = Color3.fromRGB(255, 255, 255)
        eggType.TextSize = 15
        eggType.Font = Enum.Font.GothamBold
        eggType.Text = "🥚 " .. egg.type
        eggType.TextXAlignment = Enum.TextXAlignment.Left
        eggType.Parent = card
        
        local slot = Instance.new("TextLabel")
        slot.Size = UDim2.new(0.35, -10, 0, 30)
        slot.Position = UDim2.new(0.65, 0, 0, 10)
        slot.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        slot.TextColor3 = Color3.fromRGB(150, 150, 150)
        slot.TextSize = 12
        slot.Font = Enum.Font.Gotham
        slot.Text = "Slot #" .. i
        slot.BorderSizePixel = 0
        slot.Parent = card
        
        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(1, -20, 0, 20)
        status.Position = UDim2.new(0, 10, 0, 45)
        status.BackgroundTransparency = 1
        status.TextColor3 = Color3.fromRGB(150, 200, 150)
        status.TextSize = 11
        status.Font = Enum.Font.Gotham
        status.Text = "✓ Ready to hatch"
        status.TextXAlignment = Enum.TextXAlignment.Left
        status.Parent = card
        
        local hatchBtn = Instance.new("TextButton")
        hatchBtn.Size = UDim2.new(0.9, -20, 0, 30)
        hatchBtn.Position = UDim2.new(0.05, 10, 0, 65)
        hatchBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        hatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        hatchBtn.TextSize = 13
        hatchBtn.Font = Enum.Font.GothamBold
        hatchBtn.Text = "HATCH 🐣"
        hatchBtn.BorderSizePixel = 0
        hatchBtn.Parent = card
        
        hatchBtn.MouseButton1Click:Connect(function()
            hatchEggEvent:FireServer(i)
            wait(5)
            refreshEggs()
        end)
        
        hatchBtn.MouseEnter:Connect(function()
            hatchBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        end)
        
        hatchBtn.MouseLeave:Connect(function()
            hatchBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        end)
        
        yPos = yPos + 110
    end
    
    contentArea.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Refresh pets
local function refreshPets()
    contentArea:ClearAllChildren()
    
    local inventory = getInventoryFunc:InvokeServer()
    
    if #inventory.pets == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 0, 80)
        empty.Position = UDim2.new(0, 0, 0.5, -40)
        empty.BackgroundTransparency = 1
        empty.TextColor3 = Color3.fromRGB(150, 150, 150)
        empty.TextSize = 16
        empty.Font = Enum.Font.GothamBold
        empty.Text = "No pets yet!\nHatch some eggs!"
        empty.TextWrapped = true
        empty.Parent = contentArea
        return
    end
    
    local yPos = 10
    for i, pet in pairs(inventory.pets) do
        local isEquipped = inventory.equippedPet == i
        
        local card = Instance.new("Frame")
        card.Name = "PetCard_" .. i
        card.Size = UDim2.new(1, -30, 0, 110)
        card.Position = UDim2.new(0, 15, 0, yPos)
        card.BackgroundColor3 = isEquipped and Color3.fromRGB(60, 40, 80) or Color3.fromRGB(40, 40, 50)
        card.BorderColor3 = pet.color
        card.BorderSizePixel = isEquipped and 3 or 2
        card.Parent = contentArea
        
        local petName = Instance.new("TextLabel")
        petName.Size = UDim2.new(0.6, -10, 0, 35)
        petName.Position = UDim2.new(0, 10, 0, 10)
        petName.BackgroundTransparency = 1
        petName.TextColor3 = pet.color
        petName.TextSize = 16
        petName.Font = Enum.Font.GothamBold
        petName.Text = "◼ " .. pet.name
        petName.TextXAlignment = Enum.TextXAlignment.Left
        petName.Parent = card
        
        local rarity = Instance.new("TextLabel")
        rarity.Size = UDim2.new(0.35, -10, 0, 35)
        rarity.Position = UDim2.new(0.65, 0, 0, 10)
        rarity.BackgroundColor3 = pet.color
        rarity.TextColor3 = Color3.fromRGB(0, 0, 0)
        rarity.TextSize = 12
        rarity.Font = Enum.Font.GothamBold
        rarity.Text = pet.rarity
        rarity.BorderSizePixel = 0
        rarity.Parent = card
        
        if isEquipped then
            local equipped = Instance.new("TextLabel")
            equipped.Size = UDim2.new(1, -20, 0, 20)
            equipped.Position = UDim2.new(0, 10, 0, 50)
            equipped.BackgroundTransparency = 1
            equipped.TextColor3 = Color3.fromRGB(100, 255, 100)
            equipped.TextSize = 12
            equipped.Font = Enum.Font.GothamBold
            equipped.Text = "✓ EQUIPPED"
            equipped.TextXAlignment = Enum.TextXAlignment.Left
            equipped.Parent = card
        end
        
        local equipBtn = Instance.new("TextButton")
        equipBtn.Size = UDim2.new(0.9, -20, 0, 30)
        equipBtn.Position = UDim2.new(0.05, 10, 0, 75)
        if isEquipped then
            equipBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
            equipBtn.Text = "UNEQUIP"
        else
            equipBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
            equipBtn.Text = "EQUIP"
        end
        equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        equipBtn.TextSize = 13
        equipBtn.Font = Enum.Font.GothamBold
        equipBtn.BorderSizePixel = 0
        equipBtn.Parent = card
        
        equipBtn.MouseButton1Click:Connect(function()
            equipPetEvent:FireServer(i)
            wait(0.3)
            refreshPets()
        end)
        
        equipBtn.MouseEnter:Connect(function()
            if isEquipped then
                equipBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            else
                equipBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
            end
        end)
        
        equipBtn.MouseLeave:Connect(function()
            if isEquipped then
                equipBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
            else
                equipBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
            end
        end)
        
        yPos = yPos + 120
    end
    
    contentArea.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Refresh upgrades
local function refreshUpgrades()
    contentArea:ClearAllChildren()
    
    local coming = Instance.new("TextLabel")
    coming.Size = UDim2.new(1, 0, 0, 80)
    coming.Position = UDim2.new(0, 0, 0.5, -40)
    coming.BackgroundTransparency = 1
    coming.TextColor3 = Color3.fromRGB(150, 150, 150)
    coming.TextSize = 16
    coming.Font = Enum.Font.GothamBold
    coming.Text = "Upgrades\nComing Soon! ⬆️"
    coming.TextWrapped = true
    coming.Parent = contentArea
end

-- Tab connections
shopTabBtn.MouseButton1Click:Connect(function()
    shopTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    eggsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    petsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    upgradesTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    refreshShop()
end)

eggsTabBtn.MouseButton1Click:Connect(function()
    shopTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    eggsTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    petsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    upgradesTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    refreshEggs()
end)

petsTabBtn.MouseButton1Click:Connect(function()
    shopTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    eggsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    petsTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    upgradesTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    refreshPets()
end)

upgradesTabBtn.MouseButton1Click:Connect(function()
    shopTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    eggsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    petsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    upgradesTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    refreshUpgrades()
end)

-- Hatch event
hatchEggEvent.OnClientEvent:Connect(function(petType, petData)
    showHatchingCutscene(petType)
end)

-- Initial
refreshShop()

print("✅ GUI V2 READY!")