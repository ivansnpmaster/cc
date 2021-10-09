import peasy.*;

PeasyCam cam;
PImage img;
float[][] h;

void setup()
{
  size(600, 600, P3D);

  img = loadImage("double narcissus.jpg");
  img.resize(256, 256);
  h = new float [img.width][img.height];

  for (int i = 0; i < img.width; i++)
    for (int j = 0; j < img.height; j++)
    {
      int index = i + j * img.width;
      float r = red(img.pixels[index]);
      float g = green(img.pixels[index]);
      float b = blue(img.pixels[index]);

      h[i][j] = map((r + g + b) / 3.0, 0, 255, 0, 100);
    }

  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  
  frameRate(15);
}

void draw()
{
  background(255);
  strokeWeight(6);

  for (int i = 0; i < img.width - 1; i++)
    for (int j = 0; j < img.height - 1; j++)
    {
      stroke(img.pixels[i + j * img.width]);
      line(i, h[i][j], j, i + 1, h[i + 1][j], j);
    }
}

void keyPressed()
{
  if (key == 's')
  { 
    saveFrame("Double Narcissus " + floor(random(10000)) + ".jpg");
    print("Saved!");
  }
}