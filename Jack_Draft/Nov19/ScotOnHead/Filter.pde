  
abstract class Filter{
    String name;

    public String getName(){
        return this.name;
    }
    abstract PImage transform(PImage image);
}

class MacColorFilter extends Filter {
  MacColorFilter(){
    this.name = "MacColorFilter";
  }
  
  PImage transform(PImage image){
    PImage processedImage = PaletteMapping.apply(image,color(13, 60, 97), color(133, 29, 86), color(239, 79, 38), color(147, 149, 151), color(93, 198, 233), color(253, 174, 21));
    return processedImage;
  }
  
}



//class sticker extends Filter{
//  sticker() {
//    this.name = "sticker";
//  }
  
//  PImage transform(PImage image) {
    
//}
