float floorPos, charY, charX;

float charSpeedX = 0;
float charSpeedY = 2;

float bounceFactor = 0.7;

Character character;

boolean moveLeft = false;
boolean moveRight = false;
boolean jump = false;
boolean canJump = false;

Rocket[] rockets = new Rocket[10];
Cookie[] cookies = new Cookie[10];




void setup() {
  size(800, 600);
  drawBackground();
  surface.setResizable(true);
  fill(0);
  charX = width / 2;
  charY = height / 2;
  floorPos = height - (height/5);
  character = new Character(charX, charY, floorPos);
  updateRockets();
}

void drawBackground() {
  background(223, 208, 184);
  updateRockets();
  updateCookies();
  noStroke();
  fill(6, 32, 43);
  rect(0, height, width, -height/8);
  fill(122, 226, 207);
  rect(0, 0, width, height / 8);
  floorPos = height - (height/8) - 50;
}

void updateRockets() {
  for (int i = 0; i < rockets.length; i++) {
    if (rockets[i] == null) {
      rockets[i] = new Rocket(random(0, width), height);
      println("Rocket created at: " + rockets[i].xPos);
    }
    rockets[i].drawRocket();
    if (rockets[i].yPos <= 0) {
      rockets[i] = null;
      println("Rocket removed");
    }
  }
  //    println(rockets[0].yPos);
}
void updateCookies() {
  for (int i = 0; i < cookies.length; i++) {
    if (cookies[i] == null) {
      cookies[i] = new Cookie(random(0, width), random((-height/8)+50, floorPos));
      println("Cookie created at: " + cookies[i].xPos);
    }
    cookies[i].drawCookie();
    if (cookies[i].yPos <= 0) {
      cookies[i] = null;
      println("Cookie removed");
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

  Cookie(float x, float y) {
    this.xPos = x;
    this.yPos = y;
    this.cookieScale = random(0.5, 1.5);
    this.speed = random(1, 3);
  }
  void drawCookie() {
    fill(0, 0, 0);
    ellipse(this.xPos, this.yPos, 20 * this.cookieScale, 20 * this.cookieScale);
    fill(255, 255, 255);
    ellipse(this.xPos - 5, this.yPos - 5, 5 * this.cookieScale, 5 * this.cookieScale);
    ellipse(this.xPos + 5, this.yPos - 5, 5 * this.cookieScale, 5 * this.cookieScale);
    stroke(100);

    for (int i = 0; i < bounceFactor; i++) {
      stroke(168, 121, 50);
      line(this.xPos - random(-20, 20), this.yPos + random(-20, 20), this.xPos - random(-20, 20), this.yPos + random(-20, 20));
      line(this.xPos + random(-20, 20), this.yPos + random(-20, 20), this.xPos + random(-20, 20), this.yPos + random(-20, 20));
    }
    stroke(0);
  }
}
