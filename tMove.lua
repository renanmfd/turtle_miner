-- @file tMove.lua
-- ComputerCraft
-- This is tMove - an API for better turtle actions.
--
-- Dependencies:
--   * tLog
--   * tTracker
--   * tAttack
--   * tDig
--
-- Public functions: 
--   * dig()
--   * digUp()
--   * digDown()
--   * forward(steps)
--   * up(steps)
--   * down(steps)
--   * back(steps)
--   * turnLeft()
--   * turnRight()
--   * goLeft(steps)
--   * goRight(steps)
--   * strafeLeft(steps)
--   * strafeRight(steps)
--   * turnAround()

-- API: Alias for native turtle.
local t = turtle
-- API: Alias for custom ptracker - position tracker.
os.loadAPI('tTracker');
local track = tTracker or false
-- API: Alias for custom tLog - Log messages with severity.
os.loadAPI('tLog');
local log = tLog or false
-- API: Alias for custom tAttack - Turtle attack actions.
os.loadAPI('tAttack');
local attack = tAttack or false
-- API: Alias for custom tDig - Turtle digging actions.
os.loadAPI('tDig');
local dig = tDig or false

-- Max number of move tries when movement is blocked.
local max_tries = 20
-- Whether to run on debug mode - verbose log.
local debug = true

-------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------

-- FORWARD
-- Goes forward no matter what is in front of it. Can only be stopped by
-- bedrock as it attack and dig it's way through.
--
-- @param number steps - How many meters/blocks turtle should move.
-- @return boolean - Whether move was successful or not.
function forward(steps)
  steps = steps or 1
  for i = 1, steps do
    local tries = 0
    while not t.forward() do
      attack.front()
      dig.front()

      tries = tries + 1
      if tries > max_tries then
        _log('warning' ,'Can\'t move forward.')
        return false
      end
    end
    if track then track.forward() end
  end
  if debug then
    _log('debug', 'forward ' .. steps)
  end
  return true
end

-- UP
-- Goes up no matter what is above it. Can only be stopped by bedrock
-- as it attack and dig it's way through.
--
-- @param number steps - How many meters/blocks turtle should move.
-- @return boolean - Whether move was successful or not.
function up(steps)
  steps = steps or 1
  for i = 1, steps do
    local tries = 0

    while t.up() ~= true do
      attack.front()
      dig.front()

      tries = tries + 1
      if tries > max_tries then
        _log('warning' ,'Can\'t move up.')
        return false
      end
    end
    if track then track.up() end
  end
  if debug then
    _log('debug', 'up ' .. steps)
  end
  return true
end

-- DOWN
-- Goes down no matter what is below it. Can only be stopped by bedrock
-- as it attack and dig it's way through.
--
-- @param number steps - How many meters/blocks turtle should move.
-- @return boolean - Whether move was successful or not.
function down(steps)
  steps = steps or 1
  for i = 1, steps do
    local tries = 0

    while t.down() ~= true do
      attack.front()
      dig.front()

      tries = tries + 1
      if tries > max_tries then
        _log('warning' ,'Can\'t move down.')
        return false
      end
    end
    if track then track.down() end
  end
  if debug then
    _log('debug', 'down ' .. steps)
  end
  return true
end
 
-- BACK
-- Goes back no matter what is below it. Can only be stopped by bedrock
-- as it attack and dig it's way through.
--
-- @param number steps - How many meters/blocks turtle should move.
-- @return boolean - Whether move was successful or not.
function back(steps)
  steps = steps or 1
  for i = 1, steps do
    local tries = 0

    while t.back() ~= true do
      turnAround()
      attack.front()
      dig.front()
      turnAround()

      tries = tries + 1
      if tries > max_tries then
        _log('warning' ,'Can\'t move back.')
        return false
      end
    end
    if track then track.down() end
  end
  if debug then
    _log('debug', 'back ' .. steps)
  end
  return true
end

-- TURN LEFT
-- Turn turtle left of current position.
--
-- @return boolean - Whether turn was successful or not.
function turnLeft()
  success = t.turnLeft()
  if success then
    if track then track.left() end
    if debug then
      _log('debug', 'turnLeft')
    end
  else
    _log('warning' ,'Could not turn left.')
  end
  return success
end

-- TURN RIGHT
-- Turn turtle right of current position.
--
-- @return boolean - Whether turn was successful or not.
function turnRight()
  success = t.turnRight()
  if success then
    if track then track.right() end
    if debug then
      _log('debug', 'turnRight')
    end
  else
    _log('warning' ,'Could not turn right.')
  end
  return success
end

-------------------------------------------------------------------------------
-- COMPOSITE HELPERS
-------------------------------------------------------------------------------

-- GO LEFT
-- Move to the left of current position some steps and keep facing left.
--
-- @param number steps - Number of steps should be given to the left.
-- @return boolean - Whether the movement was successful or not.
function goLeft(steps)
  steps = steps or 1
  if not turnLeft() then return false end
  if not forward(steps) then return false end
  return true
end

-- GO RIGHT
-- Move to the right of current position some steps and keep facing right.
--
-- @param number steps - Number of steps should be given to the right.
-- @return boolean - Whether the movement was successful or not.
function goRight(steps)
  steps = steps or 1
  if not turnRight() then return false end
  if not forward(steps) then return false end
  return true
end

-- STRAFE LEFT
-- Move to the left of current position some steps without changing face
-- position at the end of the movement.
--
-- @param number steps - Number of steps should be given to the left.
-- @return boolean - Whether the movement was successful or not.
function strafeLeft(steps)
  steps = steps or 1
  if not goLeft(steps) then return false end
  if not turnRight() then return false end
  return true
end

-- STRAFE RIGHT
-- Move to the right of current position some steps without changing face
-- position at the end of the movement.
--
-- @param number steps - Number of steps should be given to the right.
-- @return boolean - Whether the movement was successful or not.
function strafeRight(steps)
  steps = steps or 1
  if not goRight(steps) then return false end
  if not turnLeft() then return false end
  return true
end

-- TURN AROUND
-- Turn the face of the turtle to where the back was, a 180 degree turn.
--
-- @return boolean - Whether the movement was successful or not.
function turnAround()
  if not turnRight() then return false end
  if not turnRight() then return false end
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
-- @scenario
function test()
  debug = true

  up(2)
  forward(5)
  turnLeft()
  down()
  strafeLeft(5)
  turnRight() -- Ends on top of you
  sleep(3)

  down(2)
  turnAround()
  back(5)
  up()
  turnLeft()
  strafeRight(5)
  turnLeft() -- Ends on above where it began

  debug = false
end
