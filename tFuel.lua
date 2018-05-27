-- @file tFuel.lua
-- ComputerCraft
-- This is tFuel - an API for better turtle fuel handling.
--
-- Dependencies:
--   * tLog
--
-- Public functions: 
--   * getLevel
--   * refuel

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

-- GET FUEL LEVEL
-- Check how much fuel is available.
function getLevel()
  if debug then
    _log('debug', 'GetFuelLevel')
  end
  return t.getFuelLevel()
end

-- REFUEL
-- Proceed with turtle refuel.
--
-- @param number quantity - How many items should be consumed for refuel.
function refuel(quantity)
  quantity = quantity or 1
  if debug then
    _log('debug', 'refuel ' .. steps)
  end
  return t.refuel(quantity)
end


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
    log[level](os.getComputerLabel(), 'tFuel', message)
  else
    print(level .. ': ' .. message)
  end
end

-------------------------------------------------------------------------------
-- TESTING
-------------------------------------------------------------------------------

-- TEST
-- @scenario Add 64 coal (80 fuel units each) to the first slot. Half of the
--   coal stack should be consumed after testing.
function test()
  debug = true

  print('Testing...');
  fuel = getLevel()
  refuel(32)
  newfuel = getLevel()
  if (newfuel - fuel == 80 * 32) then
    print('SUCCESS');
  else
    print('FAIL');
  end

  debug = false
end