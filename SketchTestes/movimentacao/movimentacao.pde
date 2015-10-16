import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

boolean[] direcoes = new boolean[4];
int[] angulo = new int[2]; //x, y

void setup() {
    println(Arduino.list()); 
    arduino = new Arduino(this, Arduino.list()[5], 57600);
    arduino.pinMode(4, Arduino.SERVO);
    arduino.pinMode(7, Arduino.SERVO);
}

void draw() {
    atualizaServo();
    arduino.servoWrite(4, angulo[0]);


    arduino.servoWrite(7, angulo[1]);

    println(angulo[0]);
}


void atualizaServo(){
     int x = 0;
     int y = 0;
    if(direcoes[0])x++;
    if(direcoes[1])x--;
    if(direcoes[2])y++;    
    if(direcoes[3])y--; 
    angulo[0] +=x;
    angulo[1] +=y;
    if(angulo[0]<0) angulo[0] = 0;
    if(angulo[0]>180) angulo[0] = 180;
    if(angulo[1]<0) angulo[1] = 0;
    if(angulo[1]>180) angulo[1] = 180;
    

    
}


void keyPressed() {
    
  if(key == 'd'){
      direcoes[0] = true;
  }
  if(key == 'a'){
      direcoes[1] = true;
  }
  if(key == 'w'){
      direcoes[2] = true;
  }
  if(key == 's'){
      direcoes[3] = true;
  }
}


void keyReleased() {
    
  if(key == 'd'){
      direcoes[0] = false;
  }
  if(key == 'a'){
      direcoes[1] = false;
  }
  if(key == 'w'){
      direcoes[2] = false;
  }
  if(key == 's'){
      direcoes[3] = false;
  }
}
