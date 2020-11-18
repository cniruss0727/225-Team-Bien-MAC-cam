import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
import java.util.*;

  ControlP5 cp5;
  
  Button macColorFilterButton;
  Filter macColorFilter;
  Bang recorder;
  
  PImage img;


  void setup() {
    size(960, 900);
    cp5 = new ControlP5(this);
    img = loadImage("button.png");
   
    
 
//Tabs   
    cp5.getTab("default")
    .setColorBackground(color(121, 172, 247))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
      .setAlwaysActive(true);
      
     cp5.addTab("filters picker")
     .setColorBackground(color(121, 172, 247))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
    
    cp5.addTab("color adjustment")
     .setColorBackground(color(22, 112, 245))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
     
        cp5.addTab("stickers")  
     .setColorBackground(color(2, 68, 166))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
    
    
//All the sliders for color adjustment   
    cp5.addSlider("Saturation")
     .setPosition(80,680)
     .setSize(200,20)
     .setColorActive(color(247, 171, 7))
     .setColorForeground(color(247, 171, 7))
     .setWidth(300)
     .setHeight(30)
     .moveTo("color adjustment")
     ;
     
    cp5.addSlider("Brightness")
     .setPosition(80,720)
     .setSize(200,20)
     .setColorActive(color(242, 165, 0))
     .setColorForeground(color(242, 165, 0))
     .setWidth(300)
     .setHeight(30)
     .moveTo("color adjustment")
     ;
     
      cp5.addSlider("Contrast")
     .setPosition(80,760)
     .setSize(200,20)
     .setColorActive(color(214, 147, 2))
     .setColorForeground(color(214, 147, 2))
     .setWidth(300)
     .setHeight(30)
     .moveTo("color adjustment")
     ;
     
       cp5.addSlider("Hue")
     .setPosition(80,800)
     .setSize(200,20)
     .setColorActive(color( 191, 135, 13))
     .setColorForeground(color( 191, 135, 13))
     .setWidth(300)
     .setHeight(30)
     .moveTo("color adjustment")
     ;
    
    
    
    recorder= cp5.addBang("bang")
     .setPosition(60, 500)
     .setSize(50, 50)
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("record")
     .setImage(img)
     .moveTo("default")
     ;
      
 
     
 //filter selection bar
  ButtonBar b = cp5.addButtonBar("filter bar")
     .setPosition(300, 800)
     .setSize(400, 30)
     .addItems(split("a b c d e"," "))
     .moveTo("filters picker");
     ;
     
  b.changeItem("a","text","basic");
  b.changeItem("b","text","MAC");
  b.changeItem("c","text","stickers");

  }

  void draw() {
     background(50, 84, 168);
     rect(0,0,width,height-300);   
     
  }
  
  void bang(){
    println("whatsup");
  }
  
  
  public void stickers() {
    recorder.moveTo("stickers");
     println("whatsup");        
  }
