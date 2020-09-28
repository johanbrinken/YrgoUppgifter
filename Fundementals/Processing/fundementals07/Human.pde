public class Human extends character {

  public Human ()
  {
    super();
  }

  public Human (int x, int y)
  {
    super(x, y);
  }

  void draw()
  {
    //Change color then run ball draw function.
    fill(255, 255, 255);
    super.draw();
  }

}
