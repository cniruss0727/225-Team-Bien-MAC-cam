class Sticker{
  PImage[] images;
  int activeImageIndex;
  float x;
  float y;
  boolean animated;
  
  Sticker(PImage[] images, float x, float y, boolean animated){
    this.images = images;
    this.x = x;
    this.y = y;
    this.animated = animated;
    activeImageIndex = 0;
  }
  
  
  private void updateActiveImage(int currFrame, int mod){
    if(currFrame % mod == 0){
      activeImageIndex = (activeImageIndex + 1) % images.length;
    }
  }
  
  public PImage getActiveImage(int currFrame, int mod){
    if(animated){
      updateActiveImage(currFrame, mod);
    }
    return images[activeImageIndex];
  }
  
  public PImage[] getImages(){
    return images;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
}

class StickerButton{
  Button button;
  Sticker sticker;
  
  StickerButton(Button button, Sticker sticker){
    this.button = button;
    this.sticker = sticker;
  }
  
  public Button getButton(){
    return button;
  }
  
  public Sticker getSticker(){
    return sticker;
  }
}

void loadStickerImages(){
  PImage[] macHeartImages = new PImage[4];
  macHeartImages[0] = loadImage("Stickers//MacHeart001.gif");
  macHeartImages[1] = loadImage("Stickers//MacHeart002.gif");
  macHeartImages[2] = loadImage("Stickers//MacHeart003.gif");
  macHeartImages[3] = loadImage("Stickers//MacHeart004.gif");
  
  for(PImage image : macHeartImages){
    image.resize(150, 0);
  }
  stickerImageMap.put("MacHeart", macHeartImages);
  
  PImage[] goScotsImages = new PImage[2];
  goScotsImages[0] = loadImage("Stickers//GoScotsGif001.gif");
  goScotsImages[1] = loadImage("Stickers//GoScotsGif002.gif");
  stickerImageMap.put("GoScots", goScotsImages);
  
  for(PImage image : goScotsImages){
    image.resize(150, 0);
  }
}

//Creates buttons for the sticker tab. Should be called in setup AFTER loading sticker images and creating the sticker tab.
void createStickerButtons(){
  Button macHeartButton = cp5.addButton("MacHeartButton")
      .setSwitch(true)
      .setPosition(450, 700)
      .setImages(stickerImageMap.get("MacHeart")[0], stickerImageMap.get("MacHeart")[1], stickerImageMap.get("MacHeart")[1], addBorderToImage(stickerImageMap.get("MacHeart")[0], 4, color(0,0,0)))
      .moveTo("stickers")
      .updateSize()
      .onRelease(turnOffOtherStickerButtons);
  
  Sticker macHeartSticker = new Sticker(stickerImageMap.get("MacHeart"), 0, 0, true);
      
  Button goScotsButton = cp5.addButton("GoScotsButton")
      .setPosition(620, 700)
      .setSwitch(true)
      .setImages(stickerImageMap.get("GoScots")[0], stickerImageMap.get("GoScots")[1], stickerImageMap.get("GoScots")[1], addBorderToImage(stickerImageMap.get("GoScots")[0], 4, color(0,0,0)))
      .moveTo("stickers")
      .updateSize()
      .onRelease(turnOffOtherStickerButtons);
      
  Sticker goScotsSticker = new Sticker(stickerImageMap.get("GoScots"), 0, 0, true);
  
  StickerButton macHeartStickerButton = new StickerButton(macHeartButton, macHeartSticker);
  StickerButton goScotsStickerButton = new StickerButton(goScotsButton, goScotsSticker);
  
  stickerButtons.add(macHeartStickerButton);
  stickerButtons.add(goScotsStickerButton);
  
  cp5.addButton("clearStickers")

    .setPosition(810, 720)

    .setSize(120, 80)
    .setColorBackground(color(200, 200, 200))
    .setColorLabel(color(0, 0, 0))
    .setColorActive(color(100, 100, 100))
    .setColorForeground(color(247, 171, 7))

    .setLabel("Clear Stickers")
    .moveTo("stickers");
}

public PImage addBorderToImage(PImage img, int borderWidth, int col){
  PGraphics buffer = createGraphics(img.width + borderWidth*2, img.height + borderWidth*2);
  buffer.beginDraw();
  buffer.noFill();
  buffer.strokeWeight(borderWidth);
  buffer.image(img, borderWidth, borderWidth);
  buffer.stroke(col);
  buffer.rect(0, 0, img.width + borderWidth, img.height + borderWidth);
  buffer.endDraw();
  return buffer.get(0, 0, img.width+borderWidth*2, img.height+borderWidth*2);
}

//Clear all the stickers from the webcam
public void clearStickers(){
  stickers.clear();
}

CallbackListener turnOffOtherStickerButtons = new CallbackListener(){
  void controlEvent(CallbackEvent theEvent){
    for(StickerButton sb : stickerButtons){
      if(!sb.getButton().equals(theEvent.getController())){
        sb.getButton().setOff();
      }
    }
  }
};
