class character {
  //Object data
  PVector position;
  PVector velocity;
  int size = 20;

  //Constructor without arguments
  public character () {
    //Create vector objects
    position = new PVector();

    //Set random start pos
    position.x = random(0, width);
    position.y = random(0, height);

    //Create vector for velocity and set random direction
    velocity = new PVector();
    velocity.x = random(10) - 5;
    velocity.y = random(10) - 5;
  }

  //Constructor with position arguments
  public character (int x, int y) {
    position = new PVector(x, y);

    velocity = new PVector();
    velocity.x = random(10) - 5;
    velocity.y = random(10) - 5;
  }


  void update()
  {
    //Update our position
    position.x += velocity.x;
    position.y += velocity.y;

    //Bounce if we hit a wall (reverse velocity)
    if(position.x >= width)
    position.x = 0;
    else if (position.x <= 0) 
    position.x = width;

    if(position.y >= height)
    position.y = 0;
    else if (position.y <= 0) 
    position.y = height;
  }

  void draw()
  {
    //Draw our ball on the screen
    ellipse(position.x - size/2, position.y - size/2, size, size);
  }
}
