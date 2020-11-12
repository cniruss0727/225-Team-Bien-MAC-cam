import controlP5.*;
import processing.video.*;
  ControlP5 cp5;
  Button button;
  Slider slider;
  Capture cam;
  Icon macColorFilter;

  void setup() {
    size(900, 900);
    
    cam = new Capture(this, 900, 600);
    cam.start();
    
    cp5 = new ControlP5(this);
    slider = cp5.addSlider("mySlider").setPosition(1000,600).setSize(200,20);
    button = cp5.addButton("boo").
        setValue(0).
        setPosition(800,600).
        setSize(100,40);
    button.moveTo("Tab 1");
    slider.moveTo("Tab 2");
    
    macColorFilter = cp5.addIcon("macFilter", 0).
        setPosition(500, 500).
        setSize(100,100);
    macColorFilter.moveTo("Tab 1");
      

  }

  void draw() {
     background(0);
     
    if (cam.available()){
    cam.read();
  }
  image(cam,0,0);
  }
  
  public void boo(){
    println("boo");//funcitons triggered by button
  }
 
     
