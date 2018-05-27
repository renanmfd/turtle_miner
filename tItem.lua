-- @file tItem.lua
-- ComputerCraft
-- This is tItem - an API for better turtle item/slot handling.
--
-- Dependencies:
--   * tLog
--
-- Public functions: 
--   * select(slot)
--   * getSelectedSlot()
--   * getItemCount(slot)
--   * getItemSpace(slot)
--   * getItemDetail(slot)
--   * transferTo(slot, quantity)
--   * inspect()
--   * inspectUp()
--   * inspectDown()
--   * detect()
--   * detectUp()
--   * detectDown()
--   * compare()
--   * compareUp()
--   * compareDown()
--   * compareTo(slot)
--   * drop(count)
--   * dropUp(count)
--   * dropDown(count)
--   * suck(count)
--   * suckUp(count)
--   * suckDown(count)

-------------------------------------------------------------------------------
-- VARIABLES
-------------------------------------------------------------------------------

-- API: Alias for native turtle.
local t = turtle
-- API: Alias for custom tLog - Log messages with severity.
os.loadAPI('tLog');
local log = tlog or false

-- Whether to run on debug mode - verbose log.
local debug = true

-------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------

-- SELECT
-- Select one inventory slot.
--
-- @oaram number slot - Inventory slot selected.
-- @return boolean - Whether slot was selected or not.
function select(slot)
  return t.select()
end

-- GET SELECTED SLOT
-- Get the id of the selected slot.
--
-- @return number - Slot currently selected.
function getSelectedSlot()
  return t.getSelectedSlot()
end

-- GET ITEM COUNT
-- Get the number of items in one specific slot.
--
-- @oaram number slot - Inventory slot to check.
-- @return number - Quantity of items in the slot.
function getItemCount(slot)
  slot = slot or getSelectedSlot()
  return t.getItemCount(slot)
end

-- GET ITEM SPACE
-- Get the number of items left to fill a slot.
--
-- @oaram number slot - Inventory slot to check.
-- @return number - Quantity of items to fill the slot.
function getItemSpace(slot)
  slot = slot or getSelectedSlot()
  return t.getItemSpace(slot)
end

-- GET ITEM DETAIL
-- Get the details of the item in a specific slot.
--
-- @oaram number slot - Inventory slot to check.
-- @return table - Information on the item.
function getItemDetail(slot)
  slot = slot or getSelectedSlot()
  return t.getItemDetail(slot)
end

-- TRANSFER TO
-- Transfer items from slot to current select slot.
--
-- @oaram number slot - Inventory slot to get items.
-- @oaram number quantity - Number of items to be transfered.
-- @return boolean - Whether transfer was successful or not.
function transferTo(slot, quantity)
  quantity = quantity or 64
  return t.transferTo(slot, quantity)
end

-- INSPECT
-- Get the data of the block in front/up/down of the turtle.
--
-- @return boolean - Whether the inspect was successful.
-- @return table/string - Data of the block or error message.
function inspect()     return t.inspect()     end
function inspectUp()   return t.inspectUp()   end
function inspectDown() return t.inspectDown() end

-- DETECT
-- Get the data of the block in front/up/down of the turtle.
--
-- @return boolean - Whether there is a block in front/up/down or not.
function detect()     return t.detect()     end
function detectUp()   return t.detectUp()   end
function detectDown() return t.detectDown() end

-- COMPARE
-- Get the data of the block in front/up/down of the turtle.
--
-- @param number slot - Compare slot.
-- @return boolean - Whether the block in front is the same as the one in the
--   currently selected slot.
function compare()       return t.compare()       end
function compareUp()     return t.compareUp()     end
function compareDown()   return t.compareDown()   end
function compareTo(slot) return t.compareTo(slot) end

-- DROP
-- Drop the item(s) item the selected slot.
--
-- @param number count - How many items should be dropped.
-- @return boolean - Whether there is a block in front/up/down or not.
function drop(count)     return t.drop(count)     end
function dropUp(count)   return t.dropUp(count)   end
function dropDown(count) return t.dropDown(count) end

-- SUCK
-- Suck items from ground or inventory.
--
-- @param number count - How many items should be dropped.
-- @return boolean - Whether there is a block in front/up/down or not.
function suck(count)     return t.suck(count)     end
function suckUp(count)   return t.suckUp(count)   end
function suckDown(count) return t.suckDown(count) end

-------------------------------------------------------------------------------
-- PRIVATE
-------------------------------------------------------------------------------

-- LOG
-- Log messages for turtle actions.
--
-- @param string level - Can be debug, notice, warning or error.
-- @param string message - Reason for the log.
function _log(level, message)
  if log and log[level] ~= nill then
    log[level](os.getComputerLabel(), 'tDig', message)
  else
    print(level .. ': ' .. message)
  end
end

-------------------------------------------------------------------------------
-- TESTING
-------------------------------------------------------------------------------

-- TEST
-- @scenario
function test()
  debug = true

  debug = false
end
