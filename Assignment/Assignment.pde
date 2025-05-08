float floorPos, charY, charX;

float charSpeedX = 0;
float charSpeedY = 2;

float bounceFactor = 0.7; 

Character character;

void setup() {
    size(800, 600);
    drawBackground();
    surface.setResizable(true);
    fill(0);
    charX = width / 2;
    charY = height / 2;
    floorPos = height + height/8;

    character = new Character(charX, charY, floorPos);
}

void drawBackground() {
    background(223, 208, 184);
    noStroke();
    fill(6, 32, 43);
    rect(0, height, width, -height / 8);
    fill(122, 226, 207);
    rect(0, 0, width, height / 8);
    
}



void keyPressed() {
    switch (key) {
        case 'a':
            charX -= 5;
            break;
        case 'd':   
            charX += 5;
            break;
        case 'w':
            charY -= 5;
            break;
    }
}






void draw() {
    drawBackground();

    character.xPos = charX;
    character.yPos = charY;

    character.update();

    charX = character.xPos;
    charY = character.yPos;
}


