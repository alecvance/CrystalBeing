int numSteps =5;
float len = 280;
float stub = 3;

float n1 = 0.0;
float n2 = 0.0;
float n3 = 0.0;

float ns = 0.0;

void setup() {
  size(900, 700, P3D);

  smooth();
  colorMode(RGB, 255);
}

void draw() {

  background(0);
  frameRate(30);
  stroke(255);
  smooth();

  //  n1 = n1 + .002;
  n2 = n2 + .001;

  //  n3 = n3 + .0005;
  ns = ns + 0.02;

  numSteps = int(3.0 + ns);

  float x, y, z;
  float interval =  2*PI / numSteps; 
  float colorInterval = 200 / numSteps;

  pushMatrix();
  translate(width/2, height/2, -10);

  for (int a = 0;  a< numSteps; a++) {

    x = interval * a;
    pushMatrix();
    rotateX(x+n1);


    for (int b = 0; b< numSteps; b++) {

      y = interval * b;
      pushMatrix();
      rotateY(y+n2);


      for (int c = 0; c<numSteps; c++) {

        z = interval * c;

        pushMatrix();
        rotateZ(z+n3);
        
        stroke(50+b*colorInterval, 50+a*colorInterval, 50+c*colorInterval, 200);

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

