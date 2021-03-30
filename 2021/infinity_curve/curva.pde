class Curve
{
  float a;
  float r;
  float l;
  int al;

  Curve(float startingAngle, float radii, int lines, int angleLength)
  {
    a = startingAngle;
    r = radii;
    l = lines;
    al = angleLength;
  }

  void show()
  {
    for (int k = 0; k < l; k++)
    {
      float sw = map(k, 0, l - 1, maxThickness, maxThickness / l);

      strokeWeight(sw);
      stroke(k % 2 == 0 ? 255 : 0, 100);

      for (int i = 0; i < nPoints - 1; i++)
      {
        float a1 = map(i, 0, nPoints-1, a, a + radians(al));
        float x1 = r * X(a1);
        float y1 = r * Y(a1);

        float a2 = map(i + 1, 0, nPoints, a, a + radians(al));
        float x2 = r * X(a2);
        float y2 = r * Y(a2);

        line(x1, y1, x2, y2);
      }
    }
    
    c.a += t;
  }
  
  // https://en.wikipedia.org/wiki/Lemniscate_of_Bernoulli
  // https://math.stackexchange.com/questions/1277790/is-there-a-closed-form-expression-for-the-infinity-symbol
  
  float X(float t)
  {
    return (2 * cos(t)) / (1 + sin(t) * sin(t));
  }
  
  float Y(float t)
  {
    return (2 * sin(t) * cos(t)) / (1 + sin(t) * sin(t));
  }
}
