
class player
{

PVector velocity;
PVector charLocation;
float topSpeed = 7;
float decelerationSpeed = 0.85;
int ballDiameter = 20;
float xInput = 0;
float yInput = 0;
float v = 1;

public player(int x, int y)
{
	ellipseMode(CENTER);  
	charLocation = new PVector(x, y);

	velocity = new PVector(0,0);
	xInput = 0;
    yInput = 0;
}

void update()
{

  if (gravityOn)
    Gravity();

  if (moveLeft)
  {
    xInput -= v;
  }
  if (moveRight)
  {
    xInput += v;
  }
  if (moveUp)
  {
    yInput -= v;
  }
  if (moveDown)
  {
    yInput += v;
  }
  //If there is no player input the xInput will reset to start deceleration.
  if (!moveLeft && !moveRight)
  {
    xInput = 0;
  }
  
  if (!moveDown && !moveUp)
  {
    yInput = 0;
  }


    //Creates a acceleration vector with player input and sets the magnitude of that vector.
  PVector acceleration = new PVector(xInput, yInput);
  acceleration.setMag(15f);

  //Deceleration if no input is registered.
  if (yInput == 0)
    velocity.y *= decelerationSpeed;
  else
    velocity.add(acceleration.mult(deltaTime));
  if (xInput == 0)
    velocity.x *= decelerationSpeed;
  else
    velocity.add(acceleration.mult(deltaTime));

  xInput = constrain(xInput, -topSpeed, topSpeed);
  yInput = constrain(yInput, -topSpeed, topSpeed);
  charLocation.y = constrain(charLocation.y, 0+ballDiameter/2, height-ballDiameter/2);
  charLocation.x = constrain(charLocation.x, 0, width);

  //Limits the velocity vector and adds to vector to the character location vector.
  velocity.limit(topSpeed);
  charLocation.add(velocity);

  WrapPlayer();
}

void draw()
{
	fill(255, 255, 255);
	ellipse(charLocation.x, charLocation.y, ballDiameter, ballDiameter);
}


void WrapPlayer()
{
  //Wrapping effect.
  if(charLocation.x >= width)
    charLocation.x = 0;
  else if (charLocation.x <= 0) 
    charLocation.x = width;
}

void Gravity()
{
  //Creates artificial gravity if turned on.
  println("Gravity On!");
  if (charLocation.y < height)
    velocity.y += v + 10 * deltaTime;
  //Bounce determined by the ball diameter to register on the edge instead of inside.
  if (charLocation.y >= height-ballDiameter/2)
    velocity.y *= -1;
  if (charLocation.y <= 0+ballDiameter/2)
    velocity.y *= -1;
}

}
