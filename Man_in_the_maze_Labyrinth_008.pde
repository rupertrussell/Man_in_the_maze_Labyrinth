// Draws The man in the maze Labyrinth
// by Rupert Russell
// artwork on Rebbubble at: https://www.redbubble.com/people/rupertrussell
// code on Github at: https://github.com/rupertrussell/
// 22 March 2020
// Thanks to: https://blogmymaze.wordpress.com/tag/pdf/
// https://blogmymaze.files.wordpress.com/2009/09/man_maze_en.pdf
// thanks to: https://forum.processing.org/two/discussion/90/point-and-line-intersection-detection

int scale = 45;

float r1 = 1 * scale;
float r2 = 2 * scale;
float r3 = 3 * scale;
float r4 = 4 * scale;
float r5 = 5 * scale;
float r6 = 6 * scale;
float r7 = 7 * scale;
float r8 = 8 * scale;
float r9 = 9 * scale;
float r10 = 10 * scale;
float r11 = 11 * scale;

float[] saveCircleX;
float[] saveCircleY; 


float r8end = radians(360 + 22.5);
float r8start = radians(180);

int nPoints = 1;

PVector p;
float x0, y0, radius;

import processing.pdf.*;
void setup() {
  x0 = 0;
  y0 = 0;

  radius = r8;
  p = new PVector(0, 0);

  saveCircleX = new float[360]; // store x Points for the circles
  saveCircleY = new float[360]; // store y Points for the circles

  strokeCap(SQUARE);
  size(800, 800);
  background(255);
  noLoop();
  // beginRecord(PDF, "man_in_the_maze_labyrinth_001.pdf");
}

void draw() {
  boolean displayGuideLines = true;
  background(255);
  translate(width/2, height/2);
  rectMode(CENTER);  // Set rectMode to CENTER
  noFill();
  stroke(255, 0, 0); // red
  strokeWeight(1);

  step1(displayGuideLines);
  step2(true);
}

void step1(boolean displayGuideLines) {
  // Guide Lines
  if (displayGuideLines) {
    circle(0, 0, r1);  
    circle(0, 0, r2); 
    circle(0, 0, r3); 
    circle(0, 0, r4); 
    circle(0, 0, r5); 
    circle(0, 0, r6); 
    circle(0, 0, r7); 
    circle(0, 0, r8); 
    circle(0, 0, r9); 
    circle(0, 0, r10); 
    circle(0, 0, r11);
  }

  // Outter square
  rect(0, 0, 12 * scale, 12 * scale);

  // spokes
  stroke(0, 0, 255);// blue
  line(0, -6 * scale, 0, 6 * scale); // center verticle line
  line( (4.97 /2) * scale, (-12 / 2) * scale, (-4.97 /2) * scale, (12 /2) * scale); // 1st clockwise from center verticle line 
  line(-6 * scale, -6 * scale, 6 * scale, 6 * scale); // 2nd clockwise from center verticle line 
  line(-6 * scale, 6 * scale, 6 * scale, -6 * scale); // 2nd clockwise from center verticle line 
  line(-6 * scale, (4.97 /2) * scale, 6* scale, -(4.97 /2) * scale); // 3rd clockwise from center verticle line
  line(-6 * scale, 0, 6 * scale, 0 ); // 3rd clockwise Horizontal line
  line(6* scale, (4.97 /2) * scale, -6 * scale, (-4.97 /2) * scale); // 4th clockwise from center verticle line
  line((4.97 /2) * scale, 6 * scale, (-4.97 /2) * scale, (-12 /2) * scale); // 6th clockwise from center verticle line
}

void step2 (boolean displayDesign) {
  if (displayDesign) {
    stroke(255, 0, 0);
    strokeWeight(5);
    arc(0, 0, r8, r8, r8start, r8end);
    strokeWeight(1);
    findIntersection(6 * scale, (4.97 /2) * scale );
  }
}


void findIntersection(float endX, float endY) {
  PVector line = new PVector(endX, endY);
  stroke(0, 0, 255);
  strokeWeight(2);
 // line(p.x, p.y, line.x, line.y);

  PVector sub = PVector.sub(line, p);
  radius =  radius /2;
  float a = sub.y / sub.x;
  float b = p.y - a * p.x;
  float A = (1 + a * a);
  float B = (2 * a *( b - y0) - 2 * x0);
  float C = (x0 * x0 + (b - y0) * (b - y0)) - (radius * radius);
  float delta = B * B - 4 * A * C;


  if (delta >= 0) {
    stroke(255, 0, 0);
    strokeWeight(5);
    float x1 = (-B - sqrt(delta)) / (2 * A);
    float y1 = a * x1 + b;
    // ellipse(x1, y1, 10, 10);

    if ((x1 > min(p.x, line.x)) && (x1 < max(p.x, line.x)) && (y1 > min(p.y, line.y)) && (y1 < max(p.y, line.y))) {
    }
    float x2 = (-B + sqrt(delta)) / (2 * A);
    float y2 = a * x2 + b;
    if ((x2 > min(p.x, line.x)) && (x2 < max(p.x, line.x)) && (y2 > min(p.y, line.y)) && (y2 < max(p.y, line.y))) {
      // ellipse(x2, y2, 10, 10); // show intersection point
      line(0,0,x2,y2);
    }
  }
}
