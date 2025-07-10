---@class SoundData
---@field soundId string
---@field soundType string @default
---@field soundName string
---@field maxVolume number
---@field looped boolean

---@class SoundDataWithEntity
---@field soundType string @entity
---@field soundName string | string[] @Sound name or list of sound names
---@field maxVolume number
---@field maxDistance number
---@field entityNetId integer
---@field looped boolean | number | {[1]: number, [2]: number} @Basic looping, loop with time between, loop with random time between

---@class SoundDataWithLocation
---@field soundId string
---@field soundType string @location
---@field soundName string
---@field maxVolume number
---@field maxDistance number
---@field location vector3
---@field looped boolean

---@class NUISoundData
---@field soundId string
---@field soundName string | string[] @Sound name or list of sound names
---@field volume number @0.0-1.0
---@field looped? boolean | number | {[1]: number, [2]: number} @Basic looping, loop with time between, loop with random time between
---@field playCount? number @How many times to play the sound