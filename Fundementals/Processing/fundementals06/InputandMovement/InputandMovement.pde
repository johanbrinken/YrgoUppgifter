float deltaTime;
float time;
player playerball;
boolean playerHit;
BallManager ballManager;

void settings()
{
    size(640,480);
}

void setup() 
{
  playerHit = false;
  playerball = new player(width/2, height/2);
  ballManager = new BallManager();
  ballManager.setup();
}

void draw() 
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

