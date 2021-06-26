const palletes = [
  ["#fe4a49", "#fed766", "#009fb7", "#0d2c54", "#f2f2f2"],
  ["#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419"],
  ["#212738", "#F97068", "#D1D646", "#EDF2EF", "#57C4E5"]
]

const indexPallete = Math.floor(Math.random() * palletes.length)

let ft, points, bounds

function preload()
{
  ft = loadFont('benne.ttf')
}

function setup()
{
  createCanvas(800, 600)
  background(244)
  noLoop()
}

function draw()
{
  generate()
  genocida()
}

function genocida()
{
  points = ft.textToPoints('genocida', 0, 0, 200, {
    sampleFactor: 0.3,
    simplifyThreshold: 0
  })
  bounds = ft.textBounds('genocida', width / 2, height / 2, 200)
  
  noiseLine(0, height / 2, width, height / 2)
  //line(0, height / 2, width, height / 2)
  
  let a = random(TWO_PI)
  
  for(let p of points)
  {
    p.x = p.x + bounds.x - bounds.w / 2
    p.y = p.y + bounds.y + bounds.h
    
    noiseLine(p.x, p.y, p.x, p.y + abs(sin(a)) * 25)
    
    //circle(p.x, p.y, 15)
    
    a += 0.1
  }
}

function generate()
{
  const s = int(random(100000))
  noiseSeed(s)

  shuffle(palletes[indexPallete], true)
  
  background(palletes[indexPallete][0])
  
  palletes[indexPallete].splice(0, 1)
  
  noFill()

  for (let i = 90; i-- > 0; )
  {
    push()
    
    translate(random(-0.1, 1.1) * width, random(-0.1, 1.1) * height)
    rotate((int(random(8)) * PI) / 4)
    
    stroke(random(palletes[indexPallete]))
    strokeWeight(random(2))

    const maxX = random(width)
    const maxAngle = random(360)

    beginShape()

    let xoff = 0.0
  
    const dir = random(1) < 0.75 ? 1 : -1

    for (let j = 0; j < maxAngle; ++j)
    {
      xoff = xoff + 0.001;
      const n = noise(xoff) * width;
      
      //line(n, 0, n, height + n / width);
      
      const x = map(j, 0, maxAngle - 1, 0, maxX);
      const pos = createVector(x, sin(radians(j * dir + n) + noise(xoff)) * 15)
      
      vertex(pos.x, pos.y)
    }

    endShape()

    pop()
  }
  
  for (let i = 5; i --> 0;)
    noiseLine(random(width), 0, random(width), height)

  for (let i = 100; i-- > 0; )
    noiseCircles(random(-0.2, 1.1) * width, random(-0.2, 1.1) * height)
}

function noiseCircles(x, y)
{
  const c = int(random(50, 150));
  const col = color(random(palletes[indexPallete]))
  col.setAlpha(random(120, 255))
  
  const step = random(2, 20)

  noStroke()
  fill(col)
  
  for (let i = c; i-- > 0; )
  {
    const scl = 0.015
    const nScl = noise(x * scl, y * scl) * 700
    const angle = noise(x * scl, y * scl, i * 0.1) * nScl
    
    circle(x, y, random(random(random(random(50)))))
   
    x += cos(angle) * step
    y += sin(angle) * step
  }
}

function noiseLine(x1, y1, x2, y2, col)
{
  const minAngle = random(100)
  const maxAngle = random(minAngle, 360)  
  const initialPos = createVector(x1, y1)
  const finalPos = createVector(x2, y2)
  const diff = p5.Vector.sub(finalPos, initialPos)
  
  col = col ? col : color(random(palletes[indexPallete]))
  col.setAlpha(random(120, 255))
  
  stroke(col)
  noFill()
  
  beginShape()

  let xoff = 0.0

  for (let j = minAngle; j < maxAngle; ++j)
  {
    const t = map(j, minAngle, maxAngle - 1, 0, 1)

    xoff = xoff + 0.01
    const n = noise(xoff)
    
    const newMag = diff.mag() * t
    const newPos = diff.copy().setMag(newMag).add(initialPos)
    const up = diff.copy().rotate(PI/2).setMag(n * 50)
    
    newPos.add(up)
    
    vertex(newPos.x, newPos.y)
  }

  endShape()
}