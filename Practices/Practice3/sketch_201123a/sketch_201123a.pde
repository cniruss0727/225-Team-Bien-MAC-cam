import ddf.minim.*;


boolean playBGM=false;

AudioPlayer ScotlandTheBrave;
Minim minim;


void setup(){
  size(500,500);
  minim=new Minim(this);
  ScotlandTheBrave = minim.loadFile("scotland the brave.mp3");
   ScotlandTheBrave.play();
}


void draw(){

  
  }
  
void mousePressed(){
  
  if(ScotlandTheBrave.isPlaying()){
    ScotlandTheBrave.pause();
  }else {
    ScotlandTheBrave.play();
  }
}
