abstract class Filter{
    String name;
    PApplet applet;

    public String getName(){
        return this.name;
    }
    abstract PImage transform(PImage image);
}

class MacColorFilter extends Filter {
  MacColorFilter(PApplet applet){
    this.name = "MacColorFilter";
    this.applet = applet;
  }
  
  PImage transform(PImage image){
    PImage processedImage = PaletteMapping.apply(image,color(13, 60, 97), color(133, 29, 86), color(239, 79, 38), color(147, 149, 151), color(93, 198, 233), color(253, 174, 21));
    return processedImage;
  }
}

class ContrastFilter extends Filter {
  OpenCV cv;
  ContrastFilter(PApplet applet){
    this.name = "ContrastFilter";
    this.applet = applet;
    this.cv = new OpenCV(applet, 940, 580);
    cv.useColor();
  }
  
  PImage transform(PImage image){
    return image;
  }
  
  PImage transform(PImage image, int brightness, float contrast, float saturation){
  cv.loadImage(image);
  cv.brightness(brightness);
  cv.contrast(contrast);
  return Saturation.apply(cv.getOutput(), saturation);
  }
}
