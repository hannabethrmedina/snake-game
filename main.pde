/* Screen
0: Menu Screen
1: Game Screen
2: Pause Screen
3: Game-Over Screen
*/

int gameScreen = 0;
Snake s;
// change this to whatever the grid size actually is
int grid = 20;
boolean paused = false;


// Color Mode Variable 0-dark 1-light
int colorMode = 0;

// Sound Variable
boolean soundOn = true;
int count = 0;

// Controls Variable
boolean left = true;
boolean right = false;

// Button outline display
int c = -15;
int a = -15;
int d = -15;
int m = -15;

// replace this with food object
PVector food;

// change this with end condition methods
boolean gameOver = false;


// Update map size and speed based on level
int w;
int h;
int cx = 0;
int cy = 0;
int f = 0;

boolean easy = true;
boolean medium = false;
boolean hard = false;

// audio
import processing.sound.*;
SoundFile backgroundSound;
SoundFile startSound;
SoundFile eatFoodSound;
SoundFile gameOverSound;
SoundFile loadingSound;

// buttons
Button dark_b;
Button light_b;
Button on_b;
Button off_b;
Button easy_b;
Button medium_b;
Button hard_b;
Button left_b;
Button right_b;

PImage settings;


void setup() {
  size(800, 800);
  s = new Snake();
  frameRate(10+f);
  
  w = width;
  h = height;
  foodLocation();
  
  // audio
  backgroundSound = new SoundFile(this, "game.wav");
  backgroundSound.amp(0.25);
  
  loadingSound = new SoundFile(this, "loading.wav");
  loadingSound.amp(0.25);
  
  startSound = new SoundFile(this, "start.wav");
  startSound.amp(0.25);
  
  eatFoodSound = new SoundFile(this, "eat.wav");
  eatFoodSound.amp(0.35);
  
  gameOverSound = new SoundFile(this, "gameover.wav");
  gameOverSound.amp(0.35);
  
  // buttons
  dark_b = new Button(width/2 - 15,575,100,25,color(150),color(250));
  light_b = new Button(width/2 + 110,575,100,25,color(150),color(250));
  on_b = new Button(width/2 - 15, 625,100,25,color(150),color(250));
  off_b = new Button(width/2 + 110,625,100,25,color(150),color(250));
  easy_b = new Button(width/2 - 15, 675,100,25,color(150),color(250));
  medium_b = new Button(width/2 + 110, 675,100,25,color(150),color(250));
  hard_b = new Button(width/2 +240, 675,100,25,color(150),color(250));
  left_b = new Button(width/2 - 15, 725,100,25,color(150),color(250));
  right_b = new Button(width/2 + 110, 725,100,25,color(150),color(250));
  
  settings = loadImage("settings.png");
}

// change this when combining parts
void foodLocation() {
  int c = floor(h/grid); // calculate number of columns in grid
  int r = floor(w/grid); // calculate number of rows in grid
  food = new PVector(floor(random(s.body.size(),c)), floor(random(s.body.size(),r))); //place food at random stop
  food = food.mult(grid);
}

void draw(){
  if (gameScreen == 0){
    menuScreen();
  } else if (gameScreen == 1){
    gameplayScreen();
  } else if (gameScreen == 2){
    pauseScreen();
  } else if (gameScreen == 3){
    gameOverScreen();
  }
  
}

void menuScreen(){
  if (!loadingSound.isPlaying()&&soundOn){
    loadingSound.play();
  }
  if (!soundOn){
    loadingSound.stop();
  }
  
  if (colorMode == 0){
    background(0);
    fill(255);
  } else if (colorMode == 1){
    background(255);
    fill(0);
  }
  textAlign(CENTER,CENTER);
  image(settings, width/2 - 100, 485, 40, 40);
  textSize(30);
  text("Settings",width/2 + 15,501);
  
  
  // Title
  fill(0,255,0);
  textSize(80);
  text("Snake Game", width/2, 275);
  
  
  // Press to Begin
  fill(0,100,255);
  textSize(35);
  text("Press 'SPACEBAR' to begin", width/2,height/2);
  
  // Settings Label
  fill(255,0,0);
  textSize(25);
  textAlign(RIGHT,CENTER);
  text("Color Mode", width/2 - 100, 575);
  text("Sound", width/2 - 100, 625);
  text("Difficulty", width/2 - 100, 675);
  text("Controls", width/2 - 100, 725);
  
  // Settings buttons
  
  dark_b.update(mouseX, mouseY);
  dark_b.display();
  light_b.update(mouseX, mouseY);
  light_b.display();
  on_b.update(mouseX, mouseY);
  on_b.display();
  off_b.update(mouseX, mouseY);
  off_b.display();
  easy_b.update(mouseX, mouseY);
  easy_b.display();
  medium_b.update(mouseX, mouseY);
  medium_b.display();
  hard_b.update(mouseX,mouseY);
  hard_b.display();
  left_b.update(mouseX,mouseY);
  left_b.display();
  right_b.update(mouseX,mouseY);
  right_b.display();
  
   
  textAlign(CENTER,CENTER);
  textSize(22);
  fill(0);
  stroke(0);
  strokeWeight(1);
  text("DARK",width/2 - 15,572);
  text("LIGHT",width/2 + 110,572);
  
  text("ON", width/2 - 15, 622);
  text("OFF", width/2 + 110,622);
  
  text("EASY", width/2 - 15, 672);
  text("MEDIUM", width/2 + 110, 672);
  text("HARD", width/2 + 240, 672);
  
  text("'WASD'",width/2 - 15,722);
  text("ARROWS",width/2 + 110,722);
  
  // Chosen buttons
  noFill();
  stroke(0,255,0);
  strokeWeight(3);
  rect(width/2 + c,575,100,25);
  rect(width/2 + a,625,100,25);
  rect(width/2 + d,675,100,25);
  rect(width/2 + m,725,100,25);

  
  
  
}


void gameplayScreen() {
  if(!backgroundSound.isPlaying()&&soundOn){
    loadingSound.stop();
    if(!startSound.isPlaying()){
      backgroundSound.play();
    }
  }
  
  rectMode(CORNER);
  frameRate(10+f);
  background(255,0,0);
  if (colorMode == 0){
    fill(0);
  } else if (colorMode == 1){
    fill(255);
  }
  
  rect(cx,cy,w,h);
  //  Food
  if (s.eatFood(food.x, food.y)) {
    foodLocation();
  }
  
     //new/////////////////////////////////////////////////////////
   //if tongue is triggered - animation hierarchy
  if (s.tongueOut(food.x, food.y)) {
    //set initial size of tongue
    float x = 40;
    float y = 0;
    //get head of snake
    PVector head = s.body.get(s.body.size() - 1).copy();
    //animation hierarchy
    pushMatrix();
    fill(245, 113, 190);
    //make tongue stick out and grow in direction of snake movement and move with the snake head
    if (s.vx == -1 && s.vy == 0){
      translate(head.x-20, head.y+5);
      rotate(radians(180));
      //use r to increase length of tongue with each turn and while near food
      rect(0,y-10,x+s.r,y+10);
    }
    else if (s.vx == 0 && s.vy == 1){
      translate(head.x+5, head.y+40);
      rotate(radians(90));
      rect(0,y-10,x+s.r,y+10);
    }
    else if (s.vx == 0 && s.vy == -1){
      translate(head.x+15, head.y-20);
      rotate(radians(270));
      rect(0,y-10,x+s.r,y+10);
    }
    else{
      translate(head.x+40, head.y+15);
      rect(0,y-10,x+s.r,y+10);
    }
    popMatrix();
  }
  
  
  
  fill(0, 255, 0);
  //rectMode(CENTER);
  rect(food.x, food.y, grid, grid);


  //  Game
  if (!gameOver) {
    s.update();
    s.display();
  } else {
  }
}

void pauseScreen(){
  textSize(32);
  text("Press P to Resume", width/2, height-100); 
  fill(200);
}

void gameOverScreen(){
  if (soundOn){
    backgroundSound.stop();
    if (count == 0){
      gameOverSound.play();
      count++;
    }
  }
   
  background(0);
}

void mousePressed() {
   if (dark_b.isPressed()){
    colorMode = 0;
    c = -15;
  } if (light_b.isPressed()){
    colorMode = 1;
    c = 110;
  } if (on_b.isPressed()){
    soundOn = true;
    a = -15;
  } if (off_b.isPressed()){
    soundOn = false;
    a = 110;
  } if (easy_b.isPressed()){
    easy = true;
    medium = false;
    hard = false;
    d = -15;
  } if (medium_b.isPressed()){
    easy = false;
    medium = true;
    hard = false;
    d = 110;
  } if (hard_b.isPressed()){
    easy = false;
    medium = false;
    hard = true;
    d = 240;
  } if (left_b.isPressed()){
    left = true;
    right = false;
    m = -15;
  } if (right_b.isPressed()){
    right = true;
    left = false;
    m = 110;
  }
  
  
}


void keyPressed() {
  if (gameScreen == 0){
    if (key == ' '){
      gameScreen++;
      if (soundOn){
        startSound.play();
      }
    }
  }
  if (gameScreen == 1){ // make sure game is running
    if (right){
      if (keyCode == UP) {
        if ((!(s.vx == 0 && s.vy == 1)) || (s.body.size() == 1)){ // snake can't flip directions on itself unless body size is one
          s.vx = 0;
          s.vy = -1;
          s.r = 0;
        }
      } else if (keyCode == DOWN) {
        if ((!(s.vx == 0 && s.vy == -1))|| (s.body.size() == 1)){
          s.vx = 0;
          s.vy = 1;
          s.r = 0;
        }
      } else if (keyCode == LEFT) {
        if ((!(s.vx == 1 && s.vy == 0))|| (s.body.size() == 1)){
          s.vx = -1;
          s.vy = 0;
          s.r = 0;
        }
      } else if (keyCode == RIGHT) {
        if ((!(s.vx == -1 && s.vy == 0))|| (s.body.size() == 1)){
          s.vx = 1;
          s.vy = 0;
          s.r = 0;
        }
      } 
        else{   // make sure the snake is traveling in bounds at start of new game
          if (s.vx == -1) {
            s.vx = 1;
          }
          else if (s.vy == -1) {
            s.vy = 1;
      }
    }
  }
  if (left){
      if (key == 'w') {
        if ((!(s.vx == 0 && s.vy == 1)) || (s.body.size() == 1)){ // snake can't flip directions on itself unless body size is one
          s.vx = 0;
          s.vy = -1;
          s.r = 0;
        }
      } else if (key == 's') {
        if ((!(s.vx == 0 && s.vy == -1))|| (s.body.size() == 1)){
          s.vx = 0;
          s.vy = 1;
          s.r = 0;
        }
      } else if (key == 'a') {
        if ((!(s.vx == 1 && s.vy == 0))|| (s.body.size() == 1)){
          s.vx = -1;
          s.vy = 0;
          s.r = 0;
        }
      } else if (key == 'd') {
        if ((!(s.vx == -1 && s.vy == 0))|| (s.body.size() == 1)){
          s.vx = 1;
          s.vy = 0;
          s.r = 0;
        }
      } 
        else{   // make sure the snake is traveling in bounds at start of new game
          if (s.vx == -1) {
            s.vx = 1;
          }
          else if (s.vy == -1) {
            s.vy = 1;
      }
    }
  }
  }
  if (key == 'p'){
    paused = !paused;
    if (paused) {
      pauseScreen();
      noLoop();
    } else {
      loop();
    }
  }
}
