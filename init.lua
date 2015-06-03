local ny = {spaces = require "ny.spaces",
            window = require "ny.window"}

-- some nice constants
hs.window.animationDuration = 0
ny.window.persistentapps = {Hammerspoon = true,
                            Transmission = true}

-- window management key bindings
hs.hotkey.bind({"alt", "shift"}, "C", function()
    ny.window.closeOrQuit(hs.window.focusedWindow()) end)
hs.hotkey.bind({"alt", "shift"}, "space", function()
    local win = hs.window.focusedWindow()
    if win == nil then return end
    win:maximize() end)

-- application management bindings
applaunch = hs.hotkey.modal.new({"alt"}, "w")
applaunch:bind({}, "escape", function() applaunch:exit() end)
applaunch:bind({"alt"}, "s", function()
    hs.application.launchOrFocus("Skype") applaunch:exit() end)
applaunch:bind({"alt"}, "t", function()
    hs.application.launchOrFocus("Terminal") applaunch:exit() end)
applaunch:bind({"alt"}, "w", function()
    hs.application.launchOrFocus("Firefox") applaunch:exit() end)
applaunch:bind({"alt"}, "m", function()
    hs.application.launchOrFocus("Thunderbird") applaunch:exit() end)
applaunch:bind({"alt"}, "k", function()
    hs.application.launchOrFocus("KakaoTalk") applaunch:exit() end)

-- toggle console visibility
function toggle_console()
  local console = hs.appfinder.windowFromWindowTitle("Hammerspoon Console")
  if console and (console ~= hs.window.focusedWindow()) then
    console:focus()
  elseif console then
    console:close()
  else
    hs.openConsole()
  end
end

hs.hotkey.bind({"alt", "shift"}, "A", function()
    toggle_console()
end)

-- key bindings for moving spaces
ny.spaces.modifiers = {alt = true}
hs.hotkey.bind({"alt", "shift"}, "1", function() ny.spaces.moveToSpace("1") end)
hs.hotkey.bind({"alt", "shift"}, "2", function() ny.spaces.moveToSpace("2") end)
hs.hotkey.bind({"alt", "shift"}, "3", function() ny.spaces.moveToSpace("3") end)
hs.hotkey.bind({"alt", "shift"}, "4", function() ny.spaces.moveToSpace("4") end)
hs.hotkey.bind({"alt", "shift"}, "5", function() ny.spaces.moveToSpace("5") end)
hs.hotkey.bind({"alt", "shift"}, "6", function() ny.spaces.moveToSpace("6") end)
hs.hotkey.bind({"alt", "shift"}, "7", function() ny.spaces.moveToSpace("7") end)
hs.hotkey.bind({"alt", "shift"}, "8", function() ny.spaces.moveToSpace("8") end)
hs.hotkey.bind({"alt", "shift"}, "9", function() ny.spaces.moveToSpace("9") end)
hs.hotkey.bind({"alt", "shift"}, "0", function() ny.spaces.moveToSpace("0") end)

-- something nice to bring up terminal windows
hs.hotkey.bind({"alt", "shift"}, "Return", function()
    local itermApp = hs.appfinder.appFromName("Terminal")
    if itermApp == nil then
      hs.application.launchOrFocus("Terminal")
    else
      hs.applescript.applescript(
        [[tell application "Terminal"
            do script " "
            activate
          end tell]])
    end
end)

-- auto reload the configuration
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function()
                     hs.reload() end):start()

hs.notify.new({title = "Hammerspoon config loaded",
               autoWithdraw = true}):send()
os.execute("sleep 1s")
hs.notify.withdraw_all()
