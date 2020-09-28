boolean moveRight;
boolean moveLeft;
boolean moveUp;
boolean moveDown;
boolean gravityOn = false;
PVector vectorInput = new PVector(0,0);

void keyPressed()
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

void keyReleased()
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