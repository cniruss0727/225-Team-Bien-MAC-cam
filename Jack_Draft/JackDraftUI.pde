import controlP5.*;

ControlP5 cp5;

void setup() {
//set up the window

  size(550, 650);
  
 

  cp5 = new ControlP5(this);

  cp5.addButton("Filters")
    .setPosition(420, 50)
    .setSize(50, 30);
  

  cp5.addButton("Record")
    .setPosition(420, 110)
    .setSize(50, 30);
  
  Slider hue = cp5.addSlider("hue", 0, 100, 50, 420, 160, 100, 10);
  Slider saturation = cp5.addSlider("saturation", 0, 100, 50, 420, 210, 100, 10);
  Slider Color = cp5.addSlider("Color", 0, 100, 50, 420, 250, 100, 10);
    
  
}

void draw() {
  background(235, 180, 255);
  fill(0, 255, 0);
  text("Webcam Filter", 225, 30);
}
