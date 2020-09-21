Ball[] balls;
int numOfBalls = 10;
int curNumOfBalls = 0;


class BallManager
{
void setup() 
{
	balls = new Ball[numOfBalls];

	for (int i = 0; i < numOfBalls; ++i) 
	{
  		if (random(0, 1) < 0.5)
  		{
  			balls[i] = new Apple();
  		}
  	else
  		{
  			balls[i] = new Pear();
  		} 
	}
}

void update()
{
   

	for (int i = 0; i < numOfBalls; ++i) 
  {

  	for (int j = i+1; j < numOfBalls; ++j) 
  	{
  		if (balls[i].size == 0 || balls[j].size == 0)
  		{
  			continue;
  		}
  		boolean hasCollided = roundCollision(int(balls[i].position.x), int(balls[i].position.y),
  			balls[i].size/2,
  			int(balls[j].position.x), int(balls[j].position.y),
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
  }
}

void AddNewBalls(float waitTime)
{
	//ADD NEW BALLS
}

void playerCollisionCheck()
{
	for (int i = 0; i < numOfBalls; ++i) 
  {
  	if (balls[i].size == 0)
  	{
  		continue;
  	}

  	boolean hasCollided = roundCollision(int(balls[i].position.x), int(balls[i].position.y),
  		balls[i].size/2,
  		int(playerball.charLocation.x), int(playerball.charLocation.y),
  		playerball.ballDiameter/2);

  	if (hasCollided)
  	{
  		balls[i].size = 0;
  		playerHit = true;
  	}
  }
}

}