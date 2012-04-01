
atom.input.bind atom.button.LEFT, 'click'
atom.input.bind atom.key.W, 'warp'
atom.input.bind atom.key.S, 'warpstone'
atom.input.bind atom.key.A, 'attack'
atom.input.bind atom.key.T, 'wait'
atom.input.bind atom.key.ESC, 'cancel'
atom.input.bind atom.key.LSHIFT, 'accelerate'

atom.input.bind atom.key.B, 'back'
atom.input.bind atom.key.F, 'fwd'

canvas = atom.canvas
canvas.width = 1280
canvas.height = 720


origin = {x:32,y:425}
tileW = 56*2
tileH = 28*2

image = (src) -> (i = new Image).src = src; i

bg =
  back: image 'bg_layer1.png'
  fore: image 'bg_layer_cog.png'
  canEnter: (x, y) ->
    return false if x < 0 or y < 0 or x > 11 or y > 9
    return x <= 1 if y is 0
    return x in [10, 11] if y is 9
    return y <= 3 if x is 0
    true

wiz =
  img: image 'Wizard Spritesheet.png'
  tileWidth: 100
  tileHeight: 100

  redtopleft: {x:0, y:0, num:1}
  redtopright: {x:8, y:0, num:1}
  redbotright: {x:0, y:1, num:1}
  redbotleft: {x:15, y:1, num:1}

  bluetopleft: {x:0, y:6, num:1}
  bluetopright: {x:8, y:6, num:1}
  bluebotright: {x:0, y:7, num:1}
  bluebotleft: {x:15, y:7, num:1}

  redwalktopleft: {x: 0, y: 0, num: 8}
  redwalktopright:{x: 8, y: 0, num: 8}
  redwalkbotright:{x: 0, y: 1, num: 8}
  redwalkbotleft: {x: 8, y: 1, num: 8}

  redwarptopleft: {x: 0, y:2, num:4}
  redwarptopright:{x: 5, y:2, num:4}
  redwarpbotright:{x: 0, y:3, num:4}
  redwarpbotleft: {x: 5, y:3, num:4}

  redattacktopleft: {x: 0, y:2, num:4}
  redattacktopright:{x: 5, y:2, num:4}
  redattackbotright:{x: 0, y:3, num:4}
  redattackbotleft: {x: 5, y:3, num:4}

  reddeathtopleft: {x: 9, y:3, num:4}
  reddeathtopright:{x: 13,y:3, num:4}
  reddeathbotright:{x: 13,y:2, num:4}
  reddeathbotleft: {x: 9, y:2, num:4}

  redstonebotleft: {x: 0, y:4, num:10}
  redstonebotright:{x: 10, y:4, num:10}
  redstonetopleft: {x: 0, y:5, num:10}
  redstonetopright:{x: 10, y:5, num:10}

  bluewalktopleft: {x: 0, y: 6, num: 8}
  bluewalktopright:{x: 8, y: 6, num: 8}
  bluewalkbotright:{x: 0, y: 7, num: 8}
  bluewalkbotleft: {x: 8, y: 7, num: 8}

  bluewarptopleft: {x: 0, y:8, num:4}
  bluewarptopright:{x: 5, y:8, num:4}
  bluewarpbotright:{x: 0, y:9, num:4}
  bluewarpbotleft: {x: 5, y:9, num:4}

  blueattacktopleft: {x: 0, y:8, num:4}
  blueattacktopright:{x: 5, y:8, num:4}
  blueattackbotright:{x: 0, y:9, num:4}
  blueattackbotleft: {x: 5, y:9, num:4}

  bluedeathtopleft: {x: 9, y:9, num:4}
  bluedeathtopright:{x: 13,y:9, num:4}
  bluedeathbotright:{x: 13,y:8, num:4}
  bluedeathbotleft: {x: 9, y:8, num:4}

  bluestonebotleft: {x: 0, y:10, num:10}
  bluestonebotright:{x: 10, y:10, num:10}
  bluestonetopleft: {x: 0, y:11, num:10}
  bluestonetopright:{x: 10, y:11, num:10}


  anchor: {x: 50, y: 91}

dragon =
  img: image 'dragonshheeet.png'
  tileWidth: 150
  tileHeight: 150

  redtopleft: {x:0, y:1, num:1}
  redtopright: {x:0, y:1, num:1}
  redbotleft: {x:0, y:1, num:1}
  redbotright: {x:0, y:1, num:1}

  bluetopleft: {x:0, y:4, num:1}
  bluetopright: {x:0, y:4, num:1}
  bluebotleft: {x:0, y:4, num:1}
  bluebotright: {x:0, y:4, num:1}

  redwalkbotleft: {x:0, y:0, num:9}
  redwalkbotright: {x:0, y:1, num:9}
  redwalktopright: {x:0, y:2, num:9}
  redwalktopleft: {x:0, y:3, num:9}

  bluewalkbotleft: {x:0, y:4, num:9}
  bluewalkbotright: {x:0, y:5, num:9}
  bluewalktopright: {x:0, y:6, num:9}
  bluewalktopleft: {x:0, y:7, num:9}

  # Attack and idle animations
  redattackbotleft: {x:0, y:8, num:5}
  redattackbotright: {x:0, y:9, num:5}
  redattacktopright: {x:5, y:8, num:5}
  redattacktopleft: {x:5, y:9, num:5}

  blueattackbotleft: {x:0, y:10, num:5}
  blueattackbotright: {x:0, y:11, num:5}
  blueattacktopright: {x:5, y:10, num:5}
  blueattacktopleft: {x:5, y:11, num:5}

  reddeathbotright: {x:0, y:13, num:4}
  reddeathbotleft:  {x:0, y:14, num:4}
  reddeathtopleft:  {x:0, y:15, num:4}
  reddeathtopright: {x:0, y:16, num:4}

  bluedeathbotright: {x:4, y:13, num:4}
  bluedeathbotleft:  {x:4, y:14, num:4}
  bluedeathtopleft:  {x:4, y:15, num:4}
  bluedeathtopright: {x:4, y:16, num:4}

  anchor: {x:75, y:120}

stoneImg =
  img: image 'stone.png'
  anchor: {x:38, y:20}

selectorImg = new Image
selectorImg.src = 'Selector.png'

selector =
  img: image 'Selector.png'
  anchor: {x:45, y:50}

movementShadow =
  img: image 'Movementshadow.png'
  anchor: {x:83, y:59}


reversing = false
reversingState = 0

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
#  console.log 'xUnit',xUnit.x,xUnit.y
#  console.log 'len(xUnit)',mag(xUnit)
#  console.log 'proj(xUnit,xUnit)', proj(xUnit,xUnit)
#  console.log 'proj(xUnit,yUnit)', proj(xUnit,yUnit)
  x = proj s, xUnit
  y = proj s, yUnit
  l = mag(xUnit)
  {tileX:Math.floor(x/l), tileY:Math.floor(y/l)}

ctx = atom.ctx


unitTypes =
  wizard: {hp:2, abilities:['Warp', 'Stone'], speed:2, sprites:wiz}
  dragon: {hp:3, abilities:['Attack'], speed:3, sprites:dragon}

class Unit
  constructor: (@x, @y, @type, @owner = 'red') ->
    @type = unitTypes[@type] if typeof @type is 'string'
    @hp = @type.hp
    @tired = true
    @alpha = 1
    @facing = if @owner is 'red' then 'botright' else 'botleft'

  draw: ->
    return @animation.call(@) if @animation
    if @selected then drawAtIsoXY selector, @x, @y
    if @alpha != 1
      ctx.globalAlpha = @alpha
    drawAtIsoXY @type.sprites, @x, @y, "#{@owner}#{@facing}", 0
    ctx.globalAlpha = 1

  z: 0

class Stone
  constructor: (@x, @y, @owner) ->
    @age = 0

  draw: ->
    drawAtIsoXY stoneImg, @x, @y
    ###
    ctx.save()
    ctx.translate origin.x, origin.y
    x = tileW/2*(@x+@y)
    y = tileH/2*(-@x+@y)
    ctx.fillStyle = if @age then 'gray' else @owner
    #ctx.fillRect x, y-20, tileW, 20
    ctx.drawImage stoneImg, x+tileW/2-38, y-20
    ctx.restore()
    ###

  z: 1

units = [
  new Unit 1, 3, 'wizard', 'red'
  new Unit 2, 4, 'wizard', 'red'
  new Unit 2, 1, 'wizard', 'blue'
  new Unit 2, 2, 'wizard', 'blue'

  new Unit 5, 4, 'dragon', 'red'
  new Unit 6, 1, 'dragon', 'blue'
]

warpstones = []

currentDay = 0
currentPlayer = 'red'

selected = null
sel = (u) ->
  selected?.selected = false
  selected = u
  u?.selected = true

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
drawAtIsoXY = (sprite, x, y, animName, frame) ->
  ctx.save()
  ctx.translate origin.x, origin.y
  px = tileW/2*(x+y)
  py = tileH/2*(-x+y)
  
  if animName
    a = sprite[animName]

    tw = sprite.tileWidth
    th = sprite.tileHeight
    tx = tw * (a.x + frame)
    ty = th * a.y

    ctx.drawImage sprite.img, tx, ty, tw, th, px+tileW/2-sprite.anchor.x, py-sprite.anchor.y, tw, th
  else
    ctx.drawImage sprite.img, px+tileW/2-sprite.anchor.x, py-sprite.anchor.y
  
  ctx.restore()

facingDirection = (dx, dy) ->
  if dx is -1
    'botleft'
  else if dx is 1
    'topright'
  else if dy is -1
    'topleft'
  else if dy is 1
    'botright'

class Animation
  constructor: (@duration, @direction) ->
    @t = if @direction is 'forward' then 0 else @duration
    reversing = @direction is 'backward'

  step: (dt) ->
    @t = if @direction is 'forward'
      Math.min(@duration, @t + dt)
    else
      Math.max(0, @t - dt)

  isDone: ->
    (@direction is 'forward' and @t is @duration) or (@direction is 'backward' and @t is 0)


class MoveAnim extends Animation
  constructor: (@unit, @path, direction) ->
    super 0.5 * (@path.length - 1), direction
    anim = @
    @frameTime = 0.1 # Length in seconds of each animation frame
    @unit.animation = ->
      from = anim.path[anim.sectionNum]
      to = anim.path[anim.sectionNum + 1]

      dx = to.x - from.x
      dy = to.y - from.y
      facing = facingDirection dx, dy

      pos = lerp from, to, (anim.section % 1)
      frame = Math.floor(anim.t / anim.frameTime) % 8
      drawAtIsoXY @type.sprites, pos.x, pos.y, "#{unit.owner}walk#{facing}", frame

    @step(0)

  step: (dt) ->
    super(dt)

    @section = @t * (@path.length - 1) / @duration
    @sectionNum = Math.floor(@section)

    if @sectionNum >= @path.length - 1
      @sectionNum = @path.length - 2
      @section = @sectionNum + .9999

    currentPos = @path[@sectionNum]

    # Do correct depth ordering
    @unit.x = currentPos.x
    @unit.y = currentPos.y

    return @isDone()
      
  end: ->
    @unit.animation = null

    if @direction is 'forward' and @path.length >= 2
      from = @path[@path.length - 2]
      to = @path[@path.length - 1]
      dx = to.x - from.x
      dy = to.y - from.y
      @unit.facing = facingDirection dx, dy

    finalPos = if @direction is 'forward' then @path[@path.length - 1] else @path[0]
    @unit.x = finalPos.x
    @unit.y = finalPos.y


class MoveAction
  constructor: (@u, @path) ->
    if @path.length
      {@x, @y} = @path[@path.length - 1]
    else
      {@x, @y} = @u
    @prevX = @u.x
    @prevY = @u.y
  apply: ->
    #@u.x = @x
    #@u.y = @y
    @u.tired = true
    @prevFacing = @u.facing
    currentAnimation = new MoveAnim @u, @path, 'forward' if @path.length
  unapply: ->
    #@u.x = @prevX
    #@u.y = @prevY
    @u.tired = false
    currentAnimation = new MoveAnim @u, @path, 'backward' if @path.length
    @u.facing = @prevFacing

removeUnit = (unit) ->
  units = (u for u in units when u != unit)


class AttackAnim extends Animation
  constructor: (@attacker, @victim, @died, direction, @callback) ->
    duration = if @died then 2 else 1
    super duration, direction
    @frames =      [0,1,2,3,2,3,2,1,0,0,0,0]
    deathframes =  [0,0,0,0,0,0,0,1,2,3,3,3]

    @step(0)

    dx = @victim.x - @attacker.x
    dy = @victim.y - @attacker.y
    facing = facingDirection dx, dy

    anim = this
    @attacker.animation = ->
      console.log @owner, facing
      drawAtIsoXY @type.sprites, @x, @y, "#{@owner}attack#{facing}", anim.frames[anim.frame]
    facing = facingDirection dx, dy
    if @died
      @victim.animation = ->
        console.log @owner, facing
        drawAtIsoXY @type.sprites, @x, @y, "#{@owner}deathbotleft", deathframes[anim.frame]

  step: (dt) ->
    super dt

    @frame = Math.floor(@t * @frames.length / @duration)
    @frame = Math.min @frame, @frames.length - 1
    
    return @isDone()

  end: ->
    @attacker.animation = null
    @victim.animation = null
    @callback?()

class AttackAction
  constructor: (@u, @x, @y) ->
    # u is attacking the tile at x,y
  apply: ->
    # 1. find a live unit at x,y
    target = unitAt @x, @y
    return unless target
    # 2. deal 1 damage to it
    target.hp-- if target.owner != @u.owner
    # 3. set its state to dead if its hp is 0 and if we killed it, store that fact
    @killed = target if target.hp <= 0
    currentAnimation = new AttackAnim @u, target, @killed, 'forward', if @killed then ->
      removeUnit target


  unapply: ->
    # 1. if we killed a unit last time we were simulated, find a dead unit at x,y and revive it
    if @killed
      target = @killed
      units.push target
    else
      target = unitAt @x, @y
      return unless target

    # 2. add 1 hp to unit at x,y
    target.hp++ if target.owner != @u.owner

    currentAnimation = new AttackAnim @u, target, @killed, 'backward'

# Used for both placing stones and warping in units
class PlaceStoneWarpAnimation extends Animation
  # Warpee is optional.
  constructor: (@unit, x, y, direction, @warpee) ->
    super 1, direction

    dx = x - @unit.x
    dy = y - @unit.y
    facing = facingDirection dx, dy
    a = "#{@unit.owner}stone#{facing}"
    anim = this
    @unit.animation = ->
      frame = Math.floor(Math.min(anim.t / anim.duration * @type.sprites[a].num, @type.sprites[a].num))
      drawAtIsoXY @type.sprites, @x, @y, a, frame

    @step(0)

  step: (dt) ->
    super dt
    if @warpee
      @warpee.alpha = @t / @duration
    return @isDone()

  end: ->
    @unit.animation = null
    @warpee?.alpha = 1

class PlaceStone
  constructor: (@unit, @x, @y) ->
    @stone = new Stone x, y, @unit.owner
    @stone.marker = this

    warpstones.push @stone

  apply: ->
    currentAnimation = new PlaceStoneWarpAnimation @unit, @x, @y, 'forward'
    #warpstones.push @stone

  unapply: ->
    currentAnimation = new PlaceStoneWarpAnimation @unit, @x, @y, 'backward'
    #warpstones = (w for w in warpstones when w != @stone)

class WarpIn
  constructor: (@warpee, @summoner) ->

  apply: ->
    units.push @warpee
    @warpee.tired = true
    currentAnimation = new PlaceStoneWarpAnimation @summoner, @warpee.x, @warpee.y, 'forward', @warpee

  unapply: ->
    removeUnit @warpee
    currentAnimation = new PlaceStoneWarpAnimation @summoner, @warpee.x, @warpee.y, 'backward', @warpee

class WarpOutAnimation extends Animation
  constructor: (@warpee, @warper, direction, @callback) ->
    super 1, direction
    @frames = [0,1,2,3,2,3,2,1,0]

    @step(0)

    dx = @warpee.x - @warper.x
    dy = @warpee.y - @warper.y
    facing = facingDirection dx, dy

    anim = this
    @warper.animation = ->
      drawAtIsoXY @type.sprites, @x, @y, "#{anim.warper.owner}warp#{facing}", anim.frames[anim.frame]

  step: (dt) ->
    super dt

    @frame = Math.floor(@t * @frames.length / @duration)
    @frame = @frames.length - 1 if @frame is @frames.length
    
    @warpee.alpha = 1 - @t / @duration

    return @isDone()


  end: ->
    @warper.animation = null
    @warpee.alpha = 1
    @callback?()

class WarpOut
  constructor: (@warpee, @warper) ->

  apply: ->
#    @warper.tired = true
    currentAnimation = new WarpOutAnimation @warpee, @warper, 'forward', ->
      removeUnit @warpee if @direction is 'forward'

  unapply: ->
#    @warper.tired = false
    units.push @warpee
    currentAnimation = new WarpOutAnimation @warpee, @warper, 'backward'

class WaitAction
  constructor: (@u) ->

  apply: ->
    #    @u.tired = true

  unapply: ->
    #    @u.tired = false

class FadeUnitsAnimation extends Animation
  constructor: (@us, direction, @callback) ->
    super 0.4, direction
    @t = if direction is 'forward' then 0 else @duration
    @step(0)
  
  step: (dt) ->
    super dt

    u.alpha = 1 - @t / @duration for u in @us

    return @isDone()

  end: ->
    a = if @direction is 'forward' then 0 else 1
    u.alpha = a for u in @us
    @callback?()

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
   
    currentDay++

    if @activeUnits.length
      currentAnimation = new FadeUnitsAnimation @activeUnits, 'forward', -> units = newUnits
    else
      units = newUnits

  unapply: ->
    currentDay--
    for u in units
      u.tired = true

    units = units.concat @activeUnits
    currentAnimation = new FadeUnitsAnimation @activeUnits, 'backward'

    w.age-- for w in warpstones

# action is {apply:->, unapply:->}
past = []
future = (new EndDay for [1..20])

pendingActions = [] # [{action:a,direction:'forward'}]

endDays = (d for d in future)
endDays.reverse()

#past.push new EndDay

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
  console.log 'fwd'
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
  shadowedTiles = null
  state = 'select'

  for d in [currentDay...20].concat([0...currentDay])
    if unitsToMove[d].length
      goToEvening d
      break
  return


bfs = (map, origin, distance, cull) ->
  dest = {}

  fill = (x, y, path, distance) ->
    return unless map.canEnter x, y

    oldPath = dest["#{x},#{y}"]
    return if oldPath and oldPath.length <= (path.length + 1)

    u = unitAt x, y
    return if u and u.owner isnt origin.owner
    s = stoneAt x, y
    return if s and s.age is 0

    path = path.slice()
    path.push {x, y}
    dest["#{x},#{y}"] = path
    
    return if distance is 0

    fill x-1, y, path, distance - 1
    fill x, y-1, path, distance - 1
    fill x+1, y, path, distance - 1
    fill x, y+1, path, distance - 1

  fill origin.x, origin.y, [], distance

  for k, v of dest
    d = v[v.length - 1]
    u = unitAt d.x, d.y
    if u and u.owner is origin.owner
      delete dest[k]

  dest

#suspendAnimation -> goToEvening 0
#future.push new WarpIn(new Unit 3, 3, 'wizard', 'red')

suspendAnimation -> turnStart()

shadowedTiles = null

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

    reversing = false

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
          if u
            state = 'move'
            shadowedTiles = bfs bg, unit, unit.type.speed

      when 'move'
        if atom.input.pressed 'click'
          # TODO: BFS
          path = shadowedTiles["#{tileX},#{tileY}"]
          w = stoneAt tileX, tileY

          # Empty move. Add a move action anyway to tire the unit.
          path = [] if selected.x is tileX and selected.y is tileY

          if path
            future.push new MoveAction selected, path
            forward()
            state = 'act'
            shadowedTiles = null

        else if atom.input.pressed 'cancel'
          # go back to select and unselect the unit
          state = 'select'
          shadowedTiles = null
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
        else if atom.input.pressed 'wait'
          future.push new WaitAction selected
          currentUnitActed()

        else if atom.input.pressed 'cancel'
          # Unmove.
          suspendAnimation ->
            back()
          future.pop()
          state = 'move'
          shadowedTiles = bfs bg, selected, selected.type.speed
        
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
              if m is 1 and !stoneAt(tileX, tileY)
                future.push new PlaceStone selected, tileX, tileY
                # Animation for the stone!
                currentUnitActed()

            when 'Warp'
              if m is 1 and (warpee = unitAt tileX, tileY)
                state = 'warptarget'

        else if atom.input.pressed 'cancel'
          state = 'act'
          selectedAction = null

      when 'warptarget'
        if atom.input.pressed 'click'
          # s is the warpstone
          # warpee is the unit that got warped
          # selected is the unit that did the warping
          s = stoneAt tileX, tileY
          if s?.owner is currentPlayer
            future.push new WarpOut warpee, selected
            forward()
            removeActiveUnit warpee, currentDay
            removeActiveUnit selected, currentDay

            # Do we need to make the new unit active?
            #active = warpee in unitsToMove[currentDay]

            if s.marker in future
              forward() while future[future.length - 1] != s.marker
              future.pop()
            else
              back() while past[past.length - 1] != s.marker
              past.pop()

            # Remove the marker from the marker list
            warpstones = (w for w in warpstones when w != s)

            # Make the warp clone of the unit
            u = new Unit(s.x, s.y, warpee.type, warpee.owner)
            u.hp = warpee.hp
            future.push new WarpIn u, s.marker.unit
            forward()

            sel null
            state = 'select'

            for d in [currentDay...20].concat([0...currentDay])
              if unitsToMove[d].length
                goToEvening d
                break

        else if atom.input.pressed 'cancel'
          state = 'target'
          warpee = null

        # cancel: go back to act

  draw: ->
    #ctx.fillStyle = 'black'
    #ctx.fillRect 0,0, canvas.width, canvas.height
    ctx.drawImage bg.back, 0, 0
  
    if shadowedTiles
      for k, v of shadowedTiles
        end = v[v.length - 1]
        drawAtIsoXY movementShadow, end.x, end.y


    stuff = warpstones.concat units
    stuff.sort (a,b) -> (a.y - b.y) or (b.x - a.x) or (a.z - b.z)
    s.draw() for s in stuff
 
#    us = (u for u in units).sort (a,b) -> (a.y - b.y) or (b.x - a.x)
#    u.draw() for u in us

    ctx.drawImage bg.fore, 0, 0

    ctx.fillStyle = currentPlayer
    ctx.fillText currentPlayer, 100, 600
    ctx.fillText currentDay, 140, 600

    if reversing
      reversingState = Math.min(reversingState + 0.015, 0.5)
    else
      reversingState = Math.max(reversingState - 0.03, 0)

    if reversingState > 0
      ctx.globalCompositeOperation = 'lighter'
      ctx.fillStyle = "rgba(68, 138, 216, #{reversingState})"
      ctx.fillRect 0,0, canvas.width, canvas.height
      ctx.globalCompositeOperation = 'source-over'


