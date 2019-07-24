// Written by: Jakub Krzeptowski-Mucha
//
// The MyRobot class is used to model the physical robotic arm. The class keeps track of 
// relevant information such as the potpin connections, current servo angle measure, current
// coordinate, etc. The class also provides the ability to move the arm by inputting each angle
// measure and eventually inputting a coordinate. The class also has the ability to send relevant
// information requested using 'instructions' and serial communication. 


#ifndef ROBOT_H
#define ROBOT_H

#include <Servo.h>
#include <Arduino.h>
#include <stdlib.h>

#include "MoveAlgorithm.h"


struct position{
  int body = 0;
  int shoulder = 0;
  int elbow = 0;
  int wrist = 0;
  int hand = 0;
  int handRotator = 0;
};

struct coordinate{
  int x = 3;
  int y = 6;
  int z = 9;
};


class MyRobot : public MoveAlgorithm{

public:
  //Arm servo variables
  Servo body;
  Servo shoulder;
  Servo elbow;
  Servo wrist;
  Servo hand;
  Servo handRotator;

  int bodyPin;
  int shoulderPin;
  int elbowPin;
  int wristPin;
  int handPin;
  int handRotatorPin;
  

  position home;
  position current;
  coordinate currentCoordinate;
  static const int baudRate = 9600;    

  //Called in setup and loop of Arduino program
  void setUp();
  void setUp(int, int, int, int, int, int);

  //Functions to send instructions to GUI
  void sendPins();
  void sendCurrentPosition();
  void sendHomePosition();
  void sendCurrentCoordinate();

  //Setting functions 
  void setPins(int, int, int, int, int, int);
  void setHomePosition(int, int, int, int, int, int);
  void setCurrentPosition(int, int, int, int, int, int);
  void setCurrentCoordinate(int, int, int);

  //Functions that execute instructions sent from GUI
  void toHomePosition();
  void moveAngles(int, int, int, int, int, int);
  void moveAlgorithm(int, int, int);

  //Servo Functions
  void moveServo(Servo, int);


private:  
  //Setup Functions
  void setPins();
  void initialPosition();
  void sendInstruction(String);
};

#endif



