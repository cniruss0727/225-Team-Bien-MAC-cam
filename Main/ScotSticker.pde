class ScotSticker{
  PImage img;
  PImage img2;
  PImage img3;
  float x;
  float y;
  
  public ScotSticker(float x, float y) {
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
  public float getX(){
    return x;
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
  

}

void createScotStickerButton() {
  PImage img = loadImage("111.png");
  PImage img2 = loadImage("president1Img1.png");
  PImage img3 = loadImage("presidentImg2.png");
  img2.resize(100,0);
  img.resize(100, 0);
  img3.resize(70,0);
  Button ScotStickerButton = cp5.addButton("ScotSticker")
      .setPosition(325, 675)
      .setSwitch(true)
      .setImages(img, img, img, addBorderToImage(img, 4, color(0,0,0)))
      //.setImages(ScotButtonImage)
      .moveTo("stickers")
      .updateSize();
      
  Button presidentButton1 = cp5.addButton("PresidentButton1")
      .setPosition(200, 700)
      .setSwitch(true)
      .setImages(img2, img2, img2, addBorderToImage(img2, 4, color(0,0,0)))
      //.setImages(ScotButtonImage)
      .moveTo("stickers")
      .updateSize();
      
  Button presidentButton2 = cp5.addButton("PresidentButton2")
      .setPosition(100, 675)
      .setSwitch(true)
      .setImages(img3, img3, img3, addBorderToImage(img3, 4, color(0,0,0)))
      //.setImages(ScotButtonImage)
      .moveTo("stickers")
      .updateSize();
}
