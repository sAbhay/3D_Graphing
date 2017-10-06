import queasycam.*;

QueasyCam cam;

PVector dimensions = new PVector(1000, 1000, 1000);
PVector scale = new PVector(20, 20, 20); // initial amount sets number of increments
PVector numPixels = new PVector();

//PVector marks[][] = new PVector[3][20];

ArrayList<GraphPoint> p = new ArrayList<GraphPoint>();
ArrayList<GraphPoint> axes = new ArrayList<GraphPoint>();

ArrayList<Line> l = new ArrayList<Line>();
ArrayList<Line> gl = new ArrayList<Line>();

ArrayList<Plane> pl = new ArrayList<Plane>();

boolean xPressed, yPressed, zPressed, upPressed, downPressed;

boolean scaleIncrease[] = {false, false, false, false};
boolean scaleDecrease[] = {false, false, false, false};

void setup()
{
  fullScreen(P3D);

  cam = new QueasyCam(this, 1, 1.5 * dist(dimensions.x, dimensions.y, dimensions.z, 0, 0, 0));

  changeScale();

  //p.add(new GraphPoint(1, 0, 4, "A"));
  //p.add(new GraphPoint(2, 3, -1, "B"));
  //p.add(new GraphPoint(0, 1, -2, "C"));
  
  //l.add(new Line(1, 3, -5, 1, 0, 4));
  //l.add(new Line(3, 1, -2, 1, -2, 1));
  
  l.add(new Line(2, 1, -1, 3, 0, 1));
  
  //pl.add(new Plane(p.get(0), p.get(1), p.get(2)));
  pl.add(new Plane(1, 1, 0, 12));
  
  p.add(new GraphPoint(9, 3, -2));
  
  println(getAngle(l.get(0), pl.get(0)));
}

void draw()
{
  //checkBoundaries();
  updateScale();

  background(0);
  noFill();
  stroke(255);
  box(dimensions.x, dimensions.y, dimensions.z);

  fill(255, 0, 0);
  noStroke();

  for (int i = 0; i < axes.size(); i++)
  {
    axes.get(i).display();
  }
  
  //for (int i = 0; i < gl.size(); i++)
  //{
  //  gl.get(i).display();
  //}

  for (int i = 0; i < p.size(); i++)
  {
    p.get(i).display();
  }

  for (int i = 0; i < l.size(); i++)
  {
    l.get(i).display();
  }
  
  for (int i = 0; i < pl.size(); i++)
  {
    pl.get(i).display();
  }

  //closeSpace();
  
  //pushMatrix();
  
  //translate(1 * numPixels.x, -2 * numPixels.y, 4 * numPixels.z);
  //stroke(255, 0);
  //fill(255, 10);
  //sphere(sqrt(29) * (numPixels.x + numPixels.y + numPixels.z)/3);
  
  //popMatrix();
}

void keyPressed()
{
  if (key == 'x') scaleIncrease[0] = true;
  if (key == 'y') scaleIncrease[1] = true;
  if (key == 'z') scaleIncrease[2] = true;
  if(key == CODED) if (keyCode == UP) scaleIncrease[3] = true;

  if (key == 'X') scaleDecrease[0] = true;
  if (key == 'Y') scaleDecrease[1] = true;
  if (key == 'Z') scaleDecrease[2] = true;
  if(key == CODED) if (keyCode == DOWN) scaleDecrease[3] = true;
}

void keyReleased()
{
  if (key == 'x') scaleIncrease[0] = false;
  if (key == 'y') scaleIncrease[1] = false;
  if (key == 'z') scaleIncrease[2] = false;
  if(key == CODED) if (keyCode == UP) scaleIncrease[3] = false;

  if (key == 'X') scaleDecrease[0] = false;
  if (key == 'Y') scaleDecrease[1] = false;
  if (key == 'Z') scaleDecrease[2] = false;
  if(key == CODED) if (keyCode == DOWN) scaleDecrease[3] = false;
}

void updateScale()
{
  if (scaleIncrease[0]) scale.x++;
  else if (scaleIncrease[1]) scale.y++;
  else if (scaleIncrease[2]) scale.z++;
  else if (scaleIncrease[3]) {scale.x++; scale.y++; scale.z++;}
  
  else if (scaleDecrease[0] && scale.x > 2) scale.x--;
  else if (scaleDecrease[1] && scale.y > 2) scale.y--;
  else if (scaleDecrease[2] && scale.z > 2) scale.z--;
  else if (scaleIncrease[3] && scale.x > 2 && scale.y > 2 && scale.z > 2) {scale.x--; scale.y--; scale.z--;}
  
  if(scaleIncrease[0] || scaleIncrease[1]  || scaleIncrease[2] || scaleIncrease[3] || scaleDecrease[0] || scaleDecrease[1]  || scaleDecrease[2] || scaleDecrease[3])
  {
     changeScale(); 
  }
}

void closeSpace()
{
  pushMatrix();
  translate(-dimensions.x/2 + 1, 0, 0);
  fill(0);
  noStroke();
  box(2, dimensions.y-1, dimensions.z-1);
  popMatrix();

  pushMatrix();
  translate(dimensions.x/2 - 1, 0, 0);
  fill(0);
  noStroke();
  box(2, dimensions.y-1, dimensions.z-1);
  popMatrix();

  pushMatrix();
  translate(0, dimensions.y/2 - 1, 0);
  fill(0);
  noStroke();
  box(dimensions.x-1, 2, dimensions.z-1);
  popMatrix();

  pushMatrix();
  translate(0, -dimensions.y/2 + 1, 0);
  fill(0);
  noStroke();
  box(dimensions.x-1, 2, dimensions.z-1);
  popMatrix();

  pushMatrix();
  translate(0, 0, dimensions.z/2 - 1);
  fill(0);
  noStroke();
  box(dimensions.x-1, dimensions.y-1, 2);
  popMatrix();

  pushMatrix();
  translate(0, 0, -dimensions.z/2 + 1);
  fill(0);
  noStroke();
  box(dimensions.x-1, dimensions.y-1, 2);
  popMatrix();
}

void checkBoundaries()
{
  if (cam.position.x <= -dimensions.x/2 + 5) cam.position.x = -dimensions.x/2 + 5;
  if (cam.position.x >= dimensions.x/2 - 5) cam.position.x = dimensions.x/2 - 5;

  if (cam.position.y <= -dimensions.y/2 + 5) cam.position.y = -dimensions.y/2 + 5;
  if (cam.position.y >= dimensions.y/2 - 5) cam.position.y = dimensions.y/2 - 5;

  if (cam.position.z <= -dimensions.z/2 + 5) cam.position.z = -dimensions.z/2 + 5;
  if (cam.position.z >= dimensions.z/2 - 5) cam.position.z = dimensions.z/2 - 5;
}

void changeScale()
{ 
  axes.clear();
  
  numPixels.x = dimensions.x/scale.x;
  numPixels.y = dimensions.y/scale.y;
  numPixels.z = dimensions.z/scale.z;
  
  for (int i = 0; i < scale.x+1; i++)
  {
    //marks[0][i] = new PVector(-dimensions.x/2 + numPixels.x * i, 0, 0);
    axes.add(new GraphPoint(i-scale.x/2, 0, 0));
  }

  for (int i = 0; i < scale.y+1; i++)
  {
    //marks[1][i] = new PVector(0, -dimensions.y/2 + numPixels.y * i, 0);
    axes.add(new GraphPoint(0, i-scale.y/2, 0));
  }

  for (int i = 0; i < scale.z+1; i++)
  {
    //marks[2][i] = new PVector(0, 0, -dimensions.z/2 + numPixels.z * i);
    axes.add(new GraphPoint(0, 0, i-scale.z/2));
  }
  
  for(int i = 0; i <= scale.y; i++)
  {
    for(int j = 0; j <= scale.x; j++)
    {
      gl.add(new Line(0, 0, 1, j-scale.x/2, i-scale.y/2, 0));
    }
    
    for(int k = 0; k <= scale.x; k++)
    {
      gl.add(new Line(1, 0, 0, 0, i-scale.y/2, k-scale.z/2));
    }
  }
  
  for(int i = 0; i <= scale.x; i++)
  {
    for(int j = 0; j <= scale.z; j++)
    {
      gl.add(new Line(0, 1, 0, i-scale.y/2, j-scale.z/2, 0));
    }
  }
  
  for(GraphPoint point : p)
  {
     point.updatePos(); 
  }
  
  for(Line line : l)
  {
     line.updatePos(); 
  }
}

float getAngle(Line l0, Line l1)
{
  PVector m[] = {l0.getMultipliers(), l1.getMultipliers()};
  float l[] = new float[2];
  
  for(int i = 0; i < m.length; i++)
  {
    l[i] = sqrt(sq(m[i].x) + sq(m[i].y) + sq(m[i].z));
  }
  
  float angle = degrees(acos((m[0].x * m[1].x + m[0].y * m[1].y + m[0].z * m[1].z)/(l[0] * l[1])));
  
  return angle;
}

float getDist(GraphPoint a, GraphPoint b)
{
  float d = sqrt(sq(a.getIndex().x - b.getIndex().x) + sq(a.getIndex().y - b.getIndex().y) + sq(a.getIndex().z - b.getIndex().z));
  
  return d;
}

float getAngle(Line l0, Plane pl0)
{
  PVector m[] = {l0.getMultipliers(), pl0.getNormal()};
  float l[] = new float[2];
  
  for(int i = 0; i < m.length; i++)
  {
    l[i] = sqrt(sq(m[i].x) + sq(m[i].y) + sq(m[i].z));
  }
  
  float angle = degrees(acos((m[0].x * m[1].x + m[0].y * m[1].y + m[0].z * m[1].z)/(l[0] * l[1])));
  
  return 90 - angle;
}

public static boolean isBetween(float value, float min, float max)
{
  return((value > min) && (value < max));
}