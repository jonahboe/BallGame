BuildGUI myGUI;

void setup() {
  frameRate(20);
  
  fullScreen();
  
  myGUI = new BuildGUI(this);
  
}



void draw() {
  myGUI.draw();  
}



void mousePressed() {
  myGUI.mousePressed();
}



void mouseReleased() {
  myGUI.mouseReleased();
}



void mouseDragged() {
  myGUI.mouseDragged();
}
