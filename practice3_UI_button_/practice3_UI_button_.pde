import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
  ControlP5 cp5;
  Button button;
  Slider slider;
  Capture cam;
  Button macColorFilter;
  PImage currFrame;

  void setup() {
    size(960, 900);
    
    cam = new Capture(this, 960, 600);
    cam.start();
    
    cp5 = new ControlP5(this);
    slider = cp5.addSlider("mySlider").setPosition(1000,600).setSize(200,20);
    button = cp5.addButton("boo").
        setValue(0).
        setPosition(800,600).
        setSize(100,40);
    button.moveTo("Tab 1");
    slider.moveTo("Tab 2");
    
    macColorFilter = cp5.addButton("macFilter").
        setValue(0).
        setPosition(500, 700).
        setSize(100,40).
        setColorBackground(color(250, 250, 0));
    macColorFilter.moveTo("Tab 1");
      
   currFrame = createImage(960, 600, ARGB);

  }

  void draw() {
     background(0);
     
    if (cam.available()){
    cam.read();
  }
  
  if(macColorFilter.isOn()){
    currFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, currFrame.width, currFrame.height);
    PImage processedImage = PaletteMapping.apply(currFrame, color(13, 60, 97), color(133, 29, 86), color(239, 79, 38), color(147, 149, 151), color(93, 198, 233), color(253, 174, 21));
    image(processedImage, 0, 0);
  }
  else {
    image(cam,0,0);
  }
  }
  
  public void boo(){
    println("boo");//funcitons triggered by button
  }
  
  public void macFilter(){
    macColorFilter.setOn();
  }
 
     
