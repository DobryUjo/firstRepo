-- Ensure the peripherals are connected
local speaker = peripheral.find("speaker")
local drive = peripheral.find("drive")  -- Looking for "drive" instead of "disk"
local modem = peripheral.find("modem")

if not speaker then
    print("No speaker found!")
    return
end

if not drive then
    print("No disk drive found!")
    return
end

if not modem then
    print("No modem found!")
    return
end

-- Make sure the modem is connected and open the communication channel
modem.open(123)  -- Open a communication channel on port 123

-- URL for the .dfpwm file (replace with your own URL)
local url = "https://github.com/DobryUjo/firstRepo/raw/refs/heads/main/erika.dfpwm"
local fileName = "erika.dfpwm"

-- Download the .dfpwm file and save it to the floppy disk
print("Downloading the .dfpwm file...")
local file = http.get(url)
if not file then
    print("Failed to download the file!")
    return
end

-- Open the disk for writing
local diskFile = drive.open(fileName, "wb")  -- Use "drive" instead of "disk"
if not diskFile then
    print("Failed to open the disk for writing!")
    return
end

-- Write the file content to the floppy disk
local data = file.readAll()
diskFile.write(data)
diskFile.close()
file.close()

print("File downloaded and saved to disk.")

-- Now play the .dfpwm file using the speaker
local dfpwm = require("cc.audio.dfpwm")
local decoder = dfpwm.make_decoder()

-- Open the .dfpwm file from the floppy disk
local diskFile = drive.open(fileName, "rb")  -- Use "drive" instead of "disk"
if not diskFile then
    print("Failed to open the .dfpwm file from disk!")
    return
end

local data = diskFile.readAll()
diskFile.close()

-- Play the audio from the .dfpwm file in chunks
for chunk in data:gmatch(string.rep(".", 512)) do
    local decoded = decoder(chunk)
    speaker.playAudio(decoded)
    os.sleep(0)  -- Prevent lag
end

print("🎶 Rickroll Complete!")
