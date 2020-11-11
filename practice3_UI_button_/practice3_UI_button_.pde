import controlP5.*;
  ControlP5 cp5;

  void setup() {
    size(1100,700);
    cp5 = new ControlP5(this);
    cp5.addSlider("mySlider").setPosition(1000,600).setSize(200,20);
    cp5.addButton("boo").
        setValue(0).
        setPosition(800,600).
        setSize(100,40);

  }

  void draw() {
     background(0);
  }
  
  public void boo(){
    println("boo");//funcitons triggered by button
  }
 
     
