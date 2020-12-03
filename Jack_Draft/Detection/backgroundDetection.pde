import processing.video.*;


int pixelsNum;
Capture video;
PImage Background;
int [] bgPixel;
int [] backupP;
boolean state = false;
int threshold = 50;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();
  pixelsNum = video.width * video.height;
  bgPixel = new int[pixelsNum];
  backupP = new int[pixelsNum];
  loadPixels();
}

void draw() { 
  if(video.available()) {
    video.read();
    video.loadPixels();
  
  for(int i = 0; i< pixelsNum; i++) {
     color curcolor = video.pixels[i];
     color bgcolor = bgPixel[i];
     float r1 = red(curcolor);
     float g1 = green(curcolor);
     float b1 = blue(curcolor);
     
     float r2 = red(bgcolor);
     float g2 = green(bgcolor);
     float b2 = blue(bgcolor);
     
     float d = dist(r1, b1, g1, r2, g2, b2);
     //if(state == true) {
       //when x is pressed once
     if(d < threshold) {
       pixels[i] = color(0,0,0);
     } else {
       pixels[i] = curcolor;
     }
    //}
     //else {
       //for(int a = 0; a< pixelsNum; a++) {
         //pixels[a] = backupP[a];
         
       //}
      
      
      
    }
    updatePixels();
  
  
  //}
//}
}
}

void keyPressed() {
  if(key == 'o') {
    //if(state == false) {
      //when x is pressed once
    //state = true;
    Background = get(0,0,640,480);
    arrayCopy(Background.pixels, bgPixel);
    arrayCopy(Background.pixels, backupP);
    } 
    //else {
      //state = false;
    //}
  }
}
