class Circle
{
  float n;
  float c;
  float r;
  float speedS;
  float speedA;

  float rS;

  Circle(float nn, float cc, float rr, float speedSize, float speedAngle)
  {
    n = nn;
    c = cc;
    r = rr;
    speedS = speedSize;
    speedA = speedAngle;

    rS = (n + c) % 2 == 0 ? 1 : -1;
  }

  void Show()
  {
    gR = rS * sin(frameCount / this.speedS) * this.r;
    gA = rS * sin(frameCount / this.speedA) * TWO_PI; 

    ellipse(0, 0, this.r * 2, this.r * 2);

    ArrayList<PVector> g = new ArrayList<PVector>();

    for (int i = 0; i < this.n; i++)
    {
      float a = i * TWO_PI / this.n;

      PVector p = new PVector(this.r * cos(a), this.r * sin(a));
      PVector dir = new PVector(-p.x, -p.y).normalize();

      ArrayList<PVector> points = new ArrayList<PVector>();

      noStroke();

      for (int j = 0; j < c; j++)
      {
        PVector dirC = dir.copy();
        PVector pC = p.copy();

        float rc = j * this.r / this.c;
        dirC.setMag(rc);

        PVector pc = pC.add(dirC);

        pc.rotate(-gA);

        points.add(pc.copy());

        float aDiff = j * ((sin(frameCount / this.speedA) + 1) / 2.0 - 0.5) * (TWO_PI / this.n);

        pc.rotate(-aDiff);

        ellipse(pc.x, pc.y, j * this.r * 2 / this.c, j * this.r * 2 / this.c);
      }

      stroke(0);

      PVector b = points.get(0);
      PVector e = points.get(points.size()-1);

      PVector gp = e.copy().sub(b).normalize().setMag(gR).rotate(gA * 2);
      g.add(gp);
    }

    noStroke();
    beginShape();

    for (PVector p : g)
      vertex(p.x, p.y);

    endShape(CLOSE);

    g.clear();
  }
}
