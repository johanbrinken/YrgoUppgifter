character[] characters;
int numOfCharacters = 100;
int amountOfHumans = 0;
int curNumOfCharacters = 0;
boolean humansAlive = true; 


class CharacterManager
{
  void setup() 
  {
    characters = new character[numOfCharacters];

    for (int i = 0; i < numOfCharacters; ++i) 
    {
      if (i % 99 == 1)
        characters[i] = new Zombie();
      else 
        characters[i] = new Human();
    }
  }
 

  void update()
  {


    for (int i = 0; i < numOfCharacters; ++i) 
    {
      for (int j = i + 1; j < numOfCharacters; ++j) 
    {


    boolean hasCollidedWithZombie = roundCollision(int(characters[i].position.x),
     int(characters[i].position.y), characters[i].size/2,
      int(characters[j].position.x),
       int(characters[j].position.y), characters[j].size/2);


        if (hasCollidedWithZombie)
        {
          if (characters[i].getClass() == Zombie.class && characters[j].getClass() != Zombie.class)
          {
            characters[j] = new Zombie();
          }
          if (characters[j].getClass() == Zombie.class && characters[i].getClass() != Zombie.class)
          {
            characters[i] = new Zombie();
          }
        }
    }
    characters[i].update();
    }

    for (int i = 0; i < numOfCharacters; ++i) 
    {
      if(characters[i].getClass() == Human.class)
      {
        humansAlive = true;
        break;
      }
      humansAlive = false;
    }

    for (int i = 0; i < numOfCharacters; ++i) 
    {
      characters[i].draw();
    }
  }
}
