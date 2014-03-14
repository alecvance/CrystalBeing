/*
 * CrystalBeing
 *
 * by Alec Vance 2014
 *
 * inspired by an old Star Trek episode...
 *
 */

// import PeasyCam library
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

int numSteps = 5; // how many steps to draw within each circle (360 degrees or 2 PI radians)
float radius = 280; // the radius of the sphere
float stub = 3;

/* these are the variables that store the incrementing 3D translations 
   so we can see the sphere rotate
   */
float rotX = 0.0;
float rotY = 0.0;
float rotZ = 0.0;

float stepInc = 0.0;

PVector panStartPos, totalPan, centerPos;
boolean isPanning, shiftDown;
PeasyCam camera;

void setup() {
  size(900, 700, P3D);
  background(0);
  smooth();
  colorMode(RGB, 255);
  totalPan = new PVector(0, 0);  
//  centerPos = new PVector(width/2, height/2); // with peasyCam off
  centerPos = new PVector(0, 0); // with peasyCam ON
  
  // panStartPos  = new PVector(0,0);

  isPanning = false;
  shiftDown = false;

  camera = new PeasyCam(this, 600);
}

void draw() {

  //is shift key currently being pressed?
  if (shiftDown) {
    if (! isPanning) {
      // we weren't panning, so start panning
      isPanning = true;
      // "home" position of the mouse
      panStartPos = new PVector(mouseX - totalPan.x, mouseY - totalPan.y);
    } 
    else {
      // we were panning already, so find the total vector the mouse has traveled since the shift key was first pressed
      totalPan = new PVector(mouseX - panStartPos.x, mouseY - panStartPos.y);
    }
  }  
  else {
    // shift is NOT down
    isPanning = false;
    //totalPan = new PVector(0, 0);
  }


  background(0);
  frameRate(30);
  stroke(255);
  smooth();

  rotX = rotX + .002;
  rotY = rotY + .001;

  //  rotZ = rotZ + .0005;
  stepInc = stepInc + 0.02;

  numSteps = int(3.0 + stepInc);

  float x, y, z;
  float interval =  2*PI / numSteps; 
  float colorInterval = 200 / numSteps;

  pushMatrix();
  // translate(width/2, height/2, -10);
  translate(centerPos.x + totalPan.x, centerPos.y + totalPan.y, 0+10);

  for (int a = 0;  a< numSteps; a++) {

    x = interval * a;
    pushMatrix();
    rotateX(x+rotX);


    for (int b = 0; b< numSteps; b++) {

      y = interval * b;
      pushMatrix();
      rotateY(y+rotY);


      for (int c = 0; c<numSteps; c++) {

        z = interval * c; 

        pushMatrix();
        rotateZ(z+rotZ);

        stroke(50+b*colorInterval, 50+a*colorInterval, 50+c*colorInterval, 200);

        float len = radius; 
        line(0, 10, 0, -len);
        line(-stub, -len, stub, -len);

        rotateY(PI/3);
        line(-stub, -len, stub, -len);
        rotateY(PI/3);
        line(-stub, -len, stub, -len);



        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }

  popMatrix();
}

void keyPressed()
{
  if (key == CODED && keyCode == SHIFT) {
    shiftDown = true;
  } 
  
  if(key == 'r'){
    //reset!
    
    isPanning = false;
      totalPan = new PVector(0, 0);  
  //  centerPos = new PVector(width/2, height/2); // with peasyCam off
      centerPos = new PVector(0, 0); // with peasyCam ON
  camera.reset();


  }
  

}

void keyReleased()
{
  if (key == CODED && keyCode == SHIFT) {
    shiftDown = false;
  } 
}
