import fisica.*;

class BuildGUI {
  
  PApplet parent;
  FWorld world;
  FWorld back;
  FCircle ball;
  FBox inWork;
  ArrayList<FBox> boxes;
  
  int selected;
  PImage left;
  PImage right;
  PImage up;
  PImage down;
  
  BuildGUI(PApplet p) {
    parent = p;
    Fisica.init(parent);
    back = new FWorld();
    world = new FWorld();
      world.setGravity(0, 800);
      world.setEdges();
    boxes = new ArrayList<FBox>();
    selected = 0;
    left = loadImage("left.png");
    right = loadImage("right.png");
    up = loadImage("up.png");
    down = loadImage("down.png");
  }
  
  void draw() {
    background(255);
    
    // Draw our physical world
    back.step();
    back.draw(parent);
    world.step();
    world.draw(parent);
    
    // Test for a change in gravity
    if (ball != null && back.getBody(ball.getX(), ball.getY()) != null) {
      String name = back.getBody(ball.getX(), ball.getY()).getName();
      if (name.equals("up"))
        world.setGravity(0, -800);
      if (name.equals("down"))
        world.setGravity(0, 800);
      if (name.equals("left"))
        world.setGravity(-800, 0);
      if (name.equals("right"))
        world.setGravity(800, 0);
    }
    
    // Draw a line being worked on
    if (inWork != null) {
      inWork.draw(parent);
    }
      
    // Draw the GUI
    strokeWeight(5);
    stroke(0);
    fill(255);
    rect(width - 80, 3, 77, height-6);
    image(up, width - 65, 15);
    image(down, width - 65, 80);
    image(left, width - 65, 145);
    image(right, width - 65, 210);
    line(width - 64, 276, width - 17, 320);
    fill(0,0,255);
    strokeWeight(1);
    ellipse(width - 41, 364, 50, 50);
    // Selected box
    strokeWeight(2);
    stroke(255,0,0);
    noFill();
    rect(width - 70, 10 + selected * 65, 58, 58);
    
  }
  
  void mousePressed() {
    world.remove(ball);
    ball = null;
    if (mouseX > width - 65) {
      selected = (mouseY - 10) / 65;
      if (selected > 5) {
        selected = 5;  
      }
    }
    else {
      if (world.getBody(mouseX, mouseY) != null) {
        if (mouseButton == RIGHT)
          world.remove(world.getBody(mouseX, mouseY));
          boxes.remove(world.getBody(mouseX, mouseY));
        return;
      }
      if (back.getBody(mouseX, mouseY) != null) {
        if (mouseButton == RIGHT)
          back.remove(back.getBody(mouseX, mouseY));
          boxes.remove(back.getBody(mouseX, mouseY));
        return;
      }
      switch (selected) {
        case 0:
          boxes.add(new FBox(50,50));
          boxes.get(boxes.size()-1).setPosition(mouseX, mouseY);
          boxes.get(boxes.size()-1).setName("up");
          boxes.get(boxes.size()-1).attachImage(up);
          boxes.get(boxes.size()-1).setStatic(true);
          back.add(boxes.get(boxes.size()-1));
          break;
        case 1:
          boxes.add(new FBox(50,50));
          boxes.get(boxes.size()-1).setPosition(mouseX, mouseY);
          boxes.get(boxes.size()-1).setName("down");
          boxes.get(boxes.size()-1).attachImage(down);
          boxes.get(boxes.size()-1).setStatic(true);
          back.add(boxes.get(boxes.size()-1));
          break;
        case 2:
          boxes.add(new FBox(50,50));
          boxes.get(boxes.size()-1).setPosition(mouseX, mouseY);
          boxes.get(boxes.size()-1).setName("left");
          boxes.get(boxes.size()-1).attachImage(left);
          boxes.get(boxes.size()-1).setStatic(true);
          back.add(boxes.get(boxes.size()-1));
          break;
        case 3:
          boxes.add(new FBox(50,50));
          boxes.get(boxes.size()-1).setPosition(mouseX, mouseY);
          boxes.get(boxes.size()-1).setName("right");
          boxes.get(boxes.size()-1).attachImage(right);
          boxes.get(boxes.size()-1).setStatic(true);
          back.add(boxes.get(boxes.size()-1));
          break;
        case 4:
          inWork = new FBox(10, 10);
          inWork.setPosition(mouseX, mouseY);
          inWork.setFill(0);
          inWork.setStatic(true);
          break;
        case 5:
          ball = new FCircle(50);
          ball.setFill(0,0,255);
          ball.setPosition(mouseX, mouseY);
          world.add(ball);
          world.setGravity(0, 800);
          break;
      }
    } 
  }
  
  void mouseReleased() {
    if (inWork != null) {
      boxes.add(inWork);
      world.add(boxes.get(boxes.size()-1));
      inWork = null;
    }
  }
  
  void mouseDragged() {
    if (inWork != null) {
      float x = inWork.getX();
      float y = inWork.getY();
      float dx = mouseX - x;
      float dy = mouseY - y;
      float l = sqrt(dx*dx + dy*dy) * 2;
      inWork = new FBox(l, 10);
      inWork.setPosition(x, y);
      inWork.setFill(0);
      inWork.setStatic(true);
      inWork.setRotation(atan(dy/dx));
    }
  }

  
}
