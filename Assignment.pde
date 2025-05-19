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
  //drawBackground();
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
  for (int i = 0; i < stars.length; i++) {
    if (stars[i] == null) stars[i] = new Star(random(0, width), random(height/8, height - (height / 8)));
    stars[i].drawStar();
  }
}


void updateRockets() {
  for (int i = 0; i < rockets.length; i++) {
    if (rockets[i] == null) {
      rockets[i] = new Rocket(random(0, width), height);
    }
    rockets[i].drawRocket();
    if (rockets[i].yPos <= 0) {
      rockets[i] = null;
    }
  }
  //    println(rockets[0].yPos);
}
void updateCookies() {
  for (int i = 0; i < cookies.length; i++) {
    if (cookies[i] == null) cookies[i] = new Cookie(random(0, width), random((height/8)+100, floorPos));
    
    cookies[i].drawCookie();
    if (cookies[i].collected) {
      cookies[i] = null;
      println("Cookie collected");
      playerScore++;
    }
  }
  //    println(cookies[0].yPos);
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


