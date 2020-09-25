static final int NUM_LINES = 12;

float t;
float d;

void setup() {
  colorMode(RGB);
  fullScreen();
  noStroke();
  fill(0);
}

void draw() {
  background(20);
  strokeWeight(5);
  
  translate(width/2, height/2);


  d = sin(t/7);
  for (float i = TWO_PI; i > -1; i-=TWO_PI/NUM_LINES) {
      line(x1(t + d*i), y1(t/2 + d*i), x2(t/2 - d*i), y2(t - d*i));
      line(x2(t/2 - d*i), y2(t - d*i), x3(t + d*i), y3(t + d*i));
      stroke(0, 90 + 90*cos(t/13), i/TWO_PI*255, i/TWO_PI*255);
  
}
  t+=0.05;
}

float x1(float t) {
  return 250*sin(t/2);
}

float y1(float t) {
  return 250*cos(t/2);
}

float x2(float t) {
  return 250*sin(t/2);
}

float y2(float t) {
  return 250*cos(t/2);
}

float x3(float t) {
  return 250*cos(t/5);
}

float y3(float t) {
  return 250*sin(t/5);
}
