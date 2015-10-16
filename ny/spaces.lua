local spaces = {}

local event = hs.eventtap.event
local window = require "ny.window"
local asmspc = require "../hs._asm.undocumented.spaces"

spaces.modifiers = {ctrl = true}

function spaces.moveToSpace(key)
  asmspc.moveToSpace(key)
  window.focusInterestingWindow()
end

--- spaces.moveToSpace(key)
--- Function
---
--- 'key' should be a string describing the key to press to move to a space.
---
--- Move to a particular space by simulating the key events needed to move to
--- that space, bringing a window along with it if there is one.
function spaces.moveWindowToSpace(key)
  lastspace = asmspc.currentSpace()
  local win = hs.window.focusedWindow()
  if win == nil then
    asmspc.moveToSpace(key)
  else
    local position0 = hs.mouse.getAbsolutePosition()
    local frame = win:frame()
    local position = {x=frame.x + 65, y=frame.y + 7}
    hs.mouse.setAbsolutePosition(position)
    event.newMouseEvent(event.types.leftMouseDown, position):post()
    asmspc.moveToSpace(key)
    event.newMouseEvent(event.types.leftMouseUp, position):post()
    hs.mouse.setAbsolutePosition(position0)
  end
  asmspc.moveToSpace(lastspace)
  window.focusInterestingWindow()
end


--- newKeyEvent(modifiers, key, isPressed) -> event
--- Function
---
--- Acts like hs.eventtap.event.newKeyEvent(...), but actually works.
function newKeyEvent(modifiers, key, isPressed)
  local kev = event.newKeyEvent({}, '', isPressed)
  local kc = hs.keycodes.map[key]
  if kc ~= nil then
    kev:setKeyCode(kc)
  end
  kev:setFlags(modifiers)
  return kev
end

return spaces
