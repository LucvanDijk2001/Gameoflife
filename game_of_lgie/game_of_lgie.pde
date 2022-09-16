int gridsize = 40;
int[][] cells = new int[gridsize][gridsize];
int cellsize;
int[][] cc = new int[gridsize][gridsize];

boolean gamestart = false;
boolean kd = false;


float speed = 0.5;
float ispeed = speed;

void setup()
{
  size(800, 800);
  for (int i = 0; i < gridsize; i++)
  {
    for (int j = 0; j < gridsize; j++)
    {
      cells[i][j] = 0;
    }
  }
  cellsize = width / gridsize;
  background(255);
  strokeWeight(1);
  stroke(0);
}

void draw()
{
  background(255);
  if (!gamestart)
  {
    if (mousePressed)
    {
      int cx = round(mouseX/cellsize);
      int cy =round(mouseY/cellsize);
      if (cx >= 0 && cx <= gridsize-1 && cy >= 0 && cy <= gridsize-1)
      {
        if (mouseButton == LEFT) 
        {
          cells[cx][cy] = 1;
        } else
        {
          cells[cx][cy] = 0;
        }
      }
    } 

    if (keyPressed)
    {
      if (key == 'w')
      {
        if (!kd)
        {
          kd = true;
          gamestart = !gamestart;
        }
      }
      if (key == 's')
      {
        if (!kd)
        {
          float rc = random(0, 1);
          for (int i = 0; i < gridsize; i++)
          {
            for (int j = 0; j < gridsize; j++)
            {
              if (random(0, 1) < rc)
              {
                cells[i][j] = 1;
              } else
              {
                cells[i][j] = 0;
              }
            }
          }
          kd = true;
        }
      }
      if (key == 'd')
      {
        if (!kd)
        {
          int a = 0;
          for (int i = 0; i < gridsize; i++)
          {
            for (int j = 0; j < gridsize; j++)
            {
              cells[i][j] = a;
              if (a == 0) {
                a = 1;
              } else if (a == 1) {
                a = 0;
              }
            }
            if (a == 0) {
              a = 1;
            } else if (a == 1) {
              a = 0;
            }
          }
          kd = true;
        }
      }
      if (key == 'a')
      {
        if (!kd)
        {
          for (int i = 0; i < gridsize; i++)
          {
            for (int j = 0; j < gridsize; j++)
            {
              if (i%6 == 0)
              {
                cells[i][j] = 1;
              } else
              {
                cells[i][j] = 0;
              }
            }
          }
          kd = true;
        }
      }
    } else
    {
      kd = false;
    }
  } else
  {
    if (keyPressed)
    {
      if (key == 'w')
      {
        if (!kd)
        {
          kd = true;
          gamestart = !gamestart;
          for (int i = 0; i < gridsize; i++)
          {
            for (int j = 0; j < gridsize; j++)
            {
              cells[i][j] = 0;
            }
          }
        }
      }
    } else
    {
      kd = false;
    }
    ispeed -= 1/frameRate;
    if (ispeed <= 0)
    {
      ispeed += speed;
      iterate();
    }
  }

  for (int i = 0; i < gridsize; i++)
  {
    for (int j = 0; j < gridsize; j++)
    {
      switch(cells[i][j])
      {
      case 0:
        if (gamestart)
        {
          cc[i][j] = 0;
        }
        fill(0);
        rect(i*cellsize, j*cellsize, cellsize, cellsize);
        break;
      case 1:
        if (gamestart)
        {
          cc[i][j]+=25;
          fill(cc[i][j]);
          rect(i*cellsize, j*cellsize, cellsize, cellsize);
        } else
        {
          fill(255);
          rect(i*cellsize, j*cellsize, cellsize, cellsize);
        }

        break;
      }
    }
  }
}

void iterate()
{
  int[][] copy = new int [gridsize][gridsize];
  for (int x = 0; x < gridsize; x++)
  {
    for (int y = 0; y < gridsize; y++)
    {
      copy[x][y] = cells[x][y];
    }
  }

  for (int x = 0; x < gridsize; x++)
  {
    for (int y = 0; y < gridsize; y++)
    {
      int nbcount = 0;
      if (x > 0) {         
        if (copy[x-1][y] == 1) {
          nbcount++;
        }
      } //left
      if (x < gridsize-1) {
        if (copy[x+1][y] == 1) {
          nbcount++;
        }
      } //right
      if (y > 0) {         
        if (copy[x][y-1] == 1) {
          nbcount++;
        }
      } //up
      if (y < gridsize-1) {
        if (copy[x][y+1] == 1) {
          nbcount++;
        }
      } //down

      if (x > 0 && y > 0) {
        if (copy[x-1][y-1] == 1) {
          nbcount++;
        }
      } //topleft
      if (x < gridsize-1 && y > 0) {
        if (copy[x+1][y-1] == 1) {
          nbcount++;
        }
      }//top right
      if (x > 0 && y < gridsize-1) {
        if (copy[x-1][y+1] == 1) {
          nbcount++;
        }
      }//bottom left
      if (x < gridsize-1 && y < gridsize-1) {
        if (copy[x+1][y+1] == 1) {
          nbcount++;
        }
      }//bottom right

      switch(copy[x][y])
      {
      case 0:
        if (nbcount == 3) {
          cells[x][y] = 1;
        }
        break;

      case 1:
        if (nbcount < 2) {
          cells[x][y] = 0;
        }
        if (nbcount > 3) {
          cells[x][y] = 0;
        }
        break;
      }
    }
  }
}
