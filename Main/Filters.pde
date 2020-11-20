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
  ContrastFilter(PApplet applet){
    this.name = "ContrastFilter";
    this.applet = applet;
  }
  
  PImage transform(PImage image){
    OpenCV cv = new OpenCV(applet, image, true);
    cv.brightness(-50);
    cv.contrast(1.5);
    return cv.getOutput();
  }
  
  PImage transform(PImage image, int brightness, float contrast, float saturation, int hue){
  OpenCV cv = new OpenCV(applet, image, true);
  cv.brightness(brightness);
  cv.contrast(contrast);
  return Saturation.apply(cv.getOutput(), saturation);
  }
}
