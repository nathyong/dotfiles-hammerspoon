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

return window
