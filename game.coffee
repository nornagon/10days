
atom.input.bind atom.button.LEFT, 'click'
atom.input.bind atom.key.W, 'warp'
atom.input.bind atom.key.A, 'attack'
atom.input.bind atom.key.ESCAPE, 'cancel'

atom.input.bind atom.key.B, 'back'
atom.input.bind atom.key.F, 'fwd'

canvas = atom.canvas
canvas.width = 800
canvas.height = 600

ctx = atom.ctx

TAU = Math.PI * 2

###
spritesheet = new Image
spritesheet.src = 'tanks.png'
spritesheet.onload = -> didLoad()
###

#actions = []


currentAnimation = null


unitTypes =
  wizard: {hp:2, abilities:['Warp'], speed:2}

class Unit
  constructor: (@x, @y, type, @owner = 'red') ->
    @type = unitTypes[type]
    @state = 'alive'
    @hp = @type.hp

  draw: ->
    ctx.fillStyle = if @tired then 'gray' else @owner
    ctx.fillRect @x*80+10, @y*80+10, 60, 60

    if @selected
      ctx.lineWidth = 4
      ctx.strokeStyle = 'white'
      ctx.strokeRect @x*80+10, @y*80+10, 60, 60

units = [
  new Unit 0, 0, 'wizard', 'red'
  new Unit 0, 1, 'wizard', 'red'
  new Unit 9, 0, 'wizard', 'blue'
  new Unit 9, 1, 'wizard', 'blue'
]
warpstones = []

currentDay = 0
currentPlayer = 'red'

selected = null
sel = (u) ->
  selected?.selected = false
  selected = u
  u?.selected = true

###


animationsForDay = (day) ->
  anims = []
  for u in days[day]
    d = u.days[day]
    throw 'unit in days list doesn\'t have relevant day data' unless d
    if d.movePath? then anims.push {movePath:d.movePath}
    if d.action? then anims.push {action:d.action}
  anims

targetDay = 1

pendingAnims = []
for d in [currentDay..targetDay]
  pendingAnims = pendingAnims.concat animationsForDay(d)

getCurrentAnimation = -> currentAnimation or (currentAnimation = pendingAnims.shift())
###

# states are:
# - Pick which unit to move 'select'
# - Pick where to move it   'move'
# - Pick what action to do  'act'
# - Pick where to target with your action 'target'
# - Pick destination warp stone 'warptarget'
state = 'select'


unitAt = (x,y) ->
  for unit in units
    if unit.x is x and unit.y is y
      return unit

class MoveAction
  constructor: (@u, @x, @y) ->
    @prevX = @u.x
    @prevY = @u.y
  apply: ->
    @u.x = @x
    @u.y = @y
    @u.tired = true
  unapply: ->
    @u.x = @prevX
    @u.y = @prevY
    @u.tired = false

removeUnit = (unit) ->
  units = (u for u in units when u != unit)

class AttackAction
  constructor: (@u, @x, @y) ->
    # u is attacking the tile at x,y
  apply: ->
    # 1. find a live unit at x,y
    target = unitAt @x, @y
    return unless target
    # 2. deal 1 damage to it
    target.hp--
    # 3. set its state to dead if its hp is 0 and if we killed it, store that fact
    @killed = target if target.hp <= 0
    removeUnit target if @killed


  unapply: ->
    # 1. if we killed a unit last time we were simulated, find a dead unit at x,y and revive it
    if @killed
      target = @killed
      units.push target
    else
      target = unitAt @x, @y
      return unless target

    # 2. add 1 hp to unit at x,y
    target.hp++

class WarpIn
  constructor: (@u) ->

  apply: ->
    units.push @u

  unapply: ->
    removeUnit @u

class EndDay
  constructor: ->
    # Units that still have a turn during this day

  apply: ->
    newUnits = []

    @activeUnits = []
    for u in units
      if u.tired
        u.tired = false
        newUnits.push u
      else
        @activeUnits.push u

    units = newUnits
    currentDay++

  unapply: ->
    currentDay--
    for u in units
      u.tired = true

    units = units.concat @activeUnits


# action is {apply:->, unapply:->}
past = []
future = (new EndDay for [1..20])

endDays = (d for d in future)
endDays.reverse()

back = ->
  action = past.pop()
  return unless action
  action.unapply()
  future.push action
  action

forward = ->
  action = future.pop()
  return unless action
  action.apply()
  past.push action
  action

goToBeginning = -> while back()
  ;

goToEnd = -> while forward()
  ;

getActiveUnits = (player) ->
  goToBeginning()
  goToEnd()

  activeUnits = []
  for d, i in endDays
    activeUnits[i] = (u for u in d.activeUnits when u.owner is player)

  activeUnits

goToEvening = (dayNum) ->
  goToEnd()
  while currentDay > dayNum
    back()
  return

unitsToMove = {}

turnStart = ->
  unitsToMove = getActiveUnits currentPlayer
  for d, i in unitsToMove
    if d.length
      return goToEvening i

  maybeEndTurn()

maybeEndTurn = ->
  for d, i in unitsToMove
    if d.length
      return false

  # End the turn
  currentPlayer = if currentPlayer is 'red' then 'blue' else 'red'
  turnStart()

removeActiveUnit = (unit, d) ->
  unitsToMove[d] = (u for u in unitsToMove[d] when u != unit)

goToEvening 4
future.push new WarpIn(new Unit 3, 3, 'wizard', 'red')

turnStart()

atom.run
  update: (dt) ->
    # if we ticked time above, there might now be a current anim
    if currentAnimation
      # update anim
      return

    maybeEndTurn()

    if atom.input.pressed 'back'
      goToEvening Math.max(currentDay - 1, 0)
    if atom.input.pressed 'fwd'
      goToEvening Math.min(currentDay + 1, 19)


    if atom.input.pressed 'click'
      tileX = Math.floor atom.input.mouse.x/80
      tileY = Math.floor atom.input.mouse.y/80
    else
      tileX = tileY = null

    switch state
      when 'select'
        if atom.input.pressed 'click'
          u = null
          for unit in units
            if unit.x is tileX and unit.y is tileY and unit.owner is currentPlayer and (unit in unitsToMove[currentDay])
              # Select the unit
              u = unit
              break

          sel u
          state = 'move' if u

      when 'move'
        if atom.input.pressed 'click'
          # TODO: BFS
          m = Math.abs(selected.x - tileX) + Math.abs(selected.y - tileY)
          if m <= selected.type.speed and !unitAt tileX, tileY
            future.push new MoveAction selected, tileX, tileY
            forward()
            state = 'act'
        # cancel: go back to select and unselect the unit

      when 'act'
        if atom.input.pressed 'attack'
          state = 'target'
        # Cancel: go back to move, remove the move action
        # Wait: deselect unit and state -> select

      when 'target'
        if atom.input.pressed 'click'
          m = Math.abs(selected.x - tileX) + Math.abs(selected.y - tileY)
          if m is 1
            future.push new AttackAction selected, tileX, tileY
            forward()
            removeActiveUnit selected, currentDay
            sel null
            state = 'select'

            for d in [currentDay...20].concat([0...currentDay])
              if unitsToMove[d].length
                goToEvening d
                break

        # cancel: go back to act








  draw: ->
    ctx.fillStyle = 'black'
    ctx.fillRect 0,0, canvas.width, canvas.height

    u.draw() for u in units

    ctx.fillStyle = currentPlayer
    ctx.fillText currentPlayer, 100, 500

