-- @file tAttack.lua
-- ComputerCraft
-- This is tAttack - an API for better turtle attack.
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
local max_tries = 50

-------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------

-- FRONT
-- Turtle attacking action.
--
-- @return boolean - Whether attack was successful or not.
function front()
  local tries = 0
  attack = t.attack()
  while attack do
    attack = t.attack()
    tries = tries + 1
    if tries > max_tries then
      _log('warning' ,'Attack for too long.')
      return false
    end
  end
  if debug then
    _log('debug', 'front')
  end
  return true
end

-- UP
-- Turtle attacking up action.
--
-- @return boolean - Whether attack was successful or not.
function up()
  local tries = 0
  attack = t.attackUp()
  while attack do
    attack = t.attackUp()
    tries = tries + 1
    if tries > max_tries then
      _log('warning' ,'Attack up for too long.')
      return false
    end
  end
  if debug then
    _log('debug', 'up')
  end
  return true
end

-- DOWN
-- Turtle attacking down action.
--
-- @return boolean - Whether attack was successful or not.
function down()
  local tries = 0
  attack = t.attackDown()
  while attack do
    attack = t.attackDown()
    tries = tries + 1
    if tries > max_tries then
      _log('warning' ,'Attack down for too long.')
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
    log[level](os.getComputerLabel(), 'tAttack', message)
  else
    print(level .. ': ' .. message)
  end
end

-------------------------------------------------------------------------------
-- TESTING
-------------------------------------------------------------------------------

-- TEST
-- @scenario Put mobs above, below and in front of the turtle with restricted
--   movement. It can be more than one in each direction. It will attack down,
--   in front and up, killing all mobs before going to the next direction.
function test()
  debug = true

  down()
  front()
  up()

  debug = false
end
