public class Apple extends Ball {

	public Apple () {
		super();
	}

	public Apple (int x, int y) {
		super(x, y);
	}

	void draw()
	{
		//Change color then run ball draw function.
		fill(255, 0, 0);
		super.draw();
	}

}
