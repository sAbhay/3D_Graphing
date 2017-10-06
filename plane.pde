class Plane
{
  private GraphPoint input[] = new GraphPoint[3];
  private GraphPoint points[] = new GraphPoint[4];
  private PVector normal;
  private float sum;

  private PShape s;

  Plane(GraphPoint p1, GraphPoint p2, GraphPoint p3)
  {
    input[0] = p1;
    input[1] = p2;
    input[2] = p3;

    normal = getNormal(p1, p2, p3);
    sum = getSum(normal);

    calculateParameters(normal, sum);
  }
  
  Plane(float xm, float ym, float zm, float d)
  {
    for(int i = 0; i < input.length; i++)
    {
     input[i] = null; 
    }
    
    normal = new PVector(xm, ym, zm);
    
    sum = d;
    
    calculateParameters(normal, d);
  }

  private PVector getNormal(GraphPoint p1, GraphPoint p2, GraphPoint p3)
  {
    PVector a = new PVector();
    a = PVector.sub(p2.getIndex(), p1.getIndex());

    PVector b = new PVector();
    b = PVector.sub(p3.getIndex(), p1.getIndex());

    PVector N = a.cross(b);
    
    return N;
  }
  
  private float getSum(PVector n)
  {
    float d = n.x * input[0].getIndex().x + n.y * input[0].getIndex().y + n.z * input[0].getIndex().z;
    
    return d;
  }

  private void calculateParameters(PVector n, float d)
  { 
    float p[] = new float[4];

    p[0] = (d - n.x * (-scale.x/2) - n.z * (-scale.z/2))/n.y; 
    p[1] = (d - n.x * (scale.x/2) - n.z * (-scale.z/2))/n.y; 
    p[2] = (d - n.x * (scale.x/2) - n.z * (scale.z/2))/n.y; 
    p[3] = (d - n.x * (-scale.x/2) - n.z * (scale.z/2))/n.y;

    points[0] = new GraphPoint(-scale.x/2, p[0], -scale.z/2);
    points[1] = new GraphPoint(scale.x/2, p[1], -scale.z/2);
    points[2] = new GraphPoint(scale.x/2, p[2], scale.z/2);
    points[3] = new GraphPoint(-scale.x/2, p[3], scale.z/2);

    s = createShape();
    s.beginShape();

    s.fill(100, 100, 255, 40);
    s.noStroke();

    for(int i = 0; i < points.length; i++)
    {
      s.vertex(points[i].getPos().x, points[i].getPos().y, points[i].getPos().z);
    }

    s.endShape();
  }

  public void display()
  {
    shape(s);

    for (int i = 0; i < input.length; i++)
    {
      if(input[i] != null) input[i].display();
    }

    for (int i = 0; i < points.length; i++)
    {
      points[i].display();
    }
  }
  
  public PVector getNormal() {return normal;}
  public float[] getParameters() {float a[] = {normal.x, normal.y, normal.z, sum}; return a;}
}