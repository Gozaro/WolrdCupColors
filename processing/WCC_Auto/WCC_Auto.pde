//Version 2.1
import processing.serial.*; //import the Serial library


// importamos librerias 
import processing.serial.*; //import the Serial library

import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;
import controlP5.*;



// UI 
ControlP5 cp5;
Textlabel myTextlabelA;
Textlabel myTextlabelB;

String elangulo;
String valorAspersor;
String elvalorqueva;

int col = color(0,170,255);

// FIN variables UI


Serial myPort;  //the Serial port object
String val;

Boolean noPara1=false;
Boolean noPara2=false;

Boolean activo= true;

PFont f;

String hashtag1;
String hashtag2;


int mencionesHashtag1=0;
int mencionesHashtag2=0;

int impulsoCoche01=0;
int impulsoCoche02=0;


// tiempo encendido el motor
int tiempo1Asp = 3;
int tiempo2Asp = 3;

String TwittActual1="";
String TwittActual2="";

Timer timerTwit01;
Timer timerTwit02;


ConfigurationBuilder  cb;

// auto pilot
int random01 = 0;
int random02 = 0;

void setup() {
  
  background(64,64,64);
  smooth();
  
  size(800, 600);
  
  
  // UI ////////////////
  
  cp5 = new ControlP5(this);
  

  
   cp5.addToggle("toggle")
     .setPosition(100,30)
     .setSize(50,20)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setLabel("Auto")
     ;
      

  
 // aspersor 01
  myTextlabelA = cp5.addTextlabel("label").setText("Aspersor 01").setPosition(100,130).setColorValue(0xffb9fdff)
                    .setFont(createFont("Arial",12));
  
  
cp5.addBang("Expulsar1").setPosition(100, 165).setSize(37, 37)
   .setLabel("Expulsar")
   ;
  
cp5.addBang("Detener1").setPosition(180, 165).setSize(37, 37)
   .setLabel("Detener")
   ;
   
 cp5.addSlider("tope11").setPosition(300,165).setSize(150,20).setRange(180,90).setValue(90)
 .setLabel("Tope 1 rotacion 180 / 90")
 ;
 
  cp5.addSlider("tope12").setPosition(300,200).setSize(150,20).setRange(90,0).setValue(0)
 .setLabel("Tope 2 rotacion 90 / 0")
 ;
 


 // aspersor 02
                      
  myTextlabelB = cp5.addTextlabel("label").setText("Aspersor 02").setPosition(100,280)
                    .setColorValue(0xffb9fdff)
                    .setFont(createFont("Arial",12))
                    ;
                    
 cp5.addBang("Expulsar2").setPosition(100, 325).setSize(37, 37)
   .setLabel("Expulsar")
   ;
 
  cp5.addBang("Detener2").setPosition(180, 325).setSize(37, 37)
   .setLabel("Detener")
   ;

 cp5.addSlider("tope21").setPosition(300,325).setSize(150,20).setRange(180,90).setValue(180)
 .setLabel("Tope 1 rotacion 180 / 90")
 ;
 
  cp5.addSlider("tope22").setPosition(300,360).setSize(150,20).setRange(90,0).setValue(0)
 .setLabel("Tope 2 rotacion 90 / 0")
 ;
     
  // UI ////////////////                   
  


  
  
  
  //timerTwit01.start();
  println(Serial.list());
   
  //  lista puerto de serie - initialize your serial port and set the baud rate to 9600
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n'); 
  
  
    //segundos encendidos el motor
  timerTwit01 = new Timer(tiempo1Asp);
  timerTwit02 = new Timer(tiempo2Asp);
  
}

void draw() {
    
    background(50);
    

    
  // UI ////////////////  
    myTextlabelA.draw(this); 
    
    //led on off comunicación
    pushMatrix();
    translate(180,40);
    stroke(50);
    fill(col);
    ellipse(0,0,20,20);
    popMatrix();

    fill(255,255,255); 
    
    //piloto automa
    
     // auto 01
    random01 = int(random(0,300));
    
    if(random01 == 280 && !noPara1) {
      
      myPort.write('1'); myPort.write('1');
      timerTwit01.start();
      println(random01);
      noPara1 = true;
    }
    
    if(timerTwit01.running) {
      timerTwit01.work();
    }
    
    if(!timerTwit01.running && noPara1) {
      myPort.write('3');
      println("Para1");
      noPara1 = false;
    }
    
    // auto 02
    random02 = int(random(0,300));
    
    if(random02 == 220 && !noPara2) {
      
      myPort.write('2'); myPort.write('2');
      timerTwit02.start();
      println(random02);
      noPara2 = true;
    }
    
    if(timerTwit02.running) {
      timerTwit02.work();
    }
    
    if(!timerTwit02.running && noPara2) {
      myPort.write('4');
      println("Para2");
      noPara2 = false;
    }
    




}


void Expulsar1(int theN) {
  myPort.write('1');
}

void Expulsar2(int theN) {
  myPort.write('2');
}

void Detener1(int theN) {
  myPort.write('3');
}

void Detener2(int theN) {
  myPort.write('4');
}


void tope11(int vall11) {
 
  elangulo = str(vall11);
  valorAspersor = "11";
  elvalorqueva = valorAspersor+elangulo;
  myPort.write(elvalorqueva);
  myPort.write("");
    
  println(elvalorqueva);

}

void tope12(int vall12) {
 
  elangulo = str(vall12);
  valorAspersor = "12";
  elvalorqueva = valorAspersor+elangulo;
  myPort.write(elvalorqueva);
  myPort.write("");
    
  println(elvalorqueva);

}




void toggle(boolean theFlag) {
  
  if(theFlag==true) {
    col = color(0,170,255);
    activo = true;
  } else {
    col = color(0,45,90);
    activo = false;
    
  }

}



void keyPressed() {
  
  //myPort.write('1');
  
  if(key == '1')
    myPort.write('1');
  
  if(key == '2')
    myPort.write('2');

  if(key == '3')
    myPort.write('3');


  if(key == '4')
    myPort.write('4');


  if(key == '0')
    myPort.write('0');
  
  
}
