class ScotSticker{
//Class for image stickers
  PImage img;
  PImage img2;
  PImage img3;
  float x;
  float y;
  
  public ScotSticker(float x, float y) {
  //Create a new scotsticker object with its x position and y position as inputs. Containing gettter and setter methods for x/y coordinates
  //Load three images and have getter methods for different images
    this.x = x;
    this.y = y;
    img = loadImage("111.png");
    img2 = loadImage("president1Img1.png");
    img2.resize(65,0);
    img3 = loadImage("presidentImg2.png");
    img3.resize(65,0);
  }
  
  public PImage getImages(){
    return img;
  }
  
  public PImage getImg2() {
    return img2; 
  }
  
  public PImage getImg3() {
    return img3;
  }
  
  void setX(float x) {
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }
  
  public float getY(){
    return y;
  }
  
  public float getX(){
    return x;
  }
  

}

void createScotStickerButton() {
//Load the images for three image stickers

  PImage img = loadImage("111.png");
  PImage img2 = loadImage("president1Img1.png");
  PImage img3 = loadImage("presidentImg2.png");
  img2.resize(100,0);
  img.resize(100, 0);
  img3.resize(70,0);
  
  //Create buttons on the UI
  Button ScotStickerButton = cp5.addButton("ScotSticker")
      .setPosition(325, 675)
      .setSwitch(true)
      .setImages(img, img, img, addBorderToImage(img, 4, color(0,0,0)))
      //.setImages(ScotButtonImage)
      .moveTo("stickers")
      .updateSize()
      .onRelease(turnOffOtherStickerButtons);
      
  Button presidentButton1 = cp5.addButton("PresidentButton1")
      .setPosition(200, 700)
      .setSwitch(true)
      .setImages(img2, img2, img2, addBorderToImage(img2, 4, color(0,0,0)))
      //.setImages(ScotButtonImage)
      .moveTo("stickers")
      .updateSize()
      .onRelease(turnOffOtherStickerButtons);
      
  Button presidentButton2 = cp5.addButton("PresidentButton2")
      .setPosition(100, 675)
      .setSwitch(true)
      .setImages(img3, img3, img3, addBorderToImage(img3, 4, color(0,0,0)))
      //.setImages(ScotButtonImage)
      .moveTo("stickers")
      .updateSize()
      .onRelease(turnOffOtherStickerButtons);
 
 //Add the three image stickers to the StickerButton Class
 stickerButtons.add(new StickerButton(ScotStickerButton, new Sticker(new PImage[]{img}, 0, 0, false)));
 stickerButtons.add(new StickerButton(presidentButton1, new Sticker(new PImage[]{img2}, 0, 0, false)));
 stickerButtons.add(new StickerButton(presidentButton2, new Sticker(new PImage[]{img3}, 0, 0, false)));
}
