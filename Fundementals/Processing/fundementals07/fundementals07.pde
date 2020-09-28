float deltaTime;
float time;
float survivedDuration;
player playerball;
boolean playerHit;
CharacterManager charManager;

void settings()
{
    size(640,480);
}

void setup() 
{
  survivedDuration = 0;
  playerHit = false;
  playerball = new player(width/2, height/2);
  charManager = new CharacterManager();
  charManager.setup();
}

void draw() 
{
  long currentTime = millis();
  deltaTime = (currentTime - time) * 0.001f;

  if (humansAlive)
    survivedDuration += deltaTime;

  background(55, 255, 255);

  playerball.update();
  playerball.draw();
  charManager.update();

  if (!humansAlive)
  {	
  	textSize(52);
  	textAlign(CENTER);
    fill(0);
  	text("YOU LOSE!", width/2, height/2);
    text("\n Time:"+survivedDuration, width/2, height/2);
  }

  time = currentTime;
}

