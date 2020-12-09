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

class MactivityFilter extends Filter {
  OpenCV cv;
  PGraphics buffer;
  ArrayList<String> activities;
  
  MactivityFilter(PApplet applet){
    this.name = "MactivityFilter";
    this.applet = applet;
    this.cv = new OpenCV(applet, 940, 580);
    cv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    this.activities = new ArrayList<String>();
    createActivities();
  }
  
  PImage transform(PImage image){
    cv.loadImage(cam);
    Rectangle[] faces = cv.detect(1.2, 2, 0, width/8, width);
    if(faces!= null && faces.length > 0){
      float upperLeftX = faces[0].x;
      float upperLeftY = faces[0].y - faces[0].height/2;
      float lowerRightX = faces[0].x + faces[0].width;
      float lowerRightY = faces[0].y - faces[0].height/4 ;
      buffer = createGraphics(image.width, image.height);
      buffer.beginDraw(); 
      buffer.image(image, 0, 0);
      buffer.rect(upperLeftX, upperLeftY, lowerRightX - upperLeftX, lowerRightY - upperLeftY);
      
      String activity = activities.get(frameNumber % activities.size());
      buffer.fill(color(0,0,0));
      buffer.textAlign(CENTER);
      buffer.textFont(createFont("Georgia", 14));
      buffer.text(activity, upperLeftX, upperLeftY, lowerRightX - upperLeftX, lowerRightY - upperLeftY );
      buffer.endDraw();
      return buffer.get(0, 0, image.width, image.height);
    } else {
      return image;
      }
  }
  
  private void createActivities(){
    activities.add("Get fake Chipotle (Scotty's) from the campus center");
    activities.add("Make something in the Idea Lab");
    activities.add("STUDY!!!");
    activities.add("Play frisbee on the lawn");
    activities.add("Build a snowman");
    activities.add("Go to the Highlander store");
    activities.add("Hang out with a therapy dog");
    activities.add("Find a new book to read in the library");
  }
}

class BlizzardFilter extends Filter{
  PGraphics buffer;
  PImage prev;
  static final float THRESHOLD = 25;
  
  BlizzardFilter(PApplet applet){
    this.name = "BlizzardFilter";
    this.applet = applet;
    this.prev = null;
  }
  
  public PImage transform(PImage img){
    if(prev == null){
      prev = img;
      return img;
    }
    prev.updatePixels();
    prev.loadPixels();
    img.loadPixels();
    PImage buffer = createImage(img.width, img.height, RGB);
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        int loc = x + y * img.width;
        // What is current color
        color currentColor = img.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        color prevColor = prev.pixels[loc];
        float r2 = red(prevColor);
        float g2 = green(prevColor);
        float b2 = blue(prevColor);
  
        float difference = dist(r1, g1, b1, r2, g2, b2); 
        
        buffer.loadPixels();
        if (difference > THRESHOLD) {
          buffer.pixels[loc] = img.pixels[loc];
        } else {
          buffer.pixels[loc] = color(255,255,255);
        }
      }
    }
    prev = img;
    buffer.updatePixels();
    return buffer;
  }
  
}
