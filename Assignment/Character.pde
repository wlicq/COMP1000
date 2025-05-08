public class Character {
    float xPos, yPos, floorPos;
    float gravity = 1.85f;

    public Character(float x, float y, float floor) {
        this.xPos = x;
        this.yPos = y;
        this.floorPos = floor;
    }

    void update() {
        this.yPos = applyGravity(this.yPos);

        fill(7, 122, 125);
        rect(this.xPos - 5, this.yPos + 10, 10, 40);
        ellipse(this.xPos, this.yPos, 30, 30);


    }


    protected float applyGravity(float y) {
        if (y < floorPos) {
            y += gravity;
        } else {
            y = floorPos;
        }
        return y + gravity;
    }
}

/*public class Animation extends Character {
    
    public Animation () {
       // super(arguments);
    }
    
    public void animate () {
        // Animation logic here
    }}*/
