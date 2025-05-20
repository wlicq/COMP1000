public class Background {

    int[][] craterPos;
    int[] craterSize;

    Background() {
        this.craterPos = new int[(int)random(2, 3)][2];
        this.craterSize = new int[craterPos.length];
        floorPos = height - (height/8) - 50;
        for (int a = 0; a < craterPos.length; a++){
            int aX = (int)random(0, width);
            int aY = (int)random(floorPos, height);
            
            if(aY > floorPos+craterSize[a])  aY = aY + (craterSize[a]*100);
            if(a > 0){
                while(dist(aX, aY, craterPos[a-1][0], craterPos[a-1][1]) < 100){
                    aX = (int)random(0, width);
                    aY = (int)random(floorPos, height);
                }
            }

            this.craterPos[a][0] = aX;
            this.craterPos[a][1] = aY;
            this.craterSize[a] = (int)random(30, 50);
        }
    }

    void drawCraters(){
        for (int a = 0; a < craterPos.length; a++){
            fill(0, 0, 0);
            //ellipse(craterPos[a][0], craterPos[a][1], craterSize[a], craterSize[a]);
            //draw hexagon
            beginShape();
            for (int i = 0; i < 10; i++) {
                float angle = TWO_PI / 10 * i;
                float x = craterPos[a][0] + cos(angle) * craterSize[a];
                float y = craterPos[a][1] + sin(angle) * craterSize[a];
                vertex(x, y);
            }
            endShape();
            //draw crater shadow
           
            //fill(230, 230, 230);
           // ellipse(craterPos[a][0] + random(-5, 5), craterPos[a][1] + random(-5, 5), craterSize[a] - random(2, 10), craterSize[a] - random(2, 10));
        }
    }

    void updateBackground(){
        background(6, 32, 43);
        updateRockets();

        noStroke();
        fill(245, 238, 221);

        rect(0, height, width, -height/8);
        fill(7, 122, 125);
        rect(0, 0, width, height / 8);
        floorPos = height - (height/8) - 50;

        drawCraters();
        drawStars();

        updateCookies();
        stroke(200);
        textFont(titleFont, 32);
        textAlign(CENTER);
        text("ALIENS LOVE COOKIES", width / 2, (height / 8)-(height/16));   
    }
}



public class Star {
    float xPos, yPos;
    float size;

    Star(float x, float y) {
        this.xPos = x;
        this.yPos = y;
        this.size = random(1, 3);
    }

    void drawStar() {
        stroke(230, 212, 80);
        for(int i = 0; i<(20*size); i++){
            float angle = TWO_PI / 5 * i;
            float x = this.xPos + cos(angle) * size;
            float y = this.yPos + sin(angle) * size;
            line(this.xPos, this.yPos, random(x-5, x+5), random(y-5, y+5));
        }
    }
}