// Incluímos la librería para poder controlar el servo
#include <Servo.h>
#include <Adafruit_MotorShield.h>

// Declaramos la variable para controlar el servo
Servo servoMotor;

int valorInicial = 90;

int randomRotacion1 = 0;
int valorTope1 =130;
int valorTope2 =50;
int in1 = 7;

void setup() {

  Serial.begin(9600); 

  pinMode(in1, OUTPUT);
  digitalWrite(in1, HIGH);

  //declaramos pin para el servo
  // el cable marron es ground
  
  servoMotor.attach(9);

  // Inicializamos al ángulo 0 el servomotor
  servoMotor.write(valorInicial);
  
}
void loop() {


  delay(2000);
  Serial.println(randomRotacion1);
  mueveAspersor();


}

void mueveAspersor()
{
  
  randomRotacion1 = random(valorTope2,valorTope1);
  servoMotor.write(randomRotacion1);

  
}
