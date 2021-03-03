import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] residents;
private boolean[][] newResidents;
private int neighbors;
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private boolean running = true;
private int generation = 0;

public void setup () {
  size(450, 400);
  frameRate(6);
        Interactive.make( this );
        residents = new Life[20][20];
        newResidents = new boolean[20][20];
        for (int y = 0; y < 20; y++) {
            for (int x = 0; x < 20; x++) {
                residents[x][y] = new Life(x,y);
                /*if ((int)(random(0,2)) == 0) {
                    residents[x][y] = true;
                }
                else {
                    residents[x][y] = false;
                }*/
            }
        }
        copyFromButtonsToBuffer();
        background(255);
}

public void draw () {
  background(255);
        copyFromButtonsToBuffer();

        for (int y = 0; y < 20; y++) {
            for (int x = 0; x < 20; x++) {
                residents[x][y].draw();
            }
        }

        if(running) {
            for (int y = 0; y < 20; y++) {
                for (int x = 0; x < 20; x++) {
                    neighbors = countNeighbors(x, y, residents);
                    if ((neighbors < 3 && !residents[x][y].getLife()) ||
                            (neighbors < 2 && residents[x][y].getLife())) {
                        newResidents[x][y] = false;
                    } else if ((neighbors == 3 && !residents[x][y].getLife()) ||
                            (neighbors <= 3 && residents[x][y].getLife())) {
                        newResidents[x][y] = true;
                    } else {
                        newResidents[x][y] = false;
                    }
                }
            }
        }

        copyFromBufferToButtons();
        //residents = newResidents;

        textSize(32);
        text("Generation " + generation, 100, 438);

        if(running) {
            fill(0,255,0);
            rect(10,410,10,30);
            rect(30,410,10,30);
            generation++;
        }
        else {
            fill(0,255,0);
            beginShape();
            vertex(10,410);
            vertex(40,425);
            vertex(10,440);
            endShape(CLOSE);
            generation = 0;
        }
}

public void keyPressed() {
  //your code here
}

public void copyFromBufferToButtons() {
  for (int y = 0; y < 20; y++) {
            for (int x = 0; x < 20; x++) {
                residents[x][y].setLife(newResidents[x][y]);
            }
        }
}

public void copyFromButtonsToBuffer() {
  for (int y = 0; y < 20; y++) {
            for (int x = 0; x < 20; x++) {
                newResidents[x][y] = residents[x][y].getLife();
            }
        }
}

public boolean isValid(int row, int col) {
  boolean rowValid = false;
        boolean colValid = false;
        if (row >= 0 && row < 20) rowValid = true;
        if (col >= 0 && col < 20) colValid = true;
        return rowValid && colValid;
}

public int countNeighbors(int row, int col, Life[][] grid) {
  int trues = 0;
        if (!isValid(row, col)) return 0;
        if (isValid(row - 1, col) && grid[row - 1][col].getLife()) trues++;
        if (isValid(row + 1, col) && grid[row + 1][col].getLife()) trues++;
        if (isValid(row, col - 1) && grid[row][col - 1].getLife()) trues++;
        if (isValid(row, col + 1) && grid[row][col + 1].getLife()) trues++;
        if (isValid(row - 1, col - 1) && grid[row - 1][col - 1].getLife()) trues++;
        if (isValid(row + 1, col + 1) && grid[row + 1][col + 1].getLife()) trues++;
        if (isValid(row + 1, col - 1) && grid[row + 1][col - 1].getLife()) trues++;
        if (isValid(row - 1, col + 1) && grid[row - 1][col + 1].getLife()) trues++;
        return trues;
}

public void mousePressed () {
        if (isValid(mouseX / 20, mouseY / 20)) {
            residents[mouseX / 20][mouseY / 20].mousePressed();
        }
        else if (isValid(mouseX / 20, mouseY / 20)) {
            residents[mouseX / 20][mouseY / 20].mousePressed();
        }
        else if (running) {
            if(mouseX < 50 && mouseY > 400) {
                running = false;
            }
        }
        else {
            if(mouseX < 50 && mouseY > 400) {
                running = true;
            }
        }
    }

    public void mouseDragged () {
    }

public class Life {
  private int myRow, myCol;
        private float x, y, width, height;
        private boolean alive;

        public Life (int row, int col) {
            width = 400/NUM_COLS;
            height = 400/NUM_ROWS;
            myRow = row;
            myCol = col;
            y = myCol*width;
            x = myRow*height;
            alive = Math.random() < .5; // 50/50 chance cell will be alive
            //alive = false;
            Interactive.add( this ); // register it with the manager
        }

        // called by manager
        public void mousePressed () {
            alive = !alive; //turn cell on and off with mouse press
        }
        public void draw() {
            if (alive != true)
                fill(0);
            else
                fill( 150 );
            rect(x, y, width, height);
        }
        public boolean getLife() {
            //replace the code one line below with your code
            return alive;
        }
        public void setLife(boolean living) {
            alive = living;
        }
}
