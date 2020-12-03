import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
import java.util.*;

  ControlP5 cp5;
  

  Button recorder;
  
  PImage recordImage;
  
  


  void setup() {
    
  
    size(960, 900);
    cp5 = new ControlP5(this);
    recordImage = loadImage("macButton.png");
  
    
   
    
 
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
      PImage[] recordButtons = {loadImage("recordButton1.png"),loadImage("recordButton2.png"),loadImage("recordButton3.png")};
    recorder= cp5.addButton("record")
     .setPosition(18, 615)
     .setImages(recordButtons)
     .moveTo("default")
     .updateSize()
     ;
     
   PImage[] filterButtons = {loadImage("filterButton4.png"),loadImage("filterButton3.png"),loadImage("filterButton4.png")};
     recorder= cp5.addButton("filter")
     .setPosition(752, 616)
     .setImages(filterButtons)
     .moveTo("default")
     .updateSize()
     ;
     
      PImage[] colorButtons = {loadImage("colorButton3.png"),loadImage("colorButton4.png"),loadImage("colorButton3.png")};
     recorder= cp5.addButton("colour")
     .setPosition(826, 620)
     .setImages(colorButtons)
     .moveTo("default")
     .updateSize()
     ;
     
     PImage[] stickerButtons = {loadImage("stickerButton.png"),loadImage("stickerButton2.png"),loadImage("stickerButton.png")};
     recorder= cp5.addButton("sticker")
     .setPosition(891, 617)
     .setImages(stickerButtons)
     .moveTo("default")
     .updateSize()
     ;
     
     

//filters buttons
PImage[] preview1 = {loadImage("preview.jpg"),loadImage("preview.jpg"),loadImage("preview.jpg")};
     recorder= cp5.addButton("P1")
     .setPosition(120, 650)
     .setImages(preview1)
     .moveTo("filters picker")
     .updateSize()
     ;
PImage[] preview2 = {loadImage("preview.jpg"),loadImage("preview.jpg"),loadImage("preview.jpg")};
     recorder= cp5.addButton("P2")
     .setPosition(290, 650)
     .setImages(preview2)
     .moveTo("filters picker")
     .updateSize()
      ;
PImage[] preview3 = {loadImage("preview.jpg"),loadImage("preview.jpg"),loadImage("preview.jpg")};
     recorder= cp5.addButton("P3")
     .setPosition(460, 650)
     .setImages(preview3)
     .moveTo("filters picker")
     .updateSize()
     ;

PImage[] preview4Off = {loadImage("preview4.jpg"),loadImage("preview4.jpg"),loadImage("preview.jpg")};
     recorder= cp5.addButton("P4")
     .setPosition(630, 650)
     .setImages(preview4Off)
     .moveTo("filters picker")
     .updateSize()
     ;

//Pipemusic Control
PImage[] speaker = {loadImage("speaker2.png"),loadImage("speaker2.png"),loadImage("speaker2.png")};
     recorder= cp5.addButton("audioControl")
     .setPosition(750, 780)
     .setImages(speaker)
     .moveTo("filters picker")
     .updateSize()
     ;
      
// Description for filters
cp5.addTextlabel("Mac Color")
   .setText("Mac Color")
   .setPosition(120,845)
   .setFont(createFont("Georgia",20))
   . moveTo("filters picker")
   ;
cp5.addTextlabel("Mac Color")
   .setText("Mac Color")
   .setPosition(290,845)
   .setFont(createFont("Georgia",20))
   . moveTo("filters picker")
   ;
cp5.addTextlabel("Mac Background")
   .setText("Mac Background")
   .setPosition(460,845)
   .setFont(createFont("Georgia",20))
   . moveTo("filters picker")
   ;
cp5.addTextlabel("Scotland The Brave")
   .setText("Scotland The Brave")
   .setPosition(630,845)
   .setFont(createFont("Georgia",20))
   . moveTo("filters picker")
   ;
      
      
 
     
 //filter selection bar
  //ButtonBar b = cp5.addButtonBar("filter bar")
     //.setPosition(300, 800)
    //.setSize(400, 30)
     //.addItems(split("a b c d e"," "))
     //.moveTo("filters picker");
     //;
     
  //b.changeItem("a","text","basic");
  //b.changeItem("b","text","MAC");
 //b.changeItem("c","text","stickers");

  }

  void draw() {
     background(50, 84, 168);
     rect(0,0,width,height-300);   
     
  }
  
  public void record(){
    println("Yo im recording!");
  }
  public void P4(){
    
    PImage[] preview4On = {loadImage("preview4On.jpg"),loadImage("preview4On.jpg"),loadImage("preview4On.jpg")};
    PImage[] preview4Off = {loadImage("preview4.jpg"),loadImage("preview4.jpg"),loadImage("preview4.jpg")};
  if(((Button)(cp5.getController("P4"))).isOn()){
       cp5.getController("P4").setImages(preview4Off);
  }
  if(!((Button)(cp5.getController("P4"))).isOn()){
       cp5.getController("P4").setImages(preview4On);
  }
}
  public void audioControl(){
    PImage[] speaker = {loadImage("speaker2.png"),loadImage("speaker2.png"),loadImage("speaker2.png")};
    PImage[] speakerOff = {loadImage("speaker3.png"),loadImage("speaker3.png"),loadImage("speaker3.png")};


     if(((Button)(cp5.getController("audioControl"))).isOn()){
       cp5.getController("audioControl").setImages(speakerOff);
       
   
  }
  if(!((Button)(cp5.getController("audioControl"))).isOn()){
       cp5.getController("audioControl").setImages(speaker);
       
   
  }
    
    
    
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
 
