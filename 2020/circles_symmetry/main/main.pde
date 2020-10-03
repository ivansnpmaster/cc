// ivansnpmaster - 27/09/2020

float n = 4;
float c = 3;
float r;

float gR = 0;
float gA = 0;

float speedS = 120;
float speedA = 120;

float rows = 4;
float cols = 4;

Circle[] circles = new Circle[ int((rows - 1) * (cols - 1))];

void setup()
{
  size(1200, 1200);
  r = width / (rows + cols) - 5;

  for (int ro = 0; ro < rows-1; ro++)
    for (int co = 0; co < cols-1; co++)
    {
      int i = int(co + ro * (rows - 1));

      float nn = ro + 3;
      float cc = co + 3;
      float rr = r;

      circles[i] = new Circle(nn, cc, rr, speedS, speedA);
    }
}

void draw()
{
  println(frameCount);

  background(240);
  noStroke();
  fill(0, 50);

  for (int ro = 0; ro < rows-1; ro++)
    for (int co = 0; co < cols-1; co++)
    {
      float x = ro * width / cols + width / cols;
      float y = co * height / rows +  height / rows;

      pushMatrix();
      translate(x, y);

      int i = int(co + ro * (rows - 1));
      circles[i].Show();

      popMatrix();
    }

  //if (frameCount == 1133)
  //  noLoop();

  //saveFrame("frames/fr-####.png");
}
