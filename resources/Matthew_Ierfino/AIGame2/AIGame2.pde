/*** changeable variables ***/
int numGuys = 16; //number of agents to simulate
int numGuysBasedOnWinner = 8; //number of agents in subsequent generations based on the winner of the previous gen. All other agents will be randomized
/***   ***/

float goalX, goalY; //goal position
int currentGeneration = 0;
LittleGuy[] guys;
LittleGuy winner;
boolean restart = false;
PWindow win;

void setup()
{
  win = new PWindow();
  guys = new LittleGuy[numGuys];

  smooth();//anti-alias

  for (int i = 0; i < numGuys; i++)
  { //initialize all agents
    guys[i] = new LittleGuy();
  }

  size(400, 400);
  translate(width/2, height/2); //translate to centre
  textSize(13);

  float radius = width/3;
  float goalPos = random(6.28);
  goalX = radius*sin(goalPos); //randomize goal position
  goalY = radius*cos(goalPos);
}

//public void settings() {
//  size(400, 400);
//}

void draw() {
  translate(width/2, height/2); //translate to centre

  noStroke();
  fill(255, 255, 255, 4);
  rect(-400, -400, 800, 800);

  if (!restart) {
    for (int i = 0; i < numGuys; i++)
    {
      guys[i].update(); //update each agent
    }
  } else // Restart
  {
    for (int i = 0; i < numGuys; i++)
    {
      if (i < numGuysBasedOnWinner)//first half of the list
      {
        guys[i].mutate(winner);//mutate based off of the winner
        guys[i].x = 0; //reset position, angle
        guys[i].y = 0;
        guys[i].angle = 0;
      } else
      { //recreate new LittleGuys
        guys[i] = new LittleGuy();
      }
    }
    currentGeneration++;

    float radius = width/3;
    float goalPos = random(6.28);
    goalX = radius*sin(goalPos); //randomize goal position
    goalY = radius*cos(goalPos);
    background(255);
    restart = false;
  }

  fill(255);
  stroke(2);
  ellipse(goalX, goalY, 50, 50); //draw goal
  fill(2);
  text("Click to start a new generation based on the agent closest to the goal", -190, 190 );
}

void mousePressed() {
  //when clicked, the closest agent to the goal is declared the "winner"
  float closestDistance = 1000;

  for (int i = 0; i < numGuys; i++)
  { //sort through list to find the closest agent to goal
    float currentDistance = dist(guys[i].x, guys[i].y, goalX, goalY);
    if (currentDistance < closestDistance)
    {
      winner = guys[i];
      closestDistance = currentDistance;
    }
  }
  restart = true;
}
