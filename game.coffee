
atom.input.bind atom.button.LEFT, 'click'
atom.input.bind atom.key.W, 'warp'
atom.input.bind atom.key.S, 'warpstone'
atom.input.bind atom.key.A, 'attack'
atom.input.bind atom.key.T, 'wait'
atom.input.bind atom.key.ESC, 'cancel'
atom.input.bind atom.key.LSHIFT, 'accelerate'

atom.input.bind atom.key.E, 'end turn'

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
  back: image 'bg.png'

  fore: image 'bg_cog.png'
  drawFg: ->
    ctx.drawImage @fore, 794, 492


  canEnter: (x, y) ->
    return false if x < 0 or y < 0 or x > 11 or y > 9
    return x <= 1 if y is 0
    return x in [10, 11] if y is 9
    return y <= 3 if x is 0
    true

sliderbar = image 'time_slider_full_bar.png'
unit_stats = image 'unit_stats.png'
player_text = {red: image('player1_text.png'), blue: image('player2_text.png')}
hp_text = image 'HP.png'
hp_num = [image('1.png'), image('1.png'), image('2.png'), image('3.png')]

indicator =
  red: image 'indicator.png'
  blue: image 'indicator2.png'

cloud = image 'cloud.png'
spark =
  img: image 'spark.png'
  tileWidth: 150
  tileHeight: 75

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
  #moody: image 'dragonshheeet muted.png'
  tileWidth: 150
  tileHeight: 150

  redbotleft: {x:0, y:0, num:1}
  redbotright: {x:0, y:1, num:1}
  redtopright: {x:0, y:2, num:1}
  redtopleft: {x:0, y:3, num:1}

  bluebotleft: {x:0, y:4, num:1}
  bluebotright: {x:0, y:5, num:1}
  bluetopright: {x:0, y:6, num:1}
  bluetopleft: {x:0, y:7, num:1}

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

knight =
  img: image 'Knight Texsheet.png'
  # moody: image 'Knight_Texsheetmuted.png'
  tileWidth: 100
  tileHeight: 100

  redbotright: {x:0, y:0, num:1}
  redtopleft: {x:8, y:0, num:1}
  redbotleft: {x:0, y:1, num:1}
  redtopright: {x:8, y:1, num:1}

  bluebotleft: {x:0, y:7, num:1}
  bluebotright: {x:0, y:6, num:1}
  bluetopright: {x:0, y:10, num:1}
  bluetopleft: {x:0, y:11, num:1}

  redwalkbotright: {x:0, y:0, num:8}
  redwalktopleft: {x:8, y:0, num:8}
  redwalkbotleft: {x:0, y:1, num:8}
  redwalktopright: {x:8, y:1, num:8}

  bluewalkbotleft: {x:0, y:7, num:8}
  bluewalkbotright: {x:0, y:6, num:8}
  bluewalktopright: {x:8, y:7, num:8}
  bluewalktopleft: {x:8, y:6, num:8}

  # Attack and idle animations
  redattackbotright: {x:0, y:2, num:13}
  redattackbotleft: {x:0, y:3, num:13}
  redattacktopright: {x:0, y:4, num:13}
  redattacktopleft: {x:0, y:5, num:13}

  blueattackbotright: {x:0, y:8, num:13}
  blueattackbotleft: {x:0, y:9, num:13}
  blueattacktopright: {x:0, y:10, num:13}
  blueattacktopleft: {x:0, y:11, num:13}

  reddeathbotright: {x:14, y:2, num:4}
  reddeathtopleft:  {x:14, y:3, num:4}
  reddeathbotleft:  {x:14, y:4, num:4}
  reddeathtopright: {x:14, y:5, num:4}

  bluedeathbotright: {x:14, y:8, num:4}
  bluedeathbotleft:  {x:14, y:9, num:4}
  bluedeathtopleft:  {x:14, y:10, num:4}
  bluedeathtopright: {x:14, y:11, num:4}

  anchor: {x: 50, y: 91}

glyphs =
  img: image 'glyphs.png'
  anchor: {x:49, y:26}

  red: {x:0,y:0, num:2}
  blue: {x:0,y:1, num:2}

  tileWidth: 99
  tileHeight: 53

selector =
  img: image 'Selector.png'
  anchor: {x:45, y:50}

movementShadow =
  img: image 'Movementshadow.png'
  anchor: {x:83, y:59}

gameoverscreen =
  red: image 'redteamwinscreen.png'
  blue: image 'blueteamwinscreen.png'
  draw: image 'drawscreen.png'

splashscreen = image 'titlescreen.png'

actionSprites =
  Glyph:
    img: image 'selector_glyph.png'
    anchor: {x:100, y:90}
  Warp:
    img: image 'selector_warp.png'
    anchor: {x:40, y:120}
  Wait:
    img: image 'selector_wait.png'
    anchor: {x:-20, y:90}
  Attack:
    img: image 'selector_attack.png'
    anchor: {x:100, y:90}

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
  wizard: {hp:2, abilities:['Warp', 'Glyph'], speed:2, sprites:wiz}
  dragon: {hp:3, abilities:['Attack'], speed:3, sprites:dragon}
  knight: {hp:1, abilities:['Attack'], speed:3, sprites:knight}


reversing = false
reversingState = 0

currentAnimation = null

shadowedTiles = null


units = null
warpstones = []
currentDay = 0
currentPlayer = 'red'
selected = null
state = 'splash'
winner = null
selectedAction = null
warpee = null
past = null
future = null
pendingActions = []
endDays = []
unitsToMove = []

cloudX = 0

reset = ->
  reversing = false
  reversingState = 0

  currentAnimation = null

  shadowedTiles = null

  units = [
    new Unit 0, 1, 'wizard', 'red'
    new Unit 1, 8, 'wizard', 'red'
    new Unit 1, 5, 'dragon', 'red'

    new Unit 1, 2, 'knight', 'red'
    new Unit 2, 8, 'knight', 'red'


    new Unit 9, 1, 'wizard', 'blue'
    new Unit 10, 8, 'wizard', 'blue'
    new Unit 9, 5, 'dragon', 'blue'

    new Unit 9, 2, 'knight', 'blue'
    new Unit 9, 7, 'knight', 'blue'
  ]
  unitsToMove = []

  warpstones = []

  currentDay = 0
  currentPlayer = 'red'

  selected = null

  # states are:
  # - Pick which unit to move 'select'
  # - Pick where to move it   'move'
  # - Pick what action to do  'act'
  # - Pick where to target with your action 'target'
  # - Pick destination warp stone 'warptarget'
  state = 'select'

  winner = null

  # when we're in the 'target' state, this specifies the selected unit action (Warp, Attack, Glyph, etc)
  selectedAction = null
  warpee = null

  # action is {apply:->, unapply:->}
  past = []
  future = (new EndDay for [1..20])

  pendingActions = [] # [{action:a,direction:'forward'}]

  endDays = (d for d in future)
  endDays.reverse()

  suspendAnimation -> turnStart()



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
    drawAtIsoXY @type.sprites, @x, @y, "#{@owner}#{@facing}", 0, @ not in unitsToMove[currentDay]
    ctx.globalAlpha = 1

  z: 0

class Stone
  constructor: (@x, @y, @owner) ->
    @age = 0

  draw: ->
    drawAtIsoXY glyphs, @x, @y, @owner, if @age == 0 then 0 else 1

    {x, y} = isoToScreen {anchor:{x:0,y:0}}, @x, @y
    ctx.save()
    ctx.font = '16px Helvetica'
    ctx.textAlign = 'center'
    ctx.fillStyle = 'green'#@owner
    ctx.shadowOffsetX = 1
    ctx.shadowOffsetY = 1
    ctx.shadowBlur = 5
    ctx.shadowColor = 'black'
    ctx.fillText (currentDay - @age), x - 28, y + 5
    ctx.restore()

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

sel = (u) ->
  selected?.selected = false
  selected = u
  u?.selected = true

unitAt = (x,y) ->
  for unit in units
    if unit.x is x and unit.y is y
      return unit

stoneAt = (x, y) ->
  for w in warpstones
    return w if w.x is x and w.y is y

lerp = (from, to, t) ->
  {x:from.x*(1-t)+to.x*t, y:from.y*(1-t)+to.y*t}

isoToScreen = (sprite, x, y) ->
  px = tileW/2*(x+y)
  py = tileH/2*(-x+y)

  x: px+tileW/2-sprite.anchor.x + origin.x
  y: py-sprite.anchor.y + origin.y
  w: sprite.img?.width
  h: sprite.img?.height

# sprite is {img, anchor}
drawAtIsoXY = (sprite, x, y, animName, frame = 0, moody = false) ->
  ctx.save()
  ctx.translate origin.x, origin.y
  px = tileW/2*(x+y)
  py = tileH/2*(-x+y)
  
  #if moody then ctx.globalCompositeOperation = 'darjer'
  if moody then ctx.globalAlpha *= 0.5
  if animName
    a = sprite[animName]

    tw = sprite.tileWidth
    th = sprite.tileHeight
    tx = tw * (a.x + frame)
    ty = th * a.y

    ctx.drawImage sprite.img, tx, ty, tw, th, px+tileW/2-sprite.anchor.x, py-sprite.anchor.y, tw, th
  else
    ctx.drawImage sprite.img, px+tileW/2-sprite.anchor.x, py-sprite.anchor.y
  
  if moody then ctx.globalAlpha /= 0.5
  #if moody then ctx.globalCompositeOperation = 'source-over'
  ctx.restore()

facingDirection = (dx, dy) ->
  if dx is -1
    'botleft'
  else if dx is 1
    'topright'
  else if dy is -1
    'topleft'
  else #if dy is 1
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
  constructor: (@unit, @path, direction, @callback) ->
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
      drawAtIsoXY @type.sprites, pos.x, pos.y, "#{unit.owner}walk#{facing}", frame, @ not in unitsToMove[currentDay]


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

    @callback?()


class MoveAction
  constructor: (@u, @path) ->
    if @path.length
      {@x, @y} = @path[@path.length - 1]
    else
      {@x, @y} = @u
    @prevX = @u.x
    @prevY = @u.y
  apply: ->
    return unless @u in units
    #@u.x = @x
    #@u.y = @y
    @u.tired = true
    @prevFacing = @u.facing
    if @path.length
      currentAnimation = new MoveAnim @u, @path, 'forward', =>
        @died = false
        for u in units when u != @u and u.x is @u.x and u.y is @u.y
          # Found a unit that we moved to. Kill ourselves. How embarassing.
          @died = true
          # TODO: Add a die animation.
          removeUnit @u
          removeActiveUnit @u
          break

  unapply: ->
    if @died
      # Un-telefrag
      units.push @u

    return unless @u in units
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
    #@frames =      [0,1,2,3,2,3,2,1,0,0,0,0]
    deathframes =  [0,0,0,0,0,0,0,1,2,3,3,3]

    dx = @victim.x - @attacker.x
    dy = @victim.y - @attacker.y
    facing = facingDirection dx, dy

    a = "#{@attacker.owner}attack#{facing}"
    idle = "#{@attacker.owner}#{facing}"
    @numAttackFrames = @attacker.type.sprites[a].num

    @step(0)

    anim = this
    @attacker.animation = ->
      console.log @owner, facing
      if anim.frame < anim.numAttackFrames
        drawAtIsoXY @type.sprites, @x, @y, a, anim.frame, @ not in unitsToMove[currentDay]
      else
        drawAtIsoXY @type.sprites, @x, @y, idle, 0, @ not in unitsToMove[currentDay]

    facing = facingDirection dx, dy
    if @died
      @victim.animation = ->
        console.log @owner, facing
        drawAtIsoXY @type.sprites, @x, @y, "#{@owner}deathbotleft", deathframes[anim.frame], @ not in unitsToMove[currentDay]

  step: (dt) ->
    super dt

    @frame = Math.floor(@t * (@numAttackFrames + 5) / @duration)
    
    return @isDone()

  end: ->
    @attacker.animation = null
    @victim.animation = null
    @callback?()

class AttackAction
  constructor: (@u, @x, @y) ->
    # u is attacking the tile at x,y
  apply: ->
    return if @u not in units
    # 1. find a live unit at x,y
    target = unitAt @x, @y
    return unless target
    # 2. deal 1 damage to it
    return if target.owner == @u.owner

    target.hp--
    # 3. set its state to dead if its hp is 0 and if we killed it, store that fact
    @killed = target if target.hp <= 0
    currentAnimation = new AttackAnim @u, target, @killed, 'forward', =>
      removeUnit target if @killed

  unapply: ->
    # 1. if we killed a unit last time we were simulated, find a dead unit at x,y and revive it
    return if @u not in units

    if @killed
      target = @killed
      throw new Error 'Overlapping units' if unitAt target.x, target.y
      units.push target
    else
      target = unitAt @x, @y
      return unless target

    # 2. add 1 hp to unit at x,y
    return if target.owner == @u.owner

    target.hp++
    currentAnimation = new AttackAnim @u, target, @killed, 'backward'

# Used for both placing stones and warping in units
class PlaceStoneWarpAnimation extends Animation
  # Warpee is optional.
  constructor: (@unit, x, y, direction, @warpee, @callback) ->
    super 1, direction

    dx = x - @unit.x
    dy = y - @unit.y
    facing = facingDirection dx, dy
    a = "#{@unit.owner}stone#{facing}"
    anim = this
    @unit.animation = ->
      frame = Math.floor(Math.min(anim.t / anim.duration * @type.sprites[a].num, @type.sprites[a].num))
      drawAtIsoXY @type.sprites, @x, @y, a, frame, @ not in unitsToMove[currentDay]


    @step(0)

  step: (dt) ->
    super dt
    if @warpee
      @warpee.alpha = @t / @duration
    return @isDone()

  end: ->
    @unit.animation = null
    @warpee?.alpha = 1
    @callback?()

class PlaceStone
  constructor: (@unit, @x, @y) ->
    @stone = new Stone x, y, @unit.owner
    @stone.marker = this

    warpstones.push @stone

  apply: ->
    return unless @unit in units
    currentAnimation = new PlaceStoneWarpAnimation @unit, @x, @y, 'forward'
    #warpstones.push @stone

  unapply: ->
    return unless @unit in units
    currentAnimation = new PlaceStoneWarpAnimation @unit, @x, @y, 'backward'
    #warpstones = (w for w in warpstones when w != @stone)

class WarpIn
  constructor: (@warpee, @summoner) ->

  apply: ->
    throw new Error 'Overlapping units in warpin' if unitAt @warpee.x, @warpee.y
    units.push @warpee
    #@warpee.tired = true
    currentAnimation = new PlaceStoneWarpAnimation @summoner, @warpee.x, @warpee.y, 'forward', @warpee

  unapply: ->
    currentAnimation = new PlaceStoneWarpAnimation @summoner, @warpee.x, @warpee.y, 'backward', @warpee, ->
      removeUnit @warpee

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
      drawAtIsoXY @type.sprites, @x, @y, "#{anim.warper.owner}warp#{facing}", anim.frames[anim.frame], @ not in unitsToMove[currentDay]


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
   
    if @warpee in units
      @acted = true

      currentAnimation = new WarpOutAnimation @warpee, @warper, 'forward', =>
        removeUnit @warpee
    else
      @acted = false

  unapply: ->
    if @acted
      throw new Error 'Overlapping units in warpout' if unitAt @warpee.x, @warpee.y
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

#past.push new EndDay

perform = ({action, direction}) ->
  throw 'shouldnt be any current anim' if currentAnimation
  if direction is 'forward'
    action.apply()
  else
    action.unapply()
  action

skipAnimations = ->
  currentAnimation?.end?()
  currentAnimation = null

  for a in pendingActions
    perform a
    currentAnimation?.end?()
    currentAnimation = null
  pendingActions = []

suspendAnimation = (f) ->
  throw 'shouldnt be any current anim' if currentAnimation
  f()
  skipAnimations()

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

turnStart = ->
  unitsToMove = getActiveUnits currentPlayer

  finalDay = endDays[10].activeUnits
  if finalDay.length > 0 and currentPlayer is 'red'
    # Whoever has units here wins.
    redUnits = (u for u in finalDay when u.owner is 'red')
    blueUnits = (u for u in finalDay when u.owner is 'blue')
    state = 'gameover'
    winner = if redUnits.length and blueUnits.length
      'draw'
    else if redUnits.length
      'red'
    else
      'blue'

  for d, i in unitsToMove
    if d.length
      return goToEvening i

  # Game over!!!!!!
  state = 'gameover'
  winner = if currentPlayer is 'red' then 'blue' else 'red'

  maybeEndTurn()

maybeEndTurn = ->
  for d, i in unitsToMove
    if d.length
      return false

  # End the turn
  currentPlayer = if currentPlayer is 'red' then 'blue' else 'red'
  turnStart()

removeActiveUnit = (unit, d) ->
  if d?
    unitsToMove[d] = (u for u in unitsToMove[d] when u != unit)
  else
    removeActiveUnit(unit, d) for d in [0..19]

todoIdle = []
nextIdle = (f) -> todoIdle.push f
doIdle = -> f() while f = todoIdle.shift()

currentUnitActed = ->
  forward()
  do (selected, currentDay) ->
    nextIdle ->
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

manhattan = (a,b) -> Math.abs(a.x-b.x) + Math.abs(a.y-b.y)

hoveredUnit = null

sparkFrame = 10
sparkX = 0

atom.run
  update: (dt) ->
    if state in ['splash', 'gameover']
      reset() if atom.input.pressed 'click'
      return

    {tileX, tileY} = screenToMap atom.input.mouse.x, atom.input.mouse.y
    u = unitAt tileX, tileY
    hoveredUnit = u

    if currentAnimation
      shadowedTiles = null
      if atom.input.pressed 'cancel'
        skipAnimations()
      else
        speed = if atom.input.down 'accelerate' then 8 else 1
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

    doIdle()

    reversing = false

    maybeEndTurn()

    if state is 'select'
      if atom.input.pressed 'back'
        goToEvening Math.max(currentDay - 1, 0)
        return
      if atom.input.pressed 'fwd'
        goToEvening Math.min(currentDay + 1, 19)
        return


    # Timeline.
    if atom.input.pressed 'click'
      {tileX, tileY} = screenToMap atom.input.mouse.x, atom.input.mouse.y
      d = 300/9
      if state in ['select', 'move'] and atom.input.mouse.y < 45+41 and 493-d/2 < atom.input.mouse.x < 493+300+d/2
        if state is 'move'
          # Cancel out of the move before letting the user wiggy through time
          sel null
          shadowedTiles = null
          state = 'select'

        day = Math.floor((atom.input.mouse.x - 493 + d/2) / d) + 1
        day = Math.min(10,Math.max(1,day))
        #console.log day
        goToEvening day
        skipAnimations()
        return
    else
      tileX = tileY = null

    # End turn. Mostly useful for debugging.
    if state in ['select', 'move'] and atom.input.pressed 'end turn'
      if state is 'move'
        # Cancel out of the move before letting the user wiggy through time
        sel null
        shadowedTiles = null
        state = 'select'

      oldDay = currentDay

      for us, d in unitsToMove
        if us.length > 0
          goToEvening d
          skipAnimations()
          for u in us
            future.push new MoveAction u, []
            forward()
            future.push new WaitAction u
            forward()
            skipAnimations()
        us.length = 0

      goToEvening oldDay
      skipAnimations()

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
          # Select a different unit instead.
          if (u = unitAt tileX, tileY) and u isnt selected and u.owner is currentPlayer
            sel u
            shadowedTiles = bfs bg, u, u.type.speed
          else
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
        if atom.input.pressed 'click'
          action = null
          for a in selected.type.abilities.concat(['Wait'])
            if actionSprites[a]
              {x, y, w, h} = isoToScreen actionSprites[a], selected.x, selected.y
              #console.log x, y, w, h, atom.input.mouse.x, atom.input.mouse.y
              if x <= atom.input.mouse.x <= x+w and y <= atom.input.mouse.y <= y+h
                action = a
                break
          switch action
            when 'Attack'
              state = 'target'
              selectedAction = 'Attack'
            when 'Warp'
              state = 'target'
              selectedAction = 'Warp'
            when 'Glyph'
              state = 'target'
              selectedAction = 'Glyph'
            when 'Wait'
              future.push new WaitAction selected
              currentUnitActed()
          if state == 'target'
            shadowedTiles = {}
            switch selectedAction
              when 'Warp'
                shadowedTiles[[u.x,u.y]] = [u] for u in units when manhattan(u,selected) <= 1
              when 'Attack'
                {x:sx, y:sy} = selected
                adj = [[sx+1,sy],[sx-1,sy],[sx,sy+1],[sx,sy-1]]
                shadowedTiles[u] = [{x:u[0],y:u[1]}] for u in adj when bg.canEnter u[0],u[1]
              when 'Glyph'
                console.log 'glyph'
                {x:sx, y:sy} = selected
                adj = [[sx+1,sy],[sx-1,sy],[sx,sy+1],[sx,sy-1]]
                for u in adj when bg.canEnter(u[0],u[1]) and !unitAt(u[0],u[1])? and !stoneAt(u[0], u[1])?
                  shadowedTiles[u] = [{x:u[0],y:u[1]}]

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

            when 'Glyph'
              if m is 1 and !stoneAt(tileX, tileY)
                future.push new PlaceStone selected, tileX, tileY
                # Animation for the stone!
                currentUnitActed()

            when 'Warp'
              if m <= 1 and (warpee = unitAt tileX, tileY)
                # Next the user needs to select a target for their warp.
                state = 'warptarget'

                # Set shadowed tiles to be warp targets.
                shadowedTiles = {}
                for s in warpstones when s.owner is currentPlayer
                  shadowedTiles[[s.x, s.y]] = [s]
                

        else if atom.input.pressed 'cancel'
          state = 'act'
          shadowedTiles = null
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
            removeActiveUnit warpee

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
            u.tired = false
            future.push new WarpIn u, s.marker.unit

            currentUnitActed()

        else if atom.input.pressed 'cancel'
          state = 'act'
          warpee = null
          shadowedTiles = null

        # cancel: go back to act

  draw: ->
    if state is 'splash'
      ctx.drawImage splashscreen, 0, 0
      return
    if state is 'gameover'
      ctx.drawImage gameoverscreen[winner], 0, 0
      return

    #ctx.fillStyle = 'black'
    #ctx.fillRect 0,0, canvas.width, canvas.height
    ctx.drawImage bg.back, 0, 0
  
    if shadowedTiles
      for k, v of shadowedTiles
        end = v[v.length - 1]
        drawAtIsoXY movementShadow, end.x, end.y

    warpstones.sort (a,b) -> (a.y - b.y) or (b.x - a.x) or (a.z - b.z)
    s.draw() for s in warpstones

    stuff = units.slice()
    stuff.sort (a,b) -> (a.y - b.y) or (b.x - a.x) or (a.z - b.z)
    s.draw() for s in stuff
 
#    us = (u for u in units).sort (a,b) -> (a.y - b.y) or (b.x - a.x)
#    u.draw() for u in us
    
    bg.drawFg?()

    time_passed_px = ((currentDay - 1) / 9) * sliderbar.width
    ctx.drawImage sliderbar, 0, 0, time_passed_px, sliderbar.height, 493, 45, time_passed_px, sliderbar.height
    for d, i in unitsToMove when d.length > 0
      ctx.drawImage indicator[currentPlayer], 490 + (i-1) * sliderbar.width/9, 54

#    ctx.fillStyle = currentPlayer
#    ctx.fillText currentPlayer, 100, 600
#    ctx.fillText currentDay, 140, 600

    if state is 'act' and pendingActions.length is 0 and !currentAnimation
      for a in selected.type.abilities.concat(['Wait'])
        if a is 'Warp'
          hasStones = false
          hasStones = true for s in warpstones when s.owner is currentPlayer
          continue unless hasStones

        if actionSprites[a] then drawAtIsoXY actionSprites[a], selected.x, selected.y

    if hoveredUnit
      ctx.drawImage unit_stats, 0, 0
      ctx.drawImage player_text[hoveredUnit.owner], 0, 30
      ctx.drawImage hp_text, 155, 60
      ctx.drawImage hp_num[hoveredUnit.hp], 240, 60

    tile_x = Math.floor(sparkFrame) % 3
    tile_y = Math.floor sparkFrame / 3
    sparkFrame += 0.25 * (if reversing then -reversingState else 1)
    if sparkFrame > 150+Math.floor(Math.random()*100)
      sparkFrame = 0
      sparkX = if Math.random() < 0.5 then 1000 else 20
    if sparkFrame < 6
      ctx.drawImage spark.img, tile_x * spark.tileWidth, tile_y * spark.tileHeight, spark.tileWidth, spark.tileHeight, sparkX, canvas.height - spark.tileHeight - 40, spark.tileWidth, spark.tileHeight

    cloudSpeed = 1
    cloudX += cloudSpeed * (if reversing then -reversingState else 1)
    ctx.globalAlpha = 0.4
    ctx.drawImage cloud, cloudX % canvas.width, canvas.height - cloud.height
    ctx.drawImage cloud, (cloudX % canvas.width) - cloud.width, canvas.height - cloud.height
    ctx.globalAlpha = 1

    if reversing
      reversingState = Math.min(reversingState + 0.03, 1)
    else
      reversingState = Math.max(reversingState - 0.06, 0)

    if reversingState > 0.01
      ctx.globalCompositeOperation = 'lighter'
      ctx.fillStyle = "rgba(68, 138, 216, #{reversingState * 0.5})"
      ctx.fillRect 0,0, canvas.width, canvas.height
      ctx.globalCompositeOperation = 'source-over'


