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
  Button clickAddScot;
  Button sticker;
  Filter macColorFilter;
  PImage currFrame;
  Rectangle[] faces;
  OpenCV opencv;
  PImage img;
  PImage stickerImg;
  boolean state;
  float x;
  float y;
  FloatList xposition = new FloatList();
  FloatList yposition = new FloatList();


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
    

    stickerImg = loadImage("button2.png");
    
    img = loadImage("scotImage.png");
    img.resize(0, 500);
    
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
        setPosition(100, 700).
        setSize(100,40).
        setColorBackground(color(250, 250, 0));
    macColorFilterButton.moveTo("Tab 1");
    
    clickAddScot = cp5.addButton("onHead").
        setValue(0).
        setPosition(200, 700).
        setSize(100,40).
        setColorBackground(color(250, 250, 0));
    clickAddScot.moveTo("Tab 1");
     
     
    sticker = cp5.addButton("sticker").
        setValue(0).
        setPosition(500, 700).
        setSize(100,40).
        setColorBackground(color(250, 250, 0));
    sticker.moveTo("Tab 1");
   currFrame = createImage(960, 600, ARGB);
   
   

  }
  
  void draw() {
    background(0);
    if (cam.available()){
    cam.read();
    
    opencv.loadImage(cam);   
    faces = opencv.detect();
    image(cam, 0, 0);
    
    //See if the add scot button is clicked
    if(clickAddScot.isOn()) {
      //Put the scot image on user's face
      if (faces != null) {
      for (int i = 0; i < faces.length; i++) {
        image(img, faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        }
      } 
    }
    
    
    //Didn't restrict to the cam area, will do later.
    //See if the sticker button is on
    if(sticker.isOn()) {
      //set the boolean "state" to true
      state = true;
      //access the two position lists and create stickers on the frame
      for(int i = 0; i < xposition.size(); i++) {
        image(stickerImg, xposition.get(i), yposition.get(i));
        }
      }
    }
    
  
    if(macColorFilterButton.isOn()){
      currFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, currFrame.width, currFrame.height);
      PImage processedImage = macColorFilter.transform(currFrame);
      image(processedImage, 0, 0);
      }
    }
  
  
  
  
  public void boo(){
    println("boo");//funcitons triggered by button
  }
  
  public void mouseClicked() {
    //Check to see if the boolean "state" is true so that we could pass in coordinates
    if (state == true) {
    x = mouseX;
    y = mouseY;
    xposition.append(x);
    yposition.append(y);
    }
      
  }
 
   
