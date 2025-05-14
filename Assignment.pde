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

PFont titleFont;

int playerScore = 0;
int playerLives = 3;

void setup() {
  size(1000, 1000);
  titleFont = createFont("Arial",16,true);

  drawBackground();
  surface.setResizable(true);
  fill(0);

  charX = width / 2;
  charY = height / 2;
  
  floorPos = height - (height/5);
  
 

  character = new Character(charX, charY, floorPos, setJumpHeight);
  updateRockets();
  updateCookies();
}

void drawBackground() {
  background(223, 208, 184);
  updateRockets();

  noStroke();
  fill(6, 32, 43);
  rect(0, height, width, -height/8);
  fill(122, 226, 207);
  rect(0, 0, width, height / 8);
  floorPos = height - (height/8) - 50;

  updateCookies();
  stroke(200);
  textFont(titleFont, 32);
  textAlign(CENTER);
  text("ALIENS LOVE COOKIES", width / 2, (height / 8)-(height/16));
  


}

void drawStars(){
  
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
  drawBackground();

  character.xPos = charX;
  character.yPos = charY;

  character.update(moveLeft, moveRight, jump);

  charX = character.xPos;
  charY = character.yPos;

  character.floorPos = floorPos;
}


class Rocket {

  float xPos, yPos;
  float speed = 2;
  float rocketScale;
  float flameDensity = 10;

  Rocket(float x, float y) {
    this.xPos = x;
    this.yPos = y;
    this.rocketScale = random(0.5, 1.5);
    this.speed = random(1, 3);
  }
  void drawRocket() {
    fill(0, 0, 0);
    triangle(this.xPos, this.yPos, this.xPos - 20, this.yPos + 30, this.xPos + 20, this.yPos + 30);
    rect(this.xPos-20, this.yPos + 29, 40, 40 * this.rocketScale);
    fill(230, 230, 230);
    rect(this.xPos-5, this.yPos + 20, 5, 5);
    stroke(100);

    for (int i = 0; i < flameDensity; i++) {
      stroke(168, 121, 50);
      line(this.xPos, this.yPos + 40, this.xPos - 19 + random(-20, 20), this.yPos + 90 * this.rocketScale + random(-20, 20));
      line(this.xPos, this.yPos + 40, this.xPos + 19 + random(-20, 20), this.yPos + 90 * this.rocketScale + random(-20, 20));
    }
    stroke(0);


    this.yPos -= speed;
  }
}

class Cookie {
  float xPos, yPos;
  float speed = 2;
  float cookieScale;
  float bounceFactor = 0.7;

  boolean collected = false;

  Cookie(float x, float y) {
    this.xPos = x;
    this.yPos = y;
    this.cookieScale = random(1, 3);
    this.speed = random(1, 3);
  }
  void drawCookie() {
    textAlign(LEFT);
    text("Score: " + playerScore, 10, (height / 8)-(height/16));
    stroke(0);


    //Cookie shape
    fill(230, 165, 80);
    ellipse(this.xPos, this.yPos, 30 * cookieScale, 30 * cookieScale);
    
    //Cookie chips
    fill(0, 0, 0);
    circle(this.xPos - 8 * cookieScale, this.yPos - 5 * cookieScale, 3 * cookieScale);
    circle(this.xPos + 2 * cookieScale, this.yPos - 10 * cookieScale, 5 * cookieScale);
    circle(this.xPos + 10 * cookieScale, this.yPos + 3 * cookieScale, 2 * cookieScale);
    circle(this.xPos - 10 * cookieScale, this.yPos + 4 * cookieScale, 2 * cookieScale);

    float distance = distanceToCharacter(charX, charY);

    if(distance < (30*cookieScale)) collected = true;

    
  }
  
  float distanceToCharacter(float x, float y) {
    return dist(this.xPos, this.yPos, x, y);
  }
}