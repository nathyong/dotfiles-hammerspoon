local window = {}

window.persistentapps = {Hammerspoon = true}

function window.closeOrQuit(win)
  if win == nil then return end
  local app = win:application()
  if app ~= nil and #app:allWindows() == 1 then
    if window.persistentapps[app:title()] ~= nil then
      win:close()
    else
      app:kill()
    end
  else
    win:close()
  end
end

--[[ is this window worth of being displayed?
params : window (type hs.window)
returns : bool ]]
function window.hintableWindow(window)
  return (window:title() ~= "") and (window:application():title() ~= "")
end

--[[ get a list of visible windows that match our
display criteria
returns : list of window objects ]]
function window.hintableWindows()
  local windows = hs.window.orderedWindows()
  return hs.fnutils.filter(windows, hintableWindow)
end

function window.focusInterestingWindow()
  if next(window.hintableWindows()) ~= nil then
    window.hintableWindows()[1]:focus()
  end
end

return window
