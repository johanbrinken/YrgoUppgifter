public class Pear extends Ball {

	public Pear () {
		//Call the ball constructor
		super();
	}

	public Pear (int x, int y) {
		super(x, y);
	}

	//Our draw will run instead of Ball draw function
	void draw()
	{
		fill(0, 255, 0);
		ellipse(position.x, position.y, size/3, size * 1.2);
	}
}
