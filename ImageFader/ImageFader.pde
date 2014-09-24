
// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="sea.jpg"; */ 

PImage img;
int direction = 1;
float signal;

void setup() {
  size(640, 360);
  noFill();
  stroke(255);
  frameRate(30);
  img = loadImage("sea.jpg");
}

void draw() {
    int sx = int(signal) % img.width;
  int sy = int(signal) / img.width;
  

    signal += 0.33*direction;
        color c = img.get(sx, sy);
    background(c);
  




}
