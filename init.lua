local ny = {window = require "ny.window"}

hs.window.animationDuration = 0
ny.window.persistentapps = {Hammerspoon = true, Transmission = true}

hs.hotkey.bind({"alt", "shift"}, "C", function()
    ny.window.closeOrQuit(hs.window.focusedWindow()) end)
hs.hotkey.bind({"alt", "shift"}, "space", function()
    local win = hs.window.focusedWindow()
    if win == nil then return end
    win:maximize()
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function()
                     hs.reload() end):start()

applaunch = hs.hotkey.modal.new({"alt"}, "w")
applaunch:bind({}, "escape", function() applaunch:exit() end)
applaunch:bind({"alt"}, "s", function()
    hs.application.launchOrFocus("Skype") applaunch:exit() end)
applaunch:bind({"alt"}, "t", function()
    hs.application.launchOrFocus("iTerm") applaunch:exit() end)
applaunch:bind({"alt"}, "w", function()
    hs.application.launchOrFocus("Firefox") applaunch:exit() end)
applaunch:bind({"alt"}, "m", function()
    hs.application.launchOrFocus("Thunderbird") applaunch:exit() end)

hs.alert("[config] reloaded", 0.5)
