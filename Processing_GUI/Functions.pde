// This section is used to define Serial communication and related functions.



// Serial communication function that reads in the instruction being received. This 
// instruction is then sent to the instruction interpretter be executed. 
void serialEvent(Serial port){
  port.bufferUntil('\n');
  
  String message = port.readStringUntil('\n');
  if(message != null){  
    message = message.replace('\n', ' ');
    //println(message);
    
    instructionInterpretter(message);
  }
}

// Extracts the data from the parsed instruction. The data is either servo angle measures
// or a coordinate.
int[] extractData(String data[]){
  int size = data.length - 1; // subtract 1 because element[0] is instructionID
  int arr[] = new int[size];  
  
  for(int i=0; i<size; i++){
    try{ arr[i] = Integer.parseInt(data[i+1]); }
    catch( Exception e){ arr[i] = Integer.parseInt(data[i+1].replaceAll("\\s","")); } 
  }
  return arr;
}

// When an instruction is received it is sent to the instruction interpretter where it will be parsed
// to determine the instructionID and arguments/data. If the instruction is valid, the instructionID will
// be used to determine which branch to execute.
void instructionInterpretter(String instr){
    String[] parsedInstr = instr.split(" ");
    int size = 0;
    if(parsedInstr[0].equals("pins") || parsedInstr[0].equals("currentPosition") 
                                     || parsedInstr[0].equals("homePosition")){ size = arm.numServos; } //6 servos
    else if(parsedInstr[0].equals("currentCoordinate")){ size = 3; }
    else{ println("Unrecognized instruction received: " + instr); return; }
    
    int v[] = new int[size];
    v = extractData(parsedInstr);
    
    switch(parsedInstr[0]){
      case "pins":
        arm.setPins(v[0], v[1], v[2], v[3], v[4], v[5]);
        break;
      case "currentPosition":
        arm.setCurrentPosition(v[0], v[1], v[2], v[3], v[4], v[5]);
        break;
      case "currentCoordinate":
        arm.setCurrentCoordinate(v[0], v[1], v[2]);
        break;
      case "homePosition":
        arm.setHomePosition(v[0], v[1], v[2], v[3], v[4], v[5]);
        break;
      default:
        println(instr);
    }
}

// Used to send an instruction to the Arduino on a seperate thread using serial communication
void sendInstruction(String instr){
  ConnThread thread1 = new ConnThread(instr, port);
  thread1.start();
}

// Used to send instructions to the Arduino on a seperate thread using serial communication
void sendInstruction(String instr[]){
  ConnThread thread1 = new ConnThread(instr, port);
  thread1.start();
}

// Creates an instruction to be sent to the Arduino from an instructionID and a list of arguments. 
String makeInstruction(String instructionID, String arguments[]){
 String instruction = instructionID;
 int size = arguments.length;
 for(int i=0; i<size; i++){
   instruction = instruction + " " + arguments[i];
 }
 return instruction;
}

// Validation function incase user does not provide input for every input field. When there is an empty
// input field, this method will use the current value in place of the empty field to send an instruction.
Boolean checkEmptyInput(String input[], int menuChoice){
  int armData[] = {1};

  switch(menuChoice){
  case 5: //pins
    armData = arm.getPins();
    break;
  case 6: //home
    armData = arm.getHomePosition();
    break;
  case 7: //moveAlgorithm     (x,y,z) coordinate
    armData = arm.getCurrentCoordinate();
    break;
  case 8: //moveAngles
    armData = arm.getCurrentPosition();
    break;
  }
  
  int size = input.length;
  for(int i=0; i<size; i++){ 
    if(input[i].equals("")){ 
      input[i] = str(armData[i]);
    } 
  }
  
  return true; 
}

// Validation function to make sure what was entered by the user was an integer. 
Boolean validateIntInput(String input[]){
  for(String str : input){
    if(!str.equals("")){ 
      try{ Integer.parseInt(str); }
      catch(Exception e){ return false; }
    }
  }
  return true;
}

// Validation function used for the Potpin Selection Screen. Prevents user from assigning two 
// servos to the same potpin.
Boolean checkDuplicates(String input[]){
  int size = input.length;
  for(int i=0; i<size; i++){
    for(int j=i+1; j<size; j++){
      if(input[i].equals(input[j])){ return true; } //Duplicate
    }
  }
  return false;
}

// Template input screen used for entering servo angle measures on multiple different screens.  
void mainTemplate(int screen){
  menu.resetElements();
  menu.showElements("mainmenu");
  menuChoice = screen;
}

// Shows the servo input fields and submit button
void inputFields(){
  menu.showElements("servo input fields");
  menu.showElements("submit");
}

// Clears all input fields 
void clearInputFields(){
  menu.clearTextFields(); 
}

// Used to display the coordinate input fields
void coordinateInputFields(){
  menu.showElements("coordinate input fields");
  menu.showElements("submit");
}
