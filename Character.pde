public class Character {
  float xPos, yPos, floorPos;
  float gravity = 1.85f;
  float charScale = 1.5f;

  boolean isMoving = false;

  float maxSpeed = 1;
  float speed = 0;
  float acceleration = 0.1f;
  // boolean moveLeft, moveRight = false;

  float jumpHeight = 200;
  float jumpSpeed = 6.5f;

  String playerState = "idle";

  public Character(float x, float y, float floor, float setJumpHeight) {
    this.xPos = x;
    this.yPos = y;
    this.floorPos = floor;
    this.jumpHeight = setJumpHeight;
  }

  void update(boolean moveLeft, boolean moveRight, boolean jump) {
    if (!jump) this.yPos = applyGravity(this.yPos);
    if (jump) this.yPos = charJump(this.yPos);

    if (moveLeft) playerState = "moveLeft";
    if (moveRight) playerState = "moveRight";
    if (!moveLeft && !moveRight && !jump) playerState = "idle";

    float playerBoundary = 15 * charScale;

    switch(playerState) {
    case "moveLeft":
      speed = 0;
      while (speed < maxSpeed) {
        if (this.xPos < playerBoundary) this.xPos = playerBoundary;
        speed += acceleration;
        this.xPos -= speed;
      }
      displayPlayer();
      speed = 0;
      break;
    case "moveRight":
      speed = 0;
      while (speed < maxSpeed) {
        if (this.xPos > width-playerBoundary) this.xPos = width-playerBoundary;
        speed += acceleration;
        this.xPos += speed;
      }
      displayPlayer();
      speed = 0;
      break;

    case "idle":
      displayPlayer();
      break;

    default:
      playerState = "idle";
      break;
    }
  }
  protected void displayPlayer() {

    noStroke();

    fill(83, 125, 93); // Alien green color


    //Head
    ellipse(this.xPos, this.yPos, 30 * charScale, 35 * charScale);

    //Body
    ellipse(this.xPos, this.yPos + 30 * charScale, 20 * charScale, 30 * charScale);

    //Eyes
    fill(210, 208, 160);
    ellipse(this.xPos - 8 * charScale, this.yPos - 5 * charScale, 8 * charScale, 12 * charScale); // Left eye
    ellipse(this.xPos + 8 * charScale, this.yPos - 5 * charScale, 8 * charScale, 12 * charScale); // Right eye

    //Antenna
    stroke(115, 148, 107);
    strokeWeight(2 * charScale);
    line(this.xPos - 10 * charScale, this.yPos - 20 * charScale, this.xPos - 15 * charScale, this.yPos - 40 * charScale); // Left antenna
    line(this.xPos + 10 * charScale, this.yPos - 20 * charScale, this.xPos + 15 * charScale, this.yPos - 40 * charScale); // Right antenna
    circle(this.xPos - 15 * charScale, this.yPos - 40 * charScale, 5 * charScale); // Left antenna tip
    circle(this.xPos + 15 * charScale, this.yPos - 40 * charScale, 5 * charScale); // Right antenna tip

    //toes
    noStroke();
    fill(0, 0, 0);
    ellipse(this.xPos - 5 * charScale, this.yPos + 45 * charScale, 10 * charScale, 8 * charScale); // Left foot
    ellipse(this.xPos + 5 * charScale, this.yPos + 45 * charScale, 10 * charScale, 8 * charScale); // Right foot

    //mouth and teeth
    fill(0, 0, 0);
    arc(this.xPos, this.yPos + 10 * charScale, 20 * charScale, 10 * charScale, 0, PI); // Mouth
    fill(255, 255, 255);

    float toothX1Default = this.xPos-5*charScale;
    float toothX2Default = this.xPos-7*charScale;
    float toothX3Default = this.xPos-6*charScale;
    float toothY1Default = this.yPos + 10 * charScale;
    float toothY2Default = this.yPos + 15 * charScale;

    for (int i = 0; i<7; i++) triangle(toothX1Default+(3*i), toothY1Default, toothX2Default+(3*i), toothY1Default, toothX3Default+(3*i), toothY2Default); // Left tooth
  }

  protected float applyGravity(float y) {
    if (y +10< floorPos) {
      y += gravity;
    } else {
      y = floorPos;
    }
    return y + gravity;
  }
  protected float charJump(float y) {
    if (y > jumpHeight) {
      y -= jumpSpeed;
    } else {
      jump = false;
    }
    return y;
  }
}
