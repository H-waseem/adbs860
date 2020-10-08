boolean isTargetDown = true;
boolean assistGrid = false; //assistGrid True = Assist grid, 
boolean assistAim =  false; //assistAim True = larger targeting, 
boolean mode = false; //Mode false = Quickdraw Mode true = Blitz Mode
boolean help = false; //Help text
boolean helpMode = false; //Help text for modes
int targetX = int(random(0, 25))*40 + 20;
int targetY = int(random(2, 20))*40 + 20;
int points = 0;
int maxPoints = 5;
String modeText;

Timer sw;

void setup()
{
  size(1000, 800);
  noStroke();
  fill(180, 50, 50, 100);
  sw = new Timer();
}

void draw()
{
  background(255);
  // Menu code below___________________________________________
  if (help == false && helpMode == false) {

    textSize(30);
    fill(0);
    text("Press 'h' for help", width/2 -120, 30);
    text("Press 'H' for gamemode help", width/2 - 200, 70);
  }

  if (mode == false) {
    textSize(20);
    fill(150, 150, 0);
    modeText = "Blitz";
  }
  if (mode == true) {
    textSize(20);
    fill(150);
    modeText = "Quickdraw";
  }
  text(modeText, 880, 20);
  if (help == true && helpMode == false) {
    fill(0, 100, 200);
    textSize(17);
    text("Press 'a' for assisted aim", width/2 + 15, 17);
    text("Press 'g' for assistance grid", width/2 + 15, 47);
    text("Press 'm' for mode change", width/2 + 15, 77);
    textSize(30);
    text("Press Enter", 300, 30);
    text("to start", 320, 70);
  }
  if (help == false && helpMode == true) {
    textSize(20);
    fill(200, 0, 0);
    text("Blitz: Shoot 5 targets as fast as possible", width/2 - 200, 20);
    text("Quickdraw: Shoot 1 target as fast as possible", width/2 - 200, 60);
  }
  textSize(30);
  fill(0, 0, 0);
  text("Milliseconds:", 10, 40);
  text(sw.getElapsedTime(), 210, 40);
  textSize(20);
  text("Current mode:", 730, 20);
  text("Targets hit:", 830, 60);
  text(points, 950, 60);


  //Check what mode to run--------------------------------------------------

  if (mode == false) { //False is blitz mode
    maxPoints = 5;
    game();
    crossHair();
  }
  if (mode == true) { //True is quickdraw
    maxPoints = 1;
    game();
    crossHair();
  }
}

// Next co ordinates of new target
int getNextX() {
  int targetX = int(random(0, 25))*40 + 20;
  return targetX;
}

int getNextY() {
  int targetY = int(random(2, 20))*40 + 20;
  return targetY;
}

void game() {

  for (int row=0; row<20; row = row+1) //Row counter
  {
    for (int col=0; col<25; col = col+1) //Column counter
    {
      //Assited targeting
      if (assistAim == true) {
        if (row == mouseY/40 && row>=2) { //Check what row mouse is in
          fill(0, 0, 0);
          ellipse(20 + col*40, 20 + row*40, 30, 30);
        }
        if (col == mouseX/40) { //Check what column mouse is in
          fill(0, 0, 0);
          ellipse(20 + col*40, 100 + row*40, 30, 30);
        }
      }

      //Assist Grid
      if (assistGrid == true) {
        fill(0, 0, 0, 15);
        ellipse(20 + col*40, 100 + row*40, 30, 30);
      }
    }
  }
    if (!isTargetDown) {
    target(targetX, targetY);
  }
}

//============================================================

void mouseClicked() {
  if (dist(mouseX, mouseY, targetX, targetY) <= 15) {
    println("TARGET HIT!");
    isTargetDown = true;
    points = points + 1;
    targetX = getNextX();
    targetY = getNextY();
    isTargetDown = false;
    if (points == maxPoints) {
      sw.stop();
      isTargetDown = true;
    }
  } else if (isTargetDown == false){
    println("MISS!");
  }
} 

void keyPressed() {
  if (key == 'g') {
    assistGrid = !assistGrid;
    println("Assist grid toggled");
  }  
  if (key == 'a') {
    assistAim = !assistAim;
    println("Assist aim toggled");
  }
  if (key == 'm') {
    mode = !mode;
    println("Mode toggled");
  }
  if (key == 'h') {
    help = !help;
    println("Help menu toggled");
  }
  if (key == 'H') {
    helpMode = !helpMode;
    println("Mode help menu toggled");
  }
  if (key == ENTER) { // To start mode
    sw.start(); //start stop watch
    points = 0;
    isTargetDown = false;
  }
}

void crossHair() {
  fill(255, 0, 0); //Crosshair code
  ellipse(mouseX, mouseY, 1, 15);
  ellipse(mouseX, mouseY, 15, 1);
}

void target(float x, float y) {
  fill(255, 167, 60);
  ellipse(x, y, 30, 30);

  fill(0, 0, 100);
  ellipse(x, y, 20, 20);

  fill(255);
  ellipse(x, y, 12, 12);

  fill(150, 0, 0);
  ellipse(x, y, 4, 4);
}
