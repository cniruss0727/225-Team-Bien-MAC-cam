import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;

import processing.video.*;

Capture cam;
int switcher = 0;
PImage currFrame;
int cam_width = 640;
int cam_height = 480;

void setup(){
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  } 
  cam = new Capture(this, cam_width, cam_height, cameras[0]);
  cam.start();
  scale(-1, 1);
  currFrame = createImage(cam_width, cam_height, ARGB);
}

void settings(){
  size(cam_width, cam_height);
}

void draw(){
  if(cam.available()){
    cam.read();
  }
  
  if(switcher > 0){
    currFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, currFrame.width, currFrame.height);
    PImage processedImage = PaletteMapping.apply(currFrame, color(13, 60, 97), color(133, 29, 86), color(239, 79, 38), color(147, 149, 151), color(93, 198, 233), color(253, 174, 21));
    image(processedImage, 0, 0);
  } else {
    image(cam.get(), 0, 0);
  }
}

void mousePressed(){
  switcher++;
}
    
