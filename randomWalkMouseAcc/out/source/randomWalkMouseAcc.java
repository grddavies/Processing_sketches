import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class randomWalkMouseAcc extends PApplet {

class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector mouse;
  float topspeed;
  
  Mover() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    topspeed = 15;
  }
  
  public void applyForce(PVector force) {
    acc.add(force);
  }
  
  public void update() {
    mouse = new PVector(mouseX, mouseY);
    acc.add(mouse.sub(pos).normalize());
    acc = acc.mult(1/acc.magSq()).limit(topspeed);
    vel.add(acc);
    vel.limit(topspeed);
    pos.add(vel);
    acc.mult(0);
  }

  public void display() {
    stroke(0);
    fill(175);
    ellipse(pos.x, pos.y, 30, 30);
  }
  
  public void checkEdges() {
    if (pos.x > width){
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height){
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height;
    }
  }

  public boolean isInside(Liquid l) {
    if(pos.x > l.x && pos.x < l.x+l.w && pos.y > l.y && pos.y < l.y+l.h)
    {
      return true;
    } else {
      return false;
    }
  }

  public void drag(Liquid l) {
    float speed = vel.mag();
    float dragMagnitude = l.c*speed*speed;
    PVector drag = vel.copy();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    applyForce(drag);
  }
}

class Liquid {
  float x, y, w, h;
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  public void display() {
    noStroke();
    fill(150);
    rect(x, y, w, y);
  }
}

// MAIN
Mover[] movers = new Mover[8];
Liquid liquid;
float t = 0;
PVector wind;


public void setup(){
  
  liquid = new Liquid(1, height/2, width, height/2, 100000);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

public void draw(){
  background(255);
  liquid.display();
  wind = new PVector(noise(t), noise(t + 200));
  wind.mult(1.1f);
  for (int i = 0; i < movers.length; i++) {
    if (movers[i].isInside(liquid)){
      movers[i].drag(liquid);
    }
    movers[i].applyForce(wind);
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
    t++;
  }
}
  public void settings() {  size(640, 640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "randomWalkMouseAcc" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
