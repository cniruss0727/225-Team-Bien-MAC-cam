boolean pictureSaved = false;

void createSavePictureWindow(){
  savePictureWindow = GWindow.getWindow(this, "savePictureWindow", 650, 700, 400, 200, P2D);
  savePictureWindow.setVisible(false);
  savePictureWindow.addDrawHandler(this, "drawSaveWindow");
  savePictureWindow.setAlwaysOnTop(true); 
  savePictureWindow.setTitle("");
  //savePictureWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  
  createWindowCp5();
}


public void drawSaveWindow(PApplet app, GWinData data){
  app.background(255);
}

public void createWindowCp5(){
  savePictureCp5 = new ControlP5(savePictureWindow, new ControlFont(createFont("Georgia", 14)));
  //GTextField savePictureTextField = new GTextField(savePictureWindow, 100, 50, 150, 30);
  //GLabel savePictureText = new GLabel(savePictureWindow, 125, 10, 200, 50, "Enter a name for your photo: ");
  //GButton savePictureButton = new GButton(savePictureWindow, 250, 100, 100, 50, "Save");
  //GButton cancelSavePictureButton = new GButton(savePictureWindow, 50, 100, 100, 50, "Cancel");
  
  savePictureCp5.addTextlabel("text")
    .setText("Enter a name for your photo: ") 
    .setColorValue(color(0, 0, 0))
    .setFont(createFont("Georgia", 20))
    .setPosition(50, 10)
    .setSize(100, 20);
  
  savePictureCp5.addTextfield("savePictureTextField")
    .setPosition(100, 50)
    .setSize(150, 30);
    
  Button saveButton = savePictureCp5.addButton("saveButton")
    .setPosition(250, 100)
    .setSize(100, 50)
    .setLabel("Save");
    
  Button cancelButton = savePictureCp5.addButton("cancelButton")
    .setPosition(50, 100)
    .setSize(100, 50)
    .setLabel("Cancel");
    
    
 //Adds callback listeners for the save and cancel buttons.
 
  saveButton.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): break;
        case(ControlP5.ACTION_RELEASED): saveButton(); break;
      }
    }
  }
  );
  
  cancelButton.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): break;
        case(ControlP5.ACTION_RELEASED): cancelButton(); break;
      }
    }
  }
  );
 
}

public void saveButton(){
  print("saved!");
  pictureSaved = true;
  ((Button)cp5.get("takePhoto")).setOff();
  savePictureWindow.setVisible(false);
}

public void cancelButton(){
  print("cancelled");
  pictureSaved = false;
  ((Button)cp5.get("takePhoto")).setOff();
  savePictureWindow.setVisible(false);
}
