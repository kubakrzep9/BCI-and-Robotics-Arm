// Written by: Jakub Krzeptowski-Mucha 
//
// This program is a GUI which interfaces with a 6-servo robotic arm via serial communications. The user
// is able to view the arms relevant information: potpins selected, current servo angle measures, home servo
// angle measures, current coordinate and port connected. The user is able to set the port connection, home
// position, and potpins. The user can move the arm by using the Move Menu to set each angle measure, enter an
// (x,y,z) coordinate [WORK IN PROGRESS], or by pressing the tohome button to return to the home position.




import processing.serial.*;

String portConnection = "not set"; // The port which you are trying to connect to 
int menuChoice = 0; // Keeps track of which menu user selects
ArrayList <PFont> fonts;
Serial port; 
Robot arm;
GUISettings gui;
ArmControlMenu menu;

// Instantiates class objects and sets GUI screen
void setup(){
  fonts = new ArrayList<PFont>();
  fonts.add(createFont("Liberation Sans Bold", 20)); // font for buttons and title
  fonts.add(createFont("Liberation Sans Bold", 15)); // font for headings
  fonts.add(createFont("Liberation Sans Bold", 10)); // font for text
  
  arm = new Robot();
  gui = new GUISettings(arm);
  menu = new ArmControlMenu(this);  
  menu.init();
  gui.resizeToMain();
}

// Used to display each menu and screen, which is kept track by the menuChoice variable. 
void draw(){
  switch(menuChoice){
    case 0: // main menu
      gui.mainMenuScreen();
      break;
    case 1: // display menu
      gui.displayMenuScreen();
      break;
    case 2: // move menu
      gui.moveMenuScreen();
      break;
    case 3: // options menu
      gui.optionsMenuScreen();
      break; 
    case 4: 
      gui.portSelectionScreen();
      break;
    case 5:
      gui.potPinsSelectionScreen();
      break;
    case 6:
      gui.setHomePositionScreen();
      break;
    case 7:
      gui.moveAlgorithmScreen();
      break;
    case 8:
      gui.moveAnglesScreen();
      break;
  }
}
