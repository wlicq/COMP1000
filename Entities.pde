public class Cookie {
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
  
  protected float distanceToCharacter(float x, float y) {
    return dist(this.xPos, this.yPos, x, y);
  }
}


public class Rocket {

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