-- Unsupported Spaces extension. Uses private APIs but works okay.
-- (http://github.com/asmagill/hammerspoon_asm.undocumented)
local spaces = require("hs._asm.undocumented.spaces")

-- Local dependencies
local ny = {spaces = require "ny.spaces",
            window = require "ny.window"}

-- Some nice constants
hs.window.animationDuration = 0

-- window management key bindings
hs.hotkey.bind({"alt", "shift"}, "C", function()
  hs.window.focusedWindow():close()
  ny.window.focusInterestingWindow()
end)
hs.hotkey.bind({"alt", "shift"}, "space", function()
    local win = hs.window.focusedWindow()
    if win == nil then return end
    win:maximize() end)

-- application management bindings
applaunchTable = {s = "Skype",
                  t = "iTerm",
                  f = "Firefox",
                  t = "Thunderbird",
                  k = "KakaoTalk"}
applaunch = hs.hotkey.modal.new({"alt"}, "w")
applaunch:bind({}, "escape", function() applaunch:exit() end)
for key, name in pairs(applaunchTable) do
  applaunch:bind({"alt"}, key, function()
    hs.application.launchOrFocus(name)
    applaunch:exit()
  end)
end

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
hs.hotkey.bind({"alt", "shift"}, "A", function() toggle_console() end)

-- key bindings for moving spaces
ny.spaces.modifiers = {alt = true}
for i = 1, 9 do
  i = tostring(i)
  hs.hotkey.bind({"alt"}, i, function() ny.spaces.moveToSpace(i) end)
  hs.hotkey.bind({"shift", "alt"}, i, function() ny.spaces.moveWindowToSpace(i) end)
end

-- something nice to bring up terminal windows
hs.hotkey.bind({"alt", "shift"}, "Return", function()
    local itermApp = hs.appfinder.appFromName("iTerm2")
    if itermApp == nil then
      hs.application.launchOrFocus("iTerm")
    else
      itermApp:selectMenuItem({"Shell", "New Window"})
    end
end)

-- currently useless code
function applicationWatcher(appName, eventType, appObject)
  print(appName, eventType, appObject)
--     if (eventType == hs.application.watcher.activated) then
--         if (appName == "Finder") then
--             -- Bring all Finder windows forward when one gets activated
--             appObject:selectMenuItem({"Window", "Bring All to Front"})
--         elseif (appName == "iTunes") then
--             -- Ensure the MiniPlayer window is visible and correctly placed, since it likes to hide an awful lot
--             state = appObject:findMenuItem({"Window", "MiniPlayer"})
--             if state and not state["ticked"] then
--                 appObject:selectMenuItem({"Window", "MiniPlayer"})
--             end
--             _animationDuration = hs.window.animationDuration
--             hs.window.animationDuration = 0
--             hs.layout.apply({ iTunesMiniPlayerLayout })
--             hs.window.animationDuration = _animationDuration
--         end
--     elseif (eventType == hs.application.watcher.launching) then
--         if (appName == "Call of Duty: Modern Warfare 3") then
--             print("CoD Starting")
--             hs.itunes.pause()
--             local tbDisplay = hs.screen.findByName("Thunderbolt Display")
--             if (tbDisplay) then
--                 tbDisplay:setPrimary()
--             end
--         end
--     elseif (eventType == hs.application.watcher.terminated) then
--         if (appName == "Call of Duty: Modern Warfare 3") then
--             print("CoD Stopping")
--             local mbDisplay = hs.screen.findByName("Color LCD")
--             if (mbDisplay) then
--                 mbDisplay:setPrimary()
--             end
--             if hs.screen.findByName("Thunderbolt Display") then
--                 hs.layout.apply(dual_display)
--             end
--         end
--     end
end
-- hs.application.watcher.new(applicationWatcher):start()

-- auto reload the configuration
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/",
  function() hs.reload() end):start()

hs.notify.new({title = "Hammerspoon config loaded",
               autoWithdraw = true}):send()
