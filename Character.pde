public class Character {
  float xPos, yPos, floorPos;
  float gravity = 1.85f;
  boolean isMoving = false;

  float maxSpeed = 1;
  float speed = 0;
  float acceleration = 0.1f;
  // boolean moveLeft, moveRight = false;

  float jumpHeight = 200;
  float jumpSpeed = 6.5f;
 

  String playerState = "idle";


  public Character(float x, float y, float floor) {
    this.xPos = x;
    this.yPos = y;
    this.floorPos = floor;
  }

  void update(boolean moveLeft, boolean moveRight, boolean jump) {
    if(!jump) this.yPos = applyGravity(this.yPos);
    if (jump) this.yPos = charJump(this.yPos);

    if (moveLeft) playerState = "moveLeft";
    if (moveRight) playerState = "moveRight";   
    if (!moveLeft && !moveRight && !jump) playerState = "idle";
    

    switch(playerState) {
    case "moveLeft":
      while (speed < maxSpeed) {
        speed += acceleration;
        this.xPos -= speed;
      }
      displayPlayer();
      speed = 0;
      break;
    case "moveRight":
      while (speed < maxSpeed) {
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

    fill(7, 122, 125);
    rect(this.xPos - 10, this.yPos + 10, 20, 30);
    ellipse(this.xPos, this.yPos, 30, 30);
    //rect(this.xPos-5, this.yPos +10, 50, 50);
    fill(0, 0, 0);
    //eyes
    ellipse(this.xPos - 5, this.yPos - 5, 5, 5);
    ellipse(this.xPos + 5, this.yPos - 5, 5, 5);
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
       if(y > jumpHeight) {
         y -= jumpSpeed;
       } else{
        jump = false;
       }
       return y;
    }
}