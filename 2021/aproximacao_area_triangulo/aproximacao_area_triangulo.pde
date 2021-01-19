float l = 300;
float h = 300;
float d = 1;

void setup()
{
  size(450, 450);
  l = width * 0.65;
  h = height * 0.65;

  rectMode(CORNERS);
}

void draw()
{
  background(0);
  stroke(255);

  translate(width * 0.5, height * 0.4);

  PVector a = new PVector(-l/2, l/2);
  PVector b = new PVector(l/2, l/2);
  PVector c = new PVector(0, l/2-h);
  
  fill(255, 20);
  
  beginShape();
  
  vertex(a.x, a.y);
  vertex(b.x, b.y);
  vertex(c.x, c.y);
  
  endShape(CLOSE);

  float newH = h / d;
  float rA = 0;

  float tA = l * h / 2;

  for (float i = 0; i < d; i++)
  {
    rA += PVector.sub(b, a).mag() * newH;
    
    DrawRect(a, b.copy(), newH);

    float m = PVector.sub(c, a).mag() / (d - i);

    a = PVector.sub(c, a).setMag(m).add(a);
    b = PVector.sub(c, b).setMag(m).add(b);
  }
  
  fill(255);
  
  text("   Triângulo: " + tA + " ua", 0 - l/2, height / 2 - 45);
  text("Retângulos: " + rA + " ua", 0 - l/2, height / 2 -30);
  text("                n: " + round(d), 0 - l/2, height / 2 -15);
  text("   Diferença: " + (rA - tA) + " ua", 0 - l/2, height / 2);
}

void DrawRect(PVector a, PVector b, float hei)
{
  b.y -= hei;
  rect(a.x, a.y, b.x, b.y);
}

void mousePressed()
{
  d++;
}
