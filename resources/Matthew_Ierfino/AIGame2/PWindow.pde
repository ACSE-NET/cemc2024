class PWindow extends PApplet { 
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size (50*L + 50, 50*H + 50);
  }

  void draw() {
    background(255);
    text("Current Generation: " + currentGeneration, 10, 50*H + 40);

    if (winner != null)
      drawNetwork(winner);
  }


  float neuronOffset = 50;
  void drawNetwork(LittleGuy guy) {

    //draw inputs
    for (int i = 0; i < H; i++)
    { 
      strokeWeight(1);
      fill(map(guy.inputs[i], 0, 1, 0, 255), 0, map(guy.inputs[i], 0, -1, 0, 255));
      ellipse(25, 25 + i*neuronOffset, 30, 30);
    }

    //draw neural network
    for (int i = 0; i < L; i++)
    {
      for (int j = 0; j < H; j++)
      {
        drawNeuron(guy.neurons[i][j], i*neuronOffset + 75, j*neuronOffset + 25);
      }
    }
  }

  void drawNeuron(Neuron neuron, float x, float y)
  {  
    strokeWeight(1); 
    fill(map(neuron.output, 0, 1, 0, 255), 0, 0);
    ellipse(x, y, 30, 30); 
    strokeWeight(max(0, map(neuron.weight1, -1, 1, 0, 5))); 
    line(x - neuronOffset, y, x, y); 
    strokeWeight(max(0, map(neuron.weight2, -1, 1, 0, 5))); 
    line(x - neuronOffset, y - neuronOffset, x, y);
    strokeWeight(max(0, map(neuron.weight3, -1, 1, 0, 5))); 
    line(x - neuronOffset, y + neuronOffset, x, y);
  }
}
