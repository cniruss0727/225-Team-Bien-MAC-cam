  void setup() {
    size(960, 900);
    frameRate(10);
    cp5 = new ControlP5(this, new ControlFont(createFont("Georgia", 14)));
    
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
     .setPosition(100,680)
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
     .setPosition(100,720)
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
     .setPosition(100,760)
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
      
    resetSliders();
     
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
cp5.addTextlabel("Scot Face")
   .setText("Scot Face")
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
PImage[] preview1Off = {loadImage("preview1.JPG"),loadImage("preview1.JPG"),loadImage("preview1.JPG")};
     recorder= cp5.addButton("macColorFilterButton")
     .setPosition(120, 650)
     .setImages(preview1Off)
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
