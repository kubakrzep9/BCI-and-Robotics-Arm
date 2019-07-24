// Written by: Jakub Krzeptowski-Mucha
//
// This program is essentially the brain of the robotic arm. This program sends and receives 
// instructions to interface the arm. The most important aspect of this program is the instruction
// interpretter, which parses and executes an instruction. The robot.h header file contains all
// the functions that the instruction interpretter will execute. These functions either send information
// from the Arduino to the computer, set certain sets of values, or move the arm to a specified position. 

#include <robot.h>
#include <string.h>

const int BUFFER_LENGTH = 256;

MyRobot robot;
int numServos = 6;

// Sets servo pins, initializes the serial output and moves the arm to it's initial position  
void setup() { robot.setUp(); }

// Constantly listening for instructions being sent from GUI. Once an instruction is received the
// instructionInterpretter will parse and execute the instruction.  
void loop() {
  if(Serial.available()){
    String val = Serial.readStringUntil('\n');
    instructionInterpretter(val);
  }
}

// Parses the instruction sent from the GUI. The first token, first element of parsedInstr, is the
// instructionID which is used to specify which instruction to execute. The tokens following the
// instructionID are the arguments to the instruction. There will either be 6 arguments for the servos,
// 3 arguments for the coordinate or no arguments. 
void parseInstruction(String instr, String parsedInstr[], int arrSize){
   char input[BUFFER_LENGTH];
   instr.toCharArray(input, BUFFER_LENGTH);
   char *pch;
   pch = strtok(input, " ");
   for(int i=0; i<arrSize && pch != NULL; i++){
      String token(pch);    
      parsedInstr[i] = token;
      pch = strtok(NULL, " ");
   }
}

// Seperates the arguments from the instructionID from the parsed instruction 
void extractArguments(String parsedInstr[], int extractedArgs[], int arrSize){
  for(int i=0; i<arrSize; i++){
    extractedArgs[i] = parsedInstr[i+1].toInt();
  }
}

// When an instruction is received it is sent to the instruction interpretter where it will
// be parsed to determine the instructionID and arguments. If the instruction is valid, the 
// instructionID will be used to determine which branch to execute. 
void instructionInterpretter(String instr){
    int arrSize = numServos+1;
    String parsedInstr[arrSize];
    parseInstruction(instr, parsedInstr, arrSize);
    String instructionID = parsedInstr[0]; 

         if(instructionID == "pins"){ robot.sendPins(); }
    else if(instructionID == "current"){ robot.sendCurrentPosition(); }
    else if(instructionID == "currentCoordinate"){ robot.sendCurrentCoordinate(); }
    else if(instructionID == "home"){ robot.sendHomePosition(); }
    else if(instructionID == "quit"){ exit(0); }
    else if(instructionID == "tohome"){ robot.toHomePosition(); }
    else if(instructionID == "setPins"){ 
      int args[numServos]; 
      extractArguments(parsedInstr, args, numServos+1);
      robot.setPins(args[0], args[1], args[2], args[3], args[4], args[5]);
    } 
    else if(instructionID == "setHome"){ 
      int args[numServos]; 
      extractArguments(parsedInstr, args, numServos+1);
      robot.setHomePosition(args[0], args[1], args[2], args[3], args[4], args[5]);
    }
    else if(instructionID == "moveAngles"){
      int args[numServos]; 
      extractArguments(parsedInstr, args, numServos+1);
      robot.moveAngles(args[0], args[1], args[2], args[3], args[4], args[5]);
    }
    else if(instructionID == "moveAlgorithm"){
      int args[numServos]; 
      extractArguments(parsedInstr, args, numServos+1);
      robot.moveAlgorithm(args[0], args[1], args[2]);
    }
    else{
      Serial.print("Sending back: " );
      Serial.println(instr);
    }
}
