/*
COMP1000 Assignment
Game Name: Aliens Love Cookies
Name: William Licquorice
Student ID: 47664762

Aim of Game: Dodge the rockets and collect the cookies to gain points
Game Description and Tips:
The alien must eat cookies but is being hunted by rockets, try to get as
many cookies as you can, note. game is scalable to screen size so to make
it easier to dodge rockets make the screen bigger. collisions also only 
happen with ther aliens head because he eats cookies with his mouth and
the makes it easier to dodge rockets when they spawn at the bottom of the screen


Controls:
- A: Move left
- D: Move right
- W: Jump (hold to jump higher)
*/



float floorPos, charY, charX;

float charSpeedX = 0;
float charSpeedY = 2;
float setJumpHeight = 200;
float bounceFactor = 0.7;

boolean moveLeft = false;
boolean moveRight = false;
boolean jump = false;
boolean canJump = false;
boolean gameOver = false;

Rocket[] rockets = new Rocket[5];
Cookie[] cookies = new Cookie[10];
Star[] stars = new Star[20];

Character character;
Background background;

PFont titleFont;

int playerScore = 0;
int playerLives = 3;

int currentScreenWidth, currentScreenHeight;


void setup() {
  size(1000, 1000);

  currentScreenHeight = height;
  currentScreenWidth = width;

  titleFont = createFont("Arial",16,true);
  background = new Background();
  background.updateBackground();
  surface.setResizable(true);
  fill(0);

  charX = width / 2;
  charY = height / 2;
  
  floorPos = height - (height/5);

  character = new Character(charX, charY, floorPos, setJumpHeight);
  
  updateRockets();
  updateCookies();
}

void drawStars() {
  if(currentScreenHeight != height || currentScreenWidth != width) {
    for (int starIndex = 0; starIndex < stars.length; starIndex++) {
      stars[starIndex] = null;
    }
    currentScreenHeight = height;
    currentScreenWidth = width;
  }
  for (int starIndex = 0; starIndex < stars.length; starIndex++) {
    if (stars[starIndex] == null) stars[starIndex] = new Star(random(0, width), random(height/8, height - (height / 8)));
    stars[starIndex].drawStar();
  }
}

void updateRockets() {
  for (int rocketIndex = 0; rocketIndex < rockets.length; rocketIndex++) {
    if (rockets[rocketIndex] == null) {
      rockets[rocketIndex] = new Rocket(random(0, width), height);
    }
    //If game is over resets the rockets
    if(dist(rockets[rocketIndex].xPos, rockets[rocketIndex].yPos, charX, charY) < 30){
      gameOver = true;
      for (int rocketResetIndex = 0; rocketResetIndex < rockets.length; rocketResetIndex++) {
        rockets[rocketResetIndex] = null;
        rockets[rocketResetIndex] = new Rocket(random(0, width), height);
      }
    }
    //If rocket is off the screen then reset it
    rockets[rocketIndex].drawRocket();
    if (rockets[rocketIndex].yPos <= 0) {
      rockets[rocketIndex] = null;
    }

  }
}

void updateCookies() {
  for (int cookieIndex = 0; cookieIndex < cookies.length; cookieIndex++) {
    if (cookies[cookieIndex] == null) cookies[cookieIndex] = new Cookie(random(0, width), random((height/8)+100, floorPos));

    cookies[cookieIndex].drawCookie();

    //If cookie collided with the character reset and add to score
    if (cookies[cookieIndex].collected) {
      cookies[cookieIndex] = null;
      playerScore++;
    }
  }
}

void keyPressed() {
  switch (key) {
  case 'a':
    moveLeft = true;
    break;
  case 'd':
    moveRight = true;
    break;
  case 'w':
    if (charY >= floorPos - 10) jump = true;
    println(charY, floorPos);
    break;
  case 'r':
    if(gameOver){
      gameOver = false;
      playerScore = 0;
    }
  }
}

void keyReleased() {
  switch (key) {
  case 'a':
    moveLeft = false;
    break;
  case 'd':
    moveRight = false;
    break;
  case 'w':
    jump = false;
    break;
  }
}


void draw() {
  if(!gameOver){
    background.updateBackground();
    character.xPos = charX;
    character.yPos = charY;

    character.update(moveLeft, moveRight, jump);

    charX = character.xPos;
    charY = character.yPos;

    character.floorPos = floorPos;
  }
  else GameOver();
}

void GameOver(){
  background(0);
  fill(255);
  textAlign(CENTER);
  textFont(titleFont, 32);
  text("Game Over", width / 2, height / 2);
  text("Score: " + playerScore, width / 2, height / 2 + 50);
  text("Press R to restart", width / 2, height / 2 + 100);
}

