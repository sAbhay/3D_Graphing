class Line
{
  private GraphPoint points[] = new GraphPoint[2];
  private GraphPoint input[] = new GraphPoint[2];

  private PVector multipliers;

  public Line(float xm, float ym, float zm, float xt, float yt, float zt)
  {
    multipliers = new PVector(xm, ym, zm);

    input[0] = new GraphPoint(xt, yt, zt);
    input[1] = null;

    calculateParameters(xm, xt, ym, yt, zm, zt);
  }

  public Line(GraphPoint p1, GraphPoint p2)
  {
    PVector m = PVector.sub(p2.getIndex(), p1.getIndex());
    PVector i = p1.getIndex();

    multipliers = m;

    input[0] = p1;
    input[1] = p2;

    calculateParameters(m.x, i.x, m.y, i.y, m.z, i.z);
  }

  public Line(GraphPoint p2)
  {
    GraphPoint p1 = new GraphPoint(0, 0, 0);

    PVector m = PVector.sub(p2.getIndex(), p1.getIndex());
    PVector i = p1.getIndex();

    input[0] = p1;
    input[1] = p2;

    calculateParameters(m.x, i.x, m.y, i.y, m.z, i.z);
  }

  public void display()
  {
    stroke(0, 255, 0);
    strokeWeight(1);
    line(points[0].getPos().x, points[0].getPos().y, points[0].getPos().z, points[1].getPos().x, points[1].getPos().y, points[1].getPos().z);
    strokeWeight(1);

    for (int i = 0; i < input.length; i++)
    {
      if (input[i] != null)
      {
        input[i].display();
      }
    }
  }

  private void calculateParameters(float xm, float xt, float ym, float yt, float zm, float zt)
  {
    float t[] = new float[2];

    t[0] = (-scale.x/2)/xm;
    t[1] = (scale.x/2)/xm;

    if (!isBetween(getPoint(t[0]).getIndex().y, -scale.y/2, scale.y/2) || !isBetween(getPoint(t[0]).getIndex().z, -scale.z/2, scale.z/2) || !isBetween(getPoint(t[1]).getIndex().y, -scale.y/2, scale.y/2) || !isBetween(getPoint(t[1]).getIndex().z, -scale.z/2, scale.z/2))
    {
      t[0] = (-scale.y/2)/ym;
      t[1] = (scale.y/2)/ym;
    }

    if (!isBetween(getPoint(t[0]).getIndex().z, -scale.z/2, scale.z/2) || !isBetween(getPoint(t[1]).getIndex().z, -scale.z/2, scale.z/2))
    {
      t[0] = (-scale.z/2)/zm;
      t[1] = (scale.z/2)/zm;
    }

    float pos[] = new float[6];

    pos[0] = xm * t[0] + xt;
    pos[1] = ym * t[0] + yt;
    pos[2] = zm * t[0] + zt;

    pos[3] = xm * t[1] + xt;
    pos[4] = ym * t[1] + yt;
    pos[5] = zm * t[1] + zt;

    points[0] = new GraphPoint(pos[0], pos[1], pos[2]);
    points[1] = new GraphPoint(pos[3], pos[4], pos[5]);
  }

  public void updatePos()
  {
    for (int i = 0; i < points.length; i++)
    {
      points[i].updatePos();
    }

    for (int i = 0; i < input.length; i++)
    {
      if (input[i] != null)
      {
        input[i].updatePos();
      }
    }
  }

  public PVector getMultipliers()
  {
    return multipliers;
  }

  public GraphPoint getInput(int i) {
    return input[i];
  }

  public GraphPoint getPoint(float p) 
  {
    GraphPoint g = new GraphPoint(multipliers.x * p + input[0].getIndex().x, multipliers.y * p + input[0].getIndex().y, multipliers.z * p + input[0].getIndex().z);

    return g;
  }
}