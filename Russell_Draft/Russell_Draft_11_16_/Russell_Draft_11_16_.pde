import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
import java.util.*;

  ControlP5 cp5;
  

  Button recorder;
  
  PImage recordImage;
  PImage filterImage;
  PImage colorImage;
  PImage stickerImage;



  void setup() {
    size(960, 900);
    cp5 = new ControlP5(this);
    recordImage = loadImage("macButton.png");
    filterImage = loadImage("filterButton.png");
    colorImage = loadImage("colorButton.png");
    stickerImage = loadImage("stickerButton.png");
    
   
    
 
//Tabs   
    cp5.getTab("default")
    .setColorBackground(color(121, 172, 247))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
      .setAlwaysActive(true)
      ;
      
     cp5.addTab("filters picker")
     .setColorBackground(color(121, 172, 247))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     //.setPosition(0,700)
     //.setAbsolutePosition(array)
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
    
//buttons    
    
    recorder= cp5.addButton("record")
     .setPosition(60, 500)
     .setImage(recordImage)
     .moveTo("default")
     .updateSize()
     ;
     
     recorder= cp5.addButton("filter")
     .setPosition(650,510)
     .setImage(filterImage)
     .moveTo("default")
     .updateSize()
     ;
     recorder= cp5.addButton("colour")
     .setPosition(760, 505)
     .setImage(colorImage)
     .moveTo("default")
     .updateSize()
     ;
     
     recorder= cp5.addButton("sticker")
     .setPosition(880, 475)
     .setImage(stickerImage)
     .moveTo("default")
     .updateSize()
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
  
  public void record(){
    println("Yo im recording!");
  }
  
  public void filter(){
    cp5.getTab("filters picker").bringToFront();
  }
  
 public void colour(){
   cp5.getTab("color adjustment").bringToFront();
 }
 public void sticker(){
   cp5.getTab("stickers").bringToFront();
 }
 
