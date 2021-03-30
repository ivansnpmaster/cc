float maxThickness = 250;
int nPoints = 360;
float t = (TWO_PI / 14.0) / frameRate;

Curve c;

void setup()
{
  size(1200, 1200);
  noFill();

  c = new Curve(PI, height * 0.15, 5, 120);
}

void draw()
{
  translate(width/2, height/2);
  background(0);
  c.show();
}
