// The ConnThread class is used to send instruction on a seperate thread so that the main 
// thread can continue listening for instructions being sent from the Arduino. 

class ConnThread extends Thread{

  Serial port;
  String instruction;
  String instructions[];
  Boolean success;
  Boolean multipleInstructions;
  
  // Constructor for single instruction
  ConnThread(String instruction, Serial port){
    this.instruction     = instruction;
    this.port            = port;
    success              = true; 
    multipleInstructions = false;
  }
  
  // Constructor for multiple instructions
  ConnThread(String instructions[], Serial port){
    this.instructions    = instructions;
    this.port            = port;
    success              = true; 
    multipleInstructions = true;
  }
  
  // Runnable used to send instructions to Arduino 
  public void run(){
    if(multipleInstructions){
      for(String str : instructions){
        try{ port.write(str); }
        catch( Exception e){ 
          println("Unable to write to port: ", portConnection); 
          success = false;  
        }
        delay(1100);
      }
    }else{
      try{ port.write(instruction); }
      catch( Exception e){ 
        println("Unable to write to port: ", portConnection); 
        success = false;  
      }  
    }
  } 
  
}
