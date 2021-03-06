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
int impulsoNecesario = 50;

// tiempo encendido el motor
int tiempo1Asp = 3;
int tiempo2Asp = 3;

String TwittActual1="";
String TwittActual2="";

Timer timerTwit01;
Timer timerTwit02;


ConfigurationBuilder  cb;

void setup() {
  
  background(64,64,64);
  smooth();
  
  size(1180, 960);
  
  
  // UI ////////////////
  
  cp5 = new ControlP5(this);
  
  cp5.addSlider("ntweets1")
   .setPosition(720,30)
   .setSize(200,20)
   .setRange(1,200)
   .setValue(100)
   .setLabel("Numero de Tweets")
   ;
  
   cp5.addToggle("toggle")
     .setPosition(950,30)
     .setSize(50,20)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setLabel("Com Arduino")
     ;
      

  
 // aspersor 01
  myTextlabelA = cp5.addTextlabel("label").setText("Aspersor 01").setPosition(700,130).setColorValue(0xffb9fdff)
                    .setFont(createFont("Arial",12));
  
  
cp5.addBang("Expulsar1").setPosition(720, 165).setSize(37, 37)
   .setLabel("Expulsar")
   ;
  

 cp5.addSlider("tope11").setPosition(800,165).setSize(150,20).setRange(180,90).setValue(90)
 .setLabel("Tope 1 rotacion 180 / 90")
 ;
 
  cp5.addSlider("tope12").setPosition(800,200).setSize(150,20).setRange(90,0).setValue(0)
 .setLabel("Tope 2 rotacion 90 / 0")
 ;
 
  cp5.getController("ntweets1").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("ntweets1").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
    
  

 // aspersor 02
                      
  myTextlabelB = cp5.addTextlabel("label").setText("Aspersor 02").setPosition(700,280)
                    .setColorValue(0xffb9fdff)
                    .setFont(createFont("Arial",12))
                    ;
                    
 cp5.addBang("Expulsar2").setPosition(720, 325).setSize(37, 37)
   .setLabel("Expulsar")
   ;
  

 cp5.addSlider("tope21").setPosition(800,325).setSize(150,20).setRange(180,90).setValue(180)
 .setLabel("Tope 1 rotacion 180 / 90")
 ;
 
  cp5.addSlider("tope22").setPosition(800,360).setSize(150,20).setRange(90,0).setValue(0)
 .setLabel("Tope 2 rotacion 90 / 0")
 ;
     
  // UI ////////////////                   
  
  f = createFont("DroidSans",12,true);
  hashtag1="happy";
  hashtag2="mad";
  //impulsoNecesario =1;
  
  //segundos encendidos el motor
  timerTwit01 = new Timer(tiempo1Asp);
  timerTwit02 = new Timer(tiempo2Asp);
  
  
  
  //timerTwit01.start();
  println(Serial.list());
   
  //  initialize your serial port and set the baud rate to 9600
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n'); 
  
  cb = new ConfigurationBuilder();  

  cb.setOAuthConsumerKey("xx");
  cb.setOAuthConsumerSecret("xxx");
  
  cb.setOAuthAccessToken("xx-xx");
  cb.setOAuthAccessTokenSecret("xxx");

  StatusListener listener = new StatusListener() {
      
 
      @Override
        public void onScrubGeo(long userId, long upToStatusId) {
        System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  
      }
   
      @Override
        public void onStallWarning(StallWarning warning) {
        System.out.println("Got stall warning:" + warning);

      }
    
      //Imprimimos tweets
      public void onStatus(Status status) {
        
        
                
        String[] m1 = match(status.getText(), hashtag1);
        
        
        if (m1 != null) {
              
              //println(hashtag1);
              
              mencionesHashtag1 = mencionesHashtag1+1;
              impulsoCoche01 = impulsoCoche01+1;
              
              // ojo la variable activo desactiva el envio al puerto de serie para comunicar con Arduino
              if(impulsoCoche01 > impulsoNecesario && activo) {
                
                myPort.write('1');
                timerTwit01.start();
                impulsoCoche01 =0;
                
              }
              
              
              m1 = null;
              
              TwittActual1 = status.getText();
              TwittActual2="";
              
              
        }
        
        String[] m2 = match(status.getText(), hashtag2);
        
        if (m2 != null && activo) {
          
              //println(hashtag2);
              
              mencionesHashtag2 = mencionesHashtag2+1;
              impulsoCoche02 = impulsoCoche02+1;
              
              if(impulsoCoche02 > impulsoNecesario && activo) {
                
                myPort.write('2');
                timerTwit02.start();
                impulsoCoche02 =0;
               
              }
              m2 = null;
              

              TwittActual2 = status.getText();
              TwittActual1="";
              
        }
        
        
      }
      
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
      public void onException(Exception ex) {
        ex.printStackTrace();
        
        
      }
        
  
      

  };
  
  TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
  twitterStream.addListener(listener);
 
 // aqui recogemos el hashtag
  String keywords[] = {
    hashtag1,
    hashtag2
    //"#worldracecup"
  };
 
  FilterQuery fq = new FilterQuery(); 
  fq.track(keywords); 
  twitterStream.filter(fq);
  
  

}


void draw() {
    
 
  
    background(64,64,64);
    
    
    
    fill(50);
    rect(650, 0, width/2, height);  
    
  // UI ////////////////  
    myTextlabelA.draw(this); 
    
    //led on off comunicación
    pushMatrix();
    translate(1020,40);
    stroke(50);
    fill(col);
    ellipse(0,0,20,20);
    popMatrix();
    
    textFont(f);
    fill(255,255,255); 
    
    
    // Equipo 01
     
    text("Hashtag equipo 1: "+hashtag1,15,25);
    text("Número menciones: "+mencionesHashtag1,15,47); //22
    text("Disparos: "+impulsoCoche01,15,69);
    
    text("Twitt actual:",15,107);
    text(TwittActual1,15,129,260,250);
   
    
    // Equipo 02
    
    text("Hashtag equipo 2: "+hashtag2,315,25);
    text("Número menciones: "+mencionesHashtag2,315,47); //22
    text("Disparos: "+impulsoCoche02,315,69);
    
    text("Twitt actual:",315,107);
    text(TwittActual2,315,129,260,250);
    
  // UI ////////////////  


    //hacemos correr coche

    if(timerTwit01.running) {
      
      noPara1 = true;
      timerTwit01.work();
      
      //println("Running");
      
    }
    
    
    if(!timerTwit01.running && noPara1) {
      myPort.write('3');
      println("Para1");
      noPara1 = false;
    }
 

    if(timerTwit02.running) {
      
      noPara2 = true;
      timerTwit02.work();
 
      
      //println("Running");
      
    }
    
    
    if(!timerTwit02.running && noPara2) {
      myPort.write('4');
      println("Para2");
       noPara2 = false;
    }

 
     //myPort.write('0');
}


void Expulsar1(int theN) {
  
  myPort.write('1');
  timerTwit01.start();
  impulsoCoche01 =0; 

}

void Expulsar2(int theN) {

  myPort.write('2');
  timerTwit02.start();
  impulsoCoche02 =0; 

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


void ntweets1(float elnumero1) {
  
  impulsoNecesario = int(elnumero1); //myColor = color(theColor);
  println("Numero de tweets necesarios para expulsar "+elnumero1);
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
