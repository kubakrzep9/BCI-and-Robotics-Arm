// The ArmControlMenu is used to instatiate all buttons and input fields that will appear on the GUI.

import controlP5.*;

class ArmControlMenu {
  
  public ControlP5 menuControl;
  private final PApplet theParent; 
  public DropdownList availablePorts; 
   
  private final int buttonWidth      = 150;
  private final int buttonHeight     = 80;
  private final int btn_xCoord       = 75;  // X coordinate of upper left corner of button
  private final int btn_yCoord       = 50;  // Y coordinate of upper left corner of button
  private final int input_xCoord     = 120; // X coordinate of upper left corner of input textfield
  private final int input_yCoord     = 88;  // Y coordinate of upper left corner of input textfield
  private final int coord_xCoord     = 75;  // X coordinate of upper left corner of coord textfield
  private final int coord_yCoord     = 130; // Y coordinate of upper left corner of coord textfield 
  private final int inputFieldHeight = 18;
  private final int inputFieldWidth  = 80;
  private final int coordFieldWidth  = 25;
  
  private ArrayList<String> mainMenuButtons;
  private ArrayList<String> moveMenuButtons;
  private ArrayList<String> optionsMenuButtons;
  private ArrayList<String> servoInputFields;
  private ArrayList<String> coordinateInputFields;
    
  ArmControlMenu(final PApplet parent){
    theParent             = parent;
    mainMenuButtons       = new ArrayList<String>();
    moveMenuButtons       = new ArrayList<String>();
    optionsMenuButtons    = new ArrayList<String>();
    servoInputFields      = new ArrayList<String>();
    coordinateInputFields = new ArrayList<String>();
  }
  
  // GUI Initialization funtion. This is where all of the buttons and input fields of the GUI are created. 
  // Each button is created in a group related to the screen they will be placed on. When one screen is 
  // displayed on the GUI only the related buttons and input fields are displayed. The rest are hidden until
  // the screen is changed and the relevant buttons and input fields will be displayed. 
  public void init(){
  
    menuControl = new ControlP5(theParent);
    
    menuControl.addButton("mainmenu")     
      .setPosition(btn_xCoord, 350)         
      .setSize(buttonWidth, buttonHeight)   
      .setFont(fonts.get(0))                
      .hide()                               
    ;
   
    menuControl.addButton("connect")       
      .setPosition(200, 50)                
      .setSize(60, 25)                     
      .setFont(fonts.get(2))               
      .hide()                              
    ;
  
    menuControl.addButton("submit")       
      .setPosition(120, 265)              
      .setSize(60, 25)                    
      .setFont(fonts.get(2))              
      .hide()                             
    ;
    
    /*****************************/
    /***** Main Menu Buttons *****/
    /*****************************/
    String namesMainMenu[] = {"display", "move", "options", "quit"};
    int size = namesMainMenu.length;
    for(int i=0; i<size; i++){
      mainMenuButtons.add(namesMainMenu[i]);        
      menuControl.addButton(namesMainMenu[i])       
        .setPosition(btn_xCoord, btn_yCoord+100*i)  
        .setSize(buttonWidth, buttonHeight)         
        .setFont(fonts.get(0))                      
        .hide()                                     
      ;  
    }
    
    /*****************************/
    /***** Move Menu Buttons *****/
    /*****************************/ 
    String namesMoveMenu[] = {"algorithm", "angles", "tohome"};
    size = namesMoveMenu.length;    
    for(int i=0; i<size; i++){ 
      moveMenuButtons.add(namesMoveMenu[i]);
      menuControl.addButton(namesMoveMenu[i])         
        .setPosition(btn_xCoord, btn_yCoord+100*i)    
        .setSize(buttonWidth, buttonHeight)           
        .setFont(fonts.get(0))                        
        .hide()                                       
      ;
    }
    
    /********************************/
    /***** Options Menu Buttons *****/
    /********************************/ 
    String namesOptionsMenu[] = {"port", "potpins", "home"};
    size = namesOptionsMenu.length;    
    for(int i=0; i<size; i++){ 
      optionsMenuButtons.add(namesOptionsMenu[i]);
      menuControl.addButton(namesOptionsMenu[i])      
        .setPosition(btn_xCoord, btn_yCoord+100*i)    
        .setSize(buttonWidth, buttonHeight)           
        .setFont(fonts.get(0))                        
        .hide()                                        
      ;   
    }          
    
    /***********************************************/
    /***** Input texfields for Servo data entry ****/
    /***********************************************/
    String namesInputFields[] = {"input body", "input shoulder", "input elbow", "input wrist", "input hand", "input handRotator"};
    size = namesInputFields.length;
       
    for(int i=0; i<size; i++){
      servoInputFields.add(namesInputFields[i]);
      menuControl.addTextfield(namesInputFields[i])
        .setPosition(input_xCoord,input_yCoord+30*i)
        .setSize(inputFieldWidth, inputFieldHeight)
        .setFont(fonts.get(2))
        .setFocus(true)
        .setAutoClear(false)
        .hide()
        .getCaptionLabel().setVisible(false)
      ;
    }
    
    /*********************************************/
    /***** Input texfields for 3D coordinate *****/
    /*********************************************/
    String coordsInputFields[] = {"input x", "input y", "input z"};
    size = coordsInputFields.length;
       
    for(int i=0; i<size; i++){
      coordinateInputFields.add(coordsInputFields[i]);
      menuControl.addTextfield(coordsInputFields[i])
        .setPosition(coord_xCoord,coord_yCoord+30*i)
        .setSize(coordFieldWidth, inputFieldHeight)
        .setFont(fonts.get(2))
        .setFocus(true)
        .setAutoClear(false)
        .hide()
        .getCaptionLabel().setVisible(false)
      ;
    }
  
    /****************************************/
    /***** Port Selection Dropdown List *****/
    /****************************************/
    availablePorts = menuControl.addDropdownList("ports")
        .setPosition(25, 50)
        .setFont(fonts.get(2))
        .setSize(buttonWidth, 200)
        .hide()
    ;
    
    customizeDDL(availablePorts);
    showElements("main");
  }
  
  
  // Returns item from DropDownList at a specific index
  public String getItemDropDownList(DropdownList ddl, int index){ 
    java.util.Map<java.lang.String,java.lang.Object> item = ddl.getItem(index);
    return item.get("text").toString();
  }
  
  
  // Convenience function to customize a DropdownList
  void customizeDDL(DropdownList ddl) {
    ddl.setBackgroundColor(color(190));
    ddl.setItemHeight(25);
    ddl.setBarHeight(25);
    ddl.setCaptionLabel("Available ports");
   
    String portsAvailable[] = Serial.list();
    int size = portsAvailable.length; 
    
   //Adding ports to DropdownList
    for (int i=0;i<size;i++){ ddl.addItem(portsAvailable[i], i); }
  
    ddl.setColorBackground(color(60));
    ddl.setColorActive(color(255, 128));
  }


  // Convenience function to set a Button to a specific (x,y) coordinate.
  public void moveButton(String btnName, int xcoord, int ycoord){
    menuControl.getController(btnName).setPosition(xcoord, ycoord);
  }
  
  
  // Clears all text fields from the Template Input Screen. Used to clear input fields after user has 
  // submitted their inputs. Also used to clear input fields, if there is anything on them, when 
  // switching screens. Otherwise, the input fields will retain an old value. 
  public void clearTextFields(){
    for(String str : servoInputFields){
      menuControl.get(Textfield.class, str).setText("");
    }
  }
  
  
  // Used to retrieve user input from the input fields according to a name provided as an argument. The name 
  // is used to decide which input fields to read from. 
  public String[] getTextField(String name){
    String nullSet[] = new String[1]; //return nothing if name doesn't match
    
    if(name == "servo input fields"){        
      int size = servoInputFields.size();;    
      String textFields[] = new String[size]; 
      for(int i=0; i<size; i++){
        textFields[i] = menuControl.get(Textfield.class, servoInputFields.get(i)).getText();
      } 
      return textFields;
    }
    if(name == "coordinate input fields"){
      int size = coordinateInputFields.size();;    
      String textFields[] = new String[size]; 
      for(int i=0; i<size; i++){
        textFields[i] = menuControl.get(Textfield.class, coordinateInputFields.get(i)).getText();
      } 
      return textFields;
    }
    return nullSet;
  }
  
  
  // Convenience function used easily hide all buttons and input fields
  public void resetElements(){ hideElements("all"); }
    
  // Convenience function to easily display any GUI element or group of elements (buttons, input fields).
  // Used when preparing GUI to display a specific screen.
  public void showElements(String name){
    if(name == "main"){
       for( String btnName : mainMenuButtons){ 
          menuControl.getController(btnName).show();
       } 
    }
    if(name == "mainmenu" ){
      menuControl.getController("mainmenu").show();
    }
    if(name == "move"){
       for( String btnName : moveMenuButtons){ 
            menuControl.getController(btnName).show();
       }  
    }
    if(name == "options"){
       for( String btnName : optionsMenuButtons){  
            menuControl.getController(btnName).show();
       }  
    }
    if(name == "ports"){
      menuControl.getController("ports").show();  
      menuControl.getController("connect").show();  
    }
    if(name == "servo input fields"){
      for( String fieldName : servoInputFields){
        menuControl.getController(fieldName).show();
      }
    }
    if(name == "submit"){
      menuControl.getController(name).show();
    }
    if(name == "coordinate input fields"){
     for( String fieldName : coordinateInputFields){
        menuControl.getController(fieldName).show();
      }  
    }
  }
 
    

  // Convenience function to easily hide any and all GUI element or groups of elements (buttons, input fields). 
  // Used when preparing GUI to display a specific screen.
  public void hideElements(String name){
    if(name == "main" || name == "all"){
       for( String btnName : mainMenuButtons){ 
          menuControl.getController(btnName).hide();
       } 
    }
    if(name == "mainmenu" || name == "all" ){
      menuControl.getController("mainmenu").hide();
    }
    if(name == "move" || name == "all"){
       for( String btnName : moveMenuButtons){ 
            menuControl.getController(btnName).hide();
       }
    }
   if(name == "options" || name == "all"){
       for( String btnName : optionsMenuButtons){ 
            menuControl.getController(btnName).hide();
       }
    }
    if(name == "ports" || name == "all"){
      menuControl.getController("ports").hide();  
      menuControl.getController("connect").hide();  
    }
    if(name == "servo input fields" || name == "all"){
      for( String fieldName : servoInputFields){
        menuControl.getController(fieldName).hide();
      }
    }
    if(name == "submit" || name == "all"){
      menuControl.getController("submit").hide();
    }
    if(name == "coordinate input fields" || name == "all"){
      for( String fieldName : coordinateInputFields){
        menuControl.getController(fieldName).hide();
      }      
    }
  }
}
