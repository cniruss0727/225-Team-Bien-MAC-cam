import g4p_controls.*;
import controlP5.*;
import processing.video.*;
import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;
import gab.opencv.*;
import java.awt.Rectangle;
import ddf.minim.*;

  ControlP5 cp5;
  ControlP5 savePictureCp5;
  Capture cam;
  Filter macColorFilter;
  ContrastFilter contrastFilter;
  Button recorder;
  Rectangle[] faces;
  GWindow savePictureWindow;
  ArrayList<Sticker> stickers = new ArrayList<Sticker>();
  HashMap<String, PImage[]> stickerImageMap = new HashMap<String, PImage[]>();
  ArrayList<StickerButton> stickerButtons = new ArrayList<StickerButton>();
  OpenCV opencv;
  float x;
  float y;
  PImage currFrame;
  PImage recordImage;
  PImage processedImage;
  AudioPlayer ScotlandTheBrave;
  Minim minim;
  int frameNumber = 0;


  void setup() {
    size(960, 900);
    frameRate(10);
    cp5 = new ControlP5(this);
    
    createSavePictureWindow();
   
    macColorFilter = new MacColorFilter(this);
    contrastFilter = new ContrastFilter(this);
    
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
     
    cp5.addColorWheel("Hue")
     .setPosition(500, 650)
     .setSize(200, 200)
     .moveTo("color adjustment");
     
    cp5.addBang("resetSliders")
      .setPosition(100, 800)
      .setLabel("Reset")
      .setSize(100, 60)
      .moveTo("color adjustment")
      .setTriggerEvent(Bang.RELEASE);
     
//buttons    
      PImage[] recordButtons = {loadImage("recordButton1.png"),loadImage("recordButton2.png"),loadImage("recordButton3.png")};
    recorder= cp5.addButton("takePhoto")
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
     
// Description for filters
cp5.addTextlabel("Mac Color")
   .setText("Mac Color")
   .setPosition(120,845)
   .setFont(createFont("Georgia",20))
   . moveTo("filters picker")
   ;
cp5.addTextlabel("Mac ??")
   .setText("Mac ??")
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
      

//filters buttons
PImage[] preview1 = {loadImage("preview.jpg"),loadImage("preview.jpg"),loadImage("preview.jpg")};
     recorder= cp5.addButton("macColorFilterButton")
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
PImage[] preview4Off = {loadImage("preview4.jpg"),loadImage("preview4.jpg"),loadImage("preview4.jpg")};
     recorder= cp5.addButton("scotFace")
     .setPosition(630, 650)
     .setImages(preview4Off)
     .moveTo("filters picker")
     .updateSize()
     ;
     
  PImage[] speaker = {loadImage("speaker2.png"),loadImage("speaker2.png"),loadImage("speaker2.png")};
      recorder= cp5.addButton("audioControl")
     .setPosition(750, 780)
     .setImages(speaker)
     .moveTo("filters picker")
     .updateSize()

     ;
    
  ////filter selection bar
  //  ButtonBar b = cp5.addButtonBar("filter bar")
  //     .setPosition(300, 800)
  //     .setSize(400, 30)
  //     .addItems(split("a b c d e"," "))
  //     .moveTo("filters picker");
  //     ;
       
    //b.changeItem("a","text","basic");
    //b.changeItem("b","text","MAC");
    //b.changeItem("c","text","stickers");
    
loadStickerImages();
createStickerButtons();
  
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
    
    minim=new Minim(this);
    ScotlandTheBrave = minim.loadFile("scotland the brave.mp3");
    cam.start();
  }

  void draw() {
     background(50, 84, 168);
    
     rect(0,0,width,height-300);   
     
    if (cam.available()){
    cam.read();
    
    
    
  }
  
  if(((Button)(cp5.getController("macColorFilterButton"))).isOn()){
    processedImage = macColorFilter.transform(cam);
  }
  else {
    processedImage = cam;
  }
  
  processedImage = contrastFilter.transform(processedImage,
      Math.round(cp5.get("Brightness").getValue()),
      cp5.get("Contrast").getValue(),
      cp5.get("Saturation").getValue());
      tint(((ColorWheel)(cp5.get("Hue"))).getRGB());
      image(processedImage, 10, 10);
      tint(255, 255);
      g.removeCache(processedImage);
      
  // if(((Button)(cp5.getController("scotSticker"))).isOn()){
  // state = true;
  //    //access the two position lists and create stickers on the frame
  //    for(int i = 0; i < xposition.size(); i++) {
  //      image(loadImage("stickerButton.png"), xposition.get(i), yposition.get(i));
  //      }
  //}
  
  for(Sticker sticker : stickers){
    image(sticker.getActiveImage(frameNumber, 5), sticker.getX(), sticker.getY());
  }
  
  
  if(((Button)(cp5.getController("scotFace"))).isOn()){
      opencv.loadImage(cam);   
      faces = opencv.detect();
      if (faces != null) {
      for (int i = 0; i < faces.length; i++) {
        image(loadImage("macalester logo.png"), faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        }
      } 
  }
  
  //if(!((Button)cp5.get("audioControl")).isOn() && ScotlandTheBrave.isPlaying() && !((Button)cp5.get("scotFace")).isOn()){
  //  ScotlandTheBrave.pause();
  //}
  
  frameNumber++;
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
 

 
  public void audioControl(){
    PImage[] speaker = {loadImage("speaker2.png"),loadImage("speaker2.png"),loadImage("speaker2.png")};
    PImage[] speakerOff = {loadImage("speaker3.png"),loadImage("speaker3.png"),loadImage("speaker3.png")};


  if(ScotlandTheBrave.isPlaying()){
       cp5.getController("audioControl").setImages(speakerOff); 
  }
  if(!ScotlandTheBrave.isPlaying()){
       cp5.getController("audioControl").setImages(speaker);
  }
    
  if(ScotlandTheBrave.isPlaying()){
    ScotlandTheBrave.pause();
  }else {
      ScotlandTheBrave.play();
  }
 }
 
 public void mouseClicked() {
    //Check to see if the boolean "state" is true so that we could pass in coordinates
      for(StickerButton button: stickerButtons){
        if(button.getButton().isOn() && mouseY < 600 && cp5.getTab("stickers").isActive()){
          Sticker sticker = button.getSticker();
          float dw = sticker.getImages()[0].width;
          float dh = sticker.getImages()[0].height;
          stickers.add(new Sticker(sticker.getImages(), mouseX - dw/2, mouseY - dh/2, true));
          break;
        }
      }
  }

public void resetSliders(){
    cp5.get("Saturation").setValue(1);
    cp5.get("Brightness").setValue(0);
    cp5.get("Contrast").setValue(1);
    ((ColorWheel)cp5.get("Hue"))
      .setRGB(color(255, 255, 255))
      .setSaturation(1);
  }
  
public void takePhoto(){
    PImage camWindowCopy = get(20, 20, 940, 580);
    ((Textfield)savePictureCp5.get("savePictureTextField")).setText("");
    savePictureWindow.setVisible(true);
    while(savePictureWindow.isVisible()){
      delay(1000);
    }
    if(pictureSaved == true){
      String fileName = ((Textfield)savePictureCp5.get("savePictureTextField")).getText();
      camWindowCopy.save("Photos//" + fileName + ".png");
    }
}

public void scotFace(){
  
    ScotlandTheBrave.play();
    
    PImage[] preview4On = {loadImage("preview4On.jpg"),loadImage("preview4On.jpg"),loadImage("preview4On.jpg")};
    PImage[] preview4Off = {loadImage("preview4.jpg"),loadImage("preview4.jpg"),loadImage("preview4.jpg")};
  if(!((Button)(cp5.getController("scotFace"))).isOn()){
       cp5.getController("scotFace").setImages(preview4Off);
         ScotlandTheBrave.pause();
  }
  if(((Button)(cp5.getController("scotFace"))).isOn()){
       cp5.getController("scotFace").setImages(preview4On);
  }
  }
public void P2(){
if(ScotlandTheBrave.isPlaying()){
    ScotlandTheBrave.pause();
  }

  
}

public void P3(){
if(ScotlandTheBrave.isPlaying()){
    ScotlandTheBrave.pause();
  }

  
}
 
