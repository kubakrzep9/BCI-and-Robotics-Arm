# Brain Control Interface and Robotics Project- Robotic Arm 

This program is a University of Illinois in Chicago (UIC), Engineering in Medicine and Biology Society (EMBS) project. The goal of this project is to be able to control a robotic arm via headset communications. The headset has a set of electrodes that read the wearers brainwaves, where eventually they will control the arm just through thought.

This program is used to control the robotic arm using a GUI. The GUI interfaces the arm through serial communication to an Arduino, where instructions are passed back and forth. So far the user is able to move the arm by specifying each servo angle measure, but eventually the program will feature an algorithm that will allow the user to simply enter an (x,y,z) coordinate, to where the hand of the arm will travel to.

The GUI has a series of screens and menus, all of which are documented in the _Photos directory. From the Main Menu the user can traverse to the Display Screen, Move Menu or Options Menu. The Display Screen displays all relevant information of the arm: current positions, home position, potpin connections, current coordinate position, and port.

The Move Menu allows the user to move the arm by entering the Algorithm Screen, the Angles Screen or by pressing the tohome button. From the Algorithm Screen the user would input an (x,y,z) coordinate to where the hand of the arm would travel to (algorithm still a work in progress). From the Angles Screen the user would input each servo angle measure for the arm to move to. By clicking the tohome button, the user would move the arm to it's home position. The home position is set to a default position, but can be customized from the Options Menu.

The Options Menu allows the user to specify their port connection, potpin connections and home position throught the Port, Potpins and Home Screens. The Port Screen displays a list of available ports the user can connect to. The Potpins Screen allows the user to enter a specific potpin for each servo. The Home Screen allows the user to enter specific angle measures for each servo for the home position.  

This project is very much still a work in progress, we had started August 2018. The first semester was really a learning proceses, trying to figure out how all of our equipment worked. I had no previous knowledge of Arduino or how to connect the hardware. We have come a long way, but there still much for us to accomplish. I am excited to see what we can do as a team and what I can learn along the way.
