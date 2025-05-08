public class Character {
    float xPos, yPos, floorPos;
    float gravity = 1.85f;
    boolean isMoving = false;

    float maxSpeed = 2;
    float speed = 0;
    float acceleration = 0.3f;
    // boolean moveLeft, moveRight = false;

    String playerState = "idle";


    public Character(float x, float y, float floor) {
        this.xPos = x;
        this.yPos = y;
        this.floorPos = floor;
    }

    void update(boolean moveLeft, boolean moveRight, boolean jump) {
        this.yPos = applyGravity(this.yPos);

        if (moveLeft) playerState = "moveLeft";
        if (moveRight) playerState = "moveRight";
        if (jump) playerState = "jump";
        if (!moveLeft && !moveRight && !jump) playerState = "idle";
      
        
        switch(playerState){
            case "moveLeft":
                while (speed < maxSpeed) {
                    speed += acceleration;
                    this.xPos -= speed;
                }
                speed = 0;
                break;
            case "moveRight":
                while (speed < maxSpeed) {
                    speed += acceleration;
                    this.xPos += speed;
                    
                    fill(7, 122, 125);
                    rect(this.xPos - 5, this.yPos + 10, 10, 40);
                    ellipse(this.xPos, this.yPos, 30, 30);
                    rotate(180);
                }
                speed = 0;
                break;
            case "jump":  
                this.yPos -= 10;
                this.yPos = applyGravity(this.yPos);
                
                break;

            case "idle":
                fill(7, 122, 125);
                rect(this.xPos - 5, this.yPos + 10, 10, 40);
                ellipse(this.xPos, this.yPos, 30, 30);
                break;

            default:
                playerState = "idle";
                break;
        }



    }

    protected float applyGravity(float y) {
        if (y < floorPos) {
            y += gravity;
        } else {
            y = floorPos;
        }
        return y + gravity;
    }


 


    class Animation {
        public Animation() {
            

        }

    }


}


/*public class Animation extends Character {
    
    public Animation () {
       // super(arguments);
    }
    
    public void animate () {
        // Animation logic here
    }}*/
