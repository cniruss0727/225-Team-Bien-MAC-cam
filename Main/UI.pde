public void createUI(){
 //Tabs   
    cp5.getTab("default")
.setColorBackground(color(255,255,255, 1))
     .setColorForeground(color(255,255,255,1))
     .setColorActive(color(255,255,255,1))
     .setLabel("")
      .setAlwaysActive(true);
     
    //  .setPosition(-10,-10);
     // .setVisible(false);
      
     cp5.addTab("filters picker")
.setColorBackground(color(255,255,255, 1))
     .setColorForeground(color(255,255,255,1))
     .setColorActive(color(255,255,255,1))
     .setLabel("");

    
    cp5.addTab("color adjustment")
.setColorBackground(color(255,255,255, 1))
     .setColorForeground(color(255,255,255,1))
     .setColorActive(color(255,255,255,1))
     .setLabel("");

     
        cp5.addTab("stickers")  
.setColorBackground(color(255,255,255, 1))
     .setColorForeground(color(255,255,255,1))
     .setColorActive(color(255,255,255,1))
     .setLabel("");

 
 //All the sliders for color adjustment   
    cp5.addSlider("Saturation")
     .setPosition(100,680)
     .setSize(200,20)
     .setColorActive(color(247, 171, 7))
     .setColorForeground(color(247, 171, 7))
     .setColorBackground(color(200, 200, 200))
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
     .setColorBackground(color(200, 200, 200))
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
     .setColorBackground(color(200, 200, 200))
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
cp5.addTextlabel("Mactivities")
   .setText("Mactivities")
   .setPosition(290,845)
   .setFont(createFont("Georgia",20))
   . moveTo("filters picker")
   ;
cp5.addTextlabel("Blizzard")
   .setText("Blizzard")
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
PImage[] preview4Off = {loadImage("preview4.JPG"),loadImage("preview4.JPG"),loadImage("preview4.JPG")};
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
  }
