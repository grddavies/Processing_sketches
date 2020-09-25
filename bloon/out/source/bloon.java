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

public class bloon extends PApplet {

class Bloon {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  float radius; 
  float topspeed;
  
  Bloon(float r, float x, float y) {
    radius = r;
    mass = PI*r*r;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    topspeed = 15;
  }
  
  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }

  public void update() {
    vel.add(acc);
    vel.limit(topspeed);
    pos.add(vel);
    acc.mult(0);
  }
  
  public void checkEdges(){
    boolean bounce_y = false;
    boolean bounce_x = false;
    if (pos.y > height - radius){
      pos.y = height - radius;
      bounce_y = true;
    } else if (pos.y < radius){
      pos.y = radius;
      bounce_y = true;
    }

    if (pos.x > width - radius){
      pos.x = width - radius;
      bounce_x = true;
    } else if (pos.x < radius){
      pos.x = radius;
      bounce_x = true;
    }
    if (bounce_y) {
    vel.y *= -1;
  } if (bounce_x) {
    vel.x *= -1;
  }}
  
  public void display() {
    stroke(0);
    fill(254, 127, 156);
    ellipse(pos.x, pos.y, 2*radius, 2*radius);
  }
  
}

// main
Bloon[] bloons  = new Bloon[10];
PVector wind;
PVector gravity;
PVector repel;
PVector friction;
PVector yeet;
float t = 0;

public void setup() {
  
  for (int i = 0; i < bloons.length; i++){
    bloons[i] = new Bloon(random(5, 25), 0, 0);
  }

}

public void draw() {
  background(255);
  wind = new PVector(1.5f, 0);
  for (int i = 0; i < bloons.length; i++){
    repel = new PVector(-1/sq((width - bloons[i].pos.x)/640), 0);
    float m = bloons[i].mass;
    gravity = new PVector(0, 0.1f*m);
    bloons[i].applyForce(repel.mult(0.2f));
    bloons[i].applyForce(gravity);
    bloons[i].applyForce(wind);
    if (bloons[i].pos.x < 50){yeet = bloons[i].vel.copy().normalize().mult(20);}
    if (bloons[i].pos.x > width - 50){friction = bloons[i].vel.copy().mult(-1).normalize().mult(20);}

    bloons[i].applyForce(yeet);
    bloons[i].update();
    bloons[i].checkEdges();
    bloons[i].display();
  }
  t += 1;
}
  public void settings() {  size (640, 640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "bloon" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
