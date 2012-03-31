
atom.input.bind atom.button.LEFT, 'click'
atom.input.bind atom.key.W, 'warp'
atom.input.bind atom.key.S, 'warpstone'
atom.input.bind atom.key.A, 'attack'
atom.input.bind atom.key.ESC, 'cancel'
atom.input.bind atom.key.LSHIFT, 'accelerate'

atom.input.bind atom.key.B, 'back'
atom.input.bind atom.key.F, 'fwd'

canvas = atom.canvas
canvas.width = 1280
canvas.height = 720

bg = new Image
bg.src = 'bg_ruins720.png'

origin = {x:32,y:425}
tileW = 56*2
tileH = 28*2

image = (src) -> (i = new Image).src = src; i
wiz =
  img: image 'Staticpose.png'
  anchor: {x: 40, y: 89-10}

stoneImg = new Image
stoneImg.src = 'stone.png'

selectorImg = new Image
selectorImg.src = 'Selector.png'

selector =
  img: image 'Selector.png'
  anchor: {x:45, y:50}


currentAnimation = null

dot = (a, b) -> a.x * b.x + a.y * b.y
mag = (a) -> Math.sqrt(a.x * a.x + a.y * a.y)
proj = (a, b) -> dot(a,b) / mag(b)
screenToMap = (mx, my) ->
  # get vector from origin to mouse in screen coords
  sx = mx - origin.x
  sy = my - origin.y
  s = {x:sx, y:sy*2}
  xUnit = {x: tileW/2, y: -tileH}
  yUnit = {x: tileW/2, y: tileH}
  console.log 'xUnit',xUnit.x,xUnit.y
  console.log 'len(xUnit)',mag(xUnit)
  console.log 'proj(xUnit,xUnit)', proj(xUnit,xUnit)
  console.log 'proj(xUnit,yUnit)', proj(xUnit,yUnit)
  x = proj s, xUnit
  y = proj s, yUnit
  l = mag(xUnit)
  {tileX:Math.floor(x/l), tileY:Math.floor(y/l)}

ctx = atom.ctx


unitTypes =
  wizard: {hp:2, abilities:['Warp', 'Attack'], speed:2}

class Unit
  constructor: (@x, @y, @type, @owner = 'red') ->
    @type = unitTypes[@type] if typeof @type is 'string'
    @state = 'alive'
    @hp = @type.hp

  draw: ->
    return @animation.call(@) if @animation
    if @selected then drawAtIsoXY selector, @x, @y
    drawAtIsoXY wiz, @x, @y
    ctx.restore()

  z: 0

class Stone
  constructor: (@x, @y, @owner) ->
    @age = 0

  draw: ->
    ctx.save()
    ctx.translate origin.x, origin.y
    x = tileW/2*(@x+@y)
    y = tileH/2*(-@x+@y)
    ctx.fillStyle = if @age then 'gray' else @owner
    #ctx.fillRect x, y-20, tileW, 20
    ctx.drawImage stoneImg, x+tileW/2-38, y-20
    ctx.restore()

  z: 1

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

# when we're in the 'target' state, this specifies the selected unit action (Warp, Attack, Place Warpstone, etc)
selectedAction = null
warpee = null

unitAt = (x,y) ->
  for unit in units
    if unit.x is x and unit.y is y
      return unit

stoneAt = (x, y) ->
  for w in warpstones
    return w if w.x is x and w.y is y

lerp = (from, to, t) ->
  {x:from.x*(1-t)+to.x*t, y:from.y*(1-t)+to.y*t}

# sprite is {img, anchor}
drawAtIsoXY = (sprite, x, y) ->
  ctx.save()
  ctx.translate origin.x, origin.y
  px = tileW/2*(x+y)
  py = tileH/2*(-x+y)
  ctx.drawImage sprite.img, px+tileW/2-sprite.anchor.x, py-sprite.anchor.y
  ctx.restore()

class MoveAnim
  constructor: (@unit, @from, @to) ->
    @t = 0
    @duration = 0.5
    anim = @
    @unit.animation = ->
      pos = lerp anim.from, anim.to, anim.t/anim.duration
      drawAtIsoXY wiz, pos.x, pos.y

  step: (dt) ->
    end = @duration
    @t = Math.min end, @t + dt
    if @t >= end
      return true
  end: ->
    @unit.animation = null


class MoveAction
  constructor: (@u, @x, @y) ->
    @prevX = @u.x
    @prevY = @u.y
  apply: ->
    @u.x = @x
    @u.y = @y
    @u.tired = true
    currentAnimation = new MoveAnim @u, {x:@prevX,y:@prevY}, {x:@x,y:@y}
  unapply: ->
    @u.x = @prevX
    @u.y = @prevY
    @u.tired = false
    currentAnimation = new MoveAnim @u, {x:@x,y:@y}, {x:@prevX,y:@prevY}

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

class PlaceStone
  constructor: (x, y, owner) ->
    @stone = new Stone x, y, owner
    @stone.marker = this

    warpstones.push @stone

  apply: ->
    #warpstones.push @stone

  unapply: ->
    #warpstones = (w for w in warpstones when w != @stone)

class WarpIn
  constructor: (@u) ->

  apply: ->
    units.push @u

  unapply: ->
    removeUnit @u

class WarpOut
  constructor: (@u) ->

  apply: ->
    removeUnit @u

  unapply: ->
    units.push @u

class EndDay
  constructor: ->
    # Units that still have a turn during this day

  apply: ->
    w.age++ for w in warpstones

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

    w.age-- for w in warpstones

# action is {apply:->, unapply:->}
past = []
future = (new EndDay for [1..20])

pendingActions = [] # [{action:a,direction:'forward'}]

endDays = (d for d in future)
endDays.reverse()


perform = ({action, direction}) ->
  throw 'shouldnt be any current anim' if currentAnimation
  if direction is 'forward'
    action.apply()
  else
    action.unapply()

suspendAnimation = (f) ->
  throw 'shouldnt be any current anim' if currentAnimation
  f()
  for a in pendingActions
    perform a
    currentAnimation?.end?()
    currentAnimation = null
  pendingActions = []

back = ->
  action = past.pop()
  return unless action
  pendingActions.push {action, direction:'back'}
  future.push action
  action

forward = ->
  action = future.pop()
  return unless action
  pendingActions.push {action, direction:'forward'}
  past.push action
  action

goToBeginning = -> while back()
  ;

goToEnd = -> while forward()
  ;

getActiveUnits = (player) ->
  oldTime = future[future.length-1]
  suspendAnimation ->
    goToBeginning()
    goToEnd()

  activeUnits = []
  for d, i in endDays
    activeUnits[i] = (u for u in d.activeUnits when u.owner is player)

  suspendAnimation ->
    back() while future[future.length-1] isnt oldTime
  activeUnits

goToEvening = (dayNum) ->
  if endDays[dayNum] in future
    forward() while future[future.length-1] isnt endDays[dayNum]
  else
    back() while future[future.length-1] isnt endDays[dayNum]
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

currentUnitActed = ->
  forward()
  removeActiveUnit selected, currentDay
  sel null
  state = 'select'

  for d in [currentDay...20].concat([0...currentDay])
    if unitsToMove[d].length
      goToEvening d
      break
  return


suspendAnimation -> goToEvening 2
future.push new WarpIn(new Unit 3, 3, 'wizard', 'red')

suspendAnimation -> turnStart()

atom.run
  update: (dt) ->
    if currentAnimation
      speed = if atom.input.down 'accelerate' then 5 else 1
      # update anim
      completed = currentAnimation.step(dt * speed)
      if completed
        currentAnimation.end?()
        currentAnimation = null
      else
        return
    while pendingActions.length > 0
      a = pendingActions.shift()
      perform a
      return if currentAnimation


    maybeEndTurn()

    if state is 'select'
      if atom.input.pressed 'back'
        goToEvening Math.max(currentDay - 1, 0)
        return
      if atom.input.pressed 'fwd'
        goToEvening Math.min(currentDay + 1, 19)
        return


    if atom.input.pressed 'click'
      {tileX, tileY} = screenToMap atom.input.mouse.x, atom.input.mouse.y
      console.log 'tile', tileX, tileY
      #tileX = Math.floor atom.input.mouse.x/80
      #tileY = Math.floor atom.input.mouse.y/80
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
          w = stoneAt tileX, tileY
          if m <= selected.type.speed and !unitAt(tileX, tileY) and (!w or w.age)
            future.push new MoveAction selected, tileX, tileY
            forward()
            state = 'act'

        else if atom.input.pressed 'cancel'
          # go back to select and unselect the unit
          state = 'select'
          sel null

      when 'act'
        if atom.input.pressed 'attack'
          state = 'target'
          selectedAction = 'Attack'
        else if atom.input.pressed 'warp'
          state = 'target'
          selectedAction = 'Warp'
        else if atom.input.pressed 'warpstone'
          state = 'target'
          selectedAction = 'Place Warpstone'

        else if atom.input.pressed 'cancel'
          # Unmove.
          suspendAnimation ->
            back()
          future.pop()
          state = 'move'
        
        # Wait: deselect unit and state -> select

      when 'target'
        if atom.input.pressed 'click'
          m = Math.abs(selected.x - tileX) + Math.abs(selected.y - tileY)
          switch selectedAction
            when 'Attack'
              if m is 1
                future.push new AttackAction selected, tileX, tileY
                currentUnitActed()

            when 'Place Warpstone'
              if m is 1
                future.push new PlaceStone tileX, tileY, currentPlayer
                # Animation for the stone!
                currentUnitActed()

            when 'Warp'
              console.log 'warp a'
              if m is 1 and (warpee = unitAt tileX, tileY)
                state = 'warptarget'

        else if atom.input.pressed 'cancel'
          state = 'act'
          selectedAction = null

      when 'warptarget'
        if atom.input.pressed 'click'
          s = stoneAt tileX, tileY
          if s?.owner is currentPlayer
            future.push new WarpOut selected

            if s in future
              forward() while future[future.length - 1] != s
              future.pop()
            else
              back() while past[past.length - 1] != s
              past.pop()

            u = new Unit(warpee.x, warpee.y, warpee.type, warpee.owner)
            u.hp = warpee.hp
            future.push new WarpIn u

            currentUnitActed()



        # cancel: go back to act

  draw: ->
    #ctx.fillStyle = 'black'
    #ctx.fillRect 0,0, canvas.width, canvas.height
    ctx.drawImage bg, 0, 0

    stuff = warpstones.concat units
    stuff.sort (a,b) -> (a.y - b.y) or (b.x - a.x) or (a.z - b.z)
    s.draw() for s in stuff
 
#    us = (u for u in units).sort (a,b) -> (a.y - b.y) or (b.x - a.x)
#    u.draw() for u in us

    ctx.fillStyle = currentPlayer
    ctx.fillText currentPlayer, 100, 500

