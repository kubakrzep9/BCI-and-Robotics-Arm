// The DisplayFunctions class is used by the GUISettings class to format and display text onto the GUI


class DisplayFunctions{
 
  // Used to print a row of integers starting at a specific coordinate each seperated by an offset
  public void displayRow(int arr[], int xCoord, int yCoord, int offset){
    int size = arr.length;
    for(int i=0; i< size; i++){
      setMyText(arr[i], xCoord+(i*offset), yCoord, LEFT, fonts.get(2));
    }    
  }
  

  // Used to print a row of strings starting at a specific coordinate each seperated by an offset
  public void displayRow(String arr[], int xCoord, int yCoord, int offset){
    int size = arr.length;
    for(int i=0; i< size; i++){
      setMyText(arr[i], xCoord+(i*offset), yCoord, LEFT, fonts.get(2));
    }    
  }
  
  
  // Used to print a column of integers starting at a specific coordinate each seperated by an offset
  public void displayColumn(int arr[], int xCoord, int yCoord, int offset){
    int size = arr.length;
    for(int i=0; i< size; i++){
      setMyText(arr[i], xCoord, yCoord+(i*offset), LEFT, fonts.get(2));
    }    
  }

  // Used to print a column of strings starting at a specific coordinate each seperated by an offset
  public void displayColumn(String arr[], int xCoord, int yCoord, int offset){
    int size = arr.length;
    for(int i=0; i< size; i++){
      setMyText(arr[i], xCoord, yCoord+(i*offset), LEFT, fonts.get(2));
    }    
  }
  
  // Used to format the font and alignment of a string as text 
  public void setMyText(String text, int xcoord, int ycoord, int alignment, PFont f){
    textFont(f);
    textAlign(alignment);
    text(text, xcoord, ycoord);   
  }
  
  // Used to format the font and alignment of an integer as text
  public void setMyText(int num, int xcoord, int ycoord, int alignment, PFont f){
    textFont(f);
    textAlign(alignment);
    text(num, xcoord, ycoord);  
  }
 
  // Used to format integer data to be displayed on the GUI
  public String[] formatIntData(int arr[]){
    int size = arr.length;
    String str[] = new String[size];
    
    for(int i=0; i<size; i++){ str[i] = "[ " + arr[i] + " ]"; }
    return str;
  }
  
}
