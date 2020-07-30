class Snake {
  float x;
  float y;
  float vx;
  float vy;
  float r;
  boolean gameOver;
  int highscore=0;
  int secondscore=0;
  int thirdscore=0;
  int timesplayed=1;

  ArrayList<PVector> body;

  Snake() {
    x = 0;
    y = 0;
    vx = 0;
    vy = 1;
    body = new ArrayList<PVector>();
    gameOver = false;
    // head
    body.add(new PVector(x, y));
  }

  void update() {
    // get copy of head
    if (!gameOver) {
      PVector head = body.get(body.size() - 1).copy();
      // remove end of tail
      body.remove(0);
      // move head 
      head.x = head.x + vx*grid;
      head.y = head.y + vy*grid;
      // add new head location to body
      body.add(head);
      outOfBounds();
    }
    if (gameOver) {   //restarts the game
      scoreboard();
      if (keyPressed) {
        if (keyCode == SHIFT) {
          body = new ArrayList<PVector>();
          body.add(new PVector(x, y));
          gameOver=false;
          cx=0;
          cy=0;
          w=width;
          h=height;
          f = 0;
          timesplayed++;
        }
      }
    }
  }

  void display() {
    textAlign(CENTER);
    textSize(15);
    text("Score:"+body.size(), 30+cx, 30+cy);
    if (gameOver) {
      background(0);
      textSize(50); //displays game over message
      text("Final Score:"+body.size(), width/2, height/2-100);
      text("High Score:"+ highscore, width/2, height/2+200);
      text("Second Highest Score:" + secondscore, width/2, height/2+250);// new
      text("Third Highest Score:" + thirdscore, width/2, height/2+300);// new
      textSize(30); //displays game over message
      text("Game Over", width/2, height/2);
      text("Press Shift to Restart", width/2, height/2+40);
      foodLocation();
    }
    strokeWeight(1);
    if (colorMode == 0){
      fill(255);
      stroke(0);
    } else if (colorMode == 1){
      stroke(255);
      fill(0);
    }
    // rect for each PVector locations
    for (PVector b : body) {
      rect(b.x, b.y, grid, grid);
    }
    
  }


  // makes snake longer and moves food to new location
  boolean eatFood(float f_x, float f_y) {
    // get head 
    PVector head = body.get(body.size() - 1).copy();
    float distance = dist(head.x, head.y, f_x, f_y);
    if (distance < 1) {
      body.add(body.get(body.size() - 1).copy());  
      
      
      // Updating map and speed based on level
      if (easy){
        cx+=5;
        cy+=5;
        w-=10;
        h-=10;
        f+=1;  
      } if (medium){
        cx+=10;
        cy+=10;
        w-=20;
        h-=20;
        f+=1.5;
      }  if (hard) {
        cx+=15;
        cy+=15;
        w-=30;
        h-=30;
        f+=2;
      }
      
      if (soundOn){
        eatFoodSound.play();
      }
      
      
      return true;
    } 
    else {
      return false;
    }
  }
  //new/////////////////////////////////////////////////////////
  //trigger the snake's tongue to reach for food
  boolean tongueOut(float f_x, float f_y) {
    // get head 
    PVector head = body.get(body.size() - 1).copy();
    float distance = dist(head.x, head.y, f_x, f_y);
    //float x = 0;
    //float y = 0;
    if (distance < 200) {
      //make the tongue increase in size as if it's reaching for the food 
      r+=3;
      return true;
      
    }
    else{
      //reset tongue when snake isnt near the food
      r=0;
      return false;}
    
  }
   
   //checks if snake is out of the screen of runs into itself
  
  void outOfBounds(){
    PVector head = body.get(body.size() - 1); // take the head of the snake
    if (head.x < cx || head.x > w+cx-grid || head.y < cy || head.y > h+cy-grid){ //check if out of screen
      gameOver=true;
    }
    //check if it is running into itself (only on another part, head can't flip directions)
    for (int i = 0; i < body.size()-1; i++){ //check every other vector in body of snake
      PVector b = body.get(i);
      if (head.x == b.x && head.y == b.y){ // if head is at another part, game over
        gameOver = true;
      }
  
    }
  }
  void scoreboard() { //new//makes logic for scoreboard

    if (body.size()>highscore && timesplayed==1) {
      highscore=body.size();
    }
    if (body.size()<highscore && body.size()>secondscore && highscore!=1 && timesplayed==2 ) {
      secondscore=body.size();
    }
    if (body.size()>highscore && timesplayed==2) {
      secondscore=highscore;
      highscore=body.size();
    }
    if (body.size()<highscore && body.size()<secondscore && highscore!=1 && secondscore!=0 && timesplayed>=3 ) {
      thirdscore=body.size();
    }
    if (body.size()>highscore && timesplayed>=3) {
      thirdscore=secondscore;
      secondscore=highscore;
      highscore=body.size();
    }
    if (body.size()<highscore && body.size()>secondscore && timesplayed>3) {
      thirdscore=secondscore;
      secondscore=body.size();
    }
  }
 
}
