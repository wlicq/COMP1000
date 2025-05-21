public class Background {

  int[][] craterPos;
  int[] craterSize;

  Background() {
    floorPos = height - (height/8) - 50;
  }



  void updateBackground() {
    background(6, 32, 43);

    noStroke();
    fill(245, 238, 221);

    rect(0, height, width, -height/8);
    fill(7, 122, 125);
    rect(0, 0, width, height / 8);
    floorPos = height - (height/8) - 50;

    drawStars();

    updateRockets();


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
    for (int rayIndex = 0; rayIndex < (20 * size); rayIndex++) {
      float angle = TWO_PI / 5 * rayIndex;
      float x = this.xPos + cos(angle) * size;
      float y = this.yPos + sin(angle) * size;
      line(this.xPos, this.yPos, random(x-5, x+5), random(y-5, y+5));
    }
  }
}
