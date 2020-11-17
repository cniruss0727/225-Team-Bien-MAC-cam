import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
import gab.opencv.*;
import java.awt.Rectangle;


  ControlP5 cp5;
  Button button;
  Slider slider;
  Capture cam;
  Button macColorFilterButton;
  Filter macColorFilter;
  PImage currFrame;
  Rectangle[] faces;
  OpenCV opencv;

  void setup() {
    size(960, 900, P2D);
    String[] cameras = Capture.list();
    while(cameras.length == 0){
        println("There are no cameras available for capture.");
        cameras = Capture.list();
    }
    
    for (int i = 0; i < cameras.length; i++) {
      println("Available cameras:");
      println(cameras[i]);
    }
      
    
    cam = new Capture(this, 960, 600, cameras[0]);
    opencv = new OpenCV(this, 960, 600);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    cam.start();
    
    macColorFilter = new MacColorFilter();
    
    cp5 = new ControlP5(this);
    slider = cp5.addSlider("mySlider").setPosition(1000,600).setSize(200,20);
    button = cp5.addButton("boo").
        setValue(0).
        setPosition(800,600).
        setSize(100,40);
    button.moveTo("Tab 1");
    slider.moveTo("Tab 2");
    
    macColorFilterButton = cp5.addButton("macFilter").
        setValue(0).
        setPosition(500, 700).
        setSize(100,40).
        setColorBackground(color(250, 250, 0));
    macColorFilterButton.moveTo("Tab 1");
      
   currFrame = createImage(960, 600, ARGB);

  }
  
  
  void draw() {
    background(0);
    if (cam.available()){
    cam.read();
    
    opencv.loadImage(cam);
    
    faces = opencv.detect();
    
    image(cam, 0, 0);
    
    
    if (faces != null) {
      for (int i = 0; i < faces.length; i++) {
        stroke(255,0,0);
        strokeWeight(3);
        noFill();
        println(faces[i].x + "," + faces[i].y);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      }
    }
  
  
    if(macColorFilterButton.isOn()){
      currFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, currFrame.width, currFrame.height);
      PImage processedImage = macColorFilter.transform(currFrame);
      image(processedImage, 0, 0);
      }
    }
  }
  
  
  
  public void boo(){
    println("boo");//funcitons triggered by button
  }
 
   
