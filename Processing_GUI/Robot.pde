// The Robot class is used to maintain all of the arms information such as potpins, 
// current position, home position and current coordinate. 

class Robot{
  
  private Servos pins;
  private Servos currentPosition;
  private Servos homePosition;
  private Coordinate currentCoordinate;
  public int numServos;
  
  Robot(){
    pins              = new Servos();
    currentPosition   = new Servos();
    homePosition      = new Servos();
    currentCoordinate = new Coordinate();
    numServos         = Servos.numServos;
  }
  
  public void setPins(int b, int s, int e, int w, int h, int hr){ pins.setValues(b, s, e, w, h, hr); }
  public void setCurrentPosition(int b, int s, int e, int w, int h, int hr){ currentPosition.setValues(b, s, e, w, h, hr); }
  public void setHomePosition(int b, int s, int e, int w, int h, int hr){ homePosition.setValues(b, s, e, w, h, hr); }
  public void setCurrentCoordinate(int x, int y, int z){ currentCoordinate.setCoordinate(x, y, z); }
  
  public int[] getPins(){ return pins.getValues(); }
  public int[] getCurrentPosition(){ return currentPosition.getValues(); }
  public int[] getHomePosition(){ return homePosition.getValues(); }
  public int[] getCurrentCoordinate(){ return currentCoordinate.getCoordinate(); }
  
  
  // The Servos inner class is used to as an easily way to keep track of a value for each servo. 
  // That value could be an angle measure or a potpin.
  class Servos{
     private int body;
     private int shoulder;
     private int elbow;
     private int wrist;
     private int hand;
     private int handRotator;
     public static final int numServos = 6;
  
  
     Servos(){
       body        = 0;
       shoulder    = 0;
       elbow       = 0;
       wrist       = 0;    
       hand        = 0;
       handRotator = 0;
    }
    
    private void setValues(int b, int s, int e, int w, int h, int hr){
      body        = b;
      shoulder    = s;
      elbow       = e;
      wrist       = w;
      hand        = h;
      handRotator = hr;
    }
    
    private int[] getValues(){
      int values[] = new int[numServos];
      values[0]    = body;
      values[1]    = shoulder;
      values[2]    = elbow;
      values[3]    = wrist;
      values[4]    = hand;
      values[5]    = handRotator;
      return values;
    }
  }
  
  // The Coordinate inner class is used to keep track of an (x,y,z) coordinate. It is used to 
  // track the current coordinate.
  class Coordinate{
    private int x;
    private int y;
    private int z;
    
    Coordinate(){
      x = 0;
      y = 0;
      z = 0;
    }
    
    private void setCoordinate(int _x, int _y, int _z){
      x = _x;
      y = _y;
      z = _z;
    }
    
    private int[] getCoordinate(){
      int values[] = new int[3];
      values[0]    = x;
      values[1]    = y;
      values[2]    = z;
      return values;
    }
  } 
}
