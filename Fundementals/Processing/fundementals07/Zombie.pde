public class Zombie extends character 
{

  public Zombie ()
  {
    super();
  }

  public Zombie (int x, int y)
  {
    super(x, y);
  }

  void draw()
  {
    //Change color then run ball draw function.
    fill(0, 255, 0);
    velocity.x = constrain(velocity.x, -1, 1);
    velocity.y = constrain(velocity.y, -1, 1);
    super.draw();
  }

}
