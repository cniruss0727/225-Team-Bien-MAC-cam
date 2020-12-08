import processing.video.*;
import controlP5.*;

Capture cam;
PImage prev;
ControlP5 cp5;
Button switchTo;
float threshold = 25;

float motionX = 0;
float motionY = 0;

void setup() {
  size(700, 600);
  cam = new Capture(this, 700, 300);
  cam.start();
  prev = createImage(700,300,RGB);
  cp5 = new ControlP5(this);
  switchTo = cp5.addButton("switch").
    setValue(0).
    setPosition(350, 500).
    setSize(100,50);
  
}

void draw() {
  if(cam.available()) {
    prev.copy(cam, 0, 0, 700, 300, 0, 0, 700, 300);
    prev.updatePixels();
    cam.read();
    
  }
  
  cam.loadPixels();
  image(cam, 0, 0);
  
  threshold = 50;

  int count = 0;
  
  float avgX = 0;
  float avgY = 0;
  loadPixels();
  if(switchTo.isOn()) {
    
    for (int x = 0; x < 700; x++ ) {
    for (int y = 0; y < 300; y++ ) {
      int loc = x + y * 700;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);

      float difference = distSq(r1, g1, b1, r2, g2, b2); 

      if (difference > threshold*threshold) {
        
        avgX += x;
        avgY += y;
        count++;
        pixels[loc] = color(0,0,0);
      } else {
        pixels[loc] = color(255,255,255);
      }
    }
  }
  
  }
  updatePixels();
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
