// The GUISettings class is used to create all screens and menus that will be displayed on the GUI.

class GUISettings extends DisplayFunctions{

  private int mainMenuWidth     = 300;
  private int mainMenuHeight    = 450;
  private int displayMenuHeight = mainMenuHeight;
  private Boolean portConnected = false;
  private Boolean portSelected  = false;
  private Robot arm; 
  
  GUISettings(Robot a){
    this.arm = a;
    surface.setResizable(true);
    resizeFull();
  }
  
  
  public void resizeToDisplay(){ surface.setSize(600, displayMenuHeight); }     // Resizes GUI to display screen dimensions
  public void resizeToMain(){ surface.setSize(mainMenuWidth, mainMenuHeight); } // Resizes GUI to main menu dimensions
  private void resizeFull(){ surface.setSize(600, 600); }                       // Resizes GUI to full dimensions
   
  public void setPortConnected(Boolean bool){ this.portConnected = bool; }      
  public Boolean getPortConnected(){ return this.portConnected; }
  public void setPortSelected(Boolean bool){ this.portSelected = bool; }
  public Boolean getPortSelected(){ return this.portSelected; }
 
  
  // GUI design for Main Menu screen
  public void mainMenuScreen(){
    background(140, 162, 216); 
    fill(0, 0, 0);
    setMyText("Main Menu", width/2, 30, CENTER, fonts.get(0));      
  }
 
 
  // GUI design for Display screen, which is essentially a table describing the arms current servo
  // positions, home position, potpins, current coordinate and port connection.
  public void displayMenuScreen(){    
    String textPort  = "Port: " + portConnection; 
    int xCoord       = 110;
    int servosXCoord = xCoord + 110;
    int servosYCoord = 125;
    int valuesXCoord = servosXCoord + 10;
   
    background(140, 162, 216); 
    whiteRectangle(75, 75, 450, 235);
    
    // horizontal black bar
    fill(1);
    rect(100,130,400,2);
    
    // vertical black bar
    fill(1);
    rect(200,110,2,100);
        
    fill(1);
    setMyText("Arm Information",  width/2, 30, CENTER, fonts.get(0));
    setMyText("Servos",           width/2, 100, CENTER, fonts.get(1));
    setMyText("Current Position", xCoord, 150, LEFT, fonts.get(2)); 
    setMyText("Home Position",    xCoord, 170, LEFT, fonts.get(2));
    setMyText("Potpins",          xCoord, 190, LEFT, fonts.get(2)); 
    if(portConnected){ setMyText(textPort, xCoord, 300, LEFT, fonts.get(2)); }   
    else{ setMyText("Port: not set", xCoord, 300, LEFT, fonts.get(2)); }
  
    setMyText("Body",            servosXCoord, servosYCoord, LEFT, fonts.get(2)); 
    setMyText("Shoulder",        servosXCoord+40, servosYCoord, LEFT, fonts.get(2)); 
    setMyText("Elbow",           servosXCoord+100, servosYCoord, LEFT, fonts.get(2)); 
    setMyText("Wrist",           servosXCoord+150, servosYCoord, LEFT, fonts.get(2)); 
    setMyText("Hand",            servosXCoord+200, servosYCoord, LEFT, fonts.get(2)); 
    setMyText(" Hand\nRotator", servosXCoord+250, servosYCoord - 15, LEFT, fonts.get(2)); 
     
    int current[]    = arm.getCurrentPosition();
    int home[]       = arm.getHomePosition();
    int pins[]       = arm.getPins();    
    int coord[]      = arm.getCurrentCoordinate();  
    String coordText = "Current Coordinate: " + "( " + coord[0] + ", " + coord[1] + ", " + coord[2] + " )";
    
    displayRow(current,  valuesXCoord, 150, 50);
    displayRow(home,     valuesXCoord, 170, 50);
    displayRow(pins,     valuesXCoord, 190, 50);
    setMyText(coordText, xCoord, 250, LEFT, fonts.get(2));
  }
 
  
  // GUI design for Move Menu Screen
  public void moveMenuScreen(){    
    background(140, 162, 216);     
    setMyText("Move Arm",  width/2, 30, CENTER, fonts.get(0));          
  }
  
    
  // GUI design for Options Menu Screen
  public void optionsMenuScreen(){    
    background(140, 162, 216);           
    setMyText("Arm Settings",  width/2, 30, CENTER, fonts.get(0));
  }
  
  
  // GUI design for Port Selection Screen, which allows the user to select a port to connect to and verifies
  // if the port has been successfully connected to.
  public void portSelectionScreen(){
    int portTextHeight = 325;
    
    background(140, 162, 216);  
    setMyText("Port Selection",  width/2, 30, CENTER, fonts.get(0));
    whiteRectangle(75, 310, 150, 25); 

    if(portConnected){
      String text = "Connected to port: " + portConnection;  
      whiteRectangle(65, 310, 170, 25); 
      gui.setMyText(text, width/2, portTextHeight, CENTER, fonts.get(2)); 
    }else if(!portConnected && !portSelected){
      String text = "Port not connected";    
      gui.setMyText(text, width/2, portTextHeight, CENTER, fonts.get(2));      
    }else if(portSelected){
      String text = "Port: " + portConnection;
      gui.setMyText(text, width/2, portTextHeight, CENTER, fonts.get(2));     
    }
  }
  
  
  // GUI design for the Template Input Screen used for each screen that requires input for servo measures. Displays 
  // current information for the relevant menu and has input fields for user input. 
  private void templateInputScreen(int data[], String title){
    int xCoordName        = 50;
    int xCoordValue       = 230;
    int yCoord            = 100;
    String formatedData[] = formatIntData(data);  
    String servoNames[]   = {"Body", "Shoulder", "Elbow", "Wrist", "Hand", "Hand Rotator"};

    background(140, 162, 216);  
    whiteRectangle(215, 60, 50, 200); 
    setMyText(title,  width/2, 30, CENTER, fonts.get(0));
    setMyText("Current" ,240, yCoord-20, CENTER, fonts.get(2));
    displayColumn(servoNames, xCoordName, yCoord, 30);
    displayColumn(formatedData, xCoordValue, yCoord, 30);
  }
  
  
  // GUI design for the Potpins Selection Screen, which allows the user to set eatch servo's
  // potpin, and displays the current potpins. 
  public void potPinsSelectionScreen(){
    int pins[] = arm.getPins();
    templateInputScreen(pins, "Potpins Selection");
  }
 
  
  // GUI design for the Set Home Position Screen, which allows the user to set each servo angle
  // measure for the home position, and displays the current home position servo angle measures. 
  public void setHomePositionScreen(){
    int home[] = arm.getHomePosition();
    templateInputScreen(home, "Set Home Position");
  }  
 
 
  // GUI design for the Move Algorithm Screen, which allows the user to enter a target (x,y,z) 
  // coordinate and displays the current coordinate and servo angle measures. 
  public void moveAlgorithmScreen(){
    int xCoord              = 60;
    int yCoord              = 143;
    int yCoordServos        = 95;
    int currentCoords[]     = arm.getCurrentCoordinate();  
    int currentAngles[]     = arm.getCurrentPosition();  
    String coordNames[]     = {"X", "Y", "Z"};
    String servoNames[]     = {"Body", "Shoulder", "Elbow", "Wrist", "Hand", "Hand Rotator"};
    String formatedCoords[] = formatIntData(currentCoords);
    String formatedAngles[] = formatIntData(currentAngles);
    
    background(140, 162, 216); 
    whiteRectangle(110, 55, 140, 175); 

    setMyText("Move using Algorithm",  width/2, 30, CENTER, fonts.get(0));
    setMyText("Current",  135, 70, CENTER, fonts.get(2));
    displayColumn(coordNames,     xCoord, yCoord, 30);
    displayColumn(formatedCoords, xCoord + 60, yCoord, 30);
    displayColumn(servoNames,     xCoord + 100, yCoordServos, 30);
    displayColumn(formatedAngles, xCoord + 150, yCoordServos, 30);    
  }
  
  
  // GUI design for the Move Angles Screen, which allows the user to set each servo's angle measure,
  // and displays each servo's current angle measure. 
  public void moveAnglesScreen(){
    int currentAngles[] = arm.getCurrentPosition();
    templateInputScreen(currentAngles, "Move using Angle Measures");
  }

  // Function to easily make a white rectangle. All user needs to specify is the x and y coordinates 
  // of the upper left corner and the length and width of the rectangle itself. 
  private void whiteRectangle(int x, int y, int w, int h){
    noStroke();
    fill(255,255,255); // white for rectangle
    rect(x,y,w,h);  
    fill(1); // black, otherwise rest of text will follow with white

  }
}
