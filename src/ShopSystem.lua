-- Shop System with Leaderstat Integration & Hatching
-- Place in ServerScriptService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("🛒 Shop System Starting...")

-- Create remotes folder
local shopRemotes = ReplicatedStorage:FindFirstChild("ShopRemotes")
if not shopRemotes then
    shopRemotes = Instance.new("Folder")
    shopRemotes.Name = "ShopRemotes"
    shopRemotes.Parent = ReplicatedStorage
    print("✅ Created ShopRemotes folder")
end

-- Create hatch remotes folder
local hatchRemotes = ReplicatedStorage:FindFirstChild("HatchRemotes")
if not hatchRemotes then
    hatchRemotes = Instance.new("Folder")
    hatchRemotes.Name = "HatchRemotes"
    hatchRemotes.Parent = ReplicatedStorage
    print("✅ Created HatchRemotes folder")
end

-- Create remotes if they don't exist
local buyEggEvent = shopRemotes:FindFirstChild("BuyEgg")
if not buyEggEvent then
    buyEggEvent = Instance.new("RemoteEvent")
    buyEggEvent.Name = "BuyEgg"
    buyEggEvent.Parent = shopRemotes
end

local getShopDataEvent = shopRemotes:FindFirstChild("GetShopData")
if not getShopDataEvent then
    getShopDataEvent = Instance.new("RemoteFunction")
    getShopDataEvent.Name = "GetShopData"
    getShopDataEvent.Parent = shopRemotes
end

local getPlayerCurrencyEvent = shopRemotes:FindFirstChild("GetPlayerCurrency")
if not getPlayerCurrencyEvent then
    getPlayerCurrencyEvent = Instance.new("RemoteFunction")
    getPlayerCurrencyEvent.Name = "GetPlayerCurrency"
    getPlayerCurrencyEvent.Parent = shopRemotes
end

local getInventoryFunc = shopRemotes:FindFirstChild("GetInventory")
if not getInventoryFunc then
    getInventoryFunc = Instance.new("RemoteFunction")
    getInventoryFunc.Name = "GetInventory"
    getInventoryFunc.Parent = shopRemotes
end

-- Hatch remotes
local hatchEggEvent = hatchRemotes:FindFirstChild("HatchEgg")
if not hatchEggEvent then
    hatchEggEvent = Instance.new("RemoteEvent")
    hatchEggEvent.Name = "HatchEgg"
    hatchEggEvent.Parent = hatchRemotes
end

print("✅ All remotes created")

-- Shop Configuration
local SHOP_EGGS = {
    ["CommonEgg"] = {
        name = "Common Egg",
        price = 100,
        rarity = "Common",
        color = Color3.fromRGB(200, 200, 200),
        petChances = {"Mouse", "Bunny", "Chicken"}
    },
    ["RareEgg"] = {
        name = "Rare Egg",
        price = 500,
        rarity = "Rare",
        color = Color3.fromRGB(100, 149, 237),
        petChances = {"Dragon", "Phoenix", "Unicorn"}
    },
    ["EpicEgg"] = {
        name = "Epic Egg",
        price = 1500,
        rarity = "Epic",
        color = Color3.fromRGB(186, 85, 211),
        petChances = {"LegendaryDragon", "GoldenPhoenix", "MythicalUnicorn"}
    },
    ["LegendaryEgg"] = {
        name = "Legendary Egg",
        price = 5000,
        rarity = "Legendary",
        color = Color3.fromRGB(255, 215, 0),
        petChances = {"Phoenixlord", "ShadowDragon", "CelestialUnicorn"}
    }
}

-- Pet Configuration
local PETS = {
    ["Mouse"] = { name = "Mouse", rarity = "Common" },
    ["Bunny"] = { name = "Bunny", rarity = "Common" },
    ["Chicken"] = { name = "Chicken", rarity = "Common" },
    ["Dragon"] = { name = "Dragon", rarity = "Rare" },
    ["Phoenix"] = { name = "Phoenix", rarity = "Rare" },
    ["Unicorn"] = { name = "Unicorn", rarity = "Rare" },
    ["LegendaryDragon"] = { name = "Legendary Dragon", rarity = "Epic" },
    ["GoldenPhoenix"] = { name = "Golden Phoenix", rarity = "Epic" },
    ["MythicalUnicorn"] = { name = "Mythical Unicorn", rarity = "Epic" }
}

-- Player inventory storage
local playerInventory = {}

-- Create leaderstat for coins
local function createLeaderstat(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
    end
    
    local coins = leaderstats:FindFirstChild("Coins")
    if not coins then
        coins = Instance.new("IntValue")
        coins.Name = "Coins"
        coins.Value = 1000
        coins.Parent = leaderstats
        print("✅ Created Coins leaderstat for " .. player.Name)
    end
    
    return coins
end

-- Initialize player inventory
local function initPlayerInventory(player)
    playerInventory[player.UserId] = {
        eggs = {},
        upgrades = {
            eggHatchSpeed = 1,
            currencyMultiplier = 1,
            inventorySlots = 10
        }
    }
    print("✅ Player " .. player.Name .. " inventory initialized")
end

-- Add egg to inventory
local function addEggToInventory(player, eggType)
    local data = playerInventory[player.UserId]
    if #data.eggs < data.upgrades.inventorySlots then
        table.insert(data.eggs, {
            type = eggType,
            boughtAt = tick()
        })
        return true
    end
    return false
end

-- Remove egg from inventory
local function removeEggFromInventory(player, slotIndex)
    local data = playerInventory[player.UserId]
    if data.eggs[slotIndex] then
        table.remove(data.eggs, slotIndex)
        return true
    end
    return false
end

-- Get random pet from egg
local function getPetFromEgg(eggType)
    local eggData = SHOP_EGGS[eggType]
    if not eggData then return nil end
    
    local petChances = eggData.petChances
    local selectedPet = petChances[math.random(1, #petChances)]
    return selectedPet
end

-- Buy egg handler
buyEggEvent.OnServerEvent:Connect(function(player, eggType)
    print("💰 " .. player.Name .. " is trying to buy: " .. eggType)
    
    if not playerInventory[player.UserId] then
        initPlayerInventory(player)
    end
    
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        print("❌ No leaderstats for " .. player.Name)
        return
    end
    
    local coins = leaderstats:FindFirstChild("Coins")
    if not coins then
        print("❌ No Coins for " .. player.Name)
        return
    end
    
    local eggData = SHOP_EGGS[eggType]
    
    if not eggData then
        print("❌ Invalid egg type: " .. eggType)
        return
    end
    
    if coins.Value < eggData.price then
        print("❌ " .. player.Name .. " doesn't have enough coins")
        return
    end
    
    coins.Value = coins.Value - eggData.price
    
    if addEggToInventory(player, eggType) then
        print("✅ " .. player.Name .. " bought a " .. eggData.name .. " for $" .. eggData.price)
    else
        coins.Value = coins.Value + eggData.price -- Refund if inventory full
        print("❌ Inventory full for " .. player.Name)
    end
end)

-- Hatch egg handler
hatchEggEvent.OnServerEvent:Connect(function(player, slotIndex)
    print("🐣 " .. player.Name .. " is trying to hatch egg at slot " .. slotIndex)
    
    if not playerInventory[player.UserId] then
        initPlayerInventory(player)
    end
    
    local inventory = playerInventory[player.UserId].eggs
    
    if not inventory[slotIndex] then
        print("❌ No egg at slot " .. slotIndex)
        return
    end
    
    local eggType = inventory[slotIndex].type
    print("🐣 Egg type at slot " .. slotIndex .. ": " .. eggType)
    
    -- Get random pet
    local petType = getPetFromEgg(eggType)
    if not petType then
        print("❌ Failed to get pet from egg type: " .. eggType)
        return
    end
    
    local petData = PETS[petType]
    print("✅ Pet selected: " .. petType)
    
    -- Send hatch event to client with pet data
    hatchEggEvent:FireClient(player, petType, petData)
    
    -- Remove egg from inventory after a short delay to let animation play
    wait(1)
    removeEggFromInventory(player, slotIndex)
    print("✅ Egg removed from inventory at slot " .. slotIndex)
end)

-- Get shop data handler
getShopDataEvent.OnServerInvoke = function(player)
    return SHOP_EGGS
end

-- Get player currency handler
getPlayerCurrencyEvent.OnServerInvoke = function(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        print("❌ No leaderstats for " .. player.Name)
        return { coins = 0 }
    end
    
    local coins = leaderstats:FindFirstChild("Coins")
    if not coins then
        print("❌ No Coins for " .. player.Name)
        return { coins = 0 }
    end
    
    return { coins = coins.Value }
end

-- Get inventory handler
getInventoryFunc.OnServerInvoke = function(player)
    if not playerInventory[player.UserId] then
        initPlayerInventory(player)
    end
    return playerInventory[player.UserId].eggs
end

-- Player join event
Players.PlayerAdded:Connect(function(player)
    wait(1)
    createLeaderstat(player)
    initPlayerInventory(player)
end)

-- Player leave event
Players.PlayerRemoving:Connect(function(player)
    playerInventory[player.UserId] = nil
end)

print("✅✅ SHOP SYSTEM LOADED SUCCESSFULLY! ✅✅")