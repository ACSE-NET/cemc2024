int netX = 175;
int netY = 50;            // Position of net 
int netWidth = 250;       // Width of net
int netHeight = 135;     // Height of net

int ballX;
int ballY;            // Position of ball (unused, mouse position is used instead)
int ballSize = 40;   // Diameter of ball

PImage soccerNet;
PImage soccerBall;

// Change this variable to TRUE if the ball is in the net
boolean goalScored = false; 

void setup() {
  size(600, 400);

  soccerNet = loadImage("soccernet.png"); // load net image
  soccerNet.resize(netWidth, netHeight); // set size of net to netWidth/Height

  soccerBall = loadImage("soccerball.png"); // load ball image
  soccerBall.resize(ballSize, ballSize); // set size of ball to ballSize
}

void draw() {
  background(200, 255, 200); 

  /* ---------------
   RECTANGLE COLLISION CODE GOES HERE
   
   if (soccerBall within soccerNet)
   {
   goalScored = true;
   print("Goal!");
   }
   --------------- */

  // Draw net
  image(soccerNet, netX, netY);
  // Representation of net collision
  fill(0, 255, 255, 55);
  rect(netX, netY, netWidth, netHeight);

  // Draw ball at mouse position
  ballX = mouseX;
  ballY = mouseY;
  image(soccerBall, ballX, ballY); 
  // Representation of ball collision
  fill(255, 255, 0, 55);
  rect(ballX, ballY, ballSize, ballSize);
}
