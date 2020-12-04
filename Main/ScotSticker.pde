class ScotSticker{
  PImage img;
  float x;
  float y;
  
  public ScotSticker(float x, float y) {
    this.x = x;
    this.y = y;
    img = loadImage("preview.jpg");
  }
  
  public PImage getImages(){
    return img;
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
  Button ScotStickerButton = cp5.addButton("ScotSticker")
      .setPosition(300, 600)
      //.setImages(ScotButtonImage)
      .moveTo("stickers");
}
