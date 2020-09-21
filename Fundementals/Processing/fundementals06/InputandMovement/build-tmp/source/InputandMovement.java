import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class InputandMovement extends PApplet {

float deltaTime;
float time;
player playerball;
boolean playerHit;
BallManager ballManager;

public void settings()
{
    size(640,480);
}

public void setup() 
{
  playerHit = false;
  playerball = new player(width/2, height/2);
  ballManager = new BallManager();
  ballManager.setup();
}

public void draw() 
{
  long currentTime = millis();
  deltaTime = (currentTime - time) * 0.001f;
  background(55, 255, 255);

  playerball.update();
  playerball.draw();
  ballManager.update();

  if (playerHit)
  {	
  	textSize(52);
  	textAlign(CENTER);
  	text("YOU LOSE!", width/2, height/2);
  }

  time = currentTime;
}

public class Apple extends Ball {

	public Apple () {
		super();
	}

	public Apple (int x, int y) {
		super(x, y);
	}

	public void draw()
	{
		//Change color then run ball draw function.
		fill(255, 0, 0);
		super.draw();
	}

}
class Ball {
	//Object data
	PVector position;
	PVector velocity;
	int size = 20;

	//Constructor without arguments
	public Ball () {
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
	public Ball (int x, int y) {
		position = new PVector(x, y);

		velocity = new PVector();
		velocity.x = random(10) - 5;
		velocity.y = random(10) - 5;
	}


	public void update()
	{
		//Update our position
		position.x += velocity.x;
		position.y += velocity.y;

		//Bounce if we hit a wall (reverse velocity)
		if (position.x > width || position.x < 0) {
			velocity.x *= -1;
		}
		if (position.y > height || position.y < 0) {
			velocity.y *= -1;
		}
	}

	public void draw()
	{
		//Draw our ball on the screen
		ellipse(position.x - size/2, position.y - size/2, size, size);
	}
}
Ball[] balls;
int numOfBalls = 10;


class BallManager
{
public void setup() 
{
	balls = new Ball[numOfBalls];

	for (int i = 0; i < numOfBalls; ++i) 
	{
  		if (random(0, 1) < 0.5f)
  		{
  			balls[i] = new Apple();
  		}
  	else
  		{
  			balls[i] = new Pear();
  		} 
	}
}

public void update()
{
   

	for (int i = 0; i < numOfBalls; ++i) 
  {

  	for (int j = i+1; j < numOfBalls; ++j) 
  	{
  		if (balls[i].size == 0 || balls[j].size == 0)
  		{
  			continue;
  		}
  		boolean hasCollided = roundCollision(PApplet.parseInt(balls[i].position.x), PApplet.parseInt(balls[i].position.y),
  			balls[i].size/2,
  			PApplet.parseInt(balls[j].position.x), PApplet.parseInt(balls[j].position.y),
  			balls[j].size/2);

  		if (hasCollided)
  		{
  			balls[i].size = 0;
  			balls[j].size = 0;

  		}
  	}
  	
  	balls[i].update();
  }

  for (int i = 0; i < numOfBalls; ++i) 
  {
  	balls[i].draw();
  	delay(300);
  }


}

public void playerCollisionCheck()
{
	for (int i = 0; i < numOfBalls; ++i) 
  {
  	if (balls[i].size == 0)
  	{
  		continue;
  	}

  	boolean hasCollided = roundCollision(PApplet.parseInt(balls[i].position.x), PApplet.parseInt(balls[i].position.y),
  		balls[i].size/2,
  		PApplet.parseInt(playerball.charLocation.x), PApplet.parseInt(playerball.charLocation.y),
  		playerball.ballDiameter/2);

  	if (hasCollided)
  	{
  		balls[i].size = 0;
  		playerHit = true;
  	}
  }
}

}
public class Pear extends Ball {

	public Pear () {
		//Call the ball constructor
		super();
	}

	public Pear (int x, int y) {
		super(x, y);
	}

	//Our draw will run instead of Ball draw function
	public void draw()
	{
		fill(0, 255, 0);
		ellipse(position.x, position.y, size/3, size * 1.2f);
	}
}
//Check collision, 2 circles
//x1, y1 is the position of the first circle
//size1 is the radius of the first circle
//then the same data for circle number two

//function will return true (collision) or false (no collision)
//boolean is the return type


public boolean roundCollision(int x1, int y1, int size1, int x2, int y2, int size2)
{
  int maxDistance = size1 + size2;

  //first a quick check to see if we are too far away in x or y direction
  //if we are far away we dont collide so just return false and be done.
  if(abs(x1 - x2) > maxDistance || abs(y1 - y2) > maxDistance)
  {
    return false;
  }
  //we then run the slower distance calculation
  //dist uses Pythagoras to get exact distance, if we still are to far away we are not colliding.
  else if(dist(x1, y1, x2, y2) > maxDistance)
  {
    return false;
  }
  //We now know the points are closer then the distance so we are colliding!
  else
  {
   return true;
  }
}
//A better way to do this is to have a circle object and pass the objects in to the function,
//then we just have to pass 2 objects instead of 6 different values.
boolean moveRight;
boolean moveLeft;
boolean moveUp;
boolean moveDown;
boolean gravityOn = false;
PVector vectorInput = new PVector(0,0);

public void keyPressed()
{
	if (key == 'a')
		moveLeft = true;
	else if (key == 'd')
		moveRight = true;

	if (key == 'w')
		moveUp = true;
	else if (key == 's')
		moveDown = true;

	if (key == 'g')
	{
		gravityOn = !gravityOn;
	}
}

public void keyReleased()
{
	if (key == 'a')
		moveLeft = false;
	else if (key == 'd')
		moveRight = false;

	if (key == 'w')
		moveUp = false;
	else if (key == 's')
		moveDown = false;
}

//Test function where input is easier to handle.
/*PVector inputVector()
{
	vectorInput.x = int(key == 'd') - int(key == 'a');
	vectorInput.y = int(key == 's') - int(key == 'w');

	return vectorInput.normalize();
}*/

class player
{

PVector velocity;
PVector charLocation;
float topSpeed = 7;
float decelerationSpeed = 0.85f;
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

public void update()
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

public void draw()
{
	fill(255, 255, 255);
	ellipse(charLocation.x, charLocation.y, ballDiameter, ballDiameter);
}


public void WrapPlayer()
{
  //Wrapping effect.
  if(charLocation.x >= width)
    charLocation.x = 0;
  else if (charLocation.x <= 0) 
    charLocation.x = width;
}

public void Gravity()
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "InputandMovement" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
