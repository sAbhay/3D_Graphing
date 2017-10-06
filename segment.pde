class Segment
{
  private GraphPoint points[] = new GraphPoint[2];
  
  Segment(GraphPoint p1)
  {
    points[0] = new GraphPoint(0, 0, 0);
    points[1] = p1;
  }
  
  Segment(GraphPoint p1, GraphPoint p2)
  {
    points[0] = p1;
    points[1] = p2;
  }
  
  void display()
  {
    for(int i = 0; i < points.length; i++)
    {
     points[i].display();
    }
    
    stroke(255);
    strokeWeight(2);
    line(points[0].getPos().x, points[0].getPos().y, points[0].getPos().z, points[1].getPos().x, points[1].getPos().y, points[1].getPos().z);
    strokeWeight(1);
  }
}