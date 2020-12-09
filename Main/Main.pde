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
  PImage ScotButtonImage;
  AudioPlayer ScotlandTheBrave;
  Minim minim;
  int frameNumber = 0;
  ArrayList<ScotSticker> scotStickers = new ArrayList<ScotSticker>();

 void setup() {
    size(960, 900);
    frameRate(10);
    cp5 = new ControlP5(this, new ControlFont(createFont("Georgia", 14)));
    
    createSavePictureWindow();
   
    macColorFilter = new MacColorFilter(this);
    contrastFilter = new ContrastFilter(this);
    
    createUI();
    
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
createScotStickerButton();
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
  }else {
    processedImage = cam;
  }
  
  if(!slidersAtDefault()){
  processedImage = contrastFilter.transform(processedImage,
      Math.round(cp5.get("Brightness").getValue()),
      cp5.get("Contrast").getValue(),
      cp5.get("Saturation").getValue());
      tint(((ColorWheel)(cp5.get("Hue"))).getRGB());
  }
  
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
  
  
  for(ScotSticker a :scotStickers) {
    image(a.getImages(), a.getX(), a.getY());
  }
  
  
  if(((Button)(cp5.getController("scotFace"))).isOn()){
      opencv.loadImage(cam);  
      faces = opencv.detect(1.2, 2, 0, width/8, width);
      if (faces != null) {
      for (int i = 0; i < faces.length; i++) {
        image(loadImage("macalester logo.png"), faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        }
      }
      if(frameNumber % 5 == 0){
        System.gc();
      }
  } else if(((Button)(cp5.getController("P2"))).isOn()){
      opencv.loadImage(cam);  
      faces = opencv.detect(1.2, 2, 0, width/8, width);
      if (faces != null) {
      for (int i = 0; i < faces.length; i++) {
        image(loadImage("scotImage.png"), faces[i].x - faces[i].width/2.7, faces[i].y - faces[i].height/2.7, faces[i].width * 1.5, faces[i].height * 1.5);
        }
      }
      if(frameNumber % 5 == 0){
        System.gc();
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
      if(((Button)(cp5.getController("ScotSticker"))).isOn()) {
        //System.out.println(5);
        if(mouseY < 600){
        scotStickers.add(new ScotSticker(mouseX, mouseY));
        
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
  
public boolean slidersAtDefault(){
  if(cp5.get("Saturation").getValue() != 1 ||
      cp5.get("Brightness").getValue() != 0 ||
      cp5.get("Contrast").getValue() != 1 ||
      ((ColorWheel)cp5.get("Hue")).getRGB() != color(255, 255, 255)){
        return false;
      }
   return true; 
  }
  
public void takePhoto(){
    PImage camWindowCopy = get(20, 20, 940, 580);
    ((Textfield)savePictureCp5.get("savePictureTextField")).setText("");
    savePictureWindow.setVisible(true);
    delay(100);
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
  
public void macColorFilterButton(){
  ScotlandTheBrave.pause();
   PImage[] preview1On = {loadImage("preview1On.JPG"),loadImage("preview1On.JPG"),loadImage("preview1On.JPG")};
   PImage[] preview1Off = {loadImage("preview1.JPG"),loadImage("preview1.JPG"),loadImage("preview1.JPG")};
   if(!((Button)(cp5.getController("macColorFilterButton"))).isOn()){
       cp5.getController("macColorFilterButton").setImages(preview1Off);
         ScotlandTheBrave.pause();
  }
  if(((Button)(cp5.getController("macColorFilterButton"))).isOn()){
       cp5.getController("macColorFilterButton").setImages(preview1On);
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
 
