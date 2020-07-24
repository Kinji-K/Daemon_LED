import processing.serial.*;

int interval = 1000;  // interval taime for serial write (ms)
int lastTime;   // resister for serial write last time
PFont font;  // font variable

Serial port;  //serial port variable
String[] Filepath;

void setup(){
  
  // provide window
  size(500, 150);
  frameRate(10);
  
  // prepare font
  font = loadFont("NotoMono-32.vlw");
  
  // window setting
  fill(255);
  textFont(font, 16);
  
  // Filepath inport
  Filepath = loadStrings("Filepath");
  
  // Line for check Serial port
  // printArray(Serial.list()); 
  String arduinoPort = Serial.list()[32];
  port = new Serial(this, arduinoPort, 9600);
  
  //initial set last time
  lastTime = millis() - interval;
}

void draw(){
  
  if (lastTime+interval-millis()<0){
    try{
      
      // read file
      String[] lines = loadStrings(String.join("",Filepath));
    
      // initialize i and serial data
      int i = 0;
      int serialdata = 0;
      
      for (String line: lines){
        String[] application = line.split(" ",2);
    
        // Application Name write on window
        textAlign(CENTER, BOTTOM);
        fill(0);
        text(application[0],50+100*i,100);
      
        // Application software LED
        colorMode(RGB,256);
        fill(255, 255*int(application[1]),255*int(application[1]));  // application[1]=0:White, application[1]=1:Red
        ellipse(50+100*i,50,50,50);
      
        // setup serial data
        serialdata = serialdata + (int)Math.pow(2, i)*(1-int(application[1]));
           
        i = i +1;
       }
    
    // Serial write
    port.write (serialdata);
    
    // write seral data on window
    textAlign(CENTER, BOTTOM);
    fill(0);
    text(serialdata,250,20);
  
    // read serial data and write on console 
    if (port.available()>0){
      int inByte = port.read();
      printArray(inByte);
    }
  } catch (NullPointerException e){
    // when deamon_ck is preparing, no action.
  }
  
  // update last time
  lastTime = millis();
  }
}
