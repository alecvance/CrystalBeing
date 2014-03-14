/*
 * CrystalBeing
 *
 * by Alec Vance 2014
 *
 * inspired by an old Star Trek episode...
 *
 * click and drag to move camera. shift to pan camera
 *
 */

// import PeasyCam library
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

int numSteps = 5; // how many steps to draw within each circle (360 degrees or 2 PI radians)
float radius = 280; // the radius of the sphere
float stub = 3; // length of each of the star-shaped branches at the end of each line

/* these are the variables that store the incrementing 3D translations 
 so we can see the sphere rotate
 */
float rotX = 0.0;
float rotY = 0.0;
float rotZ = 0.0;

float stepInc = 0.0;

PVector lastMouse, totalPan, centerPos;
boolean isPanning;
PeasyCam camera;

void setup() {
  size(900, 700, P3D);
  background(0);
  smooth();
  colorMode(RGB, 255);

  isPanning = false;

  camera = new PeasyCam(this, 600);
}

void draw() {

  //is shift key currently being pressed?
  if (isPanning) {

    // find the distance the mouse has traveled since the last loop
    PVector mouse = new PVector(mouseX, mouseY);
    PVector mouseDiff = PVector.sub(mouse,lastMouse);
    camera.pan(mouseDiff.x, mouseDiff.y);
    lastMouse = mouse;
  }  

  background(0);
  frameRate(30);
  stroke(255);
  smooth();

  rotX = rotX + .002;
  rotY = rotY + .001;

  //  rotZ = rotZ + .0005;
  stepInc = stepInc + 0.02;
if( int(3.0 + stepInc) > numSteps){

  numSteps = int(3.0 + stepInc);
  println("Divisions per circle: "+numSteps);
}

  float x, y, z;
  float interval =  2*PI / numSteps; 
  float colorInterval = 200 / numSteps;

  // pushMatrix(); translate(width/2, height/2, -10); // with no camera

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
        line(0, 0, 0, -len);
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

  //  popMatrix(); // with no camera
}

void keyPressed()
{
  if (key == CODED && keyCode == SHIFT) {
    // we weren't panning, so start panning
    isPanning = true;
    // "home" position of the mouse
    lastMouse = new PVector(mouseX, mouseY );
  } 

  if (key == 'r') {
    //reset!
    isPanning = false;
    camera.reset();
  }
}

void keyReleased()
{
  if (key == CODED && keyCode == SHIFT) {
    isPanning = false;
  }
}

