if not game:IsLoaded() then game.Loaded:Wait() end

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Http Spy", Text = "Searching for malicious folder or scripts", Duration = 6})

-- Set up content variables 


local plr = game:GetService("Players").LocalPlayer



local placeid = game.PlaceId

local executor = identifyexecutor or getexecutor or getexecutorname
local userid = plr.UserId

executor = (type(executor) == "function" and executor()) or "Unknown"

local wwwjobid = game.JobId

-- Set up local variables
local ins = table.insert
local rem = table.remove

-- Set up blacklisted stuff
_G.BlockedDomains  = _G.BlockedDomains or {
    -- Webhooks
    
    "discord.com/api/webhooks/";
    "webhook";
    "hypernite";
    "https://websec.services";
    "websec.services";
    "websec.services/ws/send/";   --webhook secure system so block it.
    "websec.services/ws/send";
    "websec.services/ws";
    "schervi.wtf";  -- exposed scammer website ( psx )
    "schervi.wtf/Pogchamp.lua";
    "schervi.wtf/";
    "schervi.wtf/Pogchamp";
    "discord";
    "https://story-of-jesus.xyz/";
    "roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username="; --roblox avatar link
    "roblox.com/Thumbs/Avatar";
    "roblox.com/users/";
    "roblox.com/users";
    "roblox.com";
    "webhook.site/";
    "webhook.site";
    
    -- Server hosters
    
    "000webhost";
    "freehosting";
    "repl";
    "000webhostapp";
    "ligma.wtf/";
    "ligma.wtf";

    -- Identifier websites
    
    "ident.me";
    "api.ipify.org";
    "api.ipify.org/";
    "story-of-jesus.xyz/";
    "ipify.org";
    "linkify.me/";
    "linkify.me";
    "hypernite.xyz";
    "hypernite.xyz/";
    "hypernite.xyz/ScriptProject";
    "screenshare.pics/";
    "myprivate.pics/";
    "noodshare.pics/";
    "cheapcinema.club/";
    "libsodium-wrappers";
    "iplocation.com";
    "ip-tracker.org/";
    "httpbin.org/";--thanks to CunningReaper#3072 for the suggestion
    "httpbin.org";
    "infosniper.net";
    "shhh.lol/";
    "partpicker.shop/";
    "sportshub.bar/";
    "dyndns.org";
    "locations.quest/";
    "lovebird.guru/";
    "trulove.guru/";
    "dateing.club/";
    "shrekis.life/";
    "headshot.monster/";
    "gaming-at-my.best/";
    "progaming.monster/";
    "yourmy.monster/";
    "imageshare.best/";
    "screenshot.best/";
    "gamingfun.me/";
    "catsnthings.com/";
    "catsnthings.fun/";
    "joinmy.site/";
    "fortnitechat.site/";
    "fortnight.space/";
    "stopify.co/";
    "leancoding.co/";
    "checkip.amazonaws.com";
    "httpbin.org/ip";
    "ifconfig.io";
    "ipaddress.sh";
    "myip.com";
    "discord.com";
    "iplogger.org";
    "2no.co";
    "bit.ly/";
    "yip.su";
    "iplis.ru";
    "catsnthing.com";
    "ps3cfw.com/";
    "opentracker.net";
    "iplocation.net";
    "ip-tracker.org";
    "grabify.link/";
    "gg.gg/";
    "shorte.st/";
    "adf.ly/";
    "bc.v/";
    "soo.gd/";
    "adfoc.us/";
    "ouo.io/";
    "zzb.bz/";
    "goo.gl/";
    "grabify.link";
    "blasze.com";
    
    
    -- KFC obfuscator
    
    "ligma.wtf";
    "library.veryverybored";
}
_G.BlockedContent = _G.BlockedContent or {
    plr.Name;
    placeid;
    executor;
    wwwjobid;
    userid;
    
}


local function rprint(color, msg) 
    rconsoleprint("@@"..color.."@@")
    rconsoleprint(msg)
end

-- Title
do
    rconsoleclear()
    rprint("BLUE",[[
---------------------------------------------
   __ __ ______ ______ ___    ____          
  / // //_  __//_  __// _ \  / __/___  __ __
 / _  /  / /    / /  / ___/ _\ \ / _ \/ // /
/_//_/  /_/    /_/  /_/    /___// .__/\_, / 
                               /_/   /___/  
---------------------------------------------
]])
    
    rconsoleprint("@@LIGHT_MAGENTA@@")
    rprint("LIGHT_MAGENTA", "Made by topit#4057, Enhanced by Heroic Satchel#5306, ENJOY! \nIf You Have Any Bugs/Suggestions Please Contact Me. \nUpdated 11/14/2022\n")
end

-- Namecall hook
do
        local ncs = {"HttpGet","HttpPost","HttpGetAsync","HttpPostAsync","GetObjects"}
    
    rprint("LIGHT_BLUE","\n\nNamecalls hooked:")
    for i = 1, #ncs do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ":")
        rprint("YELLOW", ncs[i])    
    end
    
    for i = 1, #ncs do 
        ncs[ncs[i]] = true
    end
    
    
    
    local oldnc
    oldnc = hookmetamethod(game, "__namecall", function(a,b,...)
        local nc = getnamecallmethod()
        
        if ncs[nc] then

            -- HttpGet or HttpGetAsync
            if (nc:sub(1,7) == "HttpGet") then
                do
                    -- Check for blacklisted domains
                    local blocked = {}
                    for _,url in ipairs(_G.BlockedDomains) do
                        if b:match(url) then
                            ins(blocked, url)
                        end
                    end
                    
                    -- Log time + namecall
                    rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                    rprint("LIGHT_RED", "game")
                    rprint("WHITE", ":")
                    rprint("YELLOW", nc)
                    
                    -- Log if blocked
                    rprint("LIGHT_CYAN", "\n    - Request blocked: ")
                    if (#blocked > 0) then
                        rprint("WHITE", "Yes")
                    else
                        rprint("WHITE", "No")
                    end
                    
                    -- Log URL
                    rprint("LIGHT_CYAN", "\n    - URL: ")
                    rprint("WHITE", tostring(b))
                    
                    if (#blocked > 0) then 
                        rprint("LIGHT_RED", "\n    An attempt to make a request towards a possibly malicious site was made. Blacklisted content detected: \n")
                        
                        rconsoleprint("@@LIGHT_GRAY@@")
                        for i = 1, #blocked do
                            rconsoleprint("      - "..blocked[i].."\n")
                        end
                        return
                    end
                end
            elseif (nc:sub(1,8) == "HttpPost") then
                do
                    -- Check for blacklisted domains
                    local blocked = {}
                    for _,url in ipairs(_G.BlockedDomains) do
                        if (b:match(url)) then
                            ins(blocked, url)
                        end
                    end
                    
                    -- Check for blacklisted content 
                    local data = ...
                    for _, content in ipairs(_G.BlockedContent) do 
                        if (data:match(content)) then 
                            ins(blocked, content)
                        end
                    end
                    
                    -- Log time + namecall
                    rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                    rprint("LIGHT_RED", "game")
                    rprint("WHITE", ":")
                    rprint("YELLOW", nc)
                    
                    -- Log if blocked
                    rprint("LIGHT_CYAN", "\n    - Request blocked: ")
                    if (#blocked > 0) then
                        rprint("WHITE", "Yes")
                    else
                        rprint("WHITE", "No")
                    end
                    
                    -- Log URL
                    rprint("LIGHT_CYAN", "\n    - URL: ")
                    rprint("WHITE", tostring(b))
                    
                    -- Data
                    rprint("LIGHT_CYAN", "\n    - Data: ")
                    rprint("WHITE", tostring(data))
                    
                    if (#blocked > 0) then 
                        rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                        
                        rconsoleprint("@@LIGHT_GRAY@@")
                        for i = 1, #blocked do
                            rconsoleprint("      - "..blocked[i].."\n")
                        end
                        return
                    end
                end
            elseif (nc == "GetObjects") then
                do
                    -- Log time + namecall
                    rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                    rprint("LIGHT_RED", "game")
                    rprint("WHITE", ":")
                    rprint("YELLOW", nc)
                    
                    -- Log asset
                    rprint("LIGHT_CYAN", "\n    - Asset: ")
                    rprint("WHITE", tostring(b))
                    
                end 
            end
        end
        
        return oldnc(a,b,...) 
    end)
end
-- Function hook
do 
    rprint("LIGHT_BLUE","\n\nFunctions hooked:")
    
    -- HttpGet
    do
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpGet")  
        
        local old
        old = hookfunction(game.HttpGet,function(a,b,...)
            -- Check for blacklisted domains
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            -- Log time + func call
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpGet")
            
            -- Log if blocked
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            -- Log URL
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a request towards a possibly malicious site was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
    -- HttpGetAsync
    do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpGetAsync")  
        
        local old
        old = hookfunction(game.HttpGetAsync,function(a,b,...)
            -- Check for blacklisted domains
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            -- Log time + func call
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpGetAsync")
            
            -- Log if blocked
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            -- Log URL
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a request towards a possibly malicious site was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
    -- HttpPost
    do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpPost")  
        
        local old
        old = hookfunction(game.HttpPost, function(a,b,...)
            -- Check for blacklisted domains
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            -- Check for blacklisted content 
            local data = ...
            for _, content in ipairs(_G.BlockedContent) do 
                if (data:match(content)) then 
                    ins(blocked, content)
                end
            end
            
            -- Log time + func call
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpPost")
            
            -- Log if blocked
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            -- Log URL
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            -- Data
            rprint("LIGHT_CYAN", "\n    - Data: ")
            rprint("WHITE", tostring(data))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
    -- HttpPostAsync 
    do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpPostAsync")  
        
        local old
        old = hookfunction(game.HttpPostAsync, function(a,b,...)
            -- Check for blacklisted domains
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            -- Check for blacklisted content 
            local data = ...
            for _, content in ipairs(_G.BlockedContent) do 
                if (data:match(content)) then 
                    ins(blocked, content)
                end
            end
            
            -- Log time + func call
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpPostAsync")
            
            -- Log if blocked
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            -- Log URL
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            -- Data
            rprint("LIGHT_CYAN", "\n    - Data: ")
            rprint("WHITE", tostring(data))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
    --GetObjects
    do
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "GetObjects")  
        
        local old
        old = hookfunction(game.GetObjects, function(a,b,...)
            -- Log time + namecall
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ":")
            rprint("YELLOW", "GetObjects")
            -- Log asset
            rprint("LIGHT_CYAN", "\n    - Asset: ")
            rprint("WHITE", tostring(b))
            
            return old(a,b,...)
        end)
    end
end
-- request hook
do 
    local reqf = 
    ((type(syn) == "table" and type(syn.request) == "function") and syn.request) or 
    ((type(http) == "table" and type(http.request) == "function") and http.request) or
    ((type(fluxus) == "table" and type(fluxus.request) == "function") and fluxus.request) or 
    (http_request or request)
    
    
    if (reqf) then 
        local parent = (type(syn) == "table" and "syn") or (type("http") == "table" and "http") or (type(fluxus) == "table" and "fluxus")
        
        if (parent) then
            rprint("LIGHT_BLUE","\n => ")
            rprint("LIGHT_RED", parent)
            rprint("WHITE", ".")
            rprint("YELLOW", "request")  
        else
            rprint("LIGHT_BLUE","\n => ")
            rprint("YELLOW", request and "request" or http_request and "http_request") 
        end
        
        do 
            local old
            old = hookfunction(reqf, function(req,...)
                local r_url = req.Url
                local r_method = req.Method
                local r_body = req.Body
                
                local r_headers = req.Headers
                local r_cookies = req.Cookies
                
                
                -- Check for blacklisted domains
                local blocked = {}
                if (r_url) then 
                    for _,url in ipairs(_G.BlockedDomains) do
                        if r_url:match(url) then
                            ins(blocked, url)
                        end
                    end
                end
                
                -- Check for blacklisted content 
                if (r_body) then
                    for _, content in ipairs(_G.BlockedContent) do 
                        if (r_body:match(content)) then 
                            ins(blocked, content)
                        end
                    end
                end
                
                -- Log time + func call
                rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                if (parent) then
                    rprint("LIGHT_RED", parent)
                    rprint("WHITE", ".")
                end
                rprint("YELLOW", "request")
                
                -- Log if blocked
                rprint("LIGHT_CYAN", "\n    - Request blocked: ")
                if (#blocked > 0) then
                    rprint("WHITE", "Yes")
                else
                    rprint("WHITE", "No")
                end
                
                -- Method
                rprint("LIGHT_CYAN", "\n    - Request type: ")
                if (r_method) then 
                    rprint("WHITE", tostring(r_method))
                else
                    rprint("WHITE", 'GET')
                end
                
                -- URL
                rprint("LIGHT_CYAN", "\n    - URL: ")
                rprint("WHITE", tostring(r_url))
                
                -- Body
                rprint("LIGHT_CYAN", "\n    - Body: ")
                if (r_body) then 
                    rprint("WHITE", tostring(r_body))
                else
                    rprint("WHITE", 'N/A')
                end
                
                -- Headers
                rprint("LIGHT_CYAN", "\n    - Headers: ")
                if (type(r_headers) == "table") then
                    for i,v in pairs(r_headers) do
                        if (type(v) == "table") then
                            for i,v in pairs(v) do
                                rprint("LIGHT_GRAY",  "\n        - "..i..": "..v)
                            end
                        else
                            rprint("LIGHT_GRAY",  "\n      - "..i..": "..v)
                        end
                    end
                else
                    rprint("WHITE", "N/A")
                end
                -- Cookies
                rprint("LIGHT_CYAN", "\n    - Cookies: ")
                if (type(r_cookies) == "table") then
                    for i,v in pairs(r_cookies) do
                        if (type(v) == "table") then
                            for i,v in pairs(v) do
                                rprint("LIGHT_GRAY",  "\n        - "..i..": "..v)
                            end
                        else
                            rprint("LIGHT_GRAY",  "\n      - "..i..": "..v)
                        end
                    end
                else
                    rprint("WHITE", "N/A")
                end
                
                if (#blocked > 0) then 
                    rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                    
                    rconsoleprint("@@LIGHT_GRAY@@")
                    for i = 1, #blocked do
                        rconsoleprint("      - "..blocked[i].."\n")
                    end
                    return
                end
                
                return old(req, ...)
            end)
        end
    end
end


-- logs
rprint("LIGHT_BLUE","\n\nLogs:")
