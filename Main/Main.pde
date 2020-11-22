import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
import gab.opencv.*;
import java.awt.Rectangle;

  ControlP5 cp5;
  Capture cam;
  Filter macColorFilter;
  ContrastFilter contrastFilter;
  Button recorder;
  Rectangle[] faces;
  OpenCV opencv;
  boolean state;
  float x;
  float y;
  FloatList xposition = new FloatList();
  FloatList yposition = new FloatList();
  PImage currFrame;
  PImage recordImage;
  PImage processedImage;


  void setup() {
    size(960, 900);
    frameRate(5);
    cp5 = new ControlP5(this);
    
    
    
    
    macColorFilter = new MacColorFilter(this);
    contrastFilter = new ContrastFilter(this);
    recordImage = loadImage("macButton.png");
    
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
     .setRange(0, 2)
     .setValue(1)
     .moveTo("color adjustment")
     ;
     
    cp5.addSlider("Brightness")
     .setPosition(80,720)
     .setSize(200,20)
     .setColorActive(color(242, 165, 0))
     .setColorForeground(color(242, 165, 0))
     .setWidth(300)
     .setHeight(30)
     .setRange(-100, 100)
     .setValue(0)
     .moveTo("color adjustment")
     ;
     
      cp5.addSlider("Contrast")
     .setPosition(80,760)
     .setSize(200,20)
     .setColorActive(color(214, 147, 2))
     .setColorForeground(color(214, 147, 2))
     .setWidth(300)
     .setHeight(30)
     .setRange(0, 2)
     .setValue(1)
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
    
    cp5.addButton("scotSticker")
     .setPosition(300, 600)
     .moveTo("stickers")
     .updateSize()
     ;
    
    cp5.addButton("scotFace")
      .setPosition(100,600)
      .moveTo("stickers")
      .updateSize()
     ;
   PImage[] filterButtons = {loadImage("filterButton.png"),loadImage("filterButton2.png"),loadImage("filterButton.png")};
     recorder= cp5.addButton("filter")
     .setPosition(753, 614)
     .setImages(filterButtons)
     .moveTo("default")
     .updateSize()
     ;
     
      PImage[] colorButtons = {loadImage("colorButton.png"),loadImage("colorButton2.png"),loadImage("colorButton.png")};
     recorder= cp5.addButton("colour")
     .setPosition(826, 620)
     .setImages(colorButtons)
     .moveTo("default")
     .updateSize()
     ;
     
     PImage[] stickerButtons = {loadImage("stickerButton.png"),loadImage("stickerButton2.png"),loadImage("stickerButton.png")};
     recorder= cp5.addButton("sticker")
     .setPosition(892, 607)
     .setImages(stickerButtons)
     .moveTo("default")
     .updateSize()
     ;
     
    recorder= cp5.addButton("macColorFilterButton")
     .setPosition(300, 700)
     .setSize(100, 30)
     .moveTo("filters picker")
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
  
    String[] cameras = Capture.list();
    while(cameras.length == 0){
        println("There are no cameras available for capture.");
        cameras = Capture.list();
    }
    
    for (int i = 0; i < cameras.length; i++) {
      println("Available cameras:");
      println(cameras[i]);
    }
      
    
    cam = new Capture(this, 940, 580, cameras[0]);
    
    opencv = new OpenCV(this, 940, 580);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    cam.start();
    
   currFrame = createImage(940, 580, ARGB);

  }

  void draw() {
     background(50, 84, 168);
    
     rect(0,0,width,height-300);   
     
    if (cam.available()){
    cam.read();
    
    
    
  }
  
  if(((Button)(cp5.getController("colour"))).isOn()){
    processedImage = macColorFilter.transform(cam);
  }
  else {
    processedImage = cam;
  }
  
  
  
  processedImage = contrastFilter.transform(processedImage,
      Math.round(cp5.get("Brightness").getValue()),
      cp5.get("Contrast").getValue(),
      cp5.get("Saturation").getValue(),
      1);
      image(processedImage, 10, 10);
      
   if(((Button)(cp5.getController("scotSticker"))).isOn()){
   state = true;
      //access the two position lists and create stickers on the frame
      for(int i = 0; i < xposition.size(); i++) {
        image(loadImage("stickerButton.png"), xposition.get(i), yposition.get(i));
        }
  }
  
  
  opencv.loadImage(cam);   
  faces = opencv.detect();
  if(((Button)(cp5.getController("scotFace"))).isOn()){
      if (faces != null) {
      for (int i = 0; i < faces.length; i++) {
        image(loadImage("macalester logo.png"), faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        }
      } 
  }
  
  
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
 public void mouseClicked() {
    //Check to see if the boolean "state" is true so that we could pass in coordinates
    if (state == true) {
    x = mouseX;
    y = mouseY;
    xposition.append(x);
    yposition.append(y);
    }
      
  }
 
