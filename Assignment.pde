/*
COMP1000 Assignment
Game Name: Aliens Love Cookies
Name: Will Licquorice
Student ID: 47664762

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

Character character;

boolean moveLeft = false;
boolean moveRight = false;
boolean jump = false;
boolean canJump = false;


Rocket[] rockets = new Rocket[10];
Cookie[] cookies = new Cookie[10];
Star[] stars = new Star[20];

Background background;

PFont titleFont;

int playerScore = 0;
int playerLives = 3;

void setup() {
  size(1000, 1000);
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
  for (int starNum = 0; starNum < stars.length; starNum++) {
    if (stars[starNum] == null) stars[starNum] = new Star(random(0, width), random(height/8, height - (height / 8)));
    stars[starNum].drawStar();
  }
}

void updateRockets() {
  for (int rktNum = 0; rktNum < rockets.length; rktNum++) {
    if (rockets[rktNum] == null) {
      rockets[rktNum] = new Rocket(random(0, width), height);
    }
    rockets[rktNum].drawRocket();
    if (rockets[rktNum].yPos <= 0) {
      rockets[rktNum] = null;
    }
  }
}

void updateCookies() {
  for (int cookieNum = 0; cookieNum < cookies.length; cookieNum++) {
    if (cookies[cookieNum] == null) cookies[cookieNum] = new Cookie(random(0, width), random((height/8)+100, floorPos));
    
    cookies[cookieNum].drawCookie();
    if (cookies[cookieNum].collected) {
      cookies[cookieNum] = null;
      println("Cookie collected");
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
  background.updateBackground();
  character.xPos = charX;
  character.yPos = charY;

  character.update(moveLeft, moveRight, jump);

  charX = character.xPos;
  charY = character.yPos;

  character.floorPos = floorPos;
}


