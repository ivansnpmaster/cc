ArrayList<PVector> pontos = new ArrayList<PVector>();
ArrayList<PVector> novos = new ArrayList<PVector>();
int t = 1;

void setup()
{
  size(800, 800);
  background(240);
  noFill();
  strokeWeight(1);
  smooth();

  for (int i = 0; i < width; i++)
  {
    float prob = random(1);
    
    if (prob < 0.04)
    {
      float y = random(height / 2 - 100, height / 2 + 100);
      pontos.add(new PVector(i, y));
    }
  }

  stroke(100);

  beginShape();

  for (PVector p : pontos)
    vertex(p.x, p.y);
  
  endShape();

  stroke(0);

  novos.add(pontos.get(0));

  ArrayList<PVector> novos2 = chaikin(pontos);

  for (int i = 0; i < 3; i++)
    novos2 = chaikin(novos2);

  for (PVector p : novos2)
    novos.add(p);

  novos.add(pontos.get(pontos.size()-1));
}

void draw()
{
  background(240);
  stroke(100);

  beginShape();

  for (PVector p : pontos)
    vertex(p.x, p.y);

  endShape();

  stroke(0);

  for (int j = 0; j < height; j+=20)
  {
    beginShape();
    for (int i = 0; i < t; i++)
    {
      PVector p = novos.get(i);
      vertex(p.x, p.y + j - height / 2 - 100 );
    }
    endShape();
  }

  t++;

  if (t > novos.size() - 1)
    t = 0;
}

ArrayList<PVector> chaikin(ArrayList<PVector> p)
{
  ArrayList<PVector> novos = new ArrayList<PVector>();

  for (int i = 0, t = p.size() - 1; i < t; i++)
  {
    PVector p1 = p.get(i).copy().mult(0.75).add(p.get(i + 1).copy().mult(0.25));
    PVector p2 = p.get(i + 1).copy().mult(0.75).add(p.get(i).copy().mult(0.25));

    novos.add(p1);
    novos.add(p2);
  }

  return novos;
}

ArrayList<PVector> getPoints(PVector a, PVector b)
{
  ArrayList<PVector> p = new ArrayList<PVector>();

  PVector p1 = a.mult(0.75).add(b.mult(0.25));
  PVector p2 = a.mult(0.75).add(b.mult(0.25));

  p.add(p1);
  p.add(p2);

  return p;
}
