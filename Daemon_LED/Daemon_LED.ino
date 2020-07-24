// Daemon Monitoring LED

// Setup each daemon led number
const int MONITOR = 13;
int led[5]={8,9,10,11,12};
// SSH = 5,X11VNC = 7,VPN = 10,APACHE = 11,SAMBA = 12

int i = 0;
char data;

void setup() {
  // put your setup code here, to run once:

  // Serial set
  Serial.begin(9600);

  // Setup Monitor pinmode
  pinMode(MONITOR, OUTPUT);
  
  // Setup Daemon pimode
  for (i=0;i<5;i++){
    pinMode(led[i], OUTPUT);
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  
  if (Serial.available()>0){
    // Monitor LED shall bright when serial data is available.
    digitalWrite(MONITOR, HIGH);

    data = Serial.read();
    Serial.print(data);

    // LED bright by byte data
    // received data is 0 - 31 (00000000 - 00011111)
    // 2^0 = SSH, 2^1 = X11VNC, 2^2 = VPN, 2^3 = APACHE, 2^4 = SAMBA

    for (i=0; i<5;i++){
      
      if (data/(pow(2,(4-i))) >= 1){
        digitalWrite(led[4-i], HIGH);
        data = data%(int)(pow(2,(4-i))+0.5);
      }
      else {
        digitalWrite(led[4-i], LOW);
      }
    }
      
  } 
  else {
    // Monitor LED shall not bright when serial data is not received.
    digitalWrite(MONITOR, LOW);
    for (i=0;i<5;i++){
      digitalWrite(led[i], LOW);
    }
  }
  delay (1100);
}
