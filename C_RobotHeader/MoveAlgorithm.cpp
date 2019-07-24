#include "MoveAlgorithm.h"

void MoveAlgorithm::testMoveAlgorithm(){
    Serial.println("Testing move algorithm");
}

void MoveAlgorithm::calculateAngles(int x, int y, int z ){
    int bodyAngle = 0;
}

void MoveAlgorithm::calculateCoordinate(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
    //Checking to see if the arm is perfectly straight 
    if(eAngle == 90){ Serial.println("forearm is on same plane as upper arm"); }
    

    //Shoulder region 1
    if(sAngle >= 0 && sAngle < 90){
        if(sAngle == 0){
            if(eAngle == 90){ Serial.println("forearm is parallel to xy-plane [+distance]"); }
        }
        //Elbow region 1
        if(eAngle >= 0 && eAngle < 90){ 
            if(sAngle == eAngle){ Serial.println("forearm is parallel to z-axis [+height]"); } //forearm vertical 
            else if(eAngle - sAngle < 0){ Serial.println("forearm [+height -distance]"); }
            else if(eAngle - sAngle > 0){ Serial.println("forearm [+height +distance]"); }
        }
        //Elbow region 2
        else if(eAngle > 90 && eAngle <= 180){
            if(eAngle - sAngle == 90){ Serial.println("forearm is parallel to xy-plane [+distance]"); } //forearm horizontal
            else if(eAngle - sAngle > 90){ Serial.println("forearm [-height +distance]"); }
            else if(eAngle - sAngle < 90){ Serial.println("forearm [+height +distance]"); }
        }






    //Shoulder region 2
    }else if(sAngle > 90 && sAngle <= 180){
        if(sAngle == 180){
            if(eAngle == 90){ Serial.println("forearm is parallel to xy-plane [+distance]"); }
        }
        if(sAngle == eAngle){ Serial.println("forearm is parallel to z-axis [+height]"); }
        if(eAngle > 0 && eAngle < 90){
            if(sAngle - eAngle == 90){ Serial.println("forearm is parallel to xy-plane"); }
            else if(sAngle - eAngle == 90){ Serial.println("forearm is parallel to xy-plane"); } 
        }
        else if(eAngle > 90 && eAngle < 180){
          
        }        
    //Shoulder edge case, elbow cannot decrease height 
    }else if(sAngle == 90){

    }
}

void MoveAlgorithm::coordinateLocation(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
    quadrant(bAngle, sAngle, eAngle, wAngle, hAngle, hrAngle);
    nonquadrant(bAngle, sAngle, eAngle, wAngle, hAngle, hrAngle);
    calculateCoordinate(bAngle, sAngle, eAngle, wAngle, hAngle, hrAngle);
}


void MoveAlgorithm::quadrant(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
    //Q1 or Q3
    if(bAngle > 0 && bAngle < 90){
        if(sAngle > 0 && sAngle < 90){ Serial.println("Q1"); }
        else if (sAngle > 90 && sAngle < 180){ Serial.println("Q3"); }
    }

    //Q2 or Q4
    else if(bAngle > 90 && bAngle < 180){
        if(sAngle > 0 && sAngle < 90){ Serial.println("Q2"); }
        else if (sAngle > 90 && sAngle < 180){ Serial.println("Q4"); }
    }
    
    //Not exactly in one quadrant
    //else{ Serial.println("Could not figure out quadrant"); }
}


void MoveAlgorithm::nonquadrant(int bAngle, int sAngle, int eAngle, int wAngle, int hAngle, int hrAngle){
    //Vertical on z-axis
    if(sAngle == 90 && eAngle == 90){ Serial.println("Vertical on z-axis"); }
    
    //Right half (Q1 or Q4) or left half (Q2 or Q3)
    else if(bAngle == 0){
        if(sAngle >= 0 && sAngle < 90){ Serial.println("right half"); }
        else if(sAngle > 90 && sAngle <= 180){ Serial.println("left half"); }    
    }

    //Upper half (Q1 or Q2) or lower half (Q3 or Q4)
    else if(bAngle == 90){
        if(sAngle > 0 && sAngle < 90){ Serial.println("upper half"); }
        else if(sAngle > 90 && sAngle < 180){ Serial.println("lower half"); }
    }

    //Right half (Q1 or Q4) or left half (Q2 or Q3)
    else if(bAngle == 180){
        if(sAngle >= 0 && sAngle < 90){ Serial.println("left half"); }
        else if(sAngle > 90 && sAngle <= 180){ Serial.println("right half"); }    
    }
}