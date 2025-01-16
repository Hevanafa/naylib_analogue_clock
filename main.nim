import raylib, std/[math, times, strutils]

const
  ww = 200
  wh = 200


initWindow(ww, wh, "Naylib Clock - By Hevanafa (Jan 2025)")

let surface = loadRenderTexture(ww, wh)
setTextureFilter(surface.texture, TextureFilter.Point)

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

while not windowShouldClose():
  beginDrawing()
  # your drawing code here
  clearBackground(Black)
  
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

    drawLine(x1.int32, y1.int32, x2.int32, y2.int32, SkyBlue)

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
    if datetime.weekday == dSun: Red else: SkyBlue)

  # hour hand
  angle = degToRad((h.float32 + (m / 60)) * 30)
  x = cx + sin(angle) * 45
  y = cy + -cos(angle) * 45

  drawLine(cx.int32, cy.int32, x.int32, y.int32, SkyBlue)

  # minute hand
  angle = degToRad((m.float32 + (s / 60)) * 6)
  x = cx + sin(angle) * 70
  y = cy + -cos(angle) * 70

  drawLine(cx.int32, cy.int32, x.int32, y.int32, SkyBlue)

  # second hand
  angle = degToRad((s.float32 + (ms / 1000)) * 6)
  x1 = cx + -sin(angle) * 20
  y1 = cy + cos(angle) * 20
  x2 = cx + sin(angle) * 70
  y2 = cy + -cos(angle) * 70

  drawLine(x1.int32, y1.int32, x2.int32, y2.int32, Red)

  drawCircle(cx.int32, cy.int32, 3, SkyBlue)

  endDrawing()

closeWindow()