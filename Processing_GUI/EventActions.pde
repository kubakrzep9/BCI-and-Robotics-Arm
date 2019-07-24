// This section is used to define all Button Control Functions, which are executed when
// their respective buttons are pressed.



// Button Control Function. Used to display the Display Screen, which shows the relevant 
// information about the arm: potpins, current and home angle measures, current coordinate, 
// and port connected. An instruction is sent to the Arduino requesting this information. 
void display(){ 
  mainTemplate(1);
  menu.moveButton("mainmenu", 225, 350);
  gui.resizeToDisplay();
  
  String instructions[] = {"current", "home", "pins", "currentCoordinate"};
  sendInstruction(instructions);
}

// Button Control Function. Used to display the Move Menu, which allows the user to move the arm
// by entering each servo angle, entering an (x,y,z) coordinate or by selecting the home button to 
// return to the home position. 
void move(){
  mainTemplate(2);
  menu.showElements("move");
}

// Button Control Function. Used to display the Options Menu on the GUI, which allows the user to 
// set the port, potpins or home position. 
void options(){
  mainTemplate(3);  
  menu.showElements("options");
}

// Button Control Function. Used to quit the GUI.  
void quit(){ exit(); }

// Button Control Function. Used to display the Main Menu, which allows the user to traverse to the 
// Display Screen, Move Menu or Options Menu. 
void mainmenu(){ 
  menu.resetElements(); 
  menu.showElements("main");
  menuChoice = 0;
  gui.resizeToMain();
  menu.moveButton("mainmenu", 75, 350);
  clearInputFields();

}

// Button Control Function. Used to display Port Selection Screen, which allows the user to select
// which port they would like to connect to.
void port(){
  mainTemplate(4);
  menu.showElements("ports");
}

// Button Control Function. Used to display Potpins Screen, which allows the user to specify the potpin
// each servo is connected to.
void potpins(){  
  sendInstruction("pins");
  mainTemplate(5);
  inputFields();
}

// Button Control Function. Used to display the Set Home Position Screen, which allows the user to 
// specify each servo angle measure for the home position.
void home(){ 
  sendInstruction("home");
  mainTemplate(6);
  inputFields();
} 

// Button Control Function. Used in the Port Selection Screen, it is used to verify if a port is valid 
// to connect to.
void connect(){
  try{ // Try to connect to port portConnection 
    port = new Serial(this, portConnection, 9600); 
    println("Connected to port: " + portConnection);
    gui.setPortConnected(true);
  } 
  catch( Exception e){ // If failed, display error message
    if(!gui.getPortConnected()){ 
      println("Unable to connect to port: " + portConnection);
      gui.setPortConnected(false); 
      gui.setPortSelected(false);
    }else{ println("Already connect to port: " + portConnection); }    
  }     
}

// Button Control Function. Used to display the MoveAlgorithm Screen, which allows the user to enter 
// a target (x,y,z) coordinate to move the arms hand to. 
void algorithm(){ 
  mainTemplate(7); 
  coordinateInputFields();
  String instructions[] = {"current", "currentCoordinate"};
  sendInstruction(instructions);
}

// Button Control Function. Used to display MoveAngles Screen, which allows the user to enter angle 
// measures for each of the servos to move to. 
void angles(){
  mainTemplate(8);
  inputFields();
  sendInstruction("current");
}

// Button Control Function. Used to send the home instruction to move the arm to it's home position.
void tohome(){ sendInstruction("tohome"); }
  
// Decision structure to send instructions to get specific information. 
void updateInfo(){
  switch(menuChoice){
    case 5:
      sendInstruction("pins");
      break;
    case 6:
      sendInstruction("home");
      break;
    case 7:
      String instructions[] = {"currentCoordinate", "current"};
      sendInstruction(instructions);
      break;
    case 8:
      sendInstruction("current");
      break;
    default:
      return;
  }
}

// Button Control Function. Used to send user input as an instruction to the Arduino. This function 
// first verifies that the entered input is valid before it sends any instruction. There is only one 
// submit button for all screens and so menuChoice is used to differentiate which instruction should 
// be sent.
void submit(){
  Boolean nonEmpty = false;
  Boolean validInt = false; 
  Boolean duplicates = false;
  String keyWord = "";
  String textFieldKeyWord = "servo input fields";
  
  switch(menuChoice){
    case 5:
      keyWord = "setPins";
      break;
    case 6:
      keyWord = "setHome";
      break;
    case 7:
      keyWord = "moveAlgorithm";
      textFieldKeyWord = "coordinate input fields";
      break;
    case 8:
      keyWord = "moveAngles";
      break;
    default:
      return;
  }
  
  String input[] = menu.getTextField(textFieldKeyWord);

  nonEmpty = checkEmptyInput(input, menuChoice);
  validInt = validateIntInput(input);
   
  if(nonEmpty && validInt){ 
     if(menuChoice == 5){ duplicates = checkDuplicates(input); }
     if(duplicates){ println("All pin values must be unique, no duplicates");}
     else{
      String instruction = makeInstruction(keyWord, input);
      //println(instruction);
      sendInstruction(instruction);
     }
  }else{ println("Enter only digits"); return; }
  
  delay(1100);
  updateInfo();
  delay(100); 
  clearInputFields();
}



/***** Dropdown List Control Functions *****/

// Function allows the ability access each event. In this case we select a port from the 
// dropdownlist and connect to it
void controlEvent(ControlEvent theEvent) {

  // Sets user selected port to be connected
  if(theEvent.getName().equals("ports")){
    int index = int(theEvent.getController().getValue());
    if(!gui.getPortConnected()){
      portConnection = menu.getItemDropDownList(menu.availablePorts, index);
    }
    gui.setPortSelected(true);
  } 
}
