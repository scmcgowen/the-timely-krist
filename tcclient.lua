
local args = {...}

local function printArgs()
    print("The Timely Krist download client")
    print("Usage:")
    print("tcclient list")
    print(" - List all published issues")
    print("tcclient get <issue> <fn>")
    print(" - Save <issue> to <fn> as a 2dj file")
    print("tcclient print <issue>")
    print(" - Print <issue> directly")
end

if #args < 1 then
    printArgs()
    return
end



if args[1] == "list" then
    local response = http.get("https://raw.githubusercontent.com/scmcgowen/the-timely-krist/main/issue_list.txt")
    term.clear()
    term.setCursorPos(1,1)
    print("Current issues:")
    textutils.pagedPrint(response.readAll())
    response.close()
elseif args[1] == "get" and args[2] and args[3] then
    local response = http.get("https://raw.githubusercontent.com/scmcgowen/the-timely-krist/main/issues/issue_"..args[2]..".2dj",nil,true)
    
    local f = assert(fs.open(args[3], "wb"))
    f.write(response.readAll())
    response.close()
    f.close()
elseif args[1] == "print" and args[2] then
    shell.run("poster https://raw.githubusercontent.com/scmcgowen/the-timely-krist/main/issues/issue_"..args[2]..".2dj")
   
else
    printArgs()
end