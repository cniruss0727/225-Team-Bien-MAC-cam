import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;

  ControlP5 cp5;
  Button button;
  Slider slider;
  Capture cam;
  Button macColorFilterButton;
  Filter macColorFilter;
  PImage currFrame;

  void setup() {
    size(960, 900);
    

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

  }
  
  public void boo(){
    println("boo");//funcitons triggered by button
  }
 
     
