class Neuron {
  /*** changeable variables ***/
  float mutateAmount = 0.1; //how much to mutate next generation's neurons by
  /***   ***/

  float bias; //+-1 to output
  float weight1; //input 1 multiplier
  float weight2; //input 2 multiplier
  float weight3; //input 3 multiplier
  float output;

  float activate(float input1, float input2, float input3)
  {
    output = (weight1 * input1) + (weight2 * input2) + (weight3 * input3) + bias;
    output = 1 / (1 + exp(-output));
    return output;
  }

  Neuron() //create a new neuron - constructor method
  {
    bias = random(-1, 1);
    weight1 = random(-1, 1);
    weight2 = random(-1, 1);
    weight3 = random(-1, 1);
  }

  Neuron (Neuron neuron) //create a new method based on another neuron
  {
    bias = neuron.bias + random(-mutateAmount, mutateAmount);
    weight1 = neuron.weight1 + random(-mutateAmount, mutateAmount);
    weight2 = neuron.weight2 + random(-mutateAmount, mutateAmount);
  }
}
