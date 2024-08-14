/*** changeable variables ***/
int L = 3; //length of neuron matrix - MIN 2
int H = 3; //height of neuron matrix - MIN 3
/***   ***/

class LittleGuy {
  float x, y; //current position
  float angle; //current angle
  float r, g, b; //colour
  Neuron[][] neurons;

  LittleGuy() {
    neurons = new Neuron[L][H];
    inputs = new float[H];
    outputs = new float[H];

    for (int i = 0; i < L; i++)
    {
      for (int j = 0; j < H; j++)
      {
        neurons[i][j] = new Neuron();
      }
    }

    r = random(255);
    g = random(255);
    b = random(255);

    x = 0;
    y = 0;
    angle = 0;
  }


  float[] inputs;
  float[] outputs;

  void update()
  {
    float distance = dist(x, y, goalX, goalY);
    float maxDist = width/3;
    inputs[0] = distance/maxDist; //distance as percent

    float forwardX = 15*cos(angle) + x;
    float forwardY = 15*sin(angle) + y;
    float cross = (forwardX - x)*(goalY - y) - (forwardY - y)*(goalX - x); //cross product
    inputs[1] = map(cross, -100, 100, -1, 1);

    inputs[2] = map(second(), 0, 59, -1, 1);

    for (int i = 0; i < L; i++)
    { //interate through all neurons
      for (int j = 0; j < H; j++)
      {
        if (i == 0) { //first layer takes input from initial inputs
          if (j == 0) //first neuron
          {
            neurons[i][j].activate(inputs[j], inputs[H-1], inputs[j+1]);
          } else if (j == H-1) //last neuron in layer
          {
            neurons[i][j].activate(inputs[j], inputs[j-1], inputs[0]);
          } else
          {
            neurons[i][j].activate(inputs[j], inputs[j-1], inputs[j+1]);
          }
        } else
        {
          if (j == 0)
          {
            outputs[j] = neurons[i][j].activate(neurons[i-1][j].output, neurons[i-1][H-1].output, neurons[i-1][j+1].output);
          } else if (j == H-1)
          {
            outputs[j] = neurons[i][j].activate(neurons[i-1][j].output, neurons[i-1][j-1].output, neurons[i-1][0].output);
          } else
          {
            outputs[j] = neurons[i][j].activate(neurons[i-1][j].output, neurons[i-1][j-1].output, neurons[i-1][j+1].output);
          }
        }
      }
    }


    float rotateL = outputs[0];//output1
    float rotateR = outputs[1];//output2
    float speed = outputs[2];//output3

    float rotation = rotateL - rotateR;
    angle += rotation;
    float xMovement = cos(angle);
    float yMovement = sin(angle);
    x += xMovement * speed;
    y += yMovement * speed;


    //draw
    if (winner != null && this == winner)
    { //draw outline if this guy is the previous winner
      fill(0);
      ellipse(x, y, 30, 30);
      fill(255);
      ellipse(x, y, 28, 28);
    }
    fill(r, g, b);
    ellipse(x, y, 25, 25); //draw body
    fill(0);
    ellipse(forwardX, forwardY, 5, 5); //draw "nose"

    if (dist(x, y, goalX, goalY) < 25) 
    { //if close enough to the goal
      winner = this; //this agent is the winner
      restart = true; //restart the simulation
    }
  }

  void mutate(LittleGuy winner)
  {
    r = winner.r + random(-25, 25);
    g = winner.g + random(-25, 25);
    b = winner.b + random(-25, 25);

    for (int i = 0; i < L; i++)
    {
      for (int j = 0; j < H; j++)
      {
        neurons[i][j] = new Neuron(winner.neurons[i][j]);
      }
    }
  }
}
