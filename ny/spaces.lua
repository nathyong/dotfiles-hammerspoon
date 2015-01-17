local spaces = {}

local event = hs.eventtap.event

spaces.modifiers = {ctrl = true}

--- spaces.moveToSpace(key)
--- Function
---
--- 'key' should be a string describing the key to press to move to a space.
---
--- Move to a particular space by simulating the key events needed to move to
--- that space, bringing a window along with it if there is one.
function spaces.moveToSpace(key)
  local win = hs.window.focusedWindow()
  if win == nil then
    newKeyEvent(spaces.modifiers, key, true):post()
    newKeyEvent(spaces.modifiers, key, false):post()
  else
    local position0 = hs.mouse.get()
    local frame = win:frame()
    local position = {x=frame.x + 65, y=frame.y + 7}
    hs.mouse.set(position)
    os.execute("sleep 0.1")
    event.newMouseEvent(event.types.leftmousedown, position, 'left'):post()
    newKeyEvent(spaces.modifiers, key, true):post()
    event.newMouseEvent(event.types.leftmousedragged, position, 'left'):post()
    newKeyEvent(spaces.modifiers, key, false):post()
    event.newMouseEvent(event.types.leftmouseup, position, 'left'):post()
    os.execute("sleep 0.1")
    hs.mouse.set(position0)
  end
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
