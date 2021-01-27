int xs = 5, ys = 30, anSub = 300;
float xInc, yInc, an, anInc;

void setup()
{
  size(800, 800);
  
  xInc = 1.0 * width / xs;
  yInc = 1.0 * height / ys;
  anInc = TWO_PI / anSub;
  
  rectMode(CENTER);
  stroke(0);
}

void draw()
{
  background(0);
  translate(xInc * 0.5, yInc * 0.5);
  
  for(int i = 0; i < xs; i++)
    for(int j = 0; j < ys; j++)
    {
      float a = i % 2 == 0 ? 0 : HALF_PI;
      
      float x = i * xInc;
      float y = j * yInc;
      float jperiod = map(j, 0, ys - 1, 0, TWO_PI); 
      float iperiod = abs(sin(an + a + jperiod));
      
      float xsin = map(iperiod, 0, 1, 0.2, 1);
      
      float c = map(xsin, 0.2, 1, 40, 200);
      fill(c, xsin * 100);
      
      rect(x, y, xsin * xInc - 6, (yInc - 6) * xsin);
    }
  
  an += anInc;
}
