// Incluímos la librería para poder controlar el servo
#include <Servo.h>

//aspersor 01
int motorPinA = 7; //Motor

//aspersor 02
int motorPinB = 8; //Motor

char val;
int dato=0;

//servos
 Servo servoMotor1;
 Servo servoMotor2;

int valorInicial1 = 90;
int valorInicial2 = 90;

int randomRotacion1 = 0;
int randomRotacion2 = 0;

//valores definir rotacion servo
int valorTope12 =30;
int valorTope11 =150;

int valorTope22 =60;
int valorTope21 =130;

//tiempo que esta el motor expulsando pintura en milisegundos
int milisexpulsado =300;

// control dinamico tiempo
String elvalor = "";
String val2;


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

 
}




void loop() {
  

     //Spins the motor on Channel A at full speed 255 full
       //Spins the motor on Channel B at full speed 255 full
  
    if (Serial.available() > 0) { // If data is available to read
        
        val = Serial.read(); 


        //elvalor = Serial.readString();
        //milisexpulsado = elvalor.toInt();
        //elvalor = Serial.parseInt(); 

        //ajustar tiempo de ejeccion
        
         
         //valorTope11 = numeroElValor.toInt();


            
        // inicio secuencia aspersor 1
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

 
        
    }


//  milisexpulsado = elvalor;
  
}

void rotaAspersor1()
{

  //rotacion para aspersor 1
  randomRotacion1 = random(valorTope12,valorTope11);
  servoMotor1.write(randomRotacion1);

  //milisexpulsado=elvalor;
  //if(elvalor>10) milisexpulsado=elvalor;
  delay(milisexpulsado);
  //apaga motor
  digitalWrite(motorPinA, HIGH); 

  
}

void rotaAspersor2()
{

  //rotacion para aspersor 2
  randomRotacion2 = random(valorTope22,valorTope21);
  servoMotor2.write(randomRotacion2);

  //if(elvalor>10) milisexpulsado=elvalor;
  delay(milisexpulsado);
  //apaga motor
  digitalWrite(motorPinB, HIGH); 
  
}



