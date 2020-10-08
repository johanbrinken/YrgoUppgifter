int cellSize = 8;
int columns = 600/cellSize;
int rows = 600/cellSize;
int birthChance = 50; // Chance to spawn at beginning.
int[][] grid = new int[columns][rows];
{
	for (int x = 0; x<columns; x++)
	{
		for(int y= 0; y<rows; y++)
			{
				int birth = int(random(100));
				if (birth > birthChance)
					birth = 0;
				else 
					birth = 1;

			    grid[x][y]=int(birth);
			}
	}
}

void setup() 
{
	frameRate(24);
	println(width);
	println(height);
	size(600, 600);
}

void draw() 
{
	background(0);
	int[][] bufferGrid = new int[columns][rows];

	for (int x = 1; x<columns-1; x++)
	{
		for(int y= 1; y<rows-1; y++)
			{
			    int neighbours = countNeighbours(x,y);
			    bufferGrid[x][y] = ruleCheck(grid[x][y],neighbours);
			}
	}
	grid = bufferGrid;
	drawGrid();
}

int countNeighbours(int x, int y)
{
	int neighbours = 0;
	for (int i = -1; i<= 1; i++)
	{
		for (int j =-1; j <= 1; ++j) 
		{
			neighbours += grid[x+i][y+j];
		}
	}
	neighbours -= grid[x][y];

	return(neighbours);
}

int ruleCheck(int status, int neighbours)
{
	//Dör av överpupulation
	if (status == 1 && neighbours > 3)
		return(0);
	//Underpopulation
	else if (status == 1 && neighbours < 2)
		return(0);
	//Reproduktion
	else if (status == 0 && neighbours == 3)
		return(1);
	else 
		return(status);
}

void drawGrid()
{
	for (int x = 0; x<columns; x++)
	{
		for(int y= 0; y<rows; y++)
			{
			    if(grid[x][y]==1)
			    {
			    	fill(0, 125, 255);
			    }
			    else
			    {
			    	fill(64);
			    }
			    rect(x*cellSize, y*cellSize, cellSize, cellSize);
			}
	}
}