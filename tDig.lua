-- @file tDig.lua
-- ComputerCraft
-- This is tDig - an API for better turtle digging.
--
-- Dependencies:
--   * tLog
--
-- Public functions: 
--   * front()
--   * up()
--   * down()

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
-- Max number of move tries when movement is blocked.
local max_tries = 20
-- Time in seconds to wait to prevent sand/gravel.
local delay = 0.2

-------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------

-- DIG
-- Turtle digging action with block detection.
--
-- @return boolean - Whether dig was successful or not.
function front()
  local tries = 0
  while t.detect() do
    t.dig()
    sleep(delay)
    tries = tries + 1
    if tries > max_tries then
      _log('warning' ,'Dug for too long.')
      return false
    end
  end
  if debug then
    _log('debug', 'front')
  end
  return true
end

-- DIG UP
-- Turtle digging up action with block detection.
--
-- @return boolean - Whether dig was successful or not.
function up()
  local tries = 0
  while t.detectUp() do
    t.digUp()
    sleep(delay)
    tries = tries + 1
    if tries > max_tries then
      _log('warning' ,'Dug up for too long.')
      return false
    end
  end
  if debug then
    _log('debug', 'up')
  end
  return true
end

-- DIG DOWN
-- Turtle digging down action with block detection.
--
-- @return boolean - Whether dig was successful or not.
function down()
  local tries = 0
  while t.detectDown() do
    digged = t.digDown()
    sleep(delay)
    tries = tries + 1
    if tries > max_tries and not digged then
      _log('warning' ,'Dig down reached bedrock')
      return false
    end
  end
  if debug then
    _log('debug', 'down')
  end
  return true
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
    log[level](os.getComputerLabel(), 'tDig', message)
  else
    print(level .. ': ' .. message)
  end
end

-------------------------------------------------------------------------------
-- TESTING
-------------------------------------------------------------------------------

-- TEST
-- @scenario In front of the turtle stack (10) sand or gravel, above and below
--   it a simple block like cobblestone. It should break the block bellow, end
--   the stack in front and then break the block above it.
function test()
  debug = true

  down()
  front()
  up()

  debug = false
end
