        messagebox=messagebox or function(m,t) game:GetService("StarterGui"):SetCore("SendNotification",{Title=t,Text=m}) end
listfiles = listfiles or listdir
if not listfiles then messagebox("your exploit is incompatible","incompatible exploit") return end
isfile = isfile or function(file) return (pcall(function() readfile(file) end)) end
isfolder = isfolder or function() return false end
local function getallfiles()
    local t = {}
    local function getfiles(folder)
        for _,file in pairs(listfiles(folder)) do
            if isfolder(file) then
                getfiles(file)
            else
                table.insert(t,file)
            end
        end
    end
    getfiles("./")
    return t
end

local function fixfile(path)
    local old = readfile(path)
    local file = old
    local f = {file:find("http://ligma.wtf")}
    while #f>0 do
        local length = #file
        local pstart,pend = (file:reverse():find(string.reverse("pcall"),length-f[1],true)),select(2,file:find("end)",f[2],true))
        if pstart and pend then
            file = file:sub(1,length-pstart-4)..file:sub(pend+1,length)
        end
        f = {file:find("http://ligma.wtf")}
    end
    if old~=file then writefile(path,file) return true end
    return false
end

local failed,infected = {},0

for _,file in pairs(getallfiles()) do
    local r,f = pcall(fixfile,file)
    if not r then
        table.insert(failed,string.format("filename: %s error: %s",file,f))
    elseif f then
        infected+=1
    end
end

local s = string.format("Found %s infected file%s%s%s",infected>0 and "and cleaned "..infected or infected,infected==1 and "" or "s",infected==0 and " (you were clean)" or "",#failed>0 and string.format(" %s of which failed to be fixed (check infected.txt for info on the files)",#failed) or "")
if #failed>0 then writefile("infected.txt",table.concat(failed,"\n")) end
messagebox(s,"Disinfection notice",#failed>0 and 16 or 32)
