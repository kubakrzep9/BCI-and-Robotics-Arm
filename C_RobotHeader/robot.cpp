#include "robot.h"


// Moves arm to the initial position. Called from the setUp function in the MyRobot class which 
// is called in the setup function of the Arduino program. 
void MyRobot::initialPosition(){
  setHomePosition(90, 90, 90, 90, 0, 0);
  toHomePosition();
  setCurrentPosition(home.body, home.shoulder, home.elbow, home.wrist, home.hand, home.handRotator);
}

// Used to set user defined servo pins, initialize the serial output and move the arm to it's initial position 
// during the setup portion of the Arduino program
void MyRobot::setUp(int bPin, int sPin, int ePin, int wPin, int hPin, int hrPin){
  Serial.begin(baudRate);
  setPins(bPin, sPin, ePin, wPin, hPin, hrPin);
  initialPosition();
}

// Used to set servo pins, initializes the serial output and move the arm to it's initial position 
// during the setup portion of the Arduino program
void MyRobot::setUp(){
  Serial.begin(baudRate);
  setPins();
  initialPosition();
}

// Simple function to move servo, used to increase program readability
void MyRobot::moveServo(Servo s, int angle){ s.write(angle); }

// If no pins are set in the parameters, the pins will default to below.
void MyRobot::setPins(){
  bodyPin        = 8;
  shoulderPin    = 9;
  elbowPin       = 10;
  wristPin       = 11;
  handPin        = 12;
  handRotatorPin = 13;

  body.attach(bodyPin);
  shoulder.attach(shoulderPin);
  elbow.attach(elbowPin);
  wrist.attach(wristPin);
  hand.attach(handPin);
  handRotator.attach(handRotatorPin);
}

// Sets the angle measures from the moveAngles instructions as the current angle measures. Used to keep
// track of the arms current position. 
void MyRobot::setCurrentPosition(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
  current.body        = bAngle;
  current.shoulder    = sAngle;
  current.elbow       = eAngle;
  current.wrist       = wAngle;
  current.hand        = hAngle;
  current.handRotator = hrAngle;
}

// Sets the coordinates from the moveAlgorithm instruction as the current coordinates. Used to keep
// track of the hands current coordinate.
void MyRobot::setCurrentCoordinate(int _x, int _y, int _z){
  currentCoordinate.x = _x;
  currentCoordinate.y = _y;
  currentCoordinate.z = _z;
}



/*************************************************************/
/* Functions used to send information to GUI via instruction */
/*************************************************************/

// Sends the arms current potpins locations 
void MyRobot::sendPins(){
  String instruction = "pins "; // have to initialize string otherwise will cause unexpected behavior 
  instruction = instruction+bodyPin+" "+shoulderPin+" "+elbowPin+" "+wristPin+" "+handPin+" "+handRotatorPin;
  sendInstruction(instruction);
}

// Sends the arms current angle positions
void MyRobot::sendCurrentPosition(){
  String instruction = "currentPosition "; // have to initialize string otherwise will cause unexpected behavior 
  instruction = instruction+current.body+" "+current.shoulder+" "+current.elbow+" "+current.wrist+" "+current.hand+" "+current.handRotator;
  sendInstruction(instruction);
}

// Sends the arms home angle positions
void MyRobot::sendHomePosition(){
  String instruction = "homePosition "; // have to initialize string otherwise will cause unexpected behavior 
  instruction = instruction+home.body+" "+home.shoulder+" "+home.elbow+" "+home.wrist+" "+home.hand+" "+home.handRotator;
  sendInstruction(instruction);
}

// Sends current coordinate of arms hand
void MyRobot::sendCurrentCoordinate(){
  String instruction = "currentCoordinate "; // have to initialize string otherwise will cause unexpected behavior 
  instruction = instruction + currentCoordinate.x+" "+currentCoordinate.y+" "+currentCoordinate.z;
  sendInstruction(instruction);
}

// Sends an instruction to the GUI. Delay is required so instructions don't overalp
void MyRobot::sendInstruction(String instruction){
  Serial.println(instruction);
  delay(100);
}



/************************************************/
/* Functions that execute instructions from GUI */
/************************************************/

// Allows for user to set pins of each servo in Arduino program
void MyRobot::setPins(int bPin, int sPin, int ePin, int wPin, int hPin, int hrPin){
  bodyPin        = bPin;
  shoulderPin    = sPin;
  elbowPin       = ePin;
  wristPin       = wPin;
  handPin        = hPin;
  handRotatorPin = hrPin;

  body.attach(bodyPin);
  shoulder.attach(shoulderPin);
  elbow.attach(elbowPin);
  wrist.attach(wristPin);
  hand.attach(handPin);
  handRotator.attach(handRotatorPin);
}

// Allows user to set a saved position, callled the Home Position, so they can easily
// move their arm to that position by clicking a button on the GUI. 
void MyRobot::setHomePosition(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
  home.body        = bAngle;
  home.shoulder    = sAngle;
  home.elbow       = eAngle;
  home.wrist       = wAngle;
  home.hand        = hAngle;
  home.handRotator = hrAngle;
}

// Moves arm so that it is in the home position
void MyRobot::toHomePosition(){
  moveAngles(home.body, home.shoulder, home.elbow, home.wrist, home.hand, home.handRotator);
}

// Moves arm to the specified angles measures in the parameters. Sets the current position and
// coordinate as well. 
void MyRobot::moveAngles(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
  moveServo(body, bAngle);
  moveServo(shoulder, sAngle);
  moveServo(elbow, eAngle);
  moveServo(wrist, wAngle);
  moveServo(hand, hAngle);
  moveServo(handRotator, hrAngle);

  setCurrentPosition(bAngle, sAngle, eAngle, wAngle, hAngle, hrAngle);
  //coordinateLocation(bAngle, sAngle, eAngle, wAngle, hAngle, hrAngle);
}

// Moves arm's hand to a specified 3D coordinate 
void MyRobot::moveAlgorithm(int x, int y, int z){
  setCurrentCoordinate(x, y, z);
  //testMoveAlgorithm();
}




