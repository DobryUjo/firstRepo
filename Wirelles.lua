local speaker = peripheral.find("speaker")
local disk = peripheral.find("drive")
local modem = peripheral.find("modem")

if not speaker then
    print("No speaker found!")
    return
end

if not disk then
    print("No disk drive found!")
    return
end

if not modem then
    print("No modem found!")
    return
end


modem.open(123) 

local url = "https://github.com/DobryUjo/firstRepo/raw/refs/heads/main/erika.dfpwm"
local fileName = "erika.dfpwm"


print("Downloading the .dfpwm file...")
local file = http.get(url)
if not file then
    print("Failed to download the file!")
    return
end

local diskFile = disk.open(fileName, "wb")
if not diskFile then
    print("Failed to open the disk for writing!")
    return
end


local data = file.readAll()
diskFile.write(data)
diskFile.close()
file.close()

print("File downloaded and saved to disk.")


local dfpwm = require("cc.audio.dfpwm")
local decoder = dfpwm.make_decoder()


local diskFile = disk.open(fileName, "rb")
if not diskFile then
    print("Failed to open the .dfpwm file from disk!")
    return
end

local data = diskFile.readAll()
diskFile.close()


for chunk in data:gmatch(string.rep(".", 512)) do
    local decoded = decoder(chunk)
    speaker.playAudio(decoded)
    os.sleep(0) 
end

