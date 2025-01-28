import raylib, std/[math, times, strutils]

const
  ww = 200
  wh = 200
  scale = 2

let
  windowWidth: int32 = ww * scale
  windowHeight: int32 = wh * scale

initWindow(windowWidth, windowHeight, "Naylib Clock - By Hevanafa (Jan 2025)")

let palette = [
  Color(r: 0x43, g: 0x52, b: 0x3d, a: 0xff),
  Color(r: 0xc7, g: 0xf0, b: 0xd8, a: 0xff)
]

setTargetFPS(20)

let
  cx = ww / 2'f32
  cy = wh / 2'f32

var
  angle: float32 = 0
  x = 0'f32
  y = 0'f32
  x1 = 0'f32
  y1 = 0'f32
  x2 = 0'f32
  y2 = 0'f32
  

var
  datetime: DateTime = now()
  h = datetime.hour
  m = datetime.minute
  s = datetime.second
  ms = 0
  weekday = ""
  w = 0

let buffer = loadRenderTexture(ww, wh)
setTextureFilter(buffer.texture, TextureFilter.Point)

while not windowShouldClose():
  beginTextureMode(buffer)
  clearBackground(palette[0])
  
  # drawLine(0, 0, ww, wh, Black)
  # drawText(fmt"{h}", 0, 0, 12, Black)

  # draw the 12 hour marks
  # it's not possible to annotate the type of a
  for a in 1..12:
    angle = degToRad(a.float32 * 30'f32)
    x1 = cx + sin(angle) * 80
    y1 = cy + cos(angle) * 80
    x2 = cx + sin(angle) * 85
    y2 = cy + cos(angle) * 85

    drawLine(x1.int32, y1.int32, x2.int32, y2.int32, palette[1])

  # draw the current time
  datetime = now()
  h = datetime.hour
  m = datetime.minute
  s = datetime.second
  ms = parseInt(datetime.format("fff"))

  weekday = datetime.format("ddd")
  w = measureText(weekday, 12)
  
  drawText(
    weekday,
    (cx - w / 2).int32, (wh * 2 / 3).int32, 12,
    # if datetime.weekday == dSun: Red else: SkyBlue)
    palette[1])

  # hour hand
  angle = degToRad((h.float32 + (m / 60)) * 30)
  x = cx + sin(angle) * 45
  y = cy + -cos(angle) * 45

  drawLine(cx.int32, cy.int32, x.int32, y.int32, palette[1])

  # minute hand
  angle = degToRad((m.float32 + (s / 60)) * 6)
  x = cx + sin(angle) * 70
  y = cy + -cos(angle) * 70

  drawLine(cx.int32, cy.int32, x.int32, y.int32, palette[1])

  # second hand
  angle = degToRad((s.float32 + (ms / 1000)) * 6)
  x1 = cx + -sin(angle) * 20
  y1 = cy + cos(angle) * 20
  x2 = cx + sin(angle) * 70
  y2 = cy + -cos(angle) * 70

  drawLine(x1.int32, y1.int32, x2.int32, y2.int32, palette[1])

  drawCircle(cx.int32, cy.int32, 3, palette[1])

  endTextureMode()


  beginDrawing()
  clearBackground(Black)
  # DrawTexturePro is overloaded with DrawTexture
  drawTexture(
    buffer.texture,
    Rectangle(x: 0, y: 0, width: ww.float32, height: -wh.float32),
    Rectangle(x: 0, y: 0, width: windowWidth.float32, height: windowHeight.float32),
    Vector2(x: 0, y: 0), 0, White)
  endDrawing()

closeWindow()
