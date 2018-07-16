// Incluímos la librería para poder controlar el servo
#include <Servo.h>

//aspersor 01
int motorPinA = 7; //Motor

//aspersor 02
int motorPinB = 8; //Motor

char val;


//servos
 Servo servoMotor1;
 Servo servoMotor2;

int valorInicial1 = 90;
int valorInicial2 = 90;

int randomRotacion1 = 0;
int randomRotacion2 = 0;

//valores definir rotacion servo
int valorTope12 =60;
int valorTope11 =120;

int valorTope22 =80;
int valorTope21 =130;

// control dinamico tiempo

int milisexpulsado;


//valores definir rotacion servo FIN


int in1 = 7;

//servos fin


void setup() {
 
 Serial.begin(9600);
 pinMode(LED_BUILTIN, OUTPUT);
  
 pinMode(motorPinA, OUTPUT);
 pinMode(motorPinB, OUTPUT);
  
 
 digitalWrite(motorPinA, LOW); //Establishes forward direction of Channel A
 digitalWrite(motorPinA, HIGH);   //Disengage the Brake for Channel A
 
 digitalWrite(motorPinB, LOW); //Establishes forward direction of Channel B
 digitalWrite(motorPinB, HIGH);   //Disengage the Brake for Channel B


 //servos

  pinMode(in1, OUTPUT);
  digitalWrite(in1, HIGH);

  //declaramos pin para el servo
  servoMotor1.attach(9);
  servoMotor2.attach(10);
  
  // Inicializamos al ángulo 0 el servomotor
  servoMotor1.write(valorInicial1);
  servoMotor2.write(valorInicial2);
  
//servos fin

  //tiempo default expulsa
  milisexpulsado = setupTiempoPinta(1000);
}




void loop() {
  

     //Spins the motor on Channel A at full speed 255 full
       //Spins the motor on Channel B at full speed 255 full
  
    if (Serial.available() > 0) { // If data is available to read
        
        val = Serial.read(); 

        int valorTiempo;
       
        if(val == '1')  {

         
         digitalWrite(motorPinA, LOW); 
         rotaAspersor1();
          
        } 

        // enciende motor 2
        if(val == '2')  {
         
         digitalWrite(motorPinB, LOW);
         rotaAspersor2(); 
           
        } 

        // apaga motor 1
        if(val == '3')  {
         digitalWrite(motorPinA, HIGH); 
        } 

         // apaga motor 2
        if(val == '4')  {
         digitalWrite(motorPinB, HIGH);  
        } 

         // Posicion aspersor 01 al centro
        if(val == '5')  {
          servoMotor1.write(valorInicial1);
        } 

         // Posicion aspersor 02 al centro
        if(val == '6')  {
          servoMotor2.write(valorInicial2);
        } 

        if(val == '7')  {
          digitalWrite(motorPinA, LOW); 
        } 

        if(val == '8')  {
          digitalWrite(motorPinB, LOW); 
        } 


  
         if(val == 'a')  {milisexpulsado = setupTiempoPinta(100);} 
         if(val == 'b')  {milisexpulsado = setupTiempoPinta(200);} 
         if(val == 'c')  {milisexpulsado = setupTiempoPinta(300);}  
         if(val == 'd')  {milisexpulsado = setupTiempoPinta(400);} 
         if(val == 'e')  {milisexpulsado = setupTiempoPinta(500);}  
         if(val == 'f')  {milisexpulsado = setupTiempoPinta(1000);} 
         if(val == 'g')  {milisexpulsado = setupTiempoPinta(1500);} 
         if(val == 'h')  {milisexpulsado = setupTiempoPinta(2000);}

        
    }  
}

int setupTiempoPinta(int tiempo)
{
    
    return  milisexpulsado = tiempo;

}

void rotaAspersor1()
{


  randomRotacion1 = random(valorTope12,valorTope11);
  servoMotor1.write(randomRotacion1);

  delay(milisexpulsado);
  //apaga motor
  digitalWrite(motorPinA, HIGH); 

 
  
}

void rotaAspersor2()
{


  randomRotacion2 = random(valorTope22,valorTope21);
  servoMotor2.write(randomRotacion2);

  delay(milisexpulsado);
  //apaga motor
  digitalWrite(motorPinB, HIGH); 

  
}




