class Timer{

  int elapsed=0; 
  int start;
  
  int limit;
  Boolean running = false;
  Boolean reinicia = false;

 
  Timer(int limit)  {
    this.limit = limit;
  }
 
  void reset()  {
    start = millis()/1000;
    elapsed=1;
    reinicia=true;
    
  }
 
  void start()  {
    reset();
    running = true;

   
  }
 
  void stop()  {
    running = false;
    
  }
 
  Boolean work()  {
    
    if(running) {
      reinicia =false;
      elapsed = 1+(millis()/1000) - start;
    }
    
    if(elapsed >= limit) {
      
      // cuando llega al limite fijado podemos para:
      stop();
      
      //o podemos reiniciar
     
      //reset();
      
      return true;
    }
    else {
    
      return false;
     
    }
  }
 
}
