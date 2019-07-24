// WORK IN PROGRESS
// Will probably use an algorithm found online called the FABRIK algorithm. That algorithm uses
// forward and inverse kinematics to calculate the hands current coordinate position and to calculate
// the necessary angle measures to move the hand to a desired target coordinate.


#ifndef MOVEALG_H
#define MOVEALG_H


#include <Servo.h>
#include <Arduino.h>
#include <stdlib.h>

class MoveAlgorithm{
    public:
        void testMoveAlgorithm();
        void calculateAngles(int, int, int);
        void calculateCoordinate(int, int, int, int, int, int);

        void coordinateLocation(int, int, int, int, int, int);
        void quadrant(int, int, int, int, int, int);
        void nonquadrant(int, int, int, int, int, int);
        
};

#endif