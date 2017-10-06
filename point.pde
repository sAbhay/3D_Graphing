class GraphPoint
{
  private PVector index = new PVector();
  private PVector pos = new PVector();
  
  float size;
  
  private boolean labelled;
  private String label;
  
  public GraphPoint(float x, float y, float z)
  {
    index = new PVector(x, y, z);
    
    pos.x = index.x * numPixels.x;
    pos.y = -index.y * numPixels.y;
    pos.z = index.z * numPixels.z;
    
    //if(scale.x >= scale.y && scale.x >= scale.z) size = (75000/(scale.x * scale.y * scale.z)) * numPixels.x/70;
    //else if(scale.y >= scale.x && scale.y >= scale.z) size = (75000/(scale.x * scale.y * scale.z)) * numPixels.y/70;
    //else if(scale.z >= scale.x && scale.z >= scale.y) size = (75000/(scale.x * scale.y * scale.z)) * numPixels.z/70;
    
    size = 0.0011 * (dimensions.x + dimensions.y + dimensions.z)/3;
    
    labelled = false;
    label = "";
  }
  
  public GraphPoint(float x, float y, float z, String l)
  {
    index = new PVector(x, y, z);
    
    pos.x = index.x * numPixels.x;
    pos.y = -index.y * numPixels.y;
    pos.z = index.z * numPixels.z;
    
    //if(scale.x >= scale.y && scale.x >= scale.z) size = (75000/(scale.x * scale.y * scale.z)) * numPixels.x/70;
    //else if(scale.y >= scale.x && scale.y >= scale.z) size = (75000/(scale.x * scale.y * scale.z)) * numPixels.y/70;
    //else if(scale.z >= scale.x && scale.z >= scale.y) size = (75000/(scale.x * scale.y * scale.z)) * numPixels.z/70;
    
    size = 0.0011 * (dimensions.x + dimensions.y + dimensions.z)/3;
    
    labelled = true;
    label = l;
  }
  
  public void display()
  {
   pushMatrix();
   
   translate(pos.x, pos.y, pos.z);
   
   fill(255, 0, 0);
   noStroke();
   
   sphere(size);
   
   if(labelled)
   {
     text(label, 0, -20*size, 0); 
   }
   
   popMatrix();
  }
  
  public PVector getPos() {return pos;}
  public PVector getIndex() {return index;}
  public void setPos(PVector p) {pos = p;}
  
  public void updatePos()
  {
    pos.x = index.x * numPixels.x;
    pos.y = -index.y * numPixels.y;
    pos.z = index.z * numPixels.z;
  }
}